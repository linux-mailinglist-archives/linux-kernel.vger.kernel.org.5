Return-Path: <linux-kernel+bounces-7431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E281A7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A461C226AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0F4AF75;
	Wed, 20 Dec 2023 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H76fhWFI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715404A985
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e2168ab09so209554e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703105784; x=1703710584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRB2JWw5riT9sHFz7oW625bLBL4089fShSgJH975At8=;
        b=H76fhWFIa7SucuERblDCGrjD3xazteMwq76Et2RbBC2Q77bYelTrzBTM1NFiKLvEFG
         QfN/rYypPB35vkul3Z/r7NBeyvuB00IvizG5xakCutiPGMS2FNMeuSw0ScrSM7ftEPM6
         W88B4w+FpAsLNNipUmi92nIfDJ9qtwVwz50q9j9UILq85bIX8hjXQ+C4TvLx5QqwVfvI
         cpsXc7nbxEGtL1SnObciFBPRLiY6Fm8NpygQcaG0yF48m8tNIfj154VzXCjxQtiNmPw7
         qYYRVb+dmC43MSZd3tt9ZRMrMZsj0rMllS1Wy0z68LkBOEi1bDChfro27EUVvccct6/F
         6WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105784; x=1703710584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRB2JWw5riT9sHFz7oW625bLBL4089fShSgJH975At8=;
        b=alo0vOZPEVo6GolX71z0wFSQq7YjHle1Jsb2bX81aaxQNcpUDHrf0udtJP/f/deV8k
         Y2IyR1wjoPFuqyKGtZMKO2dqJYhOryAbRT8dZ26imhmc2WVNadKmsVGiHB/pqLVN9hfP
         mAjL3ILa8Rt024LvNjdFHtVzOC3F/ozF2VgRdeiJKV18Dwm9x/rgBnD+3c9nWecNFu2y
         YM4Y6BT9SwLlAKzTTRsJ98nAsaZ9coett5Hx17Jn2oMwh/ZTslAo/N7BUcUExFR3vu//
         TvDlAhk+U8MBEq1KHsyyzqGvX0llI8Hvlu09hIOm7rMgsr460G9ogRX2z2ItSLCohLdB
         rN0w==
X-Gm-Message-State: AOJu0Yw54qztpIwVcjA8J+zKFcowWNOjdBXXMo0WPvd2PqjV/EJdsalM
	XOm1soxqownr+M76nX/K4OxebE+qN3s3
X-Google-Smtp-Source: AGHT+IHaKHTvsMbU4Gfa0AzJBlv5wdIDcb37guqebiun/IJX1SWwaOTfQNBzBSoR4PlHbtVanZestQ==
X-Received: by 2002:a05:6512:950:b0:50e:3770:a6d3 with SMTP id u16-20020a056512095000b0050e3770a6d3mr2689180lft.55.1703105784114;
        Wed, 20 Dec 2023 12:56:24 -0800 (PST)
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
Subject: [PATCH v2 2/2] mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
Date: Wed, 20 Dec 2023 21:56:21 +0100
Message-Id: <20231220205621.8575-3-alex.vinarskis@gmail.com>
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

Some devices (eg. Dell XPS 9530, 2023) due to a firmware bug have a
misconfigured clock divider, which should've been 1:1. This introduces
quirk which conditionally re-configures the clock divider to 1:1.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
V1 -> V2: Documented the quirk

 drivers/mfd/intel-lpss-pci.c | 3 +++
 drivers/mfd/intel-lpss.c     | 7 +++++++
 drivers/mfd/intel-lpss.h     | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index f8454d802677..951e28ca5e42 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -30,6 +30,9 @@ static const struct pci_device_id quirk_ids[] = {
 	}, {	/* Microsoft Surface Go 2 I2C4 */
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
 		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	}, {	/* Dell XPS 9530 (2023) */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
+		.driver_data = QUIRK_CLOCK_DIVIDER_UNITY,
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
index 8a1ffd4f3546..8c032177611e 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -19,6 +19,11 @@
  * Set to ignore resource conflicts with ACPI declared SystemMemory regions
  */
 #define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+/*
+ * Some devices have misconfigured clock divider due to a firmware bug
+ * Set this to force the clock divider to 1:1 ratio
+ */
+#define QUIRK_CLOCK_DIVIDER_UNITY		BIT(1)
 
 struct device;
 struct resource;
-- 
2.40.1


