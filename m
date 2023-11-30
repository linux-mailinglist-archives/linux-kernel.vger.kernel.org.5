Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C737FF88B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346597AbjK3Rks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjK3Rkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:40:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA4197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:40:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97332C433C8;
        Thu, 30 Nov 2023 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701366047;
        bh=jAU9LyE9qOmNmDtbM/yGTVJiYQtX+NmGuCgP5XALJqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M79+WsM/f4FQhLfylak1l6W0dPgKRWNRwwbbt5NHftApztar6J5bPVF5ZWKLwAFGU
         ZL9Wiima4R174zoCDOAk0LKeg4wdwEYujLWPXDC/Zh/83A78h77I506ifKnTsCtOEn
         Z9kOlbG4Gf0FVY1GgagPXk1159xCblpw+rq5WvWlMNqIqnMKpEydNJ1UR1unUSZj4y
         MEw4JPxCcNu8N8EENG4U4Q7oxM/04v/voo7U5VL5lostbX80mG+Oxzfjm8ViPfA6YZ
         MEk+wlxdfXt3fCcKj3wCVC6cxHRgVGeMAXZKetiohMu58cD70WengG15M5FIhj2b8O
         Xe8jhhiuotKxw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8l2P-0003Py-0k;
        Thu, 30 Nov 2023 18:41:21 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] dt-bindings: thermal: qcom-spmi-adc-tm5/hc: clean up examples
Date:   Thu, 30 Nov 2023 18:41:14 +0100
Message-ID: <20231130174114.13122-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130174114.13122-1-johan+linaro@kernel.org>
References: <20231130174114.13122-1-johan+linaro@kernel.org>
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

Clean up the examples by adding newline separators, moving 'reg'
properties after 'compatible' and dropping unused labels.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml          |  5 +++--
 .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml | 10 ++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
index 82f8f25885c0..7541e27704ca 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
@@ -118,9 +118,10 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
+
         pm8998_adc: adc@3100 {
-            reg = <0x3100>;
             compatible = "qcom,spmi-adc-rev2";
+            reg = <0x3100>;
             #address-cells = <1>;
             #size-cells = <0>;
             #io-channel-cells = <1>;
@@ -131,7 +132,7 @@ examples:
             };
         };
 
-        pm8998_adc_tm: adc-tm@3400 {
+        adc-tm@3400 {
             compatible = "qcom,spmi-adc-tm-hc";
             reg = <0x3400>;
             interrupts = <0x2 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 02347cee6c6f..d9d2657287cb 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -171,9 +171,10 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
+
         pm8150b_adc: adc@3100 {
-            reg = <0x3100>;
             compatible = "qcom,spmi-adc5";
+            reg = <0x3100>;
             #address-cells = <1>;
             #size-cells = <0>;
             #io-channel-cells = <1>;
@@ -187,7 +188,7 @@ examples:
             };
         };
 
-        pm8150b_adc_tm: adc-tm@3500 {
+        adc-tm@3500 {
             compatible = "qcom,spmi-adc-tm5";
             reg = <0x3500>;
             interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
@@ -212,9 +213,10 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
+
         pmk8350_vadc: adc@3100 {
-            reg = <0x3100>;
             compatible = "qcom,spmi-adc7";
+            reg = <0x3100>;
             #address-cells = <1>;
             #size-cells = <0>;
             #io-channel-cells = <1>;
@@ -235,7 +237,7 @@ examples:
             };
         };
 
-        pmk8350_adc_tm: adc-tm@3400 {
+        adc-tm@3400 {
             compatible = "qcom,spmi-adc-tm5-gen2";
             reg = <0x3400>;
             interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
-- 
2.41.0

