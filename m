Return-Path: <linux-kernel+bounces-105459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3187DE26
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB7F1C21121
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21F51CAAE;
	Sun, 17 Mar 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Im5kzRqy"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19471CA89;
	Sun, 17 Mar 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690786; cv=none; b=pXBNwi08XvND0EzGr13NQmd2XkYn5fKWWS7cIRjSwhb5pQY4cUiQ7ypPSaJW/dCea9ty9jjdvfZ9pQ10HCT8PrC25W6QGxafb/DnLg7BtZqYHK2tfjNwNvuWbLx5za7GCCmCEJnXcxr5R/j8+9UmYq7O+Lr67WehQkZ4wwhBCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690786; c=relaxed/simple;
	bh=qsTKkYK8XLaq+bP09hviff9XCpX1URpEQAcuflFdBMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PwXfzTfTayJys/WYr+VZQcm/Hb++QyN3jq3/oc73UXhrhgmqgKmBUkdtkST43e8/BJ5MI0wHgixpFiikmnD8mYeT2T4DOxo4f15eXW6adMAqOFSIvKYcFFPwafkikPFWDRis9LH2xGJRPGpXFEsqRKrumBG8RFYiZzexdMBDMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Im5kzRqy; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1D9C6120006;
	Sun, 17 Mar 2024 18:52:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1D9C6120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710690778;
	bh=2fXEQU7bzeWiACJtGqRgHPd3Ag2CN/m9BE/2cm5CYJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Im5kzRqyELCdF4Gjpz1R3jykdpheWCh6sK9BUQtGC88e8Z/8fMeV2MIbXm5q5Wrn2
	 /WBs2dSQ9ZnQ/sqJKRTg8O49Td+5xztyGIXVC2nmDK+7TfYdpcAm/OfDyJLUZ30Lqi
	 XyZMLcbSa//eOm3uxhk+dIn/OqYYbv4AcxhapXXAOMFrfl+Cn4agxPa3QWueneIbzT
	 BmXP4C+ADdarEvFqUtPjQYH6SMM2Jzz7BL4tg/A0COchOXB6NK+4l3pPcuow1LSLxz
	 Dde27KRXh7qD8nkNcMjQzufxcFTzzKQQzklGkT1ruHGzeF7pZfahNWb7mIZETGIX5r
	 cj1bQWsurQ6Mw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Mar 2024 18:52:57 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 18:52:57 +0300
Message-ID: <6feba9ff-8bbf-4494-93f0-732679bc4032@salutedevices.com>
Date: Sun, 17 Mar 2024 18:52:15 +0300
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
To: Jerome Brunet <jbrunet@baylibre.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
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
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1jil1nhjwd.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_bl_eng_cat, c15}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/15/24 13:22, Jerome Brunet wrote:
> 
> On Fri 15 Mar 2024 at 11:00, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 15/03/2024 00:21, Jan Dakinevich wrote:
>>> This option allow to redefine the rate of DSP system clock.
>>
>> And why is it suitable for bindings? Describe the hardware, not what you
>> want to do in the driver.
>>
>>>
>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>> ---
>>>  Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>> index df21dd72fc65..d2f23a59a6b6 100644
>>> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>> @@ -40,6 +40,10 @@ properties:
>>>    resets:
>>>      maxItems: 1
>>>  
>>> +  sysrate:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: redefine rate of DSP system clock
>>
>> No vendor prefix, so is it a generic property? Also, missing unit
>> suffix, but more importantly I don't understand why this is a property
>> of hardware.
> 
> +1.
> 
> The appropriate way to set rate of the clock before the driver take over
> is 'assigned-rate', if you need to customize this for different
> platform.
> 

It would be great, but it doesn't work. Below, is what I want to see:

	assigned-clocks =
		<&clkc_audio AUD2_CLKID_PDM_SYSCLK_SEL>,
		<&clkc_audio AUD2_CLKID_PDM_SYSCLK_DIV>;
	assigned-clock-parents =
		<&clkc_pll CLKID_FCLK_DIV3>,
		<0>;
	assigned-clock-rates =
		<0>,
		<256000000>;

But regardles of this declaration, PDM's driver unconditionally sets
sysclk'rate to 250MHz and throws away everything that was configured
before, reparents audio2_pdm_sysclk_mux to hifi_pll and changes
hifi_pll's rate.

This value 250MHz is declared here:

static const struct axg_pdm_cfg axg_pdm_config = {
	.filters = &axg_default_filters,
	.sys_rate = 250000000,
};

The property 'sysrate' is intended to redefine hardcoded 'sys_rate'
value in 'axg_pdm_config'.

> Then you don't have to deal with it in the device driver.
> 
>>
>> Best regards,
>> Krzysztof
> 
> 

-- 
Best regards
Jan Dakinevich

