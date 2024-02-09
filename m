Return-Path: <linux-kernel+bounces-59994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FADA84FE4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948A01C20C2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EF13A29F;
	Fri,  9 Feb 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3eKtIPT"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AF39FE2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512998; cv=none; b=mthzKfbbzKW8lhPTzfU7R4M2s8fzV3wi9x0eu1EqrLxOVzJ37bY38OAp/K0MgNX+4fdPwN8IGcpj/BRjbl7vpwk2M8bvGB81rV7TWJ4s6jKKwRp0AKhsCmCtKV+Tb4E+MOAKaDHmLIHB2aQF0odqiIUwTySlwYtWjYSVfIMK6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512998; c=relaxed/simple;
	bh=y2JWZvHJdVFdS2JPzFc6K4lM3ffIwu7LSCAQM8cYwps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/ynHiJc+XCBpYduEt4jqoB1uKDScWl2tL4LEmAhFisUmdcMooJ2s9eomh/CtzX7caPTlmO/Fs8o2wtTHyjAG/w8HSoXWCldkPxlGHsNVFrjadhOlZ+yFe4zumN/V1X8RB4GyifGyR7gLdsOzXDrxlFXdt0lvbTdFj95CtO2Vak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M3eKtIPT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3bf9012637so118484066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512994; x=1708117794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHqRSPmMg9wEwP3rMANc1kfU5BrHC67r5uXE7Pbrcfw=;
        b=M3eKtIPTBqosWJIQ7Od1wDVHeQYwKLmZT9p4Tl5NbXWYf7A8cl8PTiCyhFhpyBI3tQ
         uG2cj863k3KrJ/C0NWw2hIUqMBBfkNXQ2VS20z2yyweKOVfQIBlaHlFh3XGxX0oZ8LnO
         oItikgINfFSyCQ1WRVO4jDb9AjnqzkwXrQf7MEtwpEIXg4SGqMvifcySKHTl5CX3hRcc
         QHkt8bAVokpk99n490U9UlDD3pzlpocTsd0ezvt63QhAMJGZPyx3Cgt8wXFaPQWZh7rj
         OxzjNJxu4+nbLNdh8gszjx/4pCfZcIw3Cmr7YUlRn+fAhU12c56L3C/alc+kjfOM8Dyb
         hcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512994; x=1708117794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHqRSPmMg9wEwP3rMANc1kfU5BrHC67r5uXE7Pbrcfw=;
        b=QQKPJmfxcT7k3xaVVjhGTW7GcYSvj9+MT87yZbieBeKOt0InprXjvasvrVY6Z484EE
         wPStqZC0YeAy6lrQTMl3edkywmiWpEFdjMWgDvseY+yu/edJGNxFs4ju+MyJqtK+f9SA
         kShw+dq4J6KY6/mAEZw3i2Ck6G0tlz0o+ufhXOoHBrdCyBdLKo/W8aOcX+dPCIi3iHR6
         Rzx7NDJehK7iBAMduGAULhWzc+dHzKJlP9pAkwrABL9aNMpYJ90o99i3xm+JgfrIpVGr
         hNlybvVJD+0HPFNVQMOFpOxTUnX63mbwM2e2VNIM85RcuyPQpMeGAeuVbe9jFD+wU4Ig
         3m1Q==
X-Gm-Message-State: AOJu0YwNDk0sfOML+Q8NYdnG16KUe24LXJbj2rM0384uIVW6Aex8rTCy
	m0s8i0eYG9yqIWcTRN/T57OApc3s6CQYnFWv33dGgn6PYzyF0TB2bc0/Tmi3LvE=
