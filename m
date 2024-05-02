Return-Path: <linux-kernel+bounces-167078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0A18BA432
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63331F230F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D815158A33;
	Thu,  2 May 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXjjfoMS"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460E1586F1
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693709; cv=none; b=C9baRLCBoNxGzWRONxZATYeZQIxUkYCwPj/EISC6jMnZW//GM9rDMA58HJTGHbPkUUDXNhdbAKdPRPwK06is7pIyUyWHFsRQfD8AMyOsQuERQZz7J/kRQ2p4RnnV1j2Dnub7RQtOj8AY1dsWIRi4WCE9IHxwCtgoOOdvyuul4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693709; c=relaxed/simple;
	bh=dOWn3mSOcYVMheI1WG2qyhEhcJ7Dm78iq59XNwASGMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eae+9D1vOWQjvxHzEJWSa8o49UR7ilX5xkFd1CfBIFnY+nu+y0gQEy5GuM00BEL8npYYM1f56jFJqELf4wvUmtusWc+7AuSbeUqDnvWNj/BSZe9ViQERAPFIL145WhLfS3k8Py1V5knoWoghx0IcJtt1xAyyCYa08y/gRJfQsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXjjfoMS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572adaa172cso1322571a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714693705; x=1715298505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrDO1cTmY8l+cA35dK9d5NCs28LmCIY9h9rPS8ELHI0=;
        b=XXjjfoMSk1UlMrS+XBmKGGqUUI15FBisTw00LuVgVKVFYmEDcTOBsoGXSdLx8YUrYL
         c4XabIhxZhsoHZYHl/iOaoLlvY+VfI/acBSaO/gaA9rqyG3a7yeY/OBr3E588ViydBrL
         r63jv/kAMntUHezwuIDwjmPnBrZqIp/8BtSEL9/KNpF2D2qXksOwkHO859ep3+DnXcHO
         Qw/DlfgLifNHf/HSLsUy6ho3LAPjYLQV3+YDTFexTusJWviBBWaVXhUf3ob1JrA4r5lZ
         XX0zD5jPoeccxjl4OX2vJvB2k+Y32ThZUgirxT5aFWdeoDCXuQV02Oxdwuoi5QXVwwzA
         ztTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714693705; x=1715298505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrDO1cTmY8l+cA35dK9d5NCs28LmCIY9h9rPS8ELHI0=;
        b=KlaNO0mxAMSTSI7QL+k25L4QUbDAW7UxRVoXEkJ5oG3Q81PC2E0F9sutL0fkz98T0c
         6kPRsltMapTH/iRwmqSsK1MNcvak1QAvPXjSMouMIkiO/pTQTbp2qF8dO+uIafi/MtlB
         T35V19pZ7IY9rtgziecNsjrZg7CFe2rpicIm5XCa2gmjd3Mg/xMnVQGGE/bV59UghI+K
         0LJ6dyspoyyncGk4o6iFmRP8G0YwME3m7VIw3UAtFy60WqC5NjHQ1/8xTcecHuQH5bJx
         4c8Pu6PUKj6TNlUPm6Cgu+feovf/kXyvpKD/Tkma7wMOnu7Ee80xounGZYABxK53KX26
         pQYg==
X-Forwarded-Encrypted: i=1; AJvYcCUFzagUBYO+FEo+J/BKC2mLGOtz2/33IYtDasZMQ0/rKxTjzdoP4kK5SQaxavFdu5iS2ksVbOjtK4EWmGl0syfY7GT1VmExNRzYFzC9
X-Gm-Message-State: AOJu0YzV+N78jG1ObcaKb3fq5IG4ON2gZDooidvJrVicwFKZKg8rgeu/
	711P8fonqRWROVLBMTI3ckisH+0pErVU68nMhCIJDw8T3Op31dwkv6AoX0JurV5oXic2YlWoVZ/
	ervf1dltYapzNcVsgzhnF79CcgEQ=
