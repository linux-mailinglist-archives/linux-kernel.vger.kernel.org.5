Return-Path: <linux-kernel+bounces-49117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C62D084660C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4BB24515
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BAFC8E1;
	Fri,  2 Feb 2024 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0OAi9XV8"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9CE549
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842373; cv=none; b=MvEUXKVDBcyngfnBRzh+RQOpfvBNitH5Sihp3nrAA4nb4QnU6uT643Yo6jSbiDEbKjoE7uYwy1iG4B4YUm3TbgGvo1bN6cdOo6ymefhU/sCQgedFRsQoa0SqVNuaVhyysZjAILcmakcUlM4iGFm7zTw+ANN7GsU1f/pthH0BVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842373; c=relaxed/simple;
	bh=QqjuENTdk7eOyEsK4MLG1kNiU0NEVI5RtJWR5DtykL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3O62rpimURauExv69eXGbpStls7S3nTqBXslsYS7P9oNs6F7SA/s/kECVUJE1J84cLLTXba1TRPhGXK/nLvuJZ/AAqdPvxhFfzOmlb+QTgM1k/GIK70ts5s1XDbeQm1eXDKnp8AW/IALivpg5tyBeWH0JtGPE4N6fySb43//TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0OAi9XV8; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AFE1D2C05EE;
	Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1706842368;
	bh=jigWZVExlHT68HTKXoH+elk5GMoflcfVL+zYx+L5+Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0OAi9XV8WJ8GqQ5q3kPCGC8YNJLnPcCfP1iaa4hrQKoX+8nw4jp+xoO+uLa9vgyef
	 i7CesjfqWjXcV+RAWkr+dH42M8eQp9H4rZupP+PjRcHEdwqJS97giSo0hcKEzjNrwo
	 y9CABIoqsBJN60SkcO9taDLIudn3WBRBmnY+tpflp1XvBhBPnSjW5BJ1pgFARj4eG4
	 MbtSm6Wrl3933mCjpks3KAKGlkgbb+nj+WqOnREgKsir2y2Zk1QW6BRP1m2PJbKbKu
	 LWO4K4EtWXVMkKtbXFtfks8LyN6tJP6DWZKTfW3Sl4nvSR+cFtYcHOqlz4SrRoXTCz
	 gVjbAV2OBsRJw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65bc59000002>; Fri, 02 Feb 2024 15:52:48 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 697AB13EDA9;
	Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 5F37A280EB7; Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	antoniu.miclaus@analog.com,
	noname.nuno@gmail.com
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Date: Fri,  2 Feb 2024 15:52:41 +1300
Message-ID: <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=8-29ehldHqSqZt1QG5QA:9 a=oVHKYsEdi7-vN-J5QA_j:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

From: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Devicetree binding documentation for Analog Devices MAX313XX RTCs

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/rtc/adi,max313xx.yaml | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.ya=
ml

diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Do=
cumentation/devicetree/bindings/rtc/adi,max313xx.yaml
new file mode 100644
index 000000000000..ccfb0cbfb045
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX313XX series I2C RTCs
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+description: Analog Devices MAX313XX series I2C RTCs.
+
+properties:
+  compatible:
+    enum:
+      - adi,max31328
+      - adi,max31329
+      - adi,max31331
+      - adi,max31334
+      - adi,max31341
+      - adi,max31342
+      - adi,max31343
+
+  reg:
+    description: I2C address of the RTC
+    items:
+      - enum: [0x68, 0x69]
+
+  interrupts:
+    description:
+      Alarm1 interrupt line of the RTC. Some of the RTCs have two interr=
upt
+      lines and alarm1 interrupt muxing depends on the clockin/clockout
+      configuration.
+    maxItems: 1
+
+  "#clock-cells":
+    description:
+      RTC can be used as a clock source through its clock output pin whe=
n
+      supplied.
+    const: 0
+
+  clocks:
+    description:
+      RTC uses this clock for clock input when supplied. Clock has to pr=
ovide
+      one of these four frequencies - 1Hz, 50Hz, 60Hz or 32.768kHz.
+    maxItems: 1
+
+  adi,tc-diode:
+    description:
+      Select the diode configuration for the trickle charger.
+      schottky - Schottky diode in series.
+      standard+schottky - standard diode + Schottky diode in series.
+    enum: [schottky, standard+schottky]
+
+  trickle-resistor-ohms:
+    description: Selected resistor for trickle charger.
+    enum: [3000, 6000, 11000]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: rtc.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31328
+              - adi,max31342
+
+    then:
+      properties:
+        aux-voltage-chargeable: false
+        trickle-resistor-ohms: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31328
+              - adi,max31331
+              - adi,max31334
+              - adi,max31343
+
+    then:
+      properties:
+        clocks: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31341
+              - adi,max31342
+
+    then:
+      properties:
+        reg:
+          items:
+            - const: 0x69
+
+    else:
+      properties:
+        reg:
+          items:
+            - const: 0x68
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        rtc@68 {
+            reg =3D <0x68>;
+            compatible =3D "adi,max31329";
+            clocks =3D <&clkin>;
+            interrupt-parent =3D <&gpio>;
+            interrupts =3D <26 IRQ_TYPE_EDGE_FALLING>;
+            aux-voltage-chargeable =3D <1>;
+            trickle-resistor-ohms =3D <6000>;
+            adi,tc-diode =3D "schottky";
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        rtc@68 {
+            reg =3D <0x68>;
+            compatible =3D "adi,max31331";
+            #clock-cells =3D <0>;
+        };
+    };
--=20
2.43.0


