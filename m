Return-Path: <linux-kernel+bounces-117849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9619D88B640
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33FCB2692D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9321CF94;
	Mon, 25 Mar 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHMC0nOX"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EDA1C6A6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396074; cv=none; b=KENJGdTZlLrFnMnzkqxRZqmfXpdQw4m71LVinPgIwk+76OlUMNAaAhWt0Wz/oCIngiNtxvSWERiYl4DHTE+xjrdX3fX26Z6zTyQTHL0gwH8K56811+APpu0uKYx86GyMFCD1Msnjgt/5PMYwQ3yiPTzpWT1kS552LfxRHExr9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396074; c=relaxed/simple;
	bh=E1JT7uTAje0LoirQMcLPjl330yK5VeuDvvFl0ILtbvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp6/jBa5zclGOFUUMnm9iIdv/6FW/Uuyb5/rOKAvl+raX3BiUcgo3fzJfcSd+C+gi5gflK3SXmo9Y8WP9l5Oosd08LjE1reqOa+wBYXNUj6bVioa5f+uRz3Y0W+fuyYNMtqvgEf2XDj1e7jElIuo1YexA55YD8UzxSNEOpk582s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHMC0nOX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso3607256a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711396072; x=1712000872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmfRQIJ2f4eWBwdaZN8dSz4H2KFzejxhDJGkcx0CRVs=;
        b=iHMC0nOXxC/BUk+dC/BK2S6xJvZofR2RT12fTX181VbbqfR3lAZB3kGGHnqxAKvia8
         jfEjvJVDnD1hsJrsrQvvhq7WkLfmGZxH8uFNA2jz2kpDQtbvXURu33nLMjZ1rRKtVhsg
         1x+TD/rV0yuNSeN+j13/MHykC/3AOoKwJdKoztCKT4UJJaQMzUNKcYRKDxisbt+7lrT/
         5QCAbMO5d9C41ESTzhDQdC3cXHV7SHbePVSORAOGUu2ZFrM1BfGEfKKSpgWnUmkKOYQj
         +JVP5brKBgb8/V7BYt4g0RvQUbIpjyP0PU4UnooR8REftzURe2a+PNaCv+jEL1ycTwV8
         OGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396072; x=1712000872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmfRQIJ2f4eWBwdaZN8dSz4H2KFzejxhDJGkcx0CRVs=;
        b=gEHOA7EUP1zHXyVz1AVsFrKd7zZad73P7jZOyU2YfdJVT6p9F2JmrPzfHhaNSEuNVy
         lWzvOQQGoTZPScnBSXsMa9CVKsCjMYX5JoI6Z4bFd1D9mQRTUCNg0uPufFyuHIzWp+VW
         XQd83qF1eyaB80e/IPnhp5F+0T4qX6EK54By0gil6O0uJc4Dik/J/bnrmHWnIz0WUBqj
         ujRhBNiv373IJ/dYAgK90P/Fk8ajNUE7yhiYptdfPuNwpx9wxnEEnU5EYpt062tJr0cN
         AUiiLkPyFd0F1yY+kvjnVkVE/o/i/C6rl7fV9TJpoYCF71khPC6wyfcONYtTUeH39bIP
         Vc5w==
X-Forwarded-Encrypted: i=1; AJvYcCUg+Gzng2tDHkkS2ivwXJwUByd/KUmAGsRWYr7ar15RHyCJQyo2o+bjWYKIajEFKHGWUchuKiHdQb1OEVwjdjVeNXrTK1R77Xscs7O+
X-Gm-Message-State: AOJu0Yzw05CnINbe0HUoPZGjXFdIMXRj39VGKXrnQ1BrrpBPV0hv9bkv
	6Zy+DJTP71SGD2hzobTDxii2+1iMXD4TpX8xIvghO4xxTgU4hEGWlDmbbXNoetxLkFKZuz/P7o4
	2EcXxPtbFhRD/uv6Fq3YkYkHDxamxPn7GxZ8qFw==
