Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613867E3F56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjKGM4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjKGMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:55:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4866D3A22A;
        Tue,  7 Nov 2023 04:21:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADCAC433C8;
        Tue,  7 Nov 2023 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359701;
        bh=fbCE/3wGbrk0VpscWgRWMhvjTR4+0eLeBxvgG53oMa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTGhxBv5xY2zGgTFp7ip1XJKUJVdc9RBmZv9of7lOmB6p4wLpWvGfbpdYwBHUt0HH
         FhW+fMxpqlmJfNDUcnQFuoVOaXRzPjfDgzDjORSwAzTudLfwF4lbLg8TZCsmIWuoWj
         B4HKTJ0TzJUOTwOX1Z++R/tUvo1dbRzUItxT/hCLGhnbCOi/1kAqAY5Ung5wmUD5A6
         YdkOquJX0croYu7xZnigqGbdgfqk9UePk6o1yRXyuKKM2m/TFPriOXEFGGaGDyWr5P
         KNz/sinTtR81oH228rsps8hD9pVmLx5oMBwqq0BqQX5KzysFhN826sRRKwMouQxz2/
         N7gGqFqU1RpQw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Clark <inindev@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        macromorgan@hotmail.com, jagan@edgeble.ai,
        tmckahan@singleboardsolutions.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 38/40] arm64: dts: rockchip: Add NanoPC T6 PCIe e-key support
Date:   Tue,  7 Nov 2023 07:16:40 -0500
Message-ID: <20231107121837.3759358-38-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Clark <inindev@gmail.com>

[ Upstream commit ac76b786cc370b000c76f3115a5d2ee76ff05c08 ]

before
~~~~
0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0002:20:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0002:21:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
0004:40:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0004:41:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)

after
~~~
0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0002:20:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0002:21:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
0003:30:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0003:31:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac PCIe Wireless Network Adapter
0004:40:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0004:41:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)

Signed-off-by: John Clark <inindev@gmail.com>
Link: https://lore.kernel.org/r/20230906012305.7113-1-inindev@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/rockchip/rk3588-nanopc-t6.dts    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index 0bd80e5157544..97af4f9128285 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -137,6 +137,18 @@ vbus5v0_typec: vbus5v0-typec-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_m2_1_pwren>;
+		regulator-name = "vcc3v3_pcie2x1l0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -421,6 +433,14 @@ &pcie2x1l0 {
 	status = "okay";
 };
 
+&pcie2x1l1 {
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_1_rst>;
+	status = "okay";
+};
+
 &pcie2x1l2 {
 	reset-gpios = <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc_3v3_pcie20>;
@@ -467,6 +487,10 @@ pcie2_0_rst: pcie2-0-rst {
 			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		pcie2_1_rst: pcie2-1-rst {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		pcie2_2_rst: pcie2-2-rst {
 			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
@@ -474,6 +498,10 @@ pcie2_2_rst: pcie2-2-rst {
 		pcie_m2_0_pwren: pcie-m20-pwren {
 			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		pcie_m2_1_pwren: pcie-m21-pwren {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	usb {
-- 
2.42.0

