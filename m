Return-Path: <linux-kernel+bounces-13156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AF0820079
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B0D1C2173F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE29125C2;
	Fri, 29 Dec 2023 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFeMU1CJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512C125BD;
	Fri, 29 Dec 2023 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2772011f8dso136203066b.2;
        Fri, 29 Dec 2023 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703866319; x=1704471119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YghuGF2un/ZZxnFMyhWAtmWnspGiZfAjoU/WXmr+UHs=;
        b=jFeMU1CJMeQYBalaiEfo2pONyes4/P/kTqdU0Kzc/9sXYnY2nm3OPJ7nbQtk4lUjrC
         OyqAjBx9bxcKpcUYY2fUcxZdtzp7hBq9Bfq7ukdNenBvSsWboB6EOWuEQI8XSzeRGB0F
         eWVHljkCZ+FH2LoYC1Z4U52ZB9fP0QZU+7XD5N3PDAhR258pILI4UzjG8ylQaCl+1ksM
         PjyaP5WP4x1BJcl7UcYaXaN6X9B+wf+0f5gmh8U2SnqWqdKoALeXzCbE7M1z0mgiGht/
         FToxM5wo5Ql0AlgC4o4NMwkInwYJoMZ+yIyvE/o365QcDYrQ+rUj73/QGE170urID4CY
         ftRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703866319; x=1704471119;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YghuGF2un/ZZxnFMyhWAtmWnspGiZfAjoU/WXmr+UHs=;
        b=N2n2o3r3I71EbRbD8Nf7ASE904ot6cpNZ08RDU6aaze8Gpv7Ku6BQhZuBScBtELwNL
         EnLPEBRoG0ID4nhG/3ijGwitidzTI85K8w12rqnWuYuDOJeGMpB/n6kOVpf9spY8HunP
         FiRY351YjrlLGJZIOPl7cBhiewmDPL1GwstFx2ReXU6gx258AZueQ8qzo1uawrcsoO7C
         TvjTecpOqCg7ASddj62yfzqCIYZbhOkSKWesoSqjv+MgOf6fs+GM1cDjVa1X6kJ8QWH+
         6QFC4Mr0XVpA+8940h6kZT4iyDrMFX21HGRS+in2KbO5c4tCN53pKXO4yJF2/PGYyFfS
         WdQA==
X-Gm-Message-State: AOJu0YyQKSGP7AF09mNEt5VboEsUy4nhEP8LD2T1sQaTdrgAH1Ba8YWH
	gYNXxMQnMIqUnWSZOZL19Ms=
X-Google-Smtp-Source: AGHT+IFbw8fLN6HRHfvS0H7TQb761VLpKKwaXVrxZyVxP/ZjtXWG7x1XLSjCfKJ8kXqBm2QRvNxywQ==
X-Received: by 2002:a17:906:1ecf:b0:a27:32aa:2dda with SMTP id m15-20020a1709061ecf00b00a2732aa2ddamr2543165ejj.96.1703866319512;
        Fri, 29 Dec 2023 08:11:59 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id fv14-20020a170907508e00b00a269f8e8869sm8417096ejc.128.2023.12.29.08.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 08:11:58 -0800 (PST)
Message-ID: <26007385-81dc-9961-05d5-8b9a0969d0b6@gmail.com>
Date: Fri, 29 Dec 2023 17:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 1/2] ARM: dts: rockchip: add gpio-ranges property to gpio
 nodes
To: heiko@sntech.de
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, kever.yang@rock-chips.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add a gpio-ranges property to Rockchip gpio nodes similar to
rk356x/rk3588 to be independent from aliases and probe order.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---

Changed V4:
  change number of pins for rk3066,rk3288 and rv1126 (Jonas)

Changed V3:
  reword
  rebase to new rockchip directory
  remove unknown properties
