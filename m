Return-Path: <linux-kernel+bounces-106334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13D87ECA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9336AB219A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70F537E6;
	Mon, 18 Mar 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LUkqxqdZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294253378;
	Mon, 18 Mar 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777074; cv=none; b=o5INSylmFeH52QYO8S5PMjlTLzSZrCx1n5gzu9pCbGxiTn3/3vixekCta1iMlqQt5JjvLsx8RoIXWJNzCHA3OSTXTDF5OU1sZ2EYqpdxLvZvHDPo1To9WwY4KI0ErNKZegopWKtLgsK4O/Pz66fUtohN48rGsIwHltA0oL9IeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777074; c=relaxed/simple;
	bh=9cqGmKwZifEH6rqhzO+wwC/ZEXL/+VH+UB9wjLsmb24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPMuTtDzC+2YceqSX/O/OECnoTVK+dzaXfZSVUG1MHxrwI15lQHyYVBrqwVOcaVxaQdrloGWqNnD+D3wzfSD9Vbn/LhHOXXACnWhjQDPH3RgfK4BZmtpanjgKF5GcL05jV4csqwV+bmOeChjrvmqCBUSay3e4Kml5dOj9pbcMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LUkqxqdZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D0CCE1BB1;
	Mon, 18 Mar 2024 16:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710777042;
	bh=9cqGmKwZifEH6rqhzO+wwC/ZEXL/+VH+UB9wjLsmb24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LUkqxqdZWyBYeB4UtMmsZxRc0Yh4TKpYQmkzuRWkCNyJmSWDmvsNUyPm5LFsbvtIE
	 7ot16zP3LlEApvDik6eAw6WE2dmLLy8pUa+CIBhVxCt0bL6P3bSPvPGYMIexJlh/A8
	 zKmlzLPWxAsf7Q9MuCL40T6Bw8lg8dAJ5evppEZM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 18 Mar 2024 17:49:57 +0200
Subject: [PATCH 2/4] dt-bindings: media: Add bindings for
 raspberrypi,rp1-cfe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
In-Reply-To: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Naushir Patuck <naush@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=9cqGmKwZifEH6rqhzO+wwC/ZEXL/+VH+UB9wjLsmb24=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl+GLovjHMleKcyqpNl3qYB2Zl8zJiIsjrJjwcB
 623441VsPaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZfhi6AAKCRD6PaqMvJYe
 9daID/9Vk05kVIENDX8siHbb/gXnQQ1MfV1RjpSpU+DEyq1f/tyhNkOHexkLMgZQkyqYgIABF5+
 N8GEapnFWM7axkCkpQ1eZSi2if6yiGaVUPu7OwyGQoWuViPsgHh0dK9FMhvr48B77+BnSunZJqE
 fuUeUiFBPfMpbfRlAYuyeuzMkP9sia1JKCFILy3IDDDuJ08s1j0Dhlggd3wg2ZarwMVtYTTlCn2
 4ikl7Y7twLdgJtUlm2jcDgLh9HbYX2IqLcubsEDas11JTV9hIdY2CI0mfFHc7sM8dg8fy4oy1wR
 FZ8zvYvkDx5DeGhUfR8BwXhH9CMhYrQXWwEsd6R+lSPka9uBM4gN7wk2a0tFoQck9C6DkDwE8vT
 97utB/jjk4KICRX1Hble5RslNX0+jFRYKtudJtBOS9Y/xhP0TvMqds8FEFG3XktZvqgTbBqku0f
 622c57VZ6scgvXiF4mQZrIfTevNYxjZg4J7ILJjOE6DFVLAd9E/Wet2aaEV9Zy5kDbgUJgWU+9B
 QbNhnenLWHpp8DHm8Qg/623qSibfCMZkdedjFRVfrrCdRHUA7/1IwfwoRBNRUwnsECaSUerWIZ0
 3DPRVsEawg1e0WoOSIe2VqQNx8Gs8cAuS8TIhf6W5ZVfqTPda0WJJto/Fg6lWijGCkdC4rawa8/
 RLIUgGCr7jkMdeg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add DT bindings for raspberrypi,rp1-cfe.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../bindings/media/raspberrypi,rp1-cfe.yaml        | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml b/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
new file mode 100644
index 000000000000..7b2beeaaab0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/raspberrypi,rp1-cfe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi PiSP Camera Front End
+
+maintainers:
+  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
+  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
+
+description: |
+  The Raspberry Pi PiSP Camera Front End is a module in Raspberrypi 5's RP1 I/O
+  controller, that contains:
+  - MIPI D-PHY
+  - MIPI CSI-2 receiver
+  - Simple image processor (called PiSP Front End, or FE)
+
+  The FE documentation is available at:
+  https://datasheets.raspberrypi.com/camera/raspberry-pi-image-signal-processor-specification.pdf
+
+  The PHY and CSI-2 receiver part have no public documentation.
+
+properties:
+  compatible:
+    const: raspberrypi,rpi5-rp1-cfe
+
+  reg:
+    items:
+      - description: CSI-2 registers
+      - description: D-PHY registers
+      - description: MIPI CFG (a simple top-level mux) registers
+      - description: FE registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+    description: CSI-2 RX Port
+
+    properties:
+      endpoint:
+        $ref: video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            minItems: 1
+            maxItems: 4
+
+          clock-lanes:
+            maxItems: 1
+
+          clock-noncontinuous: true
+
+        required:
+          - clock-lanes
+          - data-lanes
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rp1.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/rp1.h>
+
+    rpi1 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+      csi@110000 {
+        compatible = "raspberrypi,rp1-cfe";
+        reg = <0xc0 0x40110000  0x0 0x100>,
+              <0xc0 0x40114000  0x0 0x100>,
+              <0xc0 0x40120000  0x0 0x100>,
+              <0xc0 0x40124000  0x0 0x1000>;
+
+        interrupts = <RP1_INT_MIPI0 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&rp1_clocks RP1_CLK_MIPI0_CFG>;
+
+        port {
+          csi_ep: endpoint {
+            remote-endpoint = <&cam_endpoint>;
+            clock-lanes = <0>;
+            data-lanes = <1 2>;
+          };
+        };
+      };
+    };

-- 
2.34.1


