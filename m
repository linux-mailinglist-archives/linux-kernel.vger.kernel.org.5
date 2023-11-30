Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DA07FF853
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbjK3Rb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbjK3Rbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:31:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF83FE0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:31:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B982C433C8;
        Thu, 30 Nov 2023 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365519;
        bh=wxg56W6HTHMTFYDW4lY4u8CY4BkNOVOP9bjh79kHVmE=;
        h=From:To:Cc:Subject:Date:From;
        b=u3qz1RuObFfuunerRon1cBHkIkU7XP6vXJNp5DiAMMPQkvPEoWkUOPZVq+ytWyqs8
         rh7hJHBIhJl33qrkpiM0Q7WWcXqao7Ry4bCOlPzT6CkSsubV+dC1TsLJfq8vjG/M6G
         1lPmceDj3EQS4HbiaHHU//CySGBJzKKF5qyYfQhZuEuIh8Ud59jTYgzKSELFJs147a
         26poZRPxdioOB5zkDpNDbkMay5YADZg7dhw89vYDNDT84MCO9f/ixv7XkCl24c9A5R
         6z5wPJ8p7zc/fYtt+eesdYQGHBEUagEoqH0nb141XlkzdUJShW5Rk9IWHNxUoGj+l0
         cucAy8DQJB6Hg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kts-0003KX-1h;
        Thu, 30 Nov 2023 18:32:32 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: rtc: qcom-pm8xxx: fix inconsistent example
Date:   Thu, 30 Nov 2023 18:32:23 +0100
Message-ID: <20231130173223.12794-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
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

The PM8921 is an SSBI PMIC but in the binding example it is described
as being part of an SPMI PMIC while using an SSBI address.

Make the example consistent by using the sibling PM8941 SPMI PMIC
instead.

Fixes: 8138c5f0318c ("dt-bindings: rtc: qcom-pm8xxx-rtc: Add qcom pm8xxx rtc bindings")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/rtc/qcom-pm8xxx-rtc.yaml         | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
index 774c34c3f8f6..cdc56dfbfac3 100644
--- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
@@ -67,27 +67,27 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/spmi/spmi.h>
-    spmi_bus: spmi@c440000 {
-      reg = <0x0c440000 0x1100>;
-      #address-cells = <2>;
-      #size-cells = <0>;
-      pmicintc: pmic@0 {
-        reg = <0x0 SPMI_USID>;
-        compatible = "qcom,pm8921";
-        interrupts = <104 8>;
-        #interrupt-cells = <2>;
-        interrupt-controller;
-        #address-cells = <1>;
+
+    spmi {
+        #address-cells = <2>;
         #size-cells = <0>;
 
-        pm8921_rtc: rtc@11d {
-          compatible = "qcom,pm8921-rtc";
-          reg = <0x11d>;
-          interrupts = <0x27 0>;
-          nvmem-cells = <&rtc_offset>;
-          nvmem-cell-names = "offset";
+        pmic@0 {
+            compatible = "qcom,pm8941", "qcom,spmi-pmic";
+            reg = <0x0 SPMI_USID>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            rtc@6000 {
+                compatible = "qcom,pm8941-rtc";
+                reg = <0x6000>, <0x6100>;
+                reg-names = "rtc", "alarm";
+                interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+                nvmem-cells = <&rtc_offset>;
+                nvmem-cell-names = "offset";
+            };
         };
-      };
     };
 ...
-- 
2.41.0

