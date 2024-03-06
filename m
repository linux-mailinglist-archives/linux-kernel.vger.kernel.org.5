Return-Path: <linux-kernel+bounces-94747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6408744BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E96BB23097
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7321CF89;
	Wed,  6 Mar 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DoWDtmk1"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8231CA89
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769036; cv=none; b=eDKkbtuqtdnvSAyyDVhqCfbD0+dIO0xW6k9RIqC7GGjcmaY8s2WIO2Rc0FT2IvVBgcrpAM1wQaDhfvrfLo/aQIcHZTALIrm6i/DBEmvDi5NoegPOhSV4c/wXglyVhBy99v91w7QBFlx8wlNT3oV54jNlUfaGmRcoCrina6SzLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769036; c=relaxed/simple;
	bh=MQNR+RdbcoHH2xLxURMJFOw23dXCONRZwd+z9rq4X28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioRgecpB9UIK2EcS/2zZlyPwwaneFI2nMaPHSQn1aILTaBgrx4H/6nzlsOVpKn53JAp7AZ+qr1gYzxKaUStL+zujxdkWET7fgtNbA4yYWmUWxBIyKsov1xtBJIWv2o+PLKMrQ7pwjeT6HisNbH/0bnICRmNP+sVNaD0IccUuu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=DoWDtmk1; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 015D42C060F;
	Thu,  7 Mar 2024 12:50:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709769026;
	bh=mSKrn6FPRCgdiWPNWxQ7az8pVvhQbllKmGMYWxYbLNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoWDtmk1qMuYiBYuV2ZQ6VzsSglT1m3ioIsFH2/0fvB7qaHalQn8cf0T2Tp4KA0ez
	 AJ+leOzksnXT7n2lyjnFR7JdZId1SMiSb3q/sn6xxdBZA9b7kRjjh3/Ak7YNY0NXwQ
	 xrx2lBoFVFFwmDEWZPXAPaYAT9/Od/Q/mBbfcQL0m6XYYo54EOzkBNQtXRoe7CDWQS
	 9pkbvE87AqR1ibvJmkcQh7Y0qCcMLHTIJVxmo8U0xVTPkSm7MzvXjxRSrL7RP3J3f5
	 +71l0IFDEGM1oUdVjgEndv6h5FIZZYr7k4mfTptuLN2CIQhV7ACtv8toEBBiRLVPR6
	 Qpqu0Vlzw25Xg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e901410001>; Thu, 07 Mar 2024 12:50:25 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 851C413EE85;
	Thu,  7 Mar 2024 12:50:25 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 8154B280D72; Thu,  7 Mar 2024 12:50:25 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	lee@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 2/3] dt-bindings: auxdisplay: Add bindings for generic 7-segment LED
Date: Thu,  7 Mar 2024 12:50:20 +1300
Message-ID: <20240306235021.976083-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e90141 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=gEfo2CItAAAA:8 a=UL8_YvhhsuCliVb0JXoA:9 a=3ZKOabzyN94A:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add bindings for a generic 7-segment LED display using GPIOs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v5:
    - Preserve formatting, maxItems set to 8, group GPIO specifiers
      as suggested by Geert
    Changes in v4:
    - Add ASCII art diagram showing arrangement of segments
    Changes in v3:
    - Set maxItems: 7
    - Expand description of segment-gpios property.
    - Use compatible =3D "gpio-7-segment" as suggested by Rob
    Changes in v2:
    - Use compatible =3D "generic-gpio-7seg" to keep checkpatch.pl happy

 .../bindings/auxdisplay/gpio-7-segment.yaml   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/gpio-7-s=
egment.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.=
yaml b/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
new file mode 100644
index 000000000000..328954893c64
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
@@ -0,0 +1,55 @@
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
+    description: |
+      An array of GPIOs one per segment. The first GPIO corresponds to t=
he A
+      segment, the seventh GPIO corresponds to the G segment. Some LED b=
locks
+      also have a decimal point which can be specified as an optional ei=
ghth
+      segment.
+
+               -a-
+              |   |
+              f   b
+              |   |
+               -g-
+              |   |
+              e   c
+              |   |
+               -d-  dp
+
+    minItems: 7
+    maxItems: 8
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
+        segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW>,
+                        <&gpio 1 GPIO_ACTIVE_LOW>,
+                        <&gpio 2 GPIO_ACTIVE_LOW>,
+                        <&gpio 3 GPIO_ACTIVE_LOW>,
+                        <&gpio 4 GPIO_ACTIVE_LOW>,
+                        <&gpio 5 GPIO_ACTIVE_LOW>,
+                        <&gpio 6 GPIO_ACTIVE_LOW>;
+    };
--=20
2.43.2


