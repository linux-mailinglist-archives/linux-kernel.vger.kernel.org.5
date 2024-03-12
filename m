Return-Path: <linux-kernel+bounces-99956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B8878FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE6282589
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E24577A0F;
	Tue, 12 Mar 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="da+a25s0"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB0C8DD;
	Tue, 12 Mar 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232710; cv=none; b=MJiflShcxrhy+AYTr2KRISM+KtKE1O/RhzeVkXjTjVaCLRrcSWiqrf1loLLXctnTCkIUFgPe+OJeHG1yoWUDVlfvBqLH/suRiOo4L+w6psI2z5zD9PKdwdtlqysR8G0/3B3MbADfeIeVNI+HKD1lBAhQTjjPHxmTBNvs+NIFWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232710; c=relaxed/simple;
	bh=cADERAidf+JiG6/MllhsUnCwa5dSvHrvwMt2pI41UK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEeW5MF4sbLOGX6eSbEVOZQVQnRbkgtVSWATiAEXn8BdGqS9THKzqsmpIonky2v8q9jQYHtuAUWnvVlTihYprmS+x0J+LDYjU6YX0jsz8S7y2YzzIykvaSfCI/u3jJH6jdSBgUSioONRtoXEBAmzXUkG9/DKDAYAF+SPdHIXzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=da+a25s0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D340FE0005;
	Tue, 12 Mar 2024 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710232706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+y2WCRg38vZjx+jg3Hy0I1hvQc4HDSJn/8wv1tgeMPA=;
	b=da+a25s08RVCs6ZnhisGvFDQsAwIINFRgmU2YyAgUGEky+9XVBVrD8SXHePUa0Q8LMJbTa
	27ZdBhTElzHzH9F5CbB+v4OmAbnfa2YlAi4lImVz97hgEZw2TRD7HyIEZCYtiPzGIHX/Zl
	frEVAuK40PeKHO7E5Y6LGUeeHnCJ+vPQyqq2RPrQJ53r4X0NEBjizcv30H3tw+yhtr9Zkb
	/R+MqMyHc28Xk0cX4q8rcczB4edWo26nmLsuldu7mhTxj9iqwMswUdHVGRyc2UjCLKH89d
	bu7Khks1iQYqWt/rY7J1ZDc1QB0BajOi/4dJiJfmZ4sni/4oKI9MLHSf3ml3cQ==
Message-ID: <7780460c-abc3-4009-9f95-28d123a9a23d@arinc9.com>
Date: Tue, 12 Mar 2024 11:38:08 +0300
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

I am once again calling for this patch to be reverted on the net-next tree
on the basis of:

- This patch did not go through a proper reviewing process. There are
   proposed changes on the code it changes regarding the scope and the
   method of the patch, and improvements to be made on the patch log.

- This patch should be backported to stable releases, therefore it
   shouldn't be on the net-next tree and should be submitted to the net tree
   instead.

Arınç

