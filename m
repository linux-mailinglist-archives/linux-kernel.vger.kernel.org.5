Return-Path: <linux-kernel+bounces-147957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836358A7BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68B71C20A62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617F52F6B;
	Wed, 17 Apr 2024 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmY0vXcu"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654583C68C;
	Wed, 17 Apr 2024 05:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331659; cv=none; b=AED3JgJRlpWx3VGwEBn80vRLepuR9CEpY7Y+xsa9xpoLb0G33yybF9XKpfLPD3giBs1ZsnpiSVUpV6pNQhUuQfPF1xcVutlW9/wBnq77IFQijIL+V0cQyvlLeuOmGcdlU9XeQHtmFUvKb8Pq7n5gnShpLzzwzw2FAFR92oZKIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331659; c=relaxed/simple;
	bh=0rhYVy+XM69aAh3BSDniO8GIwUDEhJRmqagVk6zyqe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULEV/Qk2+1KgjILPA2Nrzh627eDV0AP0Y+sqS3GSPGTH+KV88Pigwfc9GBAfTOBjqXniifHq666+OiBkfi8HGQWXmuDPooXEl/rhl0ciiaMG5s7QitrB5glFLiB+n1vPAY2P8aqDglzXpmIkYsve7smuWJobGuhgxhmYeB/c43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmY0vXcu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so303059a12.1;
        Tue, 16 Apr 2024 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713331658; x=1713936458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOr/NZfgYFosKg2zncanxuhMXP+q9xFMQ7QOYsgKRl0=;
        b=LmY0vXcuvcxFfXz/dzrIgMCt8b4rrTl1bRPvLmTAZLnnkvBG879WmSKC/XgoH1RZ1e
         emd2UMbhreUK/zLnkrqErkOYbyQxg0po1hDD2/SetRO0pwaecr7fq2lQK3g6lN+8NSYb
         cm04Qb3n4pE0mFt4QVqQXKuE/mEQiDe0tabfV1TO+Tuj04ZWrhd4w4YQrDvHYkkiFifZ
         WqbqyfCb1I1o7GhmqePcWB0gfQ37xGRDuNDzrYQvfr0ACZ9FSloup4/8HTXBZvXCb6id
         d+DeDX0i7/cbSaVArcFh29PwDw0/fTXDyKThALTOMUYSi6G0iKfxGOSBhM+J3UlkLcB4
         2fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713331658; x=1713936458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOr/NZfgYFosKg2zncanxuhMXP+q9xFMQ7QOYsgKRl0=;
        b=wmwF0hQwEwdIOYixVzRPv5uUWszouN6gNjb52wfiH/HsSY57hVLeqNKpYh+EXdpJwP
         omRokffA6dgCnGrE0rJRfdlp951vKrJKRDcykrZ11SdCZZn2ExDdAhlTbXruF1vhulil
         7vv8Fm1uOv3JlAJJ/Dn/+TUpp3eXBvKV1lHjMGtPuGEEPYvGNI6YZBMSW9OrB08H3BfG
         xGPkDzaHOhEjUtNFc7rpH7PBdO+2es2dPQ7mHO4phHD72i/WGMie8pSoMSU907Qje72c
         WZAjfDEHoVx2iaRM24ptcAQk3lcWzeSRNOkP73+WxvvsyglhCqRYCg6MFDOnei8iOLUY
         sPow==
X-Forwarded-Encrypted: i=1; AJvYcCUdAM0Q6rPSk/8HJ6IUChFnq2pTa/A8FpVLtQnB33EaPPDOPf1Bpe8E9j9rIp0jJ9myiO0ZsAE58NVUN1OZob3JWTdEqVi03KjKKpeU4ludABBMmsCGnDTscnx+qdsjxWJN/1BefqpPDlDEJ89+DZ+YZxH+EGFgcpdWjasnEs8zmrvf+A==
X-Gm-Message-State: AOJu0Yx2E3qKQYmXDbO98aCrB691EjJeVke8bggjm6632JCKAXfBVoCI
	shh/dQj/vtVBxnkwU02/r3uTciK2dl/CSqNu474J9I1I2jfO/+gx
X-Google-Smtp-Source: AGHT+IFFoy2x1CYMxKM1gkvVe26T0majatKYQnZttU5IjrBPtQROquI9IGvKICl80Xi/CUehKCFctA==
X-Received: by 2002:a17:90a:134c:b0:2a2:c40a:1a5 with SMTP id y12-20020a17090a134c00b002a2c40a01a5mr5978631pjf.12.1713331657582;
        Tue, 16 Apr 2024 22:27:37 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:65b9:28a:a676:7871])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a730c00b00299101c1341sm526777pjk.18.2024.04.16.22.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 22:27:37 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] spi: dt-bindings: armada-3700: convert to dtschema
Date: Wed, 17 Apr 2024 10:57:06 +0530
Message-ID: <20240417052729.6612-1-five231003@gmail.com>
X-Mailer: git-send-email 2.44.0.548.g91ec36f2cc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert txt binding of marvell armada 3700 SoC spi controller to dtschema
to allow for validation.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 .../bindings/spi/marvell,armada-3700-spi.yaml | 55 +++++++++++++++++++
 .../bindings/spi/spi-armada-3700.txt          | 25 ---------
 2 files changed, 55 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt

diff --git a/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml b/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
new file mode 100644
index 000000000000..61caa1d86188
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/marvell,armada-3700-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 3700 SPI Controller
+
+description:
+  The SPI controller on Marvell Armada 3700 SoC.
+
+maintainers:
+  - Kousik Sanagavarapu <five231003@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: marvell,armada-3700-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  num-cs:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi0: spi@10600 {
+        compatible = "marvell,armada-3700-spi";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x10600 0x5d>;
+        clocks = <&nb_perih_clk 7>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+        num-cs = <4>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-armada-3700.txt b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
deleted file mode 100644
index 1564aa8c02cd..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Marvell Armada 3700 SPI Controller
-
-Required Properties:
-
-- compatible: should be "marvell,armada-3700-spi"
-- reg: physical base address of the controller and length of memory mapped
-       region.
-- interrupts: The interrupt number. The interrupt specifier format depends on
-	      the interrupt controller and of its driver.
-- clocks: Must contain the clock source, usually from the North Bridge clocks.
-- num-cs: The number of chip selects that is supported by this SPI Controller
-- #address-cells: should be 1.
-- #size-cells: should be 0.
-
-Example:
-
-	spi0: spi@10600 {
-		compatible = "marvell,armada-3700-spi";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x10600 0x5d>;
-		clocks = <&nb_perih_clk 7>;
-		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
-		num-cs = <4>;
-	};
-- 
2.44.0.548.g91ec36f2cc


