Return-Path: <linux-kernel+bounces-131674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7EB898AA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF331C296C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084641D531;
	Thu,  4 Apr 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="eU+xfFu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qNdab3Hq"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85B1C2A3;
	Thu,  4 Apr 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243286; cv=none; b=c9ZbqqnCxbgOFIHij0+y0QDF5qXJhu7UK6hLvC3g7wMY7YOhJv7kkF9/hVrvSH9seP63DBFOFMVU+8HLd8ew27IsYtm37lv1PF+cDsgKa4BCJJUyNlocd+R/emv4SEloIqm3BvL8TG0syJs4T2irAFM8xk8QHjhHPJzUSp+orEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243286; c=relaxed/simple;
	bh=SP7LKhB2PKzcyu6r6uLOTEELmqk5udEygJmfGGCcSvQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SC/v9z/WaXbV/iKPzv+pbKAb/xtRQ9XmrCzuGmFHayCHSBP8GU1D31gvtp9rSt6mrACWTjx+jlVuAd6zsSfgER5tnmD4oSu2DiopykuhkCbmGl2JTu5zIeTMXMRj7lBRzuiuFedRFkCEXPk6qKaASK7cvA7FJ8pUbSZjpE6Gip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=eU+xfFu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qNdab3Hq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2820D13800C9;
	Thu,  4 Apr 2024 11:08:03 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 04 Apr 2024 11:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712243283;
	 x=1712329683; bh=aRkSvq3mfcTUzYh16vvfOkrBDLnA1Dq0QtCI/knIBCc=; b=
	eU+xfFu/SEF6YfqqHjsC1eFGmq8AFUSvSt5HSxEk2/PURNh+XNDy61NP48dCDPN2
	5KYF4QizMwwZLsHSatKNzAt5X0JQ4ZWLz8wKTK2/RM+H+zIlB+N5LBa0PQaGKKuB
	CCvXy5LEM9I9DNLFbFMW3e7ULHct5bzq5ikDad50YlEhn8e5e1Ceu8U3rlydJywc
	ErYYJFPpYu3pxK7U456LhY7Qn1fKGZzX827zTAhTaatG3xw3oS7274gLVaysx02M
	QzMKBx243+OAWVzLLKDKQ+CnEcf2XcrpSF9epxJU7qd08w3Q9jrHLHp3lp0izOkp
	XNqNzrO+zA8w13kVTian8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712243283; x=
	1712329683; bh=aRkSvq3mfcTUzYh16vvfOkrBDLnA1Dq0QtCI/knIBCc=; b=q
	Ndab3HqsXd5rxW1816YpA5aSg4vToMJGcFq1P+4S8qs6iXlEsFu2x4nNfatFlKv1
	G2k24YwCtOKG69yD3nerY2BB1tWWoRyL2CfZUzux6e63lOIjckKhUUI0E+amvycR
	xqsZm32vC8B4f6okI9Ivlc6UGqySzlooeZk/dUUTQTd9aLSPRqwQ4oLdCKOD2e/K
	dR2EkROKeIfaQA/MjKTKp0NXHkUM5PkL1RK+xVVDaWLqTaWqjD2Mgpd3G1Za4/FE
	0cZdfErldbQG6Xaqdm0olpq66Cbk563zfOuf401YSJF5MVBgqq2dgz5mAb+US4HP
	otQLYucv+DKnRDFZb6cCw==
X-ME-Sender: <xms:UsIOZmnM9mDgK2_ArSfcNQx1b7RDUaeUqexuxHShc1ZSF4zzNix07A>
    <xme:UsIOZt16fcsVkLB46_w4J_EfbtSqxCOdJQ4TncgcNyJ6ydKlyIBTtCKVurh8Rai25
    JkcRPaJVVVN6D25YMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeevkeejleehhffhleegfedukeekfeeiueetueettdel
    teehleehhfekteejveeifeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhstggrlh
    hlfedvqdhofedvrdhssgdpshgtrghllheigedqnhefvddrshgspdhstggrlhhlieegqdhn
    ieegrdhssgdpshgtrghllheigedqohefvddrshgsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomh
X-ME-Proxy: <xmx:UsIOZko27EG_xI2e4plNiH0rBk9T6MGyKaevKRXb1OPW9XuiQoQVIA>
    <xmx:UsIOZqkFdcdpXQ0CHwnGQnNIulnNRw0Epyb-nEEKBInoL0uAfPj-Cg>
    <xmx:UsIOZk0D-RG2z9Oo5sZxZZYZRLqZqe893aUh2X1AaQYSwLK_EM_pCQ>
    <xmx:UsIOZhsy4LH3jFaJ74eTU8HRKJ7BrCiJdGRGxLoSbB71fbmLtEM8Ew>
    <xmx:U8IOZo_WjnD6dGr9VeT0taJESvdl6nycGdvtOjNn7HlgPuB4WmKn0eDV>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 14EE736A0076; Thu,  4 Apr 2024 11:08:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <465b3f19-56dc-4953-a677-58fd853f2f88@app.fastmail.com>
