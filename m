Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233B97634A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjGZLUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGZLUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:20:39 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F8497;
        Wed, 26 Jul 2023 04:20:38 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57a6df91b1eso80172237b3.1;
        Wed, 26 Jul 2023 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690370438; x=1690975238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsAEkrwSsyixiucawioU2bMgKGgn2qVLnt0XW8Bonqs=;
        b=go0Y/ietCm9U8JTrEhiSLCt6rwA/3zBE6/Kvsi0eVKMH3CgZTSACxqrKqvn6WruQv3
         s4R9Zl8Fofj4hJnPDC6OBEbUhaIvjfxAYrjQZfFPMtX3xbecO8EcLj6gqMJ+YSZdQ+hS
         yhZmYrK09lZBpLA6eadN71VhbMqhYYd8KOKuMJNcGfQ+9gHxrQIS+pwl6dG6DmpbIbWI
         k55swCKCy1MzCkgNGoWG2o573Kmy3USC04LLpCN5ae8qTEy1Y+AZhmGSbVIVUylYl8c5
         3ODcUEyQhoXTqkClHJ+f12xl8ID1iNMKrm0OtC7tFeliEp//Ukt0RBSpr1fjGl5du8io
         cO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690370438; x=1690975238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsAEkrwSsyixiucawioU2bMgKGgn2qVLnt0XW8Bonqs=;
        b=TQv8PrReibcMfo1C+a9wTnm+uMLwH1JfYk9EzNFJgi413HpTL0LJ8u6m/nozHe4WrC
         hl0OwShUDAQUoh1iW8SXJmEOMPgtVBIYKHbdWO3nVUmvBlY+twbz0+0HnRI/ZUFFZF/U
         /NGPSFZKP6x9omWLm4R74oyXAbGKBThW5SeZq5375rzkfyASA/ir4VDC5snQFwkRW8Li
         yoFzKIWfUGNSfvdux1eiYv0CE4N6y44aXmVWWlgELOLEnNI/UVYT3UEqDZ7xGHrq+98z
         fik3MLopSSSjcnuxPWDRehXoqbcRZQvuyAEMGltPJQCUEt0O5CqEAc4HrGJM6esB1CRC
         dPFA==
X-Gm-Message-State: ABy/qLY0R78XrHtQByDXt5qo/+IYkvYFnnB40ZqP5uOR3N26jOUoggkS
        xxvFOptckHANBDGT2AOsJbOPeRCTRjK10bS2uoQ=
X-Google-Smtp-Source: APBJJlEvQUG5gVitWrDCrwkW9CiW8jzQCtEPY9H5aZ8B+OH9kG23rLlGfSGfsE14kDaI2QofW7mbLBV5+Z8HYH2rgIw=
X-Received: by 2002:a81:9c11:0:b0:55a:6430:e8fb with SMTP id
 m17-20020a819c11000000b0055a6430e8fbmr2112293ywa.8.1690370437860; Wed, 26 Jul
 2023 04:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230721084039.9728-1-18500469033@163.com> <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com> <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com> <2023072546-denture-half-5ceb@gregkh>
 <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com> <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
In-Reply-To: <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
From:   Xiaofan Chen <xiaofanc@gmail.com>
Date:   Wed, 26 Jul 2023 11:20:24 +0800
Message-ID: <CAGjSPUDtn-YMqmNrmku+hkyXCKys4XRue4wdzQwr+yGxe2cJSQ@mail.gmail.com>
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
To:     Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tormod Volden <lists.tormod@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dingyan Li <18500469033@163.com>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 5:38=E2=80=AFPM Oliver Neukum <oneukum@suse.com> wr=
ote:
>
> On 26.07.23 03:37, Xiaofan Chen wrote:
> > On Tue, Jul 25, 2023 at 10:23=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
>
> Hi,
>
> >> So unless there is some actual need from userspace tools like libusb (=
or
> >> anything else?) that requires this new ioctl, let's not add it otherwi=
se
> >> we are signing ourselves up to support it for forever.
> >
> > Interestingly there is PR in libusb now, which uses sysfs for 20Gbps.
>
> True. Now would you write a patch for libusb?
> This looks to be turning into a chicken and egg problem.
>
> > Maybe this new usbfs IOCTL is indeed good to have if we can not extend
>
> Looking at the code of libusb you can see that libusb has two modes
> of operation. Either it finds sysfs, then it uses it, if not it
> goes for the ioctl.
>
> Now, how well shall it work without sysfs? That is a design decision
> and we should not be having this discussion again and again.
>
> BTW, that is not aimed at anybody personally, we are just trying to
> avoid a basic decision and it will come back.
>
> > the existing IOCTL USBDEVFS_GET_SPEED (but why not?).
>
> It does not include the lane count.
> And sort of fudging this into speed is a bad idea in the long
> run because we are likely to have collisions in the future.
>
> We have a basic issue here. Do we require libusb to use sysfs or not?

Adding Hans de Goede and Tormod Volder (libusb admins) here in the discussi=
ons
as I am more into the testing and support side of libusb and not a
real developer.

libusb does work with or without sysfs and there are multiple commits relat=
ed
to sysfs vs usbfs.

An example commit from Hans in Sept 202 which is related to this discussion=
.
https://github.com/libusb/libusb/commit/f6068e83c4f5e5fba16b23b6a87f1f6d7ab=
7200a
++++++++++++++++
linux: Fix libusb_get_device_speed() not working on wrapped devices

We don't have a sysfs_dir for wrapped devices, so we cannot read the speed
from sysfs.

The Linux kernel has supported a new ioctl to get the speed directly from
the fd for a while now, use that when we don't have sysfs access.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1871818
Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
+++++++++++++++++

To Hans and Tormod:
Discussion thread for reference:
https://lore.kernel.org/linux-usb/da536c80-7398-dae0-a22c-16e521be697a@suse=
.com/T/#t


--=20
Xiaofan
