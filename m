Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2D750F12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjGLQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjGLQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:52:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84081734;
        Wed, 12 Jul 2023 09:52:46 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-111.ewe-ip-backbone.de [91.248.191.111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 14E4E660702E;
        Wed, 12 Jul 2023 17:52:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689180765;
        bh=2VVwOOwLYFVfiLx9s3vRhudNAVz3rkLWFj9+rMW24Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEwnWd1nCvePb64/F4kDhtsNX+nq0clMGpQs+SvEyr5qzPZjA+nyifqkgDmDB6qud
         KtE+Mi6DiOhATsh+678XONtgoBdNptGj2sJrugSjrXmVPYS5K5tHVMCaSRwJulvx54
         D4EMgkwQE1Ns6Dn5qksLD1+fiWPqRrWBanI/liB1kAQnZGf5rQu29+D9IPz1ZeQtEk
         tQO0V+icVV3HagTU9eC9gG22Fd//gV1OmwnTXn1sQp10speFgzqKKwjeNRVAGjbRoN
         pkQtdxmVCKcklodUIpDmTz2qHkeQggtyT3w2H0aU4731TDxkg9fhucc2sEsTK9ZSLn
         FvdTIi/Flqb0w==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1CD914805A0; Wed, 12 Jul 2023 18:52:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 4/4] arm64: dts: rockchip: rk3588s-rock5a: add USB2
Date:   Wed, 12 Jul 2023 18:51:06 +0200
Message-Id: <20230712165106.65603-5-sebastian.reichel@collabora.com>
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

Enable USB2 (EHCI and OCHI mode) support for the Radxa ROCK 5 Model A.
This adds USB support for the on-board WLAN/BT chip, the two USB2
ports, the USB available from the 2x20 connector and the lower USB3
port (in USB2 mode).

The upper USB3 (further away from the PCB) uses the RK3588S USB TypeC
OTG controller for USB2 and USB3 and thus is not supported at all at
the moment.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index a6dff117b459..66eab281c2c9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -64,6 +64,20 @@ vcc12v_dcin: vcc12v-dcin-regulator {
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
+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_host_en>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc5v0_sys: vcc5v0-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
@@ -292,6 +306,34 @@ rtl8211f_rst: rtl8211f-rst {
 			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifibt {
+		wl_reset: wl-reset {
+			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		wl_dis: wl-dis {
+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+
+		wl_wake_host: wl-wake-host {
+			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		bt_dis: bt-dis {
+			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+
+		bt_wake_host: bt-wake-host {
+			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
 };
 
 &pwm3 {
@@ -650,7 +692,43 @@ regulator-state-mem {
 	};
 };
 
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	status = "okay";
+	phy-supply = <&vcc5v0_host>;
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&wl_reset &wl_dis &wl_wake_host &bt_dis &bt_wake_host>;
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