In-Reply-To: <20240328-mips_save_syscall-v1-1-9e1d62d6999d@flygoat.com>
References: <20240328-mips_save_syscall-v1-1-9e1d62d6999d@flygoat.com>
Date: Thu, 04 Apr 2024 16:07:42 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Oleg Nesterov" <oleg@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Xi Ruoyao" <xry111@xry111.site>
Subject: Re: [PATCH] MIPS: scall: Save thread_info.syscall unconditionally on entry
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B43=E6=9C=8828=E6=97=A5=E4=B8=89=E6=9C=88 =E4=B8=8B=E5=
=8D=882:27=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> thread_info.syscall is used by syscall_get_nr to supply syscall nr
> over a thread stack frame.
>
> Previously, thread_info.syscall is only saved at syscall_trace_enter
> when syscall tracing is enabled. However rest of the kernel code do
> expect syscall_get_nr to be available without syscall tracing. The
> previous design breaks collect_syscall.
>
> Move saving process to syscall entry to fix it.
>
> Reported-by: Xi Ruoyao <xry111@xry111.site>
> Link: https://github.com/util-linux/util-linux/issues/2867
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Ping, this needs to be in fixes tree.

Thanks

> ---
>  arch/mips/include/asm/ptrace.h |  2 +-
>  arch/mips/kernel/asm-offsets.c |  1 +
>  arch/mips/kernel/ptrace.c      | 15 ++++++---------
>  arch/mips/kernel/scall32-o32.S | 23 +++++++++++++----------
>  arch/mips/kernel/scall64-n32.S |  3 ++-
>  arch/mips/kernel/scall64-n64.S |  3 ++-
>  arch/mips/kernel/scall64-o32.S | 33 +++++++++++++++++----------------
>  7 files changed, 42 insertions(+), 38 deletions(-)
>
> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/pt=
race.h
> index d14d0e37ad02..4a2b40ce39e0 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -159,7 +159,7 @@ extern unsigned long exception_ip(struct pt_regs *=
regs);
>  #define exception_ip(regs) exception_ip(regs)
>  #define profile_pc(regs) instruction_pointer(regs)
>=20
> -extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long=
 syscall);
