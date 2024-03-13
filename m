Return-Path: <linux-kernel+bounces-101699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C4787AABF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE47EB22C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3102481C2;
	Wed, 13 Mar 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="dCjpL1Qh"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6591447F45;
	Wed, 13 Mar 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345084; cv=none; b=hDi9vCYo/oqwEG6CP5msLnIb308DHpU9fX+YKO4SR7OtWcWtIeexbSjBM3RW4ch9spCUW2gzMFIas+tU1UvQ0ZvbNUUxndtMzAR8yfN2yz2uYHr5ZX+Dv+ooJTRoAcFTqzkWvD3PJK/FGDGtJo+pu10PCRtEtPyfGawhqNSTff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345084; c=relaxed/simple;
	bh=2t109cGdjRddVihzmzHhWDx/v8hS77zLbeiHFkAORB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smvIX0I23H7sMDYfxDqVsX7u/wQowdHu5ba9GzMOqt8dotD05WYCylzhKUR0/BaDSfyDZmhqwcCpcfEV2fyQWu34v0JirCEC0AXt3ZnVe4R2oi7g7ga1KGYQI9+3Q5duHTWr4cCXLpxZ4ngl/woju7GnV93vCrqqLshFGohGpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=dCjpL1Qh; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0741CC0002;
	Wed, 13 Mar 2024 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710345079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmEhZmVSZBopL5MK9mOGygoyzG2onSwohVKSkd/C5f4=;
	b=dCjpL1Qhypjdy9xlWHCA/0s3JSgZwPFzSzJHfAufqhwzFSQnY0+zHNZjLYvDXAlw0/LawK
	RDx8xDVnYHshm2m0NrGmnkPQDWIBGnvKiYvxhLRlypYgqMngW3pU9CyIxh0kSafHPT+hhY
	swkdzbS3JIH+qJ/PXMaqmQUuUrrxxoqq/xOtdYCSEWT5KTZM0jUYkHij2g5ubg/rD86p7g
	tQhMDJsq5axO88mK1AWI3lpN7C2ChszAxiZvqc1wHXVVVGuMeAUfGqhvEotfO42uiUtjOz
	9Ow132l3YSiEod4DqhAiKq5s6qZwH6Ma40k97EpgnTbhOHrmXMZgdrb3LRq5aA==
Message-ID: <757e7f93-9ebd-49e3-afd6-a40eb81a1a49@arinc9.com>
Date: Wed, 13 Mar 2024 18:51:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: increase reset hold time
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <f594a72a91d12f1d027a06962caa9750@risingedge.co.za>
 <20240312192117.7789-1-justin.swartz@risingedge.co.za>
 <bf0ed70f-e106-4a7f-a98c-de34658feb4d@arinc9.com>
 <e6525cac666a033a5866465abb3e63f1@risingedge.co.za>
 <2640a495-97a0-4669-a53a-e367af956a78@arinc9.com>
 <c4590e9519d0cd788d157a1e1510cc45@risingedge.co.za>
 <997db446-030b-4e6a-beea-0ae7d990e7e2@arinc9.com>
 <3146df060620f08a620417cfcf2b2179@risingedge.co.za>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <3146df060620f08a620417cfcf2b2179@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 13.03.2024 18:38, Justin Swartz wrote:
> On 2024-03-13 17:04, Arınç ÜNAL wrote:
>> On 13.03.2024 16:13, Justin Swartz wrote:
>> I think you've missed that your patch is already applied. And it won't be
>> reverted for reasons explained by Paolo in this mail thread.
>>
>> https://git.kernel.org/netdev/net-next/c/2920dd92b980
>>
>> So if your patch here were to be applied too, the final mt7530.c would have
>> the LEDs disabled AND before reset deassertion delay increased.
> 
> Yes, I seem to have missed that. I thought your request for the
> patch to be reverted definitely would have been performed, or at
> least queued, seeing as you're the maintainer.

Yeah, one would think. :D Since your patch was applied in a good intent of
not having it miss the current development cycle, it was a bit rushed. So
before I could present a valid reason to revert the patch, the pull request
that included your patch was already submitted to Linus. So unless the
patch is something very bad which it's not, nobody's going to bother
reverting it.

I've sent another patch an hour or so ago that reverts it and implements
what we've discussed here. I will also make sure it is applied to stable
trees.

https://lore.kernel.org/all/20240313-for-netnext-mt7530-better-fix-xtal-frequency-v1-1-5a50df99f51a@arinc9.com/

Arınç

