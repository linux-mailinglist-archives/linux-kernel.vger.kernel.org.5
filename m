Return-Path: <linux-kernel+bounces-123498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B831589098B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3B51C2D4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931B51386C8;
	Thu, 28 Mar 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SQroCiKF"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045D1384B1;
	Thu, 28 Mar 2024 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655099; cv=none; b=rKkAXpSy8iW/jZSLBIL7ROTVQJEjWnedNDm+5idGbknf4Bxo5DWRtF9OsBSHUpyJKE9khqfB0s1frnrtCLVfOupqmSEAqlFaXjkUPazswtRbnvmB2vcwKT+k3okzO2PMsP5XP2ckrF/4fwHNm8ly419TUEAMpOwmxLDO2xgt/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655099; c=relaxed/simple;
	bh=lPxTjZUe7eZRPis+mB9P6t4Gh6SB0PqP8x+MqW3MjYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZYgsKjIZ1ZSAVgnFTI7z1C6lFMaLgXvyWvLf9AC8UXdU2+/blHvLq1nr0HJGmZOsPvemoM2OQ++gsF2WDUE+1pWv24Vnrnv95RsgUY6DH09gMbxhHq0YOoASlmpLN89n9pLezWEsRUTHnTWBv2fuxJUJ9SxswWQdqIdz2/vEKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SQroCiKF; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id ACE01100011;
	Thu, 28 Mar 2024 22:44:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru ACE01100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711655093;
	bh=m0xMJsrom0saG660a9og6h3GiS585KUQVZD10EtLm4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=SQroCiKF+YF/1tcLgcnxlC7Ala04oJF47du+bYXjDFdlVON8UQboEWtBtpOGLq4NH
	 xPMa2qMrIkroGs7P4Pz8tIROHODoXy5ZU+8MJrXKKq+DEnBeOjFxS52d5PyZ6d5d6K
	 LvJWJXbiz44mVE3sHqiIe2Cji8a6KNA1ofPGs85TkWx0qzte8srHpTu1iSiPhqqdLj
	 Ktbi8vOE+uwCDxnXBeRp+daR8V9fwpbt55jm3mL7OpIS0S2GVEuQ26TD/Hnu17WgXk
	 uWS0DnndO2t0bjqnzTHZPjK6csWynWM8nRiuWoY4EBv242+nIeDah19rUBg/eE4moz
	 4Zi69xr29EhaA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 22:44:53 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 22:44:53 +0300
Message-ID: <9ce24f8d-5800-4604-abb4-5586d6c385e0@salutedevices.com>
Date: Thu, 28 Mar 2024 22:43:41 +0300
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
 <20240328010831.884487-4-jan.dakinevich@salutedevices.com>
 <cff5e036-7f7c-4270-be0c-f49b196a502b@linaro.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <cff5e036-7f7c-4270-be0c-f49b196a502b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184478 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;devicetree-specification.readthedocs.io:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 18:21:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/28 18:21:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 18:13:00 #24496606
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/28/24 12:01, Krzysztof Kozlowski wrote:
> On 28/03/2024 02:08, Jan Dakinevich wrote:
>> Add device tree bindings for A1 SoC audio clock and reset controllers.
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
> 
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
> 
> What is "2"?
> 

This is the second clock controller. I couldn't think of a better name.

> If there is going to be any new version/resend:

Definitely, this is not the final version. Thank you for comments!


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
> #reset-cells: false
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
>> +    #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
>> +    #include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
>> +    audio {
> 
> If there is going to be any new version/resend:
> soc {
> 
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        clkc_audio: audio-clock-controller@fe050000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> So: clock-controller
> 
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
> 
> clock-controller
> (so I expect resend)
> 
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
> 
> Why both clock controllers have the same clocks? This is confusing. It
> seems you split same block into two!
> 
> Best regards,
> Krzysztof
> 

-- 
Best regards
Jan Dakinevich

