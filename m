Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420837E3E09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjKGMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjKGMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:32:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF04032B5F;
        Tue,  7 Nov 2023 04:21:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFDCC433C7;
        Tue,  7 Nov 2023 12:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359674;
        bh=+rywkNCJu5rHEIKiRGZYvVfFeXYV2uIwC+GFP24j8ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpT2+9Ei01waIECjKVEA/uHdhRp8X64vnb/YR/wMypPF4tA4y9DYcnq/UUxdZraAc
         AkvbVfbN68DsWg5H8tuPf3zMTPhD6N94LATpckxkxajY2kjemgcvxVgQCD3rGMmYAs
         I+roAx4T+0zdThlAgls1VIOiMVEiajWM0u0k/8/dnZeGupfRmw1wZZMBU2N6vIpvRY
         VEgjgyNEydZiCVr0C8XJS7lOo/rPmCtnX1lGgiSYKTARdorv6zbX5XVksjPOzJwkKA
         y6bgPMl6mSmkqBjkXhq5e6cH5Y4xZO09GpTjHAeyXngzO4JTmnW41goxzcB8hWN/rp
         0nsKy8+r/yuzQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>, magnus.damm@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 34/40] arm64: dts: renesas: r8a779f0: spider: Enable PCIe Host ch0
Date:   Tue,  7 Nov 2023 07:16:36 -0500
Message-ID: <20231107121837.3759358-34-sashal@kernel.org>
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit c588e1c9846b32182fd5a0ceb637b983810e7100 ]

Enable PCIe Host controller channel 0 on R-Car S4-8 Spider board.

Since this board has an Oculink connector, CLKREQ# pin of PFC for PCIe
should not be used. So, using a GPIO is used to output the clock instead.
Otherwise the controller cannot detect a PCIe device.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230905012404.2915246-3-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/renesas/r8a779f0-spider-cpu.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
index 5cbde8e8fcd5c..477f3114d2fd4 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
@@ -53,6 +53,12 @@ memory@480000000 {
 		reg = <0x4 0x80000000 0x0 0x80000000>;
 	};
 
+	rc21012_pci: clk-rc21012-pci {
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+		#clock-cells = <0>;
+	};
+
 	rc21012_ufs: clk-rc21012-ufs {
 		compatible = "fixed-clock";
 		clock-frequency = <38400000>;
@@ -106,6 +112,12 @@ gpio_exp_20: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		rc21012-gpio2-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-high;
+		};
 	};
 };
 
@@ -145,6 +157,18 @@ &mmc0 {
 	status = "okay";
 };
 
+&pcie0_clkref {
+	compatible = "gpio-gate-clock";
+	clocks = <&rc21012_pci>;
+	enable-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+	/delete-property/ clock-frequency;
+};
+
+&pciec0 {
+	reset-gpio = <&gpio_exp_20 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &pfc {
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
-- 
2.42.0

