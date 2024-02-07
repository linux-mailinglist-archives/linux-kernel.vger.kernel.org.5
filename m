Return-Path: <linux-kernel+bounces-57012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB984D2E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CA01F255D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE35128838;
	Wed,  7 Feb 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="j+L+Xr5u"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9091272A8;
	Wed,  7 Feb 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337413; cv=none; b=ZL8ovN0Lm4HNe87QD/oZOE/5tBfo5DbG564YxgWoMfJoYCNjN0i6xeIOX5imbzf7aGPwaH93chDie3KS0zgq1PDlyd3wkev8kMLERmgZbPulPp91b2sw8e6FUGIH+8kPs63pPjA+bbdPI0YJ02NWqFablMzXvGkVmTJO8OoWHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337413; c=relaxed/simple;
	bh=dD5CiEBNHUt0N9vBp3Iuh/sIzIg6rQGjDXZDEISTQvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0u7jIPS7tsn1yZn+gjXJLbjSaIgf/4oe2C433/XsBrD6ymW4n4DT+2k6jPXjLwRZzaYjxsw2NDCFEyBD6JIpsQt//x0Gx2OQfFnMI28ODoIwxinR0uBSZuWh9n9n0kHBnqanF+as7TEtrw3e8am4PrN2nfzW41fMXa0eHC5go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=j+L+Xr5u; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1AE71C0000EA;
	Wed,  7 Feb 2024 12:23:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1AE71C0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707337404;
	bh=dD5CiEBNHUt0N9vBp3Iuh/sIzIg6rQGjDXZDEISTQvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+L+Xr5u5YndSrR2wOyMNOhK7B/MmGQXbh9Bfpn2CU/l57PH0ocqBmRVUbSeBvEK4
	 O6NHVXs9CQ3os+3gVuuqteEpWkswLyzs/62d7Z0wBLcRdnvmrTZ3szKxYrUxMbXuVI
	 jV58wuEvooE537rPfKq6i8ruIuxumwpiGNNSuE/A=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 751F518041CAC4;
	Wed,  7 Feb 2024 12:23:22 -0800 (PST)
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
	David Regan <dregan@broadcom.com>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v5 01/12] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
Date: Wed,  7 Feb 2024 12:22:46 -0800
Message-Id: <20240207202257.271784-2-william.zhang@broadcom.com>
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

Update the descriptions to reflect different families of broadband SoC and
use the general name bcmbca for ARM based SoC.

Remove the requirement of interrupts property to reflect the driver
code and only require interrupt-names when interrupts property present.

Also add myself to the list of maintainers.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v5:
- Add reviewed-by tag

Changes in v4:
- Split the yaml changes into three patches. This is the first one

Changes in v3:
- Update brcm,nand-use-wp description
- Revert the description change to BCM63168 SoC-specific NAND controller

Changes in v2:
- Revert the new compatible string nand-bcmbca
- Drop the BCM63168 compatible fix to avoid any potential ABI
incompatibility issue
- Simplify the explanation for brcm,nand-use-wp
- Keep the interrupt name requirement when interrupt number is specified

 .../devicetree/bindings/mtd/brcm,brcmnand.yaml      | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index f57e96374e67..e54ca08a798a 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
 maintainers:
   - Brian Norris <computersforpeace@gmail.com>
   - Kamal Dasu <kdasu.kdev@gmail.com>
+  - William Zhang <william.zhang@broadcom.com>
 
 description: |
   The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
@@ -18,9 +19,10 @@ description: |
   supports basic PROGRAM and READ functions, among other features.
 
   This controller was originally designed for STB SoCs (BCM7xxx) but is now
-  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
-  iProc/Cygnus. Its history includes several similar (but not fully register
-  compatible) versions.
+  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
+  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
+  Its history includes several similar (but not fully register compatible)
+  versions.
 
   -- Additional SoC-specific NAND controller properties --
 
@@ -53,7 +55,7 @@ properties:
               - brcm,brcmnand-v7.2
               - brcm,brcmnand-v7.3
           - const: brcm,brcmnand
-      - description: BCM63138 SoC-specific NAND controller
+      - description: BCMBCA SoC-specific NAND controller
         items:
           - const: brcm,nand-bcm63138
           - enum:
@@ -177,6 +179,8 @@ allOf:
             - const: iproc-idm
             - const: iproc-ext
   - if:
+      required:
+        - interrupts
       properties:
         interrupts:
           minItems: 2
@@ -189,7 +193,6 @@ unevaluatedProperties: false
 required:
   - reg
   - reg-names
-  - interrupts
 
 examples:
   - |
-- 
2.37.3


