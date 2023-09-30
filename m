Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382827B3FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjI3KW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjI3KWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:22:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D232193;
        Sat, 30 Sep 2023 03:22:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so4627367a12.1;
        Sat, 30 Sep 2023 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696069341; x=1696674141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2cw31Dklv6LbIdS/IsVHOoHw1kB38CKqlZS0s3OaLsA=;
        b=ZsgEtLfqgmGHkIGx4MtMKbdwnTroxkKr0De5EOUCs9eOb4XMbJTcN6LjIf3OrZwBUm
         dXTmg9ccNxraOO/lJ7BeRy3ZYKqYuCR1wUVDJhRzf1LmGNomZ2akZqnU+aXpbpJahZJw
         RApqBjTIL62O63gve7pmt2ymzUZ1aMVIn2QHHSTsAE/2i1FRehoAx/x27mP2wDIlh3vw
         6vxKAerdYXoP0QJ3DjK86Rkw26aqsipaMEWKE2ppAwz7COkSh7sEGXZ9CjNvoT8Eu5G0
         nOWYSjfQjBAxgJffO9G9tNVntt2QfQUibb/bVYprMcMf/Rr4OSlLo5OiAVhqhAbtfv6o
         CJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696069341; x=1696674141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cw31Dklv6LbIdS/IsVHOoHw1kB38CKqlZS0s3OaLsA=;
        b=XKeO1GnvUiCUoJ9qMr5++LfiXeUcMQcspXBX5fEesbScHjYppZxxH6+pl/GzivHsxd
         1AJRRZi/NT4aS45FX6V41WJJ0PSGnGGJtp5j6LTeJaAIFcZuzuQpYwi0e81oJoMAmBae
         hjthDsp+KUyIVSF8bOUMeqvLDNk1c1MYEqHIFq6y0A/uEDN5ixX1corXjRc9mOm3N8x7
         vMVwK5FvNcZq22DwuCjuiH1LHotXXMA1Dp+nDL7pL5VuEqzTUNqIWlLjW/RS76zOMP4X
         VCOdxlpJK2QIK5KmSb/WQL60AnW7Z9EEn2WV1/FtPnarm/V01+TRCdg96zsNiV1MC/rh
         8cFw==
X-Gm-Message-State: AOJu0YxuL3Gii3oWYPYySPMwJtyF7HlrI40Vtdd23plICqzhSfMGOMLe
        /Zc76FVfi1ptBTH0EDo+MTA=
X-Google-Smtp-Source: AGHT+IFPaOzMep6Ta1wNJ5ZEFYYnN+5naZP3Mq/f/gUdSLTk4k8Jd9dajDC275ZkuPBe0WnIWrr2iw==
X-Received: by 2002:a17:906:51c9:b0:9ae:6355:5ef4 with SMTP id v9-20020a17090651c900b009ae63555ef4mr5432600ejk.3.1696069341055;
        Sat, 30 Sep 2023 03:22:21 -0700 (PDT)
Received: from fedora.. (dh207-96-216.xnet.hr. [88.207.96.216])
        by smtp.googlemail.com with ESMTPSA id j25-20020a170906255900b0099bcf1c07c6sm13716547ejb.138.2023.09.30.03.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:22:20 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 1/4] cpufreq: qcom-nvmem: add support for IPQ8074
Date:   Sat, 30 Sep 2023 12:21:16 +0200
Message-ID: <20230930102218.229613-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 comes in 2 families:
* IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
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

 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 45 ++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2016d47889c0..157c91b9962c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -180,6 +180,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62a7", },
 
 	{ .compatible = "qcom,ipq8064", },
+	{ .compatible = "qcom,ipq8074", },
 	{ .compatible = "qcom,apq8064", },
 	{ .compatible = "qcom,msm8974", },
 	{ .compatible = "qcom,msm8960", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 84d7033e5efe..ba9e1d60e5b5 100644
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
@@ -203,6 +208,41 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
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
@@ -217,6 +257,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
+	.get_version = qcom_cpufreq_ipq8074_name_version,
+};
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -360,6 +404,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
-- 
2.41.0

