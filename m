Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D427D7E3E98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbjKGMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjKGMic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:38:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC372101;
        Tue,  7 Nov 2023 04:26:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EACC433C8;
        Tue,  7 Nov 2023 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360003;
        bh=mV6nnOYneyUTZ+Dr37hMYmU8r271XhHRrhZrDDmeQ3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntmFM7zV90X9d3i+u3DUtjDWzK5Iek4yFtiVMux6OXn132ik9NgnDs78uRuBe1J8d
         jGwFEfg+iFETtjNNYvuc+snW88lYd8zZVZPDMmeaKzNwqm86DledJ9Zj9nTg+dc9YU
         OvszBJ3nz0HmPk1kt3+z7LwudSlDNxJotbfmwV8Ev/OxoF65z4Jq12YSBQcYWGEUeo
         qPcaBGP2wYKN0lzSYanGESKl2K9XCNTomXkkcnVpFy3uUYHc34dXMv43alLeXyLGtg
         AiKdYMWbt7v+KgyBte6jyf4xXrV+S6aCUMT5V2+iU/FaipZyk//ANi8lZj1bniDZ0m
         F7SlzIuONwzOw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>, magnus.damm@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 33/37] arm64: dts: renesas: r8a779f0: spider: Enable PCIe Host ch0
Date:   Tue,  7 Nov 2023 07:21:44 -0500
Message-ID: <20231107122407.3760584-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
index dd8e0e1595260..d959105f83bcc 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
@@ -33,6 +33,12 @@ memory@480000000 {
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
@@ -86,6 +92,12 @@ gpio_exp_20: gpio@20 {
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
 
@@ -125,6 +137,18 @@ &mmc0 {
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

