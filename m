Return-Path: <linux-kernel+bounces-146531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEDD8A66A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0ED1C213C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED5A85644;
	Tue, 16 Apr 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="HT0qzPCU"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB75A10B;
	Tue, 16 Apr 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258134; cv=none; b=pDRsquvNAspGbJgCqSxXZBr+5RvQer3hlqZJYo6isRJUjoDyJTz5xKskwgejvMtX3ALHHyGw3xFqNQW4CzCUB7YmemHyWixnu+1QrFjOs9iB8A7O0sphD6gQTcpLgntty46rEdUyHB+rdkQCH6V57061+kpnrFsQf3jRCYEwARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258134; c=relaxed/simple;
	bh=NQY0GWm2/tE/cGs8w/X2Y+trgrisiorwTG4YJnKyeVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbpHJOG6J0pZwqL0se+q6ELSZylNdatEGsVS6sfTD0zVCq3n0BzAVoGgfKWUmQ+XEG042wtzbrLxaglXnUWr4WzEdSBVbaW7IpqUnLeRbJl7wLsZp33Mp7Ph86fr3OozuzadAgsSyKY7vpVPFoQUmL7UnliJtdUg+20CvvzeDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=HT0qzPCU; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 88D2A12000B;
	Tue, 16 Apr 2024 12:02:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 88D2A12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713258121;
	bh=rluHIBDIccS9YPBslSv7pHWxp+FKIOUhEoqlducELkc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HT0qzPCUqP2bxwQ5m63ucCHwozyQ6+uGG0DoetYHXjZFuwJijlUGI9X29YiWe4Cjj
	 xJeB87XJY9c8cPZn4TbMlwSy5VUGAp9ZBkTCt1IFbK+UzF2EyG4eTtVtWif0t8GdZT
	 72r64sS8GEQQXILAQIB0acbOhzMrcBRrATgv1UlTt03cHmIZsSUgebp7JS7fJ043vZ
	 jPQPFb36s2Ig4wnwaqx8iNsmFpg0mSGLBOEmHt6r2rV4R2wG4XoZcr+nWfKPyxrEGy
	 R4e1O34OFiWrlPRWID5ABqQZhorL7Nk6Hz2jyeJ4TZZUTapyzcbJQgizBNT6xGXwST
	 Cus1PAp9Sp5Sg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 16 Apr 2024 12:02:01 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Apr 2024 12:02:00 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <oxffffaa@gmail.com>,
	<kernel@sberdevices.ru>, Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v5 1/2] dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
Date: Tue, 16 Apr 2024 11:51:00 +0300
Message-ID: <20240416085101.740458-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240416085101.740458-1-avkrasnov@salutedevices.com>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184729 [Apr 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 17 0.3.17 f2153f38d75b12894d9cf445f96cd15c9ef63a9d, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/16 06:39:00 #24817376
X-KSMG-AntiVirus-Status: Clean, skipped

Boot ROM code on Meson requires that some pages on NAND must be written
in special mode: "short" ECC mode where each block is 384 bytes and
scrambling mode is on. Such pages located with the specified interval
within specified offset. Both interval and offset are located in the
device tree and used by driver if 'nand-is-boot-medium' is set for
NAND chip.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
index 57b6957c8415..67b2f7c1259c 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
@@ -64,11 +64,25 @@ patternProperties:
         items:
           maximum: 0
 
+      amlogic,boot-pages:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Number of pages starting from 0, where special ECC
+          algorithm will be used by the driver.
+
+      amlogic,boot-page-step:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Interval between pages, read/written by the driver with
+          special ECC algorithm.
+
     unevaluatedProperties: false
 
     dependencies:
       nand-ecc-strength: [nand-ecc-step-size]
       nand-ecc-step-size: [nand-ecc-strength]
+      amlogic,boot-pages: [nand-is-boot-medium, "amlogic,boot-page-step"]
+      amlogic,boot-page-step: [nand-is-boot-medium, "amlogic,boot-pages"]
 
 
 required:
-- 
2.35.0


