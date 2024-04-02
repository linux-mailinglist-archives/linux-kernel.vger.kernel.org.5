Return-Path: <linux-kernel+bounces-128665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0F895DE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277921C22507
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C8215E207;
	Tue,  2 Apr 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="qkB3U3gs"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599C56B9F;
	Tue,  2 Apr 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090274; cv=none; b=I7Xw7DaU71YlQl/NYNew/Rvxb0FzY5i7vV6xnJcgVuIz1Zz+9lSbjvUWX57U8vwI4x3+xMKfCI+fI9mUGnduqw0l7P6BXCn9qHIE8GZVJXST7Y90gzhxtXkYJIY0XSmBnAreOCd/Z+fjE9OWJ8Ln3C1XqwWkqPxPe8pWlwh8las=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090274; c=relaxed/simple;
	bh=nbD3Qb0SYSDcuSLNn75re40zaC7iYAF89NOxZcHWLk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgmsLnXKHkRWNgytc2Aj3mRhDZkewImu9gqoagPH01TsAFJ/btDxiWR7Z2haz+Nv94fuTuxIoKOj43K31YCOIyn/5na88/d5VtrqnY9m5iI8cQF4JQNIJc1UJ8hLtXhH70Od4OTQ3EYlsEODmt2zng1ltOPye6dgEUOunOUn7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=qkB3U3gs; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 46DAD120004;
	Tue,  2 Apr 2024 23:37:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 46DAD120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712090263;
	bh=WmaHZl8EDgM7RdmbYhx5D6ei3ACHVss/dIDDZygqP6s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=qkB3U3gsXBQhDCYGf/2YXTpb4sq51Ozn8DbUYR18aXk0U0mNJX3k0lJWsCLJRsKjc
	 OogdUM2nAfQNaxIAFvdAetMLc6hpyo1u2sOrLNhtgqd4OSqAPJ7XlgRT4sfGApeH8c
	 aZEzd5IVYqBtuSOWsfRGP5X1+Zz9FgLbaHJYqhNbo0zp9g0etwHnsibNwZlnQ4GCeS
	 Bkow5kRpGmWWM6v7J1+1MZopbc8U2UwE7dl3juZFesBjpC8UsmKJWDmeQGllyxEkUX
	 K/P5amLrhqv+qBgPjTihTu26L7nfl9Rj5krnwo4ZQhZhUnpBMcdxPcFBV26L8/vmnG
	 8WRcntM6GjtYA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  2 Apr 2024 23:37:43 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Apr 2024 23:37:42 +0300
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
Subject: [PATCH v1 1/2] dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
Date: Tue, 2 Apr 2024 23:27:04 +0300
Message-ID: <20240402202705.2355326-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240402202705.2355326-1-avkrasnov@salutedevices.com>
References: <20240402202705.2355326-1-avkrasnov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184542 [Apr 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/02 18:05:00 #24580759
X-KSMG-AntiVirus-Status: Clean, skipped

Boot ROM code on Meson requires that some pages on NAND must be written
in special mode: "short" ECC mode where each block is 384 bytes and
scrambling mode is on. Such pages located with the specified interval
within specified offset. Both interval and offset are located in the
device tree and used by driver if 'nand-is-boot-medium' is set for
NAND chip.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 .../bindings/mtd/amlogic,meson-nand.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
index 57b6957c8415..f49819ee76b8 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
@@ -64,11 +64,27 @@ patternProperties:
         items:
           maximum: 0
 
+      meson,boot-page-last:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The NFC driver needs this information to select ECC
+          algorithms supported by the boot ROM.
+          Only used in combination with 'nand-is-boot-medium'.
+
+      meson,boot-page-step:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The NFC driver needs this information to select ECC
+          algorithms supported by the boot ROM.
+          Only used in combination with 'nand-is-boot-medium'.
+
     unevaluatedProperties: false
 
     dependencies:
       nand-ecc-strength: [nand-ecc-step-size]
       nand-ecc-step-size: [nand-ecc-strength]
+      meson,boot-page-last: [nand-is-boot-medium]
+      meson,boot-page-step: [nand-is-boot-medium]
 
 
 required:
-- 
2.35.0


