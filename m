Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5914E7C7C52
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjJMDsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjJMDsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:48:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A0B7;
        Thu, 12 Oct 2023 20:48:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so353920b3a.2;
        Thu, 12 Oct 2023 20:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697168896; x=1697773696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2B5MRCdS30z64p1Sa9vHfR8Dan7IFlM4yV989pxBy0=;
        b=nqFzm1oglVtP7GtVz2sedOETBNRRHvfq3w2Mb+w2KuH75gqH1P4St1hHqZG/Tq6YJt
         HQZyf5Cp1RNBcsmMjjwdvPzXByRcN9/2veC1VzBeJEgq5RP6cyYSoTHwpQ2cTYXI9aY5
         LNyRTNZcPjOs/8uH7qqoh40L0GiaOn8doBrl4Bx+IbL1L0V+IE1ydh2hDCCv9gkv6/MF
         zYnr8UHEmJ0jTL4hBXRQ+cNU5w78Msr7YO0ZT5zucmYJ4epoUBoJoElp1uztzw/tgB4u
         ojSrdClqXXfZ/JoVn7G5zODR9+QMdx3UaoDuvUg+sytVSseTELtM/6HKJlhaLbJhu12H
         pLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697168896; x=1697773696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2B5MRCdS30z64p1Sa9vHfR8Dan7IFlM4yV989pxBy0=;
        b=vliF4ayJwIH+JDUhJ4fYfEEjszN1W/+GALujR6fTGiFzCskvEn/TwBidIMtUqoc3MP
         gVg2WBsDCu59CKZR/daj4VoLS+1UTrITKdeyhf6Kzp7zMc1mIi1NlceRcrWLzQnly8AX
         yDvhcxDQ2nSYFPdIVd30+An+9cNMSrmoxWEYcE8kuIOvdjDmNF40nBNy+E8shfEAkbdv
         ku23m0WSaBcTiuVMg7S7w5l8RE4JxrtYeBm9wBBwadTaOV/nBP1FNzo5BrHGOTbLVTsk
         w2J53TM4ORJb++c1GBf+8AvyzNn91euyAFH0SscO+VW2IegwFFotUb39P4ImWNXdEhi4
         fvXw==
X-Gm-Message-State: AOJu0YxMsTJFqNUQhkkh9goim6Jnk4HgPZGPYxAWm2o1orQ1xN3ALCwH
        yKxoidik8POW9CmFDVVoElo=
X-Google-Smtp-Source: AGHT+IEJFFASqbaOXejnYkUr8SMUpcqLTujiIi8IDObtSN546/XDruKBxUuPewut0usLHlwKm50IBg==
X-Received: by 2002:a05:6a20:5482:b0:16b:afc2:3b68 with SMTP id i2-20020a056a20548200b0016bafc23b68mr24360486pzk.25.1697168896603;
        Thu, 12 Oct 2023 20:48:16 -0700 (PDT)
Received: from localhost.localdomain ([115.99.190.148])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001b53c8659fesm2777023plw.30.2023.10.12.20.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 20:48:16 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: Add Bosch BMI323
Date:   Fri, 13 Oct 2023 09:18:07 +0530
Message-Id: <20231013034808.8948-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231013034808.8948-1-jagathjog1996@gmail.com>
References: <20231013034808.8948-1-jagathjog1996@gmail.com>
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

Add devicetree description document for Bosch BMI323, a 6-Axis IMU.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 .../bindings/iio/imu/bosch,bmi323.yaml        | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
new file mode 100644
index 000000000000..64ef26e19669
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bmi323.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI323 6-Axis IMU
+
+maintainers:
+  - Jagath Jog J <jagathjog1996@gmail.com>
+
+description:
+  BMI323 is a 6-axis inertial measurement unit that supports acceleration and
+  gyroscopic measurements with hardware fifo buffering. Sensor also provides
+  events information such as motion, steps, orientation, single and double
+  tap detection.
+
+properties:
+  compatible:
+    const: bosch,bmi323
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    description:
+      set if the specified interrupt pin should be configured as
+      open drain. If not set, defaults to push-pull.
+
+  mount-matrix:
+    description:
+      an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example for I2C
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@68 {
+            compatible = "bosch,bmi323";
+            reg = <0x68>;
+            vddio-supply = <&vddio>;
+            vdd-supply = <&vdd>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <29 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
+        };
+    };
-- 
2.20.1

