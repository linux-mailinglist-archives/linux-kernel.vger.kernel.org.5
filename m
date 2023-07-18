Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81575858A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGRT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGRT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:28:07 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE5198D;
        Tue, 18 Jul 2023 12:27:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1E0F55801F1;
        Tue, 18 Jul 2023 15:27:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 18 Jul 2023 15:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689708476; x=1689715676; bh=3v
        5olxqQbLHEUCw1wGcplsHOcuOaFlaTEOubTkDMSCY=; b=EKxjS+X8XjLaKcSjTM
        7VlHdd5cD4mhgvP83FlCd2TWGW9gfWbhvLBagTe+GE2se/43Ik0MCMjjT2c3bdVS
        KM5EMAg+Be1ww/HAkXJQibi11eulu31uXuD8eA9hDrgaUZjG+PlI+zFItCfMHoWs
        3gOT8/VbI3erWYArJZVYwO3Kl4m3KxhlZ3QinLJpPnkjaOpOJJFdXexgEg+Uaj1h
        hzvqtFXJ0Aj03BMVE0CKhX77LXn7hxYibm8XZGb9Gk3ZCr5vR/M1azcftLFJQjMv
        npTyGxx9wunQ4OaVn2H0dKJx1uLZTS8pEF+28/M8Xr4oYYklVZGTMVZSj5mR47Y/
        1QGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689708476; x=1689715676; bh=3v5olxqQbLHEU
        Cw1wGcplsHOcuOaFlaTEOubTkDMSCY=; b=lBfpAEOc91iqQkRxRnoe9r+Hc5VIe
        u7P5e6pp7ptT9MD7v+vbSgYEJWI/gQN+Us99eRkCBxtnSFcTcV9G7vD6j9S+zz+6
        FkSX02PMrF9Y2Sv9ysEOHnZ9N7XJNZstKoKNiOB8F5/f1v4RnvCgR1H78b8fdGjt
        SsagM7fSrar7+UIjkvtYnzMsDpKPGcGfsYZJkTwRGI6IZvweGi1rwOSfZyvyAEhU
        psuTd1bR7/soXkHz9fcPh9Doe1k6ES6od3X0XHrQWnsim1g1R1o7VArXK/CLB+8y
        mNUsS47U6pb/swIoGGP9KPHKpphRgwaX1SpvzHteSUE/SkBW3bTLAaW0g==
X-ME-Sender: <xms:uue2ZM1E1bss64jhpTKf0hTUOXiDK83ymplhDc67gSPSgkymXlYTIw>
    <xme:uue2ZHGVkBAGx-e0H3YA_pTmINI0cyYa4_ygqX1ZWuIGT29Pscd0F0_nBfrJyftUl
    Kh9ie8maIyGoPDC-2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:uue2ZE5_X60ZxILcTJhPmhrD8RNolXcUtdyUb8WWA1db88eCph9FcQ>
    <xmx:uue2ZF201OJvOoAueRbhOsR24Ir5NUex5TUsnU8ONLHEw7um30ahtw>
    <xmx:uue2ZPEdnNbd8cxgOP2NRIDDLW4-wIas0x5OMFJLOHy3oprBmU0BXg>
    <xmx:vOe2ZN-w3E9C_QMOeeMdT0x9Znrg8uctEno_w7BLhBRzJsVfdT4_1Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 357ECB60086; Tue, 18 Jul 2023 15:27:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <91486e8b-49ca-4a8a-8dd6-e9a2c6ed63ee@app.fastmail.com>
In-Reply-To: <20230714171642.91185-4-javierm@redhat.com>
References: <20230714171642.91185-1-javierm@redhat.com>
 <20230714171642.91185-4-javierm@redhat.com>
