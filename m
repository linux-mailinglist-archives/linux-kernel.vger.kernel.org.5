Return-Path: <linux-kernel+bounces-121792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7248788EE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F79B25413
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD815250D;
	Wed, 27 Mar 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBwGLLRV"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE0152171
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562940; cv=none; b=GgKQAoE1SX0QUn53yKw1zVmzy7UfG9O+a1GypFs3wUCpzHktTcSIITdZ0SkqXpmicpFLskG6cYiuF0bhZ4GJtXzqj5FHkKuTkAvUWNd+/mqE9M0fXTfhr3jXEycgnBQKCqCDqQNHu8Ojfyh45NBErSQKdndwM2OZNP9XqoclS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562940; c=relaxed/simple;
	bh=6kdN4bIMMHrZ4SMvrh49Lrd228bzKlbevJXjeVijEjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iaBL7W6OeZfHRnNN8S82FEeWcEk1UxjDUyA7bOe3xIsd1UswbSE2tW6UvfPgd+B+Dw5CG6gepzAws5EU5kUGPO8/xsw8H1g1Bs8jSeE3ErXR270VdmCxEpIH3OqXIuch2ifaaY8IMgnAgOOYQpuEJz7+uigg7NjyVpMnBPTcGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GBwGLLRV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4e0a65f37bso16186766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711562937; x=1712167737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0yrZ/yWAaXgHD2Ul0KN3dDIRFMbDzRG8DuMRaqz9/s=;
        b=GBwGLLRVa8m6haSMEvTbNMUkL+jjFKL1nLdGPKrjVMdQ7IuHF0X1XFCJE3zPGpM3Ot
         FEmV6og7SF1IGUFD9WjJbppOdbsFc5L2K/JQ8ITxfMCM9uU5tjsw+8rXhHK0QhriNghA
         ypb1jJLHO7J7PQ8ODXfm/+jAwce+o1obZNKZuVpTy4FY466I9Si+F8M29c9YCvLCvd3k
         6ET/cSTJPnatZECwzj7vkKh61qRDyu3T1is+jCBCpFU0ravcTN+SmChpfaOrW5iJJbGE
         XCAPxhKGYaU4zrzBj+fF/xvoKuj+bHy2urubtkztofEJjSkH1VRu+H1VPqxSy0vdrJDZ
         s5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562937; x=1712167737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0yrZ/yWAaXgHD2Ul0KN3dDIRFMbDzRG8DuMRaqz9/s=;
        b=FEqZQRQh0f+Q5PQ41cIAQN6ZTnsA9U/IxqPKMlaj8L0GIveihHcwJ+LRDL3V5qNqUz
         ZFEPxZlYZc92b0qyzqClOj4NoaqsMteBrda5UBTtgl2t9/91A2g1blTtqnce3uV/4y58
         zUD0v6SBDPszXgcoDWOXjvZ5FhhdWjFnj8jyLI2hAFyADtU0bI4Oe9NP8YP994NeLnaf
         gq6L8U8AvDthmVmqo4OhayfuAV/p7IHcYu9Eozn/pPGHpcd/au8Wk9lbdndSdCe8SfMz
         SQvmQw+rwupuUByijYEybAhjZXpmDsH8tPKIrgLYN52TKHyYbhl6SijPmlQSbSx5NumB
         Ij7A==
X-Forwarded-Encrypted: i=1; AJvYcCVEeTtIhkbUBsXRUhnLTr5smixKaeGVxrdD91d1xtXCe9v+E9yLR+3jKBbvOQ6MJz6xPxhg2iXeuizCwNrOr5uWyxyWUbQNNM1YtHxz
X-Gm-Message-State: AOJu0Yw3X5VwENhDX7zayar7ew1RT7ivmtu0W8GB+wayTkjYC7fZ/iPF
	oL7CO91aLUc27svkjsGbUHGmihd80XHlpcXRH4g62FEhaPoZr1djOc5NdYeHve4=
X-Google-Smtp-Source: AGHT+IHbdhdIQeAt45jjUho5CTqQerepzE1y3k0TDCgxOb3MaGlCeDURF9i5RvhUzg0sPfbNUeLljA==
X-Received: by 2002:a17:906:4559:b0:a46:4d16:439b with SMTP id s25-20020a170906455900b00a464d16439bmr131713ejq.43.1711562937226;
        Wed, 27 Mar 2024 11:08:57 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709060be200b00a45f2dc6795sm5702733ejg.137.2024.03.27.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:08:56 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 19:08:44 +0100
Subject: [PATCH v3 06/19] media: venus: pm_helpers: Move reset acquisition
 to common code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v3-6-79f23b81c261@linaro.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
In-Reply-To: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711562923; l=2551;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6kdN4bIMMHrZ4SMvrh49Lrd228bzKlbevJXjeVijEjQ=;
 b=CtQR+eHJic5RXCB/ys245BqBen08N508V3dMF9qZepH61Eg6IBXLL/1ibfyDLWYOWndHzKBoG
 Q8bhVnsEexeAaw6s+eU2HvdmvE2TAufRlJPbHuXmMHg7HUvIUP8obA1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

There is no reason to keep reset_get code local to HFIv4/v6.

Move it to the common part.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  9 ++++++++-
 drivers/media/platform/qcom/venus/pm_helpers.c | 23 -----------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 5ab3c414ec0f..0652065cb113 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pm_domain.h>
@@ -286,7 +287,7 @@ static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct venus_core *core;
-	int ret;
+	int i, ret;
 
 	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
 	if (!core)
@@ -324,6 +325,12 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < core->res->resets_num; i++) {
+		core->resets[i] = devm_reset_control_get_exclusive(dev, core->res->resets[i]);
+		if (IS_ERR(core->resets[i]))
+			return PTR_ERR(core->resets[i]);
+	}
+
 	if (core->pm_ops->core_get) {
 		ret = core->pm_ops->core_get(core);
 		if (ret)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 730c4b593cec..5b2a40a2f524 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -939,25 +939,6 @@ static int core_resets_reset(struct venus_core *core)
 	return ret;
 }
 
-static int core_resets_get(struct venus_core *core)
-{
-	struct device *dev = core->dev;
-	const struct venus_resources *res = core->res;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < res->resets_num; i++) {
-		core->resets[i] =
-			devm_reset_control_get_exclusive(dev, res->resets[i]);
-		if (IS_ERR(core->resets[i])) {
-			ret = PTR_ERR(core->resets[i]);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int core_get_v4(struct venus_core *core)
 {
 	struct device *dev = core->dev;
@@ -981,10 +962,6 @@ static int core_get_v4(struct venus_core *core)
 	if (ret)
 		return ret;
 
-	ret = core_resets_get(core);
-	if (ret)
-		return ret;
-
 	if (legacy_binding)
 		return 0;
 

-- 
2.44.0


