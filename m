Return-Path: <linux-kernel+bounces-132693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C418998CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2906E1C213DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F387160794;
	Fri,  5 Apr 2024 09:01:44 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0A15FA7F;
	Fri,  5 Apr 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307704; cv=none; b=VyfcmqqvcDOc5L36vgY9c2VCiQk6UYwB2ymztjYSmbwSnZv1dVX24CvVDWhYUCHoj/fSa4cZf4+9EZ7v3SZ3GZJ4TZo52v8vI0XnpTtuu5cG7WXLVLW/T7yLoDPpsQLO48ZlEKrxaSOKCdLFt5xXUL02gigOhrFQ2xSEPxGQ+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307704; c=relaxed/simple;
	bh=+CGC8ZxRnPkLnB2bwYcIb90Vs1Fp+CoONNI+Hnio564=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APIjfn32uEbYrLpJ69ZdrY4aR6EDyAbOyeBjTGP+IfzlJJXiIN4ywjgyjNoaXLP157tc+R2jfjkv2Yt4GFc6pV9m5NdYXr2jc524j58BcSDJYA2eaQWfDerTB/C6Vt2WKd0P4F3LYRvaXu1RuYGjGGgkjyd2Eaujy43IEncU2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E28F62018ED;
	Fri,  5 Apr 2024 11:01:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C136200EE8;
	Fri,  5 Apr 2024 11:01:34 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 733CC183AD25;
	Fri,  5 Apr 2024 17:01:32 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v1 1/2] dt-bindings: net: bluetooth: btnxpuart: Add firmware-name property
Date: Fri,  5 Apr 2024 14:31:17 +0530
Message-Id: <20240405090118.582310-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405090118.582310-1-neeraj.sanjaykale@nxp.com>
References: <20240405090118.582310-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds a new optional device tree property called firware-name.
If this property is specified, the driver overrides the firmware
name hardcoded in the driver source code.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index f01a3988538c..25c258212bcd 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -31,6 +31,13 @@ properties:
       This property depends on the module vendor's
       configuration.
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Specify firmware file name, prepended with nxp/.
+      This property overrides the firmware names hardcoded
+      in the driver source code.
+
 required:
   - compatible
 
@@ -42,5 +49,6 @@ examples:
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
+            firmware-name = "nxp/uartuart8987_bt_v0.bin";
         };
     };
-- 
2.34.1


