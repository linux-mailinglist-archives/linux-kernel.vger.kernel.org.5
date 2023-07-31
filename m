Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC2B76941F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjGaLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjGaLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:03:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB16129;
        Mon, 31 Jul 2023 04:03:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso25442301fa.3;
        Mon, 31 Jul 2023 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690801382; x=1691406182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VbuOesFY8jgrwRNfOH6TH6GpPlQAQeFgnVpyaXLhy0=;
        b=NYA+jcorU61v4iXcDDJEPRNT7gO9w1yrLMAr5FWtCaHkz78BGEWVxa4ZY4D6824oH5
         6VIOJK8OrP0OXoAy9hf8OykiN1DMgfSOThVv+evF9JoZxB1NaLldeZ7oNz0DwEvVJ2TQ
         o20Gt1Gf7U2Ucz2KiQixp85pX8OivoGyFrdJqnC09eHMA1LliIQ+LgRoSgc9t5aURtqs
         lVqq5hnaisSRpByj7+gZU8SBi0adebwvb0F16KBAZqotd7jpO6JqpAgYujo3oQ4N3a1V
         e6QvK/ARiuMwTwqPl4OuRtL05dzjsYiLx14PK0CRHfS7j2dreA3KmpV7mgbHLKXni3SW
         VrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801382; x=1691406182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VbuOesFY8jgrwRNfOH6TH6GpPlQAQeFgnVpyaXLhy0=;
        b=StKyxOvmBr6X8QQYq7j5/kXt1KeVqqbS5rXNN7daAKVm5NRp2qGkiPmL5SBSNRnzHQ
         RmoeYfOymCi7ZP1aRYeS/3mrLwZoJb3VX+UeOJe9M6c0I4tQg/Byk/BJKK4ZuMr+i/wp
         i81hn3nSWP2xdGoWnRWvevJAvWEpkFjild1aqYCazjW6qYBt1LMZqpDcVxi0p6dXblZp
         4PGVeJ517ntRLbgubFi3KN9nERJUup7cH8FHsskIyreo8u0GxNhM+xrLEJ3GXnbrzpxV
         CC+BpSROqf1Exc8OF0s8lZzV4qLJeSusTpOaHWwPmty00FXtF4ZXKUf3/je7cqyvKLXK
         kDMQ==
X-Gm-Message-State: ABy/qLZreHN8y/3VDOT5pKi+XRx9Erj0+8jS3gOpda/AU90u1fsoBR1v
        +5T4mpq2GslsFzVYf2MYsJ4=
X-Google-Smtp-Source: APBJJlE9CLief85Q66abBBrZuGY9xYj2+K7h86HSzXoeuo0Pijv+5vETfPXq9VR5K72gnQvF+GFjdQ==
X-Received: by 2002:a2e:6e14:0:b0:2b9:dfd1:3808 with SMTP id j20-20020a2e6e14000000b002b9dfd13808mr2984934ljc.25.1690801382092;
        Mon, 31 Jul 2023 04:03:02 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e8042000000b002b9bf5b071bsm74607ljg.20.2023.07.31.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:03:01 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Samu Onkalo <samu.p.onkalo@nokia.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: iio: light: add apds990x binding
Date:   Mon, 31 Jul 2023 14:02:38 +0300
Message-Id: <20230731110239.107086-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731110239.107086-1-clamor95@gmail.com>
References: <20230731110239.107086-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding for apds990x ambient light/proximity sensor.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/iio/light/avago,apds990x.yaml    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
new file mode 100644
index 000000000000..89a061643de5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/avago,apds990x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Avago APDS990x ambient light and proximity sensor
+
+maintainers:
+  - Samu Onkalo <samu.p.onkalo@nokia.com>
+
+description:
+  APDS990x is a combined ambient light and proximity sensor. ALS and
+  proximity functionality are highly connected. ALS measurement path
+  must be running while the proximity functionality is enabled.
+  Datasheet at https://docs.broadcom.com/doc/AV02-2867EN
+
+properties:
+  compatible:
+    const: avago,apds990x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+  vled-supply: true
+
+  avago,pdrive:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description:
+      The LED drive current is controlled by a regulated current
+      sink on the LDR pin. This feature eliminates the need to use
+      a current limiting resistor to control LED current. The LED
+      drive current can be configured for 12.5 mA (pdrive = 3),
+      25 mA (2), 50 mA (1) or 100 mA (0). For higher LED drive
+      requirements, an external P type transistor can be used to
+      control the LED current.
+
+  avago,ppcount:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 255
+    description:
+      The number of LED pulses can be programmed to a value of 1 to
+      255 pulses as needed. Increasing the number of LED pulses at a
+      given current will increase the sensor sensitivity. Sensitivity
+      grows by the square root of the number of pulses. Each pulse
+      has a 16 mS period.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+  - vled-supply
+  - avago,pdrive
+  - avago,ppcount
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+            compatible = "avago,apds990x";
+            reg = <0x39>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <82 IRQ_TYPE_EDGE_RISING>;
+
+            vdd-supply = <&vdd_3v0_proxi>;
+            vled-supply = <&vdd_1v8_sen>;
+
+            avago,pdrive = <0>;
+            avago,ppcount = <3>;
+        };
+    };
+...
-- 
2.39.2

