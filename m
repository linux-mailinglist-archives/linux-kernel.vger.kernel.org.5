Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3527B270E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjI1VFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjI1VFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:05:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291CD19F;
        Thu, 28 Sep 2023 14:05:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1777644566b.1;
        Thu, 28 Sep 2023 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935131; x=1696539931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTbQhrnL6fxPB6GU4Qs86Lqzm/5lK3TOFGFgMrD3+X4=;
        b=VQDXezW5m0GV/jZRNLJt0ttsIeEhCLoePYw6cGrOQY6Zuei1gyhtLbNNIPoV2sQpxb
         2iYz5cC6Q1mIktLtuvB6sVjfp7cac43fuYcgsH4/c2cFnUwdHOdF4N/lnzTAlqcOmdJm
         XIAZqTqG+Q2LIDD4qYmGA+w+gauNF8TybOZRRwIn8XciOg9CgpW0YbpxaAroi0dEFAv8
         tas3Fuvgh7oeSWQxBF2TNFuNqjHxa9djofYmT6q672NzQak/naVENrSJmfxn5PngZUwy
         C252kVwFTKj8JgIiqiNGXjQubg0FZH3VXZf3gZkRGhcZ0CzoqC8IioZSgy4QVtQQ/Fzu
         mTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935131; x=1696539931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTbQhrnL6fxPB6GU4Qs86Lqzm/5lK3TOFGFgMrD3+X4=;
        b=RPs1SWBWW8tRbqTaQ8tzpBPqNsvwO8Qfqf1R8SMvIoBPR4Y9p0P6lUFzC2igHDG17g
         3/YD+dvyCxkRPUX8L8G2HKb1UwqX1OJ/n97zOGnx36lvRPxXsQ6FtaI10pSm5+WO897v
         1hXr9mVE5mUF/yG61lXV/fuwwI2GUalAEULyv+RCYU4EBauj3AOOGcoZMSDL/xuS+VPS
         4E438p7TEQM2rjlkbu9JGtrYmhYM5+xne7PPADBBu9QMAnkRGODO1N/vQB+e7lC/oRnS
         oxqmu5FfdZhk88MahQvRhSVAKM0bk/bvDuRxgh7nRRPc/JlWKLvzwW1J6NwfhgLfz/K0
         /mYw==
X-Gm-Message-State: AOJu0YyU5TNmVZrSAXgt9WebFrypH7aEBriqaR61Kmo27WK735qgpg/r
        jyEdHLG9pXB3e1eNt3eeLHY=
X-Google-Smtp-Source: AGHT+IHx94A2w2Wc0x/XzwAffagD1wbeTuiYFJQ2VarFFkqAle8Yjly8Or30t2ES3YZ6OXuKdmTc5Q==
X-Received: by 2002:a17:906:cb:b0:9b2:ccd8:2d3d with SMTP id 11-20020a17090600cb00b009b2ccd82d3dmr896418eji.26.1695935131580;
        Thu, 28 Sep 2023 14:05:31 -0700 (PDT)
Received: from fedora.. (dh207-99-57.xnet.hr. [88.207.99.57])
        by smtp.googlemail.com with ESMTPSA id la9-20020a170906ad8900b0098f33157e7dsm11386849ejb.82.2023.09.28.14.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:05:31 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 3/4] cpufreq: qcom-nvmem: add support for IPQ8064
Date:   Thu, 28 Sep 2023 23:04:06 +0200
Message-ID: <20230928210525.1265958-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928210525.1265958-1-robimarko@gmail.com>
References: <20230928210525.1265958-1-robimarko@gmail.com>
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

From: Christian Marangi <ansuelsmth@gmail.com>

IPQ8064 comes in 3 families:
* IPQ8062 up to 1.0GHz
* IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
* IPQ8065/IPQ8069 up to 1.7Ghz

So, in order to be able to support one OPP table, add support for
IPQ8064 family based of SMEM SoC ID-s and correctly set the version so
opp-supported-hw can be correctly used.

Bit are set with the following logic:
* IPQ8062 BIT 0
* IPQ8064/IPQ8066/IPQ8068 BIT 1
* IPQ8065/IPQ8069 BIT 2

speed is never fused, only pvs values are fused.

IPQ806x SoC doesn't have pvs_version so we drop and we use the new
pattern:
opp-microvolt-speed0-pvs<PSV_VALUE>

Example:
- for ipq8062 psv2
  opp-microvolt-speed0-pvs2 = < 925000 878750 971250>

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v4:
* Free speedbin in case of an error

Changes in v3:
* Use enum for SoC version
* Dont evaluate speed as its not fused, only pvs

Changes in v2:
* Include IPQ8064 support
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 68 +++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3fa12648ceb6..8ca0e7ebd184 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -35,6 +35,12 @@ enum ipq8074_versions {
 	IPQ8074_ACORN_VERSION,
 };
 
+enum ipq806x_versions {
+	IPQ8062_VERSION = 0,
+	IPQ8064_VERSION,
+	IPQ8065_VERSION,
+};
+
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -208,6 +214,62 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
+					     struct nvmem_cell *speedbin_nvmem,
+					     char **pvs_name,
+					     struct qcom_cpufreq_drv *drv)
+{
+	int speed = 0, pvs = 0, pvs_ver = 0;
+	int msm_id, ret = 0;
+	u8 *speedbin;
+	size_t len;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	if (len != 4) {
+		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
+		kfree(speedbin);
+		return -ENODEV;
+	}
+
+	get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver, speedbin);
+
+	ret = qcom_smem_get_soc_id(&msm_id);
+	if (ret)
+		return ret;
+
+	switch (msm_id) {
+	case QCOM_ID_IPQ8062:
+		drv->versions = BIT(IPQ8062_VERSION);
+		break;
+	case QCOM_ID_IPQ8064:
+	case QCOM_ID_IPQ8066:
+	case QCOM_ID_IPQ8068:
+		drv->versions = BIT(IPQ8064_VERSION);
+		break;
+	case QCOM_ID_IPQ8065:
+	case QCOM_ID_IPQ8069:
+		drv->versions = BIT(IPQ8065_VERSION);
+		break;
+	default:
+		dev_err(cpu_dev,
+			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
+			msm_id);
+		drv->versions = BIT(IPQ8062_VERSION);
+		break;
+	}
+
+	/* IPQ8064 speed is never fused. Only pvs values are fused. */
+	snprintf(*pvs_name, sizeof("speedXX-pvsXX"), "speed%d-pvs%d",
+		 speed, pvs);
+
+	kfree(speedbin);
+	return ret;
+}
+
 static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
 					     struct nvmem_cell *speedbin_nvmem,
 					     char **pvs_name,
@@ -260,6 +322,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
+	.get_version = qcom_cpufreq_ipq8064_name_version,
+};
+
 static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
@@ -406,7 +472,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
-	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
-- 
2.41.0