X-Google-Smtp-Source: AGHT+IFCRWKIfsiL82n4TdoS64yVcnwMBOfM5a1/WQBiaXKRFrUJF45vmgNQwB8+gNMCtrg0vsq52Q==
X-Received: by 2002:a17:906:ece8:b0:a38:1673:682a with SMTP id qt8-20020a170906ece800b00a381673682amr190148ejb.32.1707512994747;
        Fri, 09 Feb 2024 13:09:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7M3Z2lfJw6CYTLfI4lk7oZf4X/Tt8KydPPEjARXyuSj2RTAotoZMWc/4LontHspfsZvs2mavsE0O7vLe4AwgjKuGNQVD1gTmJVu/kQdu/BTIqerDe8c+vzuNfEhsv8pMxt9MMug51L2Gg7e/FAnvJmt/4XtcraJbsMt9xW0h9VBzs2n9mws+KI0ZlVdbAN6dKdGqa1Dob3dR4YoPWLILCLdo+ybAwJOLpb7b3ZslDfDnQ0H2NGbVv5srAnvbs+5cMj5gQCdloW1ToEHz2hiAs99Enc+EYRQz2Mrm6XHv3XZNZiNbMXVbp4VVd/I0UfBi3RY4gE1JVJtuD3843w7lsGqdtNxNdJUxgELZAu0lsIqehMMedmgZFsCsNbfW5L9xU3LQr4RJ3q8W7c19ZyXCAT/wi9UG2I6bRx52SdEHDvhk1n5cNCGiYBUdXcZUccz2Ml2gbfHrQMilutfat/p3IDzXnz9Lm2rUvdV2/2dz747SiXF4CBeO5iXKd7nVMaXvg0Q==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:54 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:48 +0100
Subject: [PATCH v2 04/20] media: venus: core: Set OPP clkname in a common
 code path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-4-3dac84b88c4b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=2649;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=y2JWZvHJdVFdS2JPzFc6K4lM3ffIwu7LSCAQM8cYwps=;
 b=AtvahE0Zp8lNnsXEZ/S0J1BDdGYP6MemKHscNYsYbYfY4wMxb5DnKSFgdvP2tzd3LvvAzgeJ3
 4f47+3XEPlJA57krg+XF4NHdT1tiITEo7TCJLawQhpnW9hM8/4jvzL1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Calling devm_pm_opp_set_clkname() is repeated for all HFI versions in
pm_ops->core_power.

Move it to the common codepath.

This also lets us get rid of core_get_v1.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  5 +++++
 drivers/media/platform/qcom/venus/pm_helpers.c | 23 ++---------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index ce206b709754..5ab3c414ec0f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pm_domain.h>
@@ -319,6 +320,10 @@ static int venus_probe(struct platform_device *pdev)
 	if (!core->pm_ops)
 		return -ENODEV;
 
+	ret = devm_pm_opp_set_clkname(dev, "core");
+	if (ret)
+		return ret;
+
 	if (core->pm_ops->core_get) {
 		ret = core->pm_ops->core_get(core);
 		if (ret)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index ea0a7d4601e2..1ba65345a5e2 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -318,21 +318,6 @@ static int load_scale_v1(struct venus_inst *inst)
 	return ret;
 }
 
-static int core_get_v1(struct venus_core *core)
-{
-	int ret;
-
-	ret = venus_clks_get(core);
-	if (ret)
-		return ret;
-
-	ret = devm_pm_opp_set_clkname(core->dev, "core");
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static void core_put_v1(struct venus_core *core)
 {
 }
@@ -350,7 +335,7 @@ static int core_power_v1(struct venus_core *core, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v1 = {
-	.core_get = core_get_v1,
+	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
 	.core_power = core_power_v1,
 	.load_scale = load_scale_v1,
@@ -423,7 +408,7 @@ static int venc_power_v3(struct device *dev, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v3 = {
-	.core_get = core_get_v1,
+	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
 	.core_power = core_power_v1,
 	.vdec_get = vdec_get_v3,
@@ -1013,10 +998,6 @@ static int core_get_v4(struct venus_core *core)
 	if (legacy_binding)
 		return 0;
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
-	if (ret)
-		return ret;
-
 	ret = vcodec_domains_get(core);
 	if (ret)
 		return ret;

-- 
2.43.0


