Return-Path: <linux-kernel+bounces-44051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7017D841CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2812B2834D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04A54BEF;
	Tue, 30 Jan 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="z1ZN3vjz"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1A5465D;
	Tue, 30 Jan 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600146; cv=none; b=no8Frwhhw8vJ0zq46e0K7wak1kLkvM0Sn37uswl1BDrqQT15PTQ+9vJNCTpenTNLltkbc6+fph7lT8bGmOEk56NVewm2NDOQK65rVcjMR1Z9Dyq7aUaG2uOSPSFuv5JlAG/S4SDk6UCpe7Bd+Bsz8ubW0M59xt0oaA08nxNW78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600146; c=relaxed/simple;
	bh=/jhiDAXn5xDQ3jcJlcHR5q1dx8ajj5r1UfIhMLOvtTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lf1FkbDCBpAPCE2bZ7K/W3CTYbrmTbneQ1qTaTZSw9YvyBVTFVkPwYLX4cNCxirweAIt2QynCJdbJ2fShz9J+aWE1119Unq6v+9ElF10fzc+QN/O4fc6S7Glhcgi1ztFNDTKtvpqUDLX6qF+8lEK9xmaU3wbIh64i8w/M+Rfyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=z1ZN3vjz; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 65FFB19BD2B;
	Tue, 30 Jan 2024 08:35:40 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706600140; bh=/jhiDAXn5xDQ3jcJlcHR5q1dx8ajj5r1UfIhMLOvtTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z1ZN3vjzuGCX+Y8dEn4+fs1ySTvsw7mor35rpzLLbpdiIU7jI14MfiJQr6sSuXSk+
	 cS1uXiN+QQcT2P8DfF0xCQ+G5AGr/CPEdyVsnqnTnTQeTQZfdUTL4fxXwLBR6r1bw3
	 80J4G6nxl2jOiKZaMWnoYm0ug3JOqVnrKoww6oh3thgZYrGr3At7aIrbUwxZHM6QUi
	 qOXRUg55nQPTae3/2tyna2ggFM1kDsZRpz3tseBRi2GitO9ZMvwO76s1t8zcJb98HQ
	 r0BR64lk9k9ZSnSrjwyDK+gJFZ+MPYGUANexI3pnMckyS/Fxo+ZYIpKs2cL6jxYNKK
	 68IXl2PYqbUYg==
Date: Tue, 30 Jan 2024 08:35:39 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "open list:STMMAC ETHERNET DRIVER"
 <netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:ARM/Allwinner sunXi SoC support"
 <linux-sunxi@lists.linux.dev>, Marc Haber <mh+netdev@zugschlus.de>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: protect updates of 64-bit
 statistics counters
Message-ID: <20240130083539.4ea26a8d@meshulam.tesarici.cz>
In-Reply-To: <ZbiCWtY8ODrroHIq@xhacker>
References: <20240128193529.24677-1-petr@tesarici.cz>
	<ZbiCWtY8ODrroHIq@xhacker>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 13:00:10 +0800
Jisheng Zhang <jszhang@kernel.org> wrote:

> On Sun, Jan 28, 2024 at 08:35:29PM +0100, Petr Tesarik wrote:
> > As explained by a comment in <linux/u64_stats_sync.h>, write side of struct
> > u64_stats_sync must ensure mutual exclusion, or one seqcount update could
> > be lost on 32-bit platforms, thus blocking readers forever. Such lockups
> > have been observed in real world after stmmac_xmit() on one CPU raced with
> > stmmac_napi_poll_tx() on another CPU.
> > 
> > To fix the issue without introducing a new lock, split the statics into
> > three parts:
> > 
> > 1. fields updated only under the tx queue lock,
> > 2. fields updated only during NAPI poll,
> > 3. fields updated only from interrupt context,
> > 
> > Updates to fields in the first two groups are already serialized through
> > other locks. It is sufficient to split the existing struct u64_stats_sync
> > so that each group has its own.
> > 
> > Note that tx_set_ic_bit is updated from both contexts. Split this counter
> > so that each context gets its own, and calculate their sum to get the total
> > value in stmmac_get_ethtool_stats().
> > 
> > For the third group, multiple interrupts may be processed by different CPUs
> > at the same time, but interrupts on the same CPU will not nest. Move fields
> > from this group to a newly created per-cpu struct stmmac_pcpu_stats.
> > 
> > Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
> > Link: https://lore.kernel.org/netdev/Za173PhviYg-1qIn@torres.zugschlus.de/t/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Petr Tesarik <petr@tesarici.cz>  
> 
> Thanks for the fix patch. One trivial improviement below
> s/netdev_alloc_pcpu_stats/devm_netdev_alloc_pcpu_stats to simplify
> error and exit code path.

Thanks for your review.

In fact, many other allocations in stmmac could be converted to devm_*.
I wanted to stay consistent with the existing code, but hey, you're
right there's no good reason for it.

Plus, I can send convert the other places with another patch.

> With that:
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> 
> PS: when I sent the above "net: stmmac: use per-queue 64 bit statistics
> where necessary", I had an impression: there are too much statistics in
> stmmac driver, I didn't see so many statistics in other eth drivers, is
> it possible to remove some useless or not that useful statistic members?

I don't feel authorized to make the decision. But I also wonder about
some counters. For example, why is there tx_packets and tx_pkt_n? The
former is shown as RX packets by "ip stats show dev end0", the latter
is shown by as tx_pkt_n by "ethtools -S end0". The values do differ,
but I have no clue why, and if they are even expected to be different
or if it's a bug.

Petr T

