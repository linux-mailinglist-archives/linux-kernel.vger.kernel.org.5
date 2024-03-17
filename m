Return-Path: <linux-kernel+bounces-105473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A046987DE88
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401241F21BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F531DA4E;
	Sun, 17 Mar 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="tW0w0m6R"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9DF208A3;
	Sun, 17 Mar 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692886; cv=none; b=CmaGoPkG3+n8UGc93yWt0JWfx1fdRPMobcx7cHCZeMZA9MjG29j+NWksuf8w7RvpMoQZAYlmXYJMivWrNtBMO2bdfoktLfI/SAWY0QRAbfEsA0QNJdFHEbnTu4HxMM4fn212Ax6DhCMTvZJdT4b18YpJ9oEWRQOHZsSOFKWXo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692886; c=relaxed/simple;
	bh=FZB+Ru54xR1WMMpBS6VYjrA31Nq/JCKODbm5lDsavoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PXzvQBfPvY8vS6is8lBW1on166a2j0pEO+Oxa7dwIHrOZAbaWAo9doH6ZnpIp55Mg9Q7jY75lBHQeeWLWmFdON6oC+7M6zPokoy978ch+K/pAp9rYrwgtdxgRTsHmKUE6YOTy1f3BBTpdM9gbwX+9OanS9t1g6YMWdbwJNYtZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=tW0w0m6R; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 74482100006;
	Sun, 17 Mar 2024 19:27:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 74482100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710692877;
	bh=4qS7So0Sq9vro7xE2zLDXeUD46+3m6X+u8Tq5QOIzBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=tW0w0m6RJF1gAE8R44hsxulHFsWnRUpT4WgEYVKp1z2mHww8GdOgs2W7gkOyYeZrA
	 0doNe4sA+BxnMVi/5Zdk1modCoIZUj3NeT/bbbgCZPCpOEBHjHbfIr079ybI5Bma3y
	 gGHNhvIVgsk94SRBmJbiYquUXAW9zSPHnQSUwSKZpEPEYRESbpBGpco6KMbOk20/xR
	 4BNgal5O4neLf422l9A9Tf4nP++vFSjgunGVtQvOjE1EOw5Rog/YBc7126L7bf1ulE
	 1ZXf++qiKcaT2HXRPbzn9TjrMta/y8+rcd8VbGWdFkRow50TRXjmfBHBxr1dSGlUUC
	 E2RZul9be+Ozg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Mar 2024 19:27:57 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 19:27:56 +0300
Message-ID: <c4c0e3a3-eaa8-42c6-bbd3-e5c6993dc63b@salutedevices.com>
Date: Sun, 17 Mar 2024 19:27:14 +0300
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
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <5f8e8cd2-f9c4-4961-a85d-a0f3217294e6@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/15/24 16:36, Mark Brown wrote:
> On Fri, Mar 15, 2024 at 02:21:48AM +0300, Jan Dakinevich wrote:
> 
>> +static const char * const a1_adc_mic_bias_level_txt[] = { "2.0V", "2.1V",
>> +	"2.3V", "2.5V", "2.8V" };
>> +static const unsigned int a1_adc_mic_bias_level_values[] = { 0, 1, 2, 3, 7 };
> 
> Why would this be varied at runtime rather than being something fixed
> when the system is designed?
> 
>> +static const char * const a1_adc_pga_txt[] = { "None", "Differential",
>> +	"Positive", "Negative" };
>> +static const unsigned int a1_adc_pga_right_values[] = { 0, PGAR_DIFF,
>> +	PGAR_POSITIVE, PGAR_NEGATIVE };
>> +static const unsigned int a1_adc_pga_left_values[] = { 0, PGAL_DIFF,
>> +	PGAL_POSITIVE, PGAL_NEGATIVE };
> 
> Similarly here.
> 

Both mic bias and ADC's input mode depends on schematics and should be
configurable. What is the better way to give access to these parameters?
Device tree?

>> +	SOC_SINGLE("ADC Mic Bias Switch", LINEIN_CFG, MICBIAS_EN, 1, 0),
>> +	SOC_ENUM("ADC Mic Bias Level", a1_adc_mic_bias_level),
> 
> Why would micbias be user controlled rather than a DAPM widget as
> normal?

Yes, I could use SND_SOC_DAPM_SUPPLY, but it supports only raw values,
and doesn't supports enums. Here, I want to use enum to restrict
possible values, because only these values mentioned in the
documentation that I have.

-- 
Best regards
Jan Dakinevich

