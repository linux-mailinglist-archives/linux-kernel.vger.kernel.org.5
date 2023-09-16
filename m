Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44D57A30C5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbjIPN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbjIPN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 09:57:41 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C8CEA;
        Sat, 16 Sep 2023 06:57:35 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9159D42498;
        Sat, 16 Sep 2023 18:57:29 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694872650; bh=4hf9NDkSjXIiEDRF/oTd87ONW933mcqoFz4BE59iyKY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=O2X0OmxK3DHH70+wCsefFAaVmGbwaPuAKMV/tDqsLXzVjVyKalk0DbPKd6nlDsZbT
         wS2NaBhSAca2FIVtC+Rerib9hSYFK2LVV0B57KJriC+5ktRZdDk+QFFmcukRcHXp+g
         wIbU33hcomGbbJQWemjPX9cXt9M6AGLKnudab+KDc9dqngW6XbzAA6ctD+QLOdZDRd
         A1Pl/vhnGdfZxFJW4xeMFdWfKvnQe1vW7aC29l35831hflI895iR3LWq8vlL/IdV6F
         tLnjPlIDyj0iBzneFGUqVi02QGv9rh/1+gvoXDALCt2weqrKb/N3Nr7XtENeXvgmFi
         7PaO85BCx6h5w==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Sat, 16 Sep 2023 18:57:06 +0500
Subject: [PATCH 3/3] arm64: dts: qcom: msm8916-longcheer-l8150: Add battery
 and charger
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-pm8916-dtsi-bms-lbc-v1-3-7db0b42f9fb1@trvn.ru>
References: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
In-Reply-To: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=4hf9NDkSjXIiEDRF/oTd87ONW933mcqoFz4BE59iyKY=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlBbQ8BNlnZPYaTsGrRi3gzuGx+ikU9W0eOJm+o
 qE4NQTu52WJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZQW0PAAKCRBDHOzuKBm/
 dZTeEACEw58WEI8ogGUTMLa2uBApWvK7ZnseHAogy6bvt7D4FGX7bpO3b3rqMbzMgF5DiFyyjau
 AHNe80OsUFIR9/OUba8TAMwin9DtHVbzNo/Ja/J8maUeK45Wnq9pbOIm4QYkjK6nXGhOZWA2RPt
 loL47GYG1LnCg30ZfwNUiu/YmWPICHPHsT0xEAvenwOEwUTlllUR8YYapL/w8iHIg9n1cn2iei4
 l5qBs5yXasktNeZLvE37iM4zrAwruOAaZO9WLQtOvlSYXAaJ4mzcjqZiSnvOdeOji0+Vhcrp2Sj
 YPAX6QSKlRTCAPhVFdPueRC4F8sgoXuRJR6FLyrjgudS3o//6tx2eX6x4LCZQe01n1oY4LkOzzl
 xBWz1FOiZSB7NN7MkzStMbEo1Jc7e+Ur2ndrbeAGO1SwxDaWO5lXe0VW7UrLh83Yipz2r238HGo
 61nRiXfQD+NAiHbGE5ubNj63lHR6qhv2HEMmfppX0tpi22NYMl+5aKnGx2NukE/l+ChYry9EHFO
 dm4/udF2U74ER0m5w33GCfaTLGN6VKre485OO3AMJLfsq+jBTYalxyuqdtv9wKw04DmBzjR+NO1
 ISSLNC9Dm7CpZhNFlUwkIeDVuDzjm50Xhm2QsFYBPtJEzXkSWszi53d5pma/HsELdA9smRXYzqc
 CXhkqqlMohzJWyw==
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
that those devices rely on.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 43 +++++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 3892ad4f639a..95dddf3b3880 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -33,6 +33,25 @@ wcnss_mem: wcnss@8b600000 {
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
 
@@ -220,6 +239,22 @@ &blsp_uart2 {
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
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -232,10 +267,6 @@ pm8916_l17: l17 {
 	};
 };
 
-&pm8916_usbin {
-	status = "okay";
-};
-
 &pm8916_vib {
 	status = "okay";
 };
@@ -252,11 +283,11 @@ &sdhc_2 {
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
 
 &wcnss {

-- 
2.41.0