X-Google-Smtp-Source: AGHT+IGXplUKBJqtzKmMl9SqNzgFEjsOVRpKapHhNUczt14WyhnyJtCggNrvR51DbcL/sN3wLGc+ZRatmVhsFe8cggY=
X-Received: by 2002:a17:90b:241:b0:29c:7592:febf with SMTP id
 fz1-20020a17090b024100b0029c7592febfmr726518pjb.16.1711396071839; Mon, 25 Mar
 2024 12:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325120003.1767691-1-sashal@kernel.org> <56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.org>
 <20240325181410.GA4122244@google.com>
In-Reply-To: <20240325181410.GA4122244@google.com>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Mon, 25 Mar 2024 13:47:40 -0600
Message-ID: <CAEUSe78CQrHFEz92svQKuvjU91FDc=Dt+NNf_5_=pKeE22TzXg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Mon, 25 Mar 2024 at 12:14, Sami Tolvanen <samitolvanen@google.com> wrote=
:
> On Mon, Mar 25, 2024 at 11:43:48AM -0600, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > On 25/03/24 6:00 a. m., Sasha Levin wrote:
> > > This is the start of the stable review cycle for the 6.7.11 release.
> > > There are 707 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git/patch/?id=3Dlinux-6.7.y&id2=3Dv6.7.10
> > > or in the git tree and branch at:
> > >          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-s=
table-rc.git linux-6.7.y
> > > and the diffstat can be found below.
> > >
> > > Thanks,
> > > Sasha
> >
> > We see *lots* of new warnings in RISC-V with Clang 17. Here's one:
> >
> > -----8<-----
> >   /builds/linux/mm/oom_kill.c:1195:1: warning: unused function '___se_s=
ys_process_mrelease' [-Wunused-function]
> >    1195 | SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, f=
lags)
> >         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> >   /builds/linux/include/linux/syscalls.h:221:36: note: expanded from ma=
cro 'SYSCALL_DEFINE2'
> >     221 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name=
, __VA_ARGS__)
> >         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> >   /builds/linux/include/linux/syscalls.h:231:2: note: expanded from mac=
ro 'SYSCALL_DEFINEx'
> >     231 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   /builds/linux/arch/riscv/include/asm/syscall_wrapper.h:81:2: note: ex=
panded from macro '__SYSCALL_DEFINEx'
> >      81 |         __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)      =
                   \
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   /builds/linux/arch/riscv/include/asm/syscall_wrapper.h:40:14: note: e=
xpanded from macro '__SYSCALL_SE_DEFINEx'
> >      40 |         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__=
VA_ARGS__))
> >         |                     ^~~~~~~~~~~~~~~~~~~~
> >   <scratch space>:30:1: note: expanded from here
> >      30 | ___se_sys_process_mrelease
> >         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >   1 warning generated.
> > ----->8-----
>
> Yup, I can reproduce this with ToT Clang. It looks like the alias
> isn't sufficient for Clang and we need to add an explicit __used
> attribute. Can you confirm if this patch fixes the issue for you?
>
> diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/includ=
e/asm/syscall_wrapper.h
> index 980094c2e976..ac80216549ff 100644
> --- a/arch/riscv/include/asm/syscall_wrapper.h
> +++ b/arch/riscv/include/asm/syscall_wrapper.h
> @@ -36,7 +36,8 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_=
regs *);
>                                         ulong)                           =
               \
>                         __attribute__((alias(__stringify(___se_##prefix##=
name))));      \
>         __diag_pop();                                                    =
               \
> -       static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_=
ARGS__));      \
> +       static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_=
ARGS__))       \
> +                       __used;                                          =
               \
>         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))

It does: the hundreds of warnings are gone. Build-tested with Clang
17. Logs, configs, binaries, etc., here:

  https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/daniel/builds/2eC43=
UtTjYk6loC9pNKT28SGmd5

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

