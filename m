Return-Path: <linux-kernel+bounces-144086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A158A419E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CCE1F215C5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A12421D;
	Sun, 14 Apr 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzLfFXWS"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E223763;
	Sun, 14 Apr 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713088534; cv=none; b=UDXQMVpGnXGqWl5cy8vawDRY/Ey58cw+LDPimWDjGzI8CeC163EqCs6Qt31W5hJu7f8N7ttDK0yQgJUNC/1SYl/p0iIFfopHAdxAobrNeOsPVfwunHt1ebqDK0L96M6NE3I4CbAXOlWB6+EhyL80XJZHVZT0xzQeLxerFDWcipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713088534; c=relaxed/simple;
	bh=b3tnisE5mCthW2dJBswBPlSIzQlrQrLbNhzUABTmHY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anwMLDERcusQawWEFIgkeqjMYJPDY++oyLxsL11Zms0G+j9rTtDmiYzrfCuNYTyx3s9zCgNZ9QLwJ2k9dxLKP0tjraWnvB43DPf1IxhwznXpTKpjWDCqnOMD29MI8NC9OaScgxk3wfMM9/vE23pd8URAbXTYbwcWYLGj2ky1j9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzLfFXWS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518d98b9620so213053e87.3;
        Sun, 14 Apr 2024 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713088531; x=1713693331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAW8FE3757+N73ozBr48CQyvPZHQOC5ywYwUdbEQp2A=;
        b=KzLfFXWSY+ctCoHn3r52g9vyeTJaMDvRF/C+25b7H23WrwErCL+a7r0rLcqgW5UcV+
         2JFvlGCsitldlPZ+1fvtUZCjMdhM9tqw+hdM0KTgE7pdFqAZ0FmrwMYjwzrhFHs4D3ZQ
         xgs+gURcxFTihBLbuEmS1hWrhAR/ESqF0InbaNf+wud41nwIKjS4cutyWyk2iRtlX6VF
         C22uwJTSmnGNPkabws6l2t+v6G+ljd/RfL8vaa3XLm9CizHEU4416pMS4/xh/fvNryU5
         pVH6VmdesLtD/wAC67I80fz1/EZb2vcQQLWZ7bn0v47rAyEdiof6H03sehYwD56yUmlG
         83Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713088531; x=1713693331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAW8FE3757+N73ozBr48CQyvPZHQOC5ywYwUdbEQp2A=;
        b=GdLHFSWTyoXiJGATTtwghQadKmaTQ5hst1/0cnKcFRDs9Felf7Ck7qCeH2zZNjQgu7
         ut5wyqWPd6W12kpxZ0KtVaG0N8LuLilTzHNHNd/beYyKpuMJp6HoWVI1FTc40Nmbk8Cj
         vUVFSSollMlgaW/aTeJ7nptiILAOoSKC23qjhU5iLwQnirlvdgvAKjhG9AR5vFfJc/Av
         UfOzzdPi1+Y6KIkVUB/K2uq4KZ7oIuQ6qc5E2EGecpzggTbnXsuxm3DvIoCV7sr5Kitu
         ekGZLgZc+eZihf7LlLu/+whcRDMDo8+b9/KG5XZbfYPLT4MWmoR0HBYXvWgj8w8zoHqk
         HGbw==
X-Forwarded-Encrypted: i=1; AJvYcCUt5kU/RR7fVrgjpWGZLXnxaUQQ9HHaGu0dBZ73cf4xqqTYlRB8T/nYHQaW7gNWbZTWDfij2UG7XDX1sf9XZ0QgEK26UCFMhiT9ZmSFHdmFNBBPr3wrZErCUtxPqIQlFl1M6+khD+dEpQ==
X-Gm-Message-State: AOJu0Yw+9EMlNVnaZuiedTLzXbiuCVQBrDRK4ZNpeOeERIdgeDeM4kNN
	Sq69+xPC9LRJww3csStoGFldxMspyWV64S60m1v8BJtADoy3FvAq
X-Google-Smtp-Source: AGHT+IEEKoM/iDTJCuznVR9HiQN/AVCO8Nii+pEgbCzxUMbS3kxqr5wisBFEtwUu4Hozxm6Lwg6jLw==
X-Received: by 2002:ac2:51b7:0:b0:516:c099:e785 with SMTP id f23-20020ac251b7000000b00516c099e785mr4409977lfk.20.1713088531265;
        Sun, 14 Apr 2024 02:55:31 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-123-252-50-gprs.simobil.net. [46.123.252.50])
        by smtp.gmail.com with ESMTPSA id f10-20020a056000128a00b003436a3cae6dsm8677094wrx.98.2024.04.14.02.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 02:55:30 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Maxime Ripard <mripard@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-mips@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 5/7] ARM: configs: sunxi: Enable DRM_DW_HDMI
Date: Sun, 14 Apr 2024 11:55:27 +0200
Message-ID: <3289340.44csPzL39Z@jernej-laptop>
In-Reply-To: <20240403-fix-dw-hdmi-kconfig-v1-5-afbc4a835c38@kernel.org>
References:
 <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
 <20240403-fix-dw-hdmi-kconfig-v1-5-afbc4a835c38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 3. april 2024 ob 12:56:23 CEST je Maxime Ripard napisal(a):
> Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
> module") turned the DRM_DW_HDMI dependency of DRM_SUN8I_DW_HDMI into a
> depends on which ended up disabling the driver in the defconfig. Make
> sure it's still enabled.
> 
> Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/configs/sunxi_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index bddc82f78942..a83d29fed175 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -108,10 +108,11 @@ CONFIG_DRM_SUN4I_HDMI_CEC=y
>  CONFIG_DRM_SUN8I_DW_HDMI=y
>  CONFIG_DRM_PANEL_LVDS=y
>  CONFIG_DRM_PANEL_SIMPLE=y
>  CONFIG_DRM_PANEL_EDP=y
>  CONFIG_DRM_SIMPLE_BRIDGE=y
> +CONFIG_DRM_DW_HDMI=y
>  CONFIG_DRM_LIMA=y
>  CONFIG_FB_SIMPLE=y
>  CONFIG_BACKLIGHT_CLASS_DEVICE=y
>  CONFIG_BACKLIGHT_PWM=y
>  CONFIG_SOUND=y
> 
> 





