Return-Path: <linux-kernel+bounces-135109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E224589BB46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED391F22D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C745C12;
	Mon,  8 Apr 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="muowfrvG"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6063FE48;
	Mon,  8 Apr 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567432; cv=none; b=Og4amqbbnYyxbz0Lli50UhFeSwpTlEltotrZhJ7Ns2S27Ka+XWNi4ObHVDY9vJHF3Bs3ZruYVL2yaLj5Jcft9HCJB+EhI/YKHvkytn/gIbDh4WZjnvQyYlIJTQekebqrYt1+7InjfsQYXFy74t3WkYe/b+n+8K/CiwcIbqfrdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567432; c=relaxed/simple;
	bh=8TD3PxgY61jiwladFZOXVjEURBlFWtWSjMsNv3uGaJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWZohF3zpB7Cw/ixQHbRquhE66joEAZbB1ElOhldGeoIqNhdaquj8jSMRc0JzIWFWljZFWKd7lMPmyIECULjV+ajIZ3YwgoJptBH3ICtEuZQGQdIbqE25ueOfqk+7FkZlbDNhdRGiW4luNiNKPewq9abjnmYC/paNJcTk3UzPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=muowfrvG; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D9066100032;
	Mon,  8 Apr 2024 12:10:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D9066100032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712567421;
	bh=uq+W+1WChfsNwE58vTCb2Glf4GNL4pBfquBWG7ZK/7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=muowfrvGwGt7eF31DY0k2CrFBFu4mY6MXs1ObxgnxBPxfm3SbDK6zdlTUd51cmB8W
	 R+Kb870q1kjA7PBQbNdp6KHd7DJIERF5RHNH/C/gapHapTx1kDEzfaiVATbIhSYJFL
	 YoKOL9o9BB1ziMirzXB+2KFrZjqMFMOTFBZ1FfLGZtl9eiebmgY1ShM89R0n3thxyI
	 NbPNpviAq4XjP0oYH2/TcVTNQAZt+dVhXD3ZAxDm9LL2GdApdaAlihp8ghBu7nCRp0
	 HdztnZmOjQGYuYZnkHQcEvWVKjhJpDcGA4YNZjIQ+w1VInIfMD4TC3+wB/x1HegWCO
	 S57UoHnyL3OcA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 12:10:21 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Apr 2024 12:10:21 +0300
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
Subject: [PATCH v2 1/2] dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
Date: Mon, 8 Apr 2024 11:59:30 +0300
Message-ID: <20240408085931.456337-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240408085931.456337-1-avkrasnov@salutedevices.com>
References: <20240408085931.456337-1-avkrasnov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184614 [Apr 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/08 06:07:00 #24706059
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
index 57b6957c8415..80ba5003ca70 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
@@ -64,11 +64,25 @@ patternProperties:
         items:
           maximum: 0
 
+      amlogic,boot-page-last:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The NFC driver needs this information to select ECC
+          algorithms supported by the boot ROM.
+
+      amlogic,boot-page-step:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The NFC driver needs this information to select ECC
+          algorithms supported by the boot ROM (in pages).
+
     unevaluatedProperties: false
 
     dependencies:
       nand-ecc-strength: [nand-ecc-step-size]
       nand-ecc-step-size: [nand-ecc-strength]
+      amlogic,boot-page-last: [nand-is-boot-medium, amlogic,boot-page-step]
+      amlogic,boot-page-step: [nand-is-boot-medium, amlogic,boot-page-last]
 
 
 required:
-- 
2.35.0