X-Google-Smtp-Source: AGHT+IF5EpM0SOk24Jso5+sRxEtMuYuzHrkILA6sJEuAVYq0B3tFNYQStGu+qJze/qOSfOuJwYclgmL9wYD7Hb47TOw=
X-Received: by 2002:a50:d783:0:b0:572:afb6:3b7c with SMTP id
 w3-20020a50d783000000b00572afb63b7cmr3459594edi.0.1714693705003; Thu, 02 May
 2024 16:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713559768.git.jpoimboe@kernel.org> <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop> <20240421052540.w7gtahoko2qerhqq@treble>
 <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com> <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
In-Reply-To: <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
From: Paul McKenney <paulmckrcu@gmail.com>
Date: Thu, 2 May 2024 16:48:13 -0700
Message-ID: <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers __noreturn
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>, 
	Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 2:47=E2=80=AFPM Paul McKenney <paulmckrcu@gmail.com=
> wrote:
>
> And this definitely helped, thank you!
>
> However, this one still remains:
>
> vmlinux.o: warning: objtool: ia32_sys_call+0x29b6:
> __ia32_sys_exit_group() is missing a __noreturn annotation

And looking at the patched code, this function looks to me to be
correctly marked.

No idea...  :-/

                                          Thanx, Paul

> Please see below for my diffs against next-20240419, in case I messed
> something up.
>
> I attached a copy as well, given that I am away from mutt, hence using
> gmail directly.
>
>                                                 Thanx, Paul
>
> -----------------------------------------------------
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 6de50b80702e6..9810ba2857a5c 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -49,7 +49,10 @@ static __always_inline bool do_syscall_x64(struct
> pt_regs *regs, int nr)
>
>   if (likely(unr < NR_syscalls)) {
>   unr =3D array_index_nospec(unr, NR_syscalls);
> - regs->ax =3D x64_sys_call(regs, unr);
> + if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
> + regs->ax =3D sys_call_table[unr](regs);
> + else
> + regs->ax =3D x64_sys_call(regs, unr);
>   return true;
>   }
>   return false;
> @@ -66,7 +69,10 @@ static __always_inline bool do_syscall_x32(struct
> pt_regs *regs, int nr)
>
>   if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
>   xnr =3D array_index_nospec(xnr, X32_NR_syscalls);
> - regs->ax =3D x32_sys_call(regs, xnr);
> + if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
> + regs->ax =3D x32_sys_call_table[xnr](regs);
> + else
> + regs->ax =3D x32_sys_call(regs, xnr);
>   return true;
>   }
>   return false;
> @@ -162,7 +168,10 @@ static __always_inline void
> do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
>
>   if (likely(unr < IA32_NR_syscalls)) {
>   unr =3D array_index_nospec(unr, IA32_NR_syscalls);
> - regs->ax =3D ia32_sys_call(regs, unr);
> + if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
> + regs->ax =3D ia32_sys_call_table[unr](regs);
> + else
> + regs->ax =3D ia32_sys_call(regs, unr);
>   } else if (nr !=3D -1) {
>   regs->ax =3D __ia32_sys_ni_syscall(regs);
>   }
> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index c2235bae17ef6..aab31760b4e3e 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -14,25 +14,16 @@
>  #endif
>
>  #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs=
 *);
