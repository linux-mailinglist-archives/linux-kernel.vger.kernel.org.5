Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96A7700D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjHDNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHDNHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:07:36 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5F49EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:07:30 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a776cf15c8so153287b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1691154449; x=1691759249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i/yigF2fpJEDnCMVE9c09FwuzpR2+S6iapzBaTvFv5A=;
        b=VKc6oV/RW7zPDTNHZ48iKQLRzTzlxRj54KzrC6OtsJsHsW+LFIGmDl3mkl5vOVCjS5
         556DxYCyryRDMXvZeyl8r90Zig5Sw1zY+yZQoChdvd5+wLloxiC65J8oA1RwcZausrW6
         PUh4M62bnqpMIFPa6HR2WbrTfl+EXVUNEjIDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154449; x=1691759249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/yigF2fpJEDnCMVE9c09FwuzpR2+S6iapzBaTvFv5A=;
        b=ShY/d/5ZwEjXuwW+SeRnbTg4870j420MKqWetp0cLUJElsiNpbhrmy2T5rHjmkY9Gr
         bTBkeaOw4q3E+BcHZnm1RTiRYV/38RXDryh0OlfgaG5ArQnhxHM6D9LibMpitMiZfIFm
         5nVOOLVsDhZm0EeXJBV90yWRDSbSu3tO+uNxhLrgE75NNksfsylTgQgE12L8zx7A1oxY
         gMmvP8oochKtWnGu+Ia137h2CkHJQC0BGxh3kVZjXyFHYFNyox+gtpabTfrGKfGmlp5H
         EYsgaBkUvsIj8QZQT7jr5k+7OfYC7LSBRruJjmagXcyOtmzDDE5rNvUfECGHz/EgWDvE
         Q7xg==
X-Gm-Message-State: ABy/qLbTmntdPqhkQX/k5MuTAWFxnEXCsr9C5e3rwWVrqvQFNvrVo+RU
        P/uXqhIfljJ/N6zOXsLGHmYoQ4n2yP896QQgUDi8NA==
X-Google-Smtp-Source: APBJJlF/EzkMaNQX2p63/4kVk/OEtEEV3E3kIOdMxEM5Wf7EX2fTtw0QjKGuyqON5R2OoE5HPZXiblVHLDX55eUPV0A=
X-Received: by 2002:a05:6808:3616:b0:3a1:d457:83b5 with SMTP id
 ct22-20020a056808361600b003a1d45783b5mr17111363oib.3.1691154449755; Fri, 04
 Aug 2023 06:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230804125156.1387542-1-javierm@redhat.com>
In-Reply-To: <20230804125156.1387542-1-javierm@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 4 Aug 2023 15:07:17 +0200
Message-ID: <CAKMK7uH=7m=2Y0SxPm2Q1J+u2MRWHNQrYy7M5se7Ua9ZA19y=A@mail.gmail.com>
Subject: Re: [PATCH] drm: Drop select FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 at 14:52, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The commit c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev
> emulation is enabled") changed DRM_FBDEV_EMULATION from 'depends on FB'
> to an effective 'select FB_CORE', so any config that previously had DRM=y
> and FB=n now has FB_CORE=y and FRAMEBUFFER_CONSOLE=y.
>
> This leads to unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
> as reported by Arthur Grillo, e.g:
>
> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>   Selected by [y]:
>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
>
> Arnd Bergmann suggests to drop the select FRAMEBUFFER_CONSOLE for the
> DRM_FBDEV_EMULATION Kconfig symbol, since a possible use case could
> be to enable DRM fbdev emulation but without a framebuffer console.
>
> Fixes: c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled")
> Reported-by: Arthur Grillo <arthurgrillo@riseup.net>
> Closes: https://lore.kernel.org/dri-devel/20230726220325.278976-1-arthurgrillo@riseup.net
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Yeah originally this was just to help people not misconfigure their
kernels and end up with a black screen. But select is really not a
nice way to do that, imo we could drop the FB_CORE select too :-)

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Sima

> ---
>
>  drivers/gpu/drm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index b51c6a141dfa..2a44b9419d4d 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -135,7 +135,6 @@ config DRM_DEBUG_MODESET_LOCK
>  config DRM_FBDEV_EMULATION
>         bool "Enable legacy fbdev support for your modesetting driver"
>         depends on DRM
> -       select FRAMEBUFFER_CONSOLE if !EXPERT
>         select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
>         default y
>         help
> --
> 2.41.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
