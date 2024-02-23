Return-Path: <linux-kernel+bounces-78870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319338619F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638041C24423
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB81448EC;
	Fri, 23 Feb 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cUiKWfYJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C41E503
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709462; cv=none; b=dhF7PcbM7alzwVysdQOsVatuaSjJYuIFDH6WWAwv6GNjN3fLM6KOD06ja/78svIOqAQrFq/COg/sylUhpjeeg/al3xOSkDbmHKbA6upHU+jHELl+Us6HQ9L5D3KOIUh/XxdU/hXPlW2Et6WbCqxt680et9eKoEHv7N4WAl7+/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709462; c=relaxed/simple;
	bh=t9dKh9T4aJJEvoGpdURGgQeg5Pzq3ZcMhMvCMwkgFxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Evv1Fx6OE9zxNcB6xV9wrdLXyHSNYd3WYGnBab6pTqSiEimAZPZqr3Cvqne0djxJGS4FxFWZ4Hm7Mvcn1AUtIXwUrK0eYl2jX2BuUqIoihSglTZryjCosFezp0ZftxqrfSrORRDP9Fm5HpC3FH21XVFP3jwTaAoid5NmTVR0GHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cUiKWfYJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709460; x=1740245460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t9dKh9T4aJJEvoGpdURGgQeg5Pzq3ZcMhMvCMwkgFxs=;
  b=cUiKWfYJZdwJ7yGDX4FW/4Tp+GA+zJarBdvrp6CkQaxaYLjwZHhHrqIc
   q4vifjZ2Z64sNyJZuadZVbmDLUPcCNUB53xJtspnqqNTW4Ha6+h2P9OR/
   tbuaVLgoGdAyKQNXEgk201xVHShL+9XTsrFTbVJKHYGBIeRtxJ3/qBdGZ
   8OVYm14d7HoalyGPF4PhjxPI4etyp0mdB2VOlcQLfl6H85RV+nh6pD1E4
   qrMMefBMNjeAAI3W7WbI3Giyx2tq49165yY+Dn4iLMQWMHwa2tiznIFgy
   BQtBkv4Y88JyXLJz/AekBLldRVgQOFkQiaLSAtaU/uRe0vZfnHEhOGiem
   Q==;
X-CSE-ConnectionGUID: iWPxecE1SSGsHJTwRfxMTQ==
X-CSE-MsgGUID: 5fd07XWQSYm5Sx0H3/bC/A==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16734799"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:31:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:30:42 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:30:39 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 35/39] ARM: at91: Kconfig: add config flag for SAM9X7 SoC
Date: Fri, 23 Feb 2024 23:00:35 +0530
Message-ID: <20240223173035.673386-1-varshini.rajendran@microchip.com>
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

Add config flag for sam9x7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v4:
- Updated Reviewed-by tag
---
 arch/arm/mach-at91/Kconfig | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index a8c022b4c053..49d38a3a47de 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -141,11 +141,28 @@ config SOC_SAM9X60
 	help
 	  Select this if you are using Microchip's SAM9X60 SoC
 
+config SOC_SAM9X7
+	bool "SAM9X7"
+	depends on ARCH_MULTI_V5
+	select ATMEL_AIC5_IRQ
+	select ATMEL_PM if PM
+	select ATMEL_SDRAMC
+	select CPU_ARM926T
+	select HAVE_AT91_USB_CLK
+	select HAVE_AT91_GENERATED_CLK
+	select HAVE_AT91_SAM9X60_PLL
+	select MEMORY
+	select PINCTRL_AT91
+	select SOC_SAM_V4_V5
+	select SRAM if PM
+	help
+	  Select this if you are using Microchip's SAM9X7 SoC
+
 comment "Clocksource driver selection"
 
 config ATMEL_CLOCKSOURCE_PIT
 	bool "Periodic Interval Timer (PIT) support"
-	depends on SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
+	depends on SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
 	default SOC_AT91SAM9 || SOC_SAMA5
 	select ATMEL_PIT
 	help
@@ -155,7 +172,7 @@ config ATMEL_CLOCKSOURCE_PIT
 
 config ATMEL_CLOCKSOURCE_TCB
 	bool "Timer Counter Blocks (TCB) support"
-	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
+	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
 	select ATMEL_TCB_CLKSRC
 	help
 	  Select this to get a high precision clocksource based on a
@@ -166,7 +183,7 @@ config ATMEL_CLOCKSOURCE_TCB
 
 config MICROCHIP_CLOCKSOURCE_PIT64B
 	bool "64-bit Periodic Interval Timer (PIT64B) support"
-	default SOC_SAM9X60 || SOC_SAMA7
+	default SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA7
 	select MICROCHIP_PIT64B
 	help
 	  Select this to get a high resolution clockevent (SAM9X60) or
-- 
2.25.1


