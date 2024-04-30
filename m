Return-Path: <linux-kernel+bounces-163953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A38B7683
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1791C22088
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7F171668;
	Tue, 30 Apr 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T0o0xMM/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DE171094
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481926; cv=none; b=aSlTf45yYVJ7CSvkQ0S2Zbe2+Unxcl+DKF9mU9D3whVPe+o1BmPNQdPy+OOqNGsUWAPmyVsn1DH9FX1aN/7E22jr487ilpoUnRaI8Ejop2Gqt5a4cx1S1QGabnf9HSCsWHKsHg8jcZZYodDtOtmqAmbVyMymNzxwOKW2SSwl92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481926; c=relaxed/simple;
	bh=bdVDQywRN9q+0TGpC16hr/Ent22htelHX9ET+XuhSHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSCUCEAN4j9Mo1qD2to46qw8hh1JaYYYNSw7cBUuwG755DMWRiCjSQIbD90X3lnqAgoeUB0VMngM3ZmnWNTEvHV9Aav9TIaxKUOlzFAuXWUESd7I7c2b/g2ZdToj4w1wOnNobJeOWs0t4gjTYbWvHlPULVt2nnDJmomKszz1VpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=T0o0xMM/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346407b8c9aso1230971f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714481922; x=1715086722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK7jmZXxRZeTb+AiO8D/UYyBdofUQEfkt6S+4jnJTKQ=;
        b=T0o0xMM/FBO9X7XNfKLT4ERa6RY0sS7ZfCMEH7LIv8iF5RbtAJnulVgeD85RU7J8pY
         8ivrGbbl/7ylk1i6Em9MRy/P3igoodu7Wsn76yLkN+8PLESMci0Jai626Nz6POpJqrdv
         8VLN1ehXSyZD1dHqCRP5wocjSWvpiw2TD4Oro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481922; x=1715086722;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pK7jmZXxRZeTb+AiO8D/UYyBdofUQEfkt6S+4jnJTKQ=;
        b=jKg0oLhqXrBIxtgvgPJ3zgdQ3CgzMp9ADVAyp7tN7/u7phVRJS7sf3ur44Qtf2ujCI
         UPoHG2DlRdzO7grxxjr63YlwR2+Ex/au3Ki+N4teWUQwSMS1eZktV2W5MHw9aUR2t47d
         kNGLuvmCnFA62xvNEEzSx0R2AOKSkDuqXUF4tPSKq5j6wquT6heZT4GUWrhJV13XIpEf
         P30BxMlU1Ait3KE/Dgi9NYwtKNVseLdyVdugwTXHsFM3e1LCPIJkm6IODwLVzpMTGkui
         RTISIwPCbBCV4gcimMBGE14IcrsXgcyxHXEwb0lLsjBurXhLP1BiE2816dBh3o+5P4pS
         MUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvNKhtyZX48BTTm7+s7sOA9KqNHjHds/2wRqczUAQWfCRZL65ItWFBlBuDXV1W5hHStVNoUkVqoQ+67UY2L3Y+1mxMOTnqHRc1KNZ5
X-Gm-Message-State: AOJu0YwmRIWt9BB0bCM1V9UlJfFwsVwKco2Og0Sro954on1h/SbbcM7i
	lpcSGa9slOi92XAhNJDdHXsX2jmQaHsUVW64/ul4we0HxWZjHISk556frtxomcw=
X-Google-Smtp-Source: AGHT+IGzObgQhOrn5Cn9hPdb+5X//u9rqtohoWnLNXTakga6PCKYPoCjKQwOZZ22G6y8vztfVi4+nA==
X-Received: by 2002:a5d:5692:0:b0:34d:7d77:36fa with SMTP id f18-20020a5d5692000000b0034d7d7736famr1189021wrv.5.1714481922347;
        Tue, 30 Apr 2024 05:58:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b0034d8c60c10bsm1359080wrj.92.2024.04.30.05.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:58:41 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:58:39 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: daniel@ffwll.ch, tzimmermann@suse.de, airlied@redhat.com, deller@gmx.de,
	geert@linux-m68k.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] lib/fonts: Allow to select fonts for drm_panic
Message-ID: <ZjDq_1t8iRf40dRa@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	tzimmermann@suse.de, airlied@redhat.com, deller@gmx.de,
	geert@linux-m68k.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
