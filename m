Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B75785955
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjHWN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjHWN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE8E78
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a1681fa868so681645866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797294; x=1693402094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNoAg3hhwJe0E4nipbDTVG4l0NGnowUgqTZLqUGua3g=;
        b=TGRsSZnB+u3ru0E46TXPB0Q42xGxM9KcB2+cu3i3SqpHxd/S0UMBbGKYqRaGy6puYb
         ODpg508g/r+4DBXIQdkA4DOfgJ70bx8rVSAFgmnW8TcKAW+RshCC48TNlQy5DzEIFkSv
         NzkJuJlvUl9ByGTwRoJEDUDc9Z35tPJ9jyzu4MieJ00rkGQhynXF5kuzC+B39x5EyG3+
         hS/s5HYLVnyQVMMOmu4pNNmoMvAB8CT8xs46BFkrXehaMV1t3T42KHI6VLleGYq/zZMp
         GocCycNgFzP8ktyNXemRCfrzHS96RsCxxSEXO1OYqjq/2chdBewkZ6QXwOf0hU8MYvV3
         Q4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797294; x=1693402094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNoAg3hhwJe0E4nipbDTVG4l0NGnowUgqTZLqUGua3g=;
        b=YCNc9wWoZVReU/QHBxIx3zgXWsAdR/nVcMDeOSdOmkOkMsIC8Gskaa54rFQQPRYy9x
         OErlDIih8UZHJuAUCVXAJM8RvvqWgf/s9nzZ5lYNrtPem3CnOF+kaECBdw9yRyM3K2CQ
         Jdwdrf05bzXCpXS1M2pHv1L/RrTg5v0rTfJ125VWzoa1Cm5/qN28qgRfe6QQlgdVwozg
         IsTi7vubuwNHrGlK5Rzg7LE1B2f8KNzzrTRVvKJ+V7iv5rtc5jSz6uAmsxxRP/WS1KT7
         i0SdJrWaa04XNvkG3PzVq0T8av4kCvyPF7XbIdtf1KnfGjCBMpV4j962JnUd8T8S4GCI
         yVyA==
X-Gm-Message-State: AOJu0YxGPUjm90dmelbbM/XkNvtfuBKHGBzYMsfiDS7mWFY47aDsaVKl
        WKksWrs60yQVi0EkvwatPHqRecv9Ss6NUZTXlB4=
X-Google-Smtp-Source: AGHT+IGciGoXzzi651ycVCxaNYLX0FNr3Bu6C+oy+WX4SDx/RumpGHHYKu+pv4DRSB8cy8sdFFoaXw==
X-Received: by 2002:a17:906:cc16:b0:99c:4c94:1aa5 with SMTP id ml22-20020a170906cc1600b0099c4c941aa5mr10210140ejb.51.1692797294433;
        Wed, 23 Aug 2023 06:28:14 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:13 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 17/22] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
Date:   Wed, 23 Aug 2023 14:27:39 +0100
Message-Id: <20230823132744.350618-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4763; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=URgIvjtKjhjwbkfjcnxyGX3VRlFKGX+zkI3++NTBPgA=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glJNdTFXNiJueCo2UyCDFO4XyclvVhbMtgaH ItQGEQ/+C2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSQAKCRB6of1ZxzRV N/xuCACCUNUMiV3VH1z8D8FjL0qSBH3nAcevWiLpVyqS6BfSTwET5PT8EM4mUqjr7j4sdM5vDWZ ySbIvmTaxgVK8pm0OAMXQGijIUzAI7JaEnTGyGhjnAwM2hJWopdAduvzU3BEAg755KcYhdoR5gP pLfngczMCUEJ68KMqX9Q0FklTGKhdF+p9ziQSK2OaPHFLq58jZ6DQyqy+mphoA8U5kXlN6KhEXv 0JSLz+2F89c2jsYY36DCOSsL9PMrRLsLC3+5IrYDQwOzKwbg+1jepHv3mQSK5K+6E0C3+sonukT eO/jWA0Q9QjMMStYnrvOhoeUQxl5eTqGLYAs9A9QgYKM+eee
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Komal Bajaj <quic_kbajaj@quicinc.com>

