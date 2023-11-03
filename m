Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39B17E034F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376857AbjKCNCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376604AbjKCNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:02:36 -0400
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C778C134;
        Fri,  3 Nov 2023 06:02:26 -0700 (PDT)
Received: from MTA-12-4.privateemail.com (mta-12-1.privateemail.com [198.54.122.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4E28860136;
        Fri,  3 Nov 2023 12:52:49 +0000 (UTC)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 4F89418000A2;
        Fri,  3 Nov 2023 08:52:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=carlosaurelio.net;
        s=default; t=1699015967;
        bh=7x6abVPdbko5LarCk/0BZn1SkuXjeT6liiRK10w8DLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1bqnMWBVt8/q7tRhYhjuT27rxqblzI1eR/EgXyN5SZiCLMKLC2bFJtAwN8wVNp26
         ZH31E2cz4DNKSKYJ0OJ/qARjq8moF6jPJYXlgAdKYbYBEZfddo4DSkdRqJJrbcKxOE
         uBqa8CBRFM+fJWdsYFrFTgo8nEt4m3Umukp85uv9wHSA8kY5+lN5NZ7VvhQs6UyrIA
         h0m7SRD4FvVi/648FHhDpRF6rZWaqHNUkNJ/Za365ZYFVXyf7GMpbMWfTMO0BjPjEq
         ohh7E6B8wBVHbRDpnKMYnFHEY+aK48KrjzyVAv8vkU6crXXRxdOnQNH2tAD9JbDFTa
         hcZDq7Sw8zmbA==
Received: from GB2-C0476.gertec.local (unknown [187.11.35.108])
        by mta-12.privateemail.com (Postfix) with ESMTPA;
        Fri,  3 Nov 2023 08:52:30 -0400 (EDT)
From:   Carlos Menin <menin@carlosaurelio.net>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Carlos Menin <menin@carlosaurelio.net>,
        Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v2 2/2] dt-bindings: rtc: add pcf85053a
Date:   Fri,  3 Nov 2023 09:51:06 -0300
Message-Id: <20231103125106.78220-2-menin@carlosaurelio.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103125106.78220-1-menin@carlosaurelio.net>
References: <20231103125106.78220-1-menin@carlosaurelio.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings for NXP's PCF85053A RTC chip.

Signed-off-by: Carlos Menin <menin@carlosaurelio.net>
Reviewed-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 .../bindings/rtc/nxp,pcf85053a.yaml           | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85053a.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85053a.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85053a.yaml
new file mode 100644
index 000000000000..a1fc29dd30f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85053a.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf85053a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCF85053A Real Time Clock
+
+maintainers:
+  - Carlos Menin <menin@carlosaurelio.net>
+
+properties:
+  compatible:
+    enum:
+      - nxp,pcf85053a
+
+  reg:
+    maxItems: 1
+
+  quartz-load-femtofarads:
+    description:
+      The capacitive load of the crystal, expressed in femto Farad (fF).
+    enum: [6000, 7000, 12500]
+    default: 12500
+
+  nxp,quartz-drive-control:
+    description:
+      The oscillator is designed to be used with quartz with a series resistance
+      up to 100 kOhms. This covers the typical range of 32.768 kHz quartz
+      crystals. A low drive mode is available for low series resistance quartz
+      (up to 60 kOhms). This reduces the current consumption. For very high
+      series resistance quartz (up to 500 kOhms), there is a high drive mode.
+      Current consumption increases substantially in this mode.
+    enum: [low, normal, high]
+    default: normal
+
+  nxp,low-jitter-mode:
+    description:
+      If set to true, will decrease the CLK output jitter, at the cost of
+      increasing the current consumption.
+    type: boolean
+    default: false
+
+  nxp,clk-inverted:
+    description:
+      Invert clock output. Normally, the low jitter mode reduces jitter on the
+      rising edge of the output clock. If this property is set to true, then the
+      low jitter mode will affect the falling edge of the output clock.
+    type: boolean
+    default: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: rtc.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@6f {
+            compatible = "nxp,pcf85053a";
+            reg = <0x6f>;
+        };
+    };
-- 
2.34.1

