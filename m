Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648CE7FF831
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjK3RZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjK3RZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:25:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C6B10F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:25:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBA3C433CB;
        Thu, 30 Nov 2023 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365125;
        bh=eXZVsFTRtF1cEp4KE4ZARne3vtKXRQE84t2o88qivCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMUGskGILIEcFKpnujuqZLn5Je1ChO5CiWMII5CkUTw/K1j4P3qrfCaQrxWMxm4lO
         YhDox+X5fggdQcLqi/UO+Yy3B5OFwI1XAqDgZbF4RcswidKFgesX41aI/BneiCwRP6
         no5SF+qdslN0yKV744ap9kblpydIElDro4rsV624sZ5XTcoklyzFJwUxDtOb/I0hVa
         3tm2ZAdEne9gSZ9BXuJSVqFIkBI53FE8aP+oZ0Pd0vUi2D/qQJu3RA3qCqLs4hy1t0
         sMTKSctEWPU6gtlDeLoBiYwB3MJsie8UXjhh61avG4YAwGeicXRR4q8G9QIgwUVsnE
         uRXjN5oCLB82w==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8knX-0003Gz-1S;
        Thu, 30 Nov 2023 18:25:59 +0100
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
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: clean up example
Date:   Thu, 30 Nov 2023 18:25:46 +0100
Message-ID: <20231130172547.12555-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130172547.12555-1-johan+linaro@kernel.org>
References: <20231130172547.12555-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 +++++++++---------
 1 file changed, 70 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
index 60d5e6b3de33..560ec3367045 100644
--- a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
@@ -66,69 +66,75 @@ additionalProperties: false
 
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

