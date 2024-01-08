Return-Path: <linux-kernel+bounces-19121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD882684B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893F71F21B66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5C9465;
	Mon,  8 Jan 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIjSVYyG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD859474;
	Mon,  8 Jan 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-204520717b3so1372265fac.0;
        Sun, 07 Jan 2024 22:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704696602; x=1705301402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK7rFBBfXgKkr6a1SrOgShSCoWN7R3rCy+5wKL2xaF0=;
        b=LIjSVYyGb31myOoxqSck9So0v9ZOio6YfeYp8Pc3ANPai/Vgg+vjJ1tLvbZm1hD6iM
         GDSI/kyF9c75pXQSwdbkVEhtbMPkf3e7j73aejELvaDNCswBpaxIFLsOIUH/m2vcpJxX
         xOaKoZPHM+QXVBNGorbd/ujUk5TXf3K3GFnR2+rjdWCDOa2Pn4w1mjeHAE1O+nf7m67Z
         0LgP+kRXqRhQczPh4VxU3g/DP9aYFk6qfRGEVGT8RxS6naj5dAiQP9G1lpYoYaGjLbnA
         3rsS+onMokD1v/r8hKp+VBir2ZOlz5tMYE2LjIRfkcIso7CfkWs3vfLKy6Pn09sm5gHM
         s4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704696602; x=1705301402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PK7rFBBfXgKkr6a1SrOgShSCoWN7R3rCy+5wKL2xaF0=;
        b=BYnJOh0t3//hPYsF3WPkiEBwnfjk/T8M8Q6tWRB/N4w9DgmOpRlB6R2Tp7tre4JCq/
         cI6LNrUayKWhMTkGvoRWwXmBPLd9SZ4huD7XA0ukmwAKn5OLpAPX56NTcMOjScljt6sA
         NPX3OI99umNrdSYUNNiAw65uUv8nML3tXNH+fnG6iLaq4B66A3tJDNKefCG67VFPNDcT
         kKpNwPzJ3S47WVCHW6kTs18KHoS/KEkXvEVxkJZEPwamXmX0EldP+ap89w3Q4t5SIzxj
         /0qwGuNZEVT21+fth3XIj2eynI1m3TozDYBaS6GEX5Z+jSk0ZDWE0OgGpAkrkisNIoQ9
         dIRw==
X-Gm-Message-State: AOJu0Yyf2dPkS2RGwY/TLPhLAOce7QZSSD5JnMJ9O3PbWwAvxs6Z3SjF
	To6XIHmHt7d6jzZdXWzIhIY=
X-Google-Smtp-Source: AGHT+IFTdFMRuz/SQJG/sod7IGjWs8IgoYHcIo0BMp9OVvd7RzaZctPz1Ug/WzRhWHrcnlTk97fofw==
X-Received: by 2002:a05:6870:3d8c:b0:205:c5c3:7a5d with SMTP id lm12-20020a0568703d8c00b00205c5c37a5dmr4937937oab.31.1704696601858;
        Sun, 07 Jan 2024 22:50:01 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id s19-20020a05683004d300b006dbf6784271sm1282994otd.75.2024.01.07.22.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:50:01 -0800 (PST)
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
Subject: [PATCH v7 4/4] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Mon,  8 Jan 2024 14:49:53 +0800
Message-Id: <25650372c373b15309cd9f3822306838e556d3c7.1704694903.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704694903.git.unicorn_wang@outlook.com>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
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
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  4 ++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 23 +++++++++++++++++++
 2 files changed, 27 insertions(+)

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
index 93256540d078..c9616d111905 100644
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
@@ -311,12 +318,28 @@ intc: interrupt-controller@7090000000 {
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


