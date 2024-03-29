Return-Path: <linux-kernel+bounces-125356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62B892485
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311411C21885
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42C813B5AA;
	Fri, 29 Mar 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OYJO7EMh"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426413B58C;
	Fri, 29 Mar 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741752; cv=none; b=uuTtHzAhKl8XMRRtcSqgj9V+DR15diFix5PgFbnUaEQ4iKuVRLyPz026xEYt/y3BtolI39cqYTOaxj1TG/JStMmvV/9iu959+nCLC4kWDfi9kzh7LBSLR/5ekN8imhPMCNG3H5HTXLZDLZoXsMyAAUEYUgjIW93m/HzPAlsk/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741752; c=relaxed/simple;
	bh=xTVALSbBbBWsl/l8dgpPJ/5/oohMl624HLHwodkoJRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3siAJeLnhFvAQB3SUxxE8i1hc5Px3KUFUIFX8flbG6s3RbVItSU6/AdCDafazpFxAeDr9cANPnoK64mWqtHLuZdqWDq3nbrPkBxfvABJ0VlGfYNnCc7TtvCUdFc71H4LzAUTpSDaKmvgYA4gYuP9uSW5wLjgXnIpJwRXDHJtpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OYJO7EMh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TCGnSb028424;
	Fri, 29 Mar 2024 12:49:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=LwDE4hVpVUsTgpgBUWnH7+VxfWI+SH+0P4tn4Puet80=; b=OYJ
	O7EMhu1TAlWlM10F2Oti/ZlmKc9EcfxMooUfDxvZfhjN/HgX44VwGHAZ+lJ4BWCe
	DHIAQWyA82HBfTj6P1Y3mEQj66Ib5nW2zGmrKFb/bX3jdgPB7WSy5vydkjsH5j9J
	Zm5Zvp+afjeOkV0fZCzvAS7kPtU4ZHLRqpTyMfHdMjoaX9il6lzjqullaHr7Mr4z
	VqwQY03PJNE+NfsFUGHpSHejllDqwxOgH+hdR76PsuSSYrGDZzz9o6psegrMQbSs
	SHyUEtZuSouKGBNb1ECgFxQufGkwmwtNHrPe6vlZHp6Ow0FIVl//6vcB0Rxuogxm
	DdRG9BKYwjejbWiwp/Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x5wgphd3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 12:49:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 29 Mar 2024 12:49:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 29 Mar 2024 12:49:02 -0700
Received: from localhost.localdomain (unknown [10.110.150.170])
	by maili.marvell.com (Postfix) with ESMTP id 61F273F707B;
	Fri, 29 Mar 2024 12:49:02 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH 1/5] spi: cadence: Add new bindings documentation for Cadence XSPI
Date: Fri, 29 Mar 2024 12:48:45 -0700
Message-ID: <20240329194849.25554-2-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240329194849.25554-1-wsadowski@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: x18rr20XsovfCrnsIYOlRkcn8RwavBHT
X-Proofpoint-ORIG-GUID: x18rr20XsovfCrnsIYOlRkcn8RwavBHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02

Add new bindings:
 - mrvl,xspi-nor compatible string
   Compatible string to enable Marvell XSPI modification
 - Multiple PHY configuration registers
 - base for xfer register set

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml    | 84 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index eb0f92468185..d1fde8d4e9b8 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -20,23 +20,74 @@ allOf:
 
 properties:
   compatible:
-    const: cdns,xspi-nor
+    - const: cdns,xspi-nor
+    - const: mrvl,xspi-nor
 
   reg:
     items:
       - description: address and length of the controller register set
       - description: address and length of the Slave DMA data port
       - description: address and length of the auxiliary registers
+      - description: address and length of the xfer registers
 
   reg-names:
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
@@ -68,6 +119,37 @@ examples:
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
+        xspi: spi@a0010000 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "mrvl,xspi-nor";
+            reg = <0x0 0xa0010000 0x0 0x1040>,
+                  <0x0 0xb0000000 0x0 0x1000>,
+                  <0x0 0xa0020000 0x0 0x100>;
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
2.17.1


