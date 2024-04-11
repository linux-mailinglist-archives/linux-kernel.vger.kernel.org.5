Return-Path: <linux-kernel+bounces-140545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E88A1607
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A7A1C21CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ACC15AAC7;
	Thu, 11 Apr 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="iwtg82PZ"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4915887C;
	Thu, 11 Apr 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842757; cv=none; b=eNjS80tpaAq/V98S2cNrDhLbtVNm0ODy+wruopTLGUUvT7VB6+GgqK0ddHFNjrasrpS9iIOGFZZRSrtiS5jWdWVDb4mkk/ERZwal7J++D6rYNxpHLvkvhbjLX1Oj/E0u+Xq91vpnBuElWqydTFtw3Q904F/8pYwmYXB0F5eEBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842757; c=relaxed/simple;
	bh=fuWmae+ny7hDhb4myzpAdFrW2LPO4DIPQaEGv4K6uY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwjULrOGrmCQhDKcnbfMkWKBdU1S9vhmIj23AT6vSWCNsenwT+ejykAswnLZD39NhtHULP3dD+Q1IoY/qOKHg5OgYpnWoR1BZEq7Y0S2hr4Cz+vrlkVmPDG+wG1er44QVYem0tAuoAkYQosrtjDwgQU/6trMIYYyyEaJu1nzOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=iwtg82PZ; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D305710003E;
	Thu, 11 Apr 2024 16:39:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D305710003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712842753;
	bh=Dhzi6StlM85b+jeNGJU/1RXZUXKsrml0JHwX7MzHPL8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iwtg82PZiOsV7nTiIh9qzwMvld8yqRZT7uNU5zzi51G9vN6yrm6/GSPBuAgi8QWoU
	 KHd6KiJBMpqVhjeOACYJ0og2gRRvdoDSbLWhhiDyTmZTVyTyjwIengBzXTssdY1jbB
	 gdICOIqoZwDHngcQq6oXVgBc9i6OP7ygR7u40L2pv2u7VqYmRgg4uPNjt3sqJKg/3t
	 /YH/bc1NDw57Lo4W4ssLwRMoV0r7BUPEygfhgoe4Z2n5Iqfius1ZtUft5Axqejo1V+
	 VEUcXZbOPRlWUrmynZBkEKFGWe/4bfbSF9/zya96hOFQe6LnJK2J9oGHEbvXnZ0hzs
	 BhNT4De/KgwrA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 16:39:13 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Apr 2024 16:39:13 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <vadim.fedorenko@linux.dev>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v7 19/23] dt-bindings: crypto: meson: support new SoC's
Date: Thu, 11 Apr 2024 16:38:28 +0300
Message-ID: <20240411133832.2896463-20-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411133832.2896463-1-avromanov@salutedevices.com>
References: <20240411133832.2896463-1-avromanov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184672 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/11 09:22:00 #24744908
X-KSMG-AntiVirus-Status: Clean, skipped

Now crypto module available at G12A/G12B/S4/A1/SM1/AXG.

1. Add new compatibles:
  - amlogic,g12a-crypto
  - amlogic,axg-crypto
  - amlogic,a1-crypto
  - amlogic,s4-crypto (uses a1-crypto as fallback)

2. Add power-domains in schema, which is required only for A1.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 .../bindings/crypto/amlogic,gxl-crypto.yaml   | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
index d3af7b4d5f39..23743701952a 100644
--- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
@@ -11,8 +11,16 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: amlogic,gxl-crypto
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,s4-crypto
+          - const: amlogic,a1-crypto
+      - enum:
+          - amlogic,gxl-crypto
+          - amlogic,axg-crypto
+          - amlogic,g12a-crypto
+          - amlogic,a1-crypto
 
   reg:
     maxItems: 1
@@ -21,11 +29,23 @@ properties:
     items:
       - description: Interrupt for flow 0
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: amlogic,a1-crypto
+    then:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


