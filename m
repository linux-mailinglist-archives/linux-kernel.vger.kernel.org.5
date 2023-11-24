Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF87F84CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbjKXTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346033AbjKXTkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:40:15 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680DEC2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:40:22 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4ac1988ca66so1220395e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700854821; x=1701459621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfPuzQ88UTumZWzrpshNNxDAiNQ7rGXcChPe9HqpR3s=;
        b=QsTDrsRX3hYGfPWERq7r8U9nyyGkM0Wtly2QBeOjSuusxBuubK/GNkkZMHlft0G4fC
         eSAhhI91xaySkrZekI/Cm/67OlOP91Of060XTC5vjcQ7mOjfPHDGh8VGzD3oEJI7WOI4
         iYf4/zFF8bQ/gZ4nnDEi5/oOX8tIAg2jHEIj7kF04MTfXGh3EjGXa4FckKUs7GViODsq
         iWoqJt2XOHcFV9UipKs28KzD6mQiz4ezpqlLoxyOkWJhtebV7sp3CKj7FQZvV0GD6KF2
         r7Mn6KW0mVOeAZRZQ7HxyHM7bJYtGMY3+pizEl9kUcLgsXGqVZ5HAiwePVaaqkRVJhzh
         IXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700854821; x=1701459621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfPuzQ88UTumZWzrpshNNxDAiNQ7rGXcChPe9HqpR3s=;
        b=rSdmavVoShwQ09sVaztt+zNJPE94NlsAnyQB/+7zwXK7hCAL6SFkZ2bkNQNoVM2Wsd
         yKv6F7EyrmYMl07Sedj/Nl8S0huHk5la6/osIOHg38R+1IyR8WtHNqtx2IU4rEgcokLo
         sZiLjyIe8IFZAgN2M8RAvHAn5sjEVQVl+Wz5IpckT/gu89pGlZEGrWbVTANKF3I2bP0u
         S9Q3Hl1QHN3AmGRHWwfSCEttcLMeqOZni72g3fLWoex4g+O5wj51uBI5ghejAmhSEbFd
         ai8y2Gc7axGp6BuCz5+TIQ5lwcq1gYE5p7VRNsOURB7KZaqDQg+oL3k3mNaJWhj9tcr9
         oQwA==
X-Gm-Message-State: AOJu0YzmG5b5DF6aLal7gscnV/PHNZsL5i8Jxd89eipgdtSAsfBJ5lnL
        UnIfb69Pdg3/O3QHUHtb/LEYDXV6ewPgq+ijUqTqBA==
X-Google-Smtp-Source: AGHT+IGaj4iMx31WHoOJsNqKMY2PR3YY/foCeMKUh9ruPFkRvtuUyQmgXBGrcB2rE8J6OUiUjsGAphzg4M8S3DVAK54=
X-Received: by 2002:a1f:4a45:0:b0:495:e688:72b7 with SMTP id
 x66-20020a1f4a45000000b00495e68872b7mr4731673vka.4.1700854821504; Fri, 24 Nov
 2023 11:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20231115165001.2932350-1-brgl@bgdev.pl> <CACRpkdbDny8X3WB_qJ4h_vbwrjno5ytAtNMgTeXg4jpegdUH2w@mail.gmail.com>
 <CAMRc=McZJzdj04Ckf_ygDhWNN2JcbTfY+yefOZSYx_nTE_Jpjg@mail.gmail.com> <CACRpkdb7QwWcq=mDa4y8bh_QLAFU+X9LCr0chrGVL-_9YE5P9A@mail.gmail.com>
In-Reply-To: <CACRpkdb7QwWcq=mDa4y8bh_QLAFU+X9LCr0chrGVL-_9YE5P9A@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 24 Nov 2023 20:40:10 +0100
Message-ID: <CAMRc=Md+5N_u0QkL+OTc2xVQuxP0dZY-1GbrdGQqwhdJrv4Cbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: don't use gpiod_to_chip()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:01=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Mon, Nov 20, 2023 at 4:06=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Thu, Nov 16, 2023 at 2:43=E2=80=AFPM Linus Walleij <linus.walleij@li=
naro.org> wrote:
> > > On Wed, Nov 15, 2023 at 5:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Let's start working towards removing gpiod_to_chip() from the kerne=
l.
> > > > Start with pinctrl. The first patch should go through the GPIO tree
> > > > and become available through an immutable tag so that we can get mo=
re
> > > > conversions in this cycle elsewhere.
> > >
> > > Fair enough, maybe an immutable branch with all three patches?
> > > Probably best to merga all three into both subsystems I think.
> > >
> >
> > Nah, I don't think I need to pollute the GPIO tree with every pinctrl
> > patch. It's enough to just merge the first one into GPIO and you do
> > the same in pinctrl.
>
> Fair enough, but I need that immutable branch for patch 1 so I
> can merge the rest on top.
>
> Yours,
> Linus Walleij

I applied the first patch (after fixing the typo in the commit
message) and sent you the immutable branch to pull. Please apply the
remaining patches to the pinctrl tree directly.

Thanks!
Bart
