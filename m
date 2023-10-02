Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42FF7B5A2E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjJBS0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjJBS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:26:35 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A350AB;
        Mon,  2 Oct 2023 11:26:32 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b706f604aso36035eaf.0;
        Mon, 02 Oct 2023 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696271191; x=1696875991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deMrdhI7n6d43o9ynRDnYKYyrcO/xdvIoxsUthjyE5k=;
        b=dfIcc9UmlO+rUUVyQyhyOsaSdDVtD0CVxerEh5mxALGYoUcbwm5UizUKW0R9W8wnPS
         seF+agmQlf/q6HUw9WsI1ZYqvv4wVLtm/jOrAWNkUg4uRuet23kbSOVzoppi9/vnwm6c
         rMQOiKuR5N30uOxzHSp2+An3QmiQsjcj34TPpXaGjS/43TohldALecVKjSC85JAEF2eF
         RV5i2muvSKxEafyfler4xnCfe4+sWc05wPgjDKHC9/P9t/V7R+VXABSAh2SFaVYbNViL
         WLcqIhfr5ODfmKdAk/5i2gcVmD1m8itPlC6IE9Q+X4yEAppm62jJrfTuZqu3+B7aVqnd
         rAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271191; x=1696875991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deMrdhI7n6d43o9ynRDnYKYyrcO/xdvIoxsUthjyE5k=;
        b=OYOt0nYhZKpK6Zf+Eur5xKUvmUvU3CkcgB6hMsJ0IA5VDjw0vKdJwV74tmLb7osF/f
         QVVAGxPcthWFo3C5GCzgDPzmmKPGBViMYvy0mEi977oAI2Z10XN+5Y9/rV0OCBFSvRpa
         f2SrtLQ0aern3x+QZ81kFwNrE95+p06CI6Gnr/n3OjfxSnmS4leAs+zJ/zdQXe5QiIA4
         kDCcMLkBL/55x7kF3IfpsX9xpppQfqV0b1ZsVQpmDuVdhnkC1ZO7iZ4PmbnNWzOIx4gI
         r5rwfw/wllrIiuCnGl3qHsY6xRo7J8vg8MhmFDPHLnTbKdKDfnEPx/1b6gxIHntlUJPI
         qBqA==
X-Gm-Message-State: AOJu0YwAp6sR5MM7Zvw+XfQuuWkJMeKH3soE/lReHLVoeiPBxpgaknLY
        Ofsy59iOpTSv+a/BYgn4Xo4=
X-Google-Smtp-Source: AGHT+IFOOEkZ1k10QlUz+9HgXzSS9Pvfa+Dg0k015541iUOgbMH4VTd4c1S1ehXHCVvJkRE1UfckhA==
X-Received: by 2002:a05:6358:339f:b0:142:d1cb:48ab with SMTP id i31-20020a056358339f00b00142d1cb48abmr14693012rwd.15.1696271191244;
        Mon, 02 Oct 2023 11:26:31 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id a8-20020a637f08000000b0057d86bb613esm17249584pgd.45.2023.10.02.11.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:26:30 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 1/3] dt-bindings: Add beaglecc1352
Date:   Mon,  2 Oct 2023 23:54:50 +0530
Message-ID: <20231002182454.211165-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002182454.211165-1-ayushdevel1325@gmail.com>
References: <20231002182454.211165-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for BeaglePlay CC1352 co-processor.

The BeaglePlay has a CC1352 co-processor. This co-processor is connected
to the main AM62 (running Linux) over UART. In the BeagleConnect
Technology, CC1352 is responsible for handling 6LoWPAN communication
with beagleconnect freedom nodes as well as their discovery

This commit adds net/ti,cc1352p7. It is used by gb-beagleplay greybus
driver.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 .../devicetree/bindings/net/ti,cc1352p7.yaml  | 48 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
new file mode 100644
index 000000000000..57bc2c43e5b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
@@ -0,0 +1,48 @@
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
+  reset-gpios:
+    maxItems: 1
+
+  power-gpios:
+    maxItems: 3
+    description:
+      The device has three power rails that are exposed on external pins VDDS,
+      VDDR and DCOUPL.
+
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
+        reset-gpios = <&pio 35 GPIO_ACTIVE_LOW>;
+        power-gpios = <&pio 1 GPIO_ACTIVE_HIGH>, <&pio 2 GPIO_ACTIVE_HIGH>, <&pio 3 GPIO_ACTIVE_HIGH>;
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

