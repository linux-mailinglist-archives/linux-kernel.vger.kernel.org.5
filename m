Return-Path: <linux-kernel+bounces-105398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15F87DD63
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7D71C20987
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD051C288;
	Sun, 17 Mar 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="uv7Lm/X9"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B91BF27;
	Sun, 17 Mar 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710685092; cv=none; b=qRSrAz/v19tiLpNTLCaaDa3nq/uLKnxvqZqzoAQRPeH3g8a5jLgs8aLtKHkqLGz9aO7SKKsBu/DswgPqIZRd6I3LbjsPEoAW91VeSY7R40DjLmF6G7KAt8o66k8+lUzSRPeOtshfNCtNSji8pUkKsczRTmrGH3TFurvmsWwkLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710685092; c=relaxed/simple;
	bh=xAVsxMnJoqTUvzQY5QFOBDRP+AQP097SoH7H4Z6KpPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OSTOA+nVJx/x1Ks3Z825/odkZ7II9bqpcZPYAeOGA1m0/rTpX+Ut2CfdmZrpC0UsA7jNpDp4ZojueO6yskepSgmKioC0HgdaSYeruFlNxPGzswl/JJYBZ0C4Y/rOIEcPopKtZOqQpu5uTGdNbjztKQmdPyvKOJ2H0Kyvw3Ri2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=uv7Lm/X9; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id EEF53100004;
	Sun, 17 Mar 2024 17:17:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EEF53100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710685075;
	bh=SQRSKK7y7FzIxWfxLiQrXC7XGIdk++wvMoC5iAR3Cb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=uv7Lm/X9X5z1ZUSUWfoS0ttfd/72rpm6SUnpRRaNa24NwI+up88M2sXcGcvi9f9YN
	 Jig10wMsHnHwV3wanec2UWaKwWicjrcIw9dzuHtmOHhcc7uYxFsB3ysm6RbjCzKe6y
	 jFKr94t1wofL3qvT2jXHDt0cZ9TG2LvhthtFoXo8mnq8bJQBPmuOH+d043V2q04tZW
	 98zrHAAMKuh6hEZvYg4S/n02z1WyFyc8uh7Y4DQZO2og/ahv9LdqCGSLBmonIYf9hv
	 V9kuUDEqBFP9SD9NKttW20YDJR+hHD4daPmB+e6xNuANLo3Bwgo7cs0+9iYR4UQ95k
	 jIktZ299+OK9Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Mar 2024 17:17:55 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 17:17:55 +0300
Message-ID: <cbfd9c66-cca5-49f5-9468-43710c48518e@salutedevices.com>
Date: Sun, 17 Mar 2024 17:17:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] clk: meson: a1: restrict an amount of 'hifi_pll'
 params
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
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
 <20240314232201.2102178-2-jan.dakinevich@salutedevices.com>
 <1j8r2jj24k.fsf@starbuckisacylon.baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1j8r2jj24k.fsf@starbuckisacylon.baylibre.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/15/24 11:58, Jerome Brunet wrote:
> 
> On Fri 15 Mar 2024 at 02:21, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> Existing values were insufficient to produce accurate clock for audio
>> devices. New values are safe and most suitable to produce 48000Hz sample
>> rate.
> 
> The hifi pll is not about 48k only. I see no reason to restrict the PLL
> to a single setting.
> > You've provided no justification why the PLL driver can't reach the same
> setting for 48k. The setting below is just the crude part. the fine
> tuning is done done with the frac parameter so I doubt this provides a
> more accurate rate.
> 

You are right, it is not about 48k only. However, there are two issues.

First, indeed, I could just extend the range of multipliers to 1..255.
But I am unsure if hifi_pll is able to handle whole range of
mulptipliers. The value 128 is taken from Amlogic's branch, and I am
pretty sure that it works.

Second, unfortunately frac parameter currently doesn't work. When frac
is used enabling of hifi_pll fails in meson_clk_pll_wait_lock(). I see
it when try to use 44100Hz and multipliers' range is set to 1..255. So,
support of other rates than 48k requires extra effort.

>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  drivers/clk/meson/a1-pll.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
>> index 4325e8a6a3ef..00e06d03445b 100644
>> --- a/drivers/clk/meson/a1-pll.c
>> +++ b/drivers/clk/meson/a1-pll.c
>> @@ -74,9 +74,9 @@ static struct clk_regmap fixed_pll = {
>>  	},
>>  };
>>  
>> -static const struct pll_mult_range hifi_pll_mult_range = {
>> -	.min = 32,
>> -	.max = 64,
>> +static const struct pll_params_table hifi_pll_params_table[] = {
>> +	PLL_PARAMS(128, 5),
>> +	{ },
>>  };
>>  
>>  static const struct reg_sequence hifi_init_regs[] = {
>> @@ -124,7 +124,7 @@ static struct clk_regmap hifi_pll = {
>>  			.shift   = 6,
>>  			.width   = 1,
>>  		},
>> -		.range = &hifi_pll_mult_range,
>> +		.table = hifi_pll_params_table,
>>  		.init_regs = hifi_init_regs,
>>  		.init_count = ARRAY_SIZE(hifi_init_regs),
>>  	},
> 
> 

-- 
Best regards
Jan Dakinevich

