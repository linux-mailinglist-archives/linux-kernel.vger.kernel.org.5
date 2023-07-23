Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F575E29C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGWOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGWOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:24:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67635E53
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:24:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5216f44d881so5218716a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690122262; x=1690727062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9EQDGu/G9aGY22djIAWwRsxznq61tp4HsoFojY4f8w=;
        b=kjWa/KVPVN8zUsrW+X8aOxATizFoa2tUm1qJ53sjjd10bfzhNzOYr2pql1FAoJlM8C
         r9FPXz5YtmpKwiSaCFx2lMPvthWgcyb+naJdckuKoMMnd4a1vH9A6G8wzOI+q4BN0Zfj
         XzjAOyUEWhTh1jfH64l4gJFLMvyO6bYS/DYhg3C/AmtbwLIiBqfwIHFYmxv6PDAgOIwZ
         F3ee3nsRz70dVKcQkdgX4Hr2YgkYBdvVm9KuoprcJa/49twWT5Jur1CxLqi04CcKduFP
         1i0oc2WIupxLHY5n/IJKiWx+kde4mac5zvVKQRTf4ln4SiQlSATPndjuFvw/ko3ag81n
         IknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690122262; x=1690727062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9EQDGu/G9aGY22djIAWwRsxznq61tp4HsoFojY4f8w=;
        b=eHV1xVHY+tHMjXzbPbAkCUItpndeW1DDqqd7FB+Prppf6ucswxV3jpDZd2rKsi6R8S
         YERaQgcV1+WCWuGOtF2zdQKEstlAHpzd8V5+uja8fXpZb/hgNYJs7UnyWEYHKcyyFoE/
         zY6+Rfzwu6rGk2QxodKVIEDe/3ElEV5uUi6m+XhhQuyj6OM7K6zt5G/AxwRkcStIXI96
         cCOYYfcXbXSv74eKdr48DerMRDtXWPYKbfAKgwRSdPX3yqzj1MCXWGVce5j6FyVbn8vH
         pJOps7EqDhkDu/xtBVL54vpzyI7A6R50Cwt/Dm0V/XOXP0Oaosgx2FzXGRF7PMm4G4Ws
         hE7w==
X-Gm-Message-State: ABy/qLbBlt3bulHam+fQvKomGnN9dklf6fBRU/srrVGPWa/dcnko7HPo
        gO6OnI2mETKqZjm8ZO3impkX3A==
X-Google-Smtp-Source: APBJJlGijKTBsDB0qaMqp7C37ZN/ipYKV0HPqCKFVT23piyg/YJMaCpgwwnf5grhFlPRIlRNJRHDDg==
X-Received: by 2002:aa7:cd63:0:b0:51d:8ab1:5df4 with SMTP id ca3-20020aa7cd63000000b0051d8ab15df4mr6658239edb.21.1690122261893;
        Sun, 23 Jul 2023 07:24:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7c752000000b00521830574c1sm4938618eds.2.2023.07.23.07.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:24:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2] ARM: dts: samsung: exynos4412-midas: add USB connector and USB OTG
Date:   Sun, 23 Jul 2023 16:24:17 +0200
Message-Id: <20230723142417.97734-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add full description of USB-MUIC (MAX77693 MUIC) and MUIC-MHL
connections, along with proper USB connector and OTG mode for DWC2 USB
controller.

This fixes dtc W=1 warnings:

  Warning (graph_child_address): /i2c-mhl/hdmi-bridge@39/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: replicant@osuosl.org
Cc: phone-devel@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht
Cc: Martin Jücker <martin.juecker@gmail.com>
Cc: Henrik Grimler <henrik@grimler.se>
Cc: Artur Weber <aweber.kernel@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Put connector node in the muic node (Henrik)

Not tested on hardware. Please kindly check if peripheral mode is not
broken. Or maybe OTG started to work?
---
 .../boot/dts/samsung/exynos4412-midas.dtsi    | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
index 57836d5554d0..7daf25865551 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
@@ -182,6 +182,38 @@ pmic@66 {
 			pinctrl-0 = <&max77693_irq>;
 			reg = <0x66>;
 
+			muic {
+				compatible = "maxim,max77693-muic";
+
+				connector {
+					compatible = "samsung,usb-connector-11pin",
+						     "usb-b-connector";
+					label = "micro-USB";
+					type = "micro";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							muic_to_usb: endpoint {
+								remote-endpoint = <&usb_to_muic>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							muic_to_mhl: endpoint {
+								remote-endpoint = <&mhl_to_muic>;
+							};
+						};
+					};
+				};
+			};
+
 			regulators {
 				esafeout1_reg: ESAFEOUT1 {
 					regulator-name = "ESAFEOUT1";
@@ -287,6 +319,14 @@ mhl_to_hdmi: endpoint {
 						remote-endpoint = <&hdmi_to_mhl>;
 					};
 				};
+
+				port@1 {
+					reg = <1>;
+
+					mhl_to_muic: endpoint {
+						remote-endpoint = <&muic_to_mhl>;
+					};
+				};
 			};
 		};
 	};
@@ -545,8 +585,16 @@ hdmi_to_mhl: endpoint {
 &hsotg {
 	vusb_d-supply = <&ldo15_reg>;
 	vusb_a-supply = <&ldo12_reg>;
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	role-switch-default-mode = "peripheral";
+	usb-role-switch;
 	status = "okay";
+
+	port {
+		usb_to_muic: endpoint {
+			remote-endpoint = <&muic_to_usb>;
+		};
+	};
 };
 
 &i2c_0 {
-- 
2.34.1

