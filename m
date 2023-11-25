Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD67F8B0B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjKYNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjKYNEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:04:44 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8483F1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:04:49 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50abbb23122so3579416e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700917488; x=1701522288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjX796cis+ayYldjdBxX+dPrYRA+oAMxdqEk9W736A0=;
        b=aHuud8kcCQUuMvN8bzgUWWzcgYxm0jA+Sh7EtN/QqgIQ2JuplF8AL0RtMAX32PO3r1
         oV8f5TAl4Zyqvn/VFNRqUIenK/YGYoLe9vOju+mdXqPZRwNmoqQ6JP8EA871uoalUTsg
         ZStRlE0evNp8IJZBCFD10A6J0Eg+GwxZcZC6FZDtIwd+062J/1WnP5IFWZQuxvpg4Bbi
         3o/tI4iFkwluJIwBNc1uasznJnr6fa1pXPdjbdCIXuC2/TADU5mZDjxDBgMjCcuvUVpk
         jcDMMDPtTsLQ/ogmFqn4/7kTfMpl+FYWshDVV/Gigs4t4fjtCoVCzoet0YGhfJf/jteB
         0xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700917488; x=1701522288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjX796cis+ayYldjdBxX+dPrYRA+oAMxdqEk9W736A0=;
        b=rKn5DEVNAXmq3+EE1e6rT2SqeYKAy+Z6pfO0lEnMQ0cgpq8vnNoh/Vqt58knqjUogC
         sZYvkKUzw3QTNsMbpIQUQJXSh6aBTYzRI+HtH53rySK1NgHLsrhmY0T6kdshz3EBuEjN
         GLoJORCjIl+KR+pE8fCJr3HX2SfvZuBrIF2Bd5E533uOSeGEcBOHQvvAPn1lLfhI7HKR
         KbKbydLxFR+b32PDb8FyN9BasBQsfUYpahtHIZ3QpAsHBwA9uyoXjgSlyratuB9RKCdC
         XnhwnlxHC/aixn46B7jYiykkavi+r5gtrf3IhLvggfptbtpc2Sef/RTFNdjydMrnvtGh
         VsHQ==
X-Gm-Message-State: AOJu0Yy579CGgDjyKEnAGHARfNDBjgW2GVik+CzdTGNiQr7QmFO5/sV5
        AOUfdGsX9Q8Ow3sTrYzcluKSPA==
X-Google-Smtp-Source: AGHT+IEBJQcfRNugynBOwjhkVtUG43AIj0ZUleHg9mUXCESst3QbRdQiitWD3aAdsjjsm6Nrxma8rw==
X-Received: by 2002:ac2:4c4d:0:b0:50a:a571:57a8 with SMTP id o13-20020ac24c4d000000b0050aa57157a8mr1230369lfk.55.1700917488098;
        Sat, 25 Nov 2023 05:04:48 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906361600b00a0290da4a50sm3433750ejb.186.2023.11.25.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 05:04:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 14:04:42 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: qrb4210-rb2: Enable bluetooth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-topic-rb2_bt-v1-2-509db2e28e70@linaro.org>
References: <20231120-topic-rb2_bt-v1-0-509db2e28e70@linaro.org>
In-Reply-To: <20231120-topic-rb2_bt-v1-0-509db2e28e70@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700917484; l=3406;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lMa4muGtqVp70/kaf96dhyjICErE57I62MAZHfO8ssM=;
 b=7HR57PDclXc87x/L+F8VojLz1k3cobzeS/NzVuAn9vjgGqcqhM6QaspikJl2uOZQK/IxWP8Zf
 alt+mprmlICD+en8KJ1HduUF6lLO3d011Yh5HZzc6k0PH8/5M76Ha0r
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the QCA bluetooth on RB2. It identifies like the following:

Bluetooth: hci0: QCA Product ID   :0x0000000a
Bluetooth: hci0: QCA SOC Version  :0x40020150
Bluetooth: hci0: QCA ROM Version  :0x00000201
Bluetooth: hci0: QCA Patch Version:0x00000001
Bluetooth: hci0: QCA controller version 0x01500201

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 81 +++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 9738c0dacd58..bd751236f983 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		serial0 = &uart4;
+		serial1 = &uart3;
 	};
 
 	chosen {
@@ -352,7 +353,8 @@ vreg_l8a_0p664: l8 {
 
 		vreg_l9a_1p8: l9 {
 			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2000000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 
 		vreg_l10a_1p8: l10 {
@@ -389,11 +391,13 @@ vreg_l15a_3p128: l15 {
 		vreg_l16a_1p3: l16 {
 			regulator-min-microvolt = <1704000>;
 			regulator-max-microvolt = <1904000>;
+			regulator-allow-set-load;
 		};
 
 		vreg_l17a_1p3: l17 {
 			regulator-min-microvolt = <1152000>;
 			regulator-max-microvolt = <1384000>;
+			regulator-allow-set-load;
 		};
 
 		vreg_l18a_1p232: l18 {
@@ -426,6 +430,7 @@ vreg_l22a_2p96: l22 {
 		vreg_l23a_3p3: l23 {
 			regulator-min-microvolt = <3200000>;
 			regulator-max-microvolt = <3400000>;
+			regulator-allow-set-load;
 		};
 
 		vreg_l24a_2p96: l24 {
@@ -487,6 +492,60 @@ &tlmm {
 			       <56 3>, <61 2>, <64 1>,
 			       <68 1>, <72 8>, <96 1>;
 
+	uart3_default: uart3-default-state {
+		cts-pins {
+			pins = "gpio8";
+			function = "qup3";
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio9";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		tx-pins {
+			pins = "gpio10";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio11";
+			function = "qup3";
+			bias-pull-up;
+		};
+	};
+
+	uart3_sleep: uart3-sleep-state {
+		cts-pins {
+			pins = "gpio8";
+			function = "gpio";
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio9";
+			function = "gpio";
+			bias-pull-down;
+		};
+
+		tx-pins {
+			pins = "gpio10";
+			function = "gpio";
+			bias-pull-up;
+		};
+
+		rx-pins {
+			pins = "gpio11";
+			function = "gpio";
+			bias-pull-up;
+		};
+	};
+
 	lt9611_rst_pin: lt9611-rst-state {
 		pins = "gpio41";
 		function = "gpio";
@@ -508,6 +567,26 @@ sdc2_card_det_n: sd-card-det-n-state {
 	};
 };
 
+&uart3 {
+	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
+	pinctrl-0 = <&uart3_default>;
+	pinctrl-1 = <&uart3_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+
+		vddio-supply = <&vreg_l9a_1p8>;
+		vddxo-supply = <&vreg_l16a_1p3>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l23a_3p3>;
+		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		max-speed = <3200000>;
+	};
+};
+
 &uart4 {
 	status = "okay";
 };

-- 
2.43.0

