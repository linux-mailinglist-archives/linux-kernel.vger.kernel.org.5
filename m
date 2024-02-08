Return-Path: <linux-kernel+bounces-57984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D202584DFF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595A6B22921
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275D6F516;
	Thu,  8 Feb 2024 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RmnrDl+N"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A386EB70;
	Thu,  8 Feb 2024 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392698; cv=none; b=F9v2WfOkPCrlNTrxzgXrqpnNOqIRIj3HyWEHEf/mseb/FmLfMUW58svpcAVJIO6WEU3zLWqdTrPq8lgoEfemnQMhA5cZuBCJZ7B3BjLUygcefG7ElDp+Oa4p+/aTvFNBk4fJznXDnEaeRQ9SceaZu+Pgk0wL1zG3nbV5O0+07KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392698; c=relaxed/simple;
	bh=4RLrpLO9Lr9DKthkMv9dYVS7bKcH7m8SKjLUBGgExck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ASgQq/bIsgpv7sDXYsZBvh4yYwX9ZMpQFEm2XcoJh0Ez8jjAEWBIwCYOJrHlKqXauQNiagNSKLCgkUBiWRfUYgGwThRGKcswV80/f6I1LpyyAE2ylMU2zNF7NQeMte5VUYsEPPNQUOmKxGwhuz23g76aezGv2Kge+D1FsQZbH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RmnrDl+N; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707392695; x=1738928695;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=4RLrpLO9Lr9DKthkMv9dYVS7bKcH7m8SKjLUBGgExck=;
  b=RmnrDl+N3xQJo69LYDdDZp96I3eMI5CMPAYOtEdqt1lvjX8G1xX42JWo
   YR1QbtVoEcZSLBCTf9ogl7yfDGSetakXSdmcYmdY27XFoMBamYVP0fBRP
   HcLc295vQv3k8isqxvN92DQYa1uTh7Ez+aEBpX4DJXcXbrxmVRm0gR9Bf
   g8XKeSK9CJI62k4rfA1tB4aCpcDnaPsM1nKmmYaxx1ZRrWHy01f2nJxSx
   kRn6dmKAUALxa+ugEvMjxGRfGuXcBkF+5LrPVOqX31uW517ZiZUAB4OgU
   za7xO7LgqEJDEVtxShZxqE7uDq6rPw8r200UcLMI4Bz4mspx/7ZWi44zD
   g==;
X-CSE-ConnectionGUID: 1FvkdppZRHmt/Dzk9vusdQ==
X-CSE-MsgGUID: OJNdQtm/SPKx55/Ftri+9A==
X-IronPort-AV: E=Sophos;i="6.05,253,1701154800"; 
   d="scan'208";a="15964774"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2024 04:44:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 04:44:34 -0700
Received: from [10.40.56.22] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 8 Feb 2024 04:44:29 -0700
From: Nayab Sayed <nayabbasha.sayed@microchip.com>
Date: Thu, 8 Feb 2024 17:12:12 +0530
Subject: [PATCH] dt-bindings: mtd: update references from partition.txt to
 mtd.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240208-partition-txt-v1-1-4398af3b7bb2@microchip.com>
X-B4-Tracking: v=1; b=H4sIABO+xGUC/x2MQQqAIBAAvxJ7TjATsb4SHUy32ouJSgji35OOA
 zNTIWEkTLAOFSK+lOjxHaZxAHsbfyEj1xkEF5ILrlkwMVPuFsslM6cQudWHVMsMvQkRTyr/b9t
 b+wD7YKiJXwAAAA==
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Han Xu
	<han.xu@nxp.com>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Nayab Sayed
	<nayabbasha.sayed@microchip.com>
X-Mailer: b4 0.12.4