> +extern asmlinkage long syscall_trace_enter(struct pt_regs *regs);
>  extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
>=20
>  extern void die(const char *, struct pt_regs *) __noreturn;
> diff --git a/arch/mips/kernel/asm-offsets.c=20
> b/arch/mips/kernel/asm-offsets.c
> index d1b11f66f748..cb1045ebab06 100644
> --- a/arch/mips/kernel/asm-offsets.c
> +++ b/arch/mips/kernel/asm-offsets.c
> @@ -101,6 +101,7 @@ void output_thread_info_defines(void)
>  	OFFSET(TI_CPU, thread_info, cpu);
>  	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
>  	OFFSET(TI_REGS, thread_info, regs);
> +	OFFSET(TI_SYSCALL, thread_info, syscall);
>  	DEFINE(_THREAD_SIZE, THREAD_SIZE);
>  	DEFINE(_THREAD_MASK, THREAD_MASK);
>  	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 59288c13b581..61503a36067e 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -1317,16 +1317,13 @@ long arch_ptrace(struct task_struct *child,=20
> long request,
>   * Notification of system call entry/exit
>   * - triggered by current->work.syscall_trace
>   */
> -asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscal=
l)
> +asmlinkage long syscall_trace_enter(struct pt_regs *regs)
>  {
>  	user_exit();
>=20
> -	current_thread_info()->syscall =3D syscall;
> -
>  	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
>  		if (ptrace_report_syscall_entry(regs))
>  			return -1;
> -		syscall =3D current_thread_info()->syscall;
>  	}
>=20
>  #ifdef CONFIG_SECCOMP
> @@ -1335,7 +1332,7 @@ asmlinkage long syscall_trace_enter(struct=20
> pt_regs *regs, long syscall)
>  		struct seccomp_data sd;
>  		unsigned long args[6];
>=20
> -		sd.nr =3D syscall;
> +		sd.nr =3D current_thread_info()->syscall;
>  		sd.arch =3D syscall_get_arch(current);
>  		syscall_get_arguments(current, regs, args);
>  		for (i =3D 0; i < 6; i++)
> @@ -1345,23 +1342,23 @@ asmlinkage long syscall_trace_enter(struct=20
> pt_regs *regs, long syscall)
>  		ret =3D __secure_computing(&sd);
>  		if (ret =3D=3D -1)
>  			return ret;
> -		syscall =3D current_thread_info()->syscall;
>  	}
>  #endif
>=20
>  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
>  		trace_sys_enter(regs, regs->regs[2]);
>=20
> -	audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
> +	audit_syscall_entry(current_thread_info()->syscall,
> +			    regs->regs[4], regs->regs[5],
>  			    regs->regs[6], regs->regs[7]);
>=20
>  	/*
>  	 * Negative syscall numbers are mistaken for rejected syscalls, but
>  	 * won't have had the return value set appropriately, so we do so no=
w.
>  	 */
> -	if (syscall < 0)
> +	if (current_thread_info()->syscall < 0)
>  		syscall_set_return_value(current, regs, -ENOSYS, 0);
> -	return syscall;
> +	return current_thread_info()->syscall;
>  }
>=20
>  /*
> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32=
-o32.S
> index 18dc9b345056..2c604717e630 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -77,6 +77,18 @@ loads_done:
>  	PTR_WD	load_a7, bad_stack_a7
>  	.previous
>=20
> +	/*
> +	 * syscall number is in v0 unless we called syscall(__NR_###)
> +	 * where the real syscall number is in a0
> +	 */
> +	subu	t2, v0,  __NR_O32_Linux
> +	bnez	t2, 1f /* __NR_syscall at offset 0 */
> +	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
> +	b	2f
> +1:
> +	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
> +2:
> +
>  	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
>  	li	t1, _TIF_WORK_SYSCALL_ENTRY
>  	and	t0, t1
> @@ -114,16 +126,7 @@ syscall_trace_entry:
>  	SAVE_STATIC
>  	move	a0, sp
>=20
> -	/*
> -	 * syscall number is in v0 unless we called syscall(__NR_###)
> -	 * where the real syscall number is in a0
> -	 */
> -	move	a1, v0
> -	subu	t2, v0,  __NR_O32_Linux
> -	bnez	t2, 1f /* __NR_syscall at offset 0 */
> -	lw	a1, PT_R4(sp)
> -
> -1:	jal	syscall_trace_enter
> +	jal	syscall_trace_enter
>=20
>  	bltz	v0, 1f			# seccomp failed? Skip syscall
>=20
> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64=
-n32.S
> index 97456b2ca7dc..97788859238c 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -44,6 +44,8 @@ NESTED(handle_sysn32, PT_SIZE, sp)
>=20
>  	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
>=20
> +	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
> +
>  	li	t1, _TIF_WORK_SYSCALL_ENTRY
>  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
>  	and	t0, t1, t0
> @@ -72,7 +74,6 @@ syscall_common:
>  n32_syscall_trace_entry:
>  	SAVE_STATIC
>  	move	a0, sp
> -	move	a1, v0
>  	jal	syscall_trace_enter
>=20
>  	bltz	v0, 1f			# seccomp failed? Skip syscall
> diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64=
-n64.S
> index e6264aa62e45..be11ea5cc67e 100644
> --- a/arch/mips/kernel/scall64-n64.S
> +++ b/arch/mips/kernel/scall64-n64.S
> @@ -46,6 +46,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
>=20
>  	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
>=20
> +	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
> +
>  	li	t1, _TIF_WORK_SYSCALL_ENTRY
>  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
>  	and	t0, t1, t0
> @@ -82,7 +84,6 @@ n64_syscall_exit:
>  syscall_trace_entry:
>  	SAVE_STATIC
>  	move	a0, sp
> -	move	a1, v0
>  	jal	syscall_trace_enter
>=20
>  	bltz	v0, 1f			# seccomp failed? Skip syscall
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64=
-o32.S
> index d3c2616cba22..7a5abb73e531 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -79,6 +79,22 @@ loads_done:
>  	PTR_WD	load_a7, bad_stack_a7
>  	.previous
>=20
> +	/*
> +	 * absolute syscall number is in v0 unless we called syscall(__NR_##=
#)
> +	 * where the real syscall number is in a0
> +	 * note: NR_syscall is the first O32 syscall but the macro is
> +	 * only defined when compiling with -mabi=3D32 (CONFIG_32BIT)
> +	 * therefore __NR_O32_Linux is used (4000)
> +	 */
> +
> +	subu	t2, v0,  __NR_O32_Linux
> +	bnez	t2, 1f /* __NR_syscall at offset 0 */
> +	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
> +	b	2f
> +1:
> +	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
> +2:
> +
>  	li	t1, _TIF_WORK_SYSCALL_ENTRY
>  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
>  	and	t0, t1, t0
> @@ -113,22 +129,7 @@ trace_a_syscall:
>  	sd	a7, PT_R11(sp)		# For indirect syscalls
>=20
>  	move	a0, sp
> -	/*
> -	 * absolute syscall number is in v0 unless we called syscall(__NR_##=
#)
> -	 * where the real syscall number is in a0
> -	 * note: NR_syscall is the first O32 syscall but the macro is
> -	 * only defined when compiling with -mabi=3D32 (CONFIG_32BIT)
> -	 * therefore __NR_O32_Linux is used (4000)
> -	 */
> -	.set	push
> -	.set	reorder
> -	subu	t1, v0,  __NR_O32_Linux
> -	move	a1, v0
> -	bnez	t1, 1f /* __NR_syscall at offset 0 */
> -	ld	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
> -	.set	pop
> -
> -1:	jal	syscall_trace_enter
> +	jal	syscall_trace_enter
>=20
>  	bltz	v0, 1f			# seccomp failed? Skip syscall
>=20
>
> ---
> base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
> change-id: 20240328-mips_save_syscall-be471311cc9b
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun

