Return-Path: <linux-kernel+bounces-93493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC787309A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF593B24AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780C5D730;
	Wed,  6 Mar 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="z7ULDoGJ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B517742;
	Wed,  6 Mar 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713446; cv=none; b=o6axp7Tdg5iHNZc0mODhH7yqLpKqn4RD7yw+3E9qzSzfUSdJjY0G7b6MbOtwETHkRnHkfrPjVhtsLbajS43faMT+U24FDkzmuORwuvFkbJbFMTI/aPzhyedAP0nEn5zvjp3ZE9gcZfsbfFQ8jHHljYBmaDZatCdVPEJlY+jyGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713446; c=relaxed/simple;
	bh=avi3s/FLxkX7grCL8/bkpLAuIzuIxOYGkRAv8Br88SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgOoRWxh3Vi0aZK0smmrdOjGQ9oMNITg6OfwJhF/Y3OHw2HxsBMkL6SZRE5jgCZ78WFz5Ny/Ys0aBjdnuoYmjUL+IgpjoLhV26qCyD8YvT4tfYulHqqjVgYy3M/QVu3kzyyb0drk6In5ydXBm++aPHa+HLNi75VX6uYchIwyVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=z7ULDoGJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=dP4C4A5WCdxvCJCpj0oUh+9+DdThZPg4vHyHIY5V3mA=;
	t=1709713444; x=1710145444; b=z7ULDoGJEdsOD/HUiThsgVzA9tOvLjMxKTYsEWlJ23NeCyG
	HglRGiZDgZzWzMF8cBsap3L5GFhZydA+0fTLaVGbHc3CHx7nQPiSS3npk3NCQLgz+Lu95sOXWaIKY
	EUfVVW6VKlj/qgq9+B+ZtAOUaaxh9FgxUZG65wGBJ1ji3LqnHipFqTLm5nf/a4ryBMrAjoKFJgnZA
	ZXOHkR9Pgyr1wOo/HZHYq20Pbi83W+MkILcivGIXqcuIYaIK6pjjL11Zj1OyLMTFz+T77RuioYglF
	AgP9WZY5aGwHuentcao2jpgLwsUHegVMrhdTI5S+vuL3N4zcXcyIBXbsMxr3tybA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rhmZ8-0000fd-P1; Wed, 06 Mar 2024 09:23:54 +0100
Message-ID: <e3181555-c08d-463f-a9a9-b08c69875c84@leemhuis.info>
Date: Wed, 6 Mar 2024 09:23:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit statistics
 counters
Content-Language: en-US, de-DE
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 Marc Haber <mh+netdev@zugschlus.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
 alexis.lothore@bootlin.com, Guenter Roeck <linux@roeck-us.net>
References: <20240203190927.19669-1-petr@tesarici.cz>
 <ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>
 <Zct5qJcZw0YKx54r@xhacker>
 <CANn89i+4tVWezqr=BYZ5AF=9EgV2EPqhdHun=u=ga32CEJ4BXQ@mail.gmail.com>
 <20d94512-c4f2-49f7-ac97-846dc24a6730@roeck-us.net>
 <CANn89iL1piwsbsBx4Z=kySUfmPa9LbZn-SNthgA+W6NEnojgSQ@mail.gmail.com>
 <a3749d3f-ced1-4c48-adaf-348c8dee7610@leemhuis.info>
 <20240228120308.48d6a9c2@meshulam.tesarici.cz>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240228120308.48d6a9c2@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709713444;c709e32f;
X-HE-SMSGID: 1rhmZ8-0000fd-P1

On 28.02.24 12:03, Petr Tesařík wrote:
> On Wed, 28 Feb 2024 07:19:56 +0100
> "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
> 
>> Net maintainers, chiming in here, as it seems handling this regression
>> stalled.
> Indeed, I was too busy with sandbox mode...

Hmm, no reply in the past week to Petr's request for help from someone
with more knowledge about the field. :-/