Commit f902baa917b6 ("dt-bindings: mtd: Remove useless file about
partitions") removed the file partition.txt. Hence, in this commit, the
lines mentioning this file are updated to reference mtd.yaml, which now
includes partition{,s}.yaml.

Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
---
 Documentation/devicetree/bindings/mtd/davinci-nand.txt        | 2 +-
 Documentation/devicetree/bindings/mtd/flctl-nand.txt          | 2 +-
 Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt        | 2 +-
 Documentation/devicetree/bindings/mtd/gpio-control-nand.txt   | 2 +-
 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml          | 2 +-
 Documentation/devicetree/bindings/mtd/hisi504-nand.txt        | 2 +-
 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt | 2 +-
 Documentation/devicetree/bindings/mtd/orion-nand.txt          | 2 +-
 Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt     | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
index edebeae1f5b3..eb8e2ff4dbd2 100644
--- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
@@ -68,7 +68,7 @@ Deprecated properties:
 				false.
 
 Nand device bindings may contain additional sub-nodes describing partitions of
-the address space. See partition.txt for more detail. The NAND Flash timing
+the address space. See mtd.yaml for more detail. The NAND Flash timing
 values must be programmed in the chip select’s node of AEMIF
 memory-controller (see Documentation/devicetree/bindings/memory-controllers/
 davinci-aemif.txt).
diff --git a/Documentation/devicetree/bindings/mtd/flctl-nand.txt b/Documentation/devicetree/bindings/mtd/flctl-nand.txt
index 427f46dc60ad..51518399d737 100644
--- a/Documentation/devicetree/bindings/mtd/flctl-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/flctl-nand.txt
@@ -15,7 +15,7 @@ The DMA fields are not used yet in the driver but are listed here for
 completing the bindings.
 
 The device tree may optionally contain sub-nodes describing partitions of the
-address space. See partition.txt for more detail.
+address space. See mtd.yaml for more detail.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt b/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
index 25f07c1f9e44..530c017e014e 100644
--- a/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
@@ -22,7 +22,7 @@ Deprecated properties:
 	(R/B# pins not connected).
 
 Each flash chip described may optionally contain additional sub-nodes
-describing partitions of the address space. See partition.txt for more
+describing partitions of the address space. See mtd.yaml for more
 detail.
 
 Examples:
diff --git a/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt b/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
index 486a17d533d7..0edf55d47ea8 100644
--- a/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
@@ -26,7 +26,7 @@ Optional properties:
   read to ensure that the GPIO accesses have completed.
 
 The device tree may optionally contain sub-nodes describing partitions of the
-address space. See partition.txt for more detail.
+address space. See mtd.yaml for more detail.
 
 Examples:
 
diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index ba086c34626d..021c0da0b072 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -12,7 +12,7 @@ maintainers:
 description: |
   The GPMI nand controller provides an interface to control the NAND
   flash chips. The device tree may optionally contain sub-nodes
-  describing partitions of the address space. See partition.txt for
+  describing partitions of the address space. See mtd.yaml for
   more detail.
 
 properties:
diff --git a/Documentation/devicetree/bindings/mtd/hisi504-nand.txt b/Documentation/devicetree/bindings/mtd/hisi504-nand.txt
index 8963983ae7cb..362203e7d50e 100644
--- a/Documentation/devicetree/bindings/mtd/hisi504-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/hisi504-nand.txt
@@ -22,7 +22,7 @@ The following ECC strength and step size are currently supported:
  - nand-ecc-strength = <16>, nand-ecc-step-size = <1024>
 
 Flash chip may optionally contain additional sub-nodes describing partitions of
-the address space. See partition.txt for more detail.
+the address space. See mtd.yaml for more detail.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
index e737e5beb7bf..4a00ec2b2540 100644
--- a/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
@@ -39,7 +39,7 @@ Optional children node properties:
 - wp-gpios: GPIO specifier for the write protect pin.
 
 Optional child node of NAND chip nodes:
-Partitions: see partition.txt
+Partitions: see mtd.yaml
 
   Example:
 	nand-controller@70008000 {
diff --git a/Documentation/devicetree/bindings/mtd/orion-nand.txt b/Documentation/devicetree/bindings/mtd/orion-nand.txt
index 2d6ab660e603..b9997b1f13ac 100644
--- a/Documentation/devicetree/bindings/mtd/orion-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/orion-nand.txt
@@ -13,7 +13,7 @@ Optional properties:
                registers in usecs
 
 The device tree may optionally contain sub-nodes describing partitions of the
-address space. See partition.txt for more detail.
+address space. See mtd.yaml for more detail.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
index 09815c40fc8a..635455350660 100644
--- a/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
+++ b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
@@ -19,7 +19,7 @@ Optional child properties:
 
 Each child device node may optionally contain a 'partitions' sub-node,
 which further contains sub-nodes describing the flash partition mapping.
-See partition.txt for more detail.
+See mtd.yaml for more detail.
 
 Example:
 

---
base-commit: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
change-id: 20240208-partition-txt-d6ee0c8b4693

Best regards,
-- 
Nayab Sayed <nayabbasha.sayed@microchip.com>


