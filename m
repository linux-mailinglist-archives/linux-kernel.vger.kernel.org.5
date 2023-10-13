Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1807C8C37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjJMRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMRUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:20:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D644A9;
        Fri, 13 Oct 2023 10:20:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so3661475a12.0;
        Fri, 13 Oct 2023 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697217638; x=1697822438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8uXQkYNo3bGoskQXQpsae5HsE3SRZJlPG9uoRZ+Rcc=;
        b=mPB8E6Vj2P2mo8o9BZ8cqVZsAX3SHdtoLWw+1RBRR4D22dUE7CCBAXrgGpVoCOA6qw
         ZdCQ0S3B4nKW2Y90bw7rXx+GmVnEOtukBUSawfo0stKemp70/q0aYSq7PAMNevJRpJLj
         wLOA00jOMOyMOOtX0JH0lZwj4bu5Naj0xftekrb/g8UgKww8d1P7C2JaZMDlg1d7LZd9
         4eQAkKq4NymlaxZCiYb5igP3kVTGcgeokbocq5vHIwJqhlh2UEvrO+fB27Jn4dDo5FMI
         5zlnn50Fs5LU7zOw9VrwIrIWjDDOUPo8zGIPy/w/Xysnw8uWFbd0nagrK37vK+aSVCQ/
         7TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697217638; x=1697822438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8uXQkYNo3bGoskQXQpsae5HsE3SRZJlPG9uoRZ+Rcc=;
        b=EZoH7DHKkXmE2yoH1M7kMUc5La9YlyYWcPQIslaa6DkaZO4RbEp/GOUuVCIFF0AF/i
         vuOMPyiW13Pp7ZMJg0LrZRxoNj6aKH9yUILOmTKWdP71PGHjh826iWD9pMPASnYzw+Rn
         jGv9drsi+b0p7IsI8KsW2K+JeltcpEmSxs48ai1MyKdGmIjcZqbOdWB7SrITQ95k1tWa
         h5MlYqQCtP9ku40chLMID8C9oYQ+rLjgAzB73iBW4va8OBr6UAW/gSyBqk41dxn6YEX9
         ZNtVUfJNqfBFdehaHI0A+gof5tEE5DdEeEF0apXSMgjGITJ2afAfJgUvzoyMonTnmuTU
         djOA==
X-Gm-Message-State: AOJu0Yx5N1EmVXjRjoBL0whk7dGRtLNjaGzMLOOx8bmLnXbTgi7GPhm4
        aj/LNgOiV+F8bfHQyZ3qUuM=
X-Google-Smtp-Source: AGHT+IHv3bBuzeeXYE32saD3QLU2OktKI977bWzTRNyRcoGH71CF7cTqqA49rb4LsybuQd2ZY/A/FA==
X-Received: by 2002:a05:6402:42c5:b0:53e:1e7f:482f with SMTP id i5-20020a05640242c500b0053e1e7f482fmr5134815edc.3.1697217638057;
        Fri, 13 Oct 2023 10:20:38 -0700 (PDT)
Received: from fedora.. (dh207-96-122.xnet.hr. [88.207.96.122])
        by smtp.googlemail.com with ESMTPSA id a90-20020a509ee3000000b0053e589016a7sm653125edf.16.2023.10.13.10.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:20:37 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
Date:   Fri, 13 Oct 2023 19:20:02 +0200
Message-ID: <20231013172033.3549476-1-robimarko@gmail.com>
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

IPQ8074 comes in 3 families:
* IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
* IPQ8172/IPQ8173/IPQ8174 (Oak) up to 1.4GHz
* IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz

So, in order to be able to share one OPP table lets add support for IPQ8074
family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.

IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
will get created by NVMEM CPUFreq driver.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v6:
* Split IPQ8074 from the IPQ8064 as IPQ8064 has additional dependencies.

Changes in v4:
* Add support for IPQ8174 (Oak) family

Changes in v3:
* Use enum for SoC versions

Changes in v2:
* Print an error if SMEM ID is not part of the IPQ8074 family
and restrict the speed to Acorn variant (1.4GHz)

 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 48 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 0b3776f558db..675da7f36846 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -181,6 +181,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62p5", },
 
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

