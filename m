Return-Path: <linux-kernel+bounces-87793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE0F86D916
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF51C219A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED05338FA5;
	Fri,  1 Mar 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="G/Zkkep3"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3072EB0A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257336; cv=none; b=eV425iuUB9naFQMgy0aEFi/XKk2+8kywbkPhQoFX9H3F2n5o7YxOkl+W3eLr6sPWTM6aCb8IqOuAnEA124ZeyKq7+lcCU7mExj31Cz7GLhdvoCR1pLFTuhj+AvDFWRBB0zEQvNiEjKKRW3VgPKWMZPhDto/Gu1f+hkyC/McHpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257336; c=relaxed/simple;
	bh=+K2NA3pCkHMP4WVGu6nTDubCMHmDN2IFGsQxB8tXWZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUsSpnIzJNDI8PhMqaSByjwToj3DGpBAQ+UGOLwO8dosYsNvddfHKW0vMjIbkF2a4LsVtpmyNufnlOOJer5oSyhNP7qP1KvT5XjdVdqnhNKySDcH1bFWpK2MGivIAo631YJf5PMBGsg5p/HuMW4YHB4xPxzw92p2jBjp94Crv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=G/Zkkep3; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6D5AB2C061F;
	Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709257330;
	bh=JW2bMplHMgFkl36aF3i5UY7E0A+/8mHR15PnOH9d9ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/Zkkep3XzfHlKmKvzBs6P9Yso6NjjSoJyj4FDMCLIw2WrK1p84ThJ+x4YziJ6zfM
	 g/Duod0tr8tQYMojeUoR20WJ9r6+oJUyHOoQiawlwhovRLKU9nfck2K9L1mTU9PGTU
	 flvSc7eaIwXTubOTTm1NSSB7TxJM0YwxyrIEbKUq3Z3B+1q8G7yeHwMZNfGO7m4jI3
	 4WiZEzv9QTq1Zje47UeN7KeZl2nkIfp3SnoqZZJAl6KWPDX8LN4d8g4TayZ/cWxROa
	 jBsNN/yovkU0WI3e6jE+eMGayXFM3xsB0HDihJC0lbicAUhmGpWsROCu/eKn5J5BMB
	 axCHyyvsnC6eQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e132720002>; Fri, 01 Mar 2024 14:42:10 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 12B8313EDA8;
	Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 0FBE8280062; Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	pavel@ucw.cz,
	lee@kernel.org
Cc: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/4] dt-bindings: auxdisplay: Add bindings for generic 7-segment LED
Date: Fri,  1 Mar 2024 14:42:01 +1300
Message-ID: <20240301014203.2033844-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e13272 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=gEfo2CItAAAA:8 a=UL8_YvhhsuCliVb0JXoA:9 a=3ZKOabzyN94A:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add bindings for a generic 7-segment LED display using GPIOs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - Set maxItems: 7
    - Expand description of segment-gpios property.
    - Use compatible =3D "gpio-7-segment" as suggested by Rob
    Changes in v2:
    - Use compatible =3D "generic-gpio-7seg" to keep checkpatch.pl happy

 .../bindings/auxdisplay/gpio-7-segment.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/gpio-7-s=
egment.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.=
yaml b/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
new file mode 100644
index 000000000000..76af4bf4e9a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/gpio-7-segment.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO based LED segment display
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  compatible:
+    const: gpio-7-segment
+
+  segment-gpios:
+    description:
+      An array of GPIOs one per segment. The first GPIO corresponds to t=
he A
+      segment the last GPIO corresponds to the G segment.
+    minItems: 7
+    maxItems: 7
+
+required:
+  - segment-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/gpio/gpio.h>
+
+    led-7seg {
+        compatible =3D "gpio-7-segment";
+        segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW
+                         &gpio 1 GPIO_ACTIVE_LOW
+                         &gpio 2 GPIO_ACTIVE_LOW
+                         &gpio 3 GPIO_ACTIVE_LOW
+                         &gpio 4 GPIO_ACTIVE_LOW
+                         &gpio 5 GPIO_ACTIVE_LOW
+                         &gpio 6 GPIO_ACTIVE_LOW>;
+    };
--=20
2.43.2


