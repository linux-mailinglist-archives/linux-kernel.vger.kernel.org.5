Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E63E7B7D05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbjJDKXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjJDKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:23:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B0A1;
        Wed,  4 Oct 2023 03:23:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso4252735e9.1;
        Wed, 04 Oct 2023 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696415013; x=1697019813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNz5tWyWg32rEEVo2HkyNR7o8q6W8x4WMHTpXLt2EeU=;
        b=VpmDXnRTT1j70YglARWCyqUKMSmIutlVpwgermlUQT5c0smDGGNaWSYcRT1LdfTUBw
         WRk4goD214Je8JGPEN8y3mRhtPD+VEDGSP6cLEK1A8UOvtMSqGOeE4yJcWVnmtkQi8xf
         W7dQh01GbobxU4n59QfcWTcGRCGmmzTc3qwf9yU8DO0kjHkdx/Eq9w3RqmQYJfL6bxIL
         Lq+pEbBRWK/i4NIniNugqNwV+MRNtlxxWTcI+KDzBFWqggvad97RyIodv/4MqF2h8Xng
         7Hq9qbYZ5K8maxnBcanm0Fe2mJlj6eFbEks8pLM65XHMB0dqFyzTo0sHkMSoJo4WgWfk
         k/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696415013; x=1697019813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNz5tWyWg32rEEVo2HkyNR7o8q6W8x4WMHTpXLt2EeU=;
        b=cd7ixFO9oiP8iginZ7yOFa9PvzPE3e0Gt8roEjynYs5WyhnTlT58AagHXTsaerkCTN
         wXmmoFugKF6vpq/f0gJi7MZHFYhPl9CWSH1XkW3000Dr470Osq0hMsXrcmuGbF/H2HqM
         IK437QYmavQADhaM6O8YgaZj46xFXiFw1EhpFyp+T5fxmAwIC62g7Y7XbvbOBapVQL59
         Vd1nzMxRhSu6naBjRtNy/B63NBNAq1SsMO1wmIKpGv0w9HT8tnzbOV45N0PQV5TWt6SE
         OHl3eYikw7bkdtxeknQYzgab0zJCLvycdAv0hQGApsHCQiAlIQFl1jDC6nIlStK8Snl4
         H46A==
X-Gm-Message-State: AOJu0YxfXkVpaDiuAzeJmM3Y+inBg1Wo/K7Q1U315C894BqnFAE0RyQH
        vhvvWKNqqbEYiOPvJbW2yJbAWq73/6bkUA==
X-Google-Smtp-Source: AGHT+IHg17n+N3MDjOMelKI4WqZhmHi6rJY88NumRsl06Gtx1Zrr5GaT05ekgXNxNlgh5ir6jmzwNA==
X-Received: by 2002:adf:de09:0:b0:319:5234:5c92 with SMTP id b9-20020adfde09000000b0031952345c92mr1298110wrm.35.1696415013256;
        Wed, 04 Oct 2023 03:23:33 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d63cf000000b003143c9beeaesm3631043wrw.44.2023.10.04.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:23:33 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ti,ads7038: Add description for ADS7038
Date:   Wed,  4 Oct 2023 12:23:29 +0200
Message-ID: <20231004102330.3713-1-andre.werner@systec-electronic.com>
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

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
 .../bindings/iio/adc/ti,ads7038.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
new file mode 100644
index 000000000000..37fbae95c8e6
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
+    description: Supplies the 2.5V or 5V reference voltage
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