Date:   Tue, 18 Jul 2023 21:27:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Javier Martinez Canillas" <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Helge Deller" <deller@gmx.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Jingoo Han" <jingoohan1@gmail.com>, "Lee Jones" <lee@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 3/4] fbdev: Split frame buffer support in FB and FB_CORE symbols
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023, at 19:16, Javier Martinez Canillas wrote:
> Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
> drivers are needed (e.g: only to have support for framebuffer consoles).
>
> The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
> and so it can only be enabled if that dependency is enabled as well.
>
> That means fbdev drivers have to be explicitly disabled if users want to
> enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.
>
> This patch introduces a non-visible CONFIG_FB_CORE symbol that could be
> enabled just to have core support needed for CONFIG_DRM_FBDEV_EMULATION,
> allowing CONFIG_FB to be disabled (and automatically disabling all the
> fbdev drivers).
>
> Nothing from fb_backlight.o and fbmon.o is used by the DRM fbdev emulation
> layer so these two objects can be compiled out when CONFIG_FB is disabled.

I gave this a spin in my randconfig build setup and found one small
mistake:

> diff --git a/drivers/video/fbdev/core/Makefile 
> b/drivers/video/fbdev/core/Makefile
> index 9150bafd9e89..2cd213716c12 100644
> --- a/drivers/video/fbdev/core/Makefile
> +++ b/drivers/video/fbdev/core/Makefile
> @@ -1,10 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
> -obj-$(CONFIG_FB)                  += fb.o
> -fb-y                              := fb_backlight.o \
> -                                     fb_info.o \
> -                                     fbmem.o fbmon.o fbcmap.o \
> +obj-$(CONFIG_FB_CORE)             += fb.o
> +fb-y                              := fb_info.o \
> +                                     fbmem.o fbcmap.o \
>                                       modedb.o fbcvt.o fb_cmdline.o 
> fb_io_fops.o
> +fb-$(CONFIG_FB)                   += fb_backlight.o fbmon.o

With CONFIG_FB_CORE=y and CONFIG_FB=m, Kbuild does not include
the fb_backlight.o and fbmon.o files in fb.ko because they are not
set to =y, causing link failures for fbdev drivers later:

ERROR: modpost: "of_get_fb_videomode" [drivers/video/fbdev/clps711x-fb.ko] undefined!
ERROR: modpost: "fb_videomode_from_videomode" [drivers/video/fbdev/atmel_lcdfb.ko] undefined!
ERROR: modpost: "of_get_fb_videomode" [drivers/video/fbdev/imxfb.ko] undefined!
ERROR: modpost: "fb_destroy_modedb" [drivers/video/fbdev/udlfb.ko] undefined!
ERROR: modpost: "fb_edid_to_monspecs" [drivers/video/fbdev/udlfb.ko] undefined!
ERROR: modpost: "fb_destroy_modedb" [drivers/video/fbdev/smscufx.ko] undefined!
ERROR: modpost: "fb_edid_to_monspecs" [drivers/video/fbdev/smscufx.ko] undefined!
ERROR: modpost: "fb_destroy_modedb" [drivers/video/fbdev/uvesafb.ko] undefined!
ERROR: modpost: "fb_validate_mode" [drivers/video/fbdev/uvesafb.ko] undefined!
ERROR: modpost: "fb_get_mode" [drivers/video/fbdev/uvesafb.ko] undefined!


Folding this fixup into the patch makes it work:

diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 2cd213716c12f..84ddc5d308b58 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -4,7 +4,9 @@ obj-$(CONFIG_FB_CORE)             += fb.o
 fb-y                              := fb_info.o \
                                      fbmem.o fbcmap.o \
                                      modedb.o fbcvt.o fb_cmdline.o fb_io_fops.o
-fb-$(CONFIG_FB)                   += fb_backlight.o fbmon.o
+ifdef CONFIG_FB
+fb-y		                   += fb_backlight.o fbmon.o
+endif
 fb-$(CONFIG_FB_DEFERRED_IO)       += fb_defio.o
 fb-$(CONFIG_FB_DEVICE)            += fb_chrdev.o \
                                      fb_procfs.o \


     Arnd
