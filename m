Return-Path: <linux-kernel+bounces-82286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C88681CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F3CB24EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9733130AF0;
	Mon, 26 Feb 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="UKB4DpOg"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9F1E893;
	Mon, 26 Feb 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978701; cv=none; b=aQbHXKzgu7AifLLiavsRi3OX52TCYMbAzUvDxKmFSFVRz5Gtbt7dqNtEA6CeToB2FKEWiLX1F1ZW+L3VVV/zAqUzS1tW/R9arj4Rzph22JBvY5dMtBBBlHc3lalcbt9b6sAarpKLMJAy8m7twwqdAcx025Phib2Oj+GRp8k/t90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978701; c=relaxed/simple;
	bh=iSpt6++2ulrSPwpHDBOxSMcxn7b0JUNiLB9x9NMJR4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeG65Rb0iYhq+BN0UQyrDfcqQfvgYeyhMvHAM+vXTZwMVFHTUz7NQjwFcrxNNh+zLf352atRXeNf3EV6TsSoRoUYg/VE737w6AE3dutn4FCdjDwRhh6pG1G14Y71hufTmMYp/OrEgisIEJruisMho5sll2wtLsJKtJAH7C7nIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=UKB4DpOg; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708978683; x=1709583483; i=deller@gmx.de;
	bh=iSpt6++2ulrSPwpHDBOxSMcxn7b0JUNiLB9x9NMJR4Q=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=UKB4DpOglUkN6/cG+iN7dDt20uxuqouYD/kuClRRI0XIPFgJX8jk3sPYa26GGjZx
	 Pige7zwUy5veZMFhRBc95vWIw6ajkQfIb3mvx3mtr9r+z3tvasZaefdmhs9Ss74CZ
	 9ZvRjFciuofuJWpAojOpT41p4b3s7Xf1+xfJ2mC04Ho7ZRCelFu45sMCDdkBpovbm
	 XSXK/V8HZvMhCP+fkc1UCCyrSq4gP7IoC1kHYl3znkWcVwnoLAGSLAajMTyT7BF/T
	 toKZp3owdSiTFex573nJgyBnvqaQiEzlhybXamBch2Cew/HHx+wr439AY9j0TTdJM
	 HzLpC+AXgWbxfwi8WQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.15]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1r3AkF0xq4-00beTb; Mon, 26
 Feb 2024 21:18:03 +0100
Message-ID: <4cf93ef1-b047-434c-ab2f-fa830cc1c1fc@gmx.de>
Date: Mon, 26 Feb 2024 21:18:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc/unaligned: Rewrite 64-bit inline assembly of
 emulate_ldd()
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240216073315.3801833-1-linux@roeck-us.net>
 <d5c6f6b6-e65b-4928-912d-464b9f2f6661@roeck-us.net>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <d5c6f6b6-e65b-4928-912d-464b9f2f6661@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sHDxFuqnO4r/3SnpI4OsEEowVPrP1ur2epiVCn4ibnvwc/Hzoph
 p0nAWye/PcTrNe+Pt4Ij4T0lhB26wGh+exbkYJfBt3gA3yI2lgXSjD+lv5oe9gxvzpfNbxd
 Xp78sIm8rHzHNdhqU6O/bJWkFWbpRLf3/WcCf4CcLnq22CyDz6v78IkML7BArLnSEzJIg5R
 mKvXLRAN5Ltgv7Ln1/Z8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VqwDr3yxq2E=;fxwZesX+jZukZyPETxO+GWFcPt5
 SFFNpcxcNcZXGNg2Z1xgLnWvBWhKOQJSRuOl7Se41sKanKdcPWdwtc7WrlAEV8Bwypqy1V0fO
 pX/oYPADS7FY7g0zYjyPsohUAuNb3CgYOi81C5AIeZg853AcH5VNSXsMABFE3Y0YfMw290igH
 mMKmY9t90Ulp3bdAUb8/Tdpxct+gk4g00CfIXslNQg2PF1/S+tt5mn/K/FJ4uBxaChAqJuOWE
 d4WQ3Pd3VqvqMPPR3pPZC5jNFOMot4pzUN3vt+suWgCiK5tsYMipOKtJ3dj4kTFGG6l9D92eO
 9HZkhSMiYg3eW8yxq/pxfox02cbi1MmNSgTCrIdcpzb1djetCsXkUhxxmPYc46QrVYghH6/WC
 OM7xFPTVCJuF5dZtwHeatLlt68lS+BZylTQjJvkeNwSQ8IVkJTJqenejc0quUH2aREFqoAojh
 16NHFDL2S30NzoTYoZRZOHMEXE2LYpWK+oQ0vL8Uzrbrpj7rqvALRH/c9yr9XJrd5XPAbwFVT
 a/E8vZD8wkIAOmhR+khlKjJ+otfGmN9dYJEwHyjQsHpkHhUxNd9NNOqfEU17AqDFUuvX3IgJv
 pvBBra+8Pest2L7iO4MNvYEzSWYlpKiRUFjG+tTReqDmNm/6pmx0exfHW2rlxi3scYhvqxy2n
 tnqXkSpnxcxo+o4NsNARqYTawqE/BqC7LIHm6LZgPJppgOrZ0cL7TmMqfL5OyObZ5Z039sSiX
 5r8nJFQmzwPE0+r/Scwq2Ps0Qco0RCtVly99Y1NQ2XVi24WIJxIuKUiWrTqAhBKZr6BKgkpGM
 xPTYjGnoPDsR2kA1Kd53pXlDHCU6Y/+FDKV2YuwxVxV84=

