Return-Path: <linux-kernel+bounces-111419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C3886C12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B2CB24DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680441232;
	Fri, 22 Mar 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XX34NDzS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJorp9nC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F05405DF;
	Fri, 22 Mar 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110576; cv=none; b=h2grvNn4so4h2cAaP9hOPuDzTaC8iKdN18Tpn2m30Kt1uEIoADcYeIu1cymDZBS3TkmQX7vgL4LMGfj8x5DeVAiSUPv9En8jiW7m54DqsqSTR8TujV1vN/SQhGLGYRg6+X+nzs+YqUHd3zV+hx6SFEe9k8cSXDfmQIlrCeC4Gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110576; c=relaxed/simple;
	bh=foIK+9f73HNeNks9IMM4f7cYpYcW1Ipegzfx9UD+DpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s70ebONEOV8NW9WX9SP0CylbespbuHImTn5yRtVQAA6vdLCQ/25kt4z44c3oQk5wKuvtog3rWGaHPnyZy7nv3O+4+1K/Z3k32MN5skEx6DOCt4cN9O1D1xXmVPsykl2S/OnkfolpPki7/GO5KGmKf6q838j6I42lbPKjDOItgw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XX34NDzS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJorp9nC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 13:29:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711110572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kw6jKfgYseBviEK7ThWkCBO+I75JNZXgwEbS3NadGUA=;
	b=XX34NDzSpJY5/auKw8m3bAZVQPXLyurLUHyus62eyaS2WihtYaCEGn2x5v6cx8IYwIYl0Z
	FdhOyNgmsV5KROmqopCVIlwSLC8efd9Ep0K7NBcTIbFQqryrbvB1wBt6Cb4RABIj/XBkU6
	t1xM2w63JndgZP/t5oa+W/R3Lfox9lneCo2EMtdtkpzsNXL0y88Ud0OeWMjMc/wuS++vje
	l/SUfNj8v1kGnH/J8yj+YR3w7gH8qWIgCcL51AnDBo14Auz1X9h7Hae9gWkD+ZCy+4TyH+
	PigUl7xDiMLCOtH+s4qUxBXGQ3A/OJ3GYMgzR8cDbavecI1+KX1GxJFJoiulZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711110572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kw6jKfgYseBviEK7ThWkCBO+I75JNZXgwEbS3NadGUA=;
	b=kJorp9nC1dajl14Wt4UPgHrt5NzDwscK2Snh1wYkxF4PxWwuKAwcAsfgO1NtdUzoOJSqGR
	CsN45VmUAYGfniAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMIs reported by console_blast.sh with 6.6.20-rt25
Message-ID: <20240322122921.U3WRsO4X@linutronix.de>
References: <ZfSfrzak9WS0ZFv7@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZfSfrzak9WS0ZFv7@thinkpad2021>

On 2024-03-15 15:21:19 [-0400], John B. Wyatt IV wrote:
> Hello John,
Hi John B.,

> The real-time team at Red Hat is discussing backporting the rt patchset i=
n 6.6
> to RHEL 9/Stream 9. I decided to test v6.6.20-rt25 from stable-rt with
> console_blast.sh. It reported similar NMIs from my testing of 6.7.0-rt6 w=
ith
> that high cpu count server over uart 8250; which is expected since the pa=
tchset
> is similar.
>=20
> One interesting thing is that 6.7.0-rt6 fully preemptive + realtime tuned=
 profile
> did not return any NMIs while 6.6 did with that same configuration.

The thing is that console_blast.sh does this "show a backtrace on all
CPUs, please" which triggers NMIs on all CPUs for backtrace. I can't
imagine how you did obtain the backtraces without an NMI. Unless the
tuned profile disables this somehow.

> Another aspect I noticed during my testing. I did not set grub to
> start with the realtime profile at boot for this machine. When I did set
> it the second (and latter) NMI did not show for fully preemptive (the
> 3rd set at the bottom of this email).=20
>=20
> Caller info was enabled. No modifications to the source code were made.
>=20
> I have not tested previous versions before 6.7.0-rt6 or 6.6.20-rt25;
> with the exception of accidently testing 6.6.10-rt19. 6.6.10 also
> reported NMIs during this test. If you wish to see these reports please
> let me know.

