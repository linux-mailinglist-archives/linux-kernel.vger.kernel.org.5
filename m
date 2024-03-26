Return-Path: <linux-kernel+bounces-118877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676E88C08D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CE81C37C78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416D5644B;
	Tue, 26 Mar 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzNsEhUo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD65475D;
	Tue, 26 Mar 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452205; cv=none; b=HeNGN/ACjCGmAXBnj6eK6I4K58HcRgjeOo9+Twa+/oxKRC82asi2B8JNisdrCN8E/iZreaL/zY+Kl/9QRny3u6IIFcYHxoyBJx9fYqDEpJlsKjOL7FWtgdvsiV7qlBgd4F4mXrkwxuClCvCPAly3SuOL53EsdADXEzJfthGdWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452205; c=relaxed/simple;
	bh=GfsAciEXnZ2LU1fryeqlHmfr9uhy9VqtlbVe4WUf3Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0/D7JxZXGyzKx1ayL0EKrCaMaRfAW9fkHRdczl2f4fnH8X0Bjcq3J9RERnc1ws/DHIRtJCEak4dS0AIfmzuYiEALaw87Fm+ewN6MgJl9IiahQdggndmY6JBbELilKGiCAgI1d3pkdLchPy8Ig+U/OqwC22cBl2ARs782WAFhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzNsEhUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFD5C43399;
	Tue, 26 Mar 2024 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452204;
	bh=GfsAciEXnZ2LU1fryeqlHmfr9uhy9VqtlbVe4WUf3Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzNsEhUoYobzkGaaXK2s3YnxJ0T5VhCzYCciT1pfmIUux06J8+veyBEuhk9Y+OnBQ
	 Z7UNjgdObH0gu2FXWWKhw0BTsJeIaxrPvvOR+XUk6YOC9mtzKTEfhpyrJCD1sNflPV
	 4jnIjmHP5nF1cv1AZmVFz8Bq8Lr9U8kvnZCXzGnHxu5UJ5KvyXqmNP4s9kz5Ylmj4A
	 hqzWgxxurVOX8qD60p+aq/0C9C7RXoY1P3P2/kkQBazKFMcuj3R9v+Z+dmw3qpmr5T
	 ffyasE0DFmwus+LrtBT12HjXVwxSvYdT1xcqevJt6cFEDidOcpYvxZlkTO1f579heJ
	 uCn1QWMRbpB2Q==
Date: Tue, 26 Mar 2024 07:23:23 -0400
From: Sasha Levin <sashal@kernel.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	florian.fainelli@broadcom.com, pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <ZgKwK4-S9uIaaMKD@sashalap>
References: <20240325120003.1767691-1-sashal@kernel.org>
 <56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.org>
 <20240325181410.GA4122244@google.com>
 <CAEUSe78CQrHFEz92svQKuvjU91FDc=Dt+NNf_5_=pKeE22TzXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe78CQrHFEz92svQKuvjU91FDc=Dt+NNf_5_=pKeE22TzXg@mail.gmail.com>

On Mon, Mar 25, 2024 at 01:47:40PM -0600, Daniel Díaz wrote:
>Hello!
>
>On Mon, 25 Mar 2024 at 12:14, Sami Tolvanen <samitolvanen@google.com> wrote:
>> On Mon, Mar 25, 2024 at 11:43:48AM -0600, Daniel Díaz wrote:
>> > Hello!
>> >
>> > On 25/03/24 6:00 a. m., Sasha Levin wrote:
>> > > This is the start of the stable review cycle for the 6.7.11 release.
>> > > There are 707 patches in this series, all will be posted as a response
>> > > to this one.  If anyone has any issues with these being applied, please
>> > > let me know.
>> > >
>> > > Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
>> > > Anything received after that time might be too late.
>> > >
>> > > The whole patch series can be found in one patch at:
>> > >          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
>> > > or in the git tree and branch at:
>> > >          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
>> > > and the diffstat can be found below.
>> > >
>> > > Thanks,
>> > > Sasha
>> >
>> > We see *lots* of new warnings in RISC-V with Clang 17. Here's one:
>> >
>> > -----8<-----
>> >   /builds/linux/mm/oom_kill.c:1195:1: warning: unused function '___se_sys_process_mrelease' [-Wunused-function]
>> >    1195 | SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>> >         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >   /builds/linux/include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE2'
>> >     221 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
>> >         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >   /builds/linux/include/linux/syscalls.h:231:2: note: expanded from macro 'SYSCALL_DEFINEx'
>> >     231 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >   /builds/linux/arch/riscv/include/asm/syscall_wrapper.h:81:2: note: expanded from macro '__SYSCALL_DEFINEx'
>> >      81 |         __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)                         \
>> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >   /builds/linux/arch/riscv/include/asm/syscall_wrapper.h:40:14: note: expanded from macro '__SYSCALL_SE_DEFINEx'
>> >      40 |         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
>> >         |                     ^~~~~~~~~~~~~~~~~~~~
>> >   <scratch space>:30:1: note: expanded from here
>> >      30 | ___se_sys_process_mrelease
>> >         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> >   1 warning generated.
>> > ----->8-----
>>
>> Yup, I can reproduce this with ToT Clang. It looks like the alias
>> isn't sufficient for Clang and we need to add an explicit __used
>> attribute. Can you confirm if this patch fixes the issue for you?
>>
>> diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
>> index 980094c2e976..ac80216549ff 100644
>> --- a/arch/riscv/include/asm/syscall_wrapper.h
>> +++ b/arch/riscv/include/asm/syscall_wrapper.h
>> @@ -36,7 +36,8 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
>>                                         ulong)                                          \
>>                         __attribute__((alias(__stringify(___se_##prefix##name))));      \
>>         __diag_pop();                                                                   \
>> -       static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__));      \
>> +       static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))       \
>> +                       __used;                                                         \
>>         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
>
>It does: the hundreds of warnings are gone. Build-tested with Clang

I'm assuming this fix needs to land upstream, and isn't specific for
stable?

I'll drop the offending commit for now, thanks!

-- 
Thanks,
Sasha

