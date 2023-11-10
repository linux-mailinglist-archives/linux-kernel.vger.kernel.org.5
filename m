Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4107E7706
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbjKJCHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKJCHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:07:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472F1BF1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:07:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5C2EC433C7;
        Fri, 10 Nov 2023 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699582035;
        bh=Pccpw3hZbx3hewMKfWvzkDRk5w6Jowa7nLTkFx+zYL0=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=G0U6r8+/Il8hMOoz3RFX9nCE1xbvjT3C8jHXr1U1BOIbOaPZupvgdwqNVMOpZbbhD
         FygscEkos4Ve3D6RQL/Ps903E91xwj1dybEuTPk/rwjprgbP30cQkcwy7ZoIz/WU5E
         /LNiatywMuktgf7r4dXHTocivyRocjcPIqlX1jyDKKNyxQvp3kui5yfCpdqYlzoXrD
         hC+jAry7c/OCQtKM4iFGmBv0JNys0IdO3o0FELCA6A3M8DlqQdxwWtbDaweYRDePev
         3C/t4rCkKD8GoUqvdZRXrBZVhSgcQXZaUzkTR+wr8aT162LTG0ZEAp6nfJ8d7xzEGn
         3JGixA55L6YOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 8C636C4332F;
        Fri, 10 Nov 2023 02:07:15 +0000 (UTC)
From:   Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date:   Fri, 10 Nov 2023 10:06:03 +0800
Subject: [PATCH v2] arm64: dts: qcom: Add definition for three LEDs.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAuQTWUC/23MQQrCMBCF4auUWRuZpEijK+8hRcx0tAOatIkGp
 eTuxq5d/o/Ht0DiKJzg0CwQOUuS4GuYTQM0XvyNlQy1waBptUarZgqP852HpKh16Do0e0QL9T9
 Fvsp7tU597VHSM8TPSmf9W/8pWStdKdZkd50hh8f5JSSetvUCfSnlC6NJdVekAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699582034; l=1518;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=+byzyNon88kZIXy3k8pUtWoNy6CulqY/Nh3zLuQhX1k=;
 b=Mj6pihkt2mJr539ga3W5cLKcpidoCLrTg07uAJnwp4wEuAxrqKT1hjQX8jTqCq1GDwhCengtq
 UNwsI/tmI8pB8353ceQcrLBz5VKU2vav6g7rP2cwKBqk/tnNy00/SyQ
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received: by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Liu <quic_huliu@quicinc.com>

Add definition for three LEDs to make sure they can
be enabled base on QCOM LPG LED driver.

Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
---
Changes in v2:
- Rephrased commit text and updated the nodes to board file.
- Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 2ff549f4dc7a..228e2aaeb861 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/leds/common.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi"
@@ -365,6 +366,30 @@ vreg_bob: bob {
 	};
 };
 
+&pm8350c_pwm {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	led@1 {
+		reg = <1>;
+		color = <LED_COLOR_ID_RED>;
+		label = "red";
+	};
+
+	led@2 {
+		reg = <2>;
+		color = <LED_COLOR_ID_GREEN>;
+		label = "green";
+	};
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_BLUE>;
+		label = "blue";
+	};
+};
+
 &gpi_dma0 {
 	status = "okay";
 };

---
base-commit: b9604be241587fb29c0f40450e53d0a37dc611b5
change-id: 20231108-qcom_leds-c3b0b7029008

Best regards,
-- 
Hui Liu <quic_huliu@quicinc.com>

