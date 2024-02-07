Return-Path: <linux-kernel+bounces-57014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C2384D2E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003EC1C251A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A0F129A94;
	Wed,  7 Feb 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ix1v4o9b"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581A1292EB;
	Wed,  7 Feb 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337417; cv=none; b=iP8XOc8w34zp7pytTavgCavb16ZUsOwTcADNqvGqJ2kzltJ72V2fPNnPeRTnw01p38hl8a2wh6n+KodZ7ZyQNIELD5/P8ebryEX8ugjunb5RxeBniJZboZwqMOu1VQTx166YMaPHyPuJoldEB2QKJIbEfVSgfcS2xdLU6h823XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337417; c=relaxed/simple;
	bh=tkkKLCiY+CmMh/9fyV9TP9Qpf1i/v+KHxHF98/KxN+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaVBbm2PGv4J2215Lig/ISyeBGJ7Fy6u92pEUGDNzwDZsse9Ug5KmtYixDW1fxLrKr/K2Lw8bP6vKQCtZuS1ktbl1GubSNIB2TmnvXFjd3P4ABC9qeePQQqdQf9BwaAe8T+m6NbfCiwkCgJCfYcwnbVfdmuNM0Ke1vyuzDHWiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ix1v4o9b; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2C616C002E08;
	Wed,  7 Feb 2024 12:23:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2C616C002E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707337415;
	bh=tkkKLCiY+CmMh/9fyV9TP9Qpf1i/v+KHxHF98/KxN+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ix1v4o9bKQFqE4Iq/7WQfxDfx2qYveU8FtEqQHEPNaNYdCYT5IM5bJE59Thpp+1fU
	 N3mVgwVY7/aetVlvupau5v6F1Xu2oNkutjYM1hhd9zaNT5Y6NSwhag2LcWJoyOiZAU
	 9dnxC7ZPD4zTY1BFOQRaD+dmuN/wsu05Rn1R5w/Y=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id BB3FF18041CAC4;
	Wed,  7 Feb 2024 12:23:33 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	devicetree@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 03/12] dt-bindings: mtd: brcmnand: Add ecc strap property
Date: Wed,  7 Feb 2024 12:22:48 -0800
Message-Id: <20240207202257.271784-4-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240207202257.271784-1-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
board boot strap for broadband board designs because they do not specify
ecc setting in dts but rather using the strap setting.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v5:
- Update the description for this ecc strap property
- Add check to make sure brcm,nand-ecc-use-strap and
  nand-ecc-strength/brcm,nand-oob-sector-size can not be used at the
  same time

Changes in v4:
- Move ecc strap property to this separate patch and remove some
non-binding related text from the description

Changes in v3: None
Changes in v2: None

 .../bindings/mtd/brcm,brcmnand.yaml           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index 6a717bcedfd3..52a4c993b6f1 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -146,6 +146,13 @@ patternProperties:
           layout.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      brcm,nand-ecc-use-strap:
+        description:
+          This property requires the host system to get the ECC strength
+          and step size from the SoC NAND boot strap setting. This is a
+          common hardware design on BCMBCA based boards.
+        $ref: /schemas/types.yaml#/definitions/flag
+
     unevaluatedProperties: false
 
 allOf:
@@ -195,6 +202,18 @@ allOf:
       required:
         - interrupt-names
 
+  - if:
+      patternProperties:
+        "^nand@[a-f0-9]$":
+          required:
+            - brcm,nand-ecc-use-strap
+    then:
+      patternProperties:
+        "^nand@[a-f0-9]$":
+          properties:
+            nand-ecc-strength: false
+            brcm,nand-oob-sector-size: false
+
 unevaluatedProperties: false
 
 required:
-- 
2.37.3


