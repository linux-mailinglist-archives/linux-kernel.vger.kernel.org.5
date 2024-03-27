Return-Path: <linux-kernel+bounces-120547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5206D88D934
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05991298A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF283612A;
	Wed, 27 Mar 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZcH2Bpi"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB82E63B;
	Wed, 27 Mar 2024 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528273; cv=none; b=dzty4ASNtYJt4Rs+My2sIQvhJfIAyvTqguEs8JqRqBFDyz6EfQWgWo6AXnjpvyF18ihik/FfLMz/RSoR53CYTe/joARH90ZH7Su8X/+ZXurwwD+ba1+l6aE0nwTNi8JTM24+aHWOwwMOe46Ur1FqQVNsMQWxOj22VHTs9hSZjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528273; c=relaxed/simple;
	bh=Kct7Pjk1WKf/K8JXQ51OPs2q82g4Vs270HKxVBz7YVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9boFSSwCp3pW6+dgwWGO46kKXZH34zGMfTN7iKzZrL2vHRTDscQ9rvlix/BfXxOkUjjdbikKPK13u8MsflZddwxq5lOrmziUvundpdQso6kZsRMw4EitloPMYomIX0/I8sI+uoANJVFgGJ9XNTh6GWfoNo+D69Dxgi6vzdp7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZcH2Bpi; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c3ceeb2d04so1592208b6e.1;
        Wed, 27 Mar 2024 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711528271; x=1712133071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPRTTnRNGB6MC8MgLxeQqBqXiKf58UGvbzByUZNl4Io=;
        b=RZcH2BpiX9/oa0eM66pGghAC141UrN859Fu2LWkHDWu//Em8OExtIwIjhrKz4cJMR2
         vEIVJpmus9kHAXUqSIzO+quiy3HGQpr3g3s1GWqPbMkccQ7zNiKsOzdyOYUZ9CpEvBOc
         13qFPL9Rocs9WDyQUv4BHPr6EvnEfuipszPHGEZyDrkLXMzqDUUHD5GHerWph+ue/c6b
         vHac050LTdeb+eYE7iFWAS3Qr4HyjvvOB31lPBpo1sB5BdlBf/Lyt6ETT+xM7ueuvLDN
         vt1Sfvph4XsdEAMpFaBo+oSJF+1HvmiGwrPlqmdogZaNZ/V7P4vnHRWmbCHBPwTlxdyu
         LoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528271; x=1712133071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPRTTnRNGB6MC8MgLxeQqBqXiKf58UGvbzByUZNl4Io=;
        b=N36OUGrCgYpj0Zl3BiqG3xKcEAlAnP4iqzXocwLmQy2p0JHp1V9PiLnDUM0due1lof
         rtMFaiInXDPVEqh4oQzXvV9b/bCkxC3k0ch1swbAD5ZngTgeStxheiI6yNnfXqb0KA1h
         8pnG2JhJ7LlB7zU3n1rf0wlI97LGR8CFSNvvZf4Jd+nAXya1pV/brSYC3nArwona8p4L
         9xnZPCVM75IZiwslhI1XwuKp2FcfvGnbeCUh0l+WZfvc29FXeIoJH3qxMBZJlbRhK4+6
         blvSGh6xzFSxZGKP/XywcCg4KlYw/4e4fk4FKWC9V+/ctj2jSAGPNlP+4KqMPk9TKiMZ
         VD/w==
X-Forwarded-Encrypted: i=1; AJvYcCWjgVt3778rfSFeCnPlqtoV5kXs5e0JIxupUbdnyjziPkucEkSVsU794M/300s8nvjwTH3MEl154q/G5IXWeBEBL3WFkEcvEYDmWnHEZw35e3ZYGzoVxV5M6oqSbcCnbezEq3jlFj1RxCM0b7RcML08BZhe+ZwiEzxZAOL2iCitiQ71Rg==
X-Gm-Message-State: AOJu0Yyeostq2q/9KcTuu2qINf/JxKU86UVlmEhPAJhiVHa98FNf96I2
	v1FP1IYWa9HWRnqcoYFF2Pl7vRfBsbZ2KTePa+jAjAtwfMRL7jy/
X-Google-Smtp-Source: AGHT+IGXMC8GI7EHqyzHdc2ep+bX1igihkpaRvHWPRxoLI04zdhk6t5Wq0ZlSdSHmAbGqcu5fH1TAQ==
X-Received: by 2002:a05:6808:6293:b0:3c3:cd2e:3074 with SMTP id du19-20020a056808629300b003c3cd2e3074mr4469638oib.26.1711528271233;
        Wed, 27 Mar 2024 01:31:11 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id m5-20020aca1e05000000b003c37b40b2easm1793335oic.48.2024.03.27.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:31:10 -0700 (PDT)
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
Subject: [PATCH v12 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Wed, 27 Mar 2024 16:31:03 +0800
Message-Id: <5d34a5ce93202463bd7b05ec2df93edc8fb1ef1b.1711527932.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711527932.git.unicorn_wang@outlook.com>
References: <cover.1711527932.git.unicorn_wang@outlook.com>
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


