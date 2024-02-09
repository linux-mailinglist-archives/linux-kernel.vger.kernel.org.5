Return-Path: <linux-kernel+bounces-59996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB3E84FE54
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBF4288113
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50FB1B7E9;
	Fri,  9 Feb 2024 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNoQflyD"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6EF39ACB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513001; cv=none; b=qCqr4j7gq+QWcVNseSMiI8LeI7Ha0J/M0a4soZHXcIp7jevt6nqBBd590ajeqi2hFASb93Wb+u3osUS5BISNsD926AZnOVTONFZBGHhnObaf/eUyIyZRYKwamKKSu9ystjXCggYp34+5MPoHzNcKkS12kQ+R9Z8T0KIwlW0YWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513001; c=relaxed/simple;
	bh=emlasjHcZnzrIjnafSLSnzSeNd3kwBS4D1Wpb2NJwiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXG5KNFom/qIDdiT6auubnF0wFLq9CakRHXcRvDkcSNeDBjhI+H6w1zFPHjQitCak6DT7ftF4QuCMoc87gEGNgIN0FoB24t3+WrhOZwMOHGOuOBT9plnweXcVVrgeX2e7yuSqv4x6yWn0sZoXqBTX4ogtBGhYmzO/fd1fbg3r3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iNoQflyD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso203948666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512998; x=1708117798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2YxXA2KQwmYTykbrsMuU28ijcqoH+ICj0PO4K3eu3g=;
        b=iNoQflyDa9h+8hwiffRMHkHBj6JC98z0hs8qbYw+k3TZe2zAhzBzMoNq6bWrOC9B1W
         A7miC+LAT+jpaXJu9iscfQcPZ6QKUYFb0y3vNUXpx6EyNp/ElfFKnKsiRCWt+rLRcjPW
         SF+JLQuzx3FviG2TveKI05CqX+C+5RWScJvYpIZvp9Bvvbq/qsht3uthc85TRsPuZFaR
         J4gairJNc2urNhICduT9CughT8yF8iKvly/qOIvdXqJLngXxiv2LMWyDGJnQj+PDhkfh
         5xsWyKmceaUtwIGk32HZElWONsByN+VdCZ7MmLZvpKWhAjeccQDgg2P9gil3Wq19pwuK
         KnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512998; x=1708117798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2YxXA2KQwmYTykbrsMuU28ijcqoH+ICj0PO4K3eu3g=;
        b=ovtQPgs5U+JiVuhvqPyvn82leNAT/8vxR0vrz/Qq8er4VIoZrs6naI0Ur3oTafgzrF
         dnHto4aKN6JtIbI7lX+GuDTcnEOqUs2LpH7eXiSXHtLBvJ/FQMvvbI3U6cbwigKfCw8b
         WDLhay7xjoCPNa3hNxSW7h4tG2APyThDha77Y5pANXD/9hCP+nrQ0fgs2IxFsSDMoqnO
         T8JVZJPd9BVzif8AvI8O/MaNfkaslRQERTgDKR3bWi5VgLZOuPaqJhafmHAxEMjCMT/W
         a3LK6x0bwKmcmFepTXBlk1RPhS3MWin7penBuCiXcdwUHAObQQzMNXLoDfmKpz+UQaVg
         Qgjg==
X-Gm-Message-State: AOJu0YyA0bwuQVQ5BF0DowICJ+P7z5gDR2ez6ut12opXUpZWidM21AJ1
	FCiw8+/nMImY+C5HOxYJ4ntvx0Rn9WV1Ieh4SkLmbghF2I/tWfK9R9kwHEk14TI=
X-Google-Smtp-Source: AGHT+IHDduXE6feHEfBorIgCVQWl5Jn+Ve4Cd9AvURZgwCUnQ77qWcE4yem/H1l6J8EWd0F+RIyEqA==
X-Received: by 2002:a17:906:a92:b0:a37:f129:262f with SMTP id y18-20020a1709060a9200b00a37f129262fmr221597ejf.12.1707512998289;
        Fri, 09 Feb 2024 13:09:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUc8bLRgweiBVuk9eczSVYfpuNQRnuIh3vZjAIZUIJWRHTF5591PApKSgTs049Uhc/jfFXkI5reynt3T355snl3ywCzO9R6GuUzhr8cdA/UHQSluHSMVbSLVNCpQAmO8yEYqwrTLpyo18PgE8vBSmUYJPN0EKitZ7cetILptYZex+43rxpnQ+txWDgidr8kjTzy5DWjtQe87KAQsJGAVGSYfzhoL1F7fKlTxBwXTxe9uEfA9NmdVpKYTzbXuEjn8YDzGRw9YAryTq3wbMylQj9AuKtcsjCQ9O4cRvf7yDjj8ZUy0NC7GjlmLruofgpJ3eV7JqGDV5Au+APVQGNw2o0y9ORIEQYZZIU/j9QBF9SJw3B46MJ9pExMfZ5xVVkguDzpC0KJZTKsB4oBDAnIL+oKj4G7TSmHJ4NVtQqBBg9iMwdy/R745K0TMZYVfNlcvT/b1zr+aifH5JJDyapdG8bhpXWHGJ7atx4rfpk2y2wrEIVKwsgfSaaQ1tTWPhSdnmjH0A==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:57 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:50 +0100
Subject: [PATCH v2 06/20] media: venus: pm_helpers: Move reset acquisition
 to common code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-6-3dac84b88c4b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=2551;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=emlasjHcZnzrIjnafSLSnzSeNd3kwBS4D1Wpb2NJwiU=;
 b=pmdE2ES1G6/MKZfX3GzMyvavVDPlN+plxhvovU/PoEShg7rUaVAZQB3iuBi0KNpybJBJipvMf
 wdDfzCVsd/bCwFW/C/FUH3PtUuslzktUB0X3uTw3kGdcrfgsmmrSVwE
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
index 7193075e8c04..6017a9236bff 100644
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
2.43.0


