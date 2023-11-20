Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766FF7F153D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjKTOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjKTOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:04:21 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B771310F0;
        Mon, 20 Nov 2023 06:03:46 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id A9E1341C90;
        Mon, 20 Nov 2023 19:03:41 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1700489022; bh=BrH6JaWplfF74qXPPGkuDJqNTFRktZ2OQLNeZAUmXxQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Y/ORlK5wXjTYpt12coidh4mlqNowxiQZPnHq884e9AGEzWKKz/EOenUdAvfJ0Sb0i
         T+kvfd8gw/W5CSOfO8KS5VduvL0PWAM3/PbGv9yDj0Blda7sfCasZ6uKJkGC5fdmCY
         7whdUAaYbggu6tq1CkPQBuNMcSKtKEfBvy7m+FVDH8Lj150jcxqoi8USiegHmnCVbL
         3F5xoE3LB6zFb3NqkbfeTcn1KsyzGM4c8ydmZzM6Nf28y2WNC6dR0oA3oWTEa5psgv
         4a7fbXGS8xXTNzO3DEorvMj0V+2DM6rKXZ2HRR9s88CsmR4xuDSFNrpYtDM3l8gJd3
         v3lse3VOjO+Mw==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Mon, 20 Nov 2023 19:03:05 +0500
Subject: [PATCH v4 3/3] arm64: dts: qcom: msm8916-longcheer-l8150: Add
 battery and charger
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-pm8916-dtsi-bms-lbc-v4-3-4f91056c8252@trvn.ru>
References: <20231120-pm8916-dtsi-bms-lbc-v4-0-4f91056c8252@trvn.ru>
In-Reply-To: <20231120-pm8916-dtsi-bms-lbc-v4-0-4f91056c8252@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=BrH6JaWplfF74qXPPGkuDJqNTFRktZ2OQLNeZAUmXxQ=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlW2c65Yi++t1lAaUIQqiszlSL5qLWtYw1Ki/RC
 Gz9Y2AD7+KJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZVtnOgAKCRBDHOzuKBm/
 dVjBD/4mzDIztmqQUysP2CzTPbCKfzFcCRnbqXZy+v2bPXvSDdmZZRy0BgYsIU5uCwOuHNlK1vd
 3s8628yy3BYvN8OP2E3l6eE0IoDVGW6biKcBAsH79ys0Ty7lREzj10FgWDq02vq1I1CgjroEEnk
 WbnVgihKQ5uNWVgHvbdoGdc9Hoij0BjsHFyWzKCW1MSViDZ4khSMP2ihz5HYiJYYHUTVkVGeOA3
 GZSYkaqfXRTyWVsiFNcQ6buVUZbnxsZ5LIo8JXWqx1CYU5ByT/RlaZiIgxPp0/4TBeSIGxVhjHI
 4j2HBUz0TlIEIl4ab5/xOWQnFRf5gTyqiGN3fQkndwlzEUFfPQF5S/a9Npdy4oc3M2j5iAybnWA
 nPCgHuHgXopmb7gf7XvSEhzcbO447W5xeWqDH/p6w6pAiZDw3ap5L8lDWll7FvSbZFjJcKyMfEN
 xE5lh/nZ8cwAuAmQR407tanf51sUGBnjv+Gtj4/6lxKixbPYAy82ehRL2fkN9CmrVkDfXeI8Aga
 ZmoIB5/K89e8CHBIALzuYwd4baWxG7K05DnU/0KlBepdN7xPGJZeVJE7k0rvDQwOc3Ue/YxijHn
 Y5xVbaL3vcHB8NiHmRUD4AVRabNI3AbadKTQNBt4KWXVRXCH6CYxKNG9/T9CBRemThuBDKsX5x2
 JtdmMJBRZjiRPFw==
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

Longcheer L8150 doesn't have any dedicated fuel-gauge or charger,
instead making use of the pmic hardware blocks for those purposes.

Add pm8916 bms and charger, as well as the battery cell description
that those blocks rely on.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

