Return-Path: <linux-kernel+bounces-68645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A21857DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A21F274A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFF012A148;
	Fri, 16 Feb 2024 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="bhik6z12"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF159B5F;
	Fri, 16 Feb 2024 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090482; cv=none; b=D4rhVYsK9qVKty2e352AJZBruf15keVpUgr6tx2iLMXa7/VPmv6xDt1KU6FRv08JTB1inbjbU2LCfmJh7QwW3hnMw2PcX9evlYC2CcAspffgxOVmqUuoxcTef4LHkad1Iy+lioYV9YXzdWLc+otjkC5SodcdxM1KoaxnzNIDZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090482; c=relaxed/simple;
	bh=S6GH26MOvmbaGoEuB+DlOWQVrSfvfmK+ZAJKIJVu1tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxn68tmJHjVYR8PzOWze4AH8t1bF/u26r3ViJlPcWFellHE0Ll8Hmv/iZYVwF6lefB3Dc5lUXCCjismhR5T+cm+MHOzf837Zg2yCf0OTJTYVP1z2qcfapuOvft96E2a48gpgQDMjRl4+/LILpfRYaT26hTzC921Y+43qx1zOOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=bhik6z12; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708090402; x=1708695202; i=deller@gmx.de;
	bh=S6GH26MOvmbaGoEuB+DlOWQVrSfvfmK+ZAJKIJVu1tc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bhik6z12dhMQh+ymMFYThdU/H5OON3gs4pbF/rk5WIpDBAw8hP6VMvOw3lLRVWfQ
	 B5sUJR8/osD7lgL7hfe1Iqsb6l1KzJ/wV/5FlHrkZP0h0kah2NBxl1PLcfs5EIgYk
	 SbNJTPOBxIllw9fjkD3GU1jA1q1vEsi62jAFw1ZEv6BdIFIuKmydX24BbRDLoMLw/
	 1pG2BkThewn9nIvk+KKXClvUPUsOffR5O/UzBqckIQkUrTfRX2jeXWPVnH/M3fqHQ
	 IkIvONMhW06korD6AvDC+HIfu7rA7c4ILSOczcDX7c27NaAv1ipRHWHIwl7GPvAFz
	 rCtPU6lVFY0afI7iTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.214]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlXK-1r91dc2nf4-00jrDx; Fri, 16
 Feb 2024 14:33:22 +0100
Message-ID: <1e889ddc-e5ea-41c8-a316-61bae12dfa9c@gmx.de>
Date: Fri, 16 Feb 2024 14:48:04 +0100
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
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240216073315.3801833-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mtogNv3jHbkEpeD6Y3ODqTtw7RlDpefnjzIS5HdIZYXNtECJfO+
 +3zrdf/ms5ZHl8BWKGOmVdvIFtThgbOjjRQ+4CDIwCHmyHzdpy2PKapdaMJwMR/xMtRoQ7W
 y5cPUnwBnAMtrOCRJEjcrIQ+pjPgTwTbbIJLC/KNPKJzh6cYg0hbmG1ExI6VqpTWJDWg7ez
 BW5jYJO3Lqs2ly6H0DJtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QDJGDsXe/mI=;hn24JNmWWYk+OZ58glZ5NduYEZV
 435BlSb4VLP8SJeVX+smWnNWbuwVsJudf1XF1YC3w3trbF+xjdOSRIy0j/igDXFW498tVLr84
 DHvnuhGJIeklObFeBSugEC3JOGhnK030XOnXnmaplWOpGY80tZunUFWe14tCasag97NNKPMxr
 /dmTOpLVt+McIMaL8aa0GXxeAofi9NfOfhf4jEkoBmfQ233pWX+xEfmSFtIVeAAVmNqSbRSQS
 9u9vMvLxgYsfot99DjpChzFk/lUtw+GvnoSQH9MSVgs6isgeNZrEGlhGO2rWZ2SvzJ4hBzWJK
 zpBzYEVitKGg/KTyHPp7g0iIJ16r9xycYe/3FZjWOLE6Tf1XcFpvpekMWOm11tKSPTbeDxOMS
 wL/Gv1DlD2JFaPJON2C0/1ZF+kPGMdVJubrQ9bhancQTmHI1PYkJCM610Qg8NuUnAEq926Wfp
 +7VHBIUqfAzgJ36MD/EaenD46VFn9peou3sy3frd2E7j9rdjZi+Mr5n9BqboED0TRLcPmrzlX
 0FfiTbJb2XOjV73wR7y1BRr6FNh9b7fDXX3weryTYXJ0bzWQfUGwkX+W0tacr1FuE33/6V/nK
 AmSWly4/TyeARpGJQkg63jij/prLftz+eeSwOh7Uhe6Q1OQJGAIFcuAKYcFjPAXDvwKIrOoQJ
 S21mulwz4UfaE/hUdOr9nMR2A63yyDkFiKdDdCjnc6CIiAjfoOC8hZFT+h7FxWUcWcx8jtFzA
 aTJgBGJyCXTYqhdsOtglNFJskYjG6SOGhG0gfeSt6HCnGcFL2kwIIzb7/n7IjdlhFFMm80TJY
 2nRtHzGTcyuZsd2iQ/dbQ2+7zTXg+Xsi1C9euQhLNSDpc=

