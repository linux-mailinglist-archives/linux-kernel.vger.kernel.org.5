Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2F811C50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441940AbjLMSZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjLMSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:25:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5877BA7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:25:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bffb64178so8583620e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702491928; x=1703096728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4T7IXenNPOtzbX0sRW347M25g6cHdogNOdNR8o/dNI=;
        b=MXfLUkoKgRX5iWgk6yh9cANeaQ58XSY+k0HHdAwKqI/y7fNYKFZi3GldlGWaUZxCNX
         FHykxne6R+8ouBeejlRO3Yjp1SaEVafiPaCk7yZhwSKo3+vecgVID0HPZmTClheottgn
         GM3dBgQhxZCqsw6rQlM1QjiZtWOxiHmuG2IiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491928; x=1703096728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4T7IXenNPOtzbX0sRW347M25g6cHdogNOdNR8o/dNI=;
        b=D5eRIsAAAHSSE9kVQsfnsUgQJ541Opoq6ZMqhNG0kxD4Z6hbmnHK4VnO+ZWiKIa8Eq
         kpb20JO7QUpt8KZ5hpwIISTJ6hhW4BHnqzICG8CakB/HR+JLpCsDslUkKuWFebvGqEOr
         WqgSpkTAJG2qE3chEFYqWNGaZmPZAq8vxRBc91N/rf+UHuqhHV/+Zx9aNuSE0zzk/fNE
         mvSP6iMG5yZ9keZBsK42L6o8OGQwy5qT/Jt+TUffsXs6FCmtgSRjIs1IAkJ618ogIxV1
         x3vfx3Na2Ts6kKjW9VFa+ZFXBRkG+6tqAaK9RlxUmNON5dWv450iu96YlFB6AOijQ+/k
         OW4g==
X-Gm-Message-State: AOJu0YwGWPcXUnKn9OXTVco6cBqePNJoFIhLzlykW5OI7epvMe02+eHC
        bgt89k8OaYZguukVezM8IZ8iaE06KmyJiJYXDWnTsoKy
X-Google-Smtp-Source: AGHT+IF5MHvDbpniAME3EzWsqDNbuHLxrhdrNK+Spf/RwoN+SUf3dslKvy2HfVK+ZdGGWUp/Y4kuBg==
X-Received: by 2002:a05:6512:159d:b0:50b:e7e6:8761 with SMTP id bp29-20020a056512159d00b0050be7e68761mr4272963lfb.86.1702491928126;
        Wed, 13 Dec 2023 10:25:28 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b0054c8f7708c9sm6271056edc.79.2023.12.13.10.25.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:25:28 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso5585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:25:28 -0800 (PST)
X-Received: by 2002:a7b:c3d9:0:b0:40c:20d3:3a12 with SMTP id
 t25-20020a7bc3d9000000b0040c20d33a12mr424519wmj.2.1702491450727; Wed, 13 Dec
 2023 10:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20231211182036.606660304@linuxfoundation.org> <ZXi9wyS7vjGyUWU8@duo.ucw.cz>
 <a6af01bf-7785-4531-8514-8e5eb09e207e@roeck-us.net> <ZXliuTqyO_IjlIz7@amd.ucw.cz>
 <2023121342-wanted-overarch-84a7@gregkh> <CAD=FV=WK52EjYh0nn8e0PEvY5ovUOn9rymnY09B7SQNgUXymPw@mail.gmail.com>
 <2023121322-mortician-superman-54a9@gregkh>
In-Reply-To: <2023121322-mortician-superman-54a9@gregkh>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Dec 2023 10:17:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UWo7Rm=r2N-dtGMYEggGuGgfQWkueN7sWpYDwrocfJNA@mail.gmail.com>
Message-ID: <CAD=FV=UWo7Rm=r2N-dtGMYEggGuGgfQWkueN7sWpYDwrocfJNA@mail.gmail.com>
Subject: Re: RTL8152_INACCESSIBLE was Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, Guenter Roeck <linux@roeck-us.net>,
        grundler@chromium.org, davem@davemloft.net, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 13, 2023 at 9:38=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 13, 2023 at 07:16:52AM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Dec 13, 2023 at 12:50=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 08:52:25AM +0100, Pavel Machek wrote:
> > > > Hi!
> > > >
> > > > > > > This is the start of the stable review cycle for the 6.1.68 r=
elease.
> > > > > > > There are 194 patches in this series, all will be posted as a=
 response
