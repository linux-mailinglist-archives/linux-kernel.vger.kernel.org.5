Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72975B327
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjGTPkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjGTPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:40:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C8F10A;
        Thu, 20 Jul 2023 08:40:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso1311840a12.0;
        Thu, 20 Jul 2023 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689867619; x=1690472419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsbU8ooj7S9jmkq9hSAh/7F5SKUWz7tmOq8dW3PqPg4=;
        b=UmBevlosBXQt3URK+UhcEuAllkolwtShCPzI9wum1M5f9RCts4jcmWJvruL1dz1tcz
         pDWdwoZPW9yRMDm4kXzXvfiBW/pdAAOD0S8UBFGSbpqwmsGD9+UWyFSJMoc9xirFecHy
         x2DCBNWJtNT1S9YYwkkXS+URXnsAcWXyQKOt2f27EnVk+SgdYKL2/p0pTelUL2p1b15r
         4H+nmy1xpDsJi+AndutddZra13oKft5BuBVrcMG/h7FTDtZpq394TP/t51QoSGx1HChh
         NQSdN6iZzWxqHCnob+Y0LOQfCIyzOvQhqhxwCwFRfvUe49JBwwa6BUKXtwN99ZayoBPf
         qkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867619; x=1690472419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsbU8ooj7S9jmkq9hSAh/7F5SKUWz7tmOq8dW3PqPg4=;
        b=iizCelj1uaI/Wln1X9VOFPvFwoQpTYUIkBrY2QITGtvqQwRl2pN+Ym/DIh3Kw5N4FZ
         DjKSkbJHB41usXaPWtjXF6mY9OvnJUC5rDCafsnVcv5kyfIxyrfnlsfOwZOz/yA+vXmb
         iwIooU1LJWUXEIoWQT/Mczo3DKJ9qTozQFPivmx/7JX7qgUyD6BsA6KGD984LoWjCr+G
         Ndpq20CIGBlvMJ8EcquI0bLNw/wmrbSuDWZI5broF64p7SS2KJVh3zeir46W5nP8+ejk
         +GQSdyy51nIUhTNhRGbhYmxYiSA4bI/8J/3te73wg8fq3ZhlN+rg+pbV14fbWz9BhRla
         lUjw==
X-Gm-Message-State: ABy/qLbZx82qqDAfYbRf3VlVaUqiAcV9NVzoLOubQy/bwaGk7wFm+vgL
        AesvNkiSJmJf7bwD8ruvS3g=
X-Google-Smtp-Source: APBJJlG1eF/RIRoP5fphu9rSD3DYQvQeUp1+90MIA4aJ/g7EmkwB+jNJb+bppViQsPAz15sX59+hiA==
X-Received: by 2002:a05:6402:2145:b0:51e:2a56:91d6 with SMTP id bq5-20020a056402214500b0051e2a5691d6mr2404109edb.19.1689867618600;
        Thu, 20 Jul 2023 08:40:18 -0700 (PDT)
Received: from colla-nuc.fritz.box (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id n2-20020aa7c782000000b00521953ce6e0sm899882eds.93.2023.07.20.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:40:18 -0700 (PDT)
Received: from colla-nuc.fritz.box (localhost [127.0.0.1])
        by colla-nuc.fritz.box (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 36KFeHig119646;
        Thu, 20 Jul 2023 17:40:17 +0200
Received: (from colla@localhost)
        by colla-nuc.fritz.box (8.15.2/8.15.2/Submit) id 36KFeHtU119645;
        Thu, 20 Jul 2023 17:40:17 +0200
From:   Andrea Collamati <andrea.collamati@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrea Collamati <andrea.collamati@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Date:   Thu, 20 Jul 2023 17:40:02 +0200
Message-Id: <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689857295.git.andrea.collamati@gmail.com>
References: <cover.1689857295.git.andrea.collamati@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for MCP4728

Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
---
 .../bindings/iio/dac/microchip,mcp4728.yaml   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
new file mode 100644
index 000000000000..6fd9be076245
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP4728 DAC
+
+description:
+  MCP4728 is a quad channel, 12-bit voltage output
+  Digital-to-Analog Converter with non-volatile
+  memory and I2C compatible Serial Interface.
+  https://www.microchip.com/en-us/product/mcp4728
+
+maintainers:
+  - Andrea Collamati <andrea.collamati@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4728
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: |
+      Provides both power and acts as the reference supply on the MCP4728
+      when Internal Vref is not selected.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mcp4728@60 {
+            compatible = "microchip,mcp4728";
+            reg = <0x60>;
+            vdd-supply = <&vdac_vdd>;
+        };
+    };
-- 
2.34.1

