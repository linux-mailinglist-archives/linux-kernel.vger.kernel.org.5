Return-Path: <linux-kernel+bounces-60004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983884FE6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB491C2120E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40973F8EA;
	Fri,  9 Feb 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muEh7yp+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29B3E474
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513014; cv=none; b=Yl9xAbqSuxnt+L7V+tcXg3lFgmGlN5rTmkJx/Dy7sVFN6U4dv2VByAlBtZwuchspSvblkcsQHPv4mP9MOr78Mf9aVimFeFSyoohdl64xum4n5HZPCk2snCg2Pp/f2MrzMdkl6g+pGIALQnDxV6kqEnq7i6NW50WOl1tQnS00Rnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513014; c=relaxed/simple;
	bh=cRJFudcjiVCid3coXRofqspzGAz6z91Bv4pWpCaIiXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tlqol2gwPwTa5Z//P7KjJOU2EVG0EBvIO8ZYQZf/dNekqYdG90/wqMtl57Gdoja5PPQWh6EMgQPyRfBxKvbB5/TruaTsQZYgQQQ5Pz21mjcW8UyXkIK7Hb1HgjJbxuKlBy7W1woucXD/ZY7DTWXBLRJjHshI4K32XTkCeThgfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=muEh7yp+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a34c5ca2537so178678166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513011; x=1708117811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iccq4TLkD2INMIlTDHQm1CqNTexDcalE2BlNeCgcoHc=;
        b=muEh7yp+19Fs+uwZ4bkIp/VzhZNMezF68BS7wde47Bes3VKO5ZJShZuBjnx4z/GJ3I
         t8r5v39JqnujYb9EVwZyTDoGDeecL/UtlVcoQ/fIni6dx3BdhaYNsdTGKpbkxtQKubO9
         pas8sVrP8hcleZmulTLf9f+4wRi/NIHLkGfETlD/vcuEDpD5gmkOCOTxd0amRxLkE4z2
         oyZdetV0hWbXURKqWoDYRcRHmBsOV0fEpJvaYZHK1V5q+xdoGEvV/BKO7sWx0ci+setV
         d9pQDb2CiBCbjuPp86O7UkG1R7khZv4JB3nhhh0vwYtHoq7jDh1oKyCcTqjCqnX5cz0l
         Va1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513011; x=1708117811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iccq4TLkD2INMIlTDHQm1CqNTexDcalE2BlNeCgcoHc=;
        b=fkpamt6iHiN9gw64wQf63bt3XdjXWT5IjXRNR06QDE/MRp/VLfRPGoUr0QHLCtmuRf
         eejwY6T2//qlwU/3xkqEIOKrFwaxu7CI7niiF1bs4FdKzbzCnhygOnThTOLVZAGKIoKh
         rjuTk8GQunwhsfGagT6AmeitOqHupqh+3alFG6h7Dojjo0JUBsCFyVduN+VDp4+1RIha
         bUlrJubMHhkN5pO0paq+COwXNeyFcrmpj6EJa6t9kop8/nVy+4ska2mwXPLKh9Favf3t
         xGXsJp4gJ2p2xmOCdYvlq9VQnDqsTUu9w0wLtKgF7twBZpePaEGA2EqL7+p/4h/uzBsL
         KjGA==
X-Forwarded-Encrypted: i=1; AJvYcCUvGiMi703BVrmiMj9vBt1pGHumFT+bFxh6Xp12aBD8Dc3+GCVQE8M1nIVM0PXrTxZhpDeYp2btdbSVs1v94TLx2x5tJw4q5kTdumY1
X-Gm-Message-State: AOJu0YzDz9lXhW1zzDMzcFw8b/gcACDmitF5qX3/PT5MnOz7dxaRZIG1
	pdUPeS60OgpTC11G8fgdWdVbpotDZLRv673fs3obBfKUETu/qG7DYG668iF/D9w=
X-Google-Smtp-Source: AGHT+IHQrwh3QgO0B80ohQ/feL+Ziyk/NNIeHQJ6OozwsSXAR9tc91e1mwCH5spPUXxac7RB7wLCXw==
X-Received: by 2002:a17:906:f852:b0:a35:51b1:c757 with SMTP id ks18-20020a170906f85200b00a3551b1c757mr163298ejb.38.1707513011223;
        Fri, 09 Feb 2024 13:10:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSMjZ577S4cYpw9sK3vDrzwI4sb0ibwgH3xKyPnCukwZ320+J3WCX8vKTo40BzOk56wHZMH1SiFTxHLcrt3Hkn0KB9hdlFBRYf0+5sBamiW7p6FijqIUNjnRwOyzTIbNhBOBzF1lXgYesYuCjRgh3Bhwhdl52a5P6GDX43jddN8dgq/iXA0BWMlrUBuwbp8bNWxdt26Kz9qVv+uhEOc3XYy5ywnVR9cqTdaLRNovUPhGnwfPbXwSjh3gPK9RebDoBSsRWWDnYE3+qtkx4+rKq0IwEVHiKb9WIGaWGsiWkGCk6I3z3GtMRpPLmrQPbjxGd+MUU1wOiIg1ICRaAW+azRrGfB0dvpn+4EX29dqXlzujAB+D3tMKNvLTsgp1qtDLZrxt5X1Dvg3Rt6AIX/PrbNhT8JTX7YbhjGrznkQy/oeVIM3smo8SAOafzARaEcdy+XsaPSBZQ0MeuSeK2AcH+9fEJRzqUnOx4JKgHQtw9wg9dKKo9nK2Xk3hvvL08kq34aYw==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:10 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:57 +0100
