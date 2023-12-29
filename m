Return-Path: <linux-kernel+bounces-13150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A7682005C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBB32819F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4A125BB;
	Fri, 29 Dec 2023 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fruE4LvW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0C12B60;
	Fri, 29 Dec 2023 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5553d588cc7so3035071a12.3;
        Fri, 29 Dec 2023 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703864882; x=1704469682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRIBjfdH32Rq9fmAitzJq1KnOaNP52IVb0+82EFbcek=;
        b=fruE4LvWTgHJrf0ahjUUYOolUSAh+GRPmJZdXTrSdqL/ay146X6HCEuMkxUSb5qzp0
         3mtf+gihY7A9XGLMyBunaUGyB+JQZT8ICYr0s4g+IRii2LpdEx09GlFHJ4Kw/CA3aJ9d
         PoKmrcMFEqFOLlpdW5xg47fo1agzizlqzSDYMyN+ibJNwS827+UN/tsocmm4o6h12O2C
         zNGhfCThAf6/eIaK4YdA1tqKtVPTLWq0QkV1sAvctGuI3WiRU/aaYdy4901mDCUL3yor
         o0yNYgPDazDTqNHs04dUV6eAin5HjYkkFMCPzs7WGFxX6n1YieCQNIhulHCYbmcQq7nD
         fvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703864882; x=1704469682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRIBjfdH32Rq9fmAitzJq1KnOaNP52IVb0+82EFbcek=;
        b=ZoCPPPM7D28VI2o/ZRarmQPLN/Zdl7/hYQejdglu8NocKOSPydHIY+GYyjjb3Vr27+
         ar4zm3/GR8eUuaWtZlopN8dGpTHa1YDg9u+TffrO0ft+5K3ssxBQXCMggLloeI+olhzP
         cnqCAJ71m3I+tbCk+lOxLWkg8c+nyYr/nERIka+rivJxvhrDJZdaUEY4h4GCxpf7CwWZ
         Ej0xXe7vWeKKBK0E36rel+9runm3HFu16dwL0ZQDk9XqXxg32tNhrpkisxZsncVOjvgk
         Z4c50FUhxySUFFQCly1Zs0mCYE6EqNusTr4XtedZDjlSbYfjSxdsXMa9sQsGJQ6vGDUe
         BmTQ==
X-Gm-Message-State: AOJu0YwMeNLVBotwn6ncVSpO0py4zvgdAwXjU8keIIqspA0+mAJnvaLH
	fSB/uhlPSEkwh+l0XduqSX4=
X-Google-Smtp-Source: AGHT+IEGI1Zg2UHAAntOSZJeAzwTY4UNx13OsUHhtmVQPBda8OOTtwTPXGYkjSqfExBap8BNZ2h5Jw==
X-Received: by 2002:a17:906:224c:b0:a27:7c2e:420a with SMTP id 12-20020a170906224c00b00a277c2e420amr1117559ejr.8.1703864881693;
        Fri, 29 Dec 2023 07:48:01 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id fw34-20020a170907502200b00a27aabff0dcsm225511ejc.179.2023.12.29.07.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 07:48:01 -0800 (PST)
Message-ID: <396abf33-567c-b020-b12d-ee1cd7eca836@gmail.com>
Date: Fri, 29 Dec 2023 16:47:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/2] ARM: dts: rockchip: add gpio-ranges property to
 gpio nodes
To: Jonas Karlman <jonas@kwiboo.se>, heiko@sntech.de
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, kever.yang@rock-chips.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cf46c685-bf4b-63b5-0373-dd0ba70e9700@gmail.com>
 <541b7633-af3b-4392-ac29-7ee1f2c6f943@kwiboo.se>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <541b7633-af3b-4392-ac29-7ee1f2c6f943@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonas,

