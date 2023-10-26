Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CFB7D7C94
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjJZFyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjJZFyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:54:12 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A808184;
        Wed, 25 Oct 2023 22:54:10 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 32A5943024;
        Thu, 26 Oct 2023 10:54:06 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698299646; bh=m2R8nwNx74fi7ZyA9GViMO/2RFQPpiuD8601klTAY8Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uA1oWc/i6nHNB1eoaqz/5EtSoqhREpX4vYPINveJWPSxDrgsKvPtfWXb28ZDAYUCY
         jKrX+s0JK2wF8xrnxGs3p5KfKbVmMxkKFdYuox+6rgSjE25tKuJ8GOJf3Ft1O2IBmm
         oPTB3jKPRKgPG9WLI9AYmNobwTjVPfYL7yHzOxEF4cBKR+My1ZtmHw0RCZ1cePPeaf
         82SKsG7wTimH6yY1IEkyVDC4VVxG7S0wq94QutIRPJM14Ee/NGUU3cHrJKMKDLLrpj
         7DtMldlY+TXZyZMGzs1AT52vPHZOgBuz9sYGcuCH5rhtNuKGZTCnX5ETp7YOclNL2J
         8Fa1Q/MkSa8JQ==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Thu, 26 Oct 2023 10:53:45 +0500
Subject: [PATCH v3 2/2] arm64: dts: qcom: msm8916-longcheer-l8150: Add
 battery and charger
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-pm8916-dtsi-bms-lbc-v3-2-fad1ff22306e@trvn.ru>
References: <20231026-pm8916-dtsi-bms-lbc-v3-0-fad1ff22306e@trvn.ru>
In-Reply-To: <20231026-pm8916-dtsi-bms-lbc-v3-0-fad1ff22306e@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2477; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=m2R8nwNx74fi7ZyA9GViMO/2RFQPpiuD8601klTAY8Y=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlOf78t9B+W4YKSvV7oqzbkAguV9xEVdI3quokP
 D9+7iU1IMaJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZTn+/AAKCRBDHOzuKBm/
 dYJqD/9Ch+W0ZvItovOMaQrb2cwtSEVbcTdGK789rKwTb1y/Zsa1mr9o7b4U9JvS5mWJMrovhHd
 R6w8RtZm2lcVbVfhg0LAPjZXmwXz1RnuM5QI0wfvbKAvuLRqNZ+kZYXzJXXBK7JoEES08bN/8oO
 dHTEff4cK+dTW1rJ4c9d0h/43jLBNW0Zun/gzGARzpTnPLMbFaj8Ml8hIFbf0DO3PCXgD87COD8
 9fDz2p4/qu98Ez2cKKIPmhTOtVC7brLPEmNpPMAZw1AsdrqGy5HI5uZVlSLX7gZshDy79dSXBJa
 EcUXd8d/8bMLpIgBooRwS6eDHesKkJxSF5HnHAOM5T8ikUMB2tXOPAxZwpYcAwdQn7mrGTEL/nz
 Lem83BVLSknGbOhd9ZyiiFh84hhaRfvmA/1Ijj21xEHZe3ilCsJWwhJpcnT5ZXAOocxjQ07+TD3
 jIRQ3e9lr8jy6k9oh/Dtet7/0l0VIwkhPQ0eyCimQ2o6rrMSrC6IGgfvhW9czjRwj0wNfDSmZ2r
 pWwWZ0ymK9KywbXP/hTMCANpDK2K4AIlcgWbasQYQVFZ4569t//Mz8bDvEdiHcWCJgr3erKdNUE
 WBiEnDQu4gYckusPB7+/R/A/kVYG+uI/Mb/s/3TT6htrwr+/VmpJDzwq20jI/Kwhgmpo5LIFygD
 JbfGh4D7qDdtkVw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Longcheer L8150 doesn't have any dedicated fuel-gauge or charger,
instead making use of the pmic hardware blocks for those purposes.

Add pm8916 bms and charger, as well as the battery cell description
that those blocks rely on.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 43 +++++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 37fa55166918..8e4c77003109 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -49,6 +49,25 @@ mpss_mem: mpss@8e800000 {
 		};
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4350000>;
+		energy-full-design-microwatt-hours = <9500000>;
+		charge-full-design-microamp-hours = <2500000>;
+
+		ocv-capacity-celsius = <25>;
+		ocv-capacity-table-0 = <4330000 100>, <4265000 95>,
+			<4208000 90>, <4153000 85>, <4100000 80>, <4049000 75>,
+			<4001000 70>, <3962000 65>, <3919000 60>, <3872000 55>,
+			<3839000 50>, <3817000 45>, <3798000 40>, <3783000 35>,
+			<3767000 30>, <3747000 25>, <3729000 20>, <3709000 16>,
+			<3688000 13>, <3681000 11>, <3680000 10>, <3679000 9>,
+			<3677000 8>, <3674000 7>, <3666000 6>, <3641000 5>,
+			<3597000 4>, <3537000 3>, <3457000 2>, <3336000 1>,
+			<3000000 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -236,6 +255,22 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&pm8916_bms {
+	status = "okay";
+
+	monitored-battery = <&battery>;
+	power-supplies = <&pm8916_charger>;
+};
+
+&pm8916_charger {
+	status = "okay";
+
+	monitored-battery = <&battery>;
+
+	qcom,fast-charge-safe-current = <900000>;
+	qcom,fast-charge-safe-voltage = <4300000>;
+};
+
 &pm8916_codec {
 	qcom,micbias-lvl = <2800>;
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
@@ -255,10 +290,6 @@ pm8916_l17: l17 {
 	};
 };
 
-&pm8916_usbin {
-	status = "okay";
-};
-
 &pm8916_vib {
 	status = "okay";
 };
@@ -282,11 +313,11 @@ &sound {
 &usb {
 	status = "okay";
 	dr_mode = "peripheral";
-	extcon = <&pm8916_usbin>;
+	extcon = <&pm8916_charger>;
 };
 
 &usb_hs_phy {
-	extcon = <&pm8916_usbin>;
+	extcon = <&pm8916_charger>;
 };
 
 &venus {

-- 
2.41.0

