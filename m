Return-Path: <linux-kernel+bounces-161425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11B58B4BCB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286871F21AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB0E6BB37;
	Sun, 28 Apr 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpBo87EX"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E2634E2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714308174; cv=none; b=ckSqS3M7FnwW+sun3xTLH0qYFhuZZMo/DeZMwL6hHrub5fpVUUXMBwItNCXZ25HAnZ/X+yBcU9xdqo7hax801R2gAa6rSS5QjmdSrUhfSTthlwUD4YG1BgGWqye5QDc6H4b0Me2mhMo78N8JZSod6NogfsPgem5B2Z866cRsuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714308174; c=relaxed/simple;
	bh=k/iZvRfF4dcBdsWWF77jrzu9Aw/WjqQU12YZsvYi4a4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OJcRmuxnoYc1xMHOSVJ3pntXDydrl7llql08C3VOGczWz2wQe68dthCDdVCIX8ZVmku6SOfMS70SvvUgZgqwY18K7+QyTtFhKJN8nj/XSsdiYD4YvVHy96x64HyNC6UQsGEQMDXLKGGvF3iFUQ00ArKD07zXu0iAU77ssAb+8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cpBo87EX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a55911bff66so444430066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714308169; x=1714912969; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruxM04DcwSqc1+5CUH/yirqxxYT+4VUtJYzmah4p6Dc=;
        b=cpBo87EXt3WMgaxpNN31yxuUx0Rcol8oyoxwM47VajTb3LiRx4pgpBjdeYONHMET2O
         RFXgPINGMoAgUXJzEMHlVDVOE32Niqp5+OBHgouT1zeBajOiP2ncGH2Fr5tg6dg8ABc8
         /MCd4x5VxrTAFVPI6RfUi7T6zLaBCm06WmonKBoPmzSMF/Eg7DkuCKgoCL49w2gZTsK2
         a81yKfmYkE+BVXSddXZva9YgkWioOrifykpFaJvGvnBisaKgvbTbXTR3ZdGRe5v528z6
         Bys94BLFRNBtVkasyOvG8SWtFA3aGygFRGNuWr0ROjJ9ghKQc0v5jU66vm2dEyNAkdF2
         Iwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714308169; x=1714912969;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruxM04DcwSqc1+5CUH/yirqxxYT+4VUtJYzmah4p6Dc=;
        b=uU+M4kuC1rKQw2xGKc2knrCI0wRvRAMQnlBqichqdbk+4AxCDF1fqI7uuf1cyP1BY1
         6abZm4KQNzM8M9WOiYXRDAIAw/IMJAERxYUUlbJjJTBTjEZtOP95/6f0/fZis8cPmfdb
         JQbGiJH+h7P9CG0LkDdatUnku5suyH46UZq3td3YOaL4cpMGZ05DuKCXPD99PTvsGm36
         yBp809PLDAe/Cni2TcHl/kyUQXaZWWTk1ewPbWBAUwlJsvh3wO8Hx9iF37CE3LYSO3Ke
         7RWb9Nh5H/pAiYlQf18/B10AWnmwWIaBmfqH86Uy8P+yzZGNS0rXNxnMS6ZiZWz7oK3i
         DrBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF5B62jELc7G8R3CPbvLvEgAGDDt9qsgEvUs3wcu4xaHwZuoCDGx5hfDGrKEGXYktPYmyH0yCBGUeCXKgAkdC2x9XH0OIMN2mwdad9
X-Gm-Message-State: AOJu0YzF3htJI+QRWBQUuyx0KUrrGmMK3+ucnKk9QLYCSIRfQsVNimfn
	mdvAoBeIjnc7JJJhxeYY0Xq/9ur8aZAZTUGi557R9Hif5MYIqKNKZ/RLCI6QjF8=
X-Google-Smtp-Source: AGHT+IFEmenVCstN3qRQ3VZod695J/pFmJ7LOK2zFQWoDBSbhtYZRvHLRnkehwSsSY/MkO5h5SEVWQ==
X-Received: by 2002:a17:906:a2d3:b0:a55:856b:5892 with SMTP id by19-20020a170906a2d300b00a55856b5892mr2957543ejb.30.1714308169136;
        Sun, 28 Apr 2024 05:42:49 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b25-20020a17090630d900b00a5875b34b6asm6935689ejb.14.2024.04.28.05.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 05:42:48 -0700 (PDT)