This NMI part has nothing todo with printk. If you need this clarified,
I would need a reproducer.

=E2=80=A6
> -----------------------------
> NMI Backtrace for 6.6.20-rt25 no forced preemption with tuned realtime pr=
ofile
> -----------------------------
>=20
> [ T2614] Kernel panic - not syncing: sysrq triggered crash
> [   C56] NMI backtrace for cpu 56
> [   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5=
C7411.86B.9409.D04.2212261349 12/26/2022
> [ C56] RIP: 0010:io_serial_out (arch/x86/kernel/early_printk.c:105)=20
> [ C56] Code: 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f =
1f 44 00 00 0f b6 8f c1 00 00 00 89 d0 0f b7 57 08 d3 e6 01 f2 ee <c3> cc c=
c cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> All code
> =3D=3D=3D=3D=3D=3D=3D
=E2=80=A6
>   12:	90                   	nop
>   13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   18:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
>   1f:	89 d0                	mov    %edx,%eax
>   21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
>   25:	d3 e6                	shl    %cl,%esi
>   27:	01 f2                	add    %esi,%edx
>   29:	ee                   	out    %al,(%dx)
>   2a:*	c3                   	ret		<-- trapping instruction

where is this output from? The `ret' opcode usually does not cause a
trap. My guess is that the machine has been interrupted by an external
user at this position.
Side note: This is using early_printk, correct?
=E2=80=A6

> [   C56] Call Trace:
> [   C56]  <NMI>
> [ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115)=20
> [ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (dis=
criminator 1))=20
> [ C56] ? nmi_handle (arch/x86/kernel/nmi.c:149)=20
> [ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105)=20
> [ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:347)=20
> [ C56] ? exc_nmi (arch/x86/kernel/nmi.c:538)=20
> [ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1458)=20
> [ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105)=20
> [ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105)=20
> [ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105)=20
> [   C56]  </NMI>

This looks okay. The NMI did the backtrace as expected.

> [   C56]  <TASK>
> [ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 driv=
ers/tty/serial/8250/8250_port.c:3347)=20
> [ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_p=
ort.c:3343)=20
> [ C56] uart_console_write (drivers/tty/serial/serial_core.c:2134)=20
> [ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port=
=2Ec:3628)=20
> [ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:940)=20
> [ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminato=
r 1) kernel/printk/nbcon.c:1326 (discriminator 1))=20
> [ C56] vprintk_emit (kernel/printk/printk.c:2414)=20
> [ C56] _printk (kernel/printk/printk.c:2474)=20
> [ C56] panic (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/=
bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ker=
nel/panic.c:528 kernel/panic.c:339)=20
> [ C56] ? _printk (kernel/printk/printk.c:2474)=20
> [ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
> [ C56] __handle_sysrq (drivers/tty/sysrq.c:601)=20
> [ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
> [ C56] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
> [ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1=
) kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (disc=
riminator 1) kernel/sched/core.c:5872 (discriminator 1))=20
> [ C56] vfs_write (fs/read_write.c:582)=20
> [ C56] ksys_write (fs/read_write.c:637)=20
> [ C56] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:=
81)=20
> [ C56] ? do_dup2 (fs/file.c:1142)=20
> [ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
> [ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
> [ C56] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/=
include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561=
)=20
> [ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20

According to this, someone issued a `crash' via sysrq. Why?

=E2=80=A6
> [ T2614] ---[ end Kernel panic - not syncing: sysrq triggered crash ]---
yes exactly.
=E2=80=A6
> NMI Backtrace for 6.6.20-rt25 no forced preemption with tuned throughput-=
performance profile
> -----------------------------

This and the following backtrace shows the same picture: The CPU is
crashing due to proc/sysrq request and does CPU-backtraces via NMI and
polls in early_printk, waiting for the UART to become idle (probably).

I don't see an issue here so far.

=E2=80=A6
> --=20
> Sincerly,
> John Wyatt
> Software Engineer, Core Kernel

Sebastian

