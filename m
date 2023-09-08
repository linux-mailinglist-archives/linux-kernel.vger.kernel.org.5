Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3A798FB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbjIHTeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbjIHTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:34:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E55269A;
        Fri,  8 Sep 2023 12:33:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6641BC4163D;
        Fri,  8 Sep 2023 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201623;
        bh=pCAWUMxAeQMhlxOAfYYGNQCU+BovgMqJp27SdzpfWZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfTcoE7c8NqJk51Ri/hdVNN2e/2Ndk/pZGZdTy2m611Ufx9N/taSnPdl1GQXLj9sK
         1wMfO51+0SaVRAdRymC4QXcWu4JPucgpH2bI/pqgbeSc7O2lwsnd/sujXSr2UvWwkR
         pHQMhDU+YCFsNzakwinQPzKTCjHCoFqJdJk3AId99jM7ZRpNFEggGgNMMGMLS3KHH4
         g1MbamsxVNLWzzvaGGZ61tB6dLZdJGG0H0PNCg/VZ+eN1gYX5ob+wMUALHlAbBvcl8
         XDmWa+F53sBqMGf0KiSuiQuwE6jOhyHkDyT74ipJ+ZevBOH7m1NEglcZEZnlqYT+wa
         YWy9D2ACHEoQA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 25/31] arm64: dts: qcom: sc8280xp-x13s: Add camera activity LED
Date:   Fri,  8 Sep 2023 15:31:54 -0400
Message-Id: <20230908193201.3462957-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 1c63dd1c5fdafa8854526d7d60d2b741c813678d ]

Disappointigly, the camera activity LED is implemented in software.
Hook it up as a gpio-led and (until we have camera *and* a "camera on"
LED trigger) configure it as a panic indicator.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index bdcba719fc385..90a21ab5c54fc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
@@ -78,6 +79,21 @@ switch-lid {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-camera-indicator {
+			label = "white:camera-indicator";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&tlmm 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			/* Reuse as a panic indicator until we get a "camera on" trigger */
+			panic-indicator;
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
 
-- 
2.40.1