For some of the Qualcomm SoC's, it is possible that
some of the fuse regions or entire qfprom region is
protected from non-secure access. In such situations,
the OS will have to use secure calls to read the region.
With that motivation, add secure qfprom driver.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig      | 13 ++++++
 drivers/nvmem/Makefile     |  2 +
 drivers/nvmem/sec-qfprom.c | 96 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/nvmem/sec-qfprom.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 7ab12fc1044c..5bc9c4874fe3 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -226,6 +226,19 @@ config NVMEM_QCOM_QFPROM
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_qfprom.
 
+config NVMEM_QCOM_SEC_QFPROM
+        tristate "QCOM SECURE QFPROM Support"
+        depends on ARCH_QCOM || COMPILE_TEST
+        depends on HAS_IOMEM
+        depends on OF
+        select QCOM_SCM
+        help
+          Say y here to enable secure QFPROM support. The secure QFPROM provides access
+          functions for QFPROM data to rest of the drivers via nvmem interface.
+
+          This driver can also be built as a module. If so, the module will be called
+          nvmem_sec_qfprom.
+
 config NVMEM_RAVE_SP_EEPROM
 	tristate "Rave SP EEPROM Support"
 	depends on RAVE_SP_CORE
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index e0e67a942c4f..423baf089515 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -46,6 +46,8 @@ obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
 nvmem-nintendo-otp-y			:= nintendo-otp.o
 obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
 nvmem_qfprom-y				:= qfprom.o
+obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)	+= nvmem_sec_qfprom.o
+nvmem_sec_qfprom-y			:= sec-qfprom.o
 obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
 obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
new file mode 100644
index 000000000000..e48c2dc0c44b
--- /dev/null
+++ b/drivers/nvmem/sec-qfprom.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/mod_devicetable.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+/**
+ * struct sec_qfprom - structure holding secure qfprom attributes
+ *
+ * @base: starting physical address for secure qfprom corrected address space.
+ * @dev: qfprom device structure.
+ */
+struct sec_qfprom {
+	phys_addr_t base;
+	struct device *dev;
+};
+
+static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
+{
+	struct sec_qfprom *priv = context;
+	unsigned int i;
+	u8 *val = _val;
+	u32 read_val;
+	u8 *tmp;
+
+	for (i = 0; i < bytes; i++, reg++) {
+		if (i == 0 || reg % 4 == 0) {
+			if (qcom_scm_io_readl(priv->base + (reg & ~3), &read_val)) {
+				dev_err(priv->dev, "Couldn't access fuse register\n");
+				return -EINVAL;
+			}
+			tmp = (u8 *)&read_val;
+		}
+
+		val[i] = tmp[reg & 3];
+	}
+
+	return 0;
+}
+
+static int sec_qfprom_probe(struct platform_device *pdev)
+{
+	struct nvmem_config econfig = {
+		.name = "sec-qfprom",
+		.stride = 1,
+		.word_size = 1,
+		.id = NVMEM_DEVID_AUTO,
+		.reg_read = sec_qfprom_reg_read,
+	};
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct sec_qfprom *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	priv->base = res->start;
+
+	econfig.size = resource_size(res);
+	econfig.dev = dev;
+	econfig.priv = priv;
+
+	priv->dev = dev;
+
+	nvmem = devm_nvmem_register(dev, &econfig);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id sec_qfprom_of_match[] = {
+	{ .compatible = "qcom,sec-qfprom" },
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, sec_qfprom_of_match);
+
+static struct platform_driver qfprom_driver = {
+	.probe = sec_qfprom_probe,
+	.driver = {
+		.name = "qcom_sec_qfprom",
+		.of_match_table = sec_qfprom_of_match,
+	},
+};
+module_platform_driver(qfprom_driver);
+MODULE_DESCRIPTION("Qualcomm Secure QFPROM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

