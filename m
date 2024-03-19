Return-Path: <linux-kernel+bounces-106865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCC987F4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FBA1F24227
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4741BA40;
	Tue, 19 Mar 2024 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="LhUwNjh/"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE6846D;
	Tue, 19 Mar 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808566; cv=none; b=gRNxgh0cpuH82xw6s3rW+mZeZo55cMceTGogBBSzJkWnOoZEtX9qLQ35ojwbLcDpTKMb1af5JhKfifYM8gJq/vcbE3nzQde9WILBrTkxxJHJTsXraDcm0k9T6Slw9D+2eVoDdpaZ5V+hVpxOly6wQhYNJP1rooAfQmTLQYmU5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808566; c=relaxed/simple;
	bh=D/vU+aKG4bOtngerNGs+IR+QCiFa7x2M/xMzsX6g700=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AgP4pApJjOVuPBLyoSNxeZRXkyN57XnBbvT9zQsR9zhcdpUdCEUQI5nmuScjPRnRlCONu0uqJ33sw2oQmlYfTDqIVmleNYb6mcZBYEZMUU2V/Wcp8w8AYesDs16gxl1uIiYjnkYO5F1TBnStZiaTrcD+je0QUPjgeujyo6omJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=LhUwNjh/; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 152E012000B;
	Tue, 19 Mar 2024 03:36:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 152E012000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710808561;
	bh=IAxjzQO549n6P/EQrOvtcZd9jtdlj6D3hmWwNuQy9Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=LhUwNjh/OPWvv6aoHqGKCaLkSsX7rh/W4H5kTq+ISfFzLcpWhp+Ixak1WHXuZMoAn
	 oi5/gc+Xs6S/D2j6sR5tFiITakeVQH2W4B79cxb2D+C+rquGbGizqg9RK1W6aZOPfG
	 FJEF8yZgA3mU63iaxki34WK5J2uGPvBrab+XHgkJMiDwlt/C8kFsetQ6O0hf13ybS9
	 T/kfuLb3ILNWrGLd7ppHPAyPZNCBFiCXZ1JR2/ArFCtuf/1HQya6fU6mSYMXYGFvuF
	 cyXEncC2vfCBUI25XWeGfePQ1BL3KCpmNCWvW6HcaOoy0d4ceiK8ugMK71vlyH3gVB
	 /bbVz/B4p2NaA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 03:36:00 +0300 (MSK)
Received: from [172.28.224.29] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 03:36:00 +0300
Message-ID: <3d8f23ce-1864-4cef-9895-209aff599bfa@salutedevices.com>
Date: Tue, 19 Mar 2024 03:35:14 +0300
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
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1j1q87hkq2.fsf@starbuckisacylon.baylibre.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 10 0.3.10 53c821b925e16276b831986eabc71d60ab82ee60, {Tracking_smtp_not_equal_from}, {Tracking_bl_eng_cat, c15}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/18 21:41:00 #24279760
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/18/24 13:55, Jerome Brunet wrote:
> 
> On Sun 17 Mar 2024 at 18:52, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> On 3/15/24 13:22, Jerome Brunet wrote:
>>>
>>> On Fri 15 Mar 2024 at 11:00, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 15/03/2024 00:21, Jan Dakinevich wrote:
>>>>> This option allow to redefine the rate of DSP system clock.
>>>>
>>>> And why is it suitable for bindings? Describe the hardware, not what you
>>>> want to do in the driver.
>>>>
>>>>>
>>>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>> index df21dd72fc65..d2f23a59a6b6 100644
>>>>> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>> @@ -40,6 +40,10 @@ properties:
>>>>>    resets:
>>>>>      maxItems: 1
>>>>>  
>>>>> +  sysrate:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description: redefine rate of DSP system clock
>>>>
>>>> No vendor prefix, so is it a generic property? Also, missing unit
>>>> suffix, but more importantly I don't understand why this is a property
>>>> of hardware.
>>>
>>> +1.
>>>
>>> The appropriate way to set rate of the clock before the driver take over
>>> is 'assigned-rate', if you need to customize this for different
>>> platform.
>>>
>>
>> It would be great, but it doesn't work. Below, is what I want to see:
>>
>> 	assigned-clocks =
>> 		<&clkc_audio AUD2_CLKID_PDM_SYSCLK_SEL>,
>> 		<&clkc_audio AUD2_CLKID_PDM_SYSCLK_DIV>;
>> 	assigned-clock-parents =
>> 		<&clkc_pll CLKID_FCLK_DIV3>,
>> 		<0>;
>> 	assigned-clock-rates =
>> 		<0>,
>> 		<256000000>;
>>
>> But regardles of this declaration, PDM's driver unconditionally sets
>> sysclk'rate to 250MHz and throws away everything that was configured
>> before, reparents audio2_pdm_sysclk_mux to hifi_pll and changes
>> hifi_pll's rate.
>>
>> This value 250MHz is declared here:
>>
>> static const struct axg_pdm_cfg axg_pdm_config = {
>> 	.filters = &axg_default_filters,
>> 	.sys_rate = 250000000,
>> };
>>
>> The property 'sysrate' is intended to redefine hardcoded 'sys_rate'
>> value in 'axg_pdm_config'.
> 
> What is stopping you from removing that from the driver and adding
> assigned-rate to 250M is the existing platform ?
> 

Ok, in next version I will try to remove this unconditional setting of
rate that spoils my clock hierarchy.

>>
>>> Then you don't have to deal with it in the device driver.
>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>>
> 
> 

-- 
Best regards
Jan Dakinevich

