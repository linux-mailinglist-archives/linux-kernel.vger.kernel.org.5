Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE182750F05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjGLQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjGLQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:52:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9484E136;
        Wed, 12 Jul 2023 09:52:46 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-111.ewe-ip-backbone.de [91.248.191.111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F240F660702A;
        Wed, 12 Jul 2023 17:52:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689180765;
        bh=4uJ9W9QCFAGIaL+V6KOT9teGlxI8C+rGUbMQLk1iSrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPQPP1vAvBVlbZLkPZyNbmNndPTDYg0LE2JCQg0sklRt38sdxJGgZaw5dMhX5KKJs
         qa1RcxyfKA1tvDBzrmkGjXAO/LmXSvdHHKa1GVNuA1vIIc9yBirVmqxjItvx85efM4
         Q7ZWe563nVyGDt1Q1m7InxlPIr1PtzGq2o3Rw/v7tBuikK6BmUADsW9ZuYejLQpfBQ
         ndXr5cvJ/JXI/qMHXQUmzdjZFCdbGv3ON1DvcgIMPD/nCR8PEkDnwU3qNK1OAfYhjO
         a8QhuUdQwF3q4eEiZC4zERmqno2V/3vft3SJ9cRBnlNU32NCY7gpKos3YvDM2wG3WJ
         ccb+1EeZzDmTA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 19DC1480598; Wed, 12 Jul 2023 18:52:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 2/4] arm64: dts: rockchip: rk3588-evb1: add USB2
Date:   Wed, 12 Jul 2023 18:51:04 +0200
Message-Id: <20230712165106.65603-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712165106.65603-1-sebastian.reichel@collabora.com>
References: <20230712165106.65603-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB2 (EHCI and OCHI mode) support for the Rockchip RK3588 EVB1.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index eeab8f0478a5..378d285a92be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -38,6 +38,20 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};
 
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vcc5v0_usb>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_host_en>;
+	};
+
 	vcc5v0_sys: vcc5v0-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
@@ -47,6 +61,26 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc12v_dcin>;
 	};
+
+	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usbdcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usbdcin>;
+	};
 };
 
 &combphy0_ps {
@@ -142,6 +176,12 @@ hym8563_int: hym8563-int {
 			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm2 {
@@ -767,7 +807,41 @@ &sata0 {
 	status = "okay";
 };
 
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
 };
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
-- 
2.40.1

