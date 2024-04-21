Return-Path: <linux-kernel+bounces-152619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9CF8AC13E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C586DB209B0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015945027;
	Sun, 21 Apr 2024 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="N2ZHT3AM"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E701B974;
	Sun, 21 Apr 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713733552; cv=none; b=Uwvix6Ivk5ucavMpHGY5bFxhOu5JLRUv2pQd5d9oO6BmKqS0lTBGXn16FCTtatwlDhD4pNoitfYCj2DwUPZr3XT2bvojH8iW5t8lIRAky0inP7CL+CRIl1+mErbB6YKY+MWejXTxuXvYYtI1+9fT1bzlZTu3jnJplLtAVwmXWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713733552; c=relaxed/simple;
	bh=QLDln7YA9I5hDs65OcTHbuAQgSwZ2E5WVljdqajAUsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nXr0zQVjZTVv1fXLM8dCF+fxKEs9I8AfELbTRBGeTxP66S+Ociz8dD9aCAXu8hunCo+lmMaLySZVyaYuxtkaTftt2C+qc8QKgGo1jJmfJqN0PmJpQLPbpam8zlb/fTHJi8dP+ZyFMyO62GHfYlSf+b9+8w5eNZ4cqEKjy6JnlPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=N2ZHT3AM; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9988D120005;
	Mon, 22 Apr 2024 00:05:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9988D120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713733544;
	bh=R0C125p3kVCLuPYBMrbEwNQGj81MQPjuuYJOoUD8tqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=N2ZHT3AMzi0SzOYpYvrei1rigTUEJazbj3PRW89smokzyk9oH40KdKnKmgEJ4fSMX
	 LL361Y+ux/IfNNM0k3lwK2pe3tuDWPk+WI3Gh+P8XyR1cuTQXBmoH6vkp5WPIsZ3Qn
	 Zmh7g7uIU/BhMVMzSMLtfzmc++gUVexXF+fM7hkDmaI5u5oyHxgGAqmBhRSjaJ23Az
	 htSkAqwzFHFYHT+QURlO0Yc4bZ2KT76NMHnKxKHBnWfJFPwrFQXZ5panRteNTOoIpH
	 AJQkK/SF35ueEQ8VOQWLzHkcOq69MNSx5Zq+c96Ldj9j4Y5xhbK90Bhh6q6hM+Ysh0
	 +f+/qD91HIsfA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 22 Apr 2024 00:05:44 +0300 (MSK)
Received: from [172.28.66.92] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Apr 2024 00:05:44 +0300
Message-ID: <7f8b3916-ddc1-42e1-a2e5-b5ed42010120@salutedevices.com>
Date: Mon, 22 Apr 2024 00:03:28 +0300
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
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
 <20240419125812.983409-5-jan.dakinevich@salutedevices.com>
 <20240419210949.GA3979121-robh@kernel.org>
 <b86f1058-da53-4a9c-bc12-e7297351b482@salutedevices.com>
 <48e9f035-390b-40c9-a3ad-49880c0b972d@kernel.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <48e9f035-390b-40c9-a3ad-49880c0b972d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184824 [Apr 21 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/21 18:21:00 #24913485
X-KSMG-AntiVirus-Status: Clean, skipped



On 4/21/24 21:14, Krzysztof Kozlowski wrote:
> On 20/04/2024 18:15, Jan Dakinevich wrote:
>>
>>
>> On 4/20/24 00:09, Rob Herring wrote:
>>> On Fri, Apr 19, 2024 at 03:58:10PM +0300, Jan Dakinevich wrote:
>>>> Add device tree bindings for A1 SoC audio clock and reset controllers.
>>>>
>>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>>> ---
>>>>
>>>> This controller has 6 mandatory and up to 20 optional clocks. To describe
>>>> this, I use 'additionalItems'. It produces correct processed-schema.json:
>>>>
>>>>   "clock-names": {
>>>>       "maxItems": 26,
>>>>       "items": [
>>>>           {
>>>>               "const": "pclk"
>>>>           },
>>>>           {
>>>>               "const": "dds_in"
>>>>           },
>>>>           {
>>>>               "const": "fclk_div2"
>>>>           },
>>>>           {
>>>>               "const": "fclk_div3"
>>>>           },
>>>>           {
>>>>               "const": "hifi_pll"
>>>>           },
>>>>           {
>>>>               "const": "xtal"
>>>>           }
>>>>       ],
>>>>       "additionalItems": {
>>>>           "oneOf": [
>>>>               {
>>>>                   "pattern": "^slv_sclk[0-9]$"
>>>>               },
>>>>               {
>>>>                   "pattern": "^slv_lrclk[0-9]$"
>>>>               }
>>>>           ]
>>>>       },
>>>>       "type": "array",
>>>>       "minItems": 6
>>>>   },
>>>>
>>>> and it behaves as expected. However, the checking is followed by
>>>> complaints like this:
>>>>
>>>>   Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml: properties:clock-names:additionalItems: {'oneOf': [{'pattern': '^slv_sclk[0-9]$'}, {'pattern': '^slv_lrclk[0-9]$'}]} is not of type 'boolean'
>>>>
>>>> And indeed, 'additionalItems' has boolean type in meta-schema. So, how to
>>>> do it right?
>>>
>>> The meta-schemas are written both to prevent nonsense that json-schema 
>>> allows by default (e.g additionalitems (wrong case)) and constraints to 
>>> follow the patterns we expect. I'm happy to loosen the latter case if 
>>> there's really a need. 
>>>
>>> Generally, most bindings shouldn't be using 'additionalItems' at all as 
>>> all entries should be defined, but there's a few exceptions. Here, the 
>>> only reasoning I see is 26 entries is a lot to write out, but that 
>>> wouldn't really justify it. 
>>
>> Writing a lot of entries don't scary me too much, but the reason is that
>> the existence of optional clock sources depends on schematics. Also, we
> 
> Aren't you documenting SoC component, not a board? 

Yes, I'm documenting SoC component. And the feature of this component is
that its external clock inputs are not mandatory.

> So how exactly it
> depends on schematics? SoC is done or not done...
> 

Schematics determines which external clock sources exist.

>> unable to declare dt-nodes for 'clocks' array in any generic way,
>> because their declaration would depends on that what is actually
>> connected to the SoC (dt-node could be "fixed-clock" with specific rate
>> or something else).
> 
> So these are clock inputs to the SoC?
> 

Yes, these are clock inputs to the SoC, and external hardware could be
connected to them.

>>
>> By the way, I don't know any example (neither for A1 SoC nor for other
>> Amlogic's SoCs) where these optional clocks are used, but they are
>> allowed by hw.
>>
>> This is my understanding of this controller. I hope, Jerome Brunet will
>> clarify how it actually works.
> 
> Best regards,
> Krzysztof
> 

-- 
Best regards
Jan Dakinevich

