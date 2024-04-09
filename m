Return-Path: <linux-kernel+bounces-137699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B489E625
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B511C211AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A5158DCD;
	Tue,  9 Apr 2024 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cJRCcfum"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A01158DC8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705797; cv=none; b=N88GEinRUP+zYjOS1rfZ3QP5+Sy2XGpuO4TZ2Jrn8oFv+lmWNQLrmF5bnIwTrovJusocfs/BBoxxb1W3fz1p3NP9AlejjPSjtNmOcg+2Doc/moDfZHy/LtcMWKdrHsKdJDge3mx6JRSH19eYbDGICsC2F9iCArjuX3q6Bb9dzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705797; c=relaxed/simple;
	bh=IlVT+CK85bAJ4tLIN8z5XGMo3ERuJieslEjyAXxqFr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZVAcXqNYCG8EOneIHcuFIFHc4CEoyIV1hJpgbGKnxTAV0p5i8GaQUjQpy29QxDwPQCDuoS89tB5kvegD+MnryCCOkLQOHinVxnw5SCcO189GUTfhejcEkjeieFpCboj0uihhjLax1J8IK4eib9O1M8FsfLzCQrmUn0heWOhkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cJRCcfum; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 439NZfZJ3912505
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 9 Apr 2024 16:35:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 439NZfZJ3912505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1712705742;
	bh=YwyJn5+UQi9e8+unJOLQ85S4qwF8g699KG/AuSqGLuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJRCcfumoNHYR8DpvZeyZUuaV1y3mRjVB5t1r0mKDNuDTDDnLhDDzF12Cfh+bTBrb
	 94JxDBL6VRHvaM1KL4qBegUnHX2FvO83KYV0icxoDdxywNWXlUyUc4l08LQiSqLfU8
	 qrQSCQSmTKEis3uPVKWhtNiQ0mdo8EjEXt1RIfxNeMSym3LdEhXn4hPseylhXAML3F
	 WF+nEBrpJYv7PfYz6utNtwskkD5iOIfgF9ay1UmSz70QaUaJqmZd/y6+5FWjPob2ei
	 p3dSJn9V50RbANsaBmZ+JrpjX+eI1ZWfA8xRS6XCtq+QalgsdsbgNnoCQQglCuSo+T
	 b7kcWxA4BNz8w==
Message-ID: <56cbf1f0-0867-44c2-a9fd-712bf3549cbb@zytor.com>
Date: Tue, 9 Apr 2024 16:35:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/entry/64: Skip SYSRET validation tests when
 FRED is enabled
Content-Language: en-US
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, brgerst@gmail.com
References: <20240403062404.2956240-1-xin@zytor.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240403062404.2956240-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Now, for a FRED system the return value is ignored anyway, so the only 
benefit of this is skipping the test, correct?

I do observe than what is left of do_fast_syscall_32 is a single 
assignment followed by __do_fast_syscall_32(), which could be turned 
into a tailcall.

Another thing that has been added lately is a bunch of tests on the int 
$0x80 path. This is a slow path *on legacy hardware*, but on FRED 
systems it is the *fast* path for IA32 emulation. These tests are also 
totally unnecessary *AND IN FACT, WRONG* on a FRED system, as FRED 
distinguishes external interrupts from software interrupts.

Furthermore, under FRED interrupt 0x80 is available as a hardware 
interrupt (since there is no reason to block it out.) Therefore, going 
and poking the APIC as in int80_is_external() is INCORRECT and possibly 
fatal.

Again, the easiest way to fix that is to follow what XenPV does in 
int80_is_external(), but there is more unnecessary stuff: 
!user_mode(regs) cannot happen on FRED, and the stuff in the 
int80_emulation assembly function should, if it is needed at all on any 
FRED-compatible hardware (I don't believe so) should be done in the FRED 
user mode assembly entry stub.

Thus, it might be better to strip down do_int80_emulation() to a lean 
fred_int80_emulation().

	-hpa

On 4/2/24 23:24, Xin Li (Intel) wrote:
> Don't do SYSRET validation tests when FRED is enabled, since ERETU is
> the only legit instruction to return to user level.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>   arch/x86/entry/common.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 6356060caaf3..1c3944eb9901 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -72,7 +72,7 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
>   	return false;
>   }
>   
> -/* Returns true to return using SYSRET, or false to use IRET */
> +/* Returns true to return using SYSRET, or false to use IRET/ERETU */
>   __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
>   {
>   	add_random_kstack_offset();
> @@ -88,6 +88,10 @@ __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
>   	instrumentation_end();
>   	syscall_exit_to_user_mode(regs);
>   
> +	/* No test for FRED, which returns to user level with ERETU only */
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		return false;
> +
>   	/*
>   	 * Check that the register state is valid for using SYSRET to exit
>   	 * to userspace.  Otherwise use the slower but fully capable IRET
> @@ -325,7 +329,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>   	return true;
>   }
>   
> -/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
> +/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET/ERETU */
>   __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
>   {
>   	/*
> @@ -346,6 +350,10 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
>   	if (!__do_fast_syscall_32(regs))
>   		return false;
>   
> +	/* No test for FRED, which returns to user level with ERETU only */
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		return false;
> +
>   	/*
>   	 * Check that the register state is valid for using SYSRETL/SYSEXIT
>   	 * to exit to userspace.  Otherwise use the slower but fully capable
> 
> base-commit: 65d1240b6728b38e4d2068d6738a17e4ee4351f5

