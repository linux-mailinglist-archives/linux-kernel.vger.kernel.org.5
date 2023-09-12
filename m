Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D679C7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjILHPO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 03:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjILHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:15:12 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3269B9;
        Tue, 12 Sep 2023 00:15:08 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59b9b47e35dso13053187b3.0;
        Tue, 12 Sep 2023 00:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502908; x=1695107708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQRallN7a7RlN4ob4UzNdS6lCadZKR5S0w4gWNgqx4U=;
        b=xTiTgnPlbuMCyT92xzJh1rOHEOKwu/l/FK7KrqecnLHN0gh89HXeVf4lWeZHI4FSH/
         BJ9+jpmvOT6uDBlDgdo0UgSkcAZJjEINSc2xVlrMo67gU9TUAUdSEh9kbpWZdgw2vBQJ
         Ucmv2XsGoZmytcuQdZIvGDKYjYgNU2TOdB9U2EagwW+Qyuxx6FwZOXYtpV8yADn1PVhK
         exkCglsRz5M23rFHr9IjSFagac6QwyQ4XyrXtyUigtMKK5kVYHmBBUb/LAIIG+mv+yi6
         bPlfB3F1CrsQZBu8Ha4HYtjl+QmWyf1Mir9jJpxwwLdZLH+xIauN0Obb184uJ7PbOiqh
         qyOA==
X-Gm-Message-State: AOJu0YxHSSgJr0p1E8vigIuaxnDhA9DSpI7fHu04G8F+KrrJMK6UFx8s
        04fdqU5WosZ4VzbcQZZ+YoLBhf1vA8d0OA==
X-Google-Smtp-Source: AGHT+IFP2WJ7HwQzLISs/SuYvfLOzZZGXZa7GgRmpOWxIj5hqBmUVSjJBY6Fmt18KVOlytvQ2n4mRA==
X-Received: by 2002:a0d:dd96:0:b0:570:65df:21dc with SMTP id g144-20020a0ddd96000000b0057065df21dcmr12363898ywe.3.1694502907976;
        Tue, 12 Sep 2023 00:15:07 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id m4-20020a0de304000000b005773babc3cdsm2400153ywe.83.2023.09.12.00.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:15:06 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d7d50ba994eso4592667276.1;
        Tue, 12 Sep 2023 00:15:06 -0700 (PDT)
X-Received: by 2002:a25:d695:0:b0:d3c:58ef:ef7b with SMTP id
 n143-20020a25d695000000b00d3c58efef7bmr11682985ybg.6.1694502906112; Tue, 12
 Sep 2023 00:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230911205338.2385278-1-arnd@kernel.org>
In-Reply-To: <20230911205338.2385278-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 09:14:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
Message-ID: <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
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

On Mon, Sep 11, 2023 at 10:53 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> As a result of the recent Kconfig reworks, the default settings for the
> framebuffer interfaces changed in unexpected ways:
>
> Configurations that leave CONFIG_FB disabled but use DRM now get
> DRM_FBDEV_EMULATION by default. This also turns on the deprecated /dev/fb
> device nodes for machines that don't actually want it.
>
> In turn, configurations that previously had DRM_FBDEV_EMULATION enabled
> now only get the /dev/fb front-end but not the more useful framebuffer
> console, which is not selected any more.
>
> We had previously decided that any combination of the three frontends
> (FB_DEVICE, FRAMEBUFFER_CONSOLE and LOGO) should be selectable, but the
> new default settings mean that a lot of defconfig files would have to
> get adapted.
>
> Change the defaults back to what they were in Linux 6.5:
>
>  - Leave DRM_FBDEV_EMULATION turned off unless CONFIG_FB
>    is enabled. Previously this was a hard dependency but now the two are
>    independent. However, configurations that enable CONFIG_FB probably
>    also want to keep the emulation for DRM, while those without FB
>    presumably did that intentionally in the past.
>
>  - Leave FB_DEVICE turned off for FB=n. Following the same
>    logic, the deprecated option should not automatically get enabled
>    here, most users that had FB turned off in the past do not want it,
>    even if they want the console
>
>  - Turn the FRAMEBUFFER_CONSOLE option on if
>    DRM_FBDEV_EMULATION is set to avoid having to change defconfig
>    files that relied on it being selected unconditionally in the past.
>    This also makes sense since both LOGO and FB_DEVICE are now disabled
>    by default for builds without CONFIG_FB, but DRM_FBDEV_EMULATION
>    would make no sense if all three are disabled.
>
> Fixes: a5ae331edb02b ("drm: Drop select FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION")
> Fixes: 701d2054fa317 ("fbdev: Make support for userspace interfaces configurable")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -135,7 +135,7 @@ config DRM_FBDEV_EMULATION
>         bool "Enable legacy fbdev support for your modesetting driver"
>         depends on DRM
>         select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
> -       default y
> +       default FB

While this is true for existing configs, it is no longer true in general,
as DRM_FBDEV_EMULATION is no longer related to FB.

>         help
>           Choose this option if you have a need for the legacy fbdev
>           support. Note that this support also provides the linux console
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index b575cf54174af..83c2d7329ca58 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -74,6 +74,7 @@ config DUMMY_CONSOLE_ROWS
>  config FRAMEBUFFER_CONSOLE
>         bool "Framebuffer Console support"
>         depends on FB_CORE && !UML
> +       default DRM_FBDEV_EMULATION

Sounds good to me, although it looks a bit strange at first sight
(FRAMEBUFFER_CONSOLE defaults to n on a system with real fbdev, but
y on emulated fbdev?).
So this is the fix for commit a5ae331edb02b ("drm: Drop select
FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION").

>         select VT_HW_CONSOLE_BINDING
>         select CRC32
>         select FONT_SUPPORT
> diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
> index 114cb8aa6c8fd..804c2bec9b43c 100644
> --- a/drivers/video/fbdev/core/Kconfig
> +++ b/drivers/video/fbdev/core/Kconfig
> @@ -28,7 +28,7 @@ config FIRMWARE_EDID
>  config FB_DEVICE
>         bool "Provide legacy /dev/fb* device"
>         depends on FB_CORE
> -       default y
> +       default FB

Changing this means possibly causing regressions on systems running
an fbdev userspace.

>         help
>           Say Y here if you want the legacy /dev/fb* device file and
>           interfaces within sysfs anc procfs. It is only required if you

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
