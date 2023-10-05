Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6557BA017
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjJEOdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbjJEOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A91FE7;
        Wed,  4 Oct 2023 20:59:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-405361bb94eso5009595e9.0;
        Wed, 04 Oct 2023 20:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696478386; x=1697083186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXI1BYhZWroocq19G+lhuGPa3qcX4f4uqnmYQsIg5xc=;
        b=cnSqW9OQrP/MA0A2Igu9rpFUTiecXjx1R5veLPYBVDo1efRD/IJNrGsO0UVWaMWdTo
         Q7YmEBEEPDE8LyjCJ4xn1CqCQzIOv7AkJOmY+Thkc+ph9QqhSDvXbBJvmyl3UXncWQKA
         96tEZ2+7kOhm6utcKcYpyh6dUxqCY6i8VimmAsbexFHinVzZw8L7xKKgDuFu6LqHQjIZ
         udBlrIN/cqSTpLiWGVDZKJ0yDrT0ik3aSsT+GNyf+6j2hyxZCL21FV4287PW61B4TmHO
         KEvPZ8BooE1Upm9Y17tTWSU9pse+UWjb2sa1MNxuclf5kDDLZdC5DyjSABWR7XY6nWQE
         EuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696478386; x=1697083186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXI1BYhZWroocq19G+lhuGPa3qcX4f4uqnmYQsIg5xc=;
        b=gXzsWT+S7VKwlfRPrDCnIfOp64ePzBUVqRFlD4dVUQNbF9j/4ZTGB6poEvCue/qdnk
         mDiFCeOEFrT1eTrYn/9fNQVlLGKlE55Z1CMg9wwNDoaJKGppRxNoeH7CfSBygzHbnnIm
         jJzzlUFqBoDlOK6O/0u6qG+6i6Ry5ULoFJD2nwY0F6nzKcjmryYsiXYPT+WR8W0JY6AB
         eaOJthDsn/aaqjrrqPpSor+45oCoynuj9kr2enys3eUiVX0s4psPEuavxt/O9jx7eXJH
         d+97eEgZS0K9wktrc+rEhVHfZDcTl4qqn5QWV9hns54Qi9XrZZE+E/b4FidEMWAqJAZj
         S1RQ==
X-Gm-Message-State: AOJu0Yx0VNYFNj05m3x39qQE3DidnRoMr9iao38Hv8eXWyl215gPtDUl
        mCuEzUK1zk3jLVEbnuxostQ=
X-Google-Smtp-Source: AGHT+IHxJf1A+5f7DI0S276G253TSqUVG3SXkPwSa6MCPaqvDLMC8Y5kLTiGVWXqCXpOsZOxGw5igg==
X-Received: by 2002:a05:600c:2107:b0:405:48ba:9c with SMTP id u7-20020a05600c210700b0040548ba009cmr4036141wml.16.1696478385427;
        Wed, 04 Oct 2023 20:59:45 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2a40d287sm567513wmm.1.2023.10.04.20.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 20:59:45 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads7038: Add description for ADS7038
Date:   Thu,  5 Oct 2023 05:54:54 +0200
Message-ID: <20231005035933.31016-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Werner <andre.werner@systec-electronic.com>

Add basic description for ADS7x38 ADC devices. The driver does only
support a very basic set of functionalities provided by the chip.
Also, the example in the description covers only a setup for ADS7038 devices
while the driver structure will support both ADS7038 (SPI) and ADS7138 (I2C) devices.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
- v2: Add commit message and correct vref-description copy-paste-error.
---
 .../bindings/iio/adc/ti,ads7038.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
new file mode 100644
index 000000000000..d40869b9a604
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads7038.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS7038 and similar ADCs
+
+maintainers:
+  - Andre Werner <andre.werner@systec-electronic.com>
+
+description: |
+  Family of 7 channel, 12 bit ADCs with SPI/I2C interface.
+
+  Datasheet: https://www.ti.com/lit/gpn/ads7038
+
+properties:
+  compatible:
+    enum:
+      - ti,ads7038
+      - ti,ads7138
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 60000000
+
+  vref-supply:
+    description: Supplies the reference voltage AVDD
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads7038";
+            reg = <0>;
+            vref-supply = <&refin_supply>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.42.0

