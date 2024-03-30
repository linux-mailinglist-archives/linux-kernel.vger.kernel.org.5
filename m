Return-Path: <linux-kernel+bounces-125829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8432892CD5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E91283395
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D954206B;
	Sat, 30 Mar 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Kc1dWBy9"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA18475;
	Sat, 30 Mar 2024 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711827815; cv=none; b=YEfl+mzuusDYN6SSuUmHZd0bgnvjtjjf8lvzkfKNXr43dpyq+pUeM5ywmzu1Ap4vaGC+nCEFZe4NuqBXxkhmETilv+SwAkw9XsAGz9MPQFoyI6LPYz3ONMPqa2uZA+KvDNFUnnnc7mml9RXb6H4FfoJ0ShSnO7UMvJLpFNXvGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711827815; c=relaxed/simple;
	bh=aeUU+Y/JEfBmjPFnbRw+lanNh1Bl968PNz1dKyk//UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IJJB5gob6i+pkFf8++llF4Nc6b+hSKONp35pFeOF0FEeubwvkgP4l7eNJFsukMC6eAQohhCUIYTtEwtB9/iz8EuxBMagZgc3e3Q0i9Hb6r+5tRUqpR3/Kc8P+IeXvX/ABWp8q/vSdKhZnhNhrOXQ6GOY0Gsh0TxRs6qzf0Ui+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Kc1dWBy9; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9C88C12000A;
	Sat, 30 Mar 2024 22:43:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9C88C12000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711827798;
	bh=afqhDWhc6QmTdlx96ICHDE9CGA8xc1bbiYySJpCfgqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Kc1dWBy94r1vnGg4VUFWGQgfR2wkonuAEdC6KwFMMZBlj5X9/1+4CwZihd0Mowo0S
	 L/R+ZfTgn25z0BSetJ0inLPr/4Unc8lDEVUr/iB4Dhoo5q5V89rQU95n9qDvHIiXsq
	 IaLQdgVhMTZMwFi9h+R+yqyqqUqEF5thfzmSSNTWfuyRwA1avOox3ftQSZruPlx2Ve
	 Mj/9gIknIVbreztFxQ52kWbZNDfrAMX98p5H7pMBO1QE/cXFd4t/NO211dCkxPyfyv
	 wScVyZzy2gErPYm4NoCu/et5KJxvvBCzyU6cPKjpzJudnI5yKdakrhLDA9g9siB+6U
	 XEGZSvyMIsewQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 30 Mar 2024 22:43:18 +0300 (MSK)
Received: from [172.28.64.112] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 22:43:17 +0300
Message-ID: <d55a0fea-92a0-4b73-abd5-46a3841cf6c6@salutedevices.com>
Date: Sat, 30 Mar 2024 22:42:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] dt-bindings: clock: meson: document A1 SoC
 audio clock controller driver
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
 <20240328010831.884487-4-jan.dakinevich@salutedevices.com>
 <1j4jcp9qdl.fsf@starbuckisacylon.baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1j4jcp9qdl.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184500 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;devicetree.org:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/30 18:32:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/30 18:32:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/30 16:55:00 #24525594
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/29/24 15:24, Jerome Brunet wrote:
> 
> On Thu 28 Mar 2024 at 04:08, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> Add device tree bindings for A1 SoC audio clock and reset controllers.
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  .../bindings/clock/amlogic,a1-audio-clkc.yaml | 141 ++++++++++++++++++
>>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 +++++++++++++++
>>  .../reset/amlogic,meson-a1-audio-reset.h      |  29 ++++
>>  3 files changed, 292 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml
>>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml
>> new file mode 100644
>> index 000000000000..1c9ef3292f3c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml
>> @@ -0,0 +1,141 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,a1-audio-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic A1 Audio Clock Control Unit and Reset Controller
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - amlogic,a1-audio-clkc
>> +      - amlogic,a1-audio2-clkc
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 6
>> +    maxItems: 7
>> +
>> +  clock-names:
>> +    minItems: 6
>> +    maxItems: 7
>> +
>> +required:
>> +  - compatible
>> +  - '#clock-cells'
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,a1-audio-clkc
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: input core clock
>> +            - description: input main peripheral bus clock
>> +            - description: input dds_in
>> +            - description: input fixed pll div2
>> +            - description: input fixed pll div3
>> +            - description: input hifi_pll
>> +            - description: input oscillator (usually at 24MHz)
>> +        clocks-names:
>> +          items:
>> +            - const: core
>> +            - const: pclk
>> +            - const: dds_in
>> +            - const: fclk_div2
>> +            - const: fclk_div3
>> +            - const: hifi_pll
>> +            - const: xtal
>> +      required:
>> +        - '#reset-cells'
>> +    else:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: input main peripheral bus clock
>> +            - description: input dds_in
>> +            - description: input fixed pll div2
>> +            - description: input fixed pll div3
>> +            - description: input hifi_pll
>> +            - description: input oscillator (usually at 24MHz)
>> +        clock-names:
>> +          items:
>> +            - const: pclk
>> +            - const: dds_in
>> +            - const: fclk_div2
>> +            - const: fclk_div3
>> +            - const: hifi_pll
>> +            - const: xtal
> 
> All the optional slave clock inputs are missing from this dcoumentation..
> They need to be documentated as well
> 
Hmmm... here should be a list of 26 entries. First 6 of them are
mandatory, other are optional.

