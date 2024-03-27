Return-Path: <linux-kernel+bounces-121802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB0E88EE20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C21B25963
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82699154441;
	Wed, 27 Mar 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShAPU6yN"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC884153BF2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562961; cv=none; b=dxAMQd6QfR2l6r2nSIv2wdgpXHlFu4cqVwd8tLd3joV4DJnx8z/Fwy74bGW1aZXRYiUWXkjjnmmF4R7HKfT85K5QvHDaibrkrL1zID3HBJ3DfbiJsr5Swo0C6grDSstUnjy7xFULJ+dO/TQbPdKHLazROEMQMpJZDTXPWeJB1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562961; c=relaxed/simple;
	bh=rfeCKF0TDJxow2k4V6ytPA8cst5sc8C0h2kYpOgo/rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2XGEnuW7ZZ/bztRd1n5vv6GZfuvE00TIAbALodiXwOG5t1sQbAaoz3LHr2Jfv8CzlvwTPksb/L4uFOXZZEri+9FYj8tO/KgnySore6wzfZTl9oMc0ou7jlSEqrEUxtCZI/qBSzgMspNsFDH2gHV5anfemgLZRVKtJmYpDx5khM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ShAPU6yN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so166579a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711562957; x=1712167757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hgrsUJ/GR8AiL4ulZYMnT6DC/W7yW/8RHSfzLSDdCI=;
        b=ShAPU6yN8vndh/cLbeJZMqJoFHJCPKrvBd9UM0Wbzx52l2Evh60L+fvmVxn8YM0PmA
         SzGWV4JrQR5RJSmq8VVucJj4bGwuNGGxB5WHv2CCNiCmpA6lGmRUgjl3b79h9irIfYai
         5Xi2mEN2mhBuG3riDZuF3chWl9mV1hJae2KJzjHRlxlo4H49Ni1Pkdtzvn8uDx2T/V0e
         w/w85vyNOtKcgKm8GlwDOXkm0vfCmiRDtbPi7VIyn0jE/8SLqpiniBZ1zp9ApuCprjZu
         5IbFi0y5iLpm2Bvd71wFQ8Lw2+6zn+mtWx5MBaNSosHRf7x2h2hAkv3L9xGHV+quERlF
         xyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562957; x=1712167757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hgrsUJ/GR8AiL4ulZYMnT6DC/W7yW/8RHSfzLSDdCI=;
        b=snuSHIHSzcR8uFW8gdRvHaSJY88Dxd2RoikW0P7nYUzL1qNQcwbXxNT0z3uamY6YpE
         d+cguHs9J6YzlhFZXY+50n0qjBO1/vmRLx+Mj4zTykhYBGNZabgl2VLG3kWBFfsVo4q7
         zuJOvYmN8TWLqYOQhVlh/8FPyzIAqWcLRWDdngsejGG8hW4Y4XTx3i0BE4bIUFRvTG+f
         hqR2EX+x1n9+ChOyR0+T5XkxyfuFRrlucZg8D1Fyv9pJTxzlc1qRITUo2xHAJhTTeCgx
         MW/ypvimCUH5CXQOcvD72sM8BdC6GEw8YrQo4LJSanQrH5ykBM9aL3/D1ut25rli2XgQ
         fwbg==
X-Forwarded-Encrypted: i=1; AJvYcCVO6gzhqZ8Dz448aQF4V163MH0P+FEJm3hXCnle62rFyMaC8rWQ7PS52WhbStH2zExf7nPL+nmwEdeXshU5ArXvv5LuBVJaZFoIbwT8
X-Gm-Message-State: AOJu0Yx0V3qSI44faWBeMhaghL/wlX/877WbXboBwlKM2AXgGLKhmqah
	4jcjDMYhPZjg4QsOWr15R67LJR2PkFi8Y68KYYAPDTa+Rn9cpzMcRKSmiS+u0Pk=
