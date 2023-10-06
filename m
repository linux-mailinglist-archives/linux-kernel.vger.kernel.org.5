Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F17BB0B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjJFEMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJFEMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:12:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F3DB;
        Thu,  5 Oct 2023 21:12:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1470048b3a.0;
        Thu, 05 Oct 2023 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696565531; x=1697170331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ElaHiBH2gpr//Jw4k1jpeuPEUC0EHD6jwce46X0hpw=;
        b=Xuitsgfg0BJu+hRQFXk0Dzr8TSNtEEN60ttuuPoLN5xfsdmoR13npq1zGQjK9CX4FH
         93fhG4/En8DVtcOhSQN5fLUZm6qPwkCYgZ/FSBdOWe0OCWKFUAmZUEIZ2oEhwKU04yEp
         Gf67NUngFMjJXocmEqpB18+LwrIf6dm3CrXnnDCHJJ1SagzBpmM7N4haAV/6qV6/fFlQ
         cLK06kx3BhBUIStnucZttY56kbybfgwGOXK6MiTW4wpCvmgdlSFAjvpWbYSe7VfcC0ZF
         9un21q+gfCmD9vjZ1vcuRzwVdJQ+aRh6nW0vLC1+o7Q4oGCk2fUSDzEWL85U3KUm0JhW
         Bu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696565531; x=1697170331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ElaHiBH2gpr//Jw4k1jpeuPEUC0EHD6jwce46X0hpw=;
        b=hyhVhwxPW5D1Fihfpsq/JPmsm8t9EZBcTHOC93Srr97KMAXilBxvHDXb0kMMAbCuQA
         uF79KxdSYw9sdtbisCWJHDau4bE23Pg9cmwDbZYVcbeI3nYuZPV9xnJ0UodBOxe9Iq2k
         5aleG+sFVVecYYwRU44fjdGFT1oJnuxYpzaaSXmPtGwWSDkLUtPnNeITzdcLUvu64qut
         fx6uBckpnqdRFL0owSOtps+UOl94O0lzC60P//l5mO2SZFV4pKeffxUjpbzEAVH1apXG
         h5RLtRw8Wj1tD0NDVCtWpIRkWgyIbF8wo+tpSftj7cugoVNYpgaow5NeGfJzmrJSxt2m
         ClyA==
X-Gm-Message-State: AOJu0YxDjmzNu7cdsFwYIHzcrQTZVZ6R7apzaBxEpADH787EiP+2roXG
        ynFKFglPhH3dHPfVQ+MmJDY=
X-Google-Smtp-Source: AGHT+IGCUK795EYjNWmS1WCmxu8wWlR0iFUgaTwAN667aycGcat4PIME2RRoQEut2/Wz8COmWS6MvQ==
X-Received: by 2002:a05:6a20:8e29:b0:15d:684d:f514 with SMTP id y41-20020a056a208e2900b0015d684df514mr8294977pzj.6.1696565531371;
        Thu, 05 Oct 2023 21:12:11 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.92])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79391000000b00694fee1011asm401131pfe.208.2023.10.05.21.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 21:12:10 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 1/3] dt-bindings: net: Add ti,cc1352p7
Date:   Fri,  6 Oct 2023 09:40:31 +0530
Message-ID: <20231006041035.652841-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006041035.652841-1-ayushdevel1325@gmail.com>
References: <20231006041035.652841-1-ayushdevel1325@gmail.com>
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
---
 .../devicetree/bindings/net/ti,cc1352p7.yaml  | 51 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
new file mode 100644
index 000000000000..742763e04543
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
+    items:
+      - description: main system (mcu and peripherals) clock
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

