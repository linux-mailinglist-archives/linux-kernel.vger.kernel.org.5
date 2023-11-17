Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB24C7EF1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbjKQLcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345989AbjKQLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:32:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6BB19AA;
        Fri, 17 Nov 2023 03:32:26 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so1670433b3a.1;
        Fri, 17 Nov 2023 03:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700220745; x=1700825545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOtRLRGkXxx0VmodeVlJit5RooY/9FqLm/ivq6a+Pf4=;
        b=nJ6LwaYIiQTVFrh9nxMyvOmMv6jg6/yAl6+3zDJC5QIfR7FC4w2PJ8NymYTVfGZCgf
         FvqaT0P1JcrG7B5lvxwg/HVYoYDyjiXN2VVB744NZZFW7zHM3fORYeXnbWUFToLrc/82
         Y6XlrUBPoI2r1vFAkCKkRkbWqhvigqZz68TvHjAmD9SnYFYSyffngOqxUTtB+w2CTT1J
         7YjKXgreI+CIz7r/J/hcsyniNA7ldotXZ6AKgEYLJPkb0SXiV7x31KqMOk/HdsWaaJrV
         SUr8Gip1LZ1m5Exmmy0ASDNlH799aaPm7ezUUn0TxY+WV9SFf9+WYq49Y6vQcjYX11u+
         ggpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220745; x=1700825545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOtRLRGkXxx0VmodeVlJit5RooY/9FqLm/ivq6a+Pf4=;
        b=BJDSKlIlzD0i+UgJlSy3FWm8nQtOmh7RgvXtupoVl9RsLbwj45GRo+JyAzqB39I/ow
         wFWPlb+B+kC7fkcNeMMcnO6j2KDaU2W87yTRWm010z+lSuX6qfOaPGh35xEZeSfT+cfo
         MedHzF9HBBb960ChtCOuk0e7cuqGQZ3lBCpfHxvhGIT/xmQnU95zitUnjfg64LOave66
         nU2rTWhbD5Y0+HFAGlbMJnDZYx7nnTnP7MYtB2fr7Oi8JiyGtKYywE9DpPSDpwlOFsVa
         hGFQN2R1zb/JrVVzvQw3j/b6q06Y4I+nby1h3a3qM0mqAfcqlFRtA36UBIdaiFhMo70+
         H+8g==
X-Gm-Message-State: AOJu0YyVYdGjD3aBZp3vCrmvmsRWmqV/+ev+N61qD/G1HDc1pTD/bLjQ
        7lQJ7N7n6AI/ZD6A16lN914=
X-Google-Smtp-Source: AGHT+IGNAOuah2qyf5sUuohXvePxLX7nznjYJuchSmpO9YHS3i+QiPPUhViQEeSIWOCywubZ8EUJWw==
X-Received: by 2002:a05:6a21:1f05:b0:180:d33d:9256 with SMTP id ry5-20020a056a211f0500b00180d33d9256mr14551583pzb.58.1700220745442;
        Fri, 17 Nov 2023 03:32:25 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e286-d458-bc89-d4cd-bd42-ffb5.emome-ip6.hinet.net. [2001:b400:e286:d458:bc89:d4cd:bd42:ffb5])
        by smtp.gmail.com with ESMTPSA id u2-20020a631402000000b005b4b70738e5sm1229224pgl.8.2023.11.17.03.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 03:32:25 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V13 09/21] mmc: sdhci: add UHS-II module and add a kernel configuration
Date:   Fri, 17 Nov 2023 19:31:37 +0800
Message-Id: <20231117113149.9069-10-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117113149.9069-1-victorshihgli@gmail.com>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This patch adds sdhci-uhs2.c as a module for UHS-II support.
This is a skeleton for further development in this patch series.

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V9:
 - Modify the commit message.

Updates in V8:
 - Modify MODULE_LICENSE from "GPL v2" to "GPL".

Updates in V6:
 - Merage V5 of patch[7] and patch[9] in to V6 of patch[8].

---

 drivers/mmc/host/Kconfig      |  9 +++++++
 drivers/mmc/host/Makefile     |  1 +
 drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 58bd5fe4cd25..46a722270ad0 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -98,6 +98,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index d0be4465f3ec..1a7c8abc7891 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
new file mode 100644
index 000000000000..608f8ad5aaed
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
+ *  Interface driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *  Copyright (C) 2020 Genesys Logic, Inc.
+ *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
+ *  Copyright (C) 2020 Linaro Limited
+ *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <linux/module.h>
+
+#include "sdhci.h"
+#include "sdhci-uhs2.h"
+
+#define DRIVER_NAME "sdhci_uhs2"
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static int __init sdhci_uhs2_mod_init(void)
+{
+	return 0;
+}
+module_init(sdhci_uhs2_mod_init);
+
+static void __exit sdhci_uhs2_mod_exit(void)
+{
+}
+module_exit(sdhci_uhs2_mod_exit);
+
+MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
+MODULE_DESCRIPTION("MMC UHS-II Support");
+MODULE_LICENSE("GPL");
-- 
2.25.1

