Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8360A7B8B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbjJDSq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244587AbjJDSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:46:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7BAB;
        Wed,  4 Oct 2023 11:46:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c87e55a6baso533535ad.3;
        Wed, 04 Oct 2023 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445212; x=1697050012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGkn6FWnzPVYcS/g+kK6fmU6Eb+O3BODHAwBfu1+xyI=;
        b=Vkroi5OFsLnWFucFDOtcljNDg23dSbV0qcTMi5hx1KmuzxFtcT4aGazZ0Fp8cTDgwP
         r95T5zmxe3stX2m+y4xQ+SzmKUEtDk81QBmyF8abOSEKljgy4m8soLMxoFK19ZDbIfO4
         pCZaIoUC+MQ96GI5LYmU6xacYKUAmmLX2u0yefsucDfAkV6e4tpIGLCiJ9RGl1DT9fQ1
         wcrLOyeL8xy3KiJUKsHCDBBQANvQienWz0/D09TYZOYvhAbPN5Fo4337foUdZSWzG2Zp
         CxE1y3vRSh05Cvbtchqz1dPbpq36uMYeBRgPatPXSmjCPPnkzaopCrLh5dcXil+GkSo5
         jnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445212; x=1697050012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGkn6FWnzPVYcS/g+kK6fmU6Eb+O3BODHAwBfu1+xyI=;
        b=A1T8bGskLM4Zo/v03U8YV+IIafwwz8m1PnjmnTG+Hq1Ysi9EjaFg7bpMIwQMZABe2u
         q9wNXrugV8dHlfX5VHkUDlNFKqeLI4i1qGwxOtnzgOSkxjGyhsXYpdOR+ECSETdykEsI
         FZTYtg+VcfH5aAVNS2x6Cw/1rIgt7XI9WMddBxOB2FaK7PiV51qQLXLkDlu5SMEzDabS
         DhWZkrUgoeDVNzsyPJ5FwfjS383+MZ16hel/oMoAr/o7xjJhvUwQ9vYYyek4XYuByDgl
         h9g10dUmRerxCoVB571vhbLy/XS/GEh06nE4RUCu3Bpwt+oG3Q7NljcALSVh4OfiIWu+
         Nykg==
X-Gm-Message-State: AOJu0Yyz769o+LT+XB+vlmpwIunJ1drnwWv2uZpF30TR7qKNT4NOGQZ5
        wfr53EReHMm4qHNDIc+Zypw=
X-Google-Smtp-Source: AGHT+IFYXF4ZywWRqeV1R0fq27lUfsrP0h0L4NrBtdG7W3yLqL6MqhzBhYpU1sPxwi5C26jmMvlNcw==
X-Received: by 2002:a17:902:ec8d:b0:1c3:4210:623f with SMTP id x13-20020a170902ec8d00b001c34210623fmr3812679plg.13.1696445212361;
        Wed, 04 Oct 2023 11:46:52 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b001b9d95945afsm4063903plj.155.2023.10.04.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:46:51 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/3] dt-bindings: net: Add ti,cc1352p7
Date:   Thu,  5 Oct 2023 00:16:36 +0530
Message-ID: <20231004184639.462510-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004184639.462510-1-ayushdevel1325@gmail.com>
References: <20231004184639.462510-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Texas Instruments Simplelink CC1352P7 wireless MCU

BeaglePlay has CC1352P7 co-processor connected to the main AM62 (running
Linux) over UART. In the BeagleConnect Technology, CC1352 is responsible
for handling 6LoWPAN communication with beagleconnect freedom nodes as
well as their discovery.

It is used by gb-beagleplay greybus driver.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 .../devicetree/bindings/net/ti,cc1352p7.yaml  | 51 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
new file mode 100644
index 000000000000..291ba34c389b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,cc1352p7.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Simplelink CC1352P7 wireless MCU
+
+description:
+  The cc1352p7 mcu can be connected via SPI or UART.
+
+maintainers:
+  - Ayush Singh <ayushdevel1325@gmail.com>
+
+properties:
+  compatible:
+    const: ti,cc1352p7
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    description:
+      sclk_hf is the main system (mcu and peripherals) clock
+      sclk_lf is low-frequency system clock
+    items:
+      - const: sclk_hf
+      - const: sclk_lf
+
+  reset-gpios: true
+
+  vdds-supply: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    serial {
+      mcu {
+        compatible = "ti,cc1352p7";
+        clocks = <&sclk_hf 0>, <&sclk_lf 25>;
+        clock-names = "sclk_hf", "sclk_lf";
+        reset-gpios = <&pio 35 GPIO_ACTIVE_LOW>;
+        vdds-supply = <&vdds>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 37b9626ee654..5467669d7963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8969,6 +8969,12 @@ F:	drivers/staging/greybus/sdio.c
 F:	drivers/staging/greybus/spi.c
 F:	drivers/staging/greybus/spilib.c
 
+GREYBUS BEAGLEPLAY DRIVERS
+M:	Ayush Singh <ayushdevel1325@gmail.com>
+L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
+
 GREYBUS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 M:	Alex Elder <elder@kernel.org>
-- 
2.41.0