I have no ideas left on how to describe it in yaml, also I can't find
something similar beside existing schemas... Maybe you can give some advice.

>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
>> +    #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
>> +    #include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
>> +    audio {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        clkc_audio: audio-clock-controller@fe050000 {
>> +                compatible = "amlogic,a1-audio-clkc";
>> +                reg = <0x0 0xfe050000 0x0 0xb0>;
>> +                #clock-cells = <1>;
>> +                #reset-cells = <1>;
>> +                clocks = <&clkc_audio2 AUD2_CLKID_AUDIOTOP>,
>> +                         <&clkc_periphs CLKID_AUDIO>,
>> +                         <&clkc_periphs CLKID_DDS_IN>,
>> +                         <&clkc_pll CLKID_FCLK_DIV2>,
>> +                         <&clkc_pll CLKID_FCLK_DIV3>,
>> +                         <&clkc_pll CLKID_HIFI_PLL>,
>> +                         <&xtal>;
>> +                clock-names = "core",
>> +                              "pclk",
>> +                              "dds_in",
>> +                              "fclk_div2",
>> +                              "fclk_div3",
>> +                              "hifi_pll",
>> +                              "xtal";
>> +        };
>> +
>> +        clkc_audio2: audio-clock-controller@fe054800 {
>> +                compatible = "amlogic,a1-audio2-clkc";
>> +                reg = <0x0 0xfe054800 0x0 0x20>;
>> +                #clock-cells = <1>;
>> +                clocks = <&clkc_periphs CLKID_AUDIO>,
>> +                         <&clkc_periphs CLKID_DDS_IN>,
>> +                         <&clkc_pll CLKID_FCLK_DIV2>,
>> +                         <&clkc_pll CLKID_FCLK_DIV3>,
>> +                         <&clkc_pll CLKID_HIFI_PLL>,
>> +                         <&xtal>;
>> +                clock-names = "pclk",
>> +                              "dds_in",
>> +                              "fclk_div2",
>> +                              "fclk_div3",
>> +                              "hifi_pll",
>> +                              "xtal";
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/clock/amlogic,a1-audio-clkc.h b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>> new file mode 100644
>> index 000000000000..b30df3b1ae08
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>> @@ -0,0 +1,122 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
>> + *
>> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> + */
>> +
>> +#ifndef __A1_AUDIO_CLKC_BINDINGS_H
>> +#define __A1_AUDIO_CLKC_BINDINGS_H
>> +
>> +#define AUD_CLKID_DDR_ARB		1
>> +#define AUD_CLKID_TDMIN_A		2
>> +#define AUD_CLKID_TDMIN_B		3
>> +#define AUD_CLKID_TDMIN_LB		4
>> +#define AUD_CLKID_LOOPBACK		5
>> +#define AUD_CLKID_TDMOUT_A		6
>> +#define AUD_CLKID_TDMOUT_B		7
>> +#define AUD_CLKID_FRDDR_A		8
>> +#define AUD_CLKID_FRDDR_B		9
>> +#define AUD_CLKID_TODDR_A		10
>> +#define AUD_CLKID_TODDR_B		11
>> +#define AUD_CLKID_SPDIFIN		12
>> +#define AUD_CLKID_RESAMPLE		13
>> +#define AUD_CLKID_EQDRC			14
>> +#define AUD_CLKID_LOCKER		15
>> +#define AUD_CLKID_MST_A_MCLK_SEL	16
>> +#define AUD_CLKID_MST_A_MCLK_DIV	17
>> +#define AUD_CLKID_MST_A_MCLK		18
>> +#define AUD_CLKID_MST_B_MCLK_SEL	19
>> +#define AUD_CLKID_MST_B_MCLK_DIV	20
>> +#define AUD_CLKID_MST_B_MCLK		21
>> +#define AUD_CLKID_MST_C_MCLK_SEL	22
>> +#define AUD_CLKID_MST_C_MCLK_DIV	23
>> +#define AUD_CLKID_MST_C_MCLK		24
>> +#define AUD_CLKID_MST_D_MCLK_SEL	25
>> +#define AUD_CLKID_MST_D_MCLK_DIV	26
>> +#define AUD_CLKID_MST_D_MCLK		27
>> +#define AUD_CLKID_SPDIFIN_CLK_SEL	28
>> +#define AUD_CLKID_SPDIFIN_CLK_DIV	29
>> +#define AUD_CLKID_SPDIFIN_CLK		30
>> +#define AUD_CLKID_RESAMPLE_CLK_SEL	31
>> +#define AUD_CLKID_RESAMPLE_CLK_DIV	32
>> +#define AUD_CLKID_RESAMPLE_CLK		33
>> +#define AUD_CLKID_LOCKER_IN_CLK_SEL	34
>> +#define AUD_CLKID_LOCKER_IN_CLK_DIV	35
>> +#define AUD_CLKID_LOCKER_IN_CLK		36
>> +#define AUD_CLKID_LOCKER_OUT_CLK_SEL	37
>> +#define AUD_CLKID_LOCKER_OUT_CLK_DIV	38
>> +#define AUD_CLKID_LOCKER_OUT_CLK	39
>> +#define AUD_CLKID_EQDRC_CLK_SEL		40
>> +#define AUD_CLKID_EQDRC_CLK_DIV		41
>> +#define AUD_CLKID_EQDRC_CLK		42
>> +#define AUD_CLKID_MST_A_SCLK_PRE_EN	43
>> +#define AUD_CLKID_MST_A_SCLK_DIV	44
>> +#define AUD_CLKID_MST_A_SCLK_POST_EN	45
>> +#define AUD_CLKID_MST_A_SCLK		46
>> +#define AUD_CLKID_MST_B_SCLK_PRE_EN	47
>> +#define AUD_CLKID_MST_B_SCLK_DIV	48
>> +#define AUD_CLKID_MST_B_SCLK_POST_EN	49
>> +#define AUD_CLKID_MST_B_SCLK		50
>> +#define AUD_CLKID_MST_C_SCLK_PRE_EN	51
>> +#define AUD_CLKID_MST_C_SCLK_DIV	52
>> +#define AUD_CLKID_MST_C_SCLK_POST_EN	53
>> +#define AUD_CLKID_MST_C_SCLK		54
>> +#define AUD_CLKID_MST_D_SCLK_PRE_EN	55
>> +#define AUD_CLKID_MST_D_SCLK_DIV	56
>> +#define AUD_CLKID_MST_D_SCLK_POST_EN	57
>> +#define AUD_CLKID_MST_D_SCLK		58
>> +#define AUD_CLKID_MST_A_LRCLK_DIV	59
>> +#define AUD_CLKID_MST_A_LRCLK		60
>> +#define AUD_CLKID_MST_B_LRCLK_DIV	61
>> +#define AUD_CLKID_MST_B_LRCLK		62
>> +#define AUD_CLKID_MST_C_LRCLK_DIV	63
>> +#define AUD_CLKID_MST_C_LRCLK		64
>> +#define AUD_CLKID_MST_D_LRCLK_DIV	65
>> +#define AUD_CLKID_MST_D_LRCLK		66
>> +#define AUD_CLKID_TDMIN_A_SCLK_SEL	67
>> +#define AUD_CLKID_TDMIN_A_SCLK_PRE_EN	68
>> +#define AUD_CLKID_TDMIN_A_SCLK_POST_EN	69
>> +#define AUD_CLKID_TDMIN_A_SCLK		70
>> +#define AUD_CLKID_TDMIN_A_LRCLK		71
>> +#define AUD_CLKID_TDMIN_B_SCLK_SEL	72
>> +#define AUD_CLKID_TDMIN_B_SCLK_PRE_EN	73
>> +#define AUD_CLKID_TDMIN_B_SCLK_POST_EN	74
>> +#define AUD_CLKID_TDMIN_B_SCLK		75
>> +#define AUD_CLKID_TDMIN_B_LRCLK		76
>> +#define AUD_CLKID_TDMIN_LB_SCLK_SEL	77
>> +#define AUD_CLKID_TDMIN_LB_SCLK_PRE_EN	78
>> +#define AUD_CLKID_TDMIN_LB_SCLK_POST_EN	79
>> +#define AUD_CLKID_TDMIN_LB_SCLK		80
>> +#define AUD_CLKID_TDMIN_LB_LRCLK	81
>> +#define AUD_CLKID_TDMOUT_A_SCLK_SEL	82
>> +#define AUD_CLKID_TDMOUT_A_SCLK_PRE_EN	83
>> +#define AUD_CLKID_TDMOUT_A_SCLK_POST_EN	84
>> +#define AUD_CLKID_TDMOUT_A_SCLK		85
>> +#define AUD_CLKID_TDMOUT_A_LRCLK	86
>> +#define AUD_CLKID_TDMOUT_B_SCLK_SEL	87
>> +#define AUD_CLKID_TDMOUT_B_SCLK_PRE_EN	88
>> +#define AUD_CLKID_TDMOUT_B_SCLK_POST_EN	89
>> +#define AUD_CLKID_TDMOUT_B_SCLK		90
>> +#define AUD_CLKID_TDMOUT_B_LRCLK	91
>> +
>> +#define AUD2_CLKID_DDR_ARB		1
>> +#define AUD2_CLKID_PDM			2
>> +#define AUD2_CLKID_TDMIN_VAD		3
>> +#define AUD2_CLKID_TODDR_VAD		4
>> +#define AUD2_CLKID_VAD			5
>> +#define AUD2_CLKID_AUDIOTOP		6
>> +#define AUD2_CLKID_VAD_MCLK_SEL		7
>> +#define AUD2_CLKID_VAD_MCLK_DIV		8
>> +#define AUD2_CLKID_VAD_MCLK		9
>> +#define AUD2_CLKID_VAD_CLK_SEL		10
>> +#define AUD2_CLKID_VAD_CLK_DIV		11
>> +#define AUD2_CLKID_VAD_CLK		12
>> +#define AUD2_CLKID_PDM_DCLK_SEL		13
>> +#define AUD2_CLKID_PDM_DCLK_DIV		14
>> +#define AUD2_CLKID_PDM_DCLK		15
>> +#define AUD2_CLKID_PDM_SYSCLK_SEL	16
>> +#define AUD2_CLKID_PDM_SYSCLK_DIV	17
>> +#define AUD2_CLKID_PDM_SYSCLK		18
>> +
>> +#endif /* __A1_AUDIO_CLKC_BINDINGS_H */
>> diff --git a/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
>> new file mode 100644
>> index 000000000000..653fddba1d8f
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
>> + *
>> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H
>> +#define _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H
>> +
>> +#define AUD_RESET_DDRARB	0
>> +#define AUD_RESET_TDMIN_A	1
>> +#define AUD_RESET_TDMIN_B	2
>> +#define AUD_RESET_TDMIN_LB	3
>> +#define AUD_RESET_LOOPBACK	4
>> +#define AUD_RESET_TDMOUT_A	5
>> +#define AUD_RESET_TDMOUT_B	6
>> +#define AUD_RESET_FRDDR_A	7
>> +#define AUD_RESET_FRDDR_B	8
>> +#define AUD_RESET_TODDR_A	9
>> +#define AUD_RESET_TODDR_B	10
>> +#define AUD_RESET_SPDIFIN	11
>> +#define AUD_RESET_RESAMPLE	12
>> +#define AUD_RESET_EQDRC		13
>> +#define AUD_RESET_LOCKER	14
>> +#define AUD_RESET_TOACODEC	30
>> +#define AUD_RESET_CLKTREE	31
>> +
>> +#endif /* _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H */
> 
> 

-- 
Best regards
Jan Dakinevich

