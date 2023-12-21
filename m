Return-Path: <linux-kernel+bounces-8957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156DD81BE83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81621F26029
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6AC4B13D;
	Thu, 21 Dec 2023 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT8ZL3JW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28676518E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33674f60184so1097338f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703184708; x=1703789508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/RAuun52j6HGK4kEaCxfb8okByL4QT7kA8t/dLOABg=;
        b=ZT8ZL3JWxWUxRX5BbRST4/yGRFGBoIuK5fojF4m92qRKkWVyLRgkbBrPU7stBf81Ox
         CqBRpIVhs3kwS6kBZuzVRaT+hxPObLhKxPJ8LNJRZkpzcMi32BF775orPDbNa7dV+F98
         3a36WqaDpnsLZWS4oL9ZjVwFQZs5YkQ2dvusPKw6VnBafWSR429UpvHGF+p9YhsRfuWF
         qjmMyx5LQe7IwhWvvYywNsoj7aoERZ6UPVVgyVJmcP6rc0AF9c+RdjdvZHQHhxyXDCV7
         yvJbJyA9Wi1JZ3VU3b4BhnzRnvtuwUC+ZzvchFBgLLixCB1dOUSQQt14utlgJTvcVl8y
         oKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184708; x=1703789508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/RAuun52j6HGK4kEaCxfb8okByL4QT7kA8t/dLOABg=;
        b=nT9FxvFrP4uNHHv133hc7yhBQyId6b2cCwbjHMlI28Fmpas2as+IHWlDoKLCRJbFlX
         Ls5IBqXN5ZIq6CsiUUT9yrYJ1+WWFjPtPp/jcYtSuBkZA7AfHe33kG/SOWPmJ8SJmR6L
         9AItYjNlAwW2vmru/+sBIEaEjAh7gES+BQcRZKV6CuiybM4ZdSwnRjRd4aT8GMt1mssV
         zDyX5K/Ym/4DHwkBNntvjp1FYJEKGMsoa/WwBP0eVmnk2etUIYQUft+CIEB0J9817gxT
         GyWVW26wwp+sT6mp4D4NhvJCkEKF4gp5gvsgfFm3OTgznYh1Yx6fWV1yPXpRKPejkRTx
         KZ9Q==
X-Gm-Message-State: AOJu0Ywjzt5vuKlinEpfQj6fInYJkZ60nweKagy6d2P2IvcnRpH9r3bx
	77zxtV2dAgCVE9O24ytebcLQQ28mQSbZ
X-Google-Smtp-Source: AGHT+IETw9cgX/GUIL+MuxgyEj1pirm95PG4E7oxAqm6bxRcppfr9mtDzC8qPNRpXI97hsv+NUMAAw==
X-Received: by 2002:a5d:4849:0:b0:336:8f9f:c69c with SMTP id n9-20020a5d4849000000b003368f9fc69cmr144677wrs.40.1703184707911;
        Thu, 21 Dec 2023 10:51:47 -0800 (PST)
Received: from localhost.localdomain (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm2585632wrv.89.2023.12.21.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:51:45 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 1/2] mfd: intel-lpss: Switch to generalized quirk table
Date: Thu, 21 Dec 2023 19:51:41 +0100
Message-Id: <20231221185142.9224-2-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221185142.9224-1-alex.vinarskis@gmail.com>
References: <20231221185142.9224-1-alex.vinarskis@gmail.com>
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
 drivers/mfd/intel-lpss-pci.c | 23 +++++++++++++++--------
 drivers/mfd/intel-lpss.c     |  2 +-
 drivers/mfd/intel-lpss.h     |  9 ++++++++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 4621d3950b8f..07713a2f694f 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -23,12 +23,17 @@
 
 #include "intel-lpss.h"
 
-/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
-static const struct pci_device_id ignore_resource_conflicts_ids[] = {
-	/* Microsoft Surface Go (version 1) I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
-	/* Microsoft Surface Go 2 I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
+static const struct pci_device_id quirk_ids[] = {
+	{
+		/* Microsoft Surface Go (version 1) I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	},
+	{
+		/* Microsoft Surface Go 2 I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	},
 	{ }
 };
 
@@ -36,6 +41,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
 	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
+	const struct pci_device_id *quirk_pci_info;
 	struct intel_lpss_platform_info *info;
 	int ret;
 
@@ -55,8 +61,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
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


