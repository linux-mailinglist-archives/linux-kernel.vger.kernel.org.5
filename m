Return-Path: <linux-kernel+bounces-99564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4D1878A03
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1AE2816FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4A556B88;
	Mon, 11 Mar 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="J4/dEabM"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9D56B72;
	Mon, 11 Mar 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192189; cv=none; b=exjvRTvp9jrhQrQze+lzEaR984jZ8nzq6fNzeeJRYzPViyyQgc3BesdK10kM6vrwGJs8CG27CT/OhPnjcrYrnzCt46fXRAQPh17837POHkrN6fi86N78pMxu2OEHEbUqfL7HT0Csn3NtpmLNFrmewFGiqvcJuxVMC9/IYCNRYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192189; c=relaxed/simple;
	bh=LHRZFt6pL1ChIhnGUjDxoe+Lgrpp1HR4lJ0EVv66f2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdYmDZ5hkGHTfq7NyHskazD81iXdT+DmEgwE9LEl7sZdxYB4VLs6T0AcQKdb/jv/3qjhslV/uD2zSzlHKx/jiTvLVEE0+a3xM6NtW/2nI39X/MP6g2RflByHCb1p2Cga0OvPSy5MkEM0NMBejNuv7Wtuh/XGTz4M9n4Cno2fDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=J4/dEabM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB21D20008;
	Mon, 11 Mar 2024 21:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710192184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKO8ZtWOWbwntppeA2CDijBgfSjnDhZy4cLPpMxEYrs=;
	b=J4/dEabMkyo+qERCackQvl3zu9+iaZGjQ9G+f5UfKMJnShcljwm8wV6yk1AcDnALEPuxUM
	INdp1oAEuRHChMGb/JsP5vqwuCXArV9quhuyBdz9c0YYnd741UxSz+EbN+/PJwZpV03lFv
	/GTXP9KEumnSSizvNKuoNJlnMj+kutrSg+7a63jb2QtORqWO9iKXRwPtFrnpgds9sSR2Rq
	2NSsa9Exm1PVhzo5y/iRj8XUr4gEZlbebCT5YVm8sAsDsWeDhyhHsteIPxhlVuuKMIfdCz
	/k2g3CsEF6CqMQNSuuLNFqir6ZzMTw1jYgOZ2YXKly9dx3hKXWW2R9qB4LU3Hg==
Message-ID: <2d206dbb-a27b-4139-a49e-331797d8ba34@arinc9.com>
Date: Tue, 12 Mar 2024 00:22:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
To: patchwork-bot+netdevbpf@kernel.org,
 Justin Swartz <justin.swartz@risingedge.co.za>
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <171019143163.14853.15330891015381229970.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <171019143163.14853.15330891015381229970.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

Why was this applied? I already explained it did not achieve anything.

Arınç

On 12.03.2024 00:10, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Tue,  5 Mar 2024 06:39:51 +0200 you wrote:
>> Disable LEDs just before resetting the MT7530 to avoid
>> situations where the ESW_P4_LED_0 and ESW_P3_LED_0 pin
>> states may cause an unintended external crystal frequency
>> to be selected.
>>
>> The HT_XTAL_FSEL (External Crystal Frequency Selection)
>> field of HWTRAP (the Hardware Trap register) stores a
>> 2-bit value that represents the state of the ESW_P4_LED_0
>> and ESW_P4_LED_0 pins (seemingly) sampled just after the
>> MT7530 has been reset, as:
>>
>> [...]
> 
> Here is the summary with links:
>    - net: dsa: mt7530: disable LEDs before reset
>      https://git.kernel.org/netdev/net-next/c/2920dd92b980
> 
> You are awesome, thank you!

