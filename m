Return-Path: <linux-kernel+bounces-72154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E3785B01A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBDC28444A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FBF2556C;
	Tue, 20 Feb 2024 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzNHJbbd"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7D20DD9;
	Tue, 20 Feb 2024 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389736; cv=none; b=f9hbKK5XbQD3/bpPRySheOCUotjuHH27OLgEoyrF2p9craSDuGuxOBBh7sRmoFwJ3hRCa1StcpTBZgAZc8NHKK+Xh4whiam9HDjopd1k1NAcLqGPA129QkBwaqRKkxuczIGuGtotBNQ1CLlJvEI4MKDr/THwdOh8YW45yqiSnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389736; c=relaxed/simple;
	bh=VyizzXBnuSh2yCZo5Q9pqxckyk6aljdMhXbyB44HoPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BzG0jNKMIJBMc37ECevNFXqFa9N3u7NYz0nZX5EFiWyMKg8Gb3nGYT5Ol28/PdRabwzPpxd8Vrt3/YJiFNPSr5Rwctf8vz5v0gh5M5mrlazcPcUc3Ykdy/BEN2SIylcX7d6oEkb9gygB5JwwrL2oXBRbWK5C3xOLYbBh76MDd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzNHJbbd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da9c834646so4419974b3a.3;
        Mon, 19 Feb 2024 16:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708389734; x=1708994534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URtUqdMbVJrpdv6ULH02uflW1yxi0rUp9KzQmw/RnEI=;
        b=DzNHJbbdIDrtbDCRVJtnGrDybzCuKpSRiVp3hRtZJnpVbYwY/GiNorHodnLrF6iB8E
         0CCw+LF3Rx20VFl5LQMXV3XQ+MyyFy/t1gqS5t9cWUP04krxJz0W6jK1+Dk0bDLb6OT+
         /tRnY/vpg/GW3R3h8J3D4nQ5kRtG8jQ7AtVzX8BiYmx0LGu+Srwmma5i1bKZdBaUJL5B
         VL1zK7JvlMARUQpEpLmfk6PNuYPflyYg5B74GnCkewGQevAhkbPD6fZkkMVG1rL9WdNN
         lukDC91y/hG+r99UnrPxfbXOUOfgQQje8BVYBfAP8mlT/+aalt3azzPi9I3uQ4Sl0t2J
         BRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708389734; x=1708994534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URtUqdMbVJrpdv6ULH02uflW1yxi0rUp9KzQmw/RnEI=;
        b=oTasJ6rID2WYsfOIpoBr/tErQOTka/6dXL3wEct/lGgfHS5BLxc/0KqziWB73ykHNg
         fO4F2jCNYhvUS6RoxlQogpalcNd/nahPb8cMh7/iWHgJh7esTHA5Haz/MHscEG/D/nhV
         zRZ5IewJe66L0fRnZJZZRSYDKbmx4Sqzdkb+NI7fC03PzcOr5tpXZ8/v6YHBJa8qkZrn
         qRZG5WOnQ4p3/ZQylznYBslVGYgdoKLBhrXbFXKydxUEKUdYw8JodOY3UvrUtR6Nmhq1
         f5iLJffvxuIJeN8VoL5Zfnzp2HWm09qLkDxyh76MIpzBuomEBqPYf6BZBVNwIlR2RPog
         FCcA==
X-Forwarded-Encrypted: i=1; AJvYcCU4iAiwko7Y65vLOBMCtDtPOiZVOCJyEtCJ6blgrzAUi68NMAeffRtAoE6ibS8SJNg2GQ0/lQ3ilflYtU70agqNYHzNKlxRCWxbpEoBfhGHvmaE991W713eHzIqbra7QcHzENW9WarCQUpU6FliAgS25RhVE88S2ZS0Bw43KoyCbDZzgSo=
X-Gm-Message-State: AOJu0YxWVKCr0kVyQDXWQ9H2UqUfEmP840em674pK/zkccyz91o+UY6e
	OjM6YOzlVJwrDB7fBoSGoFlRrkH9MzDNmTGIMMgk+tr4DbXQ2XCe
X-Google-Smtp-Source: AGHT+IGkO4CHLLeIPEllI4qCU/Nqkwfv/Bv4RBGJGwGk1My7/pwWO3OLeP9veCb9fxjTOo6ZZ8KaLA==
X-Received: by 2002:a05:6a20:6f07:b0:1a0:a1f6:19a8 with SMTP id gt7-20020a056a206f0700b001a0a1f619a8mr6387253pzb.27.1708389733694;
        Mon, 19 Feb 2024 16:42:13 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id cz3-20020a17090ad44300b00299bf19e872sm1831393pjb.44.2024.02.19.16.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 16:42:13 -0800 (PST)
From: Jacky Huang <ychuang570808@gmail.com>
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: [PATCH v5 3/4] arm64: dts: nuvoton: Add pinctrl support for ma35d1
Date: Tue, 20 Feb 2024 00:41:58 +0000
Message-Id: <20240220004159.1580108-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220004159.1580108-1-ychuang570808@gmail.com>
References: <20240220004159.1580108-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Add 'pinctrl' node and 'gpioa' ~ 'gpion' nodes to the dtsi of ma35d1
SoC and describe default pin configurations.

