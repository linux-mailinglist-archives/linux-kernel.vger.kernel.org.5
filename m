Return-Path: <linux-kernel+bounces-63058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED122852A41
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A641C28401F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334CE17980;
	Tue, 13 Feb 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HifzyN0T"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3B175AC;
	Tue, 13 Feb 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810486; cv=none; b=cQsZ0y7enMjhX4m2vKztuY7p2upf8RUFBB/bkVY3WIEexIJQ6qo3U/ViYhFkMROxEJQ9/ymVs9qNPiLEG/f9ck6Qag6T1wSW6UExH4Ra0JkqNi8Xv2a1tBhLpY6WJizSDQEpVUxjLcvorNCTLomddxFDzUc6o3OZz0E6mashhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810486; c=relaxed/simple;
	bh=O7o6nrStpO/q/9GtQ75zQ0rTf7m6SOpylrVSW4RtKYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Sx9Dmcosnh+VE3nqr6oCQz+YHMpQlga86dCca1IQPdTQ0hLWseAIj1LOkQE+C7ihZHD8S/BeHjninaIIOlzwtph9FLPnSg/Bok50FI5TTNfcrxWN7PLRgM9n7BfSP0zKutPIA5/RisMnq9VJrjk6A7jTewc/U3IJBBf0ABHIQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HifzyN0T; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55fcceb5f34so4568103a12.3;
        Mon, 12 Feb 2024 23:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707810483; x=1708415283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVvE6JGrrW+bdoM2H4XHHoW+Iw01AOmS4Rx/471szCE=;
        b=HifzyN0T7+f4Lrs4HMTjdq81KP6MNRq6TmjFIbRJIPBNMOw15KHFCQyX2oE7vPrKkg
         +EuEktevY5c2/WrbW+KyrKNy9vOPds/DJzN4Xqx9tz/lLHFGNLJ8KZRktvi49lnFyLbU
         Y09AlQmOrZyYbF3MM8E7G16TFwDUkgZ5bEWbnmcG2DiOmp0YDKLljPkk8Rw4TLlbPb12
         ZFVhFw3WVZypJjdKIf3nqji07TpSYJ7Wyd9pF7PTf/Kt+Z9WaYhMTayzF40o6S3Zhpwl
         R4IaBAomi1E4TBvEVJDqLmFMFy3oZA8qidfXhu6ElW5EJl6Qxm+BBZs+GvMWL0o4MTO9
         iSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707810483; x=1708415283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVvE6JGrrW+bdoM2H4XHHoW+Iw01AOmS4Rx/471szCE=;
        b=h44TQiakWk0bfeiOsQomn3B4JdOywICUYa9idvu+vy25mDjpovOiOP+IPfhZvSHjbE
         vBDhAuP9maJySKxx6lxaJuXJEVAEyg5iZ+d5Y7zlpClFomSEv8wxrfr3nJRtFh+W6mHT
         Y15xEAtxAaPTqqPv+WaXMPv8fi/6Jl29Wy5IScW0u7gEelc0CBUBumY8mEmnXdFMDuA5
         2tJFRjexrxuQXVnXkLvstocKhhY4IvnvO1MUHH+W7ybctA4r7PF5l3EnzCEpzwmfrc7l
         GGLoXgSCsKjTJxuE4roa1OkGNyZ3xzI+oDquN0zOsj8iQif8yxebWMFYziVZ1A5g0mwA
         X96A==
X-Forwarded-Encrypted: i=1; AJvYcCX1IgsJRR2pU7kNH07hRewbC6phUjWloZ1Vwcauc4k+/492ajpjM9nyfwUNAUx+SpvKwiGX4IGDHlMZ0UAw6cRFJaSeEVThY1utfRpRpMVH782hsvFKg6ns3v7P7ENLqPeWk/bkukOZx/tQUNO69Eh0DSR3ZZCT+dKyD6XuFx1hmjEWbw==
X-Gm-Message-State: AOJu0YyrPnF5MqfNJXLlHGjMD1XsPsEh9Ieq3XyLwYbg+lHYZ+AYaEzC
	NiVSIBx/qm/KgPdgE6NaxYOPzVyf43kBdtJ8QkmC7RF81c4UO2NuTFQDw6mU
X-Google-Smtp-Source: AGHT+IF0gttBNcV8sh6ab8bf5+rN66Ur/dk0idrz9NdowKTUw3UVn+HwH+clIeE2oz8xxvtquJ3uyA==
X-Received: by 2002:a17:906:80c5:b0:a3c:c614:82bf with SMTP id a5-20020a17090680c500b00a3cc61482bfmr2868502ejx.76.1707810482394;
        Mon, 12 Feb 2024 23:48:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6Vv+QdIy1Uwbyf/48Qht/36JdZFbwumkD4KHX7ZovhK07p7UCvN6ULGkxfVnjjVaVMnF02VxgWpUCOfLlY2PIR6cJ8V29xfsYRnhLZjUVuyvUxgSETT69/hN4PUxkaoCEH5lM+i+95sFu+cbq3gFcDN+qllWKq5+/YrAz4n+ehgkY2ALBRIGdmVbzEHw7RFr31brz5OtJmS/VkU8WG/ctiW4O7dDqHB+gVD2lpd6/YXsJJZru+kIy63uj/18PJhzsvQYAY9aj3mEEZhhgkk5P3Dlc8YGxLHg3/1mwdtW483HaYmnYg7VRbVzFJPgsmYK8mp1jIIUnPC/gYdV0tLb6P56r0X8lUb2wvwwYPYig1YpZNrGXxtHA93qk5xKFBtRC5PiP+iHy6JFHGvUiUzKhXJ0mUEhyy3D40JygSix9q8pHtsChj2Y/F/AHe6bPaxIc+iDPEFkWqkc8SftFW2RFGbKtvYwjbBKT8XNU1ULfgwMPr80HNVbegj4UVw==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id vw3-20020a170907a70300b00a36c5b01ef3sm1015845ejc.225.2024.02.12.23.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:48:02 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: ata: convert MediaTek controller to the json-schema
