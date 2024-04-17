Return-Path: <linux-kernel+bounces-149157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF98A8CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6573528713F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8CD174EED;
	Wed, 17 Apr 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWnwi9PW"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2117109B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384197; cv=none; b=LRhHPhvzl1EPcivpdhiszUPNAVFHujd5IdZJRmHZ4TjX5zhR2GJdMXEJX12ga92dPkhJTunYsyMaMGa28g+bIS7njd11uGxKmcfZo2QgefWnWeuA/8Q273oCnZ3npS1OzlNUwNYufUnML6IWJ5Ux14Yl2Py8a1lQl+JeS2LTKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384197; c=relaxed/simple;
	bh=7hn9yWc0x+ZGVLx5RkT997HsicwrF9htKGIWH4IlDYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsbiqH5ufhfzgGJHOFh5Lckb+HIo7wWZVetUCBuowOjbKrd+1DBxH9s1qeGFveU7jTqwJP2x2hCx90UK+7WQooBP6BPuQTdXQ1ST/nDVbV70M/ktPGiTFbbFEz/D3JTFFktsqGiVsEDbV02YwXdled9lV+OfQmfGa5lWxnAsSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWnwi9PW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso85344a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384194; x=1713988994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ug4Rbf1oUs+Ggz/DgrdHVTQ5VxhiXHJ5sy7PE+JibXc=;
        b=IWnwi9PWBiXJlR/q81ymc74xt6FdNuwLeX1CtmN1feVVJD+hEU09qsaKElX1nUXY68
         Ja9jCBMDTcJcVBH/q6sTyTWJDRE+TLLtduPib5r/H7b0G43oGxVKh1j+lJiVtNJooXUz
         1Ghopy6VYJEbcXMLdo/fdcbJF/Ldln7T4lblP6wJ1y4vbAjcNero2/XK84GjkPhIjI+0
         oFPRqy3FSyIsNbiG10wjShqnpqr9JYffQ/9eVvtNz0ma56tteferMWCJ0hXG5lcvmMCf
         eUoxPYLa2qTXj6VoGgg7m5e5W2Z775YH6OcYB9muxhwJqGr/6nA2HESxN4Q69lWVOoVF
         sqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384194; x=1713988994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug4Rbf1oUs+Ggz/DgrdHVTQ5VxhiXHJ5sy7PE+JibXc=;
        b=YEoL1O7oYQuUeqlMg0RH5bcZhSl7ah3wF+zSOxsWNj1+afphLZ2Y8J4sCCtvMAdT3x
         PP7PwystdT6ywHskCvUa4Oi5qq6W5lfBC4ePlczvJ8sMOPQIfjx5jBdFkP+dxK4b+L/X
         M53hg/xyjOreOdI1p3oIq5aaBlUH1VR/d1uER97dHu5WDEC0GETjb1au1kv7ISYPaWBq
         wX0Bfvx5lGFbyIcTZu3pRDco7o/7Xj/CjoWhNJVZWKf7O45tcFwo8625DHqEN3c/9Trk
         Ov7kRRljHeQPcZ3gyeAyqVBV2fNNavOOC01prX8oaNjp/CM37Z3RJhmLFBinSVPBmaXD
         CJBg==
X-Forwarded-Encrypted: i=1; AJvYcCUsQAZvpP4fVO/VsDO/ufpo1kVGpgd+sWAUOYpO+eEkKdtJmNcKlWzwBgu04oXyT42PjAkiOOKD5APfnPmLNM9G3NcZb6uDo+TFUNAf
X-Gm-Message-State: AOJu0YwtjAGMi1w+nef/LPIDhsQEc3fZVWgLj21dwj2weFzBpETSo07C
	QSpp0FzUwWyqX4sABROt/DiwLSmR6obj0D/WUYyhOym5q+WXIxANtCuqjkZsz8TC3iu4LRhJi6H
	N
X-Google-Smtp-Source: AGHT+IHAyZr9H6TbxvORNTWmvyh+uqcRd5+zUK9vvdjV7xAkunQuJVY/6yEPaz70LpbJ+kjQSWci8w==
X-Received: by 2002:a17:906:4f8b:b0:a52:613c:e41d with SMTP id o11-20020a1709064f8b00b00a52613ce41dmr308193eju.60.1713384193603;
        Wed, 17 Apr 2024 13:03:13 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170906fd8400b00a5252e69c7dsm5905590ejb.160.2024.04.17.13.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:03:13 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 17 Apr 2024 22:02:57 +0200
Subject: [PATCH v2 5/7] drm/msm/adreno: Define A530 speed bins explicitly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-topic-smem_speedbin-v2-5-c84f820b7e5b@linaro.org>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
In-Reply-To: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384181; l=816;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7hn9yWc0x+ZGVLx5RkT997HsicwrF9htKGIWH4IlDYk=;
 b=upTendAZvVn04hs77lbaX9iwU13uA6OdwVPVHomF4WSNuRbSnxxNQ1VbFLsXhTSlGKv7MNqC7
 HQN2Vlx8QvcClRxHnEl2kd0FCEeFyV/7u/F1K1YX5Tfvmb7mMOtuxN3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In preparation for commonizing the speedbin handling code.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 3b631445c541..53302995fc81 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -258,6 +258,12 @@ static const struct adreno_info gpulist[] = {
 			ADRENO_QUIRK_FAULT_DETECT_MASK,
 		.init = a5xx_gpu_init,
 		.zapfw = "a530_zap.mdt",
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0, 0 },
+			{ 1, 1 },
+			{ 2, 2 },
+			{ 3, 3 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x05040001),
 		.family = ADRENO_5XX,

-- 
2.44.0


