Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F905785951
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbjHWN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjHWN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41ED1720
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c0cb7285fso715068966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797289; x=1693402089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMjewjbqgRLUDOfDr2fvd0INz7ulNUEmSWxMy1iHfM4=;
        b=QC8WNOEnw83dUT5oLd4d2HU/C2dd/BNWFk3OexfbGtxK6yjbI8iCfj1LGJ3Xzu4Mkj
         JOJm1LmB/apLw0J7055bbDA70G0oR0cHm15chwcPAvyWnKn3DUXPMUW7NP8blC0NORM0
         iatSkNk+71oFzDdPasLixE9G59bN+DGHwSTP7QPyG/JIhvc2sWaMotQzf4v/JLtMPiWp
         wnhSrG/5wypZGLP9C37Hu1bNsTV4QT7cmqA+MxxxfymOfVfG87xwbwxXVy8TCUplROuj
         Z4dvMHD14DzYOgQncGZzU+CJ8Qkeul2tvFzYxHLiqFlMVtpIXAXRn/FH668xRVyP3f0j
         s0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797289; x=1693402089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMjewjbqgRLUDOfDr2fvd0INz7ulNUEmSWxMy1iHfM4=;
        b=LqrdqDMxd6xdaNaDdBv/HDwqLYR6hRoeahGB+RKO7bPzK9rs/DP1cNTaO5iT12byP9
         OphXu0qYv6/tVqPSKEeZCeomib+EwrdtToCCgsvNCl1HGxNgNWsCsj1SWamRQbsPhjEb
         D96Eug/nfFCYk0grftGw3+cp0KSn4gmgmd1D7MtHXUAf/LUF5BDKEA4JBxMAQ1Z9dsCr
         usI+f/Kpx9isIDoXSmSwwrNRkJgguDBnCRrLY1/Mp5PIqY6saXtCCZJHTjoRbuEP7liV
         wLCvqVkNzXeBolohUk2VVXgwpgQIOqx3k3hDK37LcQFKNYvvqoqlpE+6QvmtX89HBkzR
         GsUw==
X-Gm-Message-State: AOJu0YwMFkVUtZlV58V7KabA5K2Y/6oN2eHj7d25HNjsZXrhHdhZKBHF
        027rw/MAgILsCMRw2JrPVsXF3A==
X-Google-Smtp-Source: AGHT+IGrvIxVqHeFC2jS2OeOZgWiruNGsPoceBz7kOZgnYDpuSImdznIVFg7VB5mkP9tBIX8kuJ6Xg==
X-Received: by 2002:a17:906:20d6:b0:9a1:caa8:2061 with SMTP id c22-20020a17090620d600b009a1caa82061mr2354482ejc.23.1692797288961;
        Wed, 23 Aug 2023 06:28:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:08 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Richard Alpe <richard@bit42.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 12/22] nvmem: add new NXP QorIQ eFuse driver
Date:   Wed, 23 Aug 2023 14:27:34 +0100
Message-Id: <20230823132744.350618-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4189; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=YdhH6iItu2C4qF1b74Vy48ysltYv9i8utmZeJSeqkO0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glIJ4z+MlwShrixTo43S2bBQE1eQHgrm4XBh b5GvX1Hai2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSAAKCRB6of1ZxzRV N8wrB/9t/WiARB7SG5/GVagKb6z9sOiTL2rqsTeHPml9fK52ulFcbVlbVlmT9/Q569ls5MRMjtx hKEBCQVk9NNFPMBfYoOq5H/qEVMopj+5bzJz3Sy2GdtTPzt4i7VrN5nKbkIDlLZRDAB8Bb92Vko FUdLYvZbZ4z7SM+eLkGZdzeBMDRYoBx6BewZ8xtFs14CUy7YcLe42NNjg9sTPbIu0I0Ju0lHJMw WzZM9Y0HUQaQu5xbFQdZQyiysoF3gKHklmgSsJP9OFfYrJfXWQ7pq50c/CpMFBX+khvekoXDAak lglUdeB1b4a/iipryU3OsiV2opJxNDLCya8pVXY8o4aI6czL
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