Date: Tue, 13 Feb 2024 08:47:47 +0100
Message-Id: <20240213074747.26151-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/ata/ahci-mtk.txt      | 51 ----------
 .../bindings/ata/mediatek,mtk-ahci.yaml       | 98 +++++++++++++++++++
 2 files changed, 98 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
 create mode 100644 Documentation/devicetree/bindings/ata/mediatek,mtk-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-mtk.txt b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
deleted file mode 100644
index d2aa696b161b..000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-mtk.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-MediaTek Serial ATA controller
-
-Required properties:
- - compatible	   : Must be "mediatek,<chip>-ahci", "mediatek,mtk-ahci".
-		     When using "mediatek,mtk-ahci" compatible strings, you
-		     need SoC specific ones in addition, one of:
-		     - "mediatek,mt7622-ahci"
- - reg		   : Physical base addresses and length of register sets.
- - interrupts	   : Interrupt associated with the SATA device.
- - interrupt-names : Associated name must be: "hostc".
- - clocks	   : A list of phandle and clock specifier pairs, one for each
-		     entry in clock-names.
- - clock-names	   : Associated names must be: "ahb", "axi", "asic", "rbc", "pm".
- - phys		   : A phandle and PHY specifier pair for the PHY port.
- - phy-names	   : Associated name must be: "sata-phy".
- - ports-implemented : See ./ahci-platform.txt for details.
-
-Optional properties:
- - power-domains   : A phandle and power domain specifier pair to the power
-		     domain which is responsible for collapsing and restoring
-		     power to the peripheral.
- - resets	   : Must contain an entry for each entry in reset-names.
-		     See ../reset/reset.txt for details.
- - reset-names	   : Associated names must be: "axi", "sw", "reg".
- - mediatek,phy-mode : A phandle to the system controller, used to enable
-		       SATA function.
-
-Example:
-
-	sata: sata@1a200000 {
-		compatible = "mediatek,mt7622-ahci",
-			     "mediatek,mtk-ahci";
-		reg = <0 0x1a200000 0 0x1100>;
-		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "hostc";
-		clocks = <&pciesys CLK_SATA_AHB_EN>,
-			 <&pciesys CLK_SATA_AXI_EN>,
-			 <&pciesys CLK_SATA_ASIC_EN>,
-			 <&pciesys CLK_SATA_RBC_EN>,
-			 <&pciesys CLK_SATA_PM_EN>;
-		clock-names = "ahb", "axi", "asic", "rbc", "pm";
-		phys = <&u3port1 PHY_TYPE_SATA>;
-		phy-names = "sata-phy";
-		ports-implemented = <0x1>;
-		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
-		resets = <&pciesys MT7622_SATA_AXI_BUS_RST>,
-			 <&pciesys MT7622_SATA_PHY_SW_RST>,
-			 <&pciesys MT7622_SATA_PHY_REG_RST>;
-		reset-names = "axi", "sw", "reg";
-		mediatek,phy-mode = <&pciesys>;
-	};
diff --git a/Documentation/devicetree/bindings/ata/mediatek,mtk-ahci.yaml b/Documentation/devicetree/bindings/ata/mediatek,mtk-ahci.yaml
new file mode 100644
index 000000000000..a34bd2e9c352
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/mediatek,mtk-ahci.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/mediatek,mtk-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Serial ATA controller
+
+maintainers:
+  - Ryder Lee <ryder.lee@mediatek.com>
+
+allOf:
+  - $ref: ahci-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt7622-ahci
+      - const: mediatek,mtk-ahci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: hostc
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: ahb
+      - const: axi
+      - const: asic
+      - const: rbc
+      - const: pm
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 3
+
+  reset-names:
+    items:
+      - const: axi
+      - const: sw
+      - const: reg
+
+  mediatek,phy-mode:
+    description: System controller phandle, used to enable SATA function
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - ports-implemented
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt7622-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/mt7622-power.h>
+    #include <dt-bindings/reset/mt7622-reset.h>
+
+    sata@1a200000 {
+        compatible = "mediatek,mt7622-ahci", "mediatek,mtk-ahci";
+        reg = <0x1a200000 0x1100>;
+        interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "hostc";
+        clocks = <&pciesys CLK_SATA_AHB_EN>,
+                 <&pciesys CLK_SATA_AXI_EN>,
+                 <&pciesys CLK_SATA_ASIC_EN>,
+                 <&pciesys CLK_SATA_RBC_EN>,
+                 <&pciesys CLK_SATA_PM_EN>;
+        clock-names = "ahb", "axi", "asic", "rbc", "pm";
+        phys = <&u3port1 PHY_TYPE_SATA>;
+        phy-names = "sata-phy";
+        ports-implemented = <0x1>;
+        power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+        resets = <&pciesys MT7622_SATA_AXI_BUS_RST>,
+                 <&pciesys MT7622_SATA_PHY_SW_RST>,
+                 <&pciesys MT7622_SATA_PHY_REG_RST>;
+        reset-names = "axi", "sw", "reg";
+        mediatek,phy-mode = <&pciesys>;
+    };
-- 
2.35.3


