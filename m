Return-Path: <linux-kernel+bounces-60005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569884FE71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A03D1F221C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44843FB31;
	Fri,  9 Feb 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cn7qBBSD"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2A3EA69
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513016; cv=none; b=HSWyoU6E+ySAsuhnLJNxAVMBvGWyq8es4gmeP8dYD8B27SGhhWXYUiWX/H2mIfGTwmzgdOAn3NXmLgpZYI21X4zR8ZaLlI3Dc5iB9a8tdfLQce0UW+T23gET6XWn57B4BO+kgCWo2bfnwtUCP2rxPtDu//yNnr6fqWAIg/aIqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513016; c=relaxed/simple;
	bh=G5EO8gWb7PxJbJwYQwPoc5ia4Xy6TP/ueMeizK0hDu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFMPFiJHr0sDj4yg0DTOUFOZGHMgAmuwi6AsHI8YwQGWy1/lva/WisSKxrBT8q0D89EjDpZWZ7VyN4ypL9Hy8T3r18F4+A20Q5oDfgNRRI3mqbTctSwplbFuu5QI2a8C3cdP7KCOueTsRgTsVe7WGdCglYsVeVRn1Mp2HNzUluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cn7qBBSD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso203974666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513013; x=1708117813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uywZaJdRGJQ/k/o6qaBHiBl9Wlir0Y5jv/s44rCrnpY=;
        b=cn7qBBSDSfsoiXtBt9BWwA1MHvviYCjd7ttFYCdkt8EqMzsOnnxvWiLty0+WORYRHt
         5wo/1w1Ak1U8/sKE+PM2skay4qByNneUvAkxzJRxH357U0NhqnP0zR+xAe/O6yRZ5dCO
         lvQIO8vN2W3D+E8qI9AGztM8poRk3eda9ATirAvQCW8REP53uCClT1Tx+pRoXvGe6nDf
         YQ+U3rw0iHDkvG16ND5XtEBKu6Dz6bKJ2Eopdkm/kp7oLGEoILNFhel7CKOWLynubsE9
         YdNkFMA/dEwUYjKqJjZdzj+wYmcz2jeQwVL90qV/GKPbaLgPkB9eViS8L3X44aanmEyw
         wApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513013; x=1708117813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uywZaJdRGJQ/k/o6qaBHiBl9Wlir0Y5jv/s44rCrnpY=;
        b=QoEIJsVMCppoE4D/gMitWb76L8QnYow+tcfzzXhr2Oq257h8Rck1HQZ4AEFdsjkTrN
         o7Sswzp95MwHXEdM3taaoiSCSjumQ56IJIGHB6i78EY/E+haJI92RGJiWf1U4B/RuS0n
         X3CprwA2wTaRdDSXCKIBdAh63wiD7EA8LpHY7QBZCO29qqrMA0vdUqLzoSmUlZg4Q7cj
         kOvZE21Sc+bshfMKcJZFRwCL04uDhA/pbTJ+4lVOOyesMoFc/NFCkkqO8wE2di1WPZCj
         dFCEr8p5ieuPGWbW8Rnyf4DMSF9dLc/h7bvmrn/xYOwFpgMuSo78aJRoYEJGG+iCKopc
         7Y+A==
X-Gm-Message-State: AOJu0YwJfKNgXSYxrqA9qrErbEAk4SxNJzFMf5TX573PT4UhptkSPPCp
	BuZcyabbz/ESRxg4zZoDhV+5ftTvZ7j9DuYJD+AqafdPACvaspkUQ9oGIMx2Jyg=
X-Google-Smtp-Source: AGHT+IFn4UUhkMKr556qFtgiQPsWQOzew24VLWvkaMqAGckTpyTqicd+NyFDWeWRm+x5K4RXMlZOcA==
X-Received: by 2002:a17:906:b304:b0:a38:9923:46da with SMTP id n4-20020a170906b30400b00a38992346damr194119ejz.20.1707513012869;
        Fri, 09 Feb 2024 13:10:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcC8MslwCJOOVb9rJmnm0MZ2MoASz2q+jc9yEqSbOh4sNAR7mXF/oM6qCXwZuNEgfrAzrCA/JicbhOvX1C66ls1jpoIuyNRSF7QEeRju+3XOXLOSBG2jD1/zSnkHCWgi4ToV3H6d3uGIPXqs9Zq3wXGD5AhYfF2HCQea3GG64pKi5ec3KSosDA+jYzyMlarDmd2zRYMlEonbueGPGPsj/+7YRGExvrpPj/uTcgTPUnmfgJpFPLP3MVsqt2VwfIrfF/64ZMu9xesnHssBU2o4M18PA7XkjknRnrkEKs8Zak5+kzMyT5FhES5bGPX9My2t+1j2DTimrZhQCaLPFaesi2/HORWOEolKoMf7eZSo8k/S9GwNWHYwBp0ZbSeXKXcaY+dMZw1MJ903mhhaMI8dml3+QP6cyK3r+IlMbKsr03LTsYE1h6O+NrIXGxJFDxXupIqNVNJcB5dTWa3MtYyG3nyZ7dxyheZtXa/WcmIiVyBVhJ9PdxLzzsMh2SBTHFz6YTvQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:12 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:58 +0100
