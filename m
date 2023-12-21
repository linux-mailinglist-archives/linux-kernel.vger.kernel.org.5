Return-Path: <linux-kernel+bounces-8816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673D081BCA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217E6286C21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497505990E;
	Thu, 21 Dec 2023 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuqWpLdr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98758219
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33664b4e038so898806f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178677; x=1703783477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=44t2RGdqwMohlhVRZLEWbUrgttVDOnIiDhsLyjdrJ4Y=;
        b=OuqWpLdrkJP9XWXw0tD/IvKrd9zw5JWyCLZ+WUzbuGAP3ZCPwTzUY6ljjTGMPNGWUy
         sSugZPiMwKYYH92x56i02N04anMsLz6D+5UCFK+o6yRiMaIRHhduMuz2R0qve9Ry0dPI
         pecudfoIizJu/c6gpPZgGtOir2WIg4iuWuIyo3N+100HKtZXi/BtUvJG1//OcXUSDHev
         K6Ue3nCC3dPduawo08tZoaKsUyvT9Y32htEsidVBzGN1n5J3JXGe1RiIMv2PWhWIyXT4
         FTZ5Wk2ix+F2swImik10M2DXUEIt5SvM9ao22Jdkj4nkd71kZj/t2L383Bc/D49/7bMx
         QZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178677; x=1703783477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44t2RGdqwMohlhVRZLEWbUrgttVDOnIiDhsLyjdrJ4Y=;
        b=uAp/zPpdHqSE8sYXobVi9WEU1MHemVm/RjpYRUEA8UfOS+LuRJGHQbxyXrGOmgLSvC
         Eb3YBZV92M5djc0n34MeD74QpkTkotAq87vG7Ng02zu4gO4rIg4IXxI7T49kEYYPnlpH
         ZhzL2WCEDWbpMln1VKLAK4/s/4IbLtZQuILcFB513YymQQDuJhBZBQLdLHgcDy5YAlqm
         MwRHKmzoE2fONwCpNl+smKUtogxLlvIpqmUx8n97Ypf2B7tqNPPrLutfgKkH0W5ZCun+
         Vuog8KTrN9QLcgKqIpCWj8lTLriyfi1nt7ttP/x6McwTL47vGYzYdQtTmNfG+FIPVHmr
         2jXg==
X-Gm-Message-State: AOJu0YwHktwj/h5Y2I8T+N4fpg3Sscu+Cse6EtnyjusYbI8MWsT08vc3
	LAhpi/mgxw3hmbfCwXWT0B+LW4pmpMGt
X-Google-Smtp-Source: AGHT+IHVj7i+B8AKxIswDkUNQSMkjiMcjQcYXhzcDz0CSPlavUQD6nJK+rvLDfj7GtZ/3J0W7yJ6cg==
X-Received: by 2002:adf:a34b:0:b0:333:39fc:3945 with SMTP id d11-20020adfa34b000000b0033339fc3945mr48942wrb.12.1703178676935;
        Thu, 21 Dec 2023 09:11:16 -0800 (PST)
Received: from localhost.localdomain (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b00333359b522dsm2450116wrm.77.2023.12.21.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:11:14 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mfd: intel-lpss: Switch to generalized quirk table
Date: Thu, 21 Dec 2023 18:11:13 +0100
Message-Id: <20231221171113.35714-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce generic quirk table, and port existing walkaround for select
Microsoft devices to it. This is a preparation for
QUIRK_CLOCK_DIVIDER_UNITY.
---
 drivers/mfd/intel-lpss-pci.c | 15 +++++++++------
 drivers/mfd/intel-lpss.c     |  2 +-
 drivers/mfd/intel-lpss.h     |  9 ++++++++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 4621d3950b8f..433f9380a465 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -23,12 +23,13 @@
 
 #include "intel-lpss.h"
 
-/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
-static const struct pci_device_id ignore_resource_conflicts_ids[] = {
+static const struct pci_device_id quirk_ids[] = {
 	/* Microsoft Surface Go (version 1) I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS },
 	/* Microsoft Surface Go 2 I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS },
 	{ }
 };
 
@@ -36,6 +37,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
 	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
+	const struct pci_device_id *quirk_pci_info;
 	struct intel_lpss_platform_info *info;
 	int ret;
 
@@ -55,8 +57,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = pci_resource_n(pdev, 0);
 	info->irq = pci_irq_vector(pdev, 0);
 
-	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
-		info->ignore_resource_conflicts = true;
+	quirk_pci_info = pci_match_id(quirk_ids, pdev);
+	if (quirk_pci_info)
+		info->quirks = quirk_pci_info->driver_data;
 
 	pdev->d3cold_delay = 0;
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index eff423f7dd28..aafa0da5f8db 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -412,7 +412,7 @@ int intel_lpss_probe(struct device *dev,
 		return ret;
 
 	lpss->cell->swnode = info->swnode;
-	lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
+	lpss->cell->ignore_resource_conflicts = info->quirks & QUIRK_IGNORE_RESOURCE_CONFLICTS;
 
 	intel_lpss_init_dev(lpss);
 
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index c1d72b117ed5..2fa9ef916258 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -11,16 +11,23 @@
 #ifndef __MFD_INTEL_LPSS_H
 #define __MFD_INTEL_LPSS_H
 
+#include <linux/bits.h>
 #include <linux/pm.h>
 
+/*
+ * Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources.
+ * Set to ignore resource conflicts with ACPI declared SystemMemory regions.
+ */
+#define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+
 struct device;
 struct resource;
 struct software_node;
 
 struct intel_lpss_platform_info {
 	struct resource *mem;
-	bool ignore_resource_conflicts;
 	int irq;
+	unsigned int quirks;
 	unsigned long clk_rate;
 	const char *clk_con_id;
 	const struct software_node *swnode;
-- 
2.40.1


