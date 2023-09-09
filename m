Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0F799A1E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjIIQ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjIIQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:57:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356F6BB;
        Sat,  9 Sep 2023 09:57:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a6190af24aso373449066b.0;
        Sat, 09 Sep 2023 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694278664; x=1694883464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPsFgN38cior1SKxW81Y7Gkh1AFKCwSP89NqBSkmZqU=;
        b=RnfS+Exzz6L83DioUGtcSNAVDlnh3xz/1DE4Es60wc3g/3J9yw2W/OYut0Iv1XmW8g
         36Xx40Tt13+2p5YcwFScw7zcuV3jTT6Td7LTOlnfjcyPHbn5JY1AtQTdgjOq0QIyi4l6
         X7s72q7AgXoe9/VNDaQbOWECNqP+HgW8zeGiNBRBCOCPOvCvhs7d/IDgQpvajuVHOXGQ
         g93gwidG3Hj8Q2ZYfzbCWpxSdj21xfBYZXzfH9ka7p2NBkFmD5HFpDtuPndmk0kGLfRs
         6UpLzOImS/8PV4/b6cDWZpbgPi4BbbzHNaI0N65WPu/2c6qyzwIKAnkDnySRMsRJt6G2
         Oo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694278664; x=1694883464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPsFgN38cior1SKxW81Y7Gkh1AFKCwSP89NqBSkmZqU=;
        b=ncVcTe2SV1MEn2o4G1a/oZ2kpMOnXlVG4el3IKG2JMzYfvmuFY8MK7qKFKdCumnyTO
         xf9TM9ubgaFeiyHPK8Oo7E97lbmyftEVHBnCYnVouaQM5A6rxvo0cNDBTzlbnF774cO5
         OQdsV+xwQkWMKtWSfngEau0j3gbeawdNmzZV6adxMqKCQHdy2r11df2YMRYECvJsOMrf
         vc7lSLcV/twfOSN1Js+sUy/UyHwlYo5zWAmuIT+/DkOcyYwf+FeQy+de2G/sp8MomRL3
         ZDmXYcmHA63wCyAChqGo5Juz76lU/DtiupibfX2JWzLH3hHRSG5CbKVN7gviCj8Y6Rwy
         Jljw==
X-Gm-Message-State: AOJu0YyaVVnGxmlG3GwutY37/QCNUnRhDbOMGVnW59a2P000rL722toC
        VHmeQplH0CHXRO3REYS7RsM=
X-Google-Smtp-Source: AGHT+IHwFwcuhp+B8YnQkqLLke0qXQlLEJZwmUNdi5V/W6gkyKx2w/cdcA6e7nZl1s+ypo/vYKUAwA==
X-Received: by 2002:a17:907:7791:b0:9a1:c669:6e66 with SMTP id ky17-20020a170907779100b009a1c6696e66mr4368805ejc.70.1694278664324;
        Sat, 09 Sep 2023 09:57:44 -0700 (PDT)
Received: from fedora.. (dh207-96-186.xnet.hr. [88.207.96.186])
        by smtp.googlemail.com with ESMTPSA id si16-20020a170906ced000b00993470682e5sm2569357ejb.32.2023.09.09.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 09:57:43 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 1/3] cpufreq: qcom-nvmem: add support for IPQ8074
Date:   Sat,  9 Sep 2023 18:56:00 +0200
Message-ID: <20230909165739.1036263-1-robimarko@gmail.com>
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
* IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz

So, in order to be able to share one OPP table lets add support for IPQ8074
family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.

IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
will get created by NVMEM CPUFreq driver.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Use enum for SoC versions

Changes in v2:
* Print an error if SMEM ID is not part of the IPQ8074 family
and restrict the speed to Acorn variant (1.4GHz)
---
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 45 ++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

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

