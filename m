Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE80C7CC040
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbjJQKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjJQKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:11:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029F4E8;
        Tue, 17 Oct 2023 03:11:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9b70b9656so32612115ad.1;
        Tue, 17 Oct 2023 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697537487; x=1698142287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/xhityidHANRldjqCZLdwURqWfb6ZxMT/TSWeuUQRw=;
        b=TdHR09/FojOWswG0B9uZQ0Gafvv6fm/jrtC82N64ET9P38KoASGB0nhv2kJofNyZZs
         ddZog2+bMQ1pqFJBW7d16aFpOlx7OCGxK7MlLKd5AygTMBdalLTaKpKoCUSQNzde1Rwo
         aJD4zT1TH3f6NFVQcbrJOP7q+pZSlUc/PltVGKkSgEd/el/VVp+6g/q8CW/aaPQxk0HD
         yIdSTDkypnHod+SXywL0ceHaeT9eyqu9fItV5Fp1qwNwov/S81I/YAL0vdW7O3NaFGoH
         D3x4gYymLRocDEvihgwum4T1yJlu9OarG/Rjdf9Lt0D1yG406QN9Iy8nWZHTzj8MJbmF
         NZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697537487; x=1698142287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/xhityidHANRldjqCZLdwURqWfb6ZxMT/TSWeuUQRw=;
        b=BAoUVpqE1NKjAD4mqm+ucWocRb+bkSnNLsAiW1vuzSCpuGUl7ro++idwt4azkLDlso
         3XZ8bDSR6Mn4MujOcwAosfmM4Rcrd3ivJ176oyRfJ8F4Qu95TQjfag9dMbtYmJJtxGta
         dA1zOiyZeUUiYRSpunQrqgflYd5g/4+us0ubqhyHPhRl33UXrCGjNjtZ3fwXox3D2i1D
         GKur2dalbF2YoXRsb06bl8cA1mcLHC8TOQgQpjZyvWeXGHRGMWkJ0K6SQT7G1j073LiY
         YQARyhVqlPLVgJii7EUUydnleIMrjLinUmAnaIEfaqdYhrAuocY7ZHROBCju6xq+yIHQ
         nCUA==
X-Gm-Message-State: AOJu0Yxa5bI9yMq63bS/nTY3lS968RP1ZpU51TVe5gbSanDhz4Rvifkw
        NrwJ0AuuN+q/qq6oQAqcpr8=
X-Google-Smtp-Source: AGHT+IERzA5Z7Z0TYiNwEpJH1G57kh34XWYQ19Y6Czdr8THGHCovdeCYtJWE1UDEHzJ5penp9zhgfQ==
X-Received: by 2002:a17:902:ce8b:b0:1ca:3d53:2867 with SMTP id f11-20020a170902ce8b00b001ca3d532867mr2062576plg.15.1697537487400;
        Tue, 17 Oct 2023 03:11:27 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001bbb8d5166bsm1127634plx.123.2023.10.17.03.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:11:26 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/3] dt-bindings: net: Add ti,cc1352p7
Date:   Tue, 17 Oct 2023 15:41:12 +0530
Message-ID: <20231017101116.178041-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017101116.178041-1-ayushdevel1325@gmail.com>
References: <20231017101116.178041-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/net/ti,cc1352p7.yaml  | 51 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
new file mode 100644
index 000000000000..3dde10de4630
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
+  The CC1352P7 MCU can be connected via SPI or UART.
+
+maintainers:
+  - Ayush Singh <ayushdevel1325@gmail.com>
+
+properties:
+  compatible:
+    const: ti,cc1352p7
+
+  clocks:
+    items:
+      - description: high-frequency main system (MCU and peripherals) clock
+      - description: low-frequency system clock
+
+  clock-names:
+    items:
+      - const: sclk_hf
+      - const: sclk_lf
+
+  reset-gpios:
+    maxItems: 1
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

