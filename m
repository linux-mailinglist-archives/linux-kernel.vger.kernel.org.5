Return-Path: <linux-kernel+bounces-49300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B909284685D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346071F22839
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0E1865B;
	Fri,  2 Feb 2024 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWlYgLX6"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6218635;
	Fri,  2 Feb 2024 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856186; cv=none; b=pbunB/hppL+8cntgddqFL1ky4j0WjdQRidldxnJp2/e1rMEvOjKgPCwPbl0I5Z1Aqtp7ndbX8ZIX7HuUWy3fcBUYVwQ4k6dOcSkWPtQbde6kS9839qJnk4fIydfy8zk6allQ4i2uvcR61lhR5nQTd20OrSdw/DMmFH0bGVWZL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856186; c=relaxed/simple;
	bh=u3L/t25hSxI8r3lIflWodO5iFF9bpJmEaOR9QAr2m9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCFlD9++YGsIhBO+dtRmViowZDfd65Uvsyot/Cxp3frO+YMqM9NtbUBTlP+V5CoOKPN9A8O4lgnlotftoVbyr6lxndh07vHlcrPq6KOof8bZttRbBhNjMAwRmDOXrqrmRBepnpprTe7cYT7XzbnWN/NSx1sU6lo+zb9eQvU0OBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWlYgLX6; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e1352dd653so1091661a34.2;
        Thu, 01 Feb 2024 22:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706856184; x=1707460984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW7ioWygsib3qTGH3bCtwZFbfdrDyw7qBL154vPbYOU=;
        b=EWlYgLX6VYLKel1/rpi1T4W6PIpPLHgHRJOGRY/yhcTPDs1Lcb6TEBDao2LOwDKz8R
         kIAyVN1+CkYxdt46g2k16EKis+e4FZ/RjVTcDCixouIoKihL9NvuV4i+k+qoljLlVlux
         tNai/V7SLh3t+1hQaoZT8Po7awgPJHOF3E5QTzX2LKXyBw3Yv+UBmFzdZpTZVNTT4dKG
         36IurewKxkd3/3NAzi5KWQ40EeLFF95KgrnqpWt29/A8QJ4gXHAkagVOllavUs3qo71X
         ySiW2E3Ila++b+4Q5Qq2h0ferLOwM0JXPTGn4LQSqRkyiQpGSeJYjd+sp3BhWzuqdzSf
         VrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856184; x=1707460984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW7ioWygsib3qTGH3bCtwZFbfdrDyw7qBL154vPbYOU=;
        b=Ss7JXXHasRHLxKzlFl7ZjJq74umN9nh2bScC0YklM5+4v6aX2yNgTt8vRqrS8aZieQ
         fpYqeThc3CBGBpDZgQDnahbTwIvLk4LjuLeI6Vp6LLySZqqwOogZDNlmj0VsLmSd5AhH
         tIB8eXTjl1QPV3yDQwN9H0zcJXqYzcyVIr1D5hLbPF8lqLnOoP2L37j084Q7h5MVbJwC
         ko0QucGTVWMoZp86BeFGGK4BwGONLav30Hu7hmCLnvwrPhuPZK4vjKPRx+vGIsfHmMtf
         WWuDo0KNpMdaLMbguBMG7XaenLIJXV84N5wTUPCSQPRgb7Lt3HmSZPgy/Sus9OUz1NP2
         wm5A==
X-Gm-Message-State: AOJu0Yw6cunDetp046sqTuzTA4LZStuig9jMNarmTMSzY5F5UGRVy7FZ
	2kVPB2ozM1pSnOVlKaI+mBAYJlcEkPfKyG8PuQGqOKrYEG+NLRmh
X-Google-Smtp-Source: AGHT+IEZS7LpY55EN479CaW9byfcrn8q3PFeWPPALesksVI+uPsKgcQAI6MDDGRLkQvFwDr2sJ5+0g==
X-Received: by 2002:a9d:7747:0:b0:6e1:1437:8a45 with SMTP id t7-20020a9d7747000000b006e114378a45mr1116187otl.16.1706856184002;
        Thu, 01 Feb 2024 22:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4R0qDFeaJy982qi5eiCQC391aH5Ffpz/+ineKapBilqeevjYTAitfeFBMTjPa+gvB1EsA3lO9IDA5scj1w2ZHotBHONco0z8Hs3Tpciz7GZBBWBz+vWFxKDr6MEelmjZ9OZcKJlVkO/RBAUS8/D0RyHI1qO7LPjYkYuoWUeODjh8gBmVnCmBt8dG9TI8XWyZy2gr6Ys4Phg9He7ULmDT8+vuQ+gupoT8KNvptVFvaF1by7WIGL2bqb6nCTlx1vUxnJGXOWMvQIssiiVHqGDshYrvuiKmObj4u6NoD8euyrvd5pBY1oxdoPmXG7mR0jQWS2fd1FILhYg2vLkHFHIbPaaxDiDxfJMFEGvnF8jcJAftwPbUedkeElpvN79AHJUjhyB+3R/qDbdbGSH0bGzTMvxOapOjoyQ2auOiTsERY+Phdx2vuka3w0bcRwgGQwKtNYPyeNvW7QD9fNVlDf+l3jDr9JgkIcVzeycgqyS7ngBDE0CmSqWt3okOZT4R9LUjY/ySiJvd5m+0VaqA0+e0ymG2+MBTyq6gEUiKO26QmSeCaoQiKQD94SKZDbBeJrUXHqlwD4Rv6XJUh9yN8hhFkq5tdrZqr7x4Z4s9Qk9yv8XwabgxykqKxlN8OGuxH5DC2I58t9wHae2syY+Qnsrb+XkxkKK5C/klvjdflv4fAk2Q=
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id q24-20020a05683022d800b006e1116e5169sm278807otc.7.2024.02.01.22.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:43:03 -0800 (PST)
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
Subject: [PATCH v9 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Fri,  2 Feb 2024 14:42:56 +0800
Message-Id: <dff0beff331dcc4e0d46175787f045064f8bcbc9.1706854074.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706854074.git.unicorn_wang@outlook.com>
References: <cover.1706854074.git.unicorn_wang@outlook.com>
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
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 ++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 41 +++++++++++++++++++
 2 files changed, 53 insertions(+)

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
index ead1cc35d88b..d83b6a01fbd9 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
 
 #include "sg2042-cpus.dtsi"
 
@@ -18,12 +19,49 @@ aliases {
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
+			#clock-cells = <1>;
+		};
+
+		clkgen: clock-controller@7030012000 {
+			compatible = "sophgo,sg2042-clkgen";
+			reg = <0x70 0x30012000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		clint_mswi: interrupt-controller@7094000000 {
 			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
 			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
@@ -333,6 +371,9 @@ uart0: serial@7040000000 {
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


