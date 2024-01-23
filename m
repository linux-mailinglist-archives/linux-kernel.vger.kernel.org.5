Return-Path: <linux-kernel+bounces-34779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D580838765
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0298B249CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E156741;
	Tue, 23 Jan 2024 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0CgjR6D"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744955E5F;
	Tue, 23 Jan 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991349; cv=none; b=j8gzNDqM6ewcXj1S9lhE/nURpRdiF5RyMUyPYLJSRlVBp/TGQ2/nydiRnq0tcf2H5CmTzM3+EGYXzA0QJ0LnoyaSedJxVOdB2yKgQ5vS6agJU4HnSUqiW7N3M4hWwIAPWtncNdwaXAQmCl2bJ1bNu3FaSvrxRKmPB5uwdfRTu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991349; c=relaxed/simple;
	bh=B+jLOGEd1jBpOiOUxb17HltTAHAve69EOByggyZOxqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPMPSNjiTZEGc+LtoNTUz+s530f9coQecch8FzqpdUiVoZ5T7slYILdYcTZFxhiWysWkEtNXvCD74wXL7+Pf9t66fMigvecbtgFbpd80wmKw8aRoPpNTF7PZAtYxk4X0ATPm5ZDdamuNMKmNskn86hJfeKEFCM1fRZ2h1d6aPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0CgjR6D; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb53e20a43so2955548b6e.1;
        Mon, 22 Jan 2024 22:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991347; x=1706596147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+rUjdwohmexkGKxXXvs3YawFs1TyBScXYH26WbIGT8=;
        b=I0CgjR6DERsGqvwvZpRnURAIjg9+EOpqywF1haNUZkP2VftfkeZNwFYC48ONFnKaNy
         Ky3tVx3jUdnGRflIKoKBzyfR1L4yDLfDd/rPFtD70mCxdyI2Qlyf1bqNcID4f8SdMOqE
         QPBjSbEy8LfKXYGjLi9i79+Zai4noI8yqoINwaRUu7KdsvYjZq0yj70Kp00hdEyFkBdn
         ETMc0StkIP+a/1y7ZeDg+9j5Ah17ffAEoOYIDKulJMcfOVduqEAHvmU2aaXb312AMHvr
         T2SL4OmWWyeidZ+vH5eUKfLtgm1Zc8skQY8Akphodfj7FxPW4dgZGO5mpe3jy402xJqO
         iRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991347; x=1706596147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+rUjdwohmexkGKxXXvs3YawFs1TyBScXYH26WbIGT8=;
        b=GbN4Jq3jyF2pnZBfp8cnp4wL6ZHZLHZPoX3TqiyuDJJjT5KUuLst/IUl4SfUyd2JZ/
         LZ1RGpomLVGK0nJqRstCq/sHmu3R+CYisLV88MMF4jBtrSuGwk3VTXZkqQvMUf7MfK0H
         NZWn5ePuyTowEiY+3jmXlXIvowYIpuqxQqzdSeuqbrIAGIYGvd9abywFSA6uiMmjElcR
         y8H4YKOcP83FpWNmRpmIhcc7Rh6IvvEvr/R8SDcQLfFEWp7d2xr/yXC0mYtFSC0ocW+y
         mNJasoVf+l3P7JMiLoPoAnarbhZcGEw/Fa3DqIAFzCownYhmWeQnHpbZZu9+MjCQ1Ehc
         agWA==
X-Gm-Message-State: AOJu0YwF49niK4Ch2r0uA2eZRks6gUFS4h9ogbd+ZZhChkU2Ujg87wco
	m5d14zI/6XpZmSKwp5YS6Tdh0Ji+Wz5lnqcty7dzmwUn9HRRePpkTEJ4smpyV8I=
X-Google-Smtp-Source: AGHT+IEi8hVyUnhjJapz1M7KfnT+pyKPgV1/YWfpJhrbDq9FV7yuCwi/k4DamHL0/0AxnUfCxxi7Ag==
X-Received: by 2002:a05:6808:211c:b0:3bd:bef5:2be5 with SMTP id r28-20020a056808211c00b003bdbef52be5mr2148694oiw.19.1705991347060;
        Mon, 22 Jan 2024 22:29:07 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:29:06 -0800 (PST)
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
Subject: [PATCH V14 09/21] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Tue, 23 Jan 2024 14:28:15 +0800
Message-Id: <20240123062827.8525-10-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
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
index 81f2c4e05287..e1f47d252b06 100644
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


