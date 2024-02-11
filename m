Return-Path: <linux-kernel+bounces-60919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64993850AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374CDB219DE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC65D8EF;
	Sun, 11 Feb 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtWMuXfj"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B95A4FF;
	Sun, 11 Feb 2024 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678221; cv=none; b=mcLZu7Zp4uz+y7vWjuGyEcMgMBns9NaxY3yyyl74lbP5yTfxPxwqVn6zLsEy++/r1DBX8ah9TnZSnieSFN3D98RWZFWwtjlSuGoiCCcOLooLfTUUzVoi2PYr6/zUk3K7Z8SVMbEuUDKl19BRlaJkYgZ0ggK5uzdQztnerMQ5L8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678221; c=relaxed/simple;
	bh=tpeWXxPW9y0R5ANl3dpUfOq3RGhBakzINSXMqQQKvkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQh3JN4Pwb0bUuHTR+etInA0YfrSfs/DaYPZITt7MKGZK1gvJavQCWgqYO4oV5ByREe55GZ3dK1evxJ98/aR94NPnVw298D1mlakLSbvVTKKWcsWJJhwES2WKiHCh8QoxA0T2XvlQZRI2V9l29mJUBlObs1147ac0RO19WyeRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtWMuXfj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a271a28aeb4so315100466b.2;
        Sun, 11 Feb 2024 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707678218; x=1708283018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKk0NSJH0NwGKwQItSQOBruTltCGsF+0CI7v15bHwUA=;
        b=BtWMuXfjBk5Sn/3t3U61ECU8vh7NMOpoxDEhbN0LLo2zIiAldHCSeJh0tOQxSGSuLW
         7GoD2CUscNa7U86hPn3emX63EX02+mcnnyvUkeSXk45awlQgHFZu1Y2N3NVOfg4/NljF
         B9gIrUse5RnKXezkHItcs16asIvPeYSULxQxokWvV7GTUM+onaPRmzCQaQliUd3Braeo
         0nVXl7bKrGlh/oCtGEB+OF1SW9WwHt+hfJcLXj07fYlnRe1aVcHtgLrQ1XqiPLlJ+a/R
         JgBgeSchLyubHBPEa1WYsnaWQ5CtrUQL1bCg1EH5dgjmg1upS1ikyb+1ljzV9Q8h0wj+
         KUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707678218; x=1708283018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKk0NSJH0NwGKwQItSQOBruTltCGsF+0CI7v15bHwUA=;
        b=P/5cSqFfNx3oc7q1DkVUIJpHTpOVrNrjM6jbs6y7cvKO0kAt6zbqsAGIO0N5P+LUk2
         hu29v6QVwuixnd/0Y7VuSQ/BZBAxZAEHkkGAnLX0wqDNIZt6MzYRMm7OQgWQ8c42M+Kf
         8d0GLvdMb61XEXphKR8l3+aJOsbKh6HgmhdjbEL9FtnlvIqI2JvyX0rCWsmlufgnVr0j
         /xvgLLcs+IdrFqnoBr6W22UFkz2HqQx4/85JgeTQ6gQkZupYmMHkIiywPaalWQ9aOblJ
         ec7+mkfYoJyILbY++7y+d02dPjME3DutWHRbc3zFpahPpLlWsqmwFXQDoMcbPm8ZAXak
         kjUg==
X-Forwarded-Encrypted: i=1; AJvYcCV6WoKblBjtCwJL9MbZba+3rk4w79H58GoktWMkcKFEmm0ugs0VLA8DHUBWrZpNl0WnRfFVMmrAtQ8s+319UkGW/buQzLVG3uyAEY5Uh14rBjNk6zi94Gq9x6tm4Cmn8xR3uAw2LTJVow==
X-Gm-Message-State: AOJu0YyTbKcmHs8SSvHLSG3ylgBXC5l7CAU/jy/RsUp0vRupDeZfLwwc
	ToL1r3eleqOGYDLtYskSGlOx7Cvcg6g+lzZFMr9eNh7pfBtfor8Y