> > > > > > > to this one.  If anyone has any issues with these being appli=
ed, please
> > > > > > > let me know.
> > > > > >
> > > > > >
> > > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
> > > > > > >
> > > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1(=
)
> > > > > > >
> > > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > > >      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_f=
lash()
> > > > > > >
> > > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > > >      r8152: Add RTL8152_INACCESSIBLE checks to more loops
> > > > > > >
> > > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > > >      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
> > > > > >
> > > > > > Central patch that actually fixes something is:
> > > > > >
> > > > > > commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4
> > > > > > Author: Douglas Anderson <dianders@chromium.org>
> > > > > > Date:   Fri Oct 20 14:06:59 2023 -0700
> > > > > >
> > > > > >      r8152: Block future register access if register access fai=
ls
> > > > > >
> > > > > > ...but we don't have that in 6.1. So we should not need the res=
t,
> > > > > > either.
> > > > > >
> > > > >
> > > > > Also, the missing patch is fixed subsequently by another patch, s=
o it can not
> > > > > be added on its own.
> > > >
> > > > For the record I'm trying to advocate "drop all patches listed as t=
hey
> > > > don't fix the bug", not "add more", as this does not meet stable
> > > > criteria.
> > >
> > > But the original commit here does say it fixes a bug, see the text of
> > > the commits listed above.  So perhaps someone got this all wrong when
> > > they wrote the original commits that got merged into 6.7-rc?  Otherwi=
se
> > > this seems like they are sane to keep for now, unless the original
> > > author says they should be dropped, or someone who can test this driv=
er
> > > says something went wrong.
> >
> > Right. The patches that "add RTL8152_INACCESSIBLE" to more loops are
> > bugfixes, but they're not terribly important ones to backport. While
> > they technically make sense even on older kernels and could
> > conceivably make the older kernels unload the r8152 driver a little
> > faster when a device is unplugged, it's not a big deal. On the first
> > version of the recent patches I didn't even add a "Fixes" tag for them
> > but I was asked to during the review process.
> >
> > The "add RTL8152_INACCESSIBLE" patches become more important with
> > commit d9962b0d4202 ("r8152: Block future register access if register
> > access fails"). Once you have that it's possible to end up in the
> > "INACCESSIBLE" situation in response to normal (ish) error handling
> > and thus you want it to be faster.
> >
> > Based on our experience in ChromeOS, commit d9962b0d4202 ("r8152:
> > Block future register access if register access fails") is a pretty
> > important fix and I would say it should be backported to stable.
> > Certainly we've backported it to our kernels in ChromeOS. In our case
> > we made things easier on ourselves by backporting pretty much all
> > patches to the r8152 driver.
>
> Ok, as lots of fixes seem to be needed here, do you have a list of the
> git ids that we should backport to bring this up to a workable state
> like you have in your tree?

The ones that were relevant to commit d9962b0d4202 ("r8152: Block
future register access if register access fails") were these, which is
basically the two series that I landed recently.:

79321a793945 r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
8c53a7bd7065 r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
8a67b47fced9 r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
32a574c7e268 r8152: Add RTL8152_INACCESSIBLE checks to more loops
e62adaeecdc6 r8152: Hold the rtnl_lock for all of reset

d9962b0d4202 r8152: Block future register access if register access fails
715f67f33af4 r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
bc65cc42af73 r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
dc90ba37a8c3 r8152: Check for unplug in rtl_phy_patch_request()
b8d35024d405 r8152: Release firmware if we have an error in probe
bb8adff9123e r8152: Cancel hw_phy_work if we have an error in probe
5dd176895269 r8152: Run the unload routine if we have errors during probe
a5feba71ec9c r8152: Increase USB control msg timeout to 5000ms as per spec

The problem, of course, is that picking commit d9962b0d4202 ("r8152:
Block future register access if register access fails") causes
conflicts with other changes that have happened to this driver. On
ChromeOS we generally resolve things like this by just picking the
extra patches. We already had quite a few backports to the ChromeOS
kernel trees, so I can't say it would be the same for stable branches.
On ChromeOS 5.15 you can see the picks that were needed at:

https://crrev.com/c/4857700

If you click "SHOW ALL (17)" then you can see the patches that I
uploaded together to get things resolved on our ChromeOS 5.15 branch.
There are also links to our 6.1, 5.10, and 5.4 branches.

One note is that as part of taking these extra patches we ended up
getting commit ec51fbd1b8a2 ("r8152: add USB device driver for config
selection") which caused a regression. That's where the following
recent changes that landed in your tree came from:

aa4f2b3e418e r8152: Choose our USB config with choose_configuration()
rather than probe()
a87b8e3be926 usb: core: Allow subclassed USB drivers to override
usb_choose_configuration()
c2d95fcff0f0 usb: core: Don't force USB generic_subclass drivers to
define probe()

...and where the (pending) extra patch came from:

https://lore.kernel.org/r/20231211073237.v3.1.If27eb3bf7812f91ab83810f23229=
2f032f4203e0@changeid
("usb: core: Fix crash w/ usb_choose_configuration() if no driver")


-Doug