> -
>  #include <asm/syscalls_32.h>
>  #undef __SYSCALL
>
> -/*
> - * The sys_call_table[] is no longer used for system calls, but
> - * kernel/trace/trace_syscalls.c still wants to know the system
> - * call address.
> - */
> -#ifdef CONFIG_X86_32
>  #define __SYSCALL(nr, sym) __ia32_##sym,
> -const sys_call_ptr_t sys_call_table[] =3D {
> +const sys_call_ptr_t ia32_sys_call_table[] =3D {
>  #include <asm/syscalls_32.h>
>  };
>  #undef __SYSCALL
> -#endif
>
>  #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
> -
>  long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
>   switch (nr) {
> diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
> index 33b3f09e6f151..ff36a993a07e0 100644
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -8,14 +8,13 @@
>  #include <asm/syscall.h>
>
>  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs =
*);
> +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn
> __x64_##sym(const struct pt_regs *);
>  #include <asm/syscalls_64.h>
>  #undef __SYSCALL
>
> -/*
> - * The sys_call_table[] is no longer used for system calls, but
> - * kernel/trace/trace_syscalls.c still wants to know the system
> - * call address.
> - */
> +#undef __SYSCALL_NORETURN
> +#define __SYSCALL_NORETURN __SYSCALL
> +
>  #define __SYSCALL(nr, sym) __x64_##sym,
>  const sys_call_ptr_t sys_call_table[] =3D {
>  #include <asm/syscalls_64.h>
> @@ -23,7 +22,6 @@ const sys_call_ptr_t sys_call_table[] =3D {
>  #undef __SYSCALL
>
>  #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> -
>  long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
>   switch (nr) {
> diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> index 03de4a9321318..4221ecce6e689 100644
> --- a/arch/x86/entry/syscall_x32.c
> +++ b/arch/x86/entry/syscall_x32.c
> @@ -8,11 +8,20 @@
>  #include <asm/syscall.h>
>
>  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs =
*);
> +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn
> __x64_##sym(const struct pt_regs *);
>  #include <asm/syscalls_x32.h>
>  #undef __SYSCALL
>
> -#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> +#undef __SYSCALL_NORETURN
> +#define __SYSCALL_NORETURN __SYSCALL
> +
> +#define __SYSCALL(nr, sym) __x64_##sym,
> +const sys_call_ptr_t x32_sys_call_table[] =3D {
> +#include <asm/syscalls_x32.h>
> +};
> +#undef __SYSCALL
>
> +#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
>  long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
>   switch (nr) {
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
> b/arch/x86/entry/syscalls/syscall_64.tbl
> index a396f6e6ab5bf..7ec68d94eb593 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -2,7 +2,7 @@
>  # 64-bit system call numbers and entry vectors
>  #
>  # The format is:
> -# <number> <abi> <name> <entry point>
> +# <number> <abi> <name> <entry point> [0 noreturn]
>  #
>  # The __x64_sys_*() stubs are created on-the-fly for sys_*() system call=
s
>  #
> @@ -68,7 +68,7 @@
>  57 common fork sys_fork
>  58 common vfork sys_vfork
>  59 64 execve sys_execve
> -60 common exit sys_exit
> +60 common exit sys_exit 0 noreturn
>  61 common wait4 sys_wait4
>  62 common kill sys_kill
>  63 common uname sys_newuname
> @@ -239,7 +239,7 @@
>  228 common clock_gettime sys_clock_gettime
>  229 common clock_getres sys_clock_getres
>  230 common clock_nanosleep sys_clock_nanosleep
> -231 common exit_group sys_exit_group
> +231 common exit_group sys_exit_group 0 noreturn
>  232 common epoll_wait sys_epoll_wait
>  233 common epoll_ctl sys_epoll_ctl
>  234 common tgkill sys_tgkill
> diff --git a/arch/x86/include/asm/cpufeatures.h
> b/arch/x86/include/asm/cpufeatures.h
> index 3c7434329661c..d64b0a5291f10 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -470,6 +470,7 @@
>  #define X86_FEATURE_BHI_CTRL (21*32+ 2) /* "" BHI_DIS_S HW control avail=
able */
>  #define X86_FEATURE_CLEAR_BHB_HW (21*32+ 3) /* "" BHI_DIS_S HW
> control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear
> branch history at vmexit using SW loop */
> +#define X86_FEATURE_INDIRECT_BRANCH_OK (21*32+ 5) /* "" It's OK to
> use indirect branches */
>
>  /*
>   * BUG word(s)
> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscal=
l.h
> index 2fc7bc3863ff6..dfb59521244c2 100644
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -16,14 +16,20 @@
>  #include <asm/thread_info.h> /* for TS_COMPAT */
>  #include <asm/unistd.h>
>
> -/* This is used purely for kernel/trace/trace_syscalls.c */
>  typedef long (*sys_call_ptr_t)(const struct pt_regs *);
>  extern const sys_call_ptr_t sys_call_table[];
>
> +#if defined(CONFIG_X86_32)
> +#define ia32_sys_call_table sys_call_table
> +#else
>  /*
>   * These may not exist, but still put the prototypes in so we
>   * can use IS_ENABLED().
>   */
> +extern const sys_call_ptr_t ia32_sys_call_table[];
> +extern const sys_call_ptr_t x32_sys_call_table[];
> +#endif
> +
>  extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
>  extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
>  extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index ab18185894dfd..5fca46c78daf2 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1665,6 +1665,12 @@ static void __init bhi_select_mitigation(void)
>   if (!IS_ENABLED(CONFIG_X86_64))
>   return;
>
> + /*
> + * There's no HW mitigation in place.  Mark indirect branches as
> + * "not OK".
> + */
> + setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
> +
>   /* Mitigate KVM by default */
>   setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
>   pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
> @@ -1679,6 +1685,28 @@ static void __init spectre_v2_select_mitigation(vo=
id)
>   enum spectre_v2_mitigation_cmd cmd =3D spectre_v2_parse_cmdline();
>   enum spectre_v2_mitigation mode =3D SPECTRE_V2_NONE;
>
> + /*
> + * X86_FEATURE_INDIRECT_BRANCH_OK indicates that indirect calls are
> + * "OK" to use due to (at least) one of the following being true:
> + *
> + *   - the CPU isn't vulnerable to Spectre v2, BHI, etc;
> + *
> + *   - a HW mitigation is in place (e.g., IBRS, eIBRS+BHI_DIS_S); or
> + *
> + *   - the user disabled mitigations.
> + *
> + * Clearing the bit enables certain indirect branch "easy targets" [*]
> + * to be converted to a series of direct branches.
> + *
> + * Assume innocence until proven guilty: set it now and clear it later
> + * if/when needed.
> + *
> + * [*] The closer the indirect branch is to kernel entry, and the more
> + *     user-controlled registers there are, the easier target it may be
> + *     for future Spectre v2 variants.
> + */
> + setup_force_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
> +
>   /*
>   * If the CPU is not affected and the command line mode is NONE or AUTO
>   * then nothing to do.
> @@ -1765,11 +1793,16 @@ static void __init spectre_v2_select_mitigation(v=
oid)
>   break;
>
>   case SPECTRE_V2_LFENCE:
> + setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
> + fallthrough;
>   case SPECTRE_V2_EIBRS_LFENCE:
>   setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
> - fallthrough;
> + setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
> + break;
>
>   case SPECTRE_V2_RETPOLINE:
> + setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
> + fallthrough;
>   case SPECTRE_V2_EIBRS_RETPOLINE:
>   setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
>   break;
> diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table=
_32.c
> index 89df5d89d6640..c7d4bf955d2ba 100644
> --- a/arch/x86/um/sys_call_table_32.c
> +++ b/arch/x86/um/sys_call_table_32.c
> @@ -24,6 +24,7 @@
>  #define __SYSCALL_WITH_COMPAT(nr, native, compat) __SYSCALL(nr, native)
>
>  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long,
> unsigned long, unsigned long, unsigned long, unsigned long, unsigned
> long);
> +#define __SYSCALL_NORETURN __SYSCALL
>  #include <asm/syscalls_32.h>
>
>  #undef __SYSCALL
> diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table=
_64.c
> index b0b4cfd2308c8..4760c40ae5cd0 100644
> --- a/arch/x86/um/sys_call_table_64.c
> +++ b/arch/x86/um/sys_call_table_64.c
> @@ -19,6 +19,7 @@
>  #define sys_ioperm sys_ni_syscall
>
>  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long,
> unsigned long, unsigned long, unsigned long, unsigned long, unsigned
> long);
> +#define __SYSCALL_NORETURN __SYSCALL
>  #include <asm/syscalls_64.h>
>
>  #undef __SYSCALL
> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index 6abe143889ef6..16487d47e06a3 100755
> --- a/scripts/syscalltbl.sh
> +++ b/scripts/syscalltbl.sh
> @@ -54,7 +54,7 @@ nxt=3D0
>
>  grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
>
> - while read nr abi name native compat ; do
> + while read nr abi name native compat noreturn; do
>
>   if [ $nxt -gt $nr ]; then
>   echo "error: $infile: syscall table is not sorted or duplicates the
> same syscall number" >&2
> @@ -66,7 +66,9 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
>   nxt=3D$((nxt + 1))
>   done
>
> - if [ -n "$compat" ]; then
> + if [ -n "$noreturn" ]; then
> + echo "__SYSCALL_NORETURN($nr, $native)"
> + elif [ -n "$compat" ]; then
>   echo "__SYSCALL_WITH_COMPAT($nr, $native, $compat)"
>   elif [ -n "$native" ]; then
>   echo "__SYSCALL($nr, $native)"
> diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
> index 7ebf29c911849..1e8141ef1b15d 100644
> --- a/tools/objtool/noreturns.h
> +++ b/tools/objtool/noreturns.h
> @@ -7,12 +7,16 @@
>   * Yes, this is unfortunate.  A better solution is in the works.
>   */
>  NORETURN(__fortify_panic)
> +NORETURN(__ia32_sys_exit)
> +NORETURN(__ia32_sys_exit_group)
>  NORETURN(__kunit_abort)
>  NORETURN(__module_put_and_kthread_exit)
>  NORETURN(__reiserfs_panic)
>  NORETURN(__stack_chk_fail)
>  NORETURN(__tdx_hypercall_failed)
>  NORETURN(__ubsan_handle_builtin_unreachable)
> +NORETURN(__x64_sys_exit)
> +NORETURN(__x64_sys_exit_group)
>  NORETURN(arch_cpu_idle_dead)
>  NORETURN(bch2_trans_in_restart_error)
>  NORETURN(bch2_trans_restart_error)
>
> On Sun, Apr 21, 2024 at 1:40=E2=80=AFPM Paul McKenney <paulmckrcu@gmail.c=
om> wrote:
> >
> > They apply fine as is, so I have started tests with that pair of patche=
s.
> >
> >                                               Thanx, Paul
> >
> > On Sat, Apr 20, 2024 at 10:25=E2=80=AFPM Josh Poimboeuf <jpoimboe@kerne=
l.org> wrote:
> > >
> > > On Sat, Apr 20, 2024 at 06:58:58AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Apr 19, 2024 at 02:09:49PM -0700, Josh Poimboeuf wrote:
> > > > > The direct-call syscall dispatch functions don't know that the ex=
it()
> > > > > and exit_group() syscall handlers don't return.  As a result the =
call
> > > > > sites aren't optimized accordingly.
> > > > >
> > > > > Fix that by marking those exit syscall declarations as __noreturn=
.
> > > > >
> > > > > Fixes the following warnings:
> > > > >
> > > > >   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exi=
t() is missing a __noreturn annotation
> > > > >   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_e=
xit_group() is missing a __noreturn annotation
> > > > >
> > > > > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch hi=
story at syscall entry")
> > > > > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08=
852f17a3@paulmck-laptop
> > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > >
> > > > Looks good, but it does not apply on top of current -next and I don=
't
> > > > trust myself to hand-apply it (something about having just got off =
of
> > > > a flight across the big pond).
> > > >
> > > > Could you please let me know what else do I need to pull in to be a=
ble
> > > > to cleanly apply this one?
> > >
> > > This patch has a dependency on an earlier patch in the set:
> > >
> > >   https://lkml.kernel.org/lkml/982d05a2f669140f26500bee643011896d6610=
94.1713559768.git.jpoimboe@kernel.org
> > >
> > > Though I think it's not a hard dependency and I could reverse the ord=
er
> > > of the patches if needed.
> > >
> > > --
> > > Josh

