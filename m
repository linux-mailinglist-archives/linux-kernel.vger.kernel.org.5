Return-Path: <linux-kernel+bounces-29220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D85830B25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEFF2820DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF831224D3;
	Wed, 17 Jan 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.hr header.i=@alu.hr header.b="iNl/Zmpg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="HrHEWwuM"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D4224D2;
	Wed, 17 Jan 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509330; cv=none; b=KED0/f2vpjLkgvDskG57GKZxIAvX7PUqpF55mh88RFGpmrW5/0z/c7LsWelHbD+0KMwhod1N7VJie/IIoy8lUAT9CQFFdNlxZws2lT8qiasOP0nu4Deip48jKuuklaZ317JmSGcLpjZTImB/+Rb1b26PY0zw87/9qZymansZIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509330; c=relaxed/simple;
	bh=Lg4fjwQ0RsegVVSUFk0J1M0jxOQPKcQD+1HOemMkLXw=;
	h=Received:DKIM-Signature:X-Virus-Scanned:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Kq0WJLzmGyhYSZpMOOAPqcSevTBm+CpZFesTnL7FeezYqdX1GtRM1Tc4ziqw4yTXqQs6UEH15c4gPu1igwrTiMbCtAUUMzrCk9hzaErFhzFdcEDFGa9rvk2m+hZqW968LCCVbxm6Bv5cNNBoyVFzJfVgxnxpXu2UP8FUD0D9JAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alu.hr; spf=pass smtp.mailfrom=alu.hr; dkim=pass (2048-bit key) header.d=alu.hr header.i=@alu.hr header.b=iNl/Zmpg; dkim=fail (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=HrHEWwuM reason="signature verification failed"; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alu.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id D8F92601A1;
	Wed, 17 Jan 2024 17:35:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
	t=1705509321; bh=Lg4fjwQ0RsegVVSUFk0J1M0jxOQPKcQD+1HOemMkLXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iNl/ZmpgoS2jzx5d7itltBgCAAxwZu8NoF6X2JJ7hnGcvecGzJOcpp6goT6Qsd8s4
	 N4offvodEOLVFtDcFJYVjLHbIAMzE3IOqWti+5TJybUbyQdUsP7fajk0NSoCmE2+pb
	 WnHzuTYHnbEmUdaR7hnlbE9ZS2XtYxP1bzHAWe94qhcSYqZrCAq6/eiETVF/vQHg6P
	 Uyniu5LwmepT3Q9/sPFMbwM8z60qnts/hCgo9oXmuZFwaV2o6Gv8d8ULLUBT035yLF
	 GNKByCS/aMuEkOFVe8BNmduwuzx+PvmPsc5ajbb2okw18Vq3RkSTQ8sDrV5iNIKJ7Z
	 EuRQF5EVhvaFQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZk3stcJxdOg; Wed, 17 Jan 2024 17:35:19 +0100 (CET)
Received: from [10.0.1.190] (unknown [161.53.83.23])
	by domac.alu.hr (Postfix) with ESMTPSA id 387C06019B;
	Wed, 17 Jan 2024 17:35:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705509319; bh=Lg4fjwQ0RsegVVSUFk0J1M0jxOQPKcQD+1HOemMkLXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HrHEWwuMqeSVDWoVoNIMCgv4UgKqLRcwjZ+KdZYsqsFpChtIDa1Zck3FgxZQHh9F3
	 nJpUoNvCTmjIXIFuCBQ8nuEDXnGoUJFhRjf7PzEkLUY8HoXvqluT+vt0YO2KJ5M1Eb
	 kQquSa0tEbnWdNPk85kbb2vIuqbRYmtyzHTv/1RhaNRYURzJ8UuoW1uOjbLD4psqMF
	 8FtWwNPthuA1g7iRMgK/Wfp7CSv15NU3kHX3wuaac5VGAO6V/8PZ0YoVo2spTpbpDh
	 Kbjo/mzwCZGZwVS9yVTapabCJoYH6DZNwIl32O3Z/XUf+Es6SpBxr0KR99FYWnmO9u
	 hwBWR+bYqDkeQ==
Message-ID: <ccb8b694-4361-40bc-b7df-528a6616c15b@alu.unizg.hr>
Date: Wed, 17 Jan 2024 17:35:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.7 021/108] r8169: improve RTL8411b phy-down
 fixup
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Mirsad Todorovac <mirsad.todorovac@alu.hr>
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 nic_swsd@realtek.com, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-21-sashal@kernel.org>
 <20240116174315.2629f21c@kernel.org>
 <4523ad21-d06a-4ba2-9b46-974a6093b189@alu.unizg.hr>
 <2c590117-96fa-4e0b-84bd-9e3ea138d93b@lunn.ch>