Date: Sun, 28 Apr 2024 15:42:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: re-indent dpp401_dscl_program_isharp()
Message-ID: <2b0a61a0-baca-415f-aad4-7dc4cde73ef7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains because some lines are indented more than they should
be.  I went a bit crazy re-indenting this.  ;)

The comments were not useful except as a marker of things which are left
to implement so I deleted most of them except for the TODO.

I introduced a "data" pointer so that I could replace
"scl_data->dscl_prog_data." with just "data->" and shorten the lines a
bit.  It's more readable without the line breaks.

I also tried to align it so you can see what is changing on each line.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 93 ++++++-------------
 1 file changed, 30 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index c20376083441..696ccf96b847 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -779,75 +779,42 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 		const struct scaler_data *scl_data)
 {
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
+	const struct dscl_prog_data *data;
 
 	if (memcmp(&dpp->scl_data, scl_data, sizeof(*scl_data)) == 0)
 		return;
 
 	PERF_TRACE();
 	dpp->scl_data = *scl_data;
-	// ISHARP_EN
-	REG_SET(ISHARP_MODE, 0,
-		ISHARP_EN, scl_data->dscl_prog_data.isharp_en);
-		// ISHARP_NOISEDET_EN
-		REG_SET(ISHARP_MODE, 0,
-				ISHARP_NOISEDET_EN, scl_data->dscl_prog_data.isharp_noise_det.enable);
-		// ISHARP_NOISEDET_MODE
-		REG_SET(ISHARP_MODE, 0,
-				ISHARP_NOISEDET_MODE, scl_data->dscl_prog_data.isharp_noise_det.mode);
-		// ISHARP_NOISEDET_UTHRE
-		REG_SET(ISHARP_NOISEDET_THRESHOLD, 0,
-				ISHARP_NOISEDET_UTHRE, scl_data->dscl_prog_data.isharp_noise_det.uthreshold);
-		// ISHARP_NOISEDET_DTHRE
-		REG_SET(ISHARP_NOISEDET_THRESHOLD, 0,
-				ISHARP_NOISEDET_DTHRE, scl_data->dscl_prog_data.isharp_noise_det.dthreshold);
-		REG_SET(ISHARP_MODE, 0,
-				ISHARP_NOISEDET_MODE, scl_data->dscl_prog_data.isharp_noise_det.mode);
-		// ISHARP_NOISEDET_UTHRE
-		REG_SET(ISHARP_NOISEDET_THRESHOLD, 0,
-				ISHARP_NOISEDET_UTHRE, scl_data->dscl_prog_data.isharp_noise_det.uthreshold);
-		// ISHARP_NOISEDET_DTHRE
-		REG_SET(ISHARP_NOISEDET_THRESHOLD, 0,
-				ISHARP_NOISEDET_DTHRE, scl_data->dscl_prog_data.isharp_noise_det.dthreshold);
-		// ISHARP_NOISEDET_PWL_START_IN
-		REG_SET(ISHARP_NOISE_GAIN_PWL, 0,
-				ISHARP_NOISEDET_PWL_START_IN, scl_data->dscl_prog_data.isharp_noise_det.pwl_start_in);
-		// ISHARP_NOISEDET_PWL_END_IN
-		REG_SET(ISHARP_NOISE_GAIN_PWL, 0,
-				ISHARP_NOISEDET_PWL_END_IN, scl_data->dscl_prog_data.isharp_noise_det.pwl_end_in);
-		// ISHARP_NOISEDET_PWL_SLOPE
-		REG_SET(ISHARP_NOISE_GAIN_PWL, 0,
-				ISHARP_NOISEDET_PWL_SLOPE, scl_data->dscl_prog_data.isharp_noise_det.pwl_slope);
-		// ISHARP_LBA_MODE
-		REG_SET(ISHARP_MODE, 0,
-				ISHARP_LBA_MODE, scl_data->dscl_prog_data.isharp_lba.mode);
-		// TODO: ISHARP_LBA: IN_SEG, BASE_SEG, SLOPE_SEG
-		// ISHARP_FMT_MODE
-		REG_SET(ISHARP_MODE, 0,
-				ISHARP_FMT_MODE, scl_data->dscl_prog_data.isharp_fmt.mode);
-		// ISHARP_FMT_NORM
-		REG_SET(ISHARP_MODE, 0,
-				ISHARP_FMT_NORM, scl_data->dscl_prog_data.isharp_fmt.norm);
-		// ISHARP_DELTA_LUT
-		dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
-		// ISHARP_NLDELTA_SCLIP_EN_P
-		REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0,
-				ISHARP_NLDELTA_SCLIP_EN_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.enable_p);
-		// ISHARP_NLDELTA_SCLIP_PIVOT_P
-		REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0,
-				ISHARP_NLDELTA_SCLIP_PIVOT_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.pivot_p);
-		// ISHARP_NLDELTA_SCLIP_SLOPE_P
-		REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0,
-				ISHARP_NLDELTA_SCLIP_SLOPE_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.slope_p);
-		// ISHARP_NLDELTA_SCLIP_EN_N
-		REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0,
-				ISHARP_NLDELTA_SCLIP_EN_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.enable_n);
-		// ISHARP_NLDELTA_SCLIP_PIVOT_N
-		REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0,
-				ISHARP_NLDELTA_SCLIP_PIVOT_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.pivot_n);
-		// ISHARP_NLDELTA_SCLIP_SLOPE_N
-		REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0,
-				ISHARP_NLDELTA_SCLIP_SLOPE_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.slope_n);
-		PERF_TRACE();
+	data = &scl_data->dscl_prog_data;
+
+	REG_SET(ISHARP_MODE, 0,	ISHARP_EN, data->isharp_en);
+
+	REG_SET(ISHARP_MODE, 0,	              ISHARP_NOISEDET_EN,    data->isharp_noise_det.enable);
+	REG_SET(ISHARP_MODE, 0,               ISHARP_NOISEDET_MODE,  data->isharp_noise_det.mode);
+	REG_SET(ISHARP_NOISEDET_THRESHOLD, 0, ISHARP_NOISEDET_UTHRE, data->isharp_noise_det.uthreshold);
+	REG_SET(ISHARP_NOISEDET_THRESHOLD, 0, ISHARP_NOISEDET_DTHRE, data->isharp_noise_det.dthreshold);
+	REG_SET(ISHARP_MODE, 0,               ISHARP_NOISEDET_MODE,  data->isharp_noise_det.mode);
+	REG_SET(ISHARP_NOISEDET_THRESHOLD, 0, ISHARP_NOISEDET_UTHRE, data->isharp_noise_det.uthreshold);
+	REG_SET(ISHARP_NOISEDET_THRESHOLD, 0, ISHARP_NOISEDET_DTHRE, data->isharp_noise_det.dthreshold);
+	REG_SET(ISHARP_NOISE_GAIN_PWL, 0, ISHARP_NOISEDET_PWL_START_IN, data->isharp_noise_det.pwl_start_in);
+	REG_SET(ISHARP_NOISE_GAIN_PWL, 0, ISHARP_NOISEDET_PWL_END_IN, data->isharp_noise_det.pwl_end_in);
+	REG_SET(ISHARP_NOISE_GAIN_PWL, 0, ISHARP_NOISEDET_PWL_SLOPE, data->isharp_noise_det.pwl_slope);
+
+	REG_SET(ISHARP_MODE, 0, ISHARP_LBA_MODE, data->isharp_lba.mode);
+	// TODO: ISHARP_LBA: IN_SEG, BASE_SEG, SLOPE_SEG
+	REG_SET(ISHARP_MODE, 0, ISHARP_FMT_MODE, data->isharp_fmt.mode);
+	REG_SET(ISHARP_MODE, 0, ISHARP_FMT_NORM, data->isharp_fmt.norm);
+
+	dpp401_dscl_set_isharp_filter(dpp, data->isharp_delta);
+
+	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_EN_P,    data->isharp_nldelta_sclip.enable_p);
+	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_PIVOT_P, data->isharp_nldelta_sclip.pivot_p);
+	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_SLOPE_P, data->isharp_nldelta_sclip.slope_p);
+	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_EN_N,    data->isharp_nldelta_sclip.enable_n);
+	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_PIVOT_N, data->isharp_nldelta_sclip.pivot_n);
+	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_SLOPE_N, data->isharp_nldelta_sclip.slope_n);
+	PERF_TRACE();
 } // dpp401_dscl_program_isharp
 /**
  * dpp401_dscl_set_scaler_manual_scale - Manually program scaler and line buffer
-- 
2.43.0


