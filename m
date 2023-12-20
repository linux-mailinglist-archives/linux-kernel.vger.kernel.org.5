Return-Path: <linux-kernel+bounces-6489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D3819985
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E503E1C21B44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCF1168C6;
	Wed, 20 Dec 2023 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAFGEOXG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1BA1640D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-336755f1688so1143468f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057510; x=1703662310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li7fTALBuQ9Y3zgS/Ez2vT3o1PVceUgO0II6eATZKYQ=;
        b=RAFGEOXGdD7P8015P3lNuQlL5kWVZekqrKmEHK0pvFDDB54RUM72P1HO0rPCieTxG0
         9RkCR36e9xLY7sqy4gJ73g7KzlfzkBS5y+4wwBdI9DOSjdQbVlJE+oXUDBlcPxlA6ifE
         ZA01Lh+KEz5sNt20gvVHOwj/b19dNeuQhcaXzhc++L+aoRxc0wf7KtgRG/W7gDAcHzbm
         ShBH3+TEtptIZa2pdTlH3aoVVkxJFK3oX7S3IbPB4n3wfZhhFA4q35IyeWvZJ1KnbARZ
         FDuXB40lwK2GkBpB6rHiwY78LbdoO9nemSZpHewze5udvXUlui6eSCnSad9AbEI9M3jJ
         rPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057510; x=1703662310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li7fTALBuQ9Y3zgS/Ez2vT3o1PVceUgO0II6eATZKYQ=;
        b=RoFWOlD423a5Yu23R5U3aTO57qCgUESDHzD83atyykgjS/FFjDJamgIMV4imr8jjmS
         JCjwstiQnLT8AFcMIq/M/fxBxKoagmO/0WveV36PVBvAN4qS9YdRx0RBdnEhwaeKaT/8
         jYizXCG42hpHrIWryXrTra6QoZL2BlMqoFtLlssXkWig9Br82hoaJ+NR68gHA7rDYEB2
         LQ9rmp7ltd5QGazL9eqGskNndsAH2RQO+fZJwavfZQ479p4WwQnRMSh76PtUcP297raO
         usTjxlJ7xq8yQ3OYgCW+FZG//6EMFUNII4VZjKNlUvsCXmZ1b0cjTMLpJ0G3jiqBPlkh
         rewA==
X-Gm-Message-State: AOJu0YwHrD6AOGV1C/u+DUivU4P5b5W+eX0BaIcR5qMcYFyHckrS/JUK
	h8hpj0cPIY/igH2N1Z6sdA==
X-Google-Smtp-Source: AGHT+IE36QPz6XDiLYD/iC/UKtLshIoHjRygoMgFFQmfYkwhJc9MyZyp971jwxL6u/tvaT7LJEyPNg==
X-Received: by 2002:adf:e490:0:b0:336:6817:92e3 with SMTP id i16-20020adfe490000000b00336681792e3mr2553999wrm.89.1703057510581;
        Tue, 19 Dec 2023 23:31:50 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b003366a9cb0d1sm6348461wrr.92.2023.12.19.23.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:31:50 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: lee@kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	hdegoede@redhat.com
Subject: [PATCH v1 1/2] mfd: intel-lpss: Switch to generalized quirk table
Date: Wed, 20 Dec 2023 08:31:47 +0100
Message-Id: <20231220073148.19402-2-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220073148.19402-1-alex.vinarskis@gmail.com>
References: <20231220073148.19402-1-alex.vinarskis@gmail.com>
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
 drivers/mfd/intel-lpss-pci.c | 28 ++++++++++++++++++++--------
 drivers/mfd/intel-lpss.c     |  2 +-
 drivers/mfd/intel-lpss.h     |  4 +++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 4621d3950b8f..cf8006e094f7 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -24,12 +24,19 @@
 #include "intel-lpss.h"
 
 /* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
-static const struct pci_device_id ignore_resource_conflicts_ids[] = {
-	/* Microsoft Surface Go (version 1) I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
-	/* Microsoft Surface Go 2 I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
-	{ }
+static const struct intel_lpss_platform_info quirk_ignore_resource_conflicts = {
+	.quirks = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+};
+
+static const struct pci_device_id quirk_ids[] = {
+	{	/* Microsoft Surface Go (version 1) I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
+		.driver_data = (kernel_ulong_t)&quirk_ignore_resource_conflicts,
+	}, {	/* Microsoft Surface Go 2 I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
+		.driver_data = (kernel_ulong_t)&quirk_ignore_resource_conflicts,
+	},
+	{}
 };
 
 static int intel_lpss_pci_probe(struct pci_dev *pdev,
@@ -37,6 +44,8 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 {
 	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
 	struct intel_lpss_platform_info *info;
+	const struct intel_lpss_platform_info *quirk_lpss_info;
+	const struct pci_device_id *quirk_pci_info;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -55,8 +64,11 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = pci_resource_n(pdev, 0);
 	info->irq = pci_irq_vector(pdev, 0);
 
-	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
-		info->ignore_resource_conflicts = true;
+	quirk_pci_info = pci_match_id(quirk_ids, pdev);
+	if (quirk_pci_info) {
+		quirk_lpss_info = (void *)quirk_pci_info->driver_data;
+		info->quirks = quirk_lpss_info->quirks;
+	}
 
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
index c1d72b117ed5..3e9d96c372a8 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -13,14 +13,16 @@
 
 #include <linux/pm.h>
 
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


