Return-Path: <linux-kernel+bounces-66514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4D855DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926201C26CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDC0199AB;
	Thu, 15 Feb 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZJBTARU"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531A14286
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988838; cv=none; b=SZHEQ6sHgPC8QPhD62539AnwnOctBE8IP3/nn9CadKHitUiEktEEwapMIaYWh0litQ4aa6Ju5htdZrJmHmKAEMfJpmo+ZGwGOV69RwO3L1DRsoCGaPS/aYW4lh9orXaVvI2AJlza4YwUq33nXoAJG0sR1e+za5Ur4ZShz53orxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988838; c=relaxed/simple;
	bh=yo2bcPgq0Ry4Dz1DgWE+noJk1QUbw0wPoiksjLdYOBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRijS1XEWKiLY9hD8Ihqm13wl56sX289YHu+cWgc+y0KRxfvwctob/sQCBrtpmyEUW3gCTGMs8X8YFi4m0+P185vPGtDUzihivfH0FEimIQArWEz/9rR/bNFsHWzN1h2cdIcrV9ZvLHHlVbQUaN+KghGk9KxPoGf9nHkq5obeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sZJBTARU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411d231ea71so5022665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707988833; x=1708593633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJagULZ78/2FNiklIv2V0yaJYekfWzVBl7+5o+wg9ug=;
        b=sZJBTARU6ztM5Gke4bQOBPOZX51bxcb0HypOqODWdtsEoB2afwQTciB6umGFyghL7j
         BDppjI2/4vBdUwwY/FyWnDNkbCMkB7ySg7kvP3N482pE62m7Ygo6sop3+c1y2Dc1FitX
         kRlsUNkghcKUgpY9tnyfyyCqrMlnX35SHNVfaD3ooV9dzAhiGVfHiPVh+gCixxK4lmu9
         XrLqTknn6u6/eFwaYtqCiQ7guWIVaY3PSLSMUVfedyprTqQD8T3qOUjoHiUfiTzS2v8h
         gNMz3MBtXBAG9YX0UF957pI2SVXSBaqTHVjHTzxhCt9okKrxXKjHL84uyyW9OBjx8mZw
         sUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988833; x=1708593633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJagULZ78/2FNiklIv2V0yaJYekfWzVBl7+5o+wg9ug=;
        b=Cm4ud84BEHa27QjRJeGoGHUNB9WruN9cNTBtIftEyEkf39zEH8wHt7ukbbJTYtVLHm
         tpY8v545ppn8gyQcg6H9E1tfYfmRwm13zlvtvxK/lqo/rYm5/0uQqPLUcthChj23bLtj
         2ZCk1q151vPB/jCciSTaDJhI9qmBsC/0ejUoSO+J6ZwC6+Mxuog3SpoAfxZ9RUSSY6wg
         tNGUWFCaWqghPPBVGCwLwoBrlj0nHok7uGuVa9olJOs35e2U9p0u8LAM9vNLI8SLE4mR
         Ox+ZoAg/a1JOczyXkDK5oivDMom54ScdABm0Un+VfUez/quXY4lpXzN3Smvq6QotcwNM
         rT0g==
X-Forwarded-Encrypted: i=1; AJvYcCXhmhtCjzPo/8RINnNGhjvKikbs6HQGJUgKklhr/UqMj4GcfazjdUMOBM8qTzHqaMohYGj6+k4pLzjCdF1iU0E/og1J3ZzbxiZcssQo
X-Gm-Message-State: AOJu0Yz18MK4kWm3G+UnYttyhqKz85BXzskOJ4o2AGpmAV3Xj0jtNOCI
	6u2ETh+yNpgkxb5PaCVMAKD9VmFpqXeMEgYBe8+5/P05m2fq3RSm/+DREBq9org=
X-Google-Smtp-Source: AGHT+IGp8PMtl4/BQOIm+djYPcum7f8RPFzzwdqiXF8XlH48cA5EQ/oqgfoCl+h6vhKoGtgOFNP4gQ==
X-Received: by 2002:a5d:6ac5:0:b0:33c:e29b:f5cd with SMTP id u5-20020a5d6ac5000000b0033ce29bf5cdmr1177257wrw.24.1707988833298;
        Thu, 15 Feb 2024 01:20:33 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b0033b66c2d61esm1156435wrb.48.2024.02.15.01.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:20:32 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 15 Feb 2024 10:20:24 +0100
Subject: [PATCH v2 2/6] dt-bindings: arm-smmu: Document SM8650 GPU SMMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-topic-sm8650-gpu-v2-2-6be0b4bf2e09@linaro.org>
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
In-Reply-To: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
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
 iommu@lists.linux.dev, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yo2bcPgq0Ry4Dz1DgWE+noJk1QUbw0wPoiksjLdYOBo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlzddbAVFrIBQkQc8wMo3rdp9H43W74Ogf7rPLLvlB
 Pp2ObIuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc3XWwAKCRB33NvayMhJ0XWFD/
 90BnRPN6dApDP/mf/zTfMk+WPjxCgiRKD9B5wOVXHmserUOVv4XQjNbeSnmKiPHIrlA2diwPMLUQW5
 gldygkZKP/cKbNfC7aXmrDV3kzll9YnfrIfR8V9Ofd24GFWdevVhfZK95UCROl0ETK5LsWizLKAcPt
 1ASrOZziaNSQOIH7ROV8AszH8knJdYLs8AzIzc+bpGYwJ2hHwI9rAcksVDZJY1qgHvR4mO0Y3ygS9t
 kErNXLjvPAtlytDCjUh9GFFft6IZoF3Tq50VcYk8e73pOYDH15ke9huAPevApViaQZfhMgMNlEvS1g
 HKpxQ7NSWSK3Ht39GwzxDw7JBh7U5pmU8f+0DJq+QS2V+Cjjns3L73O0u+hujvD1lmE+23PmuEse9y
 IHUTUqD0w4Uy+WGigKDnMcj7sbh/a4Ij3QUnDU/U8PO4Dav9d//50iKe7xlYIkbSmqJ19MSq2Z2R4j
 ifQRWVp61pZGXzF2w/ET1xRrK45+YUffB2vkPO2USc20WFM505lX4gOP9yLOkirH/6T0u6Ew9nZOTv
 prdfEyL6z6l9L4UDPtA4AqdpbfmIUJrzpHfkKoHkjhzKgJmYwQ8dpfbz0zJvH7Aos2R1MItpDpqvUY
 7+ez6OVQ9TzbkKl9IESBxQACvj+aXm16MisovuPwclaI6Ip0zlL9qsMBs31Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the GPU SMMU found on the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a4042ae24770..3ad5c850f3bf 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -93,6 +93,7 @@ properties:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
+              - qcom,sm8650-smmu-500
           - const: qcom,adreno-smmu
           - const: qcom,smmu-500
           - const: arm,mmu-500
@@ -508,7 +509,10 @@ allOf:
   - if:
       properties:
         compatible:
-          const: qcom,sm8550-smmu-500
+          contains:
+            enum:
+              - qcom,sm8550-smmu-500
+              - qcom,sm8650-smmu-500
     then:
       properties:
         clock-names:
@@ -544,7 +548,6 @@ allOf:
               - qcom,sdx65-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
-              - qcom,sm8650-smmu-500
               - qcom,x1e80100-smmu-500
     then:
       properties:

-- 
2.34.1