On 12/28/23 17:30, Jonas Karlman wrote:
> Hi Johan,
> 
> On 2023-12-27 19:33, Johan Jonker wrote:
>> Add a gpio-ranges property to Rockchip gpio nodes similar to
>> rk356x/rk3588 to be independent from aliases and probe order.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>> Changed V3:
>>   reword
>>   rebase to new Rockchip directory
>>   remove unknown properties
>> ---
>>  arch/arm/boot/dts/rockchip/rk3036.dtsi  | 3 +++
>>  arch/arm/boot/dts/rockchip/rk3066a.dtsi | 6 ++++++
>>  arch/arm/boot/dts/rockchip/rk3128.dtsi  | 4 ++++
>>  arch/arm/boot/dts/rockchip/rk3188.dtsi  | 4 ++++
>>  arch/arm/boot/dts/rockchip/rk322x.dtsi  | 4 ++++
>>  arch/arm/boot/dts/rockchip/rk3288.dtsi  | 9 +++++++++
>>  arch/arm/boot/dts/rockchip/rv1108.dtsi  | 4 ++++
>>  arch/arm/boot/dts/rockchip/rv1126.dtsi  | 5 +++++
>>  8 files changed, 39 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> index 2b00109bea6a..6e5028b6dbfa 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> @@ -593,6 +593,7 @@ gpio0: gpio@2007c000 {
>>  			clocks = <&cru PCLK_GPIO0>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 0 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -606,6 +607,7 @@ gpio1: gpio@20080000 {
>>  			clocks = <&cru PCLK_GPIO1>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 32 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -619,6 +621,7 @@ gpio2: gpio@20084000 {
>>  			clocks = <&cru PCLK_GPIO2>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 64 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> diff --git a/arch/arm/boot/dts/rockchip/rk3066a.dtsi b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
>> index 30139f21de64..a4962b6b3f4c 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3066a.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
>> @@ -285,6 +285,7 @@ gpio0: gpio@20034000 {
>>  			clocks = <&cru PCLK_GPIO0>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 0 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -298,6 +299,7 @@ gpio1: gpio@2003c000 {
>>  			clocks = <&cru PCLK_GPIO1>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 32 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -311,6 +313,7 @@ gpio2: gpio@2003e000 {
>>  			clocks = <&cru PCLK_GPIO2>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 64 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -324,6 +327,7 @@ gpio3: gpio@20080000 {
>>  			clocks = <&cru PCLK_GPIO3>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 96 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -337,6 +341,7 @@ gpio4: gpio@20084000 {
>>  			clocks = <&cru PCLK_GPIO4>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 128 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -350,6 +355,7 @@ gpio6: gpio@2000a000 {
>>  			clocks = <&cru PCLK_GPIO6>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 192 32>;
> 

> It does not look like this matches what pins the pinctrl driver expose
> for rk3066a. Something like <&pinctrl 0 160 16> would probably be more
> correct.

See comment below.

> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> index e2264c40b924..d66fcf12032e 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> @@ -712,6 +712,7 @@ gpio0: gpio@2007c000 {
>>  			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&cru PCLK_GPIO0>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 0 32>;
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> @@ -723,6 +724,7 @@ gpio1: gpio@20080000 {
>>  			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&cru PCLK_GPIO1>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 32 32>;
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> @@ -734,6 +736,7 @@ gpio2: gpio@20084000 {
>>  			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&cru PCLK_GPIO2>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 64 32>;
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> @@ -745,6 +748,7 @@ gpio3: gpio@20088000 {
>>  			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&cru PCLK_GPIO3>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 96 32>;
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> diff --git a/arch/arm/boot/dts/rockchip/rk3188.dtsi b/arch/arm/boot/dts/rockchip/rk3188.dtsi
>> index 44b54af0bbf9..6677e4a10e5d 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3188.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3188.dtsi
>> @@ -231,6 +231,7 @@ gpio0: gpio@2000a000 {
>>  			clocks = <&cru PCLK_GPIO0>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 0 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -244,6 +245,7 @@ gpio1: gpio@2003c000 {
>>  			clocks = <&cru PCLK_GPIO1>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 32 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -257,6 +259,7 @@ gpio2: gpio@2003e000 {
>>  			clocks = <&cru PCLK_GPIO2>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 64 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -270,6 +273,7 @@ gpio3: gpio@20080000 {
>>  			clocks = <&cru PCLK_GPIO3>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 96 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
>> index 831561fc1814..0d4f9957b99b 100644
>> --- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
>> @@ -959,6 +959,7 @@ gpio0: gpio@11110000 {
>>  			clocks = <&cru PCLK_GPIO0>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 0 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -972,6 +973,7 @@ gpio1: gpio@11120000 {
>>  			clocks = <&cru PCLK_GPIO1>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 32 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -985,6 +987,7 @@ gpio2: gpio@11130000 {
>>  			clocks = <&cru PCLK_GPIO2>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 64 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -998,6 +1001,7 @@ gpio3: gpio@11140000 {
>>  			clocks = <&cru PCLK_GPIO3>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 96 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
>> index ead343dc3df1..c5550aae4ed8 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
>> @@ -1461,6 +1461,7 @@ gpio0: gpio@ff750000 {
>>  			clocks = <&cru PCLK_GPIO0>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 0 32>;
> 
> The pinctrl driver for rk3288 only expose 24 pins for the first bank,
> correct range would probably be <&pinctrl 0 0 24> here,
> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -1474,6 +1475,7 @@ gpio1: gpio@ff780000 {
>>  			clocks = <&cru PCLK_GPIO1>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 32 32>;
> 

> and correct range would probably be <&pinctrl 0 24 32> here,

Random gpio offset ranges for a gpio bank of the various Rockchip SoCs makes it impossible to easy link gpio to pinctrl and vica versa in a standard way without additional Rockchip specific node properties.
To keep things simple the gpio-range for a gpio bank must always be inside to same multiple of 32 for all Rockchip SoCs in relation to the pinctrl.
A "rockchip,pins" property always must have the same "gpio-ranges" set.

Johan

> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -1487,6 +1489,7 @@ gpio2: gpio@ff790000 {
>>  			clocks = <&cru PCLK_GPIO2>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 64 32>;
> 
> and <&pinctrl 0 56 32> here,
> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -1500,6 +1503,7 @@ gpio3: gpio@ff7a0000 {
>>  			clocks = <&cru PCLK_GPIO3>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 96 32>;
> 
> and <&pinctrl 0 88 32> here,
> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -1513,6 +1517,7 @@ gpio4: gpio@ff7b0000 {
>>  			clocks = <&cru PCLK_GPIO4>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 128 32>;
> 
> and <&pinctrl 0 120 32> here,
> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -1526,6 +1531,7 @@ gpio5: gpio@ff7c0000 {
>>  			clocks = <&cru PCLK_GPIO5>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 160 32>;
> 
> and <&pinctrl 0 152 32> here,
> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -1539,6 +1545,7 @@ gpio6: gpio@ff7d0000 {
>>  			clocks = <&cru PCLK_GPIO6>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 192 32>;
> 
> and <&pinctrl 0 184 32> here,
> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -1552,6 +1559,7 @@ gpio7: gpio@ff7e0000 {
>>  			clocks = <&cru PCLK_GPIO7>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 224 32>;
> 
> and <&pinctrl 0 216 32> here,
> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -1565,6 +1573,7 @@ gpio8: gpio@ff7f0000 {
>>  			clocks = <&cru PCLK_GPIO8>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 256 32>;
> 
> and bank num 8 only expose 16 pins, so <&pinctrl 0 248 16> here.
> 
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> diff --git a/arch/arm/boot/dts/rockchip/rv1108.dtsi b/arch/arm/boot/dts/rockchip/rv1108.dtsi
>> index abf3006f0a84..d12b97ee7588 100644
>> --- a/arch/arm/boot/dts/rockchip/rv1108.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rv1108.dtsi
>> @@ -602,6 +602,7 @@ gpio0: gpio@20030000 {
>>  			clocks = <&cru PCLK_GPIO0_PMU>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 0 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -615,6 +616,7 @@ gpio1: gpio@10310000 {
>>  			clocks = <&cru PCLK_GPIO1>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 32 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -628,6 +630,7 @@ gpio2: gpio@10320000 {
>>  			clocks = <&cru PCLK_GPIO2>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 64 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> @@ -641,6 +644,7 @@ gpio3: gpio@10330000 {
>>  			clocks = <&cru PCLK_GPIO3>;
>>
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 96 32>;
>>  			#gpio-cells = <2>;
>>
>>  			interrupt-controller;
>> diff --git a/arch/arm/boot/dts/rockchip/rv1126.dtsi b/arch/arm/boot/dts/rockchip/rv1126.dtsi
>> index bb603cae13df..71d091af6395 100644
>> --- a/arch/arm/boot/dts/rockchip/rv1126.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rv1126.dtsi
>> @@ -569,6 +569,7 @@ gpio0: gpio@ff460000 {
>>  			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 0 32>;
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> @@ -580,6 +581,7 @@ gpio1: gpio@ff620000 {
>>  			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 32 32>;
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> @@ -591,6 +593,7 @@ gpio2: gpio@ff630000 {
>>  			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 64 32>;
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> @@ -602,6 +605,7 @@ gpio3: gpio@ff640000 {
>>  			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 96 32>;
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> @@ -613,6 +617,7 @@ gpio4: gpio@ff650000 {
>>  			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
>>  			gpio-controller;
>> +			gpio-ranges = <&pinctrl 0 128 32>;
> 
> Bank num 4 only expose 2 pins, so should probably be <&pinctrl 0 128 2>.
> 
> Regards,
> Jonas
> 
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> --
>> 2.39.2
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