From: Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <2c590117-96fa-4e0b-84bd-9e3ea138d93b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/17/24 14:44, Andrew Lunn wrote:
> On Wed, Jan 17, 2024 at 11:30:53AM +0100, Mirsad Todorovac wrote:
>> On 1/17/24 02:43, Jakub Kicinski wrote:
>>> On Tue, 16 Jan 2024 14:38:47 -0500 Sasha Levin wrote:
>>>> Mirsad proposed a patch to reduce the number of spinlock lock/unlock
>>>> operations and the function code size. This can be further improved
>>>> because the function sets a consecutive register block.
>>>
>>> Clearly a noop and a lot of LoC changed. I vote to drop this from
>>> the backport.
>>
>> Dear Jakub,
>>
>> I will not argue with a senior developer, but please let me plead for the
>> cause.
>>
>> There are a couple of issues here:
>>
>> 1. Heiner's patch generates smaller and faster code, with 100+
>> spin_lock_irqsave()/spin_unlock_restore() pairs less.
>>
>> According to this table:
>>
>> [1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook-1c.2023.06.11a.pdf#table.3.1
>>
>> The cost of single lock can be 15.4 - 101.9 ns (for the example CPU),
>> so total savings would be 1709 - 11310 ns. But as the event of PHY power
>> down is not frequent, this might be a insignificant saving indeed.
>>
>> 2. Why I had advertised atomic programming of RTL registers in the first
>> place?
>>
>> The mac_ocp_lock was introduced recently:
>>
>> commit 91c8643578a21e435c412ffbe902bb4b4773e262
>> Author: Heiner Kallweit <hkallweit1@gmail.com>
>> Date:   Mon Mar 6 22:23:15 2023 +0100
>>
>>      r8169: use spinlock to protect mac ocp register access
>>
>>      For disabling ASPM during NAPI poll we'll have to access mac ocp
>>      registers in atomic context. This could result in races because
>>      a mac ocp read consists of a write to register OCPDR, followed
>>      by a read from the same register. Therefore add a spinlock to
>>      protect access to mac ocp registers.
>>
>>      Reviewed-by: Simon Horman <simon.horman@corigine.com>
>>      Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>      Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>>      Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>      Signed-off-by: David S. Miller <davem@davemloft.net>
>>
>> Well, the answer is in the question - the very need for protecting the access
>> to RTL_W(8|16|32) with locks comes from the fact that something was accessing
>> the RTL card asynchronously.
>>
>> Forgive me if this is a stupid question ...
>>
>> Now - do we have a guarantee that the card will not be used asynchronously
>> half-programmed from something else in that case, leading to another spurious
>> lockup?
>>
>> IMHO, shouldn't the entire reprogramming of PHY down recovery of the RTL 8411b
>> be done atomically, under a single spin_lock_irqsave()/spin_unlock_irqrestore()
>> pair?
> 
> Hi Mirsad
> 
> Please take a read of:
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> Do you think this patch fulfils these criteria? In particularly, "It
> must either fix a real bug that bothers people...".
> 
> I agree with Heiner, this appears to be just an optimisation,

Hi Andrew,

Yes, I wasn't aware of the 100 lines limit, and yes, this is not a bug fix,
but an improvement (optimisation).

I think by this I can join to consensus, this patch is not a candidate for
backporting. :-/

However, I am concerned about the possibility of two kernel threads accessing
the RTL NIC intermittently attempting to program the NIC over the RTL_(R|W)(8|16|32)
instructions (which are expanded to readl/writel and assembly).

AFAICS, nothing prevents two (or more) threads to decide in unlikely but
possible case to program the card at the same time. (Do we have a guard lock
against this?)

mac_ocp_lock appears to be acquired and released for each RTL_(R|W)(8|16|32),
with the exception of r8168_mac_ocp_modify().

To be true to the facts, each byte will go to the right port due to address/data
pairs used in each call - however, I am worried whether there could be a scenario
like this:


        CPU 1                                          CPU 2

    start programming NIC
    programming NIC
    (preempted in spin_lock_irqsave()
                                                   start programming NIC
					          programming NIC
					          programming NIC
					          programming NIC
					          preempted in spin_lock_irqsave()
    (resume control in spin_unlock_irqrestore()
    programming NIC
    programming NIC
    (preempted in spin_lock_irqsave()
					          continue programming NIC
					          programming NIC
					          programming NIC
						  end programming NIC
    (resume control in spin_unlock_irqrestore()
    programming NIC
    end programming NIC

Now, every byte, word or longword will come to the right place, thanks to
RTL_(R|W)(8|16|32) having the address/data pairs - but I worry that this
jumping from sequence to sequence might confuse the NIC.

I mean, if those latches behind the addresses cause some physical effect, maybe
the ORDER is also important, not just that every byte, word or longword comes
to the right address?

r8168_mac_ocp_read()/r8168_mac_ocp_write() guarantee that every piece of
data will end being read or written at the right address, OK. But this
does not seem to guarantee the SEQUENTIAL ORDER of the programming.

I mean, if we are dealing with physical hardware like a NIC, the order
of (especially writing) data might be crucial. 8-/

Am I making any sense?

Are we algorithmically secured that two threads will never attempt to
write data to NIC hardware registers?

Thanks.

Best regards,
Mirsad Todorovac


>       Andrew

-- 
CARNet system engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb

CARNet sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu


