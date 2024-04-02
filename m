Return-Path: <linux-kernel+bounces-128004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869448954D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91991C23C50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3B85650;
	Tue,  2 Apr 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="8xJ+0Hj1"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5685624
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063302; cv=none; b=WJl3/miLa6hxak2uuLC7hgGNTx8ZpZ+iT5vSzbsba/laMgdwoFZ7t86gx33+lQxCo9jgjHMk2n3ZTxpqLrUibjnvO6CNcVCZaFT+BSfJ6xB5Kk/3hi7IgfocXD/5JAviU+Ihkot/l6CZmGBxAQp+F4zxrURj8ZIRgFx7Lvd+biU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063302; c=relaxed/simple;
	bh=28fAeFvYI+Kv1sba4s7YhaUL+RxU89SC5CgGeP5JvDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFxjk0Sqx/aDWJ8KRSlPV79vxSuHLYLZJTWV4NNY72hrOg4sIdkjtrmb6iMUnMgR0bYw1knexYwlTsaC/eKwTs9VtTDtUGLSh4omqJk1PLIJwsbu/l3yUS0kWJ0l18JodyfjilVpAsAQVlAwg/YrniEDc/mDcFyy5Wic5lN70JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=8xJ+0Hj1; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JCjj67n0nhK6ksZt20rs/rYrpqTw+lXYUpYPa1MOEMo=; b=8xJ+0Hj1FxM6YbPGq6k+7eTm2v
	wDaAJkzhCrlNd/rhfGKjR2fqbKura1LXFB/GJJCXnYidq05WC/5WA3BFAPkzcO1ypYFeBkXgsULDA
	1ChsghUSYgT28jvXvg5d0HzfIMnYctxYSLyNb68rHhKHCdsZYzTmkFLy3oqjTxgU54fks+sOxvf2n
	hiIKge+u2KbIr91juxrSkh1rcA4vo24CZa6J//IdmcoTl4FFrOZhPUVSuBWf24fGT4EIOZEwPXVWp
	23/fycNn63jrmfcEBR3vFVA5I1Xyu3ycng5jlaUTNae47KxNLPeNYiLayyp3bgeZpsO9na0bC+QLt
	8duOKAVg==;
Received: from [143.58.228.53] (helo=[192.168.1.103])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1rrdRE-007s5s-MA; Tue, 02 Apr 2024 13:40:28 +0100
Message-ID: <12aa7a56-4bed-466a-a78f-21dc32d5c835@codethink.co.uk>
Date: Tue, 2 Apr 2024 13:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: lib: Implement optimized memchr function
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
 Heiko Stuebner <heiko@sntech.de>, Bjorn Topel <bjorn@rivosinc.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-36b05ed9-dd1c-45ad-aeec-921b30a75f7a@palmer-ri-x1c9>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov@codethink.co.uk>
In-Reply-To: <mhng-36b05ed9-dd1c-45ad-aeec-921b30a75f7a@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ivan.orlov@codethink.co.uk

