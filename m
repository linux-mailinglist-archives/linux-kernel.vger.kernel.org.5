Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D2808696
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379036AbjLGLVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378977AbjLGLVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:21:39 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C11D5B;
        Thu,  7 Dec 2023 03:21:45 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6280942BF9;
        Thu,  7 Dec 2023 16:21:32 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1701948093; bh=DBs7WSTRsWsDILHndJynPWxZbqbs68OouyDKWJNsV3g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Hoa7p5Rd2KrsNDYToioeGzMosAXV7/09a6h/s8R4LlgeC3Y30rZrpurXBXl9x3KwV
         QXrAjwrbRMVpz1CBZ/eJZDRLADrNSlokhxEdlt/4ENQco2tgHQtRfMI++11UmOGXSm
         cTbPqGDpd5LGzP4nJRGlAtMcBlvXvvI9U9AaQ19NI8aIEE5qqckgajA+3ggKCt8Of9
         TlIl8FrHoCOpyuBcORakF4ikUA/AQEfGHXH7VHzq0YSQwI9NiEm4T+31L8wXYi1IFQ
         KSFTyj9Nx88WD9AasjsYff4mWxfe5j9uk+Njcye1+YrOW0q3Zaj4VbgPkr7hfVSx3m
         vgurVni9tPpdg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Thu, 07 Dec 2023 16:20:16 +0500
Subject: [PATCH 3/3] arm64: dts: qcom: acer-aspire1: Add embedded
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-aspire1-ec-v1-3-ba9e1c227007@trvn.ru>
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
In-Reply-To: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=DBs7WSTRsWsDILHndJynPWxZbqbs68OouyDKWJNsV3g=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlcaq5lixDHcI7sL22tX5Fb/fuC6XCZ7nHDrS2U
 q1H48A8gwCJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZXGquQAKCRBDHOzuKBm/
 dTr0EACcFglXesnZoTHlKdBZhPYb1BP5An7F1fTIw0shv46k1t6TRjQgdj8a5A0iID3DaHg5ORL
 XCjyi+YNFNCj63sD/l2mWi+NV054o3NtfcPJB5hgxgHoenY62tSEVhnV0CeFLnoFUl6Hr64h1Gj
 GYWhtSL0/bqan02l5uYiRD8sK1nIplY5dYSgaqJSrhWe3xYYZWkmwTOr/TUMoeRSk5djCi1WPi+
 6brOb+p1MPxJJvKtDKOhk93MBj39KF2WHiYPGOUsuqkcAtyd6QzQfWETYA0nfIAiR9F3rxIvvx3
 nqcCTuU6YMpFf/FVHvKY+ugVuyvPVZ8HMXLQHswQTVbfs6Wvicb8Lvt4deDLHOrY7d9qgE3OTEe
 tm66QoI/jakdaTEfVB98k1s2D07vWIfIdciRQRtQSJG1XkCGRuBDqp+JBY8bv6Bhbsqie5q8G/O
 hLDz0xZIn8uOQr4v+0B4lxnN6y58lCBXpVqIT8Jl3AFjl6DpGtkkgre7n9OZ3ue1AIiuSacdznO
 GZOiP0Ad5yanbWgGlYGpmfs9I9RPJY06+DIl0gf6TLOMW5wOXd9tAvB36YYMMvud1GdrCfG/Jal
 XZPVmczk5jI2LVAuRVeCdGYNgf7KZK2yxigaQk97Ki9GmIyhkjIuRDEm6VQvTVnQTVHUd+urjQp
 Nq+AOrD8VoWggyA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The laptop contains an embedded controller that provides a set of
features:

- Battery and charger monitoring
- USB Type-C DP alt mode HPD monitoring
- Lid status detection
- Small amount of keyboard configuration*

[*] The keyboard is handled by the same EC but it has a dedicated i2c
bus and is already enabled. This port only provides fn key behavior
configuration.

Add the EC to the device tree and describe the relationship between the
EC-managed type-c port and the SoC DisplayPort.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 40 +++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index dbb48934d499..a29f542fa612 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -147,7 +147,25 @@ &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	/* embedded-controller@76 */
+	embedded-controller@76 {
+		compatible = "acer,aspire1-ec";
+		reg = <0x76>;
+
+		interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ec_int_default>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+
+			port {
+				ec_dp_in: endpoint {
+					remote-endpoint = <&mdss_dp_out>;
+				};
+			};
+		};
+	};
 };
 
 &i2c4 {
@@ -298,6 +316,19 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	data-lanes = <0 1>;
+
+	vdda-1p2-supply = <&vreg_l3c_1p2>;
+	vdda-0p9-supply = <&vreg_l4a_0p8>;
+
+	status = "okay";
+};
+
+&mdss_dp_out {
+	remote-endpoint = <&ec_dp_in>;
+};
+
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l3c_1p2>;
 	status = "okay";
@@ -687,6 +718,13 @@ codec_irq_default: codec-irq-deault-state {
 		bias-disable;
 	};
 
+	ec_int_default: ec-int-default-state {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	edp_bridge_irq_default: edp-bridge-irq-default-state {
 		pins = "gpio11";
 		function = "gpio";

-- 
2.43.0

