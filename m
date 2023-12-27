Return-Path: <linux-kernel+bounces-12213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D767B81F16A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072361C22623
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692491E4AF;
	Wed, 27 Dec 2023 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAV6pBi+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90001E51A;
	Wed, 27 Dec 2023 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so6582064e87.3;
        Wed, 27 Dec 2023 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703701994; x=1704306794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcB4NJ++6ivEoEqudtqQR5JbTA38RP1iyGIjkEFmlyM=;
        b=iAV6pBi+wVeuZ2NWZise38KVvU/xNgxHDcmwG29VjloNZjyR3MMDIfHT3mx2t9PT7k
         PGysuxF/ndTDSlcfXV2UNfaX/YTz5KRWMsjWuMIu2h6ba4D1/mY8VUknzL/0XXjmoQNu
         o7h8jBYlsoLSy63lKsLOXIkFB3L4yPTvVBdiUeMb2VuolZOw76N7nds4LkEJPY1hD9gi
         uwCkhz8joze/t57LJEJiDhsY6pNWsdImkWCTAvDrB51gH9l0prE0iHNDNHBZ2l9S7sJK
         Nx0G/6fkBTNmi2KSDsFqr5T+hlz2OzvJ1idBQ8rQmwcNUulwOrkvHuW+9Oa5lTotN85D
         Ed3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703701994; x=1704306794;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YcB4NJ++6ivEoEqudtqQR5JbTA38RP1iyGIjkEFmlyM=;
        b=PVxCHIllfQURpaqufdmMTDJkayFvQVsukU82T6b9btM7zPPZ30sArsQEaazCxbOJR4
         SBK5Vvr5X0FSDl3qKnmQDRSS5mJdb2MSeTjn5RYFMUassbi0jKkrQxKF7Uaf4ZcxhZhv
         MBZFVr0Nth/EXtSLCBSXUh9+8D8Ygn710jAyn831shAzn9EMCjoMMyxc9hseNP8CjZTW
         2KVJ9x7izvqWo72CPjaryLAZc0LCQlHNlM9ZfUSKv6muNoQzcL8btu+jn8LgAXlngx7D
         E9ULd9/7slUJNBzSIuZxAAtszOgCzWcHaNa7f/N96J3YITqH6CA3n6NDsdBGQYoJ7Tne
         yxVA==
X-Gm-Message-State: AOJu0Yzla2Fke1E7nZfofcDr1FRmjmqaTzlR3h00vY6TFUYbdOJEzPCY
	KIxEH+D6bF8lnji2IhTc/0qNnZ/b4vo=
X-Google-Smtp-Source: AGHT+IFSNsBKPUr/NhV+zV1c306HqKssI4Rth1kOS8IiF405rbm7OZgCXi2lAoe7ncNyy2RtxZX9bA==
X-Received: by 2002:ac2:5eda:0:b0:50e:7b04:7bc9 with SMTP id d26-20020ac25eda000000b0050e7b047bc9mr1864156lfq.23.1703701993432;
        Wed, 27 Dec 2023 10:33:13 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090791cf00b00a1db76f99c8sm6816319ejz.93.2023.12.27.10.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 10:33:12 -0800 (PST)
Message-ID: <cf46c685-bf4b-63b5-0373-dd0ba70e9700@gmail.com>
Date: Wed, 27 Dec 2023 19:33:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 1/2] ARM: dts: rockchip: add gpio-ranges property to gpio
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

Changed V3:
  reword
  rebase to new Rockchip directory
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
index 30139f21de64..a4962b6b3f4c 100644
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
+			gpio-ranges = <&pinctrl 0 192 32>;
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
index ead343dc3df1..c5550aae4ed8 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -1461,6 +1461,7 @@ gpio0: gpio@ff750000 {
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
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
+			gpio-ranges = <&pinctrl 0 256 32>;
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
index bb603cae13df..71d091af6395 100644
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
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
--
2.39.2


