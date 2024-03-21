Return-Path: <linux-kernel+bounces-110109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84269885A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90B11C21424
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D084FA2;
	Thu, 21 Mar 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYbTPVOQ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13784A52;
	Thu, 21 Mar 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029029; cv=none; b=RI3UNaRCyOVLaOTKQ9yqyNmF4DfzJku6LLznuBwsd7v50ky8s0fsbl6SaddgJ+WpMenHcO+teNjp/ms07l3aLyLavZMI5uAHjYpKzfdbvuvOLeNYssPrRKmtIT1QvNPkuesKmymKSW8Zi6o8mJPqOub9Sn+Dn0ZWW5XzdHNKaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029029; c=relaxed/simple;
	bh=K7pzVG0ipu+htF5tFIS19IL9/9ziycsmhQ1w6zOu4RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNsKfmofglTYKUDiJuTE948/1GvEchwHCY/i/NcLXC1BAqRXRvjjx2ANpYSTMfvOvOPMik33mt+OYXHNsba8uGhvkeJeD2dxMJ4h1XlPaIQlW4vDY1ws0luGbIR5xfHoimHiFoTFNgynRbQN4huFPTAphRDIrcUhHhQhoqKR1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYbTPVOQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so754294b3a.2;
        Thu, 21 Mar 2024 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711029026; x=1711633826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgk+J1XRvDjj/VZHGvqG6xQJJdsshosVOSvgWdd4L4Q=;
        b=CYbTPVOQoi7CrbrdQT2jvBWo2G8M47SUXq6jdnzMkq4dSFHa+ncxFGYZfTqXenZCnm
         JD9FXoKzZSVI4PKegKQuuLdFMG9rKxx+w9o8X/iecreVgREEKtmSnjz9FKWkDsll2/OA
         Wnaenoq4VSmRqOhGWTXxfT9pcRhjZFbFwY8kVLbSYU+T3TLXXl6LZ3mZFXFSE6HiXuHE
         +rrX55DMHjHGSg5tvzlZbva5pZZ1U/pwHmeu9RrldY6zVAfBPRGSi1IKZDc08pUP2eoT
         xohS74kvJ8tORoOrouU28TtIJSUk+Z00pWpdygkDkwJe9zPc+ucO9a4QVv2IwS3z5KWF
         8Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711029026; x=1711633826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bgk+J1XRvDjj/VZHGvqG6xQJJdsshosVOSvgWdd4L4Q=;
        b=aOYHVCWxdVbZMVE7jSupbyq/EnFb2WJ3N5Ac1iHBVHXIc0vEE2bYUKmH/DpW/xa8VH
         jnoCvPPgMWFI3jJDRB8HheCuu7dqOnRLyO5pThdukmq64MkIgBfzKHjNi6CMMd571ZZC
         xFhxekL95+rzBHlIhQpNTns5pYQ/T55sx8BeriMuxuGJKd6ODfBaI9PSdiAfM+luEEbA
         5ZduDOeicM4OpSUQC94cHHQ7RWHMWM5sjSEY11EMSFF6QjsEJJHaPPx5qPC6C+WK38rH
         LXmOTIz6dYnPjt0B7qS2Fkja69ddHq2nZiFsHrzzQKjJOqvpk77LtKU78ghnefvsxkhx
         507A==
X-Forwarded-Encrypted: i=1; AJvYcCXUpx1Xb54c97cofInSUDJnUFaVCnzK5YTjh2LIMMa6IvALg0e4Uxg+oG2G3w6paQe0PP88cOMOyECBCGo56q3XUDifA3BoGM4e
X-Gm-Message-State: AOJu0Yxf74fXXRavPn5HEb7RP7RgSTjfBanZYgOb8ktsOAyhZ/aT55MS
	49tb1eDt6//I/dS5sWXt0uvYvuSXXngMIWAn4ZoHryX/A/iA7/U+FnArdMkNazo=
X-Google-Smtp-Source: AGHT+IEmykCE6285kFS1OeJHpoDZ5UFbWUS3isPjkSzMuVzk5m7M9UTn4WKu2qMgQcTWueDKcJOz7g==
X-Received: by 2002:a05:6a00:398a:b0:6e6:b155:b9a3 with SMTP id fi10-20020a056a00398a00b006e6b155b9a3mr20695503pfb.11.1711029026298;
        Thu, 21 Mar 2024 06:50:26 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:c75d:3405:7d77:21ac])
        by smtp.gmail.com with ESMTPSA id s36-20020a056a0017a400b006e6adfb8897sm13473344pfg.156.2024.03.21.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 06:50:26 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] dt-bindings: spi: convert spi-jcore to dtschema
Date: Thu, 21 Mar 2024 19:17:14 +0530
Message-ID: <20240321134956.7731-1-five231003@gmail.com>
X-Mailer: git-send-email 2.44.0.273.g4bc5b65358.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert existing bindings of J-Core spi2 to dtschema.  No new properties
are added.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 .../devicetree/bindings/spi/jcore,spi.txt     | 34 -----------
 .../devicetree/bindings/spi/jcore,spi.yaml    | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.txt b/Documentation/devicetree/bindings/spi/jcore,spi.txt
deleted file mode 100644
index 93936d16e139..000000000000
--- a/Documentation/devicetree/bindings/spi/jcore,spi.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-J-Core SPI master
-
-Required properties:
-
-- compatible: Must be "jcore,spi2".
-
-- reg: Memory region for registers.
-
-- #address-cells: Must be 1.
-
-- #size-cells: Must be 0.
-
-Optional properties:
-
-- clocks: If a phandle named "ref_clk" is present, SPI clock speed
-  programming is relative to the frequency of the indicated clock.
-  Necessary only if the input clock rate is something other than a
-  fixed 50 MHz.
-
-- clock-names: Clock names, one for each phandle in clocks.
-
-See spi-bus.txt for additional properties not specific to this device.
-
-Example:
-
-spi@40 {
-	compatible = "jcore,spi2";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	reg = <0x40 0x8>;
-	spi-max-frequency = <25000000>;
-	clocks = <&bus_clk>;
-	clock-names = "ref_clk";
-}
diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.yaml b/Documentation/devicetree/bindings/spi/jcore,spi.yaml
new file mode 100644
index 000000000000..e76775bb68d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/jcore,spi.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/spi/jcore,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: J-Core SPI controller
+
+description: |
+  The J-Core "spi2" device is a PIO-based SPI controller which used to
+  perform byte-at-a-time transfers between the CPU and itself.
+
+maintainers:
+  - Kousik Sanagavarapu <five231003@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: jcore,spi2
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      If a phandle named "ref_clk" is present, SPI clock speed
+      programming is relative to the frequency of the indicated clock.
+      Necessary only if the input clock rate is something other than a
+      fixed 50 MHz.
+
+  clock-names:
+    description:
+      Clock names, one for each phandle in clocks.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    spi@40 {
+      compatible = "jcore,spi2";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      reg = <0x40 0x8>;
+      spi-max-frequency = <25000000>;
+      clocks = <&bus_clk>;
+      clock-names = "ref_clk";
+    };
-- 
2.44.0.273.g4bc5b65358.dirty


