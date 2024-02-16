Return-Path: <linux-kernel+bounces-68482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83417857AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F01B23B93
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3A59161;
	Fri, 16 Feb 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUvD8H/0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A394758133
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081440; cv=none; b=A9nCK6+dCD+NMLI/SRKDLabYP4RVywZwMzZi9IxpJCdPC0F5W+l4DgbgIvvqJso00+mLaAwh6w2Xi7a7wV1Xe8m+lYHWsa4pmsz6LSvFV4FmkDmSi5G6uDAc5F6XTGfmluDnSsE2RotQEYz8QObh7hPc9a70U3z2EncEZV5OzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081440; c=relaxed/simple;
	bh=bKSwIMquL3ldQeZEbQDg4MhNZo4DD2FIt5FqyCH+Nw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6K2jvRofonByeL2ZbqgcC8kPYTIlwK0v/U4ehS7H7cbyCipDMRN8xBgkeTUPkKAvCja5fKm3JzEgcPZz2lWj9vflcjF21AcRfDCU9OBSnP3dYR16KbJ/pKdTwuK/zLHUkaH9INT2fnFYPyERP+lKQyZ8rc0qlW7CctUse40EWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LUvD8H/0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4121a8635a2so12178805e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708081436; x=1708686236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWxHJkBPvh7dfzfYkfpsJVh1kKWdDbAwY9dahQR1fTQ=;
        b=LUvD8H/062QGeSIqWrLEQKcJ8x0YYWPAuNtYv8DRyIWdDUNCu21KIIr5Ok4l3xgQC3
         XfxJyypeo/femfPrkFkYBwFQ1lXxNpIRnHtssNSAIUCEes7ASmN2P32dTarxXPS58yaT
         goCPXP4Z0aTbUiivvC9TX8pTv3tt2ZoTxWBgNXNwHJwSvyVJSK5XnZt4ekjzvSMbOKPB
         3WOeCi4st5PTuhpV2p7BoH/BMmKmy76uDlYPXfohlPl5Pr0TKsz0OafuejXpzvazoQMt
         5y5N+R+kOdE8AcY87UZzHwGknbJGdlLJfOhYVmTGCBca8AgBEPXYLhTjtAaGUWrvoKkl
         E2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081436; x=1708686236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWxHJkBPvh7dfzfYkfpsJVh1kKWdDbAwY9dahQR1fTQ=;
        b=pFNX78oxAI1bVYBdmb4CEXgB1zeLLapjyslwbihIzFrzHo5hLYDVz+zufo7BOQMaqw
         tHnxnRpDmuu6PUpyORg/s382kXmcrfZlZpRNKuuiuuG9X43JwC0Xb8V0hTQrQjV81qWV
         CqMRM/xYR/aAEeW5rNrWFV/trb0+Q0dqfrXGndZxi/e2v+Az8RyORqmNNCyznmgt2+G6
         HVW/R15LMgueVb3Peb3bM3NCFn6UYsOCvHoDP6CNrzW1bm3p+aKM9JiW6mESTDpd9jxX
         Cn92tDB7KWfG1vT4jQqqNCxhB/h63AdiMzwY+ChypB/PU1UK12jJyLvSESXelq2I530J
         nTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUkMdYYgghjaJV9lRJkx293PLeUjbdHaJ3owHF121vQoLj3CmNfkPVGuPe+z6ChkirpxtJLhdO0Z9lUbNeW6gZ6LEy4zfEpsX11QYbA
X-Gm-Message-State: AOJu0Yy+bogCs3iJWswt+8Jxlwx1Bq6xnURXhzP8P9pIeSnGERzkA9H0
	VgH7W3zNdwSEpUxIYayK9zoJ4er4LLu7t0SENVTqoh4s2ox4kkxPN4qyvi7O+ow=
X-Google-Smtp-Source: AGHT+IEibQ/Igt+OBTemdGFhAzHNU82OtjS01cgsM+Rhg5xCut32DRol5sAh63j4m2MM+BVPWD1pCA==
X-Received: by 2002:a05:600c:1f89:b0:410:656c:d6d with SMTP id je9-20020a05600c1f8900b00410656c0d6dmr3225887wmb.18.1708081435852;
        Fri, 16 Feb 2024 03:03:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b004123b049f86sm1993174wmq.37.2024.02.16.03.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:03:55 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 16 Feb 2024 12:03:49 +0100
Subject: [PATCH v3 2/7] dt-bindings: arm-smmu: fix SM8[45]50 GPU SMMU if
 condition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-topic-sm8650-gpu-v3-2-eb1f4b86d8d3@linaro.org>
References: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
In-Reply-To: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bKSwIMquL3ldQeZEbQDg4MhNZo4DD2FIt5FqyCH+Nw0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlz0EVlZtPi8kLuM8GFD/opq53aRjm2jON3EvioLGw
 Pp2Pq6eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc9BFQAKCRB33NvayMhJ0eJRD/
 wMuGubcv5rl5NSZDd1jyjLXF66wVusziyc0Uj6bd6emX+Y5vX8RUWtEKTpyuOGzPk90izPMId0UFzd
 z9OcL+cud177MKnZ59fRzF2Ceas8GdkdI4TKwhvW2c9NzmPb/k/wDQHKVfRlfAPfoHCYJ+Yth/tDeM
 aAWpW2YY7srWsK2LY3uOFMHHVDRUvJgIPNZMxgu+m68UpkxK4R+r1nTOPgYD5DDhUXSts8P6PU1r5q
 bLhP5LCD/OzJQTCo5JOI/FVtFTIY9neCngCQnQQoBuu8g0NXlq2hVCtrH2Q8EK5nIMxony8Px1fJVp
 1zhgF7KvBPOv8+ZE5yAs6qEeUaca/GMh6iaQ1eH5voudCNhtlCNllEiuUcH/eWexoqVO96PSjg5h/C
 6UBqp7apKCKtQjCbUU1L1aXsdHaJWKL/elXvZGroLEZW8hXjWR+03aD0RwKN9/efIQjhReSzKyyFMb
 hxLlsCYOdsAmYwoY50+XOvmZZZ8+tfAM1RHCQx45llmq7HcYCg4aypDnMYpAJIOTKjJzI+LrVZIFlk
 5+DQbwIN7Ux0ULMwAjTGy69f0f9Ta0cyOs9C3QoAeXrGH8QVgxAEJb3uWYCCfs6vds6LHDr6c1wJx9
 GS0yygCa534u2Tc1Y2EdlZgGus1HblB7dz89fVvGMsFZlCXZ3I8lXguGKIYw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The if condition for the SM8[45]50 GPU SMMU is too large,
add the other compatible strings to the condition to only
allow the clocks for the GPU SMMU nodes.

Fixes: 4fff78dc2490 ("dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a4042ae24770..38c48131e6e7 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -484,7 +484,12 @@ allOf:
   - if:
       properties:
         compatible:
-          const: qcom,sm8450-smmu-500
+          items:
+            - const: qcom,sm8450-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+
     then:
       properties:
         clock-names:
@@ -508,7 +513,11 @@ allOf:
   - if:
       properties:
         compatible:
-          const: qcom,sm8550-smmu-500
+          items:
+            - const: qcom,sm8550-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
     then:
       properties:
         clock-names:

-- 
2.34.1


