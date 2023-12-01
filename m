Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894D801160
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378575AbjLAQqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLAQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:46:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632A2F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:46:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C23C433CA;
        Fri,  1 Dec 2023 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701449206;
        bh=T2z/FCGOZTuZvMKsnWedFJwmDPaovLjYsoXHwnzGLm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnnZRrX5/LjFKTZgBsQkxRVjT67NroSOqRvFpXS8Jk3fGMkAexLBFKU9Y4I3kecEA
         0AbISwqHhcmWSJzYz45n0WsjQ08pF/veCJprXUB1n2nL4W2jQXPH2o4qHl5w0iLPs6
         yK8oBvAsrrQ9rbABA8VYip2inF5tIEPFDtC028jntSUvZZNuypeuIwbUqnTIR73+32
         T+4ZkBO+Z+2/wYFRPlGfhWfGykEnC8Cd0XPMzOb9lhLdrgvBF+DbbvAxwC8NanIdtg
         3CwJHo2GZcXySPQIpEgDhS/WUU9m071VOF4fRnItMYXrXW6iHJpRux3Q5BwQG+p6KF
         /ONfHqDVCZf8Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r96fj-0003IW-0a;
        Fri, 01 Dec 2023 17:47:23 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: clean up example
Date:   Fri,  1 Dec 2023 17:45:45 +0100
Message-ID: <20231201164546.12606-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201164546.12606-1-johan+linaro@kernel.org>
References: <20231201164546.12606-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPMI PMIC sits on an SPMI bus which and has two address cells with
no size.

Clean up the example by adding a parent SPMI bus node with proper
'#address-cells' and '#size-cells' properties, using a define for the
second register value, dropping the unnecessary label and increasing the
indentation to four spaces.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 +++++++++---------
 1 file changed, 70 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
index 45cd6a613a91..6a824351834e 100644
--- a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
@@ -59,69 +59,75 @@ additionalProperties: false
 
 examples:
   - |
-
-    pmic: pmic@0 {
-      compatible = "hisilicon,hi6421v600-spmi";
-      reg = <0 0>;
-
-      #interrupt-cells = <2>;
-      interrupt-controller;
-      interrupt-parent = <&gpio28>;
-      interrupts = <0 0>;
-
-      regulators {
-        ldo3: ldo3 {
-          regulator-name = "ldo3";
-          regulator-min-microvolt = <1500000>;
-          regulator-max-microvolt = <2000000>;
-          regulator-boot-on;
-        };
-
-        ldo4: ldo4 {
-          regulator-name = "ldo4";
-          regulator-min-microvolt = <1725000>;
-          regulator-max-microvolt = <1900000>;
-          regulator-boot-on;
-        };
-
-        ldo9: ldo9 {
-          regulator-name = "ldo9";
-          regulator-min-microvolt = <1750000>;
-          regulator-max-microvolt = <3300000>;
-          regulator-boot-on;
-        };
-
-        ldo15: ldo15 {
-          regulator-name = "ldo15";
-          regulator-min-microvolt = <1800000>;
-          regulator-max-microvolt = <3000000>;
-          regulator-always-on;
-        };
-
-        ldo16: ldo16 {
-          regulator-name = "ldo16";
-          regulator-min-microvolt = <1800000>;
-          regulator-max-microvolt = <3000000>;
-          regulator-boot-on;
-        };
-
-        ldo17: ldo17 {
-          regulator-name = "ldo17";
-          regulator-min-microvolt = <2500000>;
-          regulator-max-microvolt = <3300000>;
-        };
-
-        ldo33: ldo33 {
-          regulator-name = "ldo33";
-          regulator-min-microvolt = <2500000>;
-          regulator-max-microvolt = <3300000>;
-          regulator-boot-on;
-        };
-
-        ldo34: ldo34 {
-          regulator-name = "ldo34";
-          regulator-min-microvolt = <2600000>;
-          regulator-max-microvolt = <3300000>;
+    #include <dt-bindings/spmi/spmi.h>
+
+    spmi {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        pmic@0 {
+            compatible = "hisilicon,hi6421v600-spmi";
+            reg = <0 SPMI_USID>;
+
+            #interrupt-cells = <2>;
+            interrupt-controller;
+            interrupt-parent = <&gpio28>;
+            interrupts = <0 0>;
+
+            regulators {
+                ldo3 {
+                    regulator-name = "ldo3";
+                    regulator-min-microvolt = <1500000>;
+                    regulator-max-microvolt = <2000000>;
+                    regulator-boot-on;
+                };
+
+                ldo4 {
+                    regulator-name = "ldo4";
+                    regulator-min-microvolt = <1725000>;
+                    regulator-max-microvolt = <1900000>;
+                    regulator-boot-on;
+                };
+
+                ldo9 {
+                    regulator-name = "ldo9";
+                    regulator-min-microvolt = <1750000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                };
+
+                ldo15 {
+                    regulator-name = "ldo15";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-always-on;
+                };
+
+                ldo16 {
+                    regulator-name = "ldo16";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-boot-on;
+                };
+
+                ldo17 {
+                    regulator-name = "ldo17";
+                    regulator-min-microvolt = <2500000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                ldo33 {
+                    regulator-name = "ldo33";
+                    regulator-min-microvolt = <2500000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                };
+
+                ldo34 {
+                    regulator-name = "ldo34";
+                    regulator-min-microvolt = <2600000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+            };
         };
-      };
     };
-- 
2.41.0

