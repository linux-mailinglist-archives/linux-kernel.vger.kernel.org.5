Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0F77991C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjHKVBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjHKVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:01:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60309E77;
        Fri, 11 Aug 2023 14:01:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso36798841fa.1;
        Fri, 11 Aug 2023 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691787706; x=1692392506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FYMqj5Ls27ICNMTXDpLDMUf6iO1TkLY2SFsKfnVgyA=;
        b=Oq6M398afUXzaoDEuJgEutAnJQTXC0nCQtTct+3O+++mgGHiKh/xjU5bX+toSQYAKH
         ogCXmdkr/ouzEZ/8GViZfaNAhBbWYGS0AQmvEHxPidaQ5SnqItEL3uL9+FNIvqptltvd
         JKVBmD57WUIpPpnAGMu91xsko6ug6b+LijvmFo/6ggR5TPkax8V7aQn1hx/tyAofoaa1
         FpfE9YrjxrY5zJq3sIeFKvK6FBpNgx5iPgWwVOubdx0kNy/Txu70YFKjsQ3LU19HqSTN
         bTP4P0ME9bhI3j/g25ejF5MfumYax6+kvFrARGtU1CFB79ok3pndOkNUKw4rDXKf2Azs
         126w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787706; x=1692392506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FYMqj5Ls27ICNMTXDpLDMUf6iO1TkLY2SFsKfnVgyA=;
        b=bX2UlnseCl2CIUxHWw+vwJJVVZlwBPoKmkwsx9VyDVrT6MxpCjCxh6kOzVXQ77oK0k
         vA8EWOHpWZzIhnXKKCJvifq+hPYXye+UAkX050xmrhJajCoGbyME0T4mueNgJYRT+gbH
         XnyFy9fTvutaHhvUs8zd0nAvyL0/32RKwH1ogdFscKJAAPmSm7r+U7xPlLjQuwZG6BYT
         n8ZrPOQcds2m+spdvNtqOSleQkhMS1L4GADHavDWj3MgiTP+gEtwd7W/YwOrJZxZeAhm
         1U2aHXxZbU5Eo3GLfJ7UY+CmlVZyCs+WYNplywcXyf6Xw8JhNvvwoN+ZpCuITN6yxv0T
         t/Og==
X-Gm-Message-State: AOJu0YxBfnUI/VxMjs8v0xI+WgovEGwo9eC07Nhp4FMoMUXz1xMnlAx9
        wTd0QHNhRHhvkgGx7JxYRS4=
X-Google-Smtp-Source: AGHT+IFLSsllj3O/Hz+W5yl9GzaOupCH8dppUpzhCKJof5azsvkKGjyp2iPAXKvd+llwRwXzDhGxbg==
X-Received: by 2002:a2e:994b:0:b0:2ba:cbb:47b7 with SMTP id r11-20020a2e994b000000b002ba0cbb47b7mr2632782ljj.21.1691787706185;
        Fri, 11 Aug 2023 14:01:46 -0700 (PDT)
Received: from fedora.. ([188.252.220.253])
        by smtp.googlemail.com with ESMTPSA id d3-20020a1709063ec300b0099bcb44493fsm2694907ejj.147.2023.08.11.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 14:01:45 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] ARM: dts: qcom: ipq4019-ap.dk01.1: use existing labels for nodes
Date:   Fri, 11 Aug 2023 23:01:02 +0200
Message-ID: <20230811210142.403160-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the nodes under soc already have existing labels so use those
instead.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi | 140 +++++++++---------
 1 file changed, 69 insertions(+), 71 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
index 0505270cf508..0714616c9e45 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
@@ -27,87 +27,85 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+};
 
-	soc {
-		rng@22000 {
-			status = "okay";
-		};
+&prng {
+	status = "okay";
+};
 
-		pinctrl@1000000 {
-			serial_pins: serial_pinmux {
-				mux {
-					pins = "gpio60", "gpio61";
-					function = "blsp_uart0";
-					bias-disable;
-				};
-			};
-
-			spi_0_pins: spi_0_pinmux {
-				pinmux {
-					function = "blsp_spi0";
-					pins = "gpio55", "gpio56", "gpio57";
-				};
-				pinmux_cs {
-					function = "gpio";
-					pins = "gpio54";
-				};
-				pinconf {
-					pins = "gpio55", "gpio56", "gpio57";
-					drive-strength = <12>;
-					bias-disable;
-				};
-				pinconf_cs {
-					pins = "gpio54";
-					drive-strength = <2>;
-					bias-disable;
-					output-high;
-				};
-			};
+&tlmm {
+	serial_pins: serial_pinmux {
+		mux {
+			pins = "gpio60", "gpio61";
+			function = "blsp_uart0";
+			bias-disable;
 		};
+	};
 
-		blsp_dma: dma-controller@7884000 {
-			status = "okay";
+	spi_0_pins: spi_0_pinmux {
+		pinmux {
+			function = "blsp_spi0";
+			pins = "gpio55", "gpio56", "gpio57";
 		};
-
-		spi@78b5000 {
-			pinctrl-0 = <&spi_0_pins>;
-			pinctrl-names = "default";
-			status = "okay";
-			cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
-
-			mx25l25635e@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0>;
-				compatible = "mx25l25635e";
-				spi-max-frequency = <24000000>;
-			};
+		pinmux_cs {
+			function = "gpio";
+			pins = "gpio54";
 		};
-
-		serial@78af000 {
-			pinctrl-0 = <&serial_pins>;
-			pinctrl-names = "default";
-			status = "okay";
+		pinconf {
+			pins = "gpio55", "gpio56", "gpio57";
+			drive-strength = <12>;
+			bias-disable;
 		};
-
-		cryptobam: dma-controller@8e04000 {
-			status = "okay";
+		pinconf_cs {
+			pins = "gpio54";
+			drive-strength = <2>;
+			bias-disable;
+			output-high;
 		};
+	};
+};
 
-		crypto@8e3a000 {
-			status = "okay";
-		};
+&blsp_dma {
+	status = "okay";
+};
 
-		watchdog@b017000 {
-			status = "okay";
-		};
+&blsp1_spi1 {
+	pinctrl-0 = <&spi_0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
+
+	mx25l25635e@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		compatible = "mx25l25635e";
+		spi-max-frequency = <24000000>;
+	};
+};
 
-		wifi@a000000 {
-			status = "okay";
-		};
+&blsp1_uart1 {
+	pinctrl-0 = <&serial_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
 
-		wifi@a800000 {
-			status = "okay";
-		};
-	};
+&cryptobam {
+	status = "okay";
+};
+
+&crypto {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&wifi0 {
+	status = "okay";
+};
+
+&wifi1 {
+	status = "okay";
 };
-- 
2.41.0