Subject: [PATCH v2 14/20] media: venus: pm_helpers: Remove pm_ops->core_put
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-14-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=3935;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G5EO8gWb7PxJbJwYQwPoc5ia4Xy6TP/ueMeizK0hDu8=;
 b=kGDBOVa3MohGI2QSLTtyRG8AUOytaLJKLMXSZvjFq6ciBdgCT8Zd4AytyxxpZbcf5J+ZHekv6
 eYfdYC0lFD/AMfmcNDieZxM+aDTLnoV9bYCQR39NyFi8iuVNmaphXh1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Without an OPP table and with vcodec_pmdomains_num (so, v1, v3 and
sdm845_legacy targets), core_put_v4 is a NOP, jut like core_put_v1.
Unify them!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  8 +++-----
 drivers/media/platform/qcom/venus/pm_helpers.c | 17 +----------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 9bfd2a30084b..666adc5aac38 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -426,15 +426,14 @@ static int venus_probe(struct platform_device *pdev)
 err_core_deinit:
 	hfi_core_deinit(core, false);
 err_core_put:
-	if (core->pm_ops->core_put)
-		core->pm_ops->core_put(core);
+	vcodec_domains_put(core);
+
 	return ret;
 }
 
 static void venus_remove(struct platform_device *pdev)
 {
 	struct venus_core *core = platform_get_drvdata(pdev);
-	const struct venus_pm_ops *pm_ops = core->pm_ops;
 	struct device *dev = core->dev;
 	int ret;
 
@@ -452,8 +451,7 @@ static void venus_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-	if (pm_ops->core_put)
-		pm_ops->core_put(core);
+	vcodec_domains_put(core);
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 6f6de9ef1c6c..32f9ccfa9d8a 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -318,13 +318,8 @@ static int load_scale_v1(struct venus_inst *inst)
 	return ret;
 }
 
-static void core_put_v1(struct venus_core *core)
-{
-}
-
 static const struct venus_pm_ops pm_ops_v1 = {
 	.core_get = venus_clks_get,
-	.core_put = core_put_v1,
 	.load_scale = load_scale_v1,
 };
 
@@ -396,7 +391,6 @@ static int venc_power_v3(struct device *dev, int on)
 
 static const struct venus_pm_ops pm_ops_v3 = {
 	.core_get = venus_clks_get,
-	.core_put = core_put_v1,
 	.vdec_get = vdec_get_v3,
 	.vdec_power = vdec_power_v3,
 	.venc_get = venc_get_v3,
@@ -893,7 +887,7 @@ static int vcodec_domains_get(struct venus_core *core)
 	return ret;
 }
 
-static void vcodec_domains_put(struct venus_core *core)
+void vcodec_domains_put(struct venus_core *core)
 {
 	dev_pm_domain_detach_list(core->pmdomains);
 
@@ -968,14 +962,6 @@ static int core_get_v4(struct venus_core *core)
 	return 0;
 }
 
-static void core_put_v4(struct venus_core *core)
-{
-	if (legacy_binding)
-		return;
-
-	vcodec_domains_put(core);
-}
-
 int venus_core_power(struct venus_core *core, int on)
 {
 	struct device *dev = core->dev;
@@ -1123,7 +1109,6 @@ static int load_scale_v4(struct venus_inst *inst)
 
 static const struct venus_pm_ops pm_ops_v4 = {
 	.core_get = core_get_v4,
-	.core_put = core_put_v4,
 	.vdec_get = vdec_get_v4,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index 77db940a265c..3014b39aa6e3 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -11,7 +11,6 @@ struct venus_core;
 
 struct venus_pm_ops {
 	int (*core_get)(struct venus_core *core);
-	void (*core_put)(struct venus_core *core);
 
 	int (*vdec_get)(struct device *dev);
 	void (*vdec_put)(struct device *dev);
@@ -28,6 +27,7 @@ struct venus_pm_ops {
 
 const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
 int venus_core_power(struct venus_core *core, int on);
+void vcodec_domains_put(struct venus_core *core);
 
 static inline int venus_pm_load_scale(struct venus_inst *inst)
 {

-- 
2.43.0