Subject: [PATCH v2 13/20] media: venus: pm_helpers: Commonize core_power
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-13-3dac84b88c4b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=4717;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cRJFudcjiVCid3coXRofqspzGAz6z91Bv4pWpCaIiXM=;
 b=Rc3oc6RfokYXBJk1f5VshwRPBBeVoH5ZYiZDI19mfIPuqHWUxAWGIJErO/N+kVzj5BpiRntlt
 hUdU68VY56RCM8bGHaW3bzgZxssatAJDZqV9XedjWazYriDhONQhN9g
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

core_power_v4 called with num_resets = 0 and core->pmdomains[0] == NULL
does exactly the same thing as core_power_v1. Unify them!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 21 +++++++--------------
 drivers/media/platform/qcom/venus/pm_helpers.c | 17 +----------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
 3 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 65a9e815e6ba..9bfd2a30084b 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -477,18 +477,15 @@ static void venus_core_shutdown(struct platform_device *pdev)
 static __maybe_unused int venus_runtime_suspend(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	const struct venus_pm_ops *pm_ops = core->pm_ops;
 	int ret;
 
 	ret = hfi_core_suspend(core);
 	if (ret)
 		return ret;
 
-	if (pm_ops->core_power) {
-		ret = pm_ops->core_power(core, POWER_OFF);
-		if (ret)
-			return ret;
-	}
+	ret = venus_core_power(core, POWER_OFF);
+	if (ret)
+		return ret;
 
 	ret = icc_set_bw(core->cpucfg_path, 0, 0);
 	if (ret)
@@ -503,8 +500,7 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
 err_video_path:
 	icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
 err_cpucfg_path:
-	if (pm_ops->core_power)
-		pm_ops->core_power(core, POWER_ON);
+	venus_core_power(core, POWER_ON);
 
 	return ret;
 }
@@ -512,7 +508,6 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
 static __maybe_unused int venus_runtime_resume(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	const struct venus_pm_ops *pm_ops = core->pm_ops;
 	int ret;
 
 	ret = icc_set_bw(core->video_path, kbps_to_icc(20000), 0);
@@ -523,11 +518,9 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (pm_ops->core_power) {
-		ret = pm_ops->core_power(core, POWER_ON);
-		if (ret)
-			return ret;
-	}
+	ret = venus_core_power(core, POWER_ON);
+	if (ret)
+		return ret;
 
 	return hfi_core_resume(core, false);
 }
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 8412deb68ed1..6f6de9ef1c6c 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -322,22 +322,9 @@ static void core_put_v1(struct venus_core *core)
 {
 }
 
-static int core_power_v1(struct venus_core *core, int on)
-{
-	int ret = 0;
-
-	if (on == POWER_ON)
-		ret = core_clks_enable(core);
-	else
-		core_clks_disable(core);
-
-	return ret;
-}
-
 static const struct venus_pm_ops pm_ops_v1 = {
 	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
-	.core_power = core_power_v1,
 	.load_scale = load_scale_v1,
 };
 
@@ -410,7 +397,6 @@ static int venc_power_v3(struct device *dev, int on)
 static const struct venus_pm_ops pm_ops_v3 = {
 	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
-	.core_power = core_power_v1,
 	.vdec_get = vdec_get_v3,
 	.vdec_power = vdec_power_v3,
 	.venc_get = venc_get_v3,
@@ -990,7 +976,7 @@ static void core_put_v4(struct venus_core *core)
 	vcodec_domains_put(core);
 }
 
-static int core_power_v4(struct venus_core *core, int on)
+int venus_core_power(struct venus_core *core, int on)
 {
 	struct device *dev = core->dev;
 	struct device *pmctrl = core->pmdomains ?
@@ -1138,7 +1124,6 @@ static int load_scale_v4(struct venus_inst *inst)
 static const struct venus_pm_ops pm_ops_v4 = {
 	.core_get = core_get_v4,
 	.core_put = core_put_v4,
-	.core_power = core_power_v4,
 	.vdec_get = vdec_get_v4,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index a492c50c5543..77db940a265c 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -12,7 +12,6 @@ struct venus_core;
 struct venus_pm_ops {
 	int (*core_get)(struct venus_core *core);
 	void (*core_put)(struct venus_core *core);
-	int (*core_power)(struct venus_core *core, int on);
 
 	int (*vdec_get)(struct device *dev);
 	void (*vdec_put)(struct device *dev);
@@ -28,6 +27,7 @@ struct venus_pm_ops {
 };
 
 const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
+int venus_core_power(struct venus_core *core, int on);
 
 static inline int venus_pm_load_scale(struct venus_inst *inst)
 {

-- 
2.43.0


