Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6701762834
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGZBhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZBhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:37:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116DD2699;
        Tue, 25 Jul 2023 18:37:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so6805552276.0;
        Tue, 25 Jul 2023 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690335433; x=1690940233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctBmwIhFDO7oOOVupRjLQ8ZULEm8JNOonoq4e52LoDI=;
        b=Dw4yR41lfSYuC22egW43grWyD0cJ2WgfwwRIjisuqV63vtSuoCJVAGMbvbbmvaq3nm
         9tfS67jccufyOxUVniU6s0Z5RpMWzR/k3+XOUHrQyYhTuFi1oBxd6iisPTuXqB3S8gy3
         EFROGOnuqu41RokFxG8fhEAuM+RcTzogZq0UrEjnNQ9eifwbwLZcd+OBtZk6U634AF2I
         8ZMaA1WBQUqKaosHmRo/oqCa68e5Tje+6VCNi/oj5w1Xeu1WrMOxtW92utjkcCOSkmeS
         B7rjHjcrSORq/N6mlZJn3fk+4TW51Oi9Nb1TeRKmKB7Nx+3auoKl5w2uf8b8A+FYSUIi
         /yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690335433; x=1690940233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctBmwIhFDO7oOOVupRjLQ8ZULEm8JNOonoq4e52LoDI=;
        b=jlDtdWGwKJLxfilybXB/gTahbcv5y84aDiZOA22jYh4OZlUWyXrhXTaY1CDy2hE5Yp
         2GlsFEGGyWeaXojK4ggyqubpAseapJq/5BBanwmPuV9gQsCZZthDK49UnQc38Nv/pFzs
         grmEZouLdwlIr4Ss86sWMGUogCOgsQGVN4R8BVs6JcHrsXHXgUKiFQjR5s9GiWNP8qQq
         NgIBDiXf6cGEaL94ag7x19yJiACyTpEnQCSMyUszvPMrMFSPsbPme9aL4E8GGQPFERa6
         G0lFXB9kZ/CqDPd3tG/lOvBXlPe7v394jB/Y9eRxxkq6ZqxVinMBlhOf2fiF3sH8ZsXP
         6kMw==
X-Gm-Message-State: ABy/qLZV0Yn12YMjjl9YoX1FJCy25KK1rl8b47GsUkOsgnjRiTa3rcfN
        UKYYq+3+zCmOxh/T7Xl71bcJLMbdUs/rX0o89h8=
X-Google-Smtp-Source: APBJJlGEEwXAFa7botQfYFa+QDAKwJF5MaUljEW3h4igXPuviSgBZgsapv7STS/8d08cjiTMXbUag/ckOOpFNoOy7qY=
X-Received: by 2002:a81:4ec3:0:b0:583:d32f:ed61 with SMTP id
 c186-20020a814ec3000000b00583d32fed61mr763448ywb.27.1690335433134; Tue, 25
 Jul 2023 18:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230721084039.9728-1-18500469033@163.com> <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com> <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com> <2023072546-denture-half-5ceb@gregkh>
In-Reply-To: <2023072546-denture-half-5ceb@gregkh>
From:   Xiaofan Chen <xiaofanc@gmail.com>
Date:   Wed, 26 Jul 2023 09:37:01 +0800
Message-ID: <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, Dingyan Li <18500469033@163.com>,
        stern@rowland.harvard.edu, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jul 24, 2023 at 11:47:49AM +0200, Oliver Neukum wrote:
> > On 21.07.23 16:51, Greg KH wrote:
>> ...
> > > > 4. I found in libusb, there are two ways to get speed value for a d=
evice.
> > > >      One way is via sysfs, which has supported 20Gbps now. Another =
way is
> > > >      to use ioctl USBDEVFS_GET_SPEED. This is when I found this ioc=
tl can only
> > > >      return USB_SPEED_SUPER_PLUS at most, it cannot determine curre=
nt ssp rate
> > > >      further, no matter Gen1x2(10Gbps), Gen2x1(10Gbps) or Gen2x2(20=
Gbps). So I
> > > >      thought maybe it's good to provide a similar way like ioctl US=
BDEVFS_GET_SPEED
> > > >      in order to get ssp rates.
> > >
> > > If libusb doesn't need this ioctl, who would use it?  We only add api=
s
> > > that are actually going to be used.
> > >
> > > So if libusb doesn't use it, we need a real-world user for us to be a=
ble
> > > to add this.
> >
> > I am sorry, but that looks pretty much like a question of API design to=
 me.
> > To what extent is libusb supposed to be functional without sysfs? There=
 is
> > no technical answer to this. It is a question of design goals.
> >
> > If we follow the precedent of c01b244ad848a
> > ("USB: add usbfs ioctl to retrieve the connection speed")
> > then we should apply an updated version of Dingyan Li's patch, preferab=
ly
> > coupled with a patch for libusb or we go and deprecate some ioctls.
>
> We can never "deprecate" ioctls, sorry.
>
> So unless there is some actual need from userspace tools like libusb (or
> anything else?) that requires this new ioctl, let's not add it otherwise
> we are signing ourselves up to support it for forever.

Interestingly there is PR in libusb now, which uses sysfs for 20Gbps.
Maybe this new usbfs IOCTL is indeed good to have if we can not extend
the existing IOCTL USBDEVFS_GET_SPEED (but why not?).
https://github.com/libusb/libusb/pull/1298


--=20
Xiaofan
