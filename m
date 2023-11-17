Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E367EECAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjKQHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQHdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:33:32 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30AED4B;
        Thu, 16 Nov 2023 23:33:28 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b5714439b3so969522b6e.3;
        Thu, 16 Nov 2023 23:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700206408; x=1700811208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3VX/lRKzVRq1yghMKNb5rPnujs/Enhs7H6aGeq5rBrw=;
        b=hikjkj3VN9rzgUgl20KmBzJBZI+RhKMi9TUJ/wcvxLQHPtGgL2LQcGOl4ETjpwHpYb
         W/L/jYWGOkojpL1Y4mWED37yMIHTOxMX5oL3rU4vB51PqbJWdK+883vfdS+i+t3TLgSG
         +WUpQ9u+2xqZlkiWFkX6aEVdr0iFLsDcvH7V0AYrbloOfYNe6KaDdItficHrQw9GCz2j
         44xFGQEVYX4cNilN9dOo2l495bilc0B1C1OtigcCkqqDtRCprNe3sYziq8xEZwP89ZFv
         65AiYpb6wjphUAszquybXN+tnoBQFEFifwuEfqRmBlyLZMDY6xYEADYA4fDD5KQqeWKO
         WFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700206408; x=1700811208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VX/lRKzVRq1yghMKNb5rPnujs/Enhs7H6aGeq5rBrw=;
        b=YCJ5KJnhMebxzjyXq9MiNrC79IjFTiA0ihF+IaVDN9Rk1g6D6xFYUhDtDS9o2fGuZ1
         ge7yEi48rS1cqe29SSsFtlZf1p3OHa3lOSviA/hCVmk6bH8hUoUxciNduo88nyufEnPy
         Djp5+lvFhSocfQAjRxrNMbPTbwTzOQIXiS4WxqDMrrDAdDzGUYbGZaKcMbLs551z0LKB
         cDjYQHDev6L8DIms5U+jQFN/5f8PC2hyugAs1g5UVe/5QWC7PUNu/J5DQfdNzlPP2VHC
         G7SwrSlbSwrO1L2x47mfpD05B6XS3a7n1oJpnwtbS8pOOZP6e8cgynJ6fFzoguRCxs1c
         ABxQ==
X-Gm-Message-State: AOJu0Yzy37/HApZJOvb3QXuD93ufrTg1XSxYgW0wuE+ThNdTOwJIw165
        UP2RW8Wh1MQhiCrA9Xh4tHN2M4ph+L4HmLFg
X-Google-Smtp-Source: AGHT+IH1d9ttlA9rh/z7aa25q9HmmvjaynwuvE/jeCgFbKyiCAepq5WWLYdeMfQuFC22El1MeOlBdA==
X-Received: by 2002:a05:6808:8c:b0:3b2:f393:dab1 with SMTP id s12-20020a056808008c00b003b2f393dab1mr18439295oic.21.1700206407693;
        Thu, 16 Nov 2023 23:33:27 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id s11-20020a65644b000000b005bcebc93d7asm705106pgv.47.2023.11.16.23.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 23:33:27 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 1/2] dt-bindings: iio: dac: add MCP4821
Date:   Fri, 17 Nov 2023 13:00:37 +0530
Message-ID: <20231117073040.685860-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for MCP48xx series of DACs.

Datasheet:
  [MCP48x1] https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
  [MCP48x2] https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---
 .../bindings/iio/dac/microchip,mcp4821.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
new file mode 100644
index 000000000000..904de15300bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4821.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP4821 and similar DACs
+
+description: |
+  Supports MCP48x1 (single channel) and MCP48x2 (dual channel) series of DACs.
+  Device supports simplex communication over SPI in Mode 0,1 and Mode 1,1.
+
+  +---------+--------------+-------------+
+  | Device  |  Resolution  |   Channels  |
+  |---------|--------------|-------------|
+  | MCP4801 |     8-bit    |      1      |
+  | MCP4811 |    10-bit    |      1      |
+  | MCP4821 |    12-bit    |      1      |
+  | MCP4802 |     8-bit    |      2      |
+  | MCP4812 |    10-bit    |      2      |
+  | MCP4822 |    12-bit    |      2      |
+  +---------+--------------+-------------+
+
+  Datasheet:
+    MCP48x1: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
+    MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4801
+      - microchip,mcp4811
+      - microchip,mcp4821
+      - microchip,mcp4802
+      - microchip,mcp4812
+      - microchip,mcp4822
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "microchip,mcp4821";
+            reg = <0>;
+            vdd-supply = <&vdd_regulator>;
+        };
+    };
-- 
2.42.1

