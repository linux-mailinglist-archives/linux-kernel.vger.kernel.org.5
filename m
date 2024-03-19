Return-Path: <linux-kernel+bounces-107610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674A487FF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853DC1C22296
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D181731;
	Tue, 19 Mar 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZdXJ+IUo"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B680BFD;
	Tue, 19 Mar 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856400; cv=none; b=YnbwmPywisBQPMi0F7R9IPfzTFmeqw833TjG+IFLYiJefq0YBBWEZUp6reGTfs3IbKrIGTnxxOJx+o8I2EM+5AV4MRgQOlE7jiPmtQR/W0/oCy61TY7VnelDiSmO7vI+MnLSSu0SZNi67aV5oqleE2P1h9kByF24g8ruu/PEj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856400; c=relaxed/simple;
	bh=OXZgPwWPdTNaxtMnH4myg+ToziRSNnXvhkwXx1ZufmU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/8P5/w41ZhMAOV4Ao35XkNBYUaPLpnh59pm4ubf7gkptaZaCm7JzpL9lZSS4CLwPHxOBpFnC+yw3x+6C7QIXa3/FPeeIE9+WdqZcWA9l9C9h8Umqj6KGN1JpOgPUYWtG2kQdH5OF3HaOp2DqGsqeQ/2nk6EekG8Kzsc2qIztTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ZdXJ+IUo; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0957D10000A;
	Tue, 19 Mar 2024 16:53:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0957D10000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710856392;
	bh=cMQFR177UDppiHHa9pB9nbmCdpBrIycSstEw9RoGTQI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ZdXJ+IUoxafVJmHArgilqIq/xR+cA8woWE5N9r6qzBMaWFunn7syOsKx8qLG8PS9j
	 vQ83YE4Sbd4e2GyM/LXFVj5CQEzYiLvCcu31GAteRYOud+OnUBzC23Uf/Xqzn91k3G
	 ST/k5QpvS04ZBnytrGLzHPs3ec/4lGwCGF1I6Z0yPqQCyvYoG1ITUtXLW7gjQFLDOv
	 oH3k8K5Ak8eAwJJDsOFfN4BFtfd2MH2RBk9JpLmvU0nmCx8BeYg+zHF8roQ5tmlLJ6
	 CW/G29alyisg1jGq+assolGMSWPgFNCYosGKMcHu2B9G5KWPNSyYdnYJtcU7RobrrC
	 IKjlAIup7GSgw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 16:53:11 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 16:53:11 +0300
Date: Tue, 19 Mar 2024 16:53:11 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
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
Subject: Re: [PATCH 01/25] clk: meson: a1: restrict an amount of 'hifi_pll'
 params
