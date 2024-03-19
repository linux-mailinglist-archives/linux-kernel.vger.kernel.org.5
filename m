Return-Path: <linux-kernel+bounces-106862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A962187F49D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE9A282B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A7ED8;
	Tue, 19 Mar 2024 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="loU4GwBy"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A188489;
	Tue, 19 Mar 2024 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808299; cv=none; b=R5+IIrBRhpw3cP2BukviY2dAbkTXIkl2GAvGaWfhLXnerv0qiQYkiLREQNxXi0yM8AWfjmzEMkfZC0CrL61qNjWYZUUenKpwUV5Ymy7UJYbu2JOild0r2tQjmImdOPa1WZBGmSnwKd4m5zJxiHGL7bDSU+W13M+4v+NKxKBlRlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808299; c=relaxed/simple;
	bh=Ju5FiwD0/Poegw+WicEP42Mt789iqidnebQo4EBb6/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BZwV/GJvtHR3JJDghneF9p9R5c5Zoj+HEnq7LFydnz4HsLA+teEG1HxFZKkhTKZDEQNuG1ITU9TF3w3vPoEpYaXc28bonhEjouYPNHZ1ANfDhxt1nrCHrzJleJ89wFV1MtoshuZy5hXMZmO/8zXiE+fIPzFgD0Pu99NQcB1g58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=loU4GwBy; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A3E89100007;
	Tue, 19 Mar 2024 03:31:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A3E89100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710808292;
	bh=+YwZKtSaR+pjRPk6L9WeQ8b6BmPf9L3Et32PnbS21HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=loU4GwByqN5/mXr3sPY0IbEQ4WiTXG4iuIV6E5c3JKFJ/oFTF3Fzaai6uOXUIM1Rw
	 S1fSzLqsApsfzp8jo7HYC9+BOGIS8I3NrCTUCvrzVfQM3HYw/j4ZFdbWj0YbZ3OLdQ
	 +zIP6iUk6FSerAYZld7gbxkexFedcYtmDstikVEbgxnx4UJ0hrf3RIeXZ0apeZi4JK
	 bVi7aoShiICvR4VJm1iNeDP/6sIYEO+/vvkI6qMQSP3apoA0PVlwGprRyKGsvf6KBl
	 fDiXZR6veUjw0+oGU/IaJ4Pc9lMNRvA4QhH2RZqK/+a1Rz6LGE50X6SUCSOBF9Y7yW
	 klLSoot5ABQVQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 03:31:31 +0300 (MSK)
Received: from [172.28.224.29] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 03:31:30 +0300
Message-ID: <158343f2-23af-4260-b631-922d81afce88@salutedevices.com>
Date: Tue, 19 Mar 2024 03:30:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] ASoC: dt-bindings: meson: axg-pdm: document
 'sysrate' property
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman
	<khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-14-jan.dakinevich@salutedevices.com>
 <ca80caab-2664-4797-a222-e14537eea440@linaro.org>
 <1jil1nhjwd.fsf@starbuckisacylon.baylibre.com>
 <6feba9ff-8bbf-4494-93f0-732679bc4032@salutedevices.com>
 <1j1q87hkq2.fsf@starbuckisacylon.baylibre.com>
 <1jwmpzg1hq.fsf@starbuckisacylon.baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1jwmpzg1hq.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184250 [Mar 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 10 0.3.10 53c821b925e16276b831986eabc71d60ab82ee60, {Tracking_smtp_not_equal_from}, {Tracking_bl_eng_cat, c15}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/18 21:41:00 #24279760
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/18/24 15:19, Jerome Brunet wrote:
> 
> On Mon 18 Mar 2024 at 11:55, Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
>> On Sun 17 Mar 2024 at 18:52, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
>>
>>> On 3/15/24 13:22, Jerome Brunet wrote:
>>>>
>>>> On Fri 15 Mar 2024 at 11:00, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>>> On 15/03/2024 00:21, Jan Dakinevich wrote:
>>>>>> This option allow to redefine the rate of DSP system clock.
>>>>>
>>>>> And why is it suitable for bindings? Describe the hardware, not what you
>>>>> want to do in the driver.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 4 ++++
>>>>>>  1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>>> index df21dd72fc65..d2f23a59a6b6 100644
>>>>>> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>>> @@ -40,6 +40,10 @@ properties:
>>>>>>    resets:
>>>>>>      maxItems: 1
>>>>>>  
>>>>>> +  sysrate:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description: redefine rate of DSP system clock
>>>>>
>>>>> No vendor prefix, so is it a generic property? Also, missing unit
>>>>> suffix, but more importantly I don't understand why this is a property
>>>>> of hardware.
>>>>
>>>> +1.
>>>>
>>>> The appropriate way to set rate of the clock before the driver take over
>>>> is 'assigned-rate', if you need to customize this for different
>>>> platform.
>>>>
>>>
>>> It would be great, but it doesn't work. Below, is what I want to see:
>>>
>>> 	assigned-clocks =
>>> 		<&clkc_audio AUD2_CLKID_PDM_SYSCLK_SEL>,
>>> 		<&clkc_audio AUD2_CLKID_PDM_SYSCLK_DIV>;
>>> 	assigned-clock-parents =
>>> 		<&clkc_pll CLKID_FCLK_DIV3>,
>>> 		<0>;
>>> 	assigned-clock-rates =
>>> 		<0>,
>>> 		<256000000>;
>>>
>>> But regardles of this declaration, PDM's driver unconditionally sets
>>> sysclk'rate to 250MHz and throws away everything that was configured
>>> before, reparents audio2_pdm_sysclk_mux to hifi_pll and changes
>>> hifi_pll's rate.
>>>
>>> This value 250MHz is declared here:
>>>
>>> static const struct axg_pdm_cfg axg_pdm_config = {
>>> 	.filters = &axg_default_filters,
>>> 	.sys_rate = 250000000,
>>> };
>>>
>>> The property 'sysrate' is intended to redefine hardcoded 'sys_rate'
>>> value in 'axg_pdm_config'.
>>
>> What is stopping you from removing that from the driver and adding
>> assigned-rate to 250M is the existing platform ?
> 
> ... Also, considering how PDM does work, I'm not sure I get the point of
> the doing all this to go from 250MHz to 256Mhz.
> 

The point is to use fclk_div3 clock as source for PDM's sysclock and
keep hiff_pll clock free for TDM. Because, I can get 256MHz from any
hifi_pll and fclk_div3, but only hifi_pll is able to provide accurate
48kHz (after several divider).

> PDM value is sampled at ~75% of the half period. That clock basically
> feeds a counter and the threshold is adjusted based on the clock rate.
> 
> So there is no need to change the rate. Changing it is only necessary
> when the captured audio rate is extremely slow (<8kHz) and the counter
> may overflow. The driver already adjust this automatically.
> 
> So changing the input rate from 250MHz to 256MHz should not make any
> difference.
> 

Thank you for the explanation.

>>
>>>
>>>> Then you don't have to deal with it in the device driver.
>>>>
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>
>>>>
> 
> 

-- 
Best regards
Jan Dakinevich

