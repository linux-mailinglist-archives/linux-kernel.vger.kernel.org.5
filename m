Return-Path: <linux-kernel+bounces-124195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF488913B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AD3B23CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB53FB97;
	Fri, 29 Mar 2024 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjLWRFHh"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40023FE4F;
	Fri, 29 Mar 2024 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693328; cv=none; b=MxosWAJEKyUeddgRfKGR3mfiQ1lfQIXbntw9dgRpSY9bDHhokvjuieqK19nI+0aJoBYkdq86qgOdrxDiAglnzch7EFVZ+FYpOu99fAwt0V4oAxlS+Hua2VNGCjkfyYhuRCh+dHv/SbHrxuet1JOoF2arvf2uElu8dofOs9CHJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693328; c=relaxed/simple;
	bh=Kct7Pjk1WKf/K8JXQ51OPs2q82g4Vs270HKxVBz7YVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jo7lW3EFuR5xPuWm57IShfDvcLYANwHJid6x4qxS30omsMbRpGEB9g95jWbCX5+LRBCJp+R4u76USE6xXFdVv1k1DyPtDtQpBsP61xHF8g8OYWOPpQ9dpDx+N6wBjWo+tW1uPTh8BquDeeDjNeTYiHmV1B2LmMo1XKX0hM2HiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjLWRFHh; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-229d01e81f1so908904fac.2;
        Thu, 28 Mar 2024 23:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711693326; x=1712298126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPRTTnRNGB6MC8MgLxeQqBqXiKf58UGvbzByUZNl4Io=;
        b=PjLWRFHhQ4Sq9sICl9wBInuoY47OjDUJ/1bmz//xJAxEr65g50d8arXwBNPFXMv1E0
         bGWbgzTt9GN0XJqcVpwHPcIxYOyvXgGOSCnBNYQ9kEvmMf+hzewcWRJ1PPkfeowocmtD
         fbU4oyCQ3iTeMaoDgPUmLmsqL2IQKegStSCFKCpzNkORVm41TiJpWE9Qe1NYoMSEhU1f
         qDs77YikekGwd2Uqru7nA9EmHHglxbd9gGjGC3S2QuZav1xGiwW3ZQGbtprZm9W60V0q
         08uYjv+DLcEhtsBmJ6Ii3mWhm3LPTL+76mXHLVx6wTZs+vJL7I3FTUlDefl0GfRPn5R1
         yd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711693326; x=1712298126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPRTTnRNGB6MC8MgLxeQqBqXiKf58UGvbzByUZNl4Io=;
        b=vXQstyyTCaO5Fj3MStaGgIc60Of3Hdk9iRwa9aQW2cQ8L2TN85N7icHmQFcAF89MUX
         MgdxWvjQL6k/KZOjvpJvJs1JMQbaYuiC10biMOsbKoPLAh3oW3uNoO8BkilkC0PucXPf
         7GPPZXIlslEYsUj0bUht6oq8kk1fjJNsOzrd4pzf0mP5fIVexFUBMkcOFjAN1C9p7EkL
         M9HK1KLVUZpYhGa7IWTdy9UNrWFOMxKXkzf24swq6xvacPp+8Q52N0t+yfzDN/7SZIRt
         eQW1OhmxUGf+BN+XjJZm0rhCGtDmKX7r1HIN/KQy1THnftIr6yL8+F4pYDysNVDNpYWm
         +exg==
X-Forwarded-Encrypted: i=1; AJvYcCWequJ4cTTcRSYgsbJsEnQs3ocowLmHWtnjOzrwjX0Ct5EvqwEvfCYCRmdgaQBXcxmXMR+xzdh9MrUk1CmPR8JHSKhpzumyH0x0CQVg5suomNacGaONRJ56+FvdCEkDCw8U6Q81iH+SW9zr20+lEUTTGOfYA51uJO/DEnY6LrrIX2Qwxw==
X-Gm-Message-State: AOJu0Yyts/+CL324+E5u3G7AAyAJqs3zP5q/B6VnWL//i62CjMsv6raY
	UkzXxN6xw16HTJLUNFoC2yZGBWa3R4z7McMgQFkaGcXayDfdyUMA
X-Google-Smtp-Source: AGHT+IFfKEV6h5Gw0WJIq9oU8ZXTVVdJrpoffjn8gZvwWlpJ2sPuHTHLS00yMZSya2NF4n05nQWr6g==
X-Received: by 2002:a05:6870:f68b:b0:22b:5bc1:66e7 with SMTP id el11-20020a056870f68b00b0022b5bc166e7mr1384174oab.11.1711693325826;
        Thu, 28 Mar 2024 23:22:05 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id m40-20020a05683032a800b006e6bf2cc882sm521325ott.26.2024.03.28.23.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:22:05 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v13 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Fri, 29 Mar 2024 14:21:58 +0800
Message-Id: <f4934589ebc3a393c270bb9e5ab7493f57af3c38.1711692169.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711692169.git.unicorn_wang@outlook.com>
References: <cover.1711692169.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add clock generator node to device tree for SG2042, and enable clock for
uart.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 +++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 49 ++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 49b4b9c2c101..80cb017974d8 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -14,6 +14,18 @@ chosen {
 	};
 };
 
+&cgi_main {
+	clock-frequency = <25000000>;
+};
+
+&cgi_dpll0 {
+	clock-frequency = <25000000>;
+};
+
+&cgi_dpll1 {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 81fda312f988..8aab027cf730 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -4,8 +4,10 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
+#include <dt-bindings/clock/sophgo,sg2042-pll.h>
+#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-
 #include <dt-bindings/reset/sophgo,sg2042-reset.h>
 
 #include "sg2042-cpus.dtsi"
@@ -20,12 +22,54 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	cgi_main: oscillator0 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_main";
+		#clock-cells = <0>;
+	};
+
+	cgi_dpll0: oscillator1 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_dpll0";
+		#clock-cells = <0>;
+	};
+
+	cgi_dpll1: oscillator2 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_dpll1";
+		#clock-cells = <0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
+		pllclk: clock-controller@70300100c0 {
+			compatible = "sophgo,sg2042-pll";
+			reg = <0x70 0x300100c0 0x0 0x40>;
+			clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+			#clock-cells = <1>;
+		};
+
+		rpgate: clock-controller@7030010368 {
+			compatible = "sophgo,sg2042-rpgate";
+			reg = <0x70 0x30010368 0x0 0x98>;
+			clocks = <&clkgen GATE_CLK_RP_CPU_NORMAL>;
+			#clock-cells = <1>;
+		};
+
+		clkgen: clock-controller@7030012000 {
+			compatible = "sophgo,sg2042-clkgen";
+			reg = <0x70 0x30012000 0x0 0x1000>;
+			clocks = <&pllclk MPLL_CLK>,
+				 <&pllclk FPLL_CLK>,
+				 <&pllclk DPLL0_CLK>,
+				 <&pllclk DPLL1_CLK>;
+			#clock-cells = <1>;
+		};
+
 		clint_mswi: interrupt-controller@7094000000 {
 			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
 			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
@@ -341,6 +385,9 @@ uart0: serial@7040000000 {
 			interrupt-parent = <&intc>;
 			interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <500000000>;
+			clocks = <&clkgen GATE_CLK_UART_500M>,
+				 <&clkgen GATE_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			resets = <&rstgen RST_UART0>;
-- 
2.25.1


