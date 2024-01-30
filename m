Return-Path: <linux-kernel+bounces-44989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A80842A05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BCE1C23DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784F128386;
	Tue, 30 Jan 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b="U5qg+AQ/"
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76118129A87
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.91.1.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633567; cv=none; b=hdrPRPxP0K9hk8mmKKRFr3bIwNxMl2c5D8z50CDjfHECMyCUdgIOtb1UiEQT+nJRYrheMhNE/s7nj0bHNWTi85SX/nsAwPRGQKJY79ylxIYDn64Og/kSQPZ4LY04WgCkQE2+NTZzafKRtch5ShU+hv8fKKRmTiOpaBziG3NTwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633567; c=relaxed/simple;
	bh=APe8qHs7OS1okrSny8ta3CCO+EktflctfrLK41gq/Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyeXaBRuN7BIn4b5TfelOXcMzy1JMGFKNuid7Jdk2ZHruBtNhYpx2ptAzCta4fIGmImYXFY1HEELFwuDof038nINdaAaz1MFhHeShNHPwwBYogM15z+gy6hzq/Ex21ImL89zO9IfuMGYHrinvRucx0fqcJlhsD/nhI20Cc82qvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr; spf=pass smtp.mailfrom=ics.forth.gr; dkim=pass (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b=U5qg+AQ/; arc=none smtp.client-ip=139.91.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.forth.gr
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 40UGqbUo012007
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:52:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1706633551; x=1709225551;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=APe8qHs7OS1okrSny8ta3CCO+EktflctfrLK41gq/Fk=;
	b=U5qg+AQ/phewkJxH70fZ2R3vQyboB5fmnWM0cI1BWhdqkgrTnMWul7LIakN9/XyG
	WVQ9T9WXqNaiSg3/ggjOzUs0UPm+aK8IR6IijLN/tJcoWRDRx1BE6p0kmJ0fUEFj
	XhLxjykO7xMx7QzGEqzq5P9luYA9dcVzzi8OE5UZHT9+5VxgxkJIYeU685apMhMB
	3P5Fy/JRTqQKz8R3ZmNclPNXCdIBX8/ThOj34R8ZG5fgiEGqmy5GpQzo5gcle9ID
	cjAaUAI7CMxMZH0iCkh68psOCKlJgyVKQPEQ9woeLFVcGrcUMOsnrBoZsg8sV5sE
	QeNG7l+J9obQbPA6dugPBA==;
X-AuditID: 8b5b014d-a17eb70000002178-8a-65b9294ffbfd
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id BA.04.08568.F4929B56; Tue, 30 Jan 2024 18:52:31 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <c6066469-7bc9-4232-b600-0b167193f13f@ics.forth.gr>
Date: Tue, 30 Jan 2024 18:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] riscv: optimized memmove
Content-Language: el-GR, en-US
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matteo Croce <mcroce@microsoft.com>, kernel test robot <lkp@intel.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-3-jszhang@kernel.org>
 <fa36b871-43d7-413c-82a2-0ecc0ebce9b4@ics.forth.gr>
 <Zbj1o6VAsk8Tn2ab@xhacker>
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <Zbj1o6VAsk8Tn2ab@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXSHT1dWddfc2eqwbTPRhZbf89it2g+tp7N
	4vKuOWwW2z63sFm8an7EZvH3139Wi5eXe5gt2mbxO3B4vHn5ksXjcMcXdo/Fe14yeWxa1cnm
	sXlJvUfrjr/sHpear7N7fN4kF8ARxWWTkpqTWZZapG+XwJVxozu3oEGoYuPPiewNjEv5uhg5
	OSQETCQOdP1l6WLk4hASOMoocWbiYmaIhKXE5k8vWUBsXgF7iV8XNrN1MXJwsAioSpxu94QI
	C0qcnPkErERUQF7i/q0Z7CAlwgKGErtvV4KEmQXkJN4/284KYosIqEn82veYCWQVs8A0Jont
	d5qYIPZuY5R4fHslI0gVm4CmxPxLB8GGcgqoS7zZMoUdYpKZRNfWLkYIW16ieets5gmMArOQ
	3DELycJZSFpmIWlZwMiyilEgscxYLzO5WC8tv6gkQy+9aBMjOCoYfXcw3t78Vu8QIxMH4yFG
	CQ5mJRHelXI7U4V4UxIrq1KL8uOLSnNSiw8xSnOwKInznrBdkCwkkJ5YkpqdmlqQWgSTZeLg
	lGpgOpj/c+WLvqesccbr/vlVL2Ot7b+a8b1I0E7i5+ZvPzZPe8wuIOWZsFz9jsuCeaY+05Qb
	Z//bkB/7jy/yDdPH+Qu65HbHB4u+WhS5s/3ti9Znsgtlc5eoCE1KNAibzPXLeBq3sfMDTfd6
	7fmpLVeZjWfUajparJh6M/256o9N374Y3V5eG3lty7rJBjqJrzSPFjmJbPh+I+P8/jdOO45v
	ez6XZ8fx952vphh0BIl+j7+js2vdDsmN67fnTzhfE3Eswjq88/dyJY2wd8bxK+3ZSm71Bm90
	sTm5POQvn+POoLWaE47sOMk6pTPu5I1XL548tmjgn5hZ0SRw4MazK95byzK4TjVt3KYjGfA+
	/8af1ypKLMUZiYZazEXFiQDQAtHd+QIAAA==

On 1/30/24 15:12, Jisheng Zhang wrote:
> On Tue, Jan 30, 2024 at 01:39:10PM +0200, Nick Kossifidis wrote:
>> On 1/28/24 13:10, Jisheng Zhang wrote:
>>> From: Matteo Croce <mcroce@microsoft.com>
>>>
>>> When the destination buffer is before the source one, or when the
>>> buffers doesn't overlap, it's safe to use memcpy() instead, which is
>>> optimized to use a bigger data size possible.
>>>
>>> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>
>> I'd expect to have memmove handle both fw/bw copying and then memcpy being
>> an alias to memmove, to also take care when regions overlap and avoid
>> undefined behavior.
> 
> Hi Nick,
> 
> Here is somthing from man memcpy:
> 
> "void *memcpy(void dest[restrict .n], const void src[restrict .n],
>                      size_t n);
> 
> The  memcpy()  function copies n bytes from memory area src to memory area dest.
> The memory areas must not overlap.  Use memmove(3) if the memory areas do  over‐
> lap."
> 
> IMHO, the "restrict" implies that there's no overlap. If overlap
> happens, the manual doesn't say what will happen.
> 
>  From another side, I have a concern: currently, other arch don't have
> this alias behavior, IIUC(at least, per my understanding of arm and arm64
> memcpy implementations)they just copy forward. I want to keep similar behavior
> for riscv.
> 
> So I want to hear more before going towards alias-memcpy-to-memmove direction.
> 
> Thanks

If you read Matteo's original post that was also his suggestion, and 
Linus has also commented on that. In general it's better to handle the 
case where the regions provided to memcpy() overlap than to resort to 
"undefined behavior", I provided a backwards copy example that you can 
use so that we can have both fw and bw copying for memmove(), and use 
memmove() in any case. The [restrict .n] in the prototype is just there 
to say that the size of src is restricted by n (the next argument). If 
someone uses memcpy() with overlapping regions, which is always a 
possibility, in your case it'll result corrupted data, we won't even get 
a warning (still counts as undefined behavior) about it.

Regards,
Nick