On 27/03/2024 14:21, Palmer Dabbelt wrote:
> On Mon, 11 Dec 2023 07:25:15 PST (-0800), ivan.orlov@codethink.co.uk wrote:
>> On 11/12/2023 15:08, Andrew Jones wrote:
>>>> As you can see, the new function shows much better results even for
>>>> the small arrays of 256 elements, therefore I believe it could be a
>>>> useful addition to the existing riscv-specific string functions.
>>>
>>> Looks good, but do we want to maintain both this version and a zbb
>>> version? I'd expect a zbb version to be even better.
>>>
>>
>> Hi Andrew,
>>
>> Yes, ZBB analog would be much better, and if we use ZBB operations we
>> could avoid the most part of bit magic happening there.
>>
>>>> +    add t1, x0, a2
>>>
>>> move t1, a2
>>>
>>> and for the remainder of the function s/x0/zero/
>>>
>>
>> Alright, will be fixed in the next version.
>>>> +    sltiu t2, a2, MIN_BORDER
>>>> +    bnez t2, 6f
>>>> +
>>>> +    // get the number of bytes we should iterate before alignment
>>>
>>> I'm not sure, but I think even in assembly we prefer the /* */ comment
>>> format.
>>>
>>>> +    andi t0, a0, SZREG - 1
>>>> +    beqz t0, 4f
>>>> +
>>>> +    # get the SZREG - t0
>>>
>>> I'm 99% sure we don't want to use the # comment syntax.
>>>
>>>> +    xor t0, t0, SZREG - 1
>>>
>>> xori?
>>>
>>
>> Hmm, I'm surprised that it is actually compilable... Yeah, should be 
>> fixed
>>>> +    addi t0, t0, 1
>>>> +
>>>> +    sub a2, a2, t0
>>>
>>> nit: Looks a bit odd to put a blank line above the sub line above,
>>> instead of above the below comment.
>>>
>>>> +    // iterate before alignment
>>>> +1:
>>>> +    beq t0, x0, 4f
>>>> +    lbu t2, 0(a0)
>>>> +    beq t2, a1, 3f
>>>> +    addi t0, t0, -1
>>>
>>> This addi t0... isn't necessary if we do
>>>
>>
>> Yeah, sounds reasonable, we can make it faster
>>>     add t0, a0, t0
>>> 1:
>>>     beq a0, t0, 4f
>>>     ...
>>>     ...
>>>     addi a0, a0, 1
>>>     j 1b
>>>
>>>> +    addi a0, a0, 1
>>>> +    j 1b
>>>> +
>>>> +2:
>>>> +    // found a word. Iterate it until we find the target byte
>>>> +    li t1, SZREG
>>>> +    j 6f
>>>
>>> These instructions seem oddly placed among the rest.
>>>
>>>> +3:
>>>> +    ret
>>>
>>> And this is an odd place to put this ret (after unconditional jump and
>>> in the middle of the function). We can just put a label at the bottom 
>>> ret.
>>>
>>
>> I agree, thanks!
>>>> +
>>>> +4:
>>>> +    // get the count remainder
>>>> +    andi t1, a2, SZREG - 1
>>>> +
>>>> +    // align the count
>>>> +    sub a2, a2, t1
>>>> +
>>>> +    // if we have no words to iterate, iterate the remainder
>>>> +    beqz a2, 6f
>>>> +
>>>> +    // from 0xBA we will get 0xBABABABABABABABA
>>>> +    li t3, REP_01
>>>> +    mul t3, t3, a1
>>>
>>> I don't think we want to implement an optimized assembly function with
>>> mul. We can just use a few shifts and ors.
>>>
>>>     slli    t3, a1, 8
>>>     or    t3, t3, a1
>>>     slli    t4, t3, 16
>>>     or    t3, t4, t3
>>> #if __riscv_xlen == 64
>>>     slli    t4, t3, 32
>>>     or    t3, t4, t3
>>> #endif
>>>
>>
>> Nice point, thanks! Will be optimized :)
>>>> +
>>>> +    add a2, a2, a0
>>>> +
>>>> +    li t4, REP_01
>>>> +    li t5, REP_80
>>>> +
>>>> +5:
>>>> +    REG_L t2, 0(a0)
>>>> +
>>>> +    // after this xor we will get one zero byte in the word if it 
>>>> contains the target byte
>>>> +    xor t2, t2, t3
>>>> +
>>>> +    // word v contains the target byte if (v - 0x01010101) & (~v) & 
>>>> 0x80808080 is positive
>>>
>>> s/is positive/is not zero/
>>>
>>>> +    sub t0, t2, t4
>>>> +
>>>> +    not t2, t2
>>>> +
>>>> +    and t0, t0, t2
>>>> +    and t0, t0, t5
>>>> +
>>>> +    bnez t0, 2b
>>>> +    addi a0, a0, SZREG
>>>> +    bne a0, a2, 5b
>>>> +
>>>> +6:
>>>> +    // iterate the remainder
>>>> +    beq t1, x0, 7f
>>>> +    lbu t4, 0(a0)
>>>> +    beq t4, a1, 3b
>>>> +    addi a0, a0, 1
>>>> +    addi t1, t1, -1
>>>
>>> Same comment as above about being able to drop the addi t1...
>>>
>>>> +    j 6b
>>>> +
>>>> +7:
>>>> +    addi a0, x0, 0
>>>
>>> li a0, 0
>>>
>>>> +    ret
>>>> +SYM_FUNC_END(memchr)
>>>> +SYM_FUNC_ALIAS(__pi_memchr, memchr)
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>> Thanks,
>>> drew
>>>
>>
>> Thanks a lot for the review!
> 
> Do you have a v2?  Sorry if I lost it.
> 

Hi Palmer,

Sorry for the late reply.

After a few experiments it became clear that we won't get such a large 
performance gain for the xlen=32. Also, I collected some usage 
statistics on the system, and it shown that `memchr` has to iterate more 
than 128 bytes quite infrequently.

Considering this information, it seems to me that such an 
overcomplication of the `memchr` function simply doesn't worth it. So, 
there was no V2 for this patch :(

Sorry, I should've written it earlier.

-- 
Kind regards,
Ivan Orlov


