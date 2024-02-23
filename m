Return-Path: <linux-kernel+bounces-78854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FAA8619C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411541F26DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF713F010;
	Fri, 23 Feb 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lNI3+6YJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DE13F00A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709275; cv=none; b=RH863gZqnaid9USJdICmsA2xvygSqBGVKuPH9dqv5pmLPY9Xf8IPmheZHt06Gncgifql5pWYIgDiyYVGws+HWzWHNcORGT0zYkidt/a01qrFA+kc9Zkg6P2ojg5mlUnozjLsDz+JOGJFGsLkx++ohXv1o3mx0t66Ulii77zhz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709275; c=relaxed/simple;
	bh=Ig30gwYZkr/IoUPy5H3F0pxktm0wBBqBXGc48gOkR1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGOndAvN5sjkIYJEiGCfCqw0u1SdhPoAk2sl4gOouNDdrsel/QETitPxqAYWfSJr4hUMNdMqdaeSo70iFdSZ+fTrasjEvlD2CzyTsk0pgHEFUe5jzWtTVOLMYbLCKZvRXJV+ch4LYDflOsYxbAY8XuvwwhYDjClA/1LaMcS50hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lNI3+6YJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709274; x=1740245274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ig30gwYZkr/IoUPy5H3F0pxktm0wBBqBXGc48gOkR1U=;
  b=lNI3+6YJVFBDhsRfD5WOJ0kEnDm/ipn0aetCTTmBCfpt/fY3d2ZFcKrS
   NeEIm2J8g2yq/zuC3Rhmt0LyFKhUavF1SPjZLhzJ/VDkRNTozysvmXj9/
   on7RydpTTdGHYZLiskK3ZabxjcwNvpQQTK2wbvlvABlo+/EMky3atZPHR
   0IX4NBOfnWkt0XmZ97+CxeNZOaYI2jIpxztim8bRdZld6D5+3D3E1uTlq
   ytOPA0JfbjB23qsBgsTyQtdI7RCiqWy26ajN0XdGqMM57A2zl3NU3Nr4h
   j15pg50RFgReHIUUo23mK6W5yzyWN7o15FLod3QMqYn9vsOluXtbyfG4W
   g==;
X-CSE-ConnectionGUID: VJwSy7CGT9OoHBfoc7EWkg==
X-CSE-MsgGUID: dncu8mqSRtmSlxV9oczyJw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="247481500"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:27:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:27:21 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:27:19 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 19/39] ARM: at91: pm: add sam9x7 SoC init config
Date: Fri, 23 Feb 2024 22:57:13 +0530
Message-ID: <20240223172713.672537-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add SoC init config for sam9x7 family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/mach-at91/Makefile |  1 +
 arch/arm/mach-at91/sam9x7.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/arm/mach-at91/sam9x7.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 794bd12ab0a8..7d8a7bc44e65 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
+obj-$(CONFIG_SOC_SAM9X7)	+= sam9x7.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o sam_secure.o
 obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
diff --git a/arch/arm/mach-at91/sam9x7.c b/arch/arm/mach-at91/sam9x7.c
new file mode 100644
index 000000000000..d998fb327860
--- /dev/null
+++ b/arch/arm/mach-at91/sam9x7.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Setup code for SAM9X7.
+ *
+ * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/system_misc.h>
+
+#include "generic.h"
+
+static void __init sam9x7_init(void)
+{
+	of_platform_default_populate(NULL, NULL, NULL);
+
+	sam9x7_pm_init();
+}
+
+static const char *const sam9x7_dt_board_compat[] __initconst = {
+	"microchip,sam9x7",
+	NULL
+};
+
+DT_MACHINE_START(sam9x7_dt, "Microchip SAM9X7")
+	/* Maintainer: Microchip */
+	.init_machine	= sam9x7_init,
+	.dt_compat	= sam9x7_dt_board_compat,
+MACHINE_END
-- 
2.25.1