X-Google-Smtp-Source: AGHT+IH9NhKiJDvRD6Cl60JM25BaQY4py10RTgZt1sW8aa8a+kiL0Rh6OrBw+AdiReyXhwuYbxAXvw==
X-Received: by 2002:a17:906:fad0:b0:a38:4f2b:8591 with SMTP id lu16-20020a170906fad000b00a384f2b8591mr3740023ejb.69.1707678218261;
        Sun, 11 Feb 2024 11:03:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9xUW1N1zNSlG3bvGQZfSlWU8yACAGpIwj5Nbwhaxe9ZQM4cO9Uoguf1SgKM55eslVsWH5u7G98hSd9tQwE4bjAdVe0XajYTif93t4qgBywiN0iWvOVHzFd72TmAss3zTrcjo6N6lJLcGAapBo1kmgY5mKVBQ5v07P2TWcrLPfqqtEfJQQ/Qq7KN8xXr/vEUpMIqwYmomLqni0osXv8o5I+5M43deFwm4SXalaUSWNAhAK9w7945KoL/D6F0RQUcV6uSKq+jnYdYR8mLG5Lezob3S40z+yUHU9GIYXCP1vDZ6nV3uxnehC0lD4LMKXKjrOroJk7Uq2BcTsa/phFTWxPSwAYSk7TVDjfYeeXHJKLzBSfZDrIFE4vtyEYg9w9Y2xrVQUKFASiebgsOO1aUI7KPQRtYsFUiP0nhOa7Fq6r1o5JycIzmRjQTxsgYsrUM4cYCuo6C5lbZLMJpEe3NrirseQ9YgGHSeX+swIkoQsu7QA54jSGlPruQy0G0s7LIjqBQ3SacXbMK6ZQc0GBnIKgkwfsjEYEf8+cDe1xSyK5yBtYhxH88qlluCyn/5qJf0hdRjJyHbMVI/frGIjElmZ8zI4ApKREFOztM6cXcyC7Q2na8fzBbdeYOustMhjnxqQ4PEXEqzzGLrZ
Received: from localhost.localdomain ([2a02:8109:aa27:2d00::2d2b])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3c5fa1052csm1207400ejb.138.2024.02.11.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 11:03:37 -0800 (PST)
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: mchehab@kernel.org,
	heiko@sntech.de,
	hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com,
	paul.kocialkowski@bootlin.com,
	michael.riesch@wolfvision.net,
	laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait.k@gmail.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND Patch v13 1/3] media: dt-bindings: media: add bindings for Rockchip CIF
Date: Sun, 11 Feb 2024 20:03:30 +0100
Message-ID: <13deb8c5cb58e08c1b47decd112b51e8e0b6c4dc.1707677804.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707677804.git.mehdi.djait.k@gmail.com>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehdi Djait <mehdi.djait@bootlin.com>

Add a documentation for the Rockchip Camera Interface binding.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 .../bindings/media/rockchip,px30-vip.yaml     | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml

diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
new file mode 100644
index 000000000000..6af4a9b6774a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Camera Interface (CIF)
+
+maintainers:
+  - Mehdi Djait <mehdi.djait@bootlin.com>
+
+description:
+  CIF is a camera interface present on some Rockchip SoCs. It receives the data
+  from Camera sensor or CCIR656 encoder and transfers it into system main memory
+  by AXI bus.
+
+properties:
+  compatible:
+    const: rockchip,px30-vip
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ACLK
+      - description: HCLK
+      - description: PCLK
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+      - const: pclk
+
+  resets:
+    items:
+      - description: AXI
+      - description: AHB
+      - description: PCLK IN
+
+  reset-names:
+    items:
+      - const: axi
+      - const: ahb
+      - const: pclkin
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: input port on the parallel interface
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              bus-type:
+                enum: [5, 6]
+
+            required:
+              - bus-type
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/media/video-interfaces.h>
+    #include <dt-bindings/power/px30-power.h>
+
+    parent {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        video-capture@ff490000 {
+            compatible = "rockchip,px30-vip";
+            reg = <0x0 0xff490000 0x0 0x200>;
+            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
+            clock-names = "aclk", "hclk", "pclk";
+            power-domains = <&power PX30_PD_VI>;
+            resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
+            reset-names = "axi", "ahb", "pclkin";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    cif_in: endpoint {
+                        remote-endpoint = <&tw9900_out>;
+                        bus-type = <MEDIA_BUS_TYPE_BT656>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.43.0