So I guess this means that this won't be fixed for 6.8? Unfortunate, but
well, that's how it it sometimes.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> On 13.02.24 16:52, Eric Dumazet wrote:
>>> On Tue, Feb 13, 2024 at 4:26 PM Guenter Roeck <linux@roeck-us.net> wrote:  
>>>> On Tue, Feb 13, 2024 at 03:51:35PM +0100, Eric Dumazet wrote:  
>>>>> On Tue, Feb 13, 2024 at 3:29 PM Jisheng Zhang <jszhang@kernel.org> wrote:  
>>>>>> On Sun, Feb 11, 2024 at 08:30:21PM -0800, Guenter Roeck wrote:  
>>>>>>> On Sat, Feb 03, 2024 at 08:09:27PM +0100, Petr Tesarik wrote:  
>>>>>>>> As explained by a comment in <linux/u64_stats_sync.h>, write side of struct
>>>>>>>> u64_stats_sync must ensure mutual exclusion, or one seqcount update could
>>>>>>>> be lost on 32-bit platforms, thus blocking readers forever. Such lockups
>>>>>>>> have been observed in real world after stmmac_xmit() on one CPU raced with
>>>>>>>> stmmac_napi_poll_tx() on another CPU.
>>>>>>>>
>>>>>>>> To fix the issue without introducing a new lock, split the statics into
>>>>>>>> three parts:
>>>>>>>>
>>>>>>>> 1. fields updated only under the tx queue lock,
>>>>>>>> 2. fields updated only during NAPI poll,
>>>>>>>> 3. fields updated only from interrupt context,
>>>>>>>>
>>>>>>>> Updates to fields in the first two groups are already serialized through
>>>>>>>> other locks. It is sufficient to split the existing struct u64_stats_sync
>>>>>>>> so that each group has its own.
>>>>>>>>
>>>>>>>> Note that tx_set_ic_bit is updated from both contexts. Split this counter
>>>>>>>> so that each context gets its own, and calculate their sum to get the total
>>>>>>>> value in stmmac_get_ethtool_stats().
>>>>>>>>
>>>>>>>> For the third group, multiple interrupts may be processed by different CPUs
>>>>>>>> at the same time, but interrupts on the same CPU will not nest. Move fields
>>>>>>>> from this group to a newly created per-cpu struct stmmac_pcpu_stats.
>>>>>>>>
>>>>>>>> Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
>>>>>>>> Link: https://lore.kernel.org/netdev/Za173PhviYg-1qIn@torres.zugschlus.de/t/
>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>> Signed-off-by: Petr Tesarik <petr@tesarici.cz>  
>>>>>>>
>>>>>>> This patch results in a lockdep splat. Backtrace and bisect results attached.
>>>>>>>
>>>>>>> ---
>>>>>>> [   33.736728] ================================
>>>>>>> [   33.736805] WARNING: inconsistent lock state
>>>>>>> [   33.736953] 6.8.0-rc4 #1 Tainted: G                 N
>>>>>>> [   33.737080] --------------------------------
>>>>>>> [   33.737155] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>>>>>>> [   33.737309] kworker/0:2/39 [HC1[1]:SC0[2]:HE0:SE0] takes:
>>>>>>> [   33.737459] ef792074 (&syncp->seq#2){?...}-{0:0}, at: sun8i_dwmac_dma_interrupt+0x9c/0x28c
>>>>>>> [   33.738206] {HARDIRQ-ON-W} state was registered at:
>>>>>>> [   33.738318]   lock_acquire+0x11c/0x368
>>>>>>> [   33.738431]   __u64_stats_update_begin+0x104/0x1ac
>>>>>>> [   33.738525]   stmmac_xmit+0x4d0/0xc58  
>>>>>>
>>>>>> interesting lockdep splat...
>>>>>> stmmac_xmit() operates on txq_stats->q_syncp, while the
>>>>>> sun8i_dwmac_dma_interrupt() operates on pcpu's priv->xstats.pcpu_stats
>>>>>> they are different syncp. so how does lockdep splat happen.  
>>>>>
>>>>> Right, I do not see anything obvious yet.  
>>>>
>>>> Wild guess: I think it maybe saying that due to
>>>>
>>>>         inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>>>>
>>>> the critical code may somehow be interrupted and, while handling the
>>>> interrupt, try to acquire the same lock again.  
>>>
>>> This should not happen, the 'syncp' are different. They have different
>>> lockdep classes.
>>>
>>> One is exclusively used from hard irq context.
>>>
>>> The second one only used from BH context.  
>>
>> Alexis Lothoré hit this now as well, see yesterday report in this
>> thread; apart from that nothing seem to have happened for two weeks now.
>> The change recently made it to some stable/longterm kernels, too. Makes
>> me wonder:
>>
>> What's the plan forward here? Is this considered to be a false positive?
> 
> Although my system has run stable for a couple of months, I am hesitant
> to call it a false positive.
> 
>> Or a real problem?
> 
> That's what I think. But I would have to learn a lot about the network
> stack to understand what exactly happens here.
> 
> It may go faster if somebody else on the Cc can give me a hint where to
> start looking based on the lockdep warning.
> 
> Petr T
> 
> 