Message-ID: <20240319135311.xjpgkvgyczq4eymi@CAB-WSD-L081021>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-2-jan.dakinevich@salutedevices.com>
 <1j8r2jj24k.fsf@starbuckisacylon.baylibre.com>
 <cbfd9c66-cca5-49f5-9468-43710c48518e@salutedevices.com>
 <1jedc7hlg4.fsf@starbuckisacylon.baylibre.com>
 <d4cfef9e-3cae-4f1a-90b3-33d5707596f9@salutedevices.com>
 <1jsf0mfwwg.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jsf0mfwwg.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184265 [Mar 19 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 10 0.3.10 53c821b925e16276b831986eabc71d60ab82ee60, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/19 13:26:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/19 13:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/19 01:36:00 #24282057
X-KSMG-AntiVirus-Status: Clean, skipped

On Tue, Mar 19, 2024 at 09:21:27AM +0100, Jerome Brunet wrote:
> 
> On Tue 19 Mar 2024 at 01:35, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
> > On 3/18/24 13:17, Jerome Brunet wrote:
> >> 
> >> On Sun 17 Mar 2024 at 17:17, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> >> 
> >>> On 3/15/24 11:58, Jerome Brunet wrote:
> >>>>
> >>>> On Fri 15 Mar 2024 at 02:21, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> >>>>
> >>>>> Existing values were insufficient to produce accurate clock for audio
> >>>>> devices. New values are safe and most suitable to produce 48000Hz sample
> >>>>> rate.
> >>>>
> >>>> The hifi pll is not about 48k only. I see no reason to restrict the PLL
> >>>> to a single setting.
> >>>>> You've provided no justification why the PLL driver can't reach the same
> >>>> setting for 48k. The setting below is just the crude part. the fine
> >>>> tuning is done done with the frac parameter so I doubt this provides a
> >>>> more accurate rate.
> >>>>
> >>>
> >>> You are right, it is not about 48k only. However, there are two issues.
> >>>
> >>> First, indeed, I could just extend the range of multipliers to 1..255.
> >> 
> >> Why 1..255 ? This is not what I'm pointing out
> >> 
> >> According to the datasheet - the range is 32 - 64, as currently
> >> set in the driver.
> >> 
> >
> > Could you point where in the doc the range 32..64 is documented?
> > Documentation that I have may be not so complete, but I don't see there
> > any mention about it.
> >
> > Anyway, range 32..64 of multipliers is not enough to produce accurate
> > clock, and a need 128 for 48kHz.
> 
> A1 datasheet v0.4 - Section 7.6.3.2
> 
> >
> >> The change you have provided request a multipler of 128/5 = 25,6
> >> If you put assigned-rate = 614400000 in DT, I see no reason can find the
> >> same solution on its own.
> >> 
> >
> > The reasoning is following. I don't know why 32..64 range was declared
> > for this clock, and whether it would be safe to extend it and include
> > 128, which is required for 48kHz. But I know, that multiplier=128 is
> > safe and works fine (together divider=5).
> 
> You have not answer my remark.
> Mainline does not do everything like the AML SDK does. Saying you are
> copying it because you know it works (in your opinion) is not good
> enough.
> 
> I'm telling you that your hack is not necessary and so far, you have not
> demonstrated that it is.
> 
> Also the multiplier range in m/n, not m alone.
> 
> >
> >>> But I am unsure if hifi_pll is able to handle whole range of
> >>> mulptipliers. The value 128 is taken from Amlogic's branch, and I am
> >>> pretty sure that it works.
> >> 
> >>>
> >>> Second, unfortunately frac parameter currently doesn't work. When frac
> >>> is used enabling of hifi_pll fails in meson_clk_pll_wait_lock(). I see
> >>> it when try to use 44100Hz and multipliers' range is set to 1..255. So,
> >>> support of other rates than 48k requires extra effort.
> >> 
> >> Then your change is even more problematic because it certainly does not
> >> disable frac ... which you say is broken.
> >> 
> >> That parameter should be removed with a proper comment explaining why
> >> you are disabling it. That type a limitation / known issue should be
> >> mentionned in your change.
> >> 
> >
> > Handling of frac should not be removed, it should be fixed to achieve
> > another rates. But that is not the goal of this commit.
> 
> You argued that frac was broken and that was partly why you introduced
> this work around. I'm telling you this approach is incorrect.
> 
> So either :
> * Remove frac for now, until it is fixed, because it is broken and add
>   comment clearly explaining that quirk.
> * Or fix it now.
> 
> Your choice.
> 
> >
> >
> >>>
> >>>>>
> >>>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> >>>>> ---
> >>>>>  drivers/clk/meson/a1-pll.c | 8 ++++----
> >>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> >>>>> index 4325e8a6a3ef..00e06d03445b 100644
> >>>>> --- a/drivers/clk/meson/a1-pll.c
> >>>>> +++ b/drivers/clk/meson/a1-pll.c
> >>>>> @@ -74,9 +74,9 @@ static struct clk_regmap fixed_pll = {
> >>>>>  	},
> >>>>>  };
> >>>>>  
> >>>>> -static const struct pll_mult_range hifi_pll_mult_range = {
> >>>>> -	.min = 32,
> >>>>> -	.max = 64,
> >>>>> +static const struct pll_params_table hifi_pll_params_table[] = {
> >>>>> +	PLL_PARAMS(128, 5),
> >>>>> +	{ },
> >>>>>  };
> >>>>>  
> >>>>>  static const struct reg_sequence hifi_init_regs[] = {
> >>>>> @@ -124,7 +124,7 @@ static struct clk_regmap hifi_pll = {
> >>>>>  			.shift   = 6,
> >>>>>  			.width   = 1,
> >>>>>  		},
> >>>>> -		.range = &hifi_pll_mult_range,
> >>>>> +		.table = hifi_pll_params_table,
> >>>>>  		.init_regs = hifi_init_regs,
> >>>>>  		.init_count = ARRAY_SIZE(hifi_init_regs),
> >>>>>  	},
> >>>>
> >>>>
> >> 
> >> 
> 
> 
> -- 
> Jerome

BTW, here Amlogic already mentioned all possible output audio rates for
which hifipll can be used:

https://lore.kernel.org/all/1569411888-98116-1-git-send-email-jian.hu@amlogic.com/T/#md7083b4f851ab97dfce43f8f6a3b266eb49ed329

```
The audio working frequency are 44.1khz, 48khz and 192khz.

614.4M can meet the three frequency.

after the hifi pll, there are two dividers in Audio clock.

614.4M/3200 = 192khz

614.4M/12800 = 48khz

614,4M/13932 = 44.0999khz
```

-- 
Thank you,
Dmitry

