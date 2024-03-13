Return-Path: <linux-kernel+bounces-101456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446087A763
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183571F236D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9AE3FB31;
	Wed, 13 Mar 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="E/IpBBLu"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED921CD00;
	Wed, 13 Mar 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331585; cv=none; b=jd5r37EfDN1HFRZMl3YzgLlVyzrZtPeNAEztWBMfx/erPVkNzkKvnIfBuk0AoakRF/JEqS7Qz6Pus/3J95HbnN9IajIwEzqxFNNraGLDx/qNBSH96Nwr+i9Hr0eV3nwdyKMfYe/H8Wh0NYbmolHO1+oqNhx5zR1LQIVWz17V4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331585; c=relaxed/simple;
	bh=G33yJ0hd6fYJ103h6Wuuwm4C6XCXponRb0+ARfXFBJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fex3ZmmLXZyaKS3IMSh2V9fMR2XFb3r7UOcjDgNKaYzEtueGk4WeYGdsnuIM0pMSGSC/HhDqzOAAFbYhilDgQVe4aOQv7x3aybxYgaJ21tde5Pnp8xGRgbra6gGvqJse7Y6p7qb0bZeDiA0boYNAjwM0f2DFP3zdt1UQaJ+PogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=E/IpBBLu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07BCDE000D;
	Wed, 13 Mar 2024 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710331580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9En6uzyrXqEpXMyli+a5bbxKTYmfpSeoH7e6bqHXIiQ=;
	b=E/IpBBLuJBUaF1nTLhkj0clPsXeXOXtqG75qHpr/AVJ1aTjlVT21OMhyXGkpR+bpiWuG0j
	dUjfrM6hzo4yaJgWljTIc3wqJz+rCFpDqcHZskzh7aP2wtcQezWwjX79pzhZR7eTrY3b9j
	+fApCe8Na+0M6PeDYARhae3X7kNi7BMTvLDZUQeG6KkJiFQ2b9LAMH4s4x/D1+keTLLvhn
	CWC8DZ+/4XERrEe0jJFN0+RSbX9wwyKgXE6Nf694GNk4xkK3vJ40ChxPy4RDeCIyJoVdkv
	cYoNvo+hWM25HLfFHCO/L++ZcWLunYW1aWYbPMZjVcNjLDT6F9JsKktOuNl1OA==
Message-ID: <2640a495-97a0-4669-a53a-e367af956a78@arinc9.com>
Date: Wed, 13 Mar 2024 15:06:04 +0300
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <e6525cac666a033a5866465abb3e63f1@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 13.03.2024 14:52, Justin Swartz wrote:
> 
> On 2024-03-13 10:59, Arınç ÜNAL wrote:
>> This ship has sailed anyway. Now the changes the first patch did must be
>> reverted too. I will deal with this from now on, you can stop sending
>> patches regarding this.
> 
> At least if the first patch isn't reverted, the approach used is
> less likely to result in the problem occuring, IMHO.

I disagree that the previous approach is less likely to result in the
problem occurring. If you don't like the delay amount we agreed on, feel
free to express a higher amount.

I also disagree on introducing a solution that is in addition to another
solution, both of which fix the same problem.

> 
> The delay between deliberately switching the LEDs off, instead of
> only waiting on chip reset logic to handle that, and the reset
> assertion could be considered a "reset setup" period to complement
> the original reset hold period.
> 
> Increasing the hold period to what should be 5000 - 5100 usec,
> definitely made the problem go away my testing, but the previous
> approach is (if nothing else) more explicit in its intent.

I don't want any unnecessary complications on the code I'm maintaining. I
already gave a clear intent on the patch log that introduces a simpler and
more efficient approach, it doesn't need to be on the code.

Arınç