Enable all UART nodes presented on som and iot boards, and add pinctrl
function settings to these nodes.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  80 +++++++++-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  83 +++++++++-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 150 +++++++++++++++++-
 3 files changed, 304 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index b89e2be6abae..9482bec1aa57 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -14,6 +14,10 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		serial10 = &uart10;
+		serial12 = &uart12;
+		serial13 = &uart13;
+		serial14 = &uart14;
 	};
 
 	chosen {
@@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &clk {
 	assigned-clocks = <&clk CAPLL>,
 			  <&clk DDRPLL>,
@@ -54,3 +54,75 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart-grp {
+		pinctrl_uart0: uart0-pins {
+			nuvoton,pins = <4 14 1>,
+				       <4 15 1>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart10: uart10-pins {
+			nuvoton,pins = <7 4 2>,
+				       <7 5 2>,
+				       <7 6 2>,
+				       <7 7 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart12: uart12-pins {
+			nuvoton,pins = <2 13 2>,
+				       <2 14 2>,
+				       <2 15 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart13: uart13-pins {
+			nuvoton,pins = <7 12 3>,
+				       <7 13 3>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart14: uart14-pins {
+			nuvoton,pins = <7 14 2>,
+				       <7 15 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart10 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart10>;
+	status = "okay";
+};
+
+&uart12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart12>;
+	status = "okay";
+};
+
+&uart13 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart13>;
+	status = "okay";
+};
+
+&uart14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart14>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index a1ebddecb7f8..f6f20a17e501 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -14,6 +14,10 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		serial11 = &uart11;
+		serial12 = &uart12;
+		serial14 = &uart14;
+		serial16 = &uart16;
 	};
 
 	chosen {
@@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &clk {
 	assigned-clocks = <&clk CAPLL>,
 			  <&clk DDRPLL>,
@@ -54,3 +54,78 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart-grp {
+		pinctrl_uart0: uart0-pins {
+			nuvoton,pins = <4 14 1>,
+				       <4 15 1>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart11: uart11-pins {
+			nuvoton,pins = <11 0 2>,
+				       <11 1 2>,
+				       <11 2 2>,
+				       <11 3 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart12: uart12-pins {
+			nuvoton,pins = <8 1 2>,
+				       <8 2 2>,
+				       <8 3 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart14: uart14-pins {
+			nuvoton,pins = <8 5 2>,
+				       <8 6 2>,
+				       <8 7 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart16: uart16-pins {
+			nuvoton,pins = <10 0 2>,
+				       <10 1 2>,
+				       <10 2 2>,
+				       <10 3 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart11 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart11>;
+	status = "okay";
+};
+
+&uart12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart12>;
+	status = "okay";
+};
+
+&uart14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart14>;
+	status = "okay";
+};
+
+&uart16 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart16>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 781cdae566a0..5f366f4c7fde 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -83,7 +83,7 @@ soc {
 		ranges;
 
 		sys: system-management@40460000 {
-			compatible = "nuvoton,ma35d1-reset";
+			compatible = "nuvoton,ma35d1-reset", "syscon";
 			reg = <0x0 0x40460000 0x0 0x200>;
 			#reset-cells = <1>;
 		};
@@ -95,6 +95,154 @@ clk: clock-controller@40460200 {
 			clocks = <&clk_hxt>;
 		};
 
+		pinctrl: pinctrl@40040000 {
+			compatible = "nuvoton,ma35d1-pinctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			nuvoton,sys = <&sys>;
+			ranges = <0x0 0x0 0x40040000 0xc00>;
+
+			gpioa: gpio@0 {
+				reg = <0x0 0x40>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPA_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiob: gpio@40 {
+				reg = <0x40 0x40>;
+				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPB_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioc: gpio@80 {
+				reg = <0x80 0x40>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPC_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiod: gpio@c0 {
+				reg = <0xc0 0x40>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPD_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioe: gpio@100 {
+				reg = <0x100 0x40>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPE_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiof: gpio@140 {
+				reg = <0x140 0x40>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPF_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiog: gpio@180 {
+				reg = <0x180 0x40>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPG_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioh: gpio@1c0 {
+				reg = <0x1c0 0x40>;
+				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPH_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioi: gpio@200 {
+				reg = <0x200 0x40>;
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPI_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioj: gpio@240 {
+				reg = <0x240 0x40>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPJ_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiok: gpio@280 {
+				reg = <0x280 0x40>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPK_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiol: gpio@2c0 {
+				reg = <0x2c0 0x40>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPL_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiom: gpio@300 {
+				reg = <0x300 0x40>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPM_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpion: gpio@340 {
+				reg = <0x340 0x40>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPN_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+
 		uart0: serial@40700000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40700000 0x0 0x100>;
-- 
2.34.1


