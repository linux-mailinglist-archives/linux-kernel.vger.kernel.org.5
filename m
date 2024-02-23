Return-Path: <linux-kernel+bounces-78823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B957861958
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2DB1F23C32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949BC12AAE0;
	Fri, 23 Feb 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kCjRTno8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B6128822;
	Fri, 23 Feb 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708996; cv=none; b=Y/fnYJQBhx6cy4Co270mf5jGxmp3qXw+4XBHwLj0AbEqT3u1Z1gLbKBCVb2MJlp7SeVBzKMlIdOPawKbTC+xqbJDiIs6QT9QuMWy5q75OZ+e/BDPCMg0qsNYaxihSD2pC+4PfupbVqE7epWFl9n1iOCGgGo1+lxnGDIzeQfNvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708996; c=relaxed/simple;
	bh=zhJKSICRTYexG6zbU9ZUtOoY1TWprSXwSg3wxv01iHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHTDOclmAEyXXGQOycK1zQu196b252HwnnhrzozeCVhS/1go9tr1Oluf20RBmnXyXr9tf7Eco3rOSYqVCD1550rOu+aAeSDnvXI3JbOtjvIhEqa0NYPpO3ueiiOg5jA7g5F6v9Rs137fbevUS3t18Ia6z+60sVPVmNyxhV7liqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kCjRTno8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708708995; x=1740244995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zhJKSICRTYexG6zbU9ZUtOoY1TWprSXwSg3wxv01iHg=;
  b=kCjRTno8J6iRukPElO3mBkVzsMlbOIiSUnnLh95ZBJ2SNL7aRPDdexs9
   wQrYSR53BjvjKlQNwjgHhsJvtRMMlL/2ZGHBFGEAhLlf8VtML2z9p7s8E
   vaJOb67ljKab09wLxnfR8HmTr5LjgStA5y6ctqDadsrv9bZI4b/aPG6z/
   uA+OrV/NIYFzPqWvDFbhfPeX55zS+Kvu9bGTT6XF6iyUbX8oGJ4pmi5Cr
   3LNy/GVwkYY3bsI8x4fmLFHhijBGvav6t2tDCcf24hNZ4tkmlnJYWyloL
   LK0C8IAJ2XOPg2UcmMCkMZaIAhcIbNrHbuSEMugKO7Bof1ukoePfPEjCk
   A==;
X-CSE-ConnectionGUID: kPA6bSjXSWenHIaSylMDKA==
X-CSE-MsgGUID: +HLrebGIS6efKqwJlXHSAw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="184009330"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:23:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:23:09 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:23:05 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<sebastian.reichel@collabora.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/39] dt-bindings: atmel-sysreg: add sam9x7
Date: Fri, 23 Feb 2024 22:52:50 +0530
Message-ID: <20240223172250.671606-1-varshini.rajendran@microchip.com>
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

Add RAM controller & SFR DT bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
- Updated Acked-by tag
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 67a66bf74895..1339298203c6 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -11,7 +11,8 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 PIT64B Timer required properties:
-- compatible: Should be "microchip,sam9x60-pit64b"
+- compatible: Should be "microchip,sam9x60-pit64b" or
+			"microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for PIT64B timer
 - clocks: Should contain the available clock sources for PIT64B timer.
@@ -31,7 +32,8 @@ RAMC SDRAM/DDR Controller required properties:
 			"atmel,at91sam9g45-ddramc",
 			"atmel,sama5d3-ddramc",
 			"microchip,sam9x60-ddramc",
-			"microchip,sama7g5-uddrc"
+			"microchip,sama7g5-uddrc",
+			"microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc".
 - reg: Should contain registers location and length
 
 Examples:
@@ -63,6 +65,7 @@ required properties:
 	"atmel,<chip>-sfrbu", "syscon"
   <chip> can be "sama5d3", "sama5d4" or "sama5d2".
   It also can be "microchip,sam9x60-sfr", "syscon".
+  It also can be "microchip,sam9x7-sfr", "microchip,sam9x60-sfr", "syscon".
 - reg: Should contain registers location and length
 
 	sfr@f0038000 {
-- 
2.25.1


