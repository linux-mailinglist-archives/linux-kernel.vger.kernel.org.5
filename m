Return-Path: <linux-kernel+bounces-167775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090628BAF04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF561F2180A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171B4A32;
	Fri,  3 May 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="XZxK2me0"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43B23BE
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746636; cv=none; b=sAjD0uLD14lwCnmlMt5GPzCN8RjLGyzB07UAWn3AoyZHohNbQouM7qSYyOapCPilmkmwhj44srnF0lAHkwUi9hTDkVnsA93o45yjmWwinZxDO5JbDXiXuHmGEWES89KDLl27Gv3e7oLyzY+uBmp1p7VaA045epM+Lj59DYz6sCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746636; c=relaxed/simple;
	bh=cyW8ZcQlQclU0wD95XD65PaDsnIvNe3Z3NQRrr+BYi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozNruMQMA+iRRfyKhEnj2WspdC/ShCddzudfXLCwc6/Qzu8wc5orhFypYQIrA+KcJF0HpScJckdKdhB+aWQrl9G8wkMvK7iECo9WZQLvtqEuUDxbfW8pLRD2Il78epize2X4Cq6/M0HjsmTunPaAUzUB8i9vKr9sARSNc80SxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=XZxK2me0; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YkLvbvGXUm01nkfrbDy3yckolxec9uJtymjr2A/6X7g=; b=XZxK2me0z2h/ITciGSZaGwelK+
	mdZyit0sucxhJNoOYx+6W2/dIlKvDbPJ6tDnGtgb197r6IbU9eQEacxfH0myWiWivbVeF/kEXHCNq
	Y2OjHjC1vrPnC0BSNZCE6xAIGeZOJRB6w3YrImpZvlRWQb0VX2AcVr4uqk8bYMR0SNafcQOxmeqEa
	mKL5N5qZPdHNdMM4pfj79EpOKZwpFb5KLdXu+hdGow36q4nwyzbcJbuDkxNqBLHKYkvX3f03l2dKr
	T0YnEsIdcjvo5bsunrh3wY6aym5vFmtzM/hGD7dU+ZO5alsOohnVZ+o4hiw83ALjbWonK1b9saWMZ
	4gIn/tpA==;
Received: from [167.98.27.226] (helo=[10.35.6.244])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s2tvR-004QUo-J1; Fri, 03 May 2024 15:30:14 +0100
Message-ID: <4a04a462-3eab-4382-83b2-ce6ed7104883@codethink.co.uk>
Date: Fri, 3 May 2024 15:30:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: uaccess: Allow the last potential unrolled copy
Content-Language: en-GB
To: Alexandre Ghiti <alex@ghiti.fr>, Xiao Wang <xiao.w.wang@intel.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: jerry.shih@sifive.com, nick.knight@sifive.com, ajones@ventanamicro.com,
 bjorn@rivosinc.com, andy.chiu@sifive.com, viro@zeniv.linux.org.uk,
 cleger@rivosinc.com, alexghiti@rivosinc.com, haicheng.li@intel.com,
 akira.tsukamoto@gmail.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240313103334.4036554-1-xiao.w.wang@intel.com>
 <7ebc5b28-7115-494f-a607-e46c71214cce@ghiti.fr>
 <4bc238eb-410b-46b1-98e1-4aaa35e34404@codethink.co.uk>
 <daa955d9-b554-4e0e-a08e-835c4cd5a366@ghiti.fr>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <daa955d9-b554-4e0e-a08e-835c4cd5a366@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 03/05/2024 14:02, Alexandre Ghiti wrote:
> Hi Ben,
> 
> On 03/05/2024 14:19, Ben Dooks wrote:
>> On 03/05/2024 13:16, Alexandre Ghiti wrote:
>>> Hi Xiao,
>>>
>>> On 13/03/2024 11:33, Xiao Wang wrote:
>>>> When the dst buffer pointer points to the last accessible aligned 
>>>> addr, we
>>>> could still run another iteration of unrolled copy.
>>>>
>>>> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
>>>> ---
>>>>   arch/riscv/lib/uaccess.S | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>>>> index 2e665f8f8fcc..1399d797d81b 100644
>>>> --- a/arch/riscv/lib/uaccess.S
>>>> +++ b/arch/riscv/lib/uaccess.S
>>>> @@ -103,7 +103,7 @@ SYM_FUNC_START(fallback_scalar_usercopy)
>>>>       fixup REG_S   t4,  7*SZREG(a0), 10f
>>>>       addi    a0, a0, 8*SZREG
>>>>       addi    a1, a1, 8*SZREG
>>>> -    bltu    a0, t0, 2b
>>>> +    bleu    a0, t0, 2b
>>>>       addi    t0, t0, 8*SZREG /* revert to original value */
>>>>       j    .Lbyte_copy_tail
>>>
>>>
>>> I agree it is still safe to continue for another word_copy here.
>>>
>>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>
>> Out of interest, has anyone checked if causing a schedule event during
>> this code breaks like the last time we had issues with the upstream
>> testing?
> 
> 
> I vaguely remember something, do you have a link to that discussion by 
> chance?
> 
> 
>>
>> I did propose saving the state of the user-access flag in the task
>> struct
> 
> 
> Makes sense, I just took a quick look and SR_SUM is cleared as soon as 
> we enter handle_exception() and it does not seem to be restored. Weird 
> it works, unless I missed something!
> 
> 
>> but we mostly solved it by making sleeping functions stay
>> away from the address calculation. This of course may have been done
>> already or need to be done if three's long areas where the user-access
>> flags can be disabled (generally only a few drivers did this, so we
>> may not have come across the problem)
>>
> I don't understand what you mean here, would you mind expanding a bit?
> 

I think this was all gone through in the original post where
we initially suggested saving SR_SUM and then moved as much out
of the critical SR_SUM area by changing how the macros worked

https://lore.kernel.org/linux-riscv/20210318151010.100966-1-ben.dooks@codethink.co.uk/

https://lore.kernel.org/linux-riscv/20210329095749.998940-1-ben.dooks@codethink.co.uk/
-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