X-Google-Smtp-Source: AGHT+IFOo4sFmtLzwbLXP0KtVDvk+1I6H0+uefuNN51KXyk92++u2x6hlx1B7phPd+BPI28GFR3vGA==
X-Received: by 2002:a17:907:7e94:b0:a4e:f44:f73e with SMTP id qb20-20020a1709077e9400b00a4e0f44f73emr258584ejc.13.1711562957265;
        Wed, 27 Mar 2024 11:09:17 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709060be200b00a45f2dc6795sm5702733ejg.137.2024.03.27.11.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:09:16 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 19:08:54 +0100
Subject: [PATCH v3 16/19] media: venus: pm_helpers: Commonize getting
 clocks and GenPDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v3-16-79f23b81c261@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711562924; l=3311;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rfeCKF0TDJxow2k4V6ytPA8cst5sc8C0h2kYpOgo/rw=;
 b=8KXAuuvGmO4WCVHnBLB5zdXP45qg+FE3jQHPKn1ZAnwRK5Q0Ij6puORMMO76D+9TTLNhNwuYI
 GEX9ukAJMclCBi0uqCujkCl83LSgnomFNnzTlQ3u89RbNnNUJPkwvEu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

As has been the story with the past few commits, much of the resource
acquisition logic is totally identical between different generations
and there's no good reason to invent a new function for each one.

Commonize core_get() and rename it to venus_get_resources() to be more
meaningful.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 8 +++-----
 drivers/media/platform/qcom/venus/pm_helpers.c | 5 +----
 drivers/media/platform/qcom/venus/pm_helpers.h | 3 +--
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 1f4a86b1bd73..6914fa991efb 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -334,11 +334,9 @@ static int venus_probe(struct platform_device *pdev)
 			return PTR_ERR(core->resets[i]);
 	}
 
-	if (core->pm_ops->core_get) {
-		ret = core->pm_ops->core_get(core);
-		if (ret)
-			return ret;
-	}
+	ret = venus_get_resources(core);
+	if (ret)
+		return ret;
 
 	ret = dma_set_mask_and_coherent(dev, res->dma_mask);
 	if (ret)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 583153bbb74e..ba5199d9e5c9 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -326,7 +326,6 @@ static int load_scale_v1(struct venus_inst *inst)
 }
 
 static const struct venus_pm_ops pm_ops_v1 = {
-	.core_get = venus_clks_get,
 	.load_scale = load_scale_v1,
 };
 
@@ -395,7 +394,6 @@ static int venc_power_v3(struct device *dev, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v3 = {
-	.core_get = venus_clks_get,
 	.vdec_get = vdec_get_v3,
 	.vdec_power = vdec_power_v3,
 	.venc_get = venc_get_v3,
@@ -920,7 +918,7 @@ static int core_resets_reset(struct venus_core *core)
 	return ret;
 }
 
-static int core_get_v4(struct venus_core *core)
+int venus_get_resources(struct venus_core *core)
 {
 	struct device *dev = core->dev;
 	const struct venus_resources *res = core->res;
@@ -1109,7 +1107,6 @@ static int load_scale_v4(struct venus_inst *inst)
 }
 
 static const struct venus_pm_ops pm_ops_v4 = {
-	.core_get = core_get_v4,
 	.vdec_get = vdec_get_v4,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index 3014b39aa6e3..7a55a55029f3 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -10,8 +10,6 @@ struct venus_core;
 #define POWER_OFF	0
 
 struct venus_pm_ops {
-	int (*core_get)(struct venus_core *core);
-
 	int (*vdec_get)(struct device *dev);
 	void (*vdec_put)(struct device *dev);
 	int (*vdec_power)(struct device *dev, int on);
@@ -28,6 +26,7 @@ struct venus_pm_ops {
 const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
 int venus_core_power(struct venus_core *core, int on);
 void vcodec_domains_put(struct venus_core *core);
+int venus_get_resources(struct venus_core *core);
 
 static inline int venus_pm_load_scale(struct venus_inst *inst)
 {

-- 
2.44.0


