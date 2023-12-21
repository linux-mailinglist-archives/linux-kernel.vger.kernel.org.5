Return-Path: <linux-kernel+bounces-8958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA26F81BE84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8203B252C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA773192;
	Thu, 21 Dec 2023 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeRN1MIY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4224651B0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3368b1e056eso674325f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703184710; x=1703789510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JVWB86A7u7nOiumhApeayaZD5D0qLKZ2ERiwr5pqqE=;
        b=HeRN1MIYq3a67PSubOb169acSRCmB7RsPJSH2r4G8udYlXZp0H4xVlCg4oIsm1/huq
         +6tw0ocu3Ftoc+6NTJKVk/6QMOxzaXrUO/8rIi/N+nqOHj1K73RTuyLXTfEyAKbUvbJo
         Zw0HvW0HAaR/WWhQm+A/BHZYW6xW/AA8AfiPvb76NvYjctulo80Xm7r6s4Cxq5pte5om
         fUnAl6MMjMILkRLxjqJ5I43/tw9kyRwbEu0Dgb8/bZWSVcTDGlXn38C1avLka/gR+xHq
         LAwHlafWOVhsL1aUOcD2pulwhaG4sBE2VldOC8flY3CiuzAxPiTHdt9zZdyXX3dagjp5
         evMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184710; x=1703789510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JVWB86A7u7nOiumhApeayaZD5D0qLKZ2ERiwr5pqqE=;
        b=Wtgdc+bsyv6gxhUD6weohbSmC7TcxeKgMSWUIh3+H2SC76l8P+LO93IbNybMLeP4Vg
         RUkWBEQQQWHlrSzrZi6EfVClvc6Yl9p4/OWonrU0PuAugS+Lx/Z7Ea9hArIjbAvh47pb
         2QmNmugiuZxKF1nXiY0DUDKr+Sbjw15NMaxfUXTk8ZzkZNeyKs1QKR+HH4k8WR/KpxkZ
         mvXhdcFC24B8Jm9JEo4ij3xiso991UZF0mjDF/dt8a7qHu7GoUK15DjLEBeqPKSpoENa
         983YQZ13uP/R3WMf3nGV+Znu45J8avuYgdZlYi4l7CMBMxQrd9uz+wnkDUaoG6yyOxmp
         U7YQ==
X-Gm-Message-State: AOJu0YwKHqQOE/CC/rdela9VhWlBs9nhe/IZogrhZmvs1pHgZj4YiMdk
	mlhzs7e4TB71vJqUeuOEZg==
X-Google-Smtp-Source: AGHT+IEx5OKkSMuNED3DaScZcp4Zz8y4tH9KMyS5iMJWAVJLX7SmUQYi9Wp0NV0E5bQS8BzjBpd6CQ==
X-Received: by 2002:adf:fa51:0:b0:336:5bb3:eff4 with SMTP id y17-20020adffa51000000b003365bb3eff4mr117459wrr.34.1703184709936;
        Thu, 21 Dec 2023 10:51:49 -0800 (PST)
Received: from localhost.localdomain (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm2585632wrv.89.2023.12.21.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:51:48 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 2/2] mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
Date: Thu, 21 Dec 2023 19:51:42 +0100
Message-Id: <20231221185142.9224-3-alex.vinarskis@gmail.com>
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

Some devices (eg. Dell XPS 9530, 2023) due to a firmware bug have a
misconfigured clock divider, which should've been 1:1. This introduces
quirk which conditionally re-configures the clock divider to 1:1.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 drivers/mfd/intel-lpss-pci.c | 5 +++++
 drivers/mfd/intel-lpss.c     | 7 +++++++
 drivers/mfd/intel-lpss.h     | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 07713a2f694f..8c00e0c695c5 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -34,6 +34,11 @@ static const struct pci_device_id quirk_ids[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
 		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
 	},
+	{
+		/* Dell XPS 9530 (2023) */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
+		.driver_data = QUIRK_CLOCK_DIVIDER_UNITY,
+	},
 	{ }
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
index 2fa9ef916258..6f8f668f4c6f 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -19,6 +19,11 @@
  * Set to ignore resource conflicts with ACPI declared SystemMemory regions.
  */
 #define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+/*
+ * Some devices have misconfigured clock divider due to a firmware bug.
+ * Set this to force the clock divider to 1:1 ratio.
+ */
+#define QUIRK_CLOCK_DIVIDER_UNITY		BIT(1)
 
 struct device;
 struct resource;
-- 
2.40.1