---
 arch/arm/boot/dts/rockchip/rk3036.dtsi  | 3 +++
 arch/arm/boot/dts/rockchip/rk3066a.dtsi | 6 ++++++
 arch/arm/boot/dts/rockchip/rk3128.dtsi  | 4 ++++
 arch/arm/boot/dts/rockchip/rk3188.dtsi  | 4 ++++
 arch/arm/boot/dts/rockchip/rk322x.dtsi  | 4 ++++
 arch/arm/boot/dts/rockchip/rk3288.dtsi  | 9 +++++++++
 arch/arm/boot/dts/rockchip/rv1108.dtsi  | 4 ++++
 arch/arm/boot/dts/rockchip/rv1126.dtsi  | 5 +++++
 8 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 2b00109bea6a..6e5028b6dbfa 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -593,6 +593,7 @@ gpio0: gpio@2007c000 {
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -606,6 +607,7 @@ gpio1: gpio@20080000 {
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -619,6 +621,7 @@ gpio2: gpio@20084000 {
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rockchip/rk3066a.dtsi b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
index 30139f21de64..9a8603b34fa2 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
@@ -285,6 +285,7 @@ gpio0: gpio@20034000 {
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -298,6 +299,7 @@ gpio1: gpio@2003c000 {
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -311,6 +313,7 @@ gpio2: gpio@2003e000 {
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -324,6 +327,7 @@ gpio3: gpio@20080000 {
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -337,6 +341,7 @@ gpio4: gpio@20084000 {
 			clocks = <&cru PCLK_GPIO4>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -350,6 +355,7 @@ gpio6: gpio@2000a000 {
 			clocks = <&cru PCLK_GPIO6>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 192 16>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index e2264c40b924..d66fcf12032e 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -712,6 +712,7 @@ gpio0: gpio@2007c000 {
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -723,6 +724,7 @@ gpio1: gpio@20080000 {
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -734,6 +736,7 @@ gpio2: gpio@20084000 {
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -745,6 +748,7 @@ gpio3: gpio@20088000 {
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/rockchip/rk3188.dtsi b/arch/arm/boot/dts/rockchip/rk3188.dtsi
index 44b54af0bbf9..6677e4a10e5d 100644
--- a/arch/arm/boot/dts/rockchip/rk3188.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3188.dtsi
@@ -231,6 +231,7 @@ gpio0: gpio@2000a000 {
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -244,6 +245,7 @@ gpio1: gpio@2003c000 {
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -257,6 +259,7 @@ gpio2: gpio@2003e000 {
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -270,6 +273,7 @@ gpio3: gpio@20080000 {
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
index 831561fc1814..0d4f9957b99b 100644
--- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
@@ -959,6 +959,7 @@ gpio0: gpio@11110000 {
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -972,6 +973,7 @@ gpio1: gpio@11120000 {
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -985,6 +987,7 @@ gpio2: gpio@11130000 {
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -998,6 +1001,7 @@ gpio3: gpio@11140000 {
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index ead343dc3df1..7116399461c8 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -1461,6 +1461,7 @@ gpio0: gpio@ff750000 {
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 24>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1474,6 +1475,7 @@ gpio1: gpio@ff780000 {
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1487,6 +1489,7 @@ gpio2: gpio@ff790000 {
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1500,6 +1503,7 @@ gpio3: gpio@ff7a0000 {
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1513,6 +1517,7 @@ gpio4: gpio@ff7b0000 {
 			clocks = <&cru PCLK_GPIO4>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1526,6 +1531,7 @@ gpio5: gpio@ff7c0000 {
 			clocks = <&cru PCLK_GPIO5>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 160 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1539,6 +1545,7 @@ gpio6: gpio@ff7d0000 {
 			clocks = <&cru PCLK_GPIO6>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 192 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1552,6 +1559,7 @@ gpio7: gpio@ff7e0000 {
 			clocks = <&cru PCLK_GPIO7>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 224 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1565,6 +1573,7 @@ gpio8: gpio@ff7f0000 {
 			clocks = <&cru PCLK_GPIO8>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 256 16>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rockchip/rv1108.dtsi b/arch/arm/boot/dts/rockchip/rv1108.dtsi
index abf3006f0a84..d12b97ee7588 100644
--- a/arch/arm/boot/dts/rockchip/rv1108.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1108.dtsi
@@ -602,6 +602,7 @@ gpio0: gpio@20030000 {
 			clocks = <&cru PCLK_GPIO0_PMU>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -615,6 +616,7 @@ gpio1: gpio@10310000 {
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -628,6 +630,7 @@ gpio2: gpio@10320000 {
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -641,6 +644,7 @@ gpio3: gpio@10330000 {
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rockchip/rv1126.dtsi b/arch/arm/boot/dts/rockchip/rv1126.dtsi
index bb603cae13df..cf58cca4f09e 100644
--- a/arch/arm/boot/dts/rockchip/rv1126.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126.dtsi
@@ -569,6 +569,7 @@ gpio0: gpio@ff460000 {
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -580,6 +581,7 @@ gpio1: gpio@ff620000 {
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -591,6 +593,7 @@ gpio2: gpio@ff630000 {
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -602,6 +605,7 @@ gpio3: gpio@ff640000 {
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -613,6 +617,7 @@ gpio4: gpio@ff650000 {
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 2>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
--
2.39.2


