Return-Path: <linux-kernel+bounces-107309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A6587FADA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA0B217BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1517E77E;
	Tue, 19 Mar 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGIDPmS9"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134F7E0E5;
	Tue, 19 Mar 2024 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840944; cv=none; b=FXy/5iWASlu+uATldMjxMVteoV2pLAr0WjanoQ2/7tzrJ3aiQlfyZCsNoIGyUYf7Z++TyWaLco9lQLSTYEmNAPKneftCwSXbcBRL6TZOv3OsgzIw/TesHPM+8Xi9Ny3C7LeonIFB8VSQ+nYolQre2MWi0blZxYIPcYOqJ7B6nmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840944; c=relaxed/simple;
	bh=9CJSCINmY9+atiiyyvCZsPCO7lIYVL6EtUTHbK+Uv08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UM10nWIWbenLfreaAYkKm1Gctgo2m5YmLfTlo3SJBmiaN0dvFl7NAPzJVqTxgsZqkaER1MhwXTKaa/3m0/AfSxfqY6QYFoi1ZuNZygh/j1zWXziSVuCTCpclNntMbO9AsTG08zcjyJhGIcO7cq8gswFXOxjuggD+65jo8RvcGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGIDPmS9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1df01161b39so26513195ad.3;
        Tue, 19 Mar 2024 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710840943; x=1711445743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpO3XyTMYrNp26rIW9VgOyOw5H/JJ52pteRLCcl6qlU=;
        b=HGIDPmS9GZAXJJ4yNu6sm7qMOdSU5OyJVUbpdG5VY7khD2ftKCYfERB1DmPoQTIrZQ
         /gLQ4gj4NKZAlDS3199o8UJp1hgq07XUI08tLoAJDJUo4zF6iyQv6fWqyeXt2+nAosKP
         7D1f8ZcD9ZKFmNDsVwRbO/bo1GKQQP1pes6msdS69Z5YPko0ZXx7xrg+LpCHjc9vBrcH
         vzEnVe7/OD6Q65lKWmjSbcpU9uqUu20iozOQFpTmcS2ugrwfSGtKDzkoDJhlLQqBViRM
         13465wFm7MJsSk93rkfTUpIL7SmwxdKrK7m2WLfJI1LUb8Db7vWN8KOShioW/u5W7Okm
         w6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840943; x=1711445743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpO3XyTMYrNp26rIW9VgOyOw5H/JJ52pteRLCcl6qlU=;
        b=oE9p9Rx3aR81qNpfAmzJe5vi6Xu5nulWR9FCTyZDXx1DyOPRtRzVf+bTCo5o0HW672
         vywyHwo2+OH5/ciGTBx87nrypVczZe8gQURgXjUTTZthorr1tV3VK9WcFjCRIIntARvE
         wX1hey/ST4geavQgbfkaHjRaQO3+Z0KozsfxVhDkwGVthLFlHyGszIIQlSXQi8pZJmq1
         +2w7k0YSnJ2aM1hBQ395JQuDJf0QsKDWKIaFa27CzXkZk0Fln8woXenVE8QWHoAhCqqE
         C9Yd0DKP3fuRTgFN/ogKxn/hkcPtQ6tSJNZkg+m5ib19YPrPdXswaOJqPxzAzpAIFz/U
         AyaA==
X-Forwarded-Encrypted: i=1; AJvYcCXeG2PxSbth09cpAhb0MhRRJWgV3Sjnl4rv0cV+Uqe2rcfBVvCio/25ve6bF7GXgk/QspXEEkPNExyrYtsSKzfQASaFzdMTXI16gAX65AuOsGsKOstOvd2VsiIHjYwTkWfRfz+BZTWALg==
X-Gm-Message-State: AOJu0Yz+szV1ui+ImAVLZOKFP3tXNNS3U3MAg5f2QJf4HzlgpfH4OlZ8
	EgxOrdJ4RmXqA3FejSup9SKeX1T2q5P6caicLxtV5cWXMRqVlqeg
X-Google-Smtp-Source: AGHT+IHryBKHJ+MSwjp/1byfMt0hDod5YQF/OmkAgxcU2UHV4h3fLG6PWHn1lTiV9EhL0mWJM96Kow==
X-Received: by 2002:a17:902:e88a:b0:1e0:2c80:2aaf with SMTP id w10-20020a170902e88a00b001e02c802aafmr5518425plg.44.1710840942841;
        Tue, 19 Mar 2024 02:35:42 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.3])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001ddc0bc5934sm10942432plh.249.2024.03.19.02.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:35:42 -0700 (PDT)
From: Manojkiran Eda <manojkiran.eda@gmail.com>
To: patrick.rudolph@9elements.com,
	chiawei_wang@aspeedtech.com,
	ryan_chen@aspeedtech.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	manojkiran.eda@gmail.com,
	jk@codeconstruct.com.au,
	openbmc@lists.ozlabs.org
Subject: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
Date: Tue, 19 Mar 2024 15:04:05 +0530
Message-Id: <20240319093405.39833-5-manojkiran.eda@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240319093405.39833-1-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the device tree bindings for aspeed eSPI
controller.

Although aspeed eSPI hardware supports 4 different channels,
this commit only adds the support for flash channel, the
bindings for other channels could be upstreamed when the driver
support for those are added.

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
---
 .../bindings/soc/aspeed/aspeed,espi.yaml      | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
new file mode 100644
index 000000000000..3d3ad528e3b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (c) 2024 IBM Corporation.
+# # Copyright (c) 2021 Aspeed Technology Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/aspeed,espi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed eSPI Controller
+
+maintainers:
+  - Manojkiran Eda <manojkiran.eda@gmail.com>
+  - Patrick Rudolph <patrick.rudolph@9elements.com>
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+description:
+  Aspeed eSPI controller implements a device side eSPI endpoint device
+  supporting the flash channel.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2500-espi
+          - aspeed,ast2600-espi
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^espi-ctrl@[0-9a-f]+$":
+    type: object
+
+    description: Controls the flash channel of eSPI hardware
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - aspeed,ast2500-espi-ctrl
+              - aspeed,ast2600-espi-ctrl
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+    required:
+      - compatible
+      - interrupts
+      - clocks
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    espi: espi@1e6ee000 {
+        compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
+        reg = <0x1e6ee000 0x1000>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6ee000 0x1000>;
+
+        espi_ctrl: espi-ctrl@0 {
+            compatible = "aspeed,ast2600-espi-ctrl";
+            reg = <0x0 0x800>,<0x0 0x4000000>;
+            reg-names = "espi_ctrl","espi_flash";
+            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+        };
+    };
-- 
2.40.1