On 2/16/24 08:33, Guenter Roeck wrote:
> Convert to use real temp variables instead of clobbering processor
> registers.

Thanks for doing this.
It was on my todo list since quite some time :-)

> This aligns the 64-bit inline assembly code with the 32-bit
> assembly code which was rewritten with commit 427c1073a2a1
> ("parisc/unaligned: Rewrite 32-bit inline assembly of emulate_ldd()").
>
> While at it, fix comment in 32-bit rewrite code. Temporary variables are
> now used for both 32-bit and 64-bit code, so move their declarations
> to the function header.
>
> No functional change intended.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Implemented while analyzing a bug. I am not really sure of it is worth
> the effort, but I figured that I might as well submit it.
>
>   arch/parisc/kernel/unaligned.c | 29 +++++++++++++----------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unalign=
ed.c
> index c520e551a165..622c7b549fb8 100644
> --- a/arch/parisc/kernel/unaligned.c
> +++ b/arch/parisc/kernel/unaligned.c
> @@ -169,7 +169,8 @@ static int emulate_ldw(struct pt_regs *regs, int tor=
eg, int flop)
>   static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
>   {
>   	unsigned long saddr =3D regs->ior;
> -	__u64 val =3D 0;
> +	unsigned long shift;
> +	__u64 val =3D 0, temp1;

temp1 is ok to be "long".

>   	ASM_EXCEPTIONTABLE_VAR(ret);
>
>   	DPRINTF("load " RFMT ":" RFMT " to r%d for 8 bytes\n",
> @@ -180,25 +181,22 @@ static int emulate_ldd(struct pt_regs *regs, int t=
oreg, int flop)
>
>   #ifdef CONFIG_64BIT
>   	__asm__ __volatile__  (
> -"	depd,z	%3,60,3,%%r19\n"		/* r19=3D(ofs&7)*8 */
> -"	mtsp	%4, %%sr1\n"
> -"	depd	%%r0,63,3,%3\n"
> -"1:	ldd	0(%%sr1,%3),%0\n"
> -"2:	ldd	8(%%sr1,%3),%%r20\n"
> -"	subi	64,%%r19,%%r19\n"
> -"	mtsar	%%r19\n"
> -"	shrpd	%0,%%r20,%%sar,%0\n"
> +"	depd,z	%4,60,3,%2\n"		/* shift=3D(ofs&7)*8 */
> +"	mtsp	%5, %%sr1\n"
> +"	depd	%%r0,63,3,%4\n"
> +"1:	ldd	0(%%sr1,%4),%0\n"
> +"2:	ldd	8(%%sr1,%4),%3\n"
> +"	subi	64,%2,%2\n"
> +"	mtsar	%2\n"
> +"	shrpd	%0,%3,%%sar,%0\n"
>   "3:	\n"
>   	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
>   	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
> -	: "=3Dr" (val), "+r" (ret)
> -	: "0" (val), "r" (saddr), "r" (regs->isr)
> -	: "r19", "r20" );
> +	: "+r" (val), "+r" (ret), "=3D&r" (shift), "=3D&r" (temp1)
> +	: "r" (saddr), "r" (regs->isr) );

addr is actually being modified.
That's why I moved it into the output registers and
shuffled shift and temp1 one backwards, so that the registers
are now in the same ordering as on the 32-bit path.

I've pushed the modified patch here:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3Da6ea53ce77e9dd6e388d673bdd4d80741f97b914

Please double-check!

Thanks!
Helge


>   #else
> -    {
> -	unsigned long shift, temp1;
>   	__asm__ __volatile__  (
> -"	zdep	%2,29,2,%3\n"		/* r19=3D(ofs&3)*8 */
> +"	zdep	%2,29,2,%3\n"		/* shift=3D(ofs&3)*8 */
>   "	mtsp	%5, %%sr1\n"
>   "	dep	%%r0,31,2,%2\n"
>   "1:	ldw	0(%%sr1,%2),%0\n"
> @@ -214,7 +212,6 @@ static int emulate_ldd(struct pt_regs *regs, int tor=
eg, int flop)
>   	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 4b, "%1")
>   	: "+r" (val), "+r" (ret), "+r" (saddr), "=3D&r" (shift), "=3D&r" (tem=
p1)
>   	: "r" (regs->isr) );
> -    }
>   #endif
>
>   	DPRINTF("val =3D 0x%llx\n", val);


