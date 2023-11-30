Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF437FF88D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbjK3Rku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjK3Rkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:40:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590F10D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:40:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD9AC433CB;
        Thu, 30 Nov 2023 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701366047;
        bh=aiwDU/GO9SPonpL1asp0uLBSgBwdDtrE9e2UpRiImAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvBHxVbD6Dce6k2qA75F5gI2inzEChlJVddBeMp+jO1UBEwEWhLuPxK+rb+PbaKaA
         XzWGJw9tgtG4GiRFEJj8y5fiTZVHrLTnNrdP5MhfHZzx81yuePdnbWeF/QYOWlVdGC
         Fcqcq4uVq1Tz5OPGxlA/Pm1HdJ0d6GhYLCxclYFQFmwuYzoeWnncDKHPfKCH+QC8RM
         1tp2w95NHodHjBMl0WUpob9hAFfWvOYVH0TKlNg+8K/myQSuHQHD9wk9s+IktrXyhq
         KTraiJBRboYhUuqWpD5aJqKTuWjj/Tdt+POF8aI8jJ/Lpn5QcD265cih7WjJIzX0+Y
         yz495e5IPUSDA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8l2P-0003Pw-0Q;
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
Subject: [PATCH 1/2] dt-bindings: thermal: qcom-spmi-adc-tm5/hc: fix example node names
Date:   Thu, 30 Nov 2023 18:41:13 +0100
Message-ID: <20231130174114.13122-2-johan+linaro@kernel.org>
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

The ADC Thermal Monitor is part of an SPMI PMIC, which in turn sits on
an SPMI bus.

Fixes: db03874b8543 ("dt-bindings: thermal: qcom: add HC variant of adc-thermal monitor bindings")
Fixes: e8ffd6c0756b ("dt-bindings: thermal: qcom: add adc-thermal monitor bindings")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml    | 3 ++-
 .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml      | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
index 01253d58bf9f..82f8f25885c0 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
@@ -114,7 +114,8 @@ examples:
   - |
     #include <dt-bindings/iio/qcom,spmi-vadc.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spmi_bus {
+
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         pm8998_adc: adc@3100 {
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 3c81def03c84..02347cee6c6f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -167,7 +167,8 @@ examples:
   - |
     #include <dt-bindings/iio/qcom,spmi-vadc.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spmi_bus {
+
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         pm8150b_adc: adc@3100 {
@@ -207,7 +208,8 @@ examples:
     #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
     #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spmi_bus {
+
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         pmk8350_vadc: adc@3100 {
-- 
2.41.0