References: <20240419132243.154466-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419132243.154466-1-jfalempe@redhat.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Fri, Apr 19, 2024 at 03:20:19PM +0200, Jocelyn Falempe wrote:
> drm_panic has been introduced recently, and uses the same fonts as
> FRAMEBUFFER_CONSOLE.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

lib/fonts/ doesn't seem to have a designated maintainer, so please push
this through drm-misc.

Thanks, Sima
> ---
>  lib/fonts/Kconfig | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
> index 7e945fdcbf11..befcb463f738 100644
> --- a/lib/fonts/Kconfig
> +++ b/lib/fonts/Kconfig
> @@ -10,7 +10,7 @@ if FONT_SUPPORT
>  
>  config FONTS
>  	bool "Select compiled-in fonts"
> -	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
> +	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
>  	help
>  	  Say Y here if you would like to use fonts other than the default
>  	  your frame buffer console usually use.
> @@ -23,7 +23,7 @@ config FONTS
>  
>  config FONT_8x8
>  	bool "VGA 8x8 font" if FONTS
> -	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
> +	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
>  	default y if !SPARC && !FONTS
>  	help
>  	  This is the "high resolution" font for the VGA frame buffer (the one
> @@ -46,7 +46,7 @@ config FONT_8x16
>  
>  config FONT_6x11
>  	bool "Mac console 6x11 font (not supported by all drivers)" if FONTS
> -	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
> +	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
>  	default y if !SPARC && !FONTS && MAC
>  	help
>  	  Small console font with Macintosh-style high-half glyphs.  Some Mac
> @@ -54,7 +54,7 @@ config FONT_6x11
>  
>  config FONT_7x14
>  	bool "console 7x14 font (not supported by all drivers)" if FONTS
> -	depends on FRAMEBUFFER_CONSOLE
> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>  	help
>  	  Console font with characters just a bit smaller than the default.
>  	  If the standard 8x16 font is a little too big for you, say Y.
> @@ -62,7 +62,7 @@ config FONT_7x14
>  
>  config FONT_PEARL_8x8
>  	bool "Pearl (old m68k) console 8x8 font" if FONTS
> -	depends on FRAMEBUFFER_CONSOLE
> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>  	default y if !SPARC && !FONTS && AMIGA
>  	help
>  	  Small console font with PC-style control-character and high-half
> @@ -70,7 +70,7 @@ config FONT_PEARL_8x8
>  
>  config FONT_ACORN_8x8
>  	bool "Acorn console 8x8 font" if FONTS
> -	depends on FRAMEBUFFER_CONSOLE
> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>  	default y if !SPARC && !FONTS && ARM && ARCH_ACORN
>  	help
>  	  Small console font with PC-style control characters and high-half
> @@ -90,7 +90,7 @@ config FONT_6x10
>  
>  config FONT_10x18
>  	bool "console 10x18 font (not supported by all drivers)" if FONTS
> -	depends on FRAMEBUFFER_CONSOLE
> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>  	help
>  	  This is a high resolution console font for machines with very
>  	  big letters. It fits between the sun 12x22 and the normal 8x16 font.
> @@ -105,7 +105,7 @@ config FONT_SUN8x16
>  
>  config FONT_SUN12x22
>  	bool "Sparc console 12x22 font (not supported by all drivers)"
> -	depends on FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)
> +	depends on (FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)) || DRM_PANIC
>  	help
>  	  This is the high resolution console font for Sun machines with very
>  	  big letters (like the letters used in the SPARC PROM). If the
> @@ -113,7 +113,7 @@ config FONT_SUN12x22
>  
>  config FONT_TER16x32
>  	bool "Terminus 16x32 font (not supported by all drivers)"
> -	depends on FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)
> +	depends on (FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)) || DRM_PANIC
>  	help
>  	  Terminus Font is a clean, fixed width bitmap font, designed
>  	  for long (8 and more hours per day) work with computers.
> @@ -122,7 +122,7 @@ config FONT_TER16x32
>  
>  config FONT_6x8
>  	bool "OLED 6x8 font" if FONTS
> -	depends on FRAMEBUFFER_CONSOLE
> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>  	help
>  	  This font is useful for small displays (OLED).
>  
> 
> base-commit: a35e92ef04c07bd473404b9b73d489aea19a60a8
> -- 
> 2.44.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

