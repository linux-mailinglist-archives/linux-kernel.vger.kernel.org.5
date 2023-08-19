Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B000781721
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 05:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbjHSDSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 23:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbjHSDRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:17:42 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96108421B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:40 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c8d895a602so907211fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692415060; x=1693019860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK4lc13hsQBieya89oWIFB0P2uDWj3MviewwKrAjxRw=;
        b=gH2yIICE5JiUkpTUs4CSGRbbH5ZMRMUR0GayY2DiaZAwbPuo7IBZOO19ZfmjRnWQow
         WSvXRhBjmEJwhIHLbz3MLbKMue1Y73dVgaSmND3FeGzInC45hRXk62nvTmyUXvINW+kQ
         IFLuZmM/4525WH4XAPKBdcSojq1g5646XK9kggBY2WIbpV0d59N2WSp/D0E+/wW8FsNP
         1S4HzvMPpFtP/9BIcu927YlH+iXdQoDB/j3X5trswIRH/NUJ/8MfhXzEu5KG1vIJLGUP
         zm8YYj1dnbrdDwzfsSGa59JPhmz07dFWmaRDzDavUZAQ8FOTt7eAQS9ZhSNAzeFjj1uu
         Qu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692415060; x=1693019860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK4lc13hsQBieya89oWIFB0P2uDWj3MviewwKrAjxRw=;
        b=mET2JtHbYU+5YLZNp908W9PQ7/9nJWY8vCz4LoUxv7qUabLatHGaHvY1hntnBCTL7n
         F+q8ZrhlwXewo57h2SxIqhd1w1TpL19M2bAbnChCXuTN6abwxeTW+qNfUAvWELT+FMAo
         VNhV4NO0InZPtJ08CfYF0wJndrXHD881mQxKI2m/1AqghFpJlzDR2sXSJvSTpK+vhbZb
         XscR5Adaq1qn35VZn+ccKRTQrD+pPXAeBa6Am+m0WjpzyfcB8ubZB79LsASijqQtW8ik
         +O+HMWM6gv+9HnpvDceMHrdpe7bZPHr1kffr4CvjpquRskDTWCIiKFq8VLrOHFrkArw6
         Z9rA==
X-Gm-Message-State: AOJu0YwTwXdXj784KO94Yk7ukCeTF5vx1tGwj7/GTpoX5Yked5QOe7+X
        /X+hmi4uV+B8/OYUjNLqavN/sw==
X-Google-Smtp-Source: AGHT+IEQ3BwqLE3HDnHpyCiEwIbHJOPXfPkwHfhNQFFL1+Q07JcVrXASX49TluX1i2SH3iY6U9p5kw==
X-Received: by 2002:a05:6870:1d0:b0:1bb:c946:b80e with SMTP id n16-20020a05687001d000b001bbc946b80emr1102346oad.28.1692415059832;
        Fri, 18 Aug 2023 20:17:39 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id q2-20020a9d7c82000000b006b89dafb721sm1424375otn.78.2023.08.18.20.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:17:39 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     JaeHun Jung <jh0801.jung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: exynos: Enable USB support on E850-96 board
Date:   Fri, 18 Aug 2023 22:17:31 -0500
Message-Id: <20230819031731.22618-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819031731.22618-1-semen.protsenko@linaro.org>
References: <20230819031731.22618-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The E850-96 board has a micro-USB socket and two USB 2.0 host sockets.
The USB role (host or peripheral) is selected automatically depending on
micro-USB cable attachment state:
  - micro-USB cable is attached: USB device role
  - micro-USB cable is detached: USB host role

USB can't act simultaneously as a device and a host, because Exynos850
SoC has only one USB controller and there are no external USB
controllers on the E850-96 board. So the USB switch chip (specifically
TS3USB221A) connects SoC USB lines either to micro-USB connector or to
USB hub chip (LAN9514), w.r.t. micro-USB cable attachment state.

When USB works in the host role, Ethernet capability becomes available
too, as LAN9514 chip (providing USB hub) also enables Ethernet PHY and
Ethernet MAC.

Dynamic role switching is done in gpio-usb-b-connector, using current
micro-USB VBUS line level as a trigger:
  - VBUS=high: SoC USB lines are wired to micro-USB socket
  - VBUS=low: SoC USB lines are wired to USB hub chip

In order to make USB host functional when the board is booted with
micro-USB cable disconnected, role-switch-default-mode = "host" is used.

One can look at E850-96 board schematics [1] to figure out how exactly
all related USB hardware connections and lines reflect into
corresponding device tree definitions.

As PMIC regulators are not implemented yet, we rely on USB LDOs being
already enabled in the bootloader, and a dummy regulator is provided to
"usbdrd" vdd nodes for now.

[1] https://www.96boards.org/documentation/consumer/e850-96b/hardware-docs/

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../boot/dts/exynos/exynos850-e850-96.dts     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index 6ed38912507f..8d733361ef82 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -29,6 +29,22 @@ chosen {
 		stdout-path = &serial_0;
 	};
 
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+		vbus-supply = <&reg_usb_host_vbus>;
+		id-gpios = <&gpa0 0 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&micro_usb_det_pins>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb1_drd_sw>;
+			};
+		};
+	};
+
 	/*
 	 * RAM: 4 GiB (eMCP):
 	 *   - 2 GiB at 0x80000000
@@ -111,6 +127,20 @@ bt_active_led: led-5 {
 		};
 	};
 
+	/* TODO: Remove this once PMIC is implemented  */
+	reg_dummy: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "dummy_reg";
+	};
+
+	reg_usb_host_vbus: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_host_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpa3 5 GPIO_ACTIVE_LOW>;
+	};
+
 	/*
 	 * RTC clock (XrtcXTI); external, must be 32.768 kHz.
 	 *
@@ -172,6 +202,12 @@ key_volup_pins: key-volup-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
+
+	micro_usb_det_pins: micro-usb-det-pins {
+		samsung,pins = "gpa0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
 };
 
 &rtc {
@@ -186,6 +222,28 @@ &serial_0 {
 	pinctrl-0 = <&uart1_pins>;
 };
 
+&usbdrd {
+	status = "okay";
+	vdd10-supply = <&reg_dummy>;
+	vdd33-supply = <&reg_dummy>;
+};
+
+&usbdrd_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	role-switch-default-mode = "host";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
+};
+
+&usbdrd_phy {
+	status = "okay";
+};
+
 &usi_uart {
 	samsung,clkreq-on; /* needed for UART mode */
 	status = "okay";
-- 
2.39.2

