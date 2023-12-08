Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D05809884
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572906AbjLHBPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572884AbjLHBPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:15:11 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC1D171F;
        Thu,  7 Dec 2023 17:15:17 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-59052ab970eso610789eaf.1;
        Thu, 07 Dec 2023 17:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701998116; x=1702602916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMotijnh/qiarlNtyEfMGI6pNts/0ixAszGWpmQazv8=;
        b=ebr/03kWW+Oh42WDQ/OrWQJngM0B1CICqrE4Av5RiQkxpEWB1XZMV3StNY6N2tBgxq
         6wM1iYNY7qOpYD9AdAJ/MjMWaoL+6jpwfBGaj52ogdMVn+q+9NJvXL12f3krYyMxigjy
         O6FVkWtCYoKSQ1Pb04zTAy5rTND75EPzV/y7hGJlpU/ldIaAOBt1LXf5MLKxsRf1nkIc
         s3MISkFaQkH+jjLdbrIou9+ZbniXCyQB91/7ZrhmGK+QQQdyRuOZqtdtHpDt95NTYP8f
         4WmGkG7qIAcTGqGYXdrZqbs5XJV99R3wVYlp1zYes79j8aDb6nFkM5yGv/GX+vCCJVb3
         mUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998116; x=1702602916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMotijnh/qiarlNtyEfMGI6pNts/0ixAszGWpmQazv8=;
        b=DMQD26oO6L+0wg+Y6tf5S7QJK7C3IDcZrfaHiN9MMDoPvkVQhg8POr8BAyrHTlJUV3
         bzf88C2e9bsOkKWTGBnHxtXSqhX/VUKf3jGYGu6Ev7SFMlf4lYskSnWeVOfmzOtyCihM
         n/fnrwO8qb51zp89E68sr1PS0Cu/Yd/wZP4A68d5ZMWGD1fClh0ufh1JRuoh23Uhu+6E
         2cfOO8duwMXcwXmOdUsBka6fq1SP7EXe4RJ1TC7FZUWJQckdxzv5bX7N35gZGdpKAbVr
         +scGQ6ImHDAGjkxzKTS9lS+FHlHydPmhPc0fYkfoqnzbUobmczKN1m7liip7Y9UX/dnl
         TiMA==
X-Gm-Message-State: AOJu0Yz4ubpl0tTO8k/IAGEDy4GY5OnMj7P6PkcLKKx7a/xCw6bh9AVJ
        pwvz3bOIGJbyxw/tvvyIwN0=
X-Google-Smtp-Source: AGHT+IGOOVBSFoaAoGYjPbsMs6QasYWQhIA4Z8UtwX3Se0kT2Qsz/Gd7BhSQaY8N6FQtPoCIb63Vnw==
X-Received: by 2002:a05:6870:799:b0:1fb:788:e8ba with SMTP id en25-20020a056870079900b001fb0788e8bamr63989oab.53.1701998116381;
        Thu, 07 Dec 2023 17:15:16 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id ps5-20020a0568709e0500b001fb33181cfasm76280oab.55.2023.12.07.17.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:15:15 -0800 (PST)
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
Subject: [PATCH v6 4/4] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date:   Fri,  8 Dec 2023 09:15:08 +0800
Message-Id: <7017ba0ffc736103339af041ec014a8cf209bc11.1701997033.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701997033.git.unicorn_wang@outlook.com>
References: <cover.1701997033.git.unicorn_wang@outlook.com>
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
index 93256540d078..f08c41dda216 100644
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
+			sophgo,system-ctrl = <&sys_ctrl>;
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

