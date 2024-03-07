Return-Path: <linux-kernel+bounces-95234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE7874B08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF55B23E53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF183CBE;
	Thu,  7 Mar 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYXndIMM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA57839FB;
	Thu,  7 Mar 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804251; cv=none; b=q3AFp5/3dq0oDlQyd0LPufIBmQUPWi3POnB+WsMEUzaFhpBi25SobT7wOnehjLrPJdA4gjXQ9P5W7MSXzq9lAhRbMSKrmJq/5BezVVlqI/sDc2JiYD4J3mOrZ/RP8lVWr93FRykn2/aybzmmLOi6LgFKgq0/CeOS64g3uRNK52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804251; c=relaxed/simple;
	bh=KbA38Ez7VtxM30+T3uVG3G9pGCGRaypiLEGvKLOb124=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OWoLB2I/Wc/+oQ0qn+F55U/DOZRFjDU0+SlPKWTXcII9v3hEAkH4BqkjSUvRwUKrTbAbEFv40h983l2ZaZUQ8CPFG7PEeuuXPdcLjaleyg0NKkOusZPgPh7BaM3dMH6Z3pPhigqhADDEfWjaCUyEoq6G7IqgfUKg+OBx00h15h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYXndIMM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-413007fe6a3so5963505e9.3;
        Thu, 07 Mar 2024 01:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709804248; x=1710409048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCGSUBoz7hkTWog5vBebF9UgG8HPCPhDFefPQRO1q34=;
        b=IYXndIMMHwsd3eeo3iUCyoOAMA9ChALUPtZePj9yEnZWOQumGIpTNxGNCbhNNQEmYY
         aQeFtnr6LYk0bMmSnuPs5q2+M2joystMQr4+lGIf2kjbuQolvN06jr2ar6bVvNraMHmh
         HJiVGG6f9p7XaFq4mxvEG1xTyuXvanCDQFUW+EFry+nXNEansy0BZQOxZTgiuHR8HFRe
         UkqUwJMtKcDsB/WpnPg/byUBra/A3aTPS/X47d3/hzZ1v4xSFRefs7icrTIox+txGFkx
         9PzJLxKQYXsAHg936/OoARl58XnZsUqA/K78Z27s45Y18pccoEi0yHqmNLOke1DcA09n
         UxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804248; x=1710409048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCGSUBoz7hkTWog5vBebF9UgG8HPCPhDFefPQRO1q34=;
        b=iDZBmofjbCAh1wvhMx1FwloEIR1WrlSZfRLKnXEzT7iuvFjJ28/Aa42Zt37Z9heQ0+
         vd5KWM5oFWxiccWXzDTu9AwlT+M69Vr6FXYfFbJ/dD4mvrAoKqJ691JaTMxvv2vu1hce
         o/RADqkZu0zl/Vp6kLBYfW/m9BNY5Y/Ckhe0m3dpvC9p47Vuy5wt1mAb0wTqSNQL8zbQ
         CP3p/7ZLQADtkX6AWDiAJnrfl3rahdjTITasCZwvk5cTXQDtQkAiBryWrBBWNI3fUW77
         +OV92tj1BuS4eL3zWJ1tFFXtMzlJj5pOfEZF0Fy5LEE2lAUgAR8GM8PmjGVquuMbpqfn
         y8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB0Y1U1dntjjwhdDrQ9J6YEK0e7W4eDS2n/bbcuxQ7m3n0IQIwKAUnDfjpDX8oO36s4oNeEMzIecJqVHXZZOl7bexaphKOQMiPAP896kTeJmK+Z3YaJb1eSPVRv9UG2uhxsPhiDwtMJCmZhg==
X-Gm-Message-State: AOJu0YwSVZbq40ivxSQY0Wilf60Mx+GRcma+IMaVuGyRFmJiCKkEL3Rl
	0Y39bj7R4t1vtnrhOCle3T/HEq7Fg6k5XpBRrHP3upybCGvOV0E1
X-Google-Smtp-Source: AGHT+IE8RizOzmSDjEf4PsBNhWryLujYdRAkPfhGtCn7+tuTX8NXpG2EQMCqSC/G4cmzXNtq0f6k3g==
X-Received: by 2002:a05:600c:3b26:b0:412:e3aa:8f69 with SMTP id m38-20020a05600c3b2600b00412e3aa8f69mr8126669wms.30.1709804248388;
        Thu, 07 Mar 2024 01:37:28 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b00413074ea471sm2073513wmq.31.2024.03.07.01.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:37:27 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/msm: remove unused variable 'out'
Date: Thu,  7 Mar 2024 09:37:27 +0000
Message-Id: <20240307093727.1978126-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable out is being initialized and incremented but it is never
actually referenced in any other way. The variable is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: warning: variable
'out' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 1f5245fc2cdc..d4e1ebfcb021 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -840,7 +840,6 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
 		struct a6xx_crashdumper *dumper)
 {
 	u64 *in = dumper->ptr;
-	u64 out = dumper->iova + A6XX_CD_DATA_OFFSET;
 	size_t datasize = block->size * A6XX_NUM_SHADER_BANKS * sizeof(u32);
 	int i;
 
@@ -853,8 +852,6 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
 
 		in += CRASHDUMP_READ(in, REG_A6XX_HLSQ_DBG_AHB_READ_APERTURE,
 			block->size, dumper->iova + A6XX_CD_DATA_OFFSET);
-
-		out += block->size * sizeof(u32);
 	}
 
 	CRASHDUMP_FINI(in);
-- 
2.39.2


