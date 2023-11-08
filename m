Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE727E5039
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjKHGF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKHGFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:05:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B51AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:05:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFA9EC433C7;
        Wed,  8 Nov 2023 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699423519;
        bh=jPf+EyCFsnTuZYFqVKcAr8GvhtDbrpKc2fnaZTnUvME=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=dsUdkLgXcLrmh02Wvi3sYoRj3QXSGKjbTy5O9sfKJu915lnSE64zSOMamWChmkJsJ
         V1M9C7f3DZCtiVDCGzlIkVoMEEViIrrN/tTHMwgbKSZhayjjHpaqXqk6wCbdTb9F/L
         PtrWFJwUHTkVhqT5AZVaj7AiORHK5AGQmOoqXg2LtaPL0op+KgmHEGi2wtOhvLJEZL
         kEv1fHnZhSqJAHuuVpep8R+UnMVkLMePZ+zflqLkwAqVUCl7ZnOt3aFxIDzesjHYXJ
         f5Yf80lJGO0dN8EdCTycDzo3OAMrIZ4QfaOq6fDqOX9WMJ1ZzFnV4abvo6YvmcGh6V
         1y2RTtSCtX1qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 96238C4332F;
        Wed,  8 Nov 2023 06:05:19 +0000 (UTC)
From:   Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date:   Wed, 08 Nov 2023 14:05:12 +0800
Subject: [PATCH] ARM: dts: qcom: Add LPG LED device description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABklS2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwML3cLk/Nz4nNSUYt1k4ySDJHMDI0sDAwsloPqCotS0zAqwWdGxtbU
 AJTBULVsAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        quic_uchheda@quicinc.com, kamalw@qti.qualcomm.com,
        Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699423518; l=1242;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=NDo+ug2xivotbN/xsmZgwuX6Kewv3ppT7LsFeWs76Jw=;
 b=RljxyHRNT45DJuHIAuZuGUdPAx1iNvdE50l+UdUDEOalLsuw49dIGrF8fUhBac0Cgpic77vmG
 QPJ6QM17/SDC1A5fMZ8TeAn2e9q1TxYc5bOQbl0TZutUnDGAKgrX2Hw
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received: by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Liu <quic_huliu@quicinc.com>

Add LPG LED device description.

Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/pm8350c.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
index f28e71487d5c..11b9f384d99c 100644
--- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/spmi/spmi.h>
 
 &spmi_bus {
@@ -34,6 +35,27 @@ pm8350c_pwm: pwm {
 			compatible = "qcom,pm8350c-pwm";
 			#pwm-cells = <2>;
 			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_RED>;
+				label = "red";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+				label = "green";
+			};
+
+			led@3 {
+				reg = <3>;
+				color = <LED_COLOR_ID_BLUE>;
+				label = "blue";
+			};
 		};
 	};
 };

---
base-commit: b9604be241587fb29c0f40450e53d0a37dc611b5
change-id: 20231108-qcom_leds-c3b0b7029008

Best regards,
-- 
Hui Liu <quic_huliu@quicinc.com>

