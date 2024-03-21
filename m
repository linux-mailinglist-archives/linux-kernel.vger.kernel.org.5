Return-Path: <linux-kernel+bounces-110538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9008588604B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B418C1C2316F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE091332AC;
	Thu, 21 Mar 2024 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCBomulw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CEE133425;
	Thu, 21 Mar 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044397; cv=none; b=mqvmHZ39Mg4pVIgvoW2+sBh/yD4rbTXkCTC7RJT5Ngtdjk42sHEFuEyHhNvBxDW1zo+Tsky+B3+KNco3DlTG/mxGD5P6tRHK7ee7np7bgFwj16Mz9JBPXEFFjcb2QWFuACl0I8RiWLjI5dsU0ar+RE7I6JRHMOJYpzJYDYvUzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044397; c=relaxed/simple;
	bh=hQM+nEBr+O+KT4m95MZF4EIGf62D1EFTUg7Imq+8K4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFOw/MOjHpzz8uUbw8wMVjdvqUQwcd4Q3/bMdFLCXOpftC+8evC/kcFeq7PdqazSPh+RNXS3c20gucy7vZu3FG2mdM7T2NIf5iXEwP6rNwxcy5OO/Mdg9vn7HpxJx/GoctYdFpqgnA3eCkyAr/jtkyM85vYK+7dNWzDzHpV05Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCBomulw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dddbe47ac1so15991155ad.1;
        Thu, 21 Mar 2024 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711044395; x=1711649195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G//XJEaui3S1uJSf5fZpwyOF3s2VA1vZvh2pajUHYgo=;
        b=KCBomulwTZfx8oyQuz2P4LNbrLhT3dYVzh1yxYv1JKA7AY+1dviS6s1gF6uLXFCHTZ
         MvZJCrUwg/H6utUme7PGUTYy57uaAYHRn3ys/JxFuEyGkBbSyK/IrW0QzlVppwgJQ0+i
         qVeM/vGwGJz+8t1Sk0xEuAxBRHxmYf8L95SsigaVQEMsIF3VNVgFsHjWIA83R+eMKYgU
         eY03zwBMm0ajc/Jfl1n8tesYpY3XStsHj30cMXrydDBeyjEQfpksGAXYwMoTsdXXd4Q3
         B/Bg5bWv6VLG1ySaJCsSiby+SbaBAIRnLSFuEehGc5ddEwlVI03magzFun7gVXEJeDy/
         KKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711044395; x=1711649195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G//XJEaui3S1uJSf5fZpwyOF3s2VA1vZvh2pajUHYgo=;
        b=W0wxNsOJsF62+QzwNtmgfq0C+CkGIxDtFzthB6ZykDvQks/9MoEHVOP9ymKZecc1Nk
         ukBeDrgDZrJj9XXTB12zAsugR+CMMI46MGYxzkSUCedsk4UYEswGaaFoXa9F8JOL1GXp
         dpqpbpV9i7n+S8TRe0IeeW6FCY3WtBa/gla9r7ogW1SIFI20DyI0SGHaOJAeUvmegkVw
         QCUX7hG8zYM34yk7g1XpU2w7iEpeoo7S2oW29L3lradADNPMTjANVaWAZdiixQDv/F+5
         E926OcW3C17g64wyU2BksmnWcdeMq3sk8odZ8EFHyqhCzg657kgEQNM9l5CmOt4fKPWi
         CLvw==
X-Forwarded-Encrypted: i=1; AJvYcCWLO0n0h6AMjeOLM4gjauhzc10S3aeC88uvGCTs+aG23mmRIZbn3Zh64Aa++s12TMBpo3VSCJRJihANl7uD5hw0dkjXvIFsw72v
X-Gm-Message-State: AOJu0Yy6xASRnwRLhY/AL1UcNvlEnBfgBoP6lL0Ou9LWtE2TEj2RGczR
	3sHi1bk8HX0tgl0E2aGBjChLLXO7TTeRbuXs25vLiegoha06kiSvZlFs2E8zNQE=
X-Google-Smtp-Source: AGHT+IFZn8qaLfdXSa3CE3FQVelBZA6AVVe4cZl7T1P9bIjqzR1zI0z8rzLd8E1+oaRXeYXWiPC+kQ==
X-Received: by 2002:a17:903:1c5:b0:1e0:137e:cd66 with SMTP id e5-20020a17090301c500b001e0137ecd66mr305347plh.30.1711044394893;
        Thu, 21 Mar 2024 11:06:34 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:c75d:3405:7d77:21ac])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001dd7de61656sm129033plh.37.2024.03.21.11.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:06:34 -0700 (PDT)
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
Subject: [PATCH v2] spi: dt-bindings: jcore,spi: convert spi-jcore to dtschema
Date: Thu, 21 Mar 2024 23:32:28 +0530
Message-ID: <20240321180617.35390-1-five231003@gmail.com>
X-Mailer: git-send-email 2.44.0.273.g4bc5b65358.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert existing bindings of J-Core spi2 to dtschema.

No new properties are added.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
Changes since v1:
- changed the subject line to conform.
- dropped desc for "clock" and "clock-names" properties.
- cleaned up stuff.

Thanks for the review Krzysztof.

 .../devicetree/bindings/spi/jcore,spi.txt     | 34 ------------
 .../devicetree/bindings/spi/jcore,spi.yaml    | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 34 deletions(-)
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
index 000000000000..b8ec3adaac8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/jcore,spi.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/spi/jcore,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: J-Core SPI controller
+
+description:
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
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref_clk
+
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@40 {
+        compatible = "jcore,spi2";
+        reg = <0x40 0x8>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        spi-max-frequency = <25000000>;
+        clocks = <&bus_clk>;
+        clock-names = "ref_clk";
+    };
-- 
2.44.0.273.g4bc5b65358.dirty


