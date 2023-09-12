Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935CE79C9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjILISt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 04:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjILISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:18:41 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B34E78;
        Tue, 12 Sep 2023 01:18:37 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58fa51a0d97so51200077b3.3;
        Tue, 12 Sep 2023 01:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506716; x=1695111516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khdzgLGt8t6E0rL7mFhUTkO1q/TxNFHuMsXkANz78Pg=;
        b=Y0MimktYlbVJ2v3vP/LiFofWk5udQyoGxEHWfdfWb6HaElNmAczp3XkhIjYFU6uDwE
         ii7r6xNxc/jYCgN6Gu9lF2NZYBogXXnsP0xkW3O2SbKa7o6fhBfoF2YaDEkeVet/pfnV
         do+tb9KZFHSHer6qEpBcAqnvp1oijyrHxSsqqjl9GPWLBkDdapkFvlhNaLyC2AqhDfnI
         TQEGppayBqLA46ff1FS+563PJzPHoKnGgJNAWmoqM+1+kNle0DObqJljyaLqhlR266/j
         faizdCcdnRJkNGPZvvgvqWBSsbVQvNN6mnubGs2rZM9+y+BLkYjlINMUKvNPDk0wVKBH
         MOrA==
X-Gm-Message-State: AOJu0YwFaSh1lVX6bwaYNP9tubuN0evyrwljvw/uveJgL5qaqGOMb5h0
        lJefC/N7QlU9MUIoHFtH4gCWMdY+eBpYzg==
X-Google-Smtp-Source: AGHT+IHkVDm3UHR6hVgc80M8CMmIpM40wKCdcqnNTB1Ik/VtnAO6fQKS1hDt8qVsvtuwkkgQKq7gzw==
X-Received: by 2002:a25:ca16:0:b0:d4e:4103:7807 with SMTP id a22-20020a25ca16000000b00d4e41037807mr10491465ybg.60.1694506716181;
        Tue, 12 Sep 2023 01:18:36 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id v3-20020a05690204c300b00c62e0df7ca8sm2002244ybs.24.2023.09.12.01.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:18:35 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d7e741729a2so4949063276.2;
        Tue, 12 Sep 2023 01:18:35 -0700 (PDT)
X-Received: by 2002:a25:ac22:0:b0:d80:1604:f6e9 with SMTP id
 w34-20020a25ac22000000b00d801604f6e9mr11644271ybi.44.1694506715264; Tue, 12
 Sep 2023 01:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230911205338.2385278-1-arnd@kernel.org> <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
 <637afb25-8ee2-4188-9385-27ee6a97ec59@suse.de>
In-Reply-To: <637afb25-8ee2-4188-9385-27ee6a97ec59@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 10:18:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW63WjidvAovqRz70bMgbLt4cSkOP1xSh7sEcqdwR3tOw@mail.gmail.com>
Message-ID: <CAMuHMdW63WjidvAovqRz70bMgbLt4cSkOP1xSh7sEcqdwR3tOw@mail.gmail.com>
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
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

Hi Thomas,

On Tue, Sep 12, 2023 at 10:11 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 12.09.23 um 09:14 schrieb Geert Uytterhoeven:
> [...]
> >> --- a/drivers/gpu/drm/Kconfig
> >> +++ b/drivers/gpu/drm/Kconfig
> >> @@ -135,7 +135,7 @@ config DRM_FBDEV_EMULATION
> >>          bool "Enable legacy fbdev support for your modesetting driver"
> >>          depends on DRM
> >>          select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
> >> -       default y
> >> +       default FB
> >
> > While this is true for existing configs, it is no longer true in general,
> > as DRM_FBDEV_EMULATION is no longer related to FB.
>
> Would it make sense to make FRAMEBUFFER_CONSOLE an independent option
> and have FBDEV_EMULATION depend on it? Something like this:
>
> FRAMEBUFFER_CONSOLE
>         depends on DRM || FB
>         select FB_CORE
>
> FBDEV_EMULATION
>         depends on DRM
>         depends on FRAMEBUFFER_CONSOLE
>         default y

Oops, now you can no longer have FBDEV_EMULATION without
FRAMEBUFFER_CONSOLE, which is useful to be able to enable
FB_DEVICE...

And what's the point (if DRM is enabled) of having FB_CORE with
FBDEV_EMULATION disabled?

> So if any graphics subsystems are enabled, FRAMEBUFFER_CONSOLE is
> select-able. But for DRM, FBDEV_EMULATION disables the console. That

Huh?

/me looks at his morning coffee, and confirms the cup is empty...

> option remains more for historical reasons than actual usefulness.

> >> --- a/drivers/video/console/Kconfig
> >> +++ b/drivers/video/console/Kconfig
> >> @@ -74,6 +74,7 @@ config DUMMY_CONSOLE_ROWS
> >>   config FRAMEBUFFER_CONSOLE
> >>          bool "Framebuffer Console support"
> >>          depends on FB_CORE && !UML
> >> +       default DRM_FBDEV_EMULATION
> >
> > Sounds good to me, although it looks a bit strange at first sight
> > (FRAMEBUFFER_CONSOLE defaults to n on a system with real fbdev, but
> > y on emulated fbdev?).
> > So this is the fix for commit a5ae331edb02b ("drm: Drop select
> > FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION").
> >
> >>          select VT_HW_CONSOLE_BINDING
> >>          select CRC32
> >>          select FONT_SUPPORT
> >> diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
> >> index 114cb8aa6c8fd..804c2bec9b43c 100644
> >> --- a/drivers/video/fbdev/core/Kconfig
> >> +++ b/drivers/video/fbdev/core/Kconfig
> >> @@ -28,7 +28,7 @@ config FIRMWARE_EDID
> >>   config FB_DEVICE
> >>          bool "Provide legacy /dev/fb* device"
> >>          depends on FB_CORE
> >> -       default y
> >> +       default FB
> >
> > Changing this means possibly causing regressions on systems running
> > an fbdev userspace.
> >
> >>          help
> >>            Say Y here if you want the legacy /dev/fb* device file and
> >>            interfaces within sysfs anc procfs. It is only required if you

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
