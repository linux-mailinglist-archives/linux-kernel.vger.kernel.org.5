Return-Path: <linux-kernel+bounces-98047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73097877407
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921051C21A63
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0C251021;
	Sat,  9 Mar 2024 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="k853Yonz"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37CE4F1EA;
	Sat,  9 Mar 2024 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710019266; cv=none; b=WnWGZB1fJNe32BIYm0E1oWUEeP6pR6fAxCVVvgOAPfUUrgI+12ro6rqx2KENqY8h60Yoa372N2H4eWW/QLkzxpZAc220TxItb768rtG+OfyW388uWXptZfNwtKwn29eUspJcu0YpnYAgAP8ia/9Li2KtrRYdtOn1+r/rQYxqRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710019266; c=relaxed/simple;
	bh=7Qay2Nui6BSw/YgKhNOWdIrnxtIU9qyJKkrZr+1I6kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LpFxpWEe/N2M3dtOl/byKUZo2jxie4rzeETXeZgXB38X/zLDY4lzKnWWmOgQPm3r/gJIrZ5sdleX3K4C/8RHDdqHWb4qlCbQKglXugx9AQJVbXdNcdsmZGBOgicoMUhVLw8CIIlE8a8hzCWgmHjG9qhosrK5QgzPTAZ2aGeE4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=k853Yonz; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BB2FE120002;
	Sun, 10 Mar 2024 00:20:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BB2FE120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710019249;
	bh=1x0/UPLw/DfjSrLeMpQgocKnbvKcJ+/lW/fGDXkjQnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=k853Yonzy1J59PCv6b7KiaY/zc2AvRg/gXIoFRA7REfR29W4zfTZCWtMNcdJRLeGP
	 Zvjd3fuCw0BTw6Eiy9aOexyZ89dbGWDD2tt+0HqAIUGQGbxR7q9/DXuWDEcc8OfqUA
	 yjDHr2534eIDWowLpsaEDcxJ2fg5vRkyM7G8FhiWYm5e8dxUuhRh6HtOTgO4AgC0o5
	 URUrhHe2Bg7rxilNs7EzfTcDA8c31yJ9W9E9MR5MKgyCQJKEgqjR+B//vcORJNWbZv
	 6bXRwzIGpt06/w4zeWTP9HhVG2KdvlMBTyI8kZR3zEubZqWWTB+LOmkQNMBWF31YhW
	 6ytYpwYag7VEQ==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru [172.24.196.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 10 Mar 2024 00:20:49 +0300 (MSK)
Received: from [172.28.226.86] (100.64.160.123) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 10 Mar 2024 00:20:49 +0300
Message-ID: <0e6a3287-9898-4c67-8c44-50b5acba4d61@salutedevices.com>
Date: Sun, 10 Mar 2024 00:20:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: allow to skip clk_core_req_round_rate_nolock()
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kernel@salutedevices.com>
References: <20240126201433.1830600-1-jan.dakinevich@salutedevices.com>
 <c79909e4e55badc8f094d2ff8c4d34ca.sboyd@kernel.org>
 <9922942e-ea9e-4cdb-a091-5b8ea0a180d8@salutedevices.com>
 <e4c1e89450aa91ec684a48797bb5d132.sboyd@kernel.org>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <e4c1e89450aa91ec684a48797bb5d132.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/29 16:52:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/29 16:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped



On 2/29/24 05:16, Stephen Boyd wrote:
> Quoting Jan Dakinevich (2024-02-23 13:47:35)
>>
>>
>> On 2/23/24 02:20, Stephen Boyd wrote:
>>> Quoting Jan Dakinevich (2024-01-26 12:14:33)
>>>> Calling of clk_core_req_round_rate_nolock() can be time-consuming in a
>>>> case of deep hierarchy with multiple dividers/parents. But if the clock
>>>> already has exactly the same rate as desired, there is no need to
>>>> determine how it could be rounded.
>>>
>>> What exactly are you trying to avoid? Is this an optimization or a bug
>>> fix? TL;DR: I'm unlikely to apply this patch.
>>>
>>
>> It is an optimization, not a bug. The problem is that 
>> clk_core_req_round_rate_nolock() is quite expensive, and I faced with 
>> cases, where it takes tens and hundreds milliseconds (depending on SoC).
>>
>> As I see, it is irremovable feature of clk_core_req_round_rate_nolock() 
>> design itself. Lets imagine, we have some clock, and its parent is a 
>> divider. When clk_core_req_round_rate_nolock() is being called the 
>> execution is walked through the following path:
>>
>> clk_core_determine_round_nolock
>>   core->ops->determine_rate
>>     divider_determine_rate
>>      clk_divider_bestdiv
>>
>> Inside clk_divider_bestdiv() for each possible divider 
>> clk_hw_round_rate() is called for parent of the clock, which in turn 
>> calls clk_core_determine_round_nolock().
>>
>> So, each divider and multiplexer in clock path multiplies many times an 
>> amount of iteration required to execute 
>> clk_core_req_round_rate_nolock(). When there are a lot of them the time 
>> consumed by clk_core_req_round_rate_nolock() becomes sufficient.
> 
> Do you have a more concrete example? I wonder if perhaps you've split up
> the clk hardware into multipliers and dividers, when they really could
> all be combined into one clk that does all the math at once without
> traversing the tree. But if the problem is really just that the
> clk_divider_bestdiv() implementation is slow then that's good to know.
> 

My experience related to audio stack on Amlogic SoCs. For example, below
is clock hierarchy on AXG SoC:

xtal

hifi_pll_dco

hifi_pll

aud_mst_c_mclk_sel

aud_mst_c_mclk_div

aud_mst_c_mclk

aud_mst_c_sclk_pre_en

aud_mst_c_sclk_div

aud_mst_c_sclk_post_en

aud_mst_c_lrclk_div

aud_mst_c_lrclk

aud_tdmout_c_lrclk

on A1 SoC (which is my target) it will be almost identical, but it is
not upstreamed yet:

xtal

hifipll_in

hifi_pll

audio_mst_a_mclk_mux

audio_mst_a_mclk_div

audio_mst_a_mclk

audio_mst_a_sclk_pre_en

audio_mst_a_sclk_div

audio_mst_a_sclk_post_en

audio_mst_a_lrclk_div

audio_mst_a_lrclk

audio_tdmout_a_lrclk

Clock setting operation that takes too long is here:

https://elixir.bootlin.com/linux/v6.7/source/sound/soc/meson/axg-tdm-interface.c#L279

In both cases there are three divider. When I artificially make that one
of these dividers has single value (using clk_div_table) it
significantly decreases the time that spent by clk_set_rate(): less then
1ms instead ~300ms on A1 SoC.


>>> I could see some driver implementing round_rate()/determine_rate() in a
>>> way that rounds the rate passed in, so that even if the rate is what the
>>> clk is running at _right now_, it still wants to change it to something
>>> else, or at least call down into the driver to call the set_rate clk_op.
>>> Applying this patch will break that. The contract is that
>>> clk_set_rate(rate) == clk_set_rate(clk_round_rate(rate)). It doesn't
>>> look like anything needs to change.
>>
>> If I am not mistaken, clocks's rate is either equal to its parent rate 
>> or calculated by ->recalc_rate(). I suppose, this callback should return 
>> valid rate value that is based on current clock parameters.
>>
>> Now, suppose the clock has rate "rateA" and we called clk_set_rate() to 
>> set "rateA", but clk_core_req_round_rate_nolock() inside clk_set_rate() 
>> rounds it to "rateB". Thus, although the clock is able to run on desired 
>> rate (and actually run on it), ->determine_rate() and ->round_rate() are 
>> unable to choose clocks's parameters for that value. Is it correct 
>> behavior for clock driver?
>>
> 
> It's not really a question for the clk framework. If the clk driver
> wants to round rateA to rateB then it can. It could be that the
> recalc_rate() clk_op calculates a slightly different rate than what
> round_rate() clk op did, because maybe the driver has frequency tables
> and the rate the clk runs at is something like 933333Hz but the driver
> just says that's 930000Hz for simplicity. If that happens, recalc_rate()
> gives us the "true" rate, while round_rate() gives us the "approximate"
> rate. Either way, the set_rate() clk_op knows that 930000Hz means set
> some clk rate, even if that doesn't match what recalc_rate() returns
> once the rate is changed.
> 
> This is very much a real case, because this is essentially how the qcom
> clk driver works.

Ok. Got it.

-- 
Best regards
Jan Dakinevich

