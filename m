Return-Path: <linux-kernel+bounces-149386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B738A9079
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B631C21301
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FA4E1BA;
	Thu, 18 Apr 2024 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aHqOVmR4"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2A3A1D3;
	Thu, 18 Apr 2024 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402874; cv=none; b=peKZUKJzxPN4+EY4D23zVDAwQSmet6Ri2jKWPzkZ/vy0JiEyPjej8H0F4QeUCXUFdCupHlnALVCeHyYRQGd7WQZZbV+Y63rAWC12AoPi1BfHjf/tweoLPj273XN/cyxGNEZYexzjGpKoveODtdk4U4iu9Gmrlkihrb7lRM18qh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402874; c=relaxed/simple;
	bh=hIx4vYCbc7ACRhRYMYXkYuPVXUdlQCT7aIvcZVQGbb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnfeFzl+zRUxzb/oIWmkplqiKzx+Lo/ZeIQI2Qna3IhHmIti9II6x5CaRWPyTUhy7SkwqjI2wsGSypCRvutNGw7f6peMcveaKbk3A6JyVbItjI/jcHVqfr7LA6EylB2UTdk41lpaN1CWImM9NArJS8qEEUlD4wdQjVKPsqelQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aHqOVmR4; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HIdd9N012424;
	Wed, 17 Apr 2024 18:14:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=nfQUi4EEyH0hsbi1Gkn9+88hdna7rRs5Rp15eOu1u78=; b=aHq
	OVmR4fqnjU07DJhPDOW2YL9fSfKH0Pfsd8b1OiuiTgbZ50+KcbUs/61HFgm1RsIz
	oPospSTeXcAd1LTNPmjM6VnYac5gvunQ/8czEppSzTASlilEgOfjmIoOEDYDwG5x
	ZfwtCxiTKD6H+o6Ipyr/5GDFdpJ4KtXIeJw2Yz/BWXKqxTVQN+5qx/6K6v8GXn8n
	vOb8rBYbz/10cXltGoR/RF1t6YZFRVRa/z2kAZv5G/LlArqX6Hkvf61TNPr+FaNC
	QUKV2re/Hv0ujOQ0GN5x/0Qr49nYmLsq2eN0lNDsoWa8EbKA1T9dIJu4Nooadxp3
	sXysoqAuomw/e5qV4fw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xjkw694va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 18:14:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 18:14:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 18:14:15 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 149BB3F7070;
	Wed, 17 Apr 2024 18:14:15 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v3 2/5] spi: cadence: Add MRVL overlay bindings documentation for Cadence XSPI
Date: Wed, 17 Apr 2024 18:13:49 -0700
Message-ID: <20240418011353.1764672-3-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418011353.1764672-1-wsadowski@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cLdHQbmdxTnXUx_ynm9dkS12epYA7iTh
X-Proofpoint-ORIG-GUID: cLdHQbmdxTnXUx_ynm9dkS12epYA7iTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02

Add new bindings for v2 Marvell xSPI overlay:
mrvl,xspi-nor  compatible string
New compatible string to distinguish between orginal and modified xSPI
block

PHY configuration registers
Allow to change orginal xSPI PHY configuration values. If not set, and
Marvell overlay is enabled, safe defaults will be written into xSPI PHY

Optional base for xfer register set
Additional reg field to allocate xSPI Marvell overlay XFER block

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml    | 92 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index eb0f92468185..0e608245b136 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -20,23 +20,82 @@ allOf:
 
 properties:
   compatible:
-    const: cdns,xspi-nor
+    oneOf:
+      - description: Vanilla Cadence xSPI controller
+        items:
+          - const: cdns,xspi-nor
+      - description: Cadence xSPI controller with v2 Marvell overlay
+        items:
+          - const: mrvl,xspi-nor
+
 
   reg:
+    minItems: 3
     items:
       - description: address and length of the controller register set
       - description: address and length of the Slave DMA data port
       - description: address and length of the auxiliary registers
+      - description: address and length of the xfer registers
 
   reg-names:
+    minItems: 3
     items:
       - const: io
       - const: sdma
       - const: aux
+      - const: xferbase
 
   interrupts:
     maxItems: 1
 
+  cdns,dll-phy-control:
+    description: |
+      PHY config register. Valid only for cdns,mrvl-xspi-nor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x707
+
+  cdns,rfile-phy-control:
+    description: |
+      PHY config register. Valid only for cdns,mrvl-xspi-nor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x40000
+
+  cdns,rfile-phy-tsel:
+    description: |
+      PHY config register. Valid only for cdns,mrvl-xspi-nor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  cdns,phy-dq-timing:
+    description: |
+      PHY config register. Valid only for cdns,mrvl-xspi-nor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x101
+
+  cdns,phy-dqs-timing:
+    description: |
+      PHY config register. Valid only for cdns,mrvl-xspi-nor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x700404
+
+  cdns,phy-gate-lpbk-ctrl:
+    description: |
+      PHY config register. Valid only for cdns,mrvl-xspi-nor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x200030
+
+  cdns,phy-dll-master-ctrl:
+    description: |
+      PHY config register. Valid only for cdns,mrvl-xspi-nor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x00800000
+
+  cdns,phy-dll-slave-ctrl:
+    description: |
+      PHY config register. Valid only for cdns,mrvl-xspi-nor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x0000ff01
+
 required:
   - compatible
   - reg
@@ -68,6 +127,37 @@ examples:
                 reg = <0>;
             };
 
+            flash@1 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <75000000>;
+                reg = <1>;
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mrvl_xspi: spi@d0010000 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "mrvl,xspi-nor";
+            reg = <0x0 0xa0010000 0x0 0x1040>,
+                  <0x0 0xb0000000 0x0 0x1000>,
+                  <0x0 0xa0020000 0x0 0x100>,
+                  <0x0 0xa0090000 0x0 0x100>;
+            reg-names = "io", "sdma", "aux", "xferbase";
+            interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-parent = <&gic>;
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <75000000>;
+                reg = <0>;
+            };
+
             flash@1 {
                 compatible = "jedec,spi-nor";
                 spi-max-frequency = <75000000>;
-- 
2.43.0


