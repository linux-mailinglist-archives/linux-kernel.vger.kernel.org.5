Return-Path: <linux-kernel+bounces-153549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3C8ACF82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 759CEB26235
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02678152169;
	Mon, 22 Apr 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="YOaMLEJT"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6031A60;
	Mon, 22 Apr 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796419; cv=none; b=KTZLKQl9Klvg7jqL09kQrUj+x4gDuWUZ9Nlye4RS3iHKVyBDrrAC8yz45McAOcgzwWZJjrJFyeKVhw8K/A+xTVCEGw4bm+JBDBtSl9J2TL+y6f+OmN4J2RjMRJG/AldwAzFbdmeDwFr+fzjoUgqLET/ZncNQ27uRZozjgpjrwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796419; c=relaxed/simple;
	bh=32lb28Z1lYWMZpAbjMEe1sXkQLPBbUMC5yKyb4I3/l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UM890dOtDHHFDrltqH1fTzdFuGv8Wb1yEKVhGVNk4haT/9m5ggkGW7xGTppoy4FFKgRX0eVxCAeItydhw+hFscUXhuIuGf7tdAsw3pw7ICv80IlP9ObfT1EbY0Xa3NYwWdbEveoCa5lEJIgOGF9cOUxq3m+zK9PJObpL74/gBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=YOaMLEJT; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id EEAC812000E;
	Mon, 22 Apr 2024 17:33:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EEAC812000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713796409;
	bh=pg3cuV5F8kgkTSzq1f+/Nqe/VS1vbp7/MOJbVVv5HY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=YOaMLEJT20TTg+ZXgm8/NFw9WAnHbDAhFTWyUS7SFGsGckragCFd5biJ/qQ17+6m4
	 EQp9NTBgkA9O+sYav117553xximaeyzNwJ0AqI0Mc9qVvYoG4gVgI7UcdSpHHp+CwD
	 qOEXLHjPUy/DqAM0+cgCBPmxrgOgAFKx7Ma+mgqiYt/FJX2RqUD1Ctl+9LMCEKzZli
	 R2PKOrgORnJrjVzq5S9tQdw93/6gRMIbGGvLdEOX8ljFa5x5Jq+l8PGx80zTlCO972
	 KYwJlr3Oz3aeFjrdG29ggb3y+B36be74DF16MFyR7IpJx9AD5zzvIqeUMN/aOI7gwY
	 SnuMXh0zQmLuA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 22 Apr 2024 17:33:29 +0300 (MSK)
