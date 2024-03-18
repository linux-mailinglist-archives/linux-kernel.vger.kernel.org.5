Return-Path: <linux-kernel+bounces-106762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D556F87F33A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729B41F21A74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA825B04B;
	Mon, 18 Mar 2024 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="WlS06RNI"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BC5A4DC;
	Mon, 18 Mar 2024 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801852; cv=none; b=gMgSEuORreUXnaAIlZwHheSaIHb2+QLc6JVHAYTsHaZUMj684hyYvYOsovVCAzkLAtmJFnAzs93nlwGIrsiOAUDQX3YdzTCzlInBnTYo/B7hlElQBLBWNLPdBMdhG0gWjU62ipIfKNho8oNNOgBevFLnwiWONrSyua0ODx6X3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801852; c=relaxed/simple;
	bh=QVvPe8HqF/hEu0sn46LH7OPfrbqHYTjl9rmwiW8KbI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uVj9PvVewUhPaDmvkI0QIke/avWTZcwWYjgWRG6tZtJiPwuWgDjmVNY3HfddwnXRugqqMUnmLS3SLvfJYuShWVgmFmaJZUOraSJdPfgXmxntiimbHjt+St+0JRv+TZoGqraxuZQQp8napN8vJ8eXRN61hmEQcMjmac9CVrOuY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=WlS06RNI; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6A2F1100011;
	Tue, 19 Mar 2024 01:44:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6A2F1100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710801846;
	bh=pa+89jrrCMIW8EjfG4aAgry+/vfLF62TIUqpulm7Y9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=WlS06RNIBTg0cU271+LYNhxdIVW8REnQkfL0Eq7bHWiEE2NaTUtuoRzgcod99PVOu
	 90XcrVazKIOpMrrn2Lj5waYPR3pBMpoyE/svDsna6Hn/ncEAfIi4zZg45J34L38rKP
	 lVo4tRAfocFgZCrdouhaItZsCLKbBfZq89MVAWFQJgD6s6aIvAf1uPVna8WJxugmor
	 mr6LDxYqk7REZoeeNrR4tv0MyJNkhX43aJ/+u2MHK2TfgTH/luXpJhpJbSgoUEi8Ou
	 ViJNVVN54rulbLvS7z84IQ4pLJeCbFV/tkIbru90+UwDb6C7lz+ie/jrcPfO/9lnvd
	 wZ99a9nIdhl9w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 01:44:06 +0300 (MSK)
Received: from [172.28.64.112] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 01:44:05 +0300
Message-ID: <bafa1669-e98f-4d45-b5cc-0c707df5ed52@salutedevices.com>
Date: Tue, 19 Mar 2024 01:43:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/25] ASoC: meson: t9015: add support for A1 SoC family
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-13-jan.dakinevich@salutedevices.com>
 <5f8e8cd2-f9c4-4961-a85d-a0f3217294e6@sirena.org.uk>
 <c4c0e3a3-eaa8-42c6-bbd3-e5c6993dc63b@salutedevices.com>
 <30dadd4c-de10-43a7-baf8-8ddd49f5c80e@sirena.org.uk>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <30dadd4c-de10-43a7-baf8-8ddd49f5c80e@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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
X-KSMG-AntiSpam-Info: LuaCore: 10 0.3.10 53c821b925e16276b831986eabc71d60ab82ee60, {Tracking_smtp_not_equal_from}, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/18 20:02:00 #24276844
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/18/24 16:48, Mark Brown wrote:
> On Sun, Mar 17, 2024 at 07:27:14PM +0300, Jan Dakinevich wrote:
> 
>> Both mic bias and ADC's input mode depends on schematics and should be
>> configurable. What is the better way to give access to these parameters?
>> Device tree?
> 
> Yes.
> 
>>>> +	SOC_SINGLE("ADC Mic Bias Switch", LINEIN_CFG, MICBIAS_EN, 1, 0),
>>>> +	SOC_ENUM("ADC Mic Bias Level", a1_adc_mic_bias_level),
> 
>>> Why would micbias be user controlled rather than a DAPM widget as
>>> normal?
> 
>> Yes, I could use SND_SOC_DAPM_SUPPLY, but it supports only raw values,
>> and doesn't supports enums. Here, I want to use enum to restrict
>> possible values, because only these values mentioned in the
>> documentation that I have.
> 
> A supply is an on/off switch not an enum.  Users should not be selecting
> values at all.

Ok. For me it is great if I am free to move these kcontrols to device tree.

-- 
Best regards
Jan Dakinevich

