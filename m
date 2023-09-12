Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25679C8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjILHvb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjILHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:51:09 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1D2109;
        Tue, 12 Sep 2023 00:50:45 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d78328bc2abso4989997276.2;
        Tue, 12 Sep 2023 00:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505044; x=1695109844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA+GxIpXP8cITPYqZGKmspSNybpN4+ElppCVJJUtNRE=;
        b=CfAAC5Z5HFE5HaCtP7cM4S6/QKqsfAQBPfn44eaQNE4weA7z9pR9DnHdbdAfzCLjjg
         k22mQGwxhbnd7DP0Ig36eo1kZGvxsdpbzxq+8Nm4gTI3APcl2bzSgsR/nW4pz5j2TpIo
         UT0N7tgErEhjJXo/EQcuvvRGqaLFf7908cmH2QlgVX8vBrSum385uR4utpfVti1TaqTv
         201smU6d75MM0v9QZxYrnfKrwTGVjWx9jeOE0+1pdRONxdubbTvtPkINlwG1vkI+ONta
         bxHhztWiSj8drunmrzIn+z+aBkZ8vk8qmf9wEy7DDiOpwc+lowUQOOkrN8Pc8yCZx22m
         bUdw==
X-Gm-Message-State: AOJu0YzCQDhPLRrQOXGmdQvVmWIJogUngSJli+APgLz+Y+pVSrqFMF1r
        mOAzTGPxLimAuYL93M1xQ602+T77dp6GcA==
X-Google-Smtp-Source: AGHT+IF+opQhLv/wC3LxKcXmEgs+fSSjgK5kNI84E97k9Lu7tanr2m7+9VMIBbxIadpHGVBpDddXvQ==
X-Received: by 2002:a25:8083:0:b0:d80:c28e:7139 with SMTP id n3-20020a258083000000b00d80c28e7139mr4302687ybk.20.1694505044528;
        Tue, 12 Sep 2023 00:50:44 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h96-20020a25a569000000b00d687cf69599sm2097997ybi.52.2023.09.12.00.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:50:43 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d78328bc2abso4989970276.2;
        Tue, 12 Sep 2023 00:50:42 -0700 (PDT)
X-Received: by 2002:a25:512:0:b0:ba8:2e05:3e9c with SMTP id
 18-20020a250512000000b00ba82e053e9cmr11393965ybf.24.1694505042631; Tue, 12
 Sep 2023 00:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230911205338.2385278-1-arnd@kernel.org> <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
 <aa935abe-2ccf-4889-a717-4efecc13d48b@app.fastmail.com>
In-Reply-To: <aa935abe-2ccf-4889-a717-4efecc13d48b@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 09:50:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAu27grxoGmtDAZVL_ZHd7vvPcZq-FJ_zYXKKQVg_idg@mail.gmail.com>
Message-ID: <CAMuHMdUAu27grxoGmtDAZVL_ZHd7vvPcZq-FJ_zYXKKQVg_idg@mail.gmail.com>
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Sep 12, 2023 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 12, 2023, at 09:14, Geert Uytterhoeven wrote:
> > On Mon, Sep 11, 2023 at 10:53 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> --- a/drivers/gpu/drm/Kconfig
> >> +++ b/drivers/gpu/drm/Kconfig
> >> @@ -135,7 +135,7 @@ config DRM_FBDEV_EMULATION
> >>         bool "Enable legacy fbdev support for your modesetting driver"
> >>         depends on DRM
> >>         select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
> >> -       default y
> >> +       default FB
> >
> > While this is true for existing configs, it is no longer true in general,
> > as DRM_FBDEV_EMULATION is no longer related to FB.
>
> I think it still makes some sense though, as configs that have
> both DRM and FB enabled almost certainly want this enabled.

OK.

People who use DRM drivers only, and now realize they no longer need
CONFIG_FB, may need to enable CONFIG_DRM_FBDEV_EMULATION
manually when disabling CONFIG_FB, depending on their use case.

> >> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> >> index b575cf54174af..83c2d7329ca58 100644
> >> --- a/drivers/video/console/Kconfig
> >> +++ b/drivers/video/console/Kconfig
> >> @@ -74,6 +74,7 @@ config DUMMY_CONSOLE_ROWS
> >>  config FRAMEBUFFER_CONSOLE
> >>         bool "Framebuffer Console support"
> >>         depends on FB_CORE && !UML
> >> +       default DRM_FBDEV_EMULATION
> >
> > Sounds good to me, although it looks a bit strange at first sight
> > (FRAMEBUFFER_CONSOLE defaults to n on a system with real fbdev, but
> > y on emulated fbdev?).
> > So this is the fix for commit a5ae331edb02b ("drm: Drop select
> > FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION").
>
> Correct, this should restore the console on configs that
> accidentally lost it. The real problem here is much older,
> the assymetry between framebuffer-only configs (with console
> default off) and DRM configs (with console selected
> unconditionally) started back in 2009 with commit 6fcefd56f5060
> ("drm/kms: fix kms helper license + Kconfig").
>
> I think that was a mistake, but there is little we can do
> to fix that now without breaking users.

Right...

>
> The only alternative I can think of would be to default-enable
> or force-enable FRAMEBUFFER_CONSOLE for any config that includes
> both VT_CONSOLE and FB_CORE. This would increase defconfig
> builds for systems that currently only want CONFIG_FB for
> either FB_DEVICE or LOGO but don't care about
> FRAMEBUFFER_CONSOLE. I have no idea who uses such a config,
> but I think Javier previously said this was an important
> use case.
>
> >> diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
> >> index 114cb8aa6c8fd..804c2bec9b43c 100644
> >> --- a/drivers/video/fbdev/core/Kconfig
> >> +++ b/drivers/video/fbdev/core/Kconfig
> >> @@ -28,7 +28,7 @@ config FIRMWARE_EDID
> >>  config FB_DEVICE
> >>         bool "Provide legacy /dev/fb* device"
> >>         depends on FB_CORE
> >> -       default y
> >> +       default FB
> >
> > Changing this means possibly causing regressions on systems running
> > an fbdev userspace.
>
> How? FB_DEVICE is a new config that was just split out from
> CONFIG_FB in 6.6-rc1, so nobody should have any defconfig
> that disables CONFIG_FB but relies on the FB_DEVICE default yet.

Right, from the PoV of running "make oldconfig" that is true.

(I was incorrectly considering the defconfigs which I maintain,
 and where I already disabled CONFIG_FB after the FB/FB_CORE
 split in linux-next).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
