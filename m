Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1717FF83E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbjK3R3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3R3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:29:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298D9E0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:29:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0780C433C7;
        Thu, 30 Nov 2023 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365394;
        bh=CGVx+2n0YKD8TyrFO2KT/eMDvxvOB0hmUQofIVVG7Ws=;
        h=From:To:Cc:Subject:Date:From;
        b=Rx7NvTbK1mO8HwfIB1WJ7b93AOTeGFBOCM4I4tnu5zwYEdxILp+hJn2hBtbamMJ7C
         i254P+xp9ooGvS/cG/8UA7HRgMqBxuWCaT59vwHwe+jbInaaXQTW7xdyoc9dLwszZO
         5NaFW+gKn3Of96r2LDkMabQSPHk0v6fBfpFg2SV34ERiJej6dI/4YollrSrUySvEkb
         C2ipD1kTjxbxCS+KdZ7ogNV9ESemFwEdrnMxVaPLtcpPHQQH9O+30BJ68y2jr1IxK5
         UtjbH5uGT5mSPUCy3c81DgxUiEgzgcJU35pmfl3wcxxEmY8Jf7Z5ESAJGjT1fkZ8OT
         kid9zSpQd8L8w==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8krs-0003JO-0X;
        Thu, 30 Nov 2023 18:30:28 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: power: reset: qcom-pon: fix inconsistent example
Date:   Thu, 30 Nov 2023 18:30:17 +0100
Message-ID: <20231130173017.12723-1-johan+linaro@kernel.org>
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

The current PON example is a bit of a mess after converting the binding
document to yaml and in the process updating parts of the example to
match the pmk8350 binding while leaving parts from the older pm8998
example in place.

Clean up the example and make it consistent by adding some newline
separators; dropping labels; removing stray spaces; fixing the PON node
name; and fixing the unit address so that it matches the interrupt
specifiers (which re-encodes the PON base address, 0x800 => 0x8).

Fixes: 76ba1900cb67 ("dt-bindings: power: reset: qcom-pon: Convert qcom PON binding to yaml")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/power/reset/qcom,pon.yaml   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 5e460128b0d1..fc8105a7b9b2 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -111,21 +111,24 @@ examples:
    #include <dt-bindings/interrupt-controller/irq.h>
    #include <dt-bindings/input/linux-event-codes.h>
    #include <dt-bindings/spmi/spmi.h>
-   spmi_bus: spmi@c440000 {
+
+   spmi@c440000 {
      reg = <0x0c440000 0x1100>;
      #address-cells = <2>;
      #size-cells = <0>;
-     pmk8350: pmic@0 {
+
+     pmic@0 {
        reg = <0x0 SPMI_USID>;
        #address-cells = <1>;
        #size-cells = <0>;
-       pmk8350_pon: pon_hlos@1300 {
-         reg = <0x1300>;
+
+       pon@800 {
          compatible = "qcom,pm8998-pon";
+         reg = <0x800>;
 
          pwrkey {
             compatible = "qcom,pm8941-pwrkey";
-            interrupts = < 0x0 0x8 0 IRQ_TYPE_EDGE_BOTH >;
+            interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
             debounce = <15625>;
             bias-pull-up;
             linux,code = <KEY_POWER>;
-- 
2.41.0