On 2/26/24 20:29, Guenter Roeck wrote:
> Hi Helge,
>
> On Thu, Feb 15, 2024 at 11:33:15PM -0800, Guenter Roeck wrote:
>> Convert to use real temp variables instead of clobbering processor
>> registers. This aligns the 64-bit inline assembly code with the 32-bit
>> assembly code which was rewritten with commit 427c1073a2a1
>> ("parisc/unaligned: Rewrite 32-bit inline assembly of emulate_ldd()").
>>
>> While at it, fix comment in 32-bit rewrite code. Temporary variables ar=
e
>> now used for both 32-bit and 64-bit code, so move their declarations
>> to the function header.
>>
>> No functional change intended.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Implemented while analyzing a bug. I am not really sure of it is worth
>> the effort, but I figured that I might as well submit it.
>>
>>   arch/parisc/kernel/unaligned.c | 29 +++++++++++++----------------
>>   1 file changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unalig=
ned.c
>> index c520e551a165..622c7b549fb8 100644
>> --- a/arch/parisc/kernel/unaligned.c
>> +++ b/arch/parisc/kernel/unaligned.c
>> @@ -169,7 +169,8 @@ static int emulate_ldw(struct pt_regs *regs, int to=
reg, int flop)
>>   static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
>>   {
>>   	unsigned long saddr =3D regs->ior;
>> -	__u64 val =3D 0;
>> +	unsigned long shift;
>> +	__u64 val =3D 0, temp1;
>>   	ASM_EXCEPTIONTABLE_VAR(ret);
>>
>>   	DPRINTF("load " RFMT ":" RFMT " to r%d for 8 bytes\n",
>> @@ -180,25 +181,22 @@ static int emulate_ldd(struct pt_regs *regs, int =
toreg, int flop)
>>
>>   #ifdef CONFIG_64BIT
>>   	__asm__ __volatile__  (
>> -"	depd,z	%3,60,3,%%r19\n"		/* r19=3D(ofs&7)*8 */
>> -"	mtsp	%4, %%sr1\n"
>> -"	depd	%%r0,63,3,%3\n"
>> -"1:	ldd	0(%%sr1,%3),%0\n"
>> -"2:	ldd	8(%%sr1,%3),%%r20\n"
>> -"	subi	64,%%r19,%%r19\n"
>> -"	mtsar	%%r19\n"
>> -"	shrpd	%0,%%r20,%%sar,%0\n"
>> +"	depd,z	%4,60,3,%2\n"		/* shift=3D(ofs&7)*8 */
>> +"	mtsp	%5, %%sr1\n"
>> +"	depd	%%r0,63,3,%4\n"
>> +"1:	ldd	0(%%sr1,%4),%0\n"
>> +"2:	ldd	8(%%sr1,%4),%3\n"
>> +"	subi	64,%2,%2\n"
>> +"	mtsar	%2\n"
>> +"	shrpd	%0,%3,%%sar,%0\n"
>>   "3:	\n"
>>   	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
>>   	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
>> -	: "=3Dr" (val), "+r" (ret)
>> -	: "0" (val), "r" (saddr), "r" (regs->isr)
>> -	: "r19", "r20" );
>> +	: "+r" (val), "+r" (ret), "=3D&r" (shift), "=3D&r" (temp1)
>> +	: "r" (saddr), "r" (regs->isr) );
>
> It looks like something went wrong when this patch was applied.

I think this was my fault when I tried to reshuffle the input vars :-(

> It is now
>
> +"      depd,z  %4,60,3,%3\n"           /* shift=3D(ofs&7)*8 */
> ...
> +       : "+r" (val), "+r" (ret), "+r" (saddr), "=3D&r" (shift), "=3D&r"=
 (temp1)
> +       : "r" (regs->isr) );
>
> meaning saddr is now %2, but the depd,z instruction
> still assumes it is %4. Unfortunately this results in a crash
> when trying to boot linux-next on parisc64.
>
> The patch below on top of linux-next fixes the problem for me.

I fixed it up with your hunk below in the parisc for-next branch, so it sh=
ould be
fixed in linux-next soon.

THANKS!

Helge



> Guenter
>
> ---
> iff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligne=
d.c
> index 31974eddedc9..a8e75e5b884a 100644
> --- a/arch/parisc/kernel/unaligned.c
> +++ b/arch/parisc/kernel/unaligned.c
> @@ -181,7 +181,7 @@ static int emulate_ldd(struct pt_regs *regs, int tor=
eg, int flop)
>
>   #ifdef CONFIG_64BIT
>          __asm__ __volatile__  (
> -"      depd,z  %4,60,3,%3\n"           /* shift=3D(ofs&7)*8 */
> +"      depd,z  %2,60,3,%3\n"           /* shift=3D(ofs&7)*8 */
>   "      mtsp    %5, %%sr1\n"
>   "      depd    %%r0,63,3,%2\n"
>   "1:    ldd     0(%%sr1,%2),%0\n"