From: Richard Alpe <richard@bit42.se>

Add SFP (Security Fuse Processor) read support for NXP (Freescale)
QorIQ series SOC's.

This patch adds support for the T1023 SOC using the SFP offset from
the existing T1023 device tree. In theory this should also work for
T1024, T1014 and T1013 which uses the same SFP base offset.

Signed-off-by: Richard Alpe <richard@bit42.se>
Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig       | 12 ++++++
 drivers/nvmem/Makefile      |  2 +
 drivers/nvmem/qoriq-efuse.c | 78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/nvmem/qoriq-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da9befa3d6c4..5c5d7414f78c 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -392,4 +392,16 @@ config NVMEM_ZYNQMP
 
 	  If sure, say yes. If unsure, say no.
 
+config NVMEM_QORIQ_EFUSE
+	tristate "NXP QorIQ eFuse support"
+	depends on PPC_85xx || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver provides read support for the eFuses (SFP) on NXP QorIQ
+	  series SoC's. This includes secure boot settings, the globally unique
+	  NXP ID 'FUIDR' and the OEM unique ID 'OUIDR'.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_qoriq_efuse.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index cc23ce4ffb1f..e0e67a942c4f 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -77,3 +77,5 @@ obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
 nvmem-vf610-ocotp-y			:= vf610-ocotp.o
 obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
+obj-$(CONFIG_NVMEM_QORIQ_EFUSE)		+= nvmem-qoriq-efuse.o
+nvmem-qoriq-efuse-y			:= qoriq-efuse.o
diff --git a/drivers/nvmem/qoriq-efuse.c b/drivers/nvmem/qoriq-efuse.c
new file mode 100644
index 000000000000..e7fd04d6dd94
--- /dev/null
+++ b/drivers/nvmem/qoriq-efuse.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2023  Westermo Network Technologies AB
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+
+struct qoriq_efuse_priv {
+	void __iomem *base;
+};
+
+static int qoriq_efuse_read(void *context, unsigned int offset, void *val,
+			    size_t bytes)
+{
+	struct qoriq_efuse_priv *priv = context;
+
+	/* .stride = 4 so offset is guaranteed to be aligned */
+	__ioread32_copy(val, priv->base + offset, bytes / 4);
+
+	/* Ignore trailing bytes (there shouldn't be any) */
+
+	return 0;
+}
+
+static int qoriq_efuse_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.dev = &pdev->dev,
+		.read_only = true,
+		.reg_read = qoriq_efuse_read,
+		.stride = sizeof(u32),
+		.word_size = sizeof(u32),
+		.name = "qoriq_efuse_read",
+		.id = NVMEM_DEVID_AUTO,
+		.root_only = true,
+	};
+	struct qoriq_efuse_priv *priv;
+	struct nvmem_device *nvmem;
+	struct resource *res;
+
+	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	config.size = resource_size(res);
+	config.priv = priv;
+	nvmem = devm_nvmem_register(config.dev, &config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id qoriq_efuse_of_match[] = {
+	{ .compatible = "fsl,t1023-sfp", },
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, qoriq_efuse_of_match);
+
+static struct platform_driver qoriq_efuse_driver = {
+	.probe = qoriq_efuse_probe,
+	.driver = {
+		.name = "qoriq-efuse",
+		.of_match_table = qoriq_efuse_of_match,
+	},
+};
+module_platform_driver(qoriq_efuse_driver);
+
+MODULE_AUTHOR("Richard Alpe <richard.alpe@bit42.se>");
+MODULE_DESCRIPTION("NXP QorIQ Security Fuse Processor (SFP) Reader");
+MODULE_LICENSE("GPL");
-- 
2.25.1

