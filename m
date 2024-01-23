Return-Path: <linux-kernel+bounces-35261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D849838ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179021F23CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA95EE81;
	Tue, 23 Jan 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIcjmVsX"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A91DFEF;
	Tue, 23 Jan 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014273; cv=none; b=mO4O1EA9m0xlEAj8Z5vOWeMSpwoavjJgEgQQHNxqLPMRTmQaMXbKIBR4ciLSIzEFtI0Fw/u0yYcfQAi7C5yh/hj8e+iQmsj1G4wl8qsNfWazOys78OZ79Huh5/CeBnInweZ38U3z69oWJDc/NSyaQpPR0QxZKkDcddmtxj3iVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014273; c=relaxed/simple;
	bh=aqO7/NlNR2Dyi9b3rA/iwNcSpumpMNjCOitWZHC97Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FLYUI97hXDH2dhoX5Hkx4LgNdo+dkVQNvE25PNGE1f5MXH9tsgR9eAk8JjplCNNJhLHCAOA8YK+YdFXnyB4EJh+flWk4LUpwiTL+hHFkBaVroubh4YGN70zFf2H8njH0Rkv3oKgEGJ4xWYQhtDVkyz6jFk09TV48tVXeVXNdHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIcjmVsX; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so44750441fa.0;
        Tue, 23 Jan 2024 04:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706014270; x=1706619070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJe/bb99wvZWtQpEHBH6bF+41ulPQ5p1NzMnmqiIsdI=;
        b=PIcjmVsXp6xmvveZ1lApsE7CFfF3m/+PMuvkaZtPXGOWRnzYItSOI6Kx6wK/cN3arN
         Joy+TJXV+Hj9dolHr922XaBr8AXKQD1aeN0R0SdJYHc3fMLIWmKg+bfHWgFTiLr5AOGl
         u8l2qrCVmIn4gX/ZKZWk4morGJYqwpkBTpclYk9VIaZjaryNcIzvV0bDC/C1K8X+i4eL
         AaXDsCpWUhZEQVUneJ8mb/t5QgHZ4Emj03a6BN/+F/uNK4Omm10u6grdVSrl+FCTewiY
         vxH0Ce1Fk/GvdzZ6hx72tQktismZQhq0nVyXNLVakEW4sqT+armocwAP15chl4h7eUdQ
         /yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014270; x=1706619070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJe/bb99wvZWtQpEHBH6bF+41ulPQ5p1NzMnmqiIsdI=;
        b=ZNs9ks0K4ZQ0tVc7dV3n+qGIl5Onv/isupNmmRlbzAQjY3pSnY/2JZKnj73K0LTpi9
         zLmiLlQnBC5vQ6wBYf2oPfs0Ob/CElVSqHjeiu8noo5VWn21cKOZJYidME1cDTNWW0Cg
         85oYtUu5eIGor7gEaw2yzx6EGLSKWpZToF0xZPa89d3WFkLah57yWDIqyTEcUfY8xKrX
         8Mf6axLiB8nf3KLIL9a6QuUdebnB8I+yj6fNfjlOHUpAvkCX+IyhdyhYQ0IDfWrU4Qk4
         XSlN0m7HUrOsc0ARbVEKmR5vu3UvMeqR0nV/wY/wgHoQHNwk8QoQOxQOe447F//HNv+d
         V2rg==
X-Gm-Message-State: AOJu0Yy+7IGH30yTro6T73E6rAltTFzfzIQEs9C/zUmpax11zNjRW/rz
	IIt3MTAxQdhyw7wznEzQpzcWzRfPeIdeZrb5L5hXY24ncWiHfIl8
X-Google-Smtp-Source: AGHT+IE44jLIuMt0FErwF7fvN3/iEOcUP3ePoa0CnFnMxIeACCJzIuIjOLKh+Miwuc2mjnbUaKmN5Q==
X-Received: by 2002:ac2:4642:0:b0:50e:6332:8083 with SMTP id s2-20020ac24642000000b0050e63328083mr1436862lfo.183.1706014269761;
        Tue, 23 Jan 2024 04:51:09 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id p6-20020a05640210c600b0055c500158b4sm1871944edu.23.2024.01.23.04.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:51:09 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: rtc: convert MT7622 RTC to the json-schema
Date: Tue, 23 Jan 2024 13:50:43 +0100
Message-Id: <20240123125043.27192-1-zajec5@gmail.com>
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

This helps validating DTS files. Introduced changes:
1. Reworded title
2. Dropper redundant properties descriptions
3. Added required #include-s and adjusted "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/rtc/mediatek,mt7622-rtc.yaml     | 52 +++++++++++++++++++
 .../devicetree/bindings/rtc/rtc-mt7622.txt    | 21 --------
 2 files changed, 52 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt7622.txt

diff --git a/Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.yaml b/Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.yaml
new file mode 100644
index 000000000000..e74dfc161cfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/mediatek,mt7622-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7622 on-SoC RTC
+
+allOf:
+  - $ref: rtc.yaml#
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt7622-rtc
+      - const: mediatek,soc-rtc
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
+  clock-names:
+    const: rtc
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt7622-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtc@10212800 {
+        compatible = "mediatek,mt7622-rtc", "mediatek,soc-rtc";
+        reg = <0x10212800 0x200>;
+        interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&topckgen CLK_TOP_RTC>;
+        clock-names = "rtc";
+    };
diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt7622.txt b/Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
deleted file mode 100644
index 09fe8f51476f..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Device-Tree bindings for MediaTek SoC based RTC
-
-Required properties:
-- compatible	    : Should be
-			"mediatek,mt7622-rtc", "mediatek,soc-rtc" : for MT7622 SoC
-- reg 		    : Specifies base physical address and size of the registers;
-- interrupts	    : Should contain the interrupt for RTC alarm;
-- clocks	    : Specifies list of clock specifiers, corresponding to
-		      entries in clock-names property;
-- clock-names	    : Should contain "rtc" entries
-
-Example:
-
-rtc: rtc@10212800 {
-	compatible = "mediatek,mt7622-rtc",
-		     "mediatek,soc-rtc";
-	reg = <0 0x10212800 0 0x200>;
-	interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
-	clocks = <&topckgen CLK_TOP_RTC>;
-	clock-names = "rtc";
-};
-- 
2.35.3


