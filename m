Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E97B2702
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjI1VFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjI1VFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:05:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B08B7;
        Thu, 28 Sep 2023 14:05:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso1164511166b.0;
        Thu, 28 Sep 2023 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935129; x=1696539929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyOTkl7GDrmjuhn9G46tKFpIgEVwvVY54Rn5f3HxobM=;
        b=LcAPAaD/Vm+7Olplc954zxRClqnpXQCNPfQMx8GcfMVSvcyijOgtWiF+L6Yhh563BV
         9y77n/w0MzlAaRh1o2nGRshoy6cMAtd6lDA3GJKyrNu7CLyeFntqZB1YlsPtF6+uRO26
         anBBs7yh/Ukmy39nCYe9xJxfGUqLXpqnBH+dMoOUU53cqof8yUsFmHDLj2mBtvSOip/O
         jT1AXQJqyea6DR0Cr8xLPDsWS0mwZnRqcX6SKqpE4CaXL44Zt34KHt+nh0zSBK3Ax9vq
         lOZGrJ0ub276nFLjWNs8kdnr6vO7kme64fUCRNSQTk3sq2L4oHpr4oN/UVXOJaaMA7eg
         mBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935129; x=1696539929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyOTkl7GDrmjuhn9G46tKFpIgEVwvVY54Rn5f3HxobM=;
        b=qNYWj6oouJnspEf58zutFNdhrEll5Y/1gpUtfxXtcte3ZQdj60ugF8f/PJnVuq8PVr
         91Y3EWliVez9j6SPk5PLmzvKZ4Qr5OYH3/3Jt0jVkM6xq7ZOSZGUIhWiNUAGEBs5y0NX
         nNdNTVPKzMpsiqEqebx6gp/wsyCsfAL7INLzKa8YTZXe1I3v/So74XygetvbPvq6hLaA
         QlTOQ54mgeIdC0qqJuh7aeAQVBoeh8xuBpi0s+HyrrLY8+rzvrYDsz5bvNI/UsB+UFni
         LE7Omz4KuH1to3ajUnbSNnl1MUmNfwr9BFTFtjX8Od7p05MnY302b0Un4KERIal6BNgB
         3N/w==
X-Gm-Message-State: AOJu0YwC1fZdHuI75fru4i6KnLSpL3IIM9KEmLVu2Yv//aYwfMfJ4TQX
        RXAvPrM0V+sl/qRd8DZZgDA=
X-Google-Smtp-Source: AGHT+IHtGpqsYb74w+cPI7fArutheXUqF8+OnSiqP74i/B8LEUMUkAocX4MICjiEH5/NjntOyJ22+A==
X-Received: by 2002:a17:906:2ca:b0:9ae:7433:aec6 with SMTP id 10-20020a17090602ca00b009ae7433aec6mr1979206ejk.60.1695935128805;
        Thu, 28 Sep 2023 14:05:28 -0700 (PDT)
Received: from fedora.. (dh207-99-57.xnet.hr. [88.207.99.57])
        by smtp.googlemail.com with ESMTPSA id la9-20020a170906ad8900b0098f33157e7dsm11386849ejb.82.2023.09.28.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:05:27 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 1/4] cpufreq: qcom-nvmem: add support for IPQ8074
Date:   Thu, 28 Sep 2023 23:04:04 +0200
Message-ID: <20230928210525.1265958-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 comes in 2 families:
* IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
* IPQ8172/IPQ8173/IPQ8174 (Oak) up to 1.4GHz
* IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz

So, in order to be able to share one OPP table lets add support for IPQ8074
family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.

IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
will get created by NVMEM CPUFreq driver.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v4:
* Add support for IPQ8174 (Oak) family

Changes in v3:
* Use enum for SoC versions

Changes in v2:
* Print an error if SMEM ID is not part of the IPQ8074 family
and restrict the speed to Acorn variant (1.4GHz)
---
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 48 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 02ec58a8603b..cc3ccc1519c3 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -179,6 +179,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62a7", },
 
 	{ .compatible = "qcom,ipq8064", },
+	{ .compatible = "qcom,ipq8074", },
 	{ .compatible = "qcom,apq8064", },
 	{ .compatible = "qcom,msm8974", },
 	{ .compatible = "qcom,msm8960", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 84d7033e5efe..3fa12648ceb6 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -30,6 +30,11 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 
+enum ipq8074_versions {
+	IPQ8074_HAWKEYE_VERSION = 0,
+	IPQ8074_ACORN_VERSION,
+};
+
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -203,6 +208,44 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
+					     struct nvmem_cell *speedbin_nvmem,
+					     char **pvs_name,
+					     struct qcom_cpufreq_drv *drv)
+{
+	u32 msm_id;
+	int ret;
+	*pvs_name = NULL;
+
+	ret = qcom_smem_get_soc_id(&msm_id);
+	if (ret)
+		return ret;
+
+	switch (msm_id) {
+	case QCOM_ID_IPQ8070A:
+	case QCOM_ID_IPQ8071A:
+	case QCOM_ID_IPQ8172:
+	case QCOM_ID_IPQ8173:
+	case QCOM_ID_IPQ8174:
+		drv->versions = BIT(IPQ8074_ACORN_VERSION);
+		break;
+	case QCOM_ID_IPQ8072A:
+	case QCOM_ID_IPQ8074A:
+	case QCOM_ID_IPQ8076A:
+	case QCOM_ID_IPQ8078A:
+		drv->versions = BIT(IPQ8074_HAWKEYE_VERSION);
+		break;
+	default:
+		dev_err(cpu_dev,
+			"SoC ID %u is not part of IPQ8074 family, limiting to 1.4GHz!\n",
+			msm_id);
+		drv->versions = BIT(IPQ8074_ACORN_VERSION);
+		break;
+	}
+
+	return 0;
+}
+
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
@@ -217,6 +260,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
+	.get_version = qcom_cpufreq_ipq8074_name_version,
+};
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -360,6 +407,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
-- 
2.41.0

