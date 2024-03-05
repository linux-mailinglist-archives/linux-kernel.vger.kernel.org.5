Return-Path: <linux-kernel+bounces-91636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1C6871482
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECEEB21CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1487405FF;
	Tue,  5 Mar 2024 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PP4nYQ5b"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA39405FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709611143; cv=none; b=mjj2e+kMmUofraFucAHAzYc/U1UTVVJCh9fDZfKdWdDjP7sCR1VPLu0QnEvb/EhZ75cW451VIzfJaCp0MJKSEOBQE2+3mhEYLAcofnfIGmBX4QrKJ55eebk1EXxPkgLNbbCBvMTRk6wGX8WIgkncOogXoA/qBcXjzfRhvzQtao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709611143; c=relaxed/simple;
	bh=kEOoLiiPz8igxf5L/W0rqxXGP621kvD+OKWf1GoMszk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABqeJJP5ctf7O9iDE5WZMJc1bNDn2Ito8xmY9xkwWUkomDRWENq8/eZF9+hO6vqkr65YnnErwFEuJ/mzFnfdtV6qb4MjRcVE97m7z/bOI+9+pArCCES9GwChU6EAgLTZP8p6cwxW5HICb8mFfsfelKdp9kZA4YG9wgy8eD9ghzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=PP4nYQ5b; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 184692C061F;
	Tue,  5 Mar 2024 16:58:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709611138;
	bh=xNOHpglBjcYe1JZrqyyKifiDXG6JqFWYwr4cN2SpPQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PP4nYQ5bqvTqBXQh34le5pK/pYPJpMFP6v57pXioPu2NW58CvyS3233Oz/z3RA9sJ
	 aBFY2jcZy4TlKFsBPbVd48Q/ji/yHqI6do6DROuKhS1U0bnzfV6C9PYNuLilLP8ODa
	 Vq9bzx6COhJAYFsU06JWyjIW3ZRfZA9QPC81RxMRUvOFBx0QbN7HtytlnKKNPBlmFT
	 09vuUf+NwClPXwSKMt2ZpCjwmhACfCtCnumEk8K4qJ/0oMODIqa+xDSVem+33eSasg
	 BONiQAaQTmnk6BM5pHOcqKl1kcf5AnJsP5UUvHCJpEkzjKmm3byWZHzW+Gxg9oHcrD
	 nu45U0/J0/Omg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e698810002>; Tue, 05 Mar 2024 16:58:57 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id B141C13ED56;
	Tue,  5 Mar 2024 16:58:57 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id AB22A28091F; Tue,  5 Mar 2024 16:58:57 +1300 (NZDT)
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
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 2/3] dt-bindings: auxdisplay: Add bindings for generic 7-segment LED
Date: Tue,  5 Mar 2024 16:58:51 +1300
Message-ID: <20240305035853.916430-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz>
References: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e69881 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=gEfo2CItAAAA:8 a=9jK-yGTeFsMUMglnDkMA:9 a=3ZKOabzyN94A:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add bindings for a generic 7-segment LED display using GPIOs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v4:
    - Add ASCII art diagram showing arrangement of segments
    Changes in v3:
    - Set maxItems: 7
    - Expand description of segment-gpios property.
    - Use compatible =3D "gpio-7-segment" as suggested by Rob
    Changes in v2:
    - Use compatible =3D "generic-gpio-7seg" to keep checkpatch.pl happy

 .../bindings/auxdisplay/gpio-7-segment.yaml   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/gpio-7-s=
egment.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.=
yaml b/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
new file mode 100644
index 000000000000..172548dfb142
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
@@ -0,0 +1,54 @@
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
+      segment the last GPIO corresponds to the G segment. Some LED block=
s also
+      have a decimal point (currently ignored).
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