Received: from [172.28.225.118] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Apr 2024 17:33:29 +0300
Message-ID: <0272deb1-5427-4805-a6f1-df223a5c14f5@salutedevices.com>
Date: Mon, 22 Apr 2024 17:31:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/6] dt-bindings: clock: meson: document A1 SoC
 audio clock controller driver
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kevin
 Hilman <khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
 <20240419125812.983409-5-jan.dakinevich@salutedevices.com>
 <20240419210949.GA3979121-robh@kernel.org>
 <b86f1058-da53-4a9c-bc12-e7297351b482@salutedevices.com>
 <48e9f035-390b-40c9-a3ad-49880c0b972d@kernel.org>
 <1jle55c0bl.fsf@starbuckisacylon.baylibre.com>
 <1jzftlakgg.fsf@starbuckisacylon.baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1jzftlakgg.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184850 [Apr 22 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/22 11:56:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/22 13:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/22 12:16:00 #24919134
X-KSMG-AntiVirus-Status: Clean, skipped



On 4/22/24 10:57, Jerome Brunet wrote:
> 
> On Mon 22 Apr 2024 at 09:16, Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
>> On Sun 21 Apr 2024 at 20:14, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>>> On 20/04/2024 18:15, Jan Dakinevich wrote:
>>>>
>>>>
>>>> On 4/20/24 00:09, Rob Herring wrote:
>>>>> On Fri, Apr 19, 2024 at 03:58:10PM +0300, Jan Dakinevich wrote:
>>>>>> Add device tree bindings for A1 SoC audio clock and reset controllers.
>>>>>>
>>>>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>>>>> ---
>>>>>>
>>>>>> This controller has 6 mandatory and up to 20 optional clocks. To describe
>>>>>> this, I use 'additionalItems'. It produces correct processed-schema.json:
>>>>>>
>>>>>>   "clock-names": {
>>>>>>       "maxItems": 26,
>>>>>>       "items": [
>>>>>>           {
>>>>>>               "const": "pclk"
>>>>>>           },
>>>>>>           {
>>>>>>               "const": "dds_in"
>>>>>>           },
>>>>>>           {
>>>>>>               "const": "fclk_div2"
>>>>>>           },
>>>>>>           {
>>>>>>               "const": "fclk_div3"
>>>>>>           },
>>>>>>           {
>>>>>>               "const": "hifi_pll"
>>>>>>           },
>>>>>>           {
>>>>>>               "const": "xtal"
>>>>>>           }
>>>>>>       ],
>>>>>>       "additionalItems": {
>>>>>>           "oneOf": [
>>>>>>               {
>>>>>>                   "pattern": "^slv_sclk[0-9]$"
>>>>>>               },
>>>>>>               {
>>>>>>                   "pattern": "^slv_lrclk[0-9]$"
>>>>>>               }
>>>>>>           ]
>>>>>>       },
>>>>>>       "type": "array",
>>>>>>       "minItems": 6
>>>>>>   },
>>>>>>
>>>>>> and it behaves as expected. However, the checking is followed by
>>>>>> complaints like this:
>>>>>>
>>>>>>   Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml: properties:clock-names:additionalItems: {'oneOf': [{'pattern': '^slv_sclk[0-9]$'}, {'pattern': '^slv_lrclk[0-9]$'}]} is not of type 'boolean'
>>>>>>
>>>>>> And indeed, 'additionalItems' has boolean type in meta-schema. So, how to
>>>>>> do it right?
>>>>>
>>>>> The meta-schemas are written both to prevent nonsense that json-schema 
>>>>> allows by default (e.g additionalitems (wrong case)) and constraints to 
>>>>> follow the patterns we expect. I'm happy to loosen the latter case if 
>>>>> there's really a need. 
>>>>>
>>>>> Generally, most bindings shouldn't be using 'additionalItems' at all as 
>>>>> all entries should be defined, but there's a few exceptions. Here, the 
>>>>> only reasoning I see is 26 entries is a lot to write out, but that 
>>>>> wouldn't really justify it. 
>>>>
>>>> Writing a lot of entries don't scary me too much, but the reason is that
>>>> the existence of optional clock sources depends on schematics. Also, we
>>>
>>> Aren't you documenting SoC component, not a board? So how exactly it
>>> depends on schematics? SoC is done or not done...
>>>
>>>> unable to declare dt-nodes for 'clocks' array in any generic way,
>>>> because their declaration would depends on that what is actually
>>>> connected to the SoC (dt-node could be "fixed-clock" with specific rate
>>>> or something else).
>>>
>>> So these are clock inputs to the SoC?
>>>
>>
>> Yes, possibly.
>> Like an external crystal or a set clocks provided by an external codec
>> where the codec is the clock master of the link.
>>
>> This is same case as the AXG that was discussed here:
>> https://lore.kernel.org/linux-devicetree/20230808194811.113087-1-alexander.stein@mailbox.org/
>>
>> IMO, like the AXG, only the pclk is a required clock.
>> All the others - master and slave clocks - are optional.
>> The controller is designed to operate with grounded inputs
> 
> Looking again at the implementation of the controller, there is a clear
> indication in patch 3 that the controller interface is the same as the
> AXG and that the above statement is true.
> > The AXG had 8 master clocks wired in. The A1 just has 5 - and 3 grounded
> master clocks. This is why you to had to provide a mux input table to
> skip the grounded inputs. You would not have to do so if the controller was
> properly declared with the 8 master clock input, as it actually is.
> 

For simplicity, I could make something like this in device tree:

clocks = <&clk0,
          &clk1,
          &clk2,
          &clk3,
          &clk4,
          0,
          0,
          0>
clock-names = <"mst_in0",
               "mst_in1",
               "mst_in2"
               "mst_in2"
               "mst_in3"
               "mst_in4"
               "mst_in5"
               "mst_in6"
               "mst_in7">

But I don't see in the doc that the last 3 clocks are grounded to
anywhere. It will be just community's assumption about internals of the
controller.

Anyway, I still don't understand what to do with external slv_* clocks.
I can do the same as in example above: list slv_(s|lr)clk[0-9] in
"clock-names" and fill the rest if "clocks" by "0" phandles.

> It also shows that it is a bad idea to name input after what is coming
> in (like you do with "dds_in" or "fclk_div2") instead of what they
> actually are like in the AXG (mst0, mst1, etc ...)
> 

I agree, these are not the best names.

>>
>>>>
>>>> By the way, I don't know any example (neither for A1 SoC nor for other
>>>> Amlogic's SoCs) where these optional clocks are used, but they are
>>>> allowed by hw.
>>
>> Those scenario exists and have been tested. There is just no dts using
>> that upstream because they are all mostly copy of the AML ref design.
>>
>>>>
>>>> This is my understanding of this controller. I hope, Jerome Brunet will
>>>> clarify how it actually works.
>>>
>>
>> I think the simpliest way to deal with this to just list all the clocks
>> with 'minItems = 1'. It is going be hard to read with a lot of '<0>,' in
>> the DTS when do need those slave clocks but at least the binding doc
>> will be simple.
>>
>>> Best regards,
>>> Krzysztof
>>
>> If you are going ahead with this, please name the file
>> amlogic,axg-audio-clkc.yaml because this is really the first controller
>> of the type and is meant to be documented in the same file.
>>
>> You are free to handle the conversion of the AXG at the same time if
>> you'd like. It would be much appreciated if you do.
> 
> 

-- 
Best regards
Jan Dakinevich

