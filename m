Return-Path: <linux-kernel+bounces-12284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC4F81F251
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D641F2309A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F60487BB;
	Wed, 27 Dec 2023 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRtOPWIu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083E481CE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a23566e91d5so633040866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703715350; x=1704320150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DM4CXwvWCS9WJcPPk5LYsBDY7vznKyyVFP9Y3rGVGSA=;
        b=eRtOPWIuphs2fQLqOcXohktt1fA3wqlCgzu/53++Vb9bMackwBN5uzZwykJ3Jh7z+u
         ob6byIZd7dAyH03+5hrDnaq6mRBgxdXhOHolRelady5yD5WqTAtijOgFA5pGX1HOn9PN
         I3z3cXJlmOlobztf1dlBz4x+kn9LpJf9BvaKr8c240e3lSvvItlIr4rr/uVBK3Hh87Zp
         75khnY/o68RahW+7tVtLNj3XPc08ANolGavwIbE9ZMyh3GnPnFcYI18q9Cth1N1zX1ND
         X0u3cBKBoyuo0cVEorDXGqvKnHGQcO0CuCv8EfBWT0rL/gJy7i+gJCinPoS0yPh4G7Tm
         3R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715350; x=1704320150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM4CXwvWCS9WJcPPk5LYsBDY7vznKyyVFP9Y3rGVGSA=;
        b=Eq/a9gopLp3FGaxEm/fAKeCNwvEnTVIlrtjiO18WFhWdhp+XuRtCxT0VcbyVPdEcXi
         xP0fPhzb9WVuKnnsAoTKKupi+6aHO/pa6SDebisyPpAubKDBQks9vgjCfNDE/FPca0yZ
         qTQDs3JQxcGuDegMZStzdjap8F/KHs6s8ukwg3nTF1abBxNxrJdOUdB3IsCOXrdthbJU
         60Y6L5ebI4F7WVxtnBemBM0IxZIhGzsfhDu2ATKC6OlhDabXsOMriJNGTFYZKO0og5K6
         De2WXwnoODHeP8d2UXkEK8pY08K+fWYrshw32QKCfptJutYLIdmEbvxxJ6VWuNV0gU3c
         bUxA==
X-Gm-Message-State: AOJu0YxRJ0sAYFEJbxv9R0GBeh9NO/PL0QrJB/miXbcxzoKDcmtrCL17
	p3Cvu+iqk/ITQCqmqVi8NpTND2Xe/8H3YQ==
X-Google-Smtp-Source: AGHT+IHb3i7zrOCE9dus7HdyD0r11qGjZT/lVPCmvxmqEPH98DLPQF0l8rTAJ7Iq27OsSbhi+H3pjQ==
X-Received: by 2002:a17:907:91d1:b0:a26:93d9:eb6a with SMTP id h17-20020a17090791d100b00a2693d9eb6amr2433282ejz.44.1703715350572;
        Wed, 27 Dec 2023 14:15:50 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id vw17-20020a170907059100b00a26f3d6062csm2821501ejb.50.2023.12.27.14.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:15:50 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 23:15:31 +0100
Subject: [PATCH 2/2] firmware/psci: Set
 pm_set_resume/suspend_via_firmware() on qcom
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-psci_fw_sus-v1-2-6910add70bf3@linaro.org>
References: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
In-Reply-To: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703715346; l=3395;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JzsZaTg1IMKhIfK68jHfV873UZDk10Nbu4hj2+1j2fg=;
 b=Mw5QVXoHdGheLV+1bzxTtADhkn/zaPQU1MbgFoSVA89LnbIQtJJVihIi5J3WuZYWxQindrXvB
 sUzNfSt1TuTDktJtJD/hPUp1yX52useQnsRzz4Dywpgok07cbtfO0Wk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Most Qualcomm platforms implementing PSCI (ab)use CPU_SUSPEND for
entering various stages of suspend, across the SoC. These range from a
simple WFI to a full-fledged power collapse of the entire chip
(mostly, anyway).

Some device drivers are curious to know whether "the firmware" (which is
often assumed to be ACPI) takes care of suspending or resuming the
platform. Set the flag that reports this behavior on the aforementioned
chips.

Some newer Qualcomm chips ship with firmware that actually advertises
PSCI SYSTEM_SUSPEND, so the compatible list should only grow slightly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/firmware/psci/psci.c | 57 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 1bcb752977b1..ddfdc14e2423 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -523,6 +523,30 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.begin          = psci_system_suspend_begin,
 };
 
+/*
+ * Some PSCI implementations (particularly on Qualcomm platforms) silently
+ * sneak in SoC-wide power collapse through CPU_SUSPEND, while advertising no
+ * support for SYSTEM_SUSPEND.
+ */
+
+static int psci_cpu_as_system_suspend_enter(suspend_state_t state)
+{
+	pm_set_resume_via_firmware();
+
+	return 0;
+}
+
+static int suspend_valid_all(suspend_state_t state)
+{
+	return state == PM_SUSPEND_TO_IDLE;
+}
+
+static const struct platform_suspend_ops psci_cpu_as_system_suspend_ops = {
+	.valid         = suspend_valid_all,
+	.enter         = psci_cpu_as_system_suspend_enter,
+	.begin         = psci_system_suspend_begin,
+};
+
 static void __init psci_init_system_reset2(void)
 {
 	int ret;
@@ -533,8 +557,33 @@ static void __init psci_init_system_reset2(void)
 		psci_system_reset2_supported = true;
 }
 
+
+static const struct of_device_id cpu_as_system_suspend_match_table[] = {
+	{ .compatible = "qcom,msm8998" },
+	{ .compatible = "qcom,qcm2290" },
+	{ .compatible = "qcom,sa8775p" },
+	{ .compatible = "qcom,sc7180" },
+	{ .compatible = "qcom,sc7280" },
+	{ .compatible = "qcom,sc8180x" },
+	{ .compatible = "qcom,sc8280xp" },
+	{ .compatible = "qcom,sdm630" },
+	{ .compatible = "qcom,sdm670" },
+	{ .compatible = "qcom,sdm845" },
+	{ .compatible = "qcom,sm4450" },
+	{ .compatible = "qcom,sm6115" },
+	{ .compatible = "qcom,sm6125" },
+	{ .compatible = "qcom,sm6350" },
+	{ .compatible = "qcom,sm6375" },
+	{ .compatible = "qcom,sm7125" },
+	{ .compatible = "qcom,sm8150" },
+	{ .compatible = "qcom,sm8250" },
+	{ .compatible = "qcom,sm8350" },
+	{ }
+};
+
 static void __init psci_init_system_suspend(void)
 {
+	struct device_node *np = of_find_node_by_path("/");
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_SUSPEND))
@@ -542,8 +591,14 @@ static void __init psci_init_system_suspend(void)
 
 	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
 
-	if (ret != PSCI_RET_NOT_SUPPORTED)
+	if (ret == PSCI_RET_NOT_SUPPORTED) {
+		if (of_match_node(cpu_as_system_suspend_match_table, np))
+			suspend_set_ops(&psci_cpu_as_system_suspend_ops);
+	} else {
 		suspend_set_ops(&psci_suspend_ops);
+	}
+
+	of_node_put(np);
 }
 
 static void __init psci_init_cpu_suspend(void)

-- 
2.43.0


