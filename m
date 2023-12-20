Return-Path: <linux-kernel+bounces-7430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A5C81A7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26481C227C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADDF4A990;
	Wed, 20 Dec 2023 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUklGEgr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACB48CF0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2698cff486so9507266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703105783; x=1703710583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oHi9oMFl/DdYjde2/GrMKXwoQyt6JOVi8ffwnrj44A=;
        b=hUklGEgrQcsJbQmzircuhB88lW5C4iPSvw1Z6/hedAzoL2SqM6a1ob626VcCp2le7M
         5dXFtMuHS6KMH0a4hcMaYcDqE0dSZNLf/8xg29QUElnoMbXnIwdILvh15QrFJ2mgSMA6
         SSQW5NqcOM6vKDaIPlgCYSP8OM2JLj3LXLmDhuNqrM9kmqrTTKSkbPkpcRrkJtl4N9EZ
         4Fr9QHMilQdMKA4k2LjDIab5MCtu5pb7vOUVmzwNe538GcuMGrvWiMzAxFYO20vH/8QR
         cuLrKO/xe2vKfh60dEsKvtcBe8xAHNNx4tG7+hx5P+v2HggT5iQSoAaGvjyb1Ml+4P72
         dfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105783; x=1703710583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oHi9oMFl/DdYjde2/GrMKXwoQyt6JOVi8ffwnrj44A=;
        b=m+Ut5JBH47DLsyMbh7UkQti/6wrd68OXWujkpZbqcThJr46O//qQ3dRWLwyy8B8skL
         A5D5R9uCaOWoYkZ1c7Q55L1igTzNfyS4QhkwoI62AgCezcl2OiWh4MyWaAR55I2oEKFM
         DoncKru28BMo+Hx3rOK0JBAunOYsLV3nrF3kMwH1MJhui7+0gGtIiMLqoPoVpVQ3FXGW
         hPEAgpUhCndK3IFkDNI/kLoot1klhJcJox4pxm81XZkAwOvyL+xnboP5cv2k8vyBwGuh
         znNfsoI9X2BGMwypdgO4eIzyMMyJzSd++KQf9W1PkL4MZtkOtvUgc7mYFcv3drcfYSDv
         KwXQ==
X-Gm-Message-State: AOJu0YzYXP640Y3SiiyP5YAPMg7wM6+gj1zwdj/mJPALihRkE0QHjeXm
	jREunbAhYSX5DxsoSG9D8A==
X-Google-Smtp-Source: AGHT+IE2IC7gVlP+p2UBEjVzHPYm0VRjiR4vF4G6sKTVfbBS+/HM08UffR6aur0RSLtOKYHqHJCRrA==
X-Received: by 2002:a17:907:160c:b0:a23:748e:f3eb with SMTP id cw12-20020a170907160c00b00a23748ef3ebmr1429801ejd.286.1703105782594;
        Wed, 20 Dec 2023 12:56:22 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906d20a00b00a1d9c81418esm204377ejz.170.2023.12.20.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:56:22 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: alex.vinarskis@gmail.com
Cc: andriy.shevchenko@linux.intel.com,
	hdegoede@redhat.com,
	lee@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mfd: intel-lpss: Switch to generalized quirk table
Date: Wed, 20 Dec 2023 21:56:20 +0100
Message-Id: <20231220205621.8575-2-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220205621.8575-1-alex.vinarskis@gmail.com>
References: <20231220073148.19402-1-alex.vinarskis@gmail.com>
 <20231220205621.8575-1-alex.vinarskis@gmail.com>
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

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
V1 -> V2: Removed unnecessary intermidiate data structure 

 drivers/mfd/intel-lpss-pci.c | 22 +++++++++++++---------
 drivers/mfd/intel-lpss.c     |  2 +-
 drivers/mfd/intel-lpss.h     |  9 ++++++++-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 4621d3950b8f..f8454d802677 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -23,13 +23,15 @@
 
 #include "intel-lpss.h"
 
-/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
-static const struct pci_device_id ignore_resource_conflicts_ids[] = {
-	/* Microsoft Surface Go (version 1) I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
-	/* Microsoft Surface Go 2 I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
-	{ }
+static const struct pci_device_id quirk_ids[] = {
+	{	/* Microsoft Surface Go (version 1) I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	}, {	/* Microsoft Surface Go 2 I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	},
+	{}
 };
 
 static int intel_lpss_pci_probe(struct pci_dev *pdev,
@@ -37,6 +39,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 {
 	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
 	struct intel_lpss_platform_info *info;
+	const struct pci_device_id *quirk_pci_info;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -55,8 +58,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
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
index c1d72b117ed5..8a1ffd4f3546 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -11,16 +11,23 @@
 #ifndef __MFD_INTEL_LPSS_H
 #define __MFD_INTEL_LPSS_H
 
+#include <linux/bits.h>
 #include <linux/pm.h>
 
+/*
+ * Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources
+ * Set to ignore resource conflicts with ACPI declared SystemMemory regions
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


