Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05CC80434E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbjLEAYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLEAYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:24:07 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B6FF;
        Mon,  4 Dec 2023 16:24:13 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1fafe41bfb0so2103944fac.0;
        Mon, 04 Dec 2023 16:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735852; x=1702340652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7obvGCBMmltBjy5XbnnE2I2O+AT6oEkcBU325Ni1XM=;
        b=l6yVqPCjVm4mh3oZXKGnMhm1rQZW50wYHoC2ljJri5slHbCcg8Bhyzxf+9jnvL3osd
         bDWQcjlE8kATOdn/eJWCmoi5s79umc2nTH8569S/cWUha5mHRqfG+Xgy96uK7B7fHMZQ
         fUNNvk8fQsjaEPiiXoDFU0iUqHSH9aLMb5I0JfmK0gadYmbaivfTJriSRIkVP3kIB9bh
         k+S3Qy8bdA7xwSP3q4/ajsZB1HdNaW5918ReL6m8ZA1pkgl6urYrY4Cgxj2r/CnXax2n
         O+AGjCKVJF+hD/5+sUZnNoHBug3Vg2bjTEocz5n/a9P8KoJgP12A+ZPS1J8XR7p67s6k
         JSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735852; x=1702340652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7obvGCBMmltBjy5XbnnE2I2O+AT6oEkcBU325Ni1XM=;
        b=PZ8kBGNhGw5kB5wvRvnWqQ7ECvRT53oEMLc7B1P1up6BdxQqjiUfKk6rFANecneQjc
         gVARcu3a53XoJJnFJuaB+2+ltEmntgf43Vv7it9Qrwo7s+SkZiKIWx5+Hpywsgl3UxBR
         dnMw0G703B01263PGuvEkl4IntTDx5MnhVSOHkA+3MGpcoDuDud1Ztc7BHKi3l1flt+R
         aoWa7LvDH70r2VHsBb49DYZxeOOrVEDDjyvApx3GWnCF0an0XaGnhCmLH53cVh3rfd3J
         uPkokjb2eZgLdS7x4r8VxZQVgGYobLTmeJbBvat3lAAVshH3+yf1TcCcXoHEMeawRQzx
         Ro1w==
X-Gm-Message-State: AOJu0YxeQ6y1Zq8h/H+XH1l1FwhaqVQPkcuPp4mL3XHfxEoFCgfnHNFU
        Yg0VivQ6OnVzz+iVNSx7xrE=
X-Google-Smtp-Source: AGHT+IGD706YDruc38UmeXeVfUdYx0iJfeoLc76Wz6RAueGGVRmm2G+cyR69igaLKhQnCz8+a2foUg==
X-Received: by 2002:a05:6870:9692:b0:1fb:75a:77b3 with SMTP id o18-20020a056870969200b001fb075a77b3mr5070235oaq.100.1701735852665;
        Mon, 04 Dec 2023 16:24:12 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id gh17-20020a0568703b1100b001fb36f71f3csm1172481oab.31.2023.12.04.16.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:24:12 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v4 4/4] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date:   Tue,  5 Dec 2023 08:24:05 +0800
Message-Id: <8ca06f77efaee132c2145a4a09fa18f4ee17ce88.1701734442.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701734442.git.unicorn_wang@outlook.com>
References: <cover.1701734442.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add clock generator node to device tree for SG2042, and enable clock for
uart.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  4 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 79 +++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 49b4b9c2c101..0b3b3b2b0c64 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -14,6 +14,10 @@ chosen {
 	};
 };
 
+&cgi {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 93256540d078..ecc7758073af 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
 
 #include "sg2042-cpus.dtsi"
 
@@ -18,6 +19,12 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	cgi: oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi";
+		#clock-cells = <0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -311,12 +318,84 @@ intc: interrupt-controller@7090000000 {
 			riscv,ndev = <224>;
 		};
 
+		sys_ctrl: system-controller@7030010000 {
+			compatible = "sophgo,sg2042-sysctrl";
+			reg = <0x70 0x30010000 0x0 0x1000>;
+		};
+
+		clkgen: clock-controller@7030012000 {
+			compatible = "sophgo,sg2042-clkgen";
+			reg = <0x70 0x30012000 0x0 0x1000>;
+			system-ctrl = <&sys_ctrl>;
+			#clock-cells = <1>;
+			clocks = <&cgi>;
+			assigned-clocks = \
+				<&clkgen DIV_CLK_FPLL_RP_CPU_NORMAL_1>,
+				<&clkgen DIV_CLK_FPLL_50M_A53>,
+				<&clkgen DIV_CLK_FPLL_TOP_RP_CMN_DIV2>,
+				<&clkgen DIV_CLK_FPLL_UART_500M>,
+				<&clkgen DIV_CLK_FPLL_AHB_LPC>,
+				<&clkgen DIV_CLK_FPLL_EFUSE>,
+				<&clkgen DIV_CLK_FPLL_TX_ETH0>,
+				<&clkgen DIV_CLK_FPLL_PTP_REF_I_ETH0>,
+				<&clkgen DIV_CLK_FPLL_REF_ETH0>,
+				<&clkgen DIV_CLK_FPLL_EMMC>,
+				<&clkgen DIV_CLK_FPLL_SD>,
+				<&clkgen DIV_CLK_FPLL_TOP_AXI0>,
+				<&clkgen DIV_CLK_FPLL_TOP_AXI_HSPERI>,
+				<&clkgen DIV_CLK_FPLL_AXI_DDR_1>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER1>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER2>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER3>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER4>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER5>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER6>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER7>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER8>,
+				<&clkgen DIV_CLK_FPLL_100K_EMMC>,
+				<&clkgen DIV_CLK_FPLL_100K_SD>,
+				<&clkgen DIV_CLK_FPLL_GPIO_DB>,
+				<&clkgen DIV_CLK_MPLL_RP_CPU_NORMAL_0>,
+				<&clkgen DIV_CLK_MPLL_AXI_DDR_0>;
+			assigned-clock-rates = \
+				<2000000000>,
+				<50000000>,
+				<1000000000>,
+				<500000000>,
+				<200000000>,
+				<25000000>,
+				<125000000>,
+				<50000000>,
+				<25000000>,
+				<100000000>,
+				<100000000>,
+				<100000000>,
+				<250000000>,
+				<1000000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<100000>,
+				<100000>,
+				<100000>,
+				<2000000000>,
+				<1000000000>;
+		};
+
 		uart0: serial@7040000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
 			interrupt-parent = <&intc>;
 			interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <500000000>;
+			clocks = <&clkgen GATE_CLK_UART_500M>,
+				 <&clkgen GATE_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
-- 
2.25.1

