Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF187FF80A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345855AbjK3RTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjK3RTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:19:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5280990;
        Thu, 30 Nov 2023 09:19:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E203FC433C8;
        Thu, 30 Nov 2023 17:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364752;
        bh=PvCAxPOZ0lYTZaufhXNc1kd1nvehZHcqsT5UF6Hm2Uc=;
        h=From:To:Cc:Subject:Date:From;
        b=teH1WywkGfVlqYJZW1HF2OeJV/+7czbISREfpUEa0JFpjPG8dxsU+693qOiTVdrCj
         g4Ziymp3ou5G7v4cMX+lOsvI5Z6ead/MV+pueHv+UFoHTxypfY+o1jzuhmEhoMVb5Q
         yNoAW8i8W6vBcAc4tXmaBJ/dyX9Dh4tCzGrtoo9ETH9XobbXtAVP+VFJKUNPREDHJ0
         LMQm8gf+907AJBlCqfs68VKGtcsCiE8Y9+i7sRl6rpZU73d/zGie7B5CJFZSgAttOH
         aR/HDVTtkrHqXU1etkS7lorho5dwJXlSqmrUR5qChV2RfyzD+uYIHJzvcHBnGylcfD
         OETHBYCGATGfA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8khU-0003E6-2a;
        Thu, 30 Nov 2023 18:19:44 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        inux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: leds: qcom,spmi-flash-led: fix example node name
Date:   Thu, 30 Nov 2023 18:19:40 +0100
Message-ID: <20231130171940.12391-1-johan+linaro@kernel.org>
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

The led controller is a child of an SPMI PMIC, which in turn sits on an
SPMI bus.

While at it, add some newline separators to improve readability.

Fixes: 1aeff6216891 ("dt-bindings: leds: Add QCOM flash LED controller")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/leds/qcom,spmi-flash-led.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
index a8736fd5a539..1ba607685f5f 100644
--- a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
+++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
@@ -89,9 +89,11 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/leds/common.h>
-    spmi {
+
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
+
         led-controller@ee00 {
             compatible = "qcom,pm8350c-flash-led", "qcom,spmi-flash-led";
             reg = <0xee00>;
-- 
2.41.0

