Return-Path: <linux-kernel+bounces-144665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A515F8A48F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA36284B78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBB0286AD;
	Mon, 15 Apr 2024 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z37LUiSv"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBCC2C1B4;
	Mon, 15 Apr 2024 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165840; cv=none; b=otN3rEojVpr7TadT5PUHhOxoZdJoXovY4fqB0etUQk4WqpZvCQYTpPpNffK//IwDLWU+Qb7LgJfcZlQ5iHv402ohp83i4Ko5/7P0BPDd+a3FlrrF+HBP79ao/rRyM09KjcI+zOj1Bkh8NZBXQZmnTB5SYB7Qy/Snk5SHOeBcwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165840; c=relaxed/simple;
	bh=Kct7Pjk1WKf/K8JXQ51OPs2q82g4Vs270HKxVBz7YVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWiHO0TaN5nHp8P0SYRD4nfB1YDgdq8S8HZLwKWafIJniKrZFpDlNbaud5rzTvIv0nRC9K44yjAFSbDTL91X0V7xNjnNAdzcedvNEGcotCYQxTzWGdqT1tDslCiMyxK+lo1dVhq6arEC415TbU+p88xFFRZqwVF8mdARx/SQ8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z37LUiSv; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ea2ac4607aso1498227a34.3;
        Mon, 15 Apr 2024 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713165838; x=1713770638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPRTTnRNGB6MC8MgLxeQqBqXiKf58UGvbzByUZNl4Io=;
        b=Z37LUiSvrC4/v+Nxx7oQ8h67uALywtz0aWgsP5xsLLskmlaAxRyZOnFnKy+2BvmMDi
         dDLdpQ6ZeG6IHGroej7/kXv80MFZecr12xCpsfgns+VrHDUM30/lnb6smjzsu60qKIEP
         hMt3Qu+QTsaucGN8KAKbXjaD8bbEaYjDUpoieMuMi9/yBhTWf8QRc6nBq/giVJWwUace
         Sxxu0O5TcrpgOoO3oi8l4c96F4LR7CORjaGRikFkhsfLUSdQ1RrVI08ydg+s5+oODO9F
         oEcwgO/YSPT9mPuCaZfpoPP5znplqEvmqZ3MUuAGJNJVx4USpamzvMezPG9MYmI5VoL5
         BEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165838; x=1713770638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPRTTnRNGB6MC8MgLxeQqBqXiKf58UGvbzByUZNl4Io=;
        b=ecJaIjf7Vskx4sli/8WYlNJM3xRp3fzIKYYLRzxhdYHchAobfZqraWvPFqcjXEn5S0
         Dr29izA60dVLdxLW3sILZgS48Gxx81aPaSm0D7dHuNvGiQBVfCl6ejmFQDIsGTUQjCq7
         uDqWcL0OzLg2pMOz7phrpX8gBgiqiYwDvRkjNg2YAjb0NpC6h9AVMpE5GXNjjdYf8pww
         yy2bWDg2sDh5ao6JJDlBWYMxqdE0S7QpF4rhPmS9IRI/pa//xPmJjtJBiGoQcLZYLgBi
         zEKt9nTcFnuij8SUPzmHz2FokmG6nd6e4wAQMWmUbgUGx5s7MrrGXOaQob65nU5oosH9
         7ecw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9BHCK+wrZM+avLh2razsOm4S1pukUdU8jBobV90fhLi/T7+Tr0pIm1men3y5Tacx0s9gd6C9CYUB87pS02k4oriNlMuNXq6mHrSR6DDMnU4JzsO0TOAZjdslRnN3coiUizhsWCqGKqQdm/Fb3pAtWOMmQa28B2AJh3J/SYtGA3EOwQ==
X-Gm-Message-State: AOJu0Yxz1xBdPmYkWvnkYU8s3rBWuXCQijYrQd0IHWuzFbWWHLd2lH0n
	pTBXBdZysRtnrXQIOEkX9B2cUogn1wZEqfu6KmLLA/KJeBxcN6z7
X-Google-Smtp-Source: AGHT+IGpiBBC2cEu8GRBC8tpHfBybNg/WOBaHwzCJMcCDFu3ggw2rTC6WE2uAyi3jpLUgBGTX0hePw==
X-Received: by 2002:a05:6808:2a7c:b0:3c7:a9b:74c2 with SMTP id fu28-20020a0568082a7c00b003c70a9b74c2mr2995368oib.5.1713165837810;
        Mon, 15 Apr 2024 00:23:57 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id ku4-20020a056808708400b003c718601b81sm105519oib.8.2024.04.15.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:23:55 -0700 (PDT)
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
Subject: [PATCH v14 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Mon, 15 Apr 2024 15:23:49 +0800
Message-Id: <ffb589094e3a111dfbf1c8961e9d3f328d2b9fde.1713164546.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713164546.git.unicorn_wang@outlook.com>
References: <cover.1713164546.git.unicorn_wang@outlook.com>
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


