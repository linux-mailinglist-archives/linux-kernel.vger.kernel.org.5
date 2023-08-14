Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55C77BE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjHNQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjHNQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D1E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-525656acf4bso1659561a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032034; x=1692636834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDmOXVWhYPmj90IFtf5XFIMoKYTfFoTMC+SvIwE3SCU=;
        b=j5xFguPTYuBFSY6tcGqssy/lflJx9f6PDmb67p1KAWpPCKN5tR3ZhhcEtyTxDQXqgZ
         AH3uco6dNFrAB1fgSJh6/xiYSYUU1fyhd1mX0zuJEs9tVt+DGJq8eyVAJ4GpREzPlAHM
         VAppv5sS+W2VkGdVCGHl6JEPF84UgTJZ809lYtWHNhF6ss30dgIXbKPZoDTius2CPygh
         +X8UmCM5/J9wLGOHCcPw8EP/Vs+PZEWs3SZgHsH+2IZOE3YUIPkIh1ChnRSOVho6REz3
         z7/ZYYm6+NoMnZ6IgML4lEwThO7TBJ/Zv7oNJ6JNW38SRlDq+VsSDfSvWW3nPbE42gXk
         av3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032034; x=1692636834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDmOXVWhYPmj90IFtf5XFIMoKYTfFoTMC+SvIwE3SCU=;
        b=XwHifEaWuJjdhkQciE+bBXUt9hcztIGtwz5ahIXYCkDRHo3JShph6/zVx4Ubc0cr73
         2oaIBgH/acGSUdCZKukBzHodsQziFNS8owfrIMs8l4tcHK7FF29jUDr8eczaryOLHbF0
         p0GrAvMqY55SbVI9u71DckVW1zkuS9hvnXk6/4pp0YobMkqpbzGlTDfaZRbn/kbvbdqD
         HMx+cduhzGhXXC1O8cTYmwTwd59p9vOJOU9r0TVE3HkS+8Q1vCZRcLuBANEPUYyU61+/
         xXq8HalpU6xMkV16hdyIhYIx1+Ao1sbbt44Upj4ASKOUqGfpUoARnq+/oB0uJQSTKdLC
         sGwQ==
X-Gm-Message-State: AOJu0YyrW3Z3XhFvWjJkZeQFEj3UHGnAD4b9JBEdINEEEjdO4JryrQWx
        rgwEB2ul//ywMRJqvQxR+ExjNQ==
X-Google-Smtp-Source: AGHT+IHbtq78lv/+xmlj8gSo4G4cqnIHa45bEQZLNjI1JFwghN+7KcmkrihCZLyGtfWK5Ka8UIe7ZQ==
X-Received: by 2002:a05:6402:12d0:b0:522:3ef1:b10 with SMTP id k16-20020a05640212d000b005223ef10b10mr7229906edx.6.1692032034307;
        Mon, 14 Aug 2023 09:53:54 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 17/22] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
Date:   Mon, 14 Aug 2023 17:52:47 +0100
Message-Id: <20230814165252.93422-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/nvmem/Kconfig      | 13 +++++
 drivers/nvmem/Makefile     |  2 +
 drivers/nvmem/sec-qfprom.c | 97 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
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
index 000000000000..868a91c81197
--- /dev/null
+++ b/drivers/nvmem/sec-qfprom.c
@@ -0,0 +1,97 @@
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
+	int ret;
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

