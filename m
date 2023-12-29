Return-Path: <linux-kernel+bounces-12972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3481FDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FC61F23A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA6849C;
	Fri, 29 Dec 2023 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCdMyGia"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EA79C2;
	Fri, 29 Dec 2023 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbd532e6e8aso4738095276.2;
        Thu, 28 Dec 2023 23:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703835930; x=1704440730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEGAxLf4IsKoqwzjcok3JRGPJ70voZ7ZjL8ngt195yA=;
        b=NCdMyGiak1nikI5QIs8riOgraD+MoSWraRRmel/fElhPgHqZsAfCuvrPlVKupXbQYc
         vFb9Dk7VkuvDg3T8BdukCa8rOp1W48IwldORza/BfQRydUDEJsOZ1EwvDG9HyJBVEQva
         pm2IZerlVNVXneMDZSCKwk6WI1/eAkinyb30KzCCeLBO/9Xw/rGQpbPqtWoVYLtFRWH/
         xs2Du3uu9hEywqRMnfQJfCLHOOSnup9+iKFHFhcrlSJCPz5BBfjAvvqqVvSLWZo2D3gD
         eHO/ad0KBiRvRs7OaKbbjxUKUKM1WPvE3QEZetOgOonXKDR1RWX+1mJNfVBA/E5cXSnY
         1sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703835930; x=1704440730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEGAxLf4IsKoqwzjcok3JRGPJ70voZ7ZjL8ngt195yA=;
        b=MBF70VEiZkDMKkh71upBbuD0v7/k6arsqF4jlyec0J5ph2mt4g2oH3idxulPz4YtIt
         4GMPqQ2KbZRhwzuvjo8RdE2O5K+wEBYkgHiYbPQ9BL59/weiulCsCFt8hGGqrOt3ZtCT
         VmV0ToW2oRKKbpKXacZpS7ft+a0LzfNZxbaxtaIJXl24DcJAJ8i/RZzgaNO3qC5QS3w9
         aBteuXo+HBcAlgHJpHv77swPGSSadB3YiaI1lbHnpKPuUh3paWFJkbPMCCRmnDZqxeQG
         DfCE+JnP8Cs681RHjCrAR8FFAJPaH6qQSk/ueXD18MM6hC2O0R6xYRK5rbX0dcfoD8LW
         K+Jw==
X-Gm-Message-State: AOJu0YxgHVP1WoVf7E1HQSsVj304ezO8wV1TSvvKpPmGXJPs9BJFXa/P
	icqc42VPhwtqLrjvdiRgzpU=
X-Google-Smtp-Source: AGHT+IGU6rlyzKFUXt2uV0qU7Ku9PkDDI4wAMUvhgBjSVCDz4vqA9CFCVZ1s108SqYFGYMxlr5tcRA==
X-Received: by 2002:a25:69c5:0:b0:dbd:38c:e612 with SMTP id e188-20020a2569c5000000b00dbd038ce612mr6841255ybc.84.1703835930106;
        Thu, 28 Dec 2023 23:45:30 -0800 (PST)
Received: from localhost.localdomain ([1.200.140.173])
        by smtp.gmail.com with ESMTPSA id s188-20020a6377c5000000b005c683937cc5sm10305186pgc.44.2023.12.28.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:45:29 -0800 (PST)
From: jim.t90615@gmail.com
X-Google-Original-From: JJLIU0@nuvoton.com
To: JJLIU0@nuvoton.com,
	KWLIU@nuvoton.com,
	jim.t90615@gmail.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	Rob Herring <robh@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v10 1/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Date: Fri, 29 Dec 2023 15:45:06 +0800
Message-Id: <20231229074508.2709093-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229074508.2709093-1-JJLIU0@nuvoton.com>
References: <20231229074508.2709093-1-JJLIU0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Liu <JJLIU0@nuvoton.com>

Add dt-bindings document for the Nuvoton NPCM7xx sgpio driver

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
Changes for v10:
   - modify error words
Changes for v9:
   - no changed
Changes for v8:
   - no changed
---
 .../bindings/gpio/nuvoton,sgpio.yaml          | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
new file mode 100644
index 000000000000..9e32e54aeb24
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton SGPIO controller
+
+maintainers:
+  - Jim LIU <JJLIU0@nuvoton.com>
+
+description: |
+  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC and detailed
+  information is in the NPCM7XX/8XX SERIAL I/O EXPANSION INTERFACE section.
+  Nuvoton NPCM7xx SGPIO module is combines a serial to parallel IC (HC595)
+  and a parallel to serial IC (HC165).
+  Clock is a division of the APB3 clock.
+  This interface has 4 pins (D_out , D_in, S_CLK, LDSH).
+  NPCM7xx/NPCM8xx have two sgpio modules. Each module can support up
+  to 64 output pins, and up to 64 input pins, the pin is only for GPI or GPO.
+  GPIO pins can be programmed to support the following options
+  - Support interrupt option for each input port and various interrupt
+    sensitivity options (level-high, level-low, edge-high, edge-low)
+  - ngpios is number of nuvoton,input-ngpios GPIO lines and nuvoton,output-ngpios GPIO lines.
+    nuvoton,input-ngpios GPIO lines is only for GPI.
+    nuvoton,output-ngpios GPIO lines is only for GPO.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-sgpio
+      - nuvoton,npcm845-sgpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nuvoton,input-ngpios:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The numbers of GPIO's exposed. GPIO lines are only for GPI.
+    minimum: 0
+    maximum: 64
+
+  nuvoton,output-ngpios:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The numbers of GPIO's exposed. GPIO lines are only for GPO.
+    minimum: 0
+    maximum: 64
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupts
+  - nuvoton,input-ngpios
+  - nuvoton,output-ngpios
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    gpio8: gpio@101000 {
+        compatible = "nuvoton,npcm750-sgpio";
+        reg = <0x101000 0x200>;
+        clocks = <&clk NPCM7XX_CLK_APB3>;
+        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        nuvoton,input-ngpios = <64>;
+        nuvoton,output-ngpios = <64>;
+    };
-- 
2.25.1


