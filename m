Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D39760D92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjGYItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjGYIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:48:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9826A3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:46:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so13143784a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690274798; x=1690879598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlbuF9GW/UUiryYl6cWoqRYe+aX6OM3eYgKK9vJEYOw=;
        b=M3iBy29puoxXZ6rM8EV9glS1Zn1pRGPsaw6LOOahZUz959whS8lkcXeS2+NK1aqPq0
         5f+cFOtECynFkB7aX4pb9L4TMfZpad4918vlV3F792Cyr/cCrSTPKmcEKhlqogRaGqJl
         y6+m8dfYviHqGh4JMY6DIchB4Z31U7xFt/uAiqkX0HB2MOC9CI6P7WoX0yHvNzu8PJyw
         hKS4bonZKIkj0FHMWSBYviNBRxRO1UYcitJVHm9ItgKoKEH3cI6dpA0/S33S4iwpTQ/H
         uxuFOTLFUNtkHalKNhrQsrI+FHsnf7Gj06S7T1rCsUaP1LTzyBQ/iNSOEf22WTdwvGBd
         5AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274798; x=1690879598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlbuF9GW/UUiryYl6cWoqRYe+aX6OM3eYgKK9vJEYOw=;
        b=A3Z7pD+ubiy0V4Wlvla7z/EOGMm1vihsF1B+yttfQT8oWIlJTrXnqMzCsb6BiUsdR5
         kYh0D6PQaVWE5CJ00YupyiVNOtqpccO149kNHz1lFZI8UfUqBzUZsb++zkr4RfdOwwLJ
         NBA5qdpPfUjOUHRV1BU+t5IlEIuv7QWnhPm5RdpyQo0kfFKLNFyegh2nlrZBTKDjf7yV
         LDPL1TIrvugAF46cb9qXKp2mH7fTNdHScQHmqsJQgncCj8/ozSiYz47S3l6CY7j9EUPy
         RFCQ+Zbf/1yVjlREcyBFXcf01Yie6Yfr0jgtEhYccAawUc5i1zpG5c3NhOxULE6E+XAd
         2NOg==
X-Gm-Message-State: ABy/qLY+YuZxo2o4nuWvP6vMuZlzCX3ZbNnNty6awdWe6w0Irp7xtc8U
        sgvOdU3qt2PdCtNtp7Q3jQF5qw==
X-Google-Smtp-Source: APBJJlFxcW0FY0WW1nnu3wIeqn0GpE6VrHe1OIkrOLE2pvGcYdsYyn7CCgeDKAS72F8B00VeN9yN6g==
X-Received: by 2002:a05:6402:4412:b0:51e:48e7:72ca with SMTP id y18-20020a056402441200b0051e48e772camr1910946eda.13.1690274797759;
        Tue, 25 Jul 2023 01:46:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w22-20020a056402071600b005221b918e33sm4472526edx.22.2023.07.25.01.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:46:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT] arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side
Date:   Tue, 25 Jul 2023 10:46:33 +0200
Message-Id: <20230725084633.67179-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Embedded USB Debugger (EUD) second port should point to Type-C
USB connector.  Such connector was defined directly in root node of
sc7280.dtsi which is clearly wrong.  SC7280 is a chip, so physically it
does not have USB Type-C port.  The connector is usually accessible
through some USB switch or controller.

Correct the EUD/USB connector topology by removing the top-level fake
USB connector and adding appropriate ports in boards having actual USB
Type-C connector defined (Herobrine, IDP).  All other boards will have
this EUD port missing.

This fixes also dtbs_check warnings:

  sc7280-herobrine-crd.dtb: connector: ports:port@0: 'reg' is a required property

Fixes: 9ee402ccfeb1 ("arm64: dts: qcom: sc7280: Fix EUD dt node syntax")
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.
---
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 15 +++++++++++++
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi | 15 +++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 21 +------------------
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9ea6636125ad..2a4f239c5632 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -573,6 +573,12 @@ usb_c0: connector@0 {
 				power-role = "dual";
 				data-role = "host";
 				try-power-role = "source";
+
+				port {
+					usb_c0_ep: endpoint {
+						remote-endpoint = <&eud_con>;
+					};
+				};
 			};
 
 			usb_c1: connector@1 {
@@ -590,6 +596,15 @@ usb_c1: connector@1 {
 #include <arm/cros-ec-keyboard.dtsi>
 #include <arm/cros-ec-sbs.dtsi>
 
+&eud_ports {
+	port@1 {
+		reg = <1>;
+		eud_con: endpoint {
+			remote-endpoint = <&usb_c0_ep>;
+		};
+	};
+};
+
 &keyboard_controller {
 	function-row-physmap = <
 		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
index ebae545c587c..ffc469431340 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -44,6 +44,12 @@ usb_c0: connector@0 {
 				power-role = "dual";
 				data-role = "host";
 				try-power-role = "source";
+
+				port {
+					usb_c0_ep: endpoint {
+						remote-endpoint = <&eud_con>;
+					};
+				};
 			};
 
 			usb_c1: connector@1 {
@@ -78,6 +84,15 @@ cr50: tpm@0 {
 	};
 };
 
+&eud_ports {
+	port@1 {
+		reg = <1>;
+		eud_con: endpoint {
+			remote-endpoint = <&usb_c0_ep>;
+		};
+	};
+};
+
 &tlmm {
 	ap_ec_int_l: ap-ec-int-l-state {
 		pins = "gpio18";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 925428a5f6ae..af9bb2ebcaa1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -649,18 +649,6 @@ cpu7_opp_3014mhz: opp-3014400000 {
 		};
 	};
 
-	eud_typec: connector {
-		compatible = "usb-c-connector";
-
-		ports {
-			port@0 {
-				con_eud: endpoint {
-					remote-endpoint = <&eud_con>;
-				};
-			};
-		};
-	};
-
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -3624,7 +3612,7 @@ eud: eud@88e0000 {
 			      <0 0x88e2000 0 0x1000>;
 			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
 
-			ports {
+			eud_ports: ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3634,13 +3622,6 @@ eud_ep: endpoint {
 						remote-endpoint = <&usb2_role_switch>;
 					};
 				};
-
-				port@1 {
-					reg = <1>;
-					eud_con: endpoint {
-						remote-endpoint = <&con_eud>;
-					};
-				};
 			};
 		};
 
-- 
2.34.1

