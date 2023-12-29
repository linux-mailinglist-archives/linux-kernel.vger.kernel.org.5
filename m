Return-Path: <linux-kernel+bounces-13157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A782007B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918DE1F229C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CEF125CF;
	Fri, 29 Dec 2023 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M39wBIJQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E354125C2;
	Fri, 29 Dec 2023 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so8676604e87.3;
        Fri, 29 Dec 2023 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703866374; x=1704471174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uXclIxtXqPFsxy0XcvgnkjbTaVqZ7ItIisfYtSYDS1c=;
        b=M39wBIJQL2qmL4bqPoo2uP/yqMbZuoqhXXeB2IhBKdEKNq5RtR8Mtm+99Y/8GHsGTd
         8NK4DhGUYksv9ydbMAp33tz9IcrNLMVmMx1oH+O8v5E1Q2jkt+XBRMeloEdMTtsSZPWW
         m00s+deJ15CJP5y8nOiM+mJXPG7bCBZNyaCRqQvm+t08bOxx/byuJBI3Vx5OeyEPdXrT
         j3YvR/CNRCTjy7ypHNuNPHRWVICPWmLCtyIAO6LKTXY024qQvUr0vyCeXE1sckX4V05u
         eD46iwf+rQIDHovcge6dyDtyJRs3j8T540a0rwTiUcu8qTPI/23f8y8KQrys2NEYh681
         gGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703866374; x=1704471174;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXclIxtXqPFsxy0XcvgnkjbTaVqZ7ItIisfYtSYDS1c=;
        b=mAzOsV5IQHDysDlmjJES1B/yRYUByQgBS5R2NXriUuw6WoRREEc98fqiLexup3C9Bt
         NSPmcy1qg1lNtGUhBTzWZGap30OGuRlBfiu3PkMVBnA2AXvnxb/tbjsVWAY05yCjGbyo
         A6IQjprBijhi5dEdCdyafcqcvD+02dLtaTQfpDk6YwwJS9GFaM8/Z63g20hvmQ9lbzQH
         ra+wp23bzmBFiYY3cu2Pe+545OIHa0EjV+DDmcubXBhbpzX2JxwweQ17c/Vgz3Km2kCl
         QkFlrwaW90l4CzdOIOrQb2tbM7ly1cEucDoGCbT5rFopAXoSv28KfYzpDG/2SUzdOkc+
         kklQ==
X-Gm-Message-State: AOJu0YwUW0nFG98plzc4/mFCqAZQjzK4VjG+LiKNmymxciMOvWYi+9uZ
	YE82JrsCNNuF030L/B8elCU=
X-Google-Smtp-Source: AGHT+IEoFACccC5y4WSZ4NEC++5o3kSgCsgwMu9rljl0dlfSrV72atbmVicDlHhumYF13mACQU7ZcA==
X-Received: by 2002:a05:6512:3986:b0:50e:7f9d:18d8 with SMTP id j6-20020a056512398600b0050e7f9d18d8mr3277511lfu.85.1703866374196;
        Fri, 29 Dec 2023 08:12:54 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id az15-20020a170907904f00b00a26aa734349sm7988188ejc.39.2023.12.29.08.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 08:12:53 -0800 (PST)
Message-ID: <18c8c89a-9962-40f0-814f-81e2c420c957@gmail.com>
Date: Fri, 29 Dec 2023 17:12:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 2/2] arm64: dts: rockchip: add gpio-ranges property to gpio
 nodes
To: heiko@sntech.de
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, kever.yang@rock-chips.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <26007385-81dc-9961-05d5-8b9a0969d0b6@gmail.com>
Content-Language: en-US
In-Reply-To: <26007385-81dc-9961-05d5-8b9a0969d0b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add a gpio-ranges property to Rockchip gpio nodes similar to
rk356x/rk3588 to be independent from aliases and probe order.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---

Changed V3:
  reword
  remove rk356x part
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 +++++
 5 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index d0905515399b..27d045296388 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1394,6 +1394,7 @@ gpio0: gpio@ff040000 {
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0_PMU>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1406,6 +1407,7 @@ gpio1: gpio@ff250000 {
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1418,6 +1420,7 @@ gpio2: gpio@ff260000 {
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1430,6 +1433,7 @@ gpio3: gpio@ff270000 {
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index cfc0a87b5195..09fda512c101 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -804,6 +804,7 @@ gpio0: gpio@ff220000 {
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -815,6 +816,7 @@ gpio1: gpio@ff230000 {
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -826,6 +828,7 @@ gpio2: gpio@ff240000 {
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -837,6 +840,7 @@ gpio3: gpio@ff250000 {
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -848,6 +852,7 @@ gpio4: gpio@ff260000 {
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index fb5dcf6e9327..2cead2e85c07 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1058,6 +1058,7 @@ gpio0: gpio@ff210000 {
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1071,6 +1072,7 @@ gpio1: gpio@ff220000 {
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1084,6 +1086,7 @@ gpio2: gpio@ff230000 {
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1097,6 +1100,7 @@ gpio3: gpio@ff240000 {
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 62af0cb94839..2a017c862263 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -987,6 +987,7 @@ gpio0: gpio@ff750000 {
 			interrupts = <GIC_SPI 0x51 IRQ_TYPE_LEVEL_HIGH>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -1000,6 +1001,7 @@ gpio1: gpio@ff780000 {
 			interrupts = <GIC_SPI 0x52 IRQ_TYPE_LEVEL_HIGH>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -1013,6 +1015,7 @@ gpio2: gpio@ff790000 {
 			interrupts = <GIC_SPI 0x53 IRQ_TYPE_LEVEL_HIGH>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -1026,6 +1029,7 @@ gpio3: gpio@ff7a0000 {
 			interrupts = <GIC_SPI 0x54 IRQ_TYPE_LEVEL_HIGH>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 6e12c5a920ca..206f7d54d4d0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2138,6 +2138,7 @@ gpio0: gpio@ff720000 {
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -2151,6 +2152,7 @@ gpio1: gpio@ff730000 {
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -2164,6 +2166,7 @@ gpio2: gpio@ff780000 {
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -2177,6 +2180,7 @@ gpio3: gpio@ff788000 {
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -2190,6 +2194,7 @@ gpio4: gpio@ff790000 {
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
--
2.39.2


