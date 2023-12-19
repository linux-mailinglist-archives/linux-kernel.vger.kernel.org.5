Return-Path: <linux-kernel+bounces-5653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEEA818DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC401C24C85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8F328BF;
	Tue, 19 Dec 2023 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+vn4rWn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6D37151;
	Tue, 19 Dec 2023 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35d74cf427cso18921545ab.1;
        Tue, 19 Dec 2023 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005476; x=1703610276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3vdGyZ+giFIRD6X/bv1+u6PRAF0RuL1pLhWZ53wREY=;
        b=M+vn4rWnYkTg/9veDuZy7T7E/XFLosmgJwflwp42cT68peKJ2Oxan0yP27HaWNeBn/
         htHZanxHsGXSo3WQmElN768pWKqsTFa/ruBZYNLR9SuJ8HxCXII7SYykwdXdv8UdMmpL
         +Q6xBnqiTmXKQErq84Hc8ZgrPBB+J6HiMHLKTSWnDa6/nUfAZQu7vCcw475T63AO1tUi
         sxFP7vShVu8ijF6X3Wu+/LwfvpApjKG1OCONM40wDasI9ymjeDDm1FGUg0wtusbjGC78
         nOa3EBOAPQy27iC08IgeZFmsMte7qECM690R5sZxQAoQ5RY1dklJJhLO2sHljRt3C81E
         Nt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005476; x=1703610276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3vdGyZ+giFIRD6X/bv1+u6PRAF0RuL1pLhWZ53wREY=;
        b=wbvnwLQbbQ5dwBy/3E+xyMzn/HGCAe7Q1k0vUEwN2GqRJ4qdZNriC2lQO5qdQK0jGX
         Aa0R4vx1ANRV4AcdDZ7eoRQlYrrV4PLQykL5h7dCVXmU0NlR+v8GEfQCXEmQZHwsYm+f
         eBT9pAOr9VRINxO5STMwOcJTI5wrxzzR3E7qCdlllaswOzCTBOHsk0fypMTEdllXSSv5
         R2xgEo9chaclA5FfeSRVYau6Jrwya9qvUsKsjgUaGa/z2r73bK81nxSwBXVz2VyPhG1k
         EuCVBqs2o9fb0mak5Xp37YE4k0qyjniQrrKsY3chMtGH3IHODiDzAwkl+jZSDWUbgcUc
         b4cA==
X-Gm-Message-State: AOJu0YyDiw3pCqaCrrXITRYkYEIgYyIv77yFJwIzKFl2/yxVV5RqXObP
	ZoolBURHJs22pc2xjDdFr50=
X-Google-Smtp-Source: AGHT+IHTnWFbi3tnLUi55hj74IPei992iitC3hJxS75IRffKP/GDwsXkYn/gQjSWJRug8oGL8oZx1Q==
X-Received: by 2002:a05:6e02:20e3:b0:35f:c6d4:5d59 with SMTP id q3-20020a056e0220e300b0035fc6d45d59mr273364ilv.43.1703005475772;
        Tue, 19 Dec 2023 09:04:35 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id w1-20020a056e021a6100b0035161817c37sm7488495ilv.1.2023.12.19.09.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:04:35 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH 5/5] drm/panel: st7703: Drive XBD599 panel at higher clock rate
Date: Tue, 19 Dec 2023 18:04:29 +0100
Message-ID: <10386431.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20231218-pinephone-pll-fixes-v1-5-e238b6ed6dc1@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <20231218-pinephone-pll-fixes-v1-5-e238b6ed6dc1@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 18. december 2023 ob 14:35:23 CET je Frank Oltmanns napisal(a):
> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
> Acoording to it's datasheet, the SOC requires PLL-MIPI to run at more
> than 500 MHz.
> 
> Therefore, change [hv]sync_(start|end) so that we reach a clock rate
> that is high enough to drive PLL-MIPI within its limits.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

I'm not too sure about this patch. I see that PLL_MIPI doesn't have set
minimum frequency limit in clock driver. If you add it, clock framework
should find rate that is high enough and divisible with target rate.

Best regards,
Jernej  

> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index b55bafd1a8be..6886fd7f765e 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -320,14 +320,14 @@ static int xbd599_init_sequence(struct st7703 *ctx)
>  
>  static const struct drm_display_mode xbd599_mode = {
>  	.hdisplay    = 720,
> -	.hsync_start = 720 + 40,
> -	.hsync_end   = 720 + 40 + 40,
> -	.htotal	     = 720 + 40 + 40 + 40,
> +	.hsync_start = 720 + 65,
> +	.hsync_end   = 720 + 65 + 65,
> +	.htotal      = 720 + 65 + 65 + 65,
>  	.vdisplay    = 1440,
> -	.vsync_start = 1440 + 18,
> -	.vsync_end   = 1440 + 18 + 10,
> -	.vtotal	     = 1440 + 18 + 10 + 17,
> -	.clock	     = 69000,
> +	.vsync_start = 1440 + 30,
> +	.vsync_end   = 1440 + 30 + 22,
> +	.vtotal	     = 1440 + 30 + 22 + 29,
> +	.clock	     = (720 + 65 + 65 + 65) * (1440 + 30 + 22 + 29) * 60 / 1000,
>  	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>  	.width_mm    = 68,
>  	.height_mm   = 136,
> 
> 





