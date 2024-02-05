Return-Path: <linux-kernel+bounces-52439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A3B849823
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3991A28323B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F916175BC;
	Mon,  5 Feb 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mnT6BSXb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780761758C;
	Mon,  5 Feb 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130370; cv=none; b=VkiH6dZdCOccyIuiKfOnLQEgrnkexKeyZ7Ac1GINWbEcEK3ViX950c8Pxh5thzs0jmQKRUmduz1o+YyCYKH6vKAeeDpgBy1u3I3PYXLCOmr5lyyQTvBhhmAxxydjGG+mfQbXwFPgBIJL1cyvReCJDSzkTlK0cZxBjmJq9kEqW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130370; c=relaxed/simple;
	bh=OoxdaFQj/xPguPbjAhoi8W1Hwqp+a2TelEoY0w5int4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cblSTVGigP5R+ni93WZvOcTgaFMW7HxePmmOBEoIMru3xa7Qlqlcde2lJblDoNwFFEXzr+1JUanCgda3H/B0uQVW58wWTfFFjWm3va8ZF0g/CTjhtRqWtjRfDAfYDkIMXTo/j4hx5qlC13JGvOkIynKfTJWPg9uu+YJ+4Sae+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mnT6BSXb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707130368; x=1738666368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OoxdaFQj/xPguPbjAhoi8W1Hwqp+a2TelEoY0w5int4=;
  b=mnT6BSXbzqh0nRA0Id4bszZnzD1ypjJclkuchG3nmZYcjLFEWfimAcdk
   QluKhCOcWOo4YsX2dCeTvBypFEqikpHKnN1rSDr01wsvW/a/U/J+WAavj
   6kEEVB5JcfXc5vIUQwA5HLD6h9n1HByr13ezANOqMxyJdVIofLKRmuTKQ
   ZJuzITRLOypB+bbbFnCJyhEnCsBSC0/Cq1m2KdKoreyrKN5P/oJUPh1E2
   hQA1jwT2gW2+Wi0vmxkPIqDCI4a94+9rp5/KBjP5vNXEdQ3N8ez6t8Eet
   T+xd0Eq8TyyOzhYXkaBF6YSc7hIQdNBNnqzh2NEFYTmVbY55YIV0czWB4
   A==;
X-CSE-ConnectionGUID: en2EpxwLQDuVOCyI9OpQuw==
X-CSE-MsgGUID: cZQiVEcWRLSBLV6E78EZZQ==
X-IronPort-AV: E=Sophos;i="6.05,245,1701154800"; 
   d="scan'208";a="15780387"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 03:52:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 03:52:07 -0700
Received: from che-lt-i63539.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 03:52:02 -0700
From: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-ide@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Hari Prasath Gujulan Elango
	<Hari.PrasathGE@microchip.com>
Subject: [PATCH] dt-bindings: ata: atmel: remove at91 compact flash documentation
Date: Mon, 5 Feb 2024 16:22:01 +0530
Message-ID: <20240205105201.81060-1-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The compatible "at91rm9200-cf" is not used by any driver,hence remove the
corresponding documentation.

Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
---
 .../devicetree/bindings/ata/atmel-at91_cf.txt | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt

diff --git a/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt b/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
deleted file mode 100644
index c1d22b3ae134..000000000000
--- a/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Atmel AT91RM9200 CompactFlash
-
-Required properties:
-- compatible : "atmel,at91rm9200-cf".
-- reg : should specify localbus address and size used.
-- gpios : specifies the gpio pins to control the CF device. Detect
-  and reset gpio's are mandatory while irq and vcc gpio's are
-  optional and may be set to 0 if not present.
-
-Example:
-compact-flash@50000000 {
-	compatible = "atmel,at91rm9200-cf";
-	reg = <0x50000000 0x30000000>;
-	gpios = <&pioC 13 0	/* irq */
-		 &pioC 15 0 	/* detect */
-		 0		/* vcc */
-		 &pioC  5 0	/* reset */
-		>;
-};
-- 
2.34.1


