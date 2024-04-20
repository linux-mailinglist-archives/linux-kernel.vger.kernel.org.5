Return-Path: <linux-kernel+bounces-152094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40B8AB8C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23535281E23
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9522DF42;
	Sat, 20 Apr 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgAwDREW"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640326ABA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580389; cv=none; b=T9JyNBam5z5KxzTc57HEN+9ZaC5WI6vgvVKJpYwXYtMkWaOLX0Ifs23hPr54rdL4JDAA/jplfGPmCiUV1phGFCTdliYyXk3PF+9bXrlD03JdQWiSD6IFgijSmBDrSlLpaQbopw0RY/l7IDMd4HU4zJfLS2xZ2aylXE8SiMxwh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580389; c=relaxed/simple;
	bh=htOhpHZqfkaNIIMsarbteDzLLXhNLKYXxH4xJldHcHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFuN71B6BjjYptLe/iTVPs1WyF2d4qP92RmzcLSzWc623QR07VwTPXLyMTxjEIaZp+jscmzXZ+6LLDOY2+/1G1+vLs1JFiZ/lgOqAIRrXWobjNuRO8cUYCTTuyxqnjSQ3zoeZXmXWsMM9YByOzo6lgLunt6KyF/OPctVV1dNwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgAwDREW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2da88833109so34496751fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713580385; x=1714185185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJj0NVpNzcIA0CNg6WrohgI0V5laf6VHve5Qp9ZoIKY=;
        b=xgAwDREWNiD/8rcJlSV6wy6FpTAQnJF/NNWIKoSa8I5a6THamxDXturEq/iS4Ur+Mk
         IrJ4uhXst9FpX1PBrvrtT/+RwLmSNeTf31oOCKoC35NUNa54kHanlYPOaNlZtEFNsky2
         t0XYKOKRswRXBpO6Vwg7G1QTkE/MZyNWQaXHH3jVP1mxg2svvYj8L1+nICOdboP6SGkW
         bVkZBkAZgLgLh0k3tl6e+EHmd0LqfC0ku6yDyKp3eRLQ2Kfj+ODdZHNz7exudptujpmO
         h46BFteaYIC46rAaoPdXy+E1Nsfa+du/5SE92i/u/q0a4mReZPgwdexivMKaBaHl1miC
         +btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713580385; x=1714185185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJj0NVpNzcIA0CNg6WrohgI0V5laf6VHve5Qp9ZoIKY=;
        b=p6zOjVRbHbT5YmJDN4+PgJpThGef8vt0VnO/YaiKyBVEKw751Y/xfk50K40O6I9jBt
         uvRbwZvA2A7UZFf3pDhBUf5dEHwe5fjbtMTX+VWnlqKqPgInXWyaIZhwcts/CdmkJBRr
         398iN5zsyJo7Oykxfp+s45cXHm7hLaEp2u79Ue0hzWqYKRQqr/MBEzsNuF3Xhl3Sg724
         xhxF1j0tp9yLxvs7EYBRHeXD/LfB9hjJ7RQGFcqlK89QDh/l9SX/H5tlA6MYutNQ1Llg
         jqlogTIwfKWG4V7yzvJoO3VQTkRkB6LRkpCqfh8HQkEXK3Olu8bAZCNdzipexbh6Hjtr
         nR1A==
X-Forwarded-Encrypted: i=1; AJvYcCXK1X7jWQmzFrrxW5AebV81qWPRMfprjbKCpUFeRpkxYqd3EYPSulrrW9XgEDIDLzgj1S3r07VyUiqsaFyfa0ZYExYHkmaHLOHZqGcU
X-Gm-Message-State: AOJu0YysIlgI8800k1TrC1nmytKaT6A3o+aRc8r0jvYN2oryrIxB2uzV
	eqal/KQ6A79b9quZucVWqgbSdAMV7YslY/iKrMC/UYGWM0PBdXsm0A0TtiMm5v4=
X-Google-Smtp-Source: AGHT+IFNtmgoAN9iJrlmraQgNVX1ijFC+HQJZ6EhK8prwLKNP2A9W//3plzTMOlbigeGs8o7w/FVXg==
X-Received: by 2002:a2e:97d7:0:b0:2d8:63a2:50d2 with SMTP id m23-20020a2e97d7000000b002d863a250d2mr2556913ljj.6.1713580385656;
        Fri, 19 Apr 2024 19:33:05 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 20-20020a05651c009400b002d87e936833sm836843ljq.125.2024.04.19.19.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 19:33:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 05:33:03 +0300
Subject: [PATCH 3/3] drm/msm/mdp4: correct LCDC regulator name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-mdp4-fixes-v1-3-96a70f64fa85@linaro.org>
References: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
In-Reply-To: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=htOhpHZqfkaNIIMsarbteDzLLXhNLKYXxH4xJldHcHM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmIyleo14FB77/xwSYYxgiMneE+ot1fDNFIjmne
 V8/xay4OceJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZiMpXgAKCRCLPIo+Aiko
 1fkIB/9jw5evFcz1CLYKLKgH5q4mGwLaIQyHv/tH6iRQFvR6xMI6/TmOexRXBFy+v6+vCaahyro
 Iv9NkjDwMYQsIX59E8SAk6R4rAS9yvbzer0Sk3SUgRPP5qWlmqYq35vvCBWGJ6zO6iTZh9A96Bf
 /+pD3nlkklNK3V9dh1BS8FNZ4FJ3shL1uSN6vlLuOjZmC9vqNmo7K39oyK2nr4S3/1tdLvHYuwM
 dTV7eE59SkZxB6YFs8blC+vWpbpF5QCitSCjuUOs3HRnGJDL+A0pwBJ+BFmhN2lkfBuVZJkY8Ts
 VdLU9Igta71TP8G2gE7I/OMx4WhznIJ4nIuLOqcj+8Shq+wt
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Correct c&p error from the conversion of LCDC regulators to the bulk
API.

Fixes: 54f1fbcb47d4 ("drm/msm/mdp4: use bulk regulators API for LCDC encoder")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index 576995ddce37..8bbc7fb881d5 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -389,7 +389,7 @@ struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
 
 	/* TODO: different regulators in other cases? */
 	mdp4_lcdc_encoder->regs[0].supply = "lvds-vccs-3p3v";
-	mdp4_lcdc_encoder->regs[1].supply = "lvds-vccs-3p3v";
+	mdp4_lcdc_encoder->regs[1].supply = "lvds-pll-vdda";
 	mdp4_lcdc_encoder->regs[2].supply = "lvds-vdda";
 
 	ret = devm_regulator_bulk_get(dev->dev,

-- 
2.39.2


