Return-Path: <linux-kernel+bounces-153209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68C8ACAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D247B22013
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E0114F116;
	Mon, 22 Apr 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cseUoHGF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB314EC74;
	Mon, 22 Apr 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782310; cv=none; b=g6HDk1WznNkbIUJ/DqFi0Je2pZYX+QjSNn7FHfXYtxe1qIY++01xrXgCCQz8cO3DflKAOOx4Yl0PvLSBBc3MV79c6JdH+oOX8mzl15/ocFgn/eBljFH+B1u3yTxwWQMm6w1pCGrue5IyuMdROlwLRWp6X7sTl2XOSzaEVFPlPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782310; c=relaxed/simple;
	bh=vENF9HCmcpJXEqgwxvddYUAdwYA+NrUfNCsZT+T4wFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fsj/UkYyvUyXvigkauMJ/63/4SjmHqItv1/qhg0R9ppillA46WF+3gGvOTBGw8zym3Ip3JrJcfbvZyCyrzKqckSyy3On9DxgvxXtRO1SzjafhEbSYPcnqzmebyXkMj8YkKzwLEGmkNoFBJehReqyN+iiwk1ASx18qGNgXfhNooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cseUoHGF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5715a9ebdso34005145ad.2;
        Mon, 22 Apr 2024 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782308; x=1714387108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4ulBUi6egoC57FE+2wADM8HkpJFXf6Ty5HbDsYr4Os=;
        b=cseUoHGFGu4xtqzc1dtg7UliTliBOOp8KPEOKdiPyZDNrBXGhBC/mbMnxff157Ml0g
         BfI8KBCieifN6jnPQzG605DYkHbGoxAuXEvTPKdytC29JZR9ehu8UTcuce3kAMuE0oxF
         bWmfu/HKxOrWZjjrEWq62XpzTgnZEpNhL83ghlx5Cjya9sZcqOg0/sJ77Z/zQrMFkIf+
         iC3/0iaDxLhpZpxu2wcuB8JrROe5VxNgWbDxS6eYcv0ArlanAQv23JXVBk+J2w6Orgs3
         ckXT50SBNZ99qKLaAR2rfZfACAChvCp407gTPitJBd3FeK4Z3ClR4vSGl6Cdf51uAUdb
         N4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782308; x=1714387108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4ulBUi6egoC57FE+2wADM8HkpJFXf6Ty5HbDsYr4Os=;
        b=KjXuNkev/gBHV2be1LX19mNuQwBwrUOoBJ9YoTP+3Vas1tCG/zFPhYLfHOCGiTCrxG
         /D/++7XYBE5EgXGMHANGifJDKSKY6nN30BFdknfPX76blDyJu+e0PSxCzuZ4d+pFs1dJ
         YD0qlb+KVecaEYVvjmenT/wYk6MSWO/aXxGw5pZIesFYm2z89frG1FJAfhxGPdV5pR8O
         0TO9szOmTGWDqUAGvtdeRM1GtVBBsO8xEqOBppKOX0U++AlxV0kCOb0pgXFXVOge8oDn
         sZMdwSVAJG8veHS+Up2U0pSCSgHD8XD7Rmxh0ZFRkqnhq4Uq2TfJHAm8R7NapDGXnKdY
         OBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfcevCu9AAV+FvY7YGVYJcUmAYhW2dBuQJl1kotsjRB5hgdQXKN/ei8evHGrwHqSyRTGlH4L+rk9BG5jO+b/+mHF84upKpjNdU35ZF
X-Gm-Message-State: AOJu0Yztg1+6KaaUNLoXLT0mvRhTZtJGvG0C7nxMJT3QbxeKLqASWQj/
	qhD3CK3dq8nC3afe0/MGmv44KcT2UDXgrodC7xsL1GU5L9VInUJr
X-Google-Smtp-Source: AGHT+IE+7TA53BxnXHwh2XU08aAeX4ky7fYfgdGVrEOYDKcJxJmU+p+laSlKF5AfwBRiRZzREX0rCA==
X-Received: by 2002:a17:903:2489:b0:1e7:8d21:7fd7 with SMTP id p9-20020a170903248900b001e78d217fd7mr7995617plw.28.1713782308283;
        Mon, 22 Apr 2024 03:38:28 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:38:27 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V15 09/22] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Mon, 22 Apr 2024 18:37:32 +0800
Message-Id: <20240422103745.14725-10-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422103745.14725-1-victorshihgli@gmail.com>
References: <20240422103745.14725-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index bb0d4fb0892a..342bbc3ef577 100644
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
index f53f86d200ac..fc064a3030ca 100644
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


