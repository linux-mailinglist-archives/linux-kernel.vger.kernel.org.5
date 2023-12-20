Return-Path: <linux-kernel+bounces-6490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9031819986
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190981C220C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD6618E3F;
	Wed, 20 Dec 2023 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQlEbAsY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A016430
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c31f18274so67958755e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057512; x=1703662312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgTfKXWY7XjvekdpFsE0LKPur0TdoR58RWZw0DnkjLQ=;
        b=TQlEbAsYS8edx3ya61BDjIT86GP3+Z+K2Bz/di8cJvkqRIhCnHfl47O7WNHucJLvF7
         /Hklx8SBYNpBBk2U6jS3ynNA/aYLjs2t2rAYnhj7uE/GZE0LbdqJSviVZQMPkeKoD08h
         7KlWZxd61M6bLD/EffE41k+9L0XQaD9tfH4jyG5XNXDWe/vl663g5V1TbhOEiy5mpakH
         5jNmu5etlL1+pvfy5IaYwMrJzxV6lkxWP5wxaUN5YPSdYxP+mEHHpv8mI+LMW9gmwWNz
         xlhDYDQLsvHeIuwmGdVfPPPjcxgB0Fr+DrgJd1zV6z/bvwsa3DQP8yi1rZCAdDdSGKEp
         JSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057512; x=1703662312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgTfKXWY7XjvekdpFsE0LKPur0TdoR58RWZw0DnkjLQ=;
        b=TJsZZGDYRA9IZL51b+48gOUpq04pKmvFXUFV7/lINLQTlO0cPl2yfy/v8RokucXDPh
         b6UEIpRK8TPhfboZtGyJI219FicXa49qh8migtfSTLN26cn2BZx6OIeXHlIu4f7G/n0m
         nzT5EeaGKKP+pCYyisAHgOq5z893veAmSI4r2RzPm+sOKlfAbHMc3ZAMCxXDA5iFmwTS
         MzI2V+nYpbhFvjrtSxQ5scdbgEH6zAGfAoJocQXlAD2a+C5g9g15TeN+21d1Fym86EQb
         8NJjAGdIsTs/AigkuC0STSL5/v8NGHNjwYMXRLPhEvuhvGEUl4athqKeoXeI8xaqgpvp
         yJwQ==
X-Gm-Message-State: AOJu0YwGjgJIfzHoi5TuG9IFaPTKTW/b/IpoFEVbKvSe+6EBgHWdWFF1
	GAQwKv7xJ39OILlnK6oosb0fpUcoFkSi
X-Google-Smtp-Source: AGHT+IE6OCx7xv9Ck8Ua1xJJjOOvuOQiCQa5MA3KZmAJTZXFR0gauoPXCD0l8/8mRJP+aBGkO1EUgw==
X-Received: by 2002:a05:600c:4746:b0:40c:6136:10eb with SMTP id w6-20020a05600c474600b0040c613610ebmr5976247wmo.36.1703057512145;
        Tue, 19 Dec 2023 23:31:52 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b003366a9cb0d1sm6348461wrr.92.2023.12.19.23.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:31:50 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: lee@kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	hdegoede@redhat.com
Subject: [PATCH v1 2/2] mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
Date: Wed, 20 Dec 2023 08:31:48 +0100
Message-Id: <20231220073148.19402-3-alex.vinarskis@gmail.com>
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

Some devices (eg. Dell XPS 9530, 2023) due to a firmware bug have a
misconfigured clock divider, which should've been 1:1. This introduces
quirk which conditionally re-configures the clock divider to 1:1.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 drivers/mfd/intel-lpss-pci.c | 8 ++++++++
 drivers/mfd/intel-lpss.c     | 7 +++++++
 drivers/mfd/intel-lpss.h     | 1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index cf8006e094f7..2e3b91418415 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -28,6 +28,11 @@ static const struct intel_lpss_platform_info quirk_ignore_resource_conflicts = {
 	.quirks = QUIRK_IGNORE_RESOURCE_CONFLICTS,
 };
 
+/* Some devices have misconfigured clock divider, which should've been 1:1 */
+static const struct intel_lpss_platform_info quirk_skip_clock_divider = {
+	.quirks = QUIRK_CLOCK_DIVIDER_UNITY,
+};
+
 static const struct pci_device_id quirk_ids[] = {
 	{	/* Microsoft Surface Go (version 1) I2C4 */
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
@@ -35,6 +40,9 @@ static const struct pci_device_id quirk_ids[] = {
 	}, {	/* Microsoft Surface Go 2 I2C4 */
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
 		.driver_data = (kernel_ulong_t)&quirk_ignore_resource_conflicts,
+	}, {	/* Dell XPS 9530 (2023) */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
+		.driver_data = (kernel_ulong_t)&quirk_skip_clock_divider,
 	},
 	{}
 };
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index aafa0da5f8db..2a9018112dfc 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -300,6 +300,7 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 {
 	char name[32];
 	struct clk *tmp = *clk;
+	int ret;
 
 	snprintf(name, sizeof(name), "%s-enable", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
@@ -316,6 +317,12 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 		return PTR_ERR(tmp);
 	*clk = tmp;
 
+	if (lpss->info->quirks & QUIRK_CLOCK_DIVIDER_UNITY) {
+		ret = clk_set_rate(tmp, lpss->info->clk_rate);
+		if (ret)
+			return ret;
+	}
+
 	snprintf(name, sizeof(name), "%s-update", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp),
 				CLK_SET_RATE_PARENT, lpss->priv, 31, 0, NULL);
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 3e9d96c372a8..f27834b74cb6 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -14,6 +14,7 @@
 #include <linux/pm.h>
 
 #define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+#define QUIRK_CLOCK_DIVIDER_UNITY		BIT(1)
 
 struct device;
 struct resource;
-- 
2.40.1


