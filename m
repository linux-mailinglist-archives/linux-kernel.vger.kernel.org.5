Return-Path: <linux-kernel+bounces-55739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A984C0FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462E91F256E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2B1CD2A;
	Tue,  6 Feb 2024 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZ3RpgqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D31CABD;
	Tue,  6 Feb 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262860; cv=none; b=Kz2UVN4E79WBfkJ/tWjb0ztx6LjnVyYvtSFcWcxGC3/nd11B0zKOPjNbK16iZMd4gD1x0mYAcDzr4kwNBwOiweKHahXW02EAV34wTk27BMAKpah3vacZdEVan4HGMpisBvH7iF2DdFTjk/FmiMtsnIioOnT3/iBb9X27uNWMrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262860; c=relaxed/simple;
	bh=PRL2AU8Ec4e9wjqPqZ5xSv6RBbyoPP0VSFP7n7tEZso=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SPYUPGzF0mHXXSDfwGe2Uszk2C4n5Pff/zfdi3mWHVZNlKwkKFetBScqvknRkZRTchRXoLoyc5Mbkz8/eF7nEO3frWSlYEBUX6PagNqHdcHlx5V8vEmNXM8Ye6NoN+YM2bqeRWCY0lxq3rK04VmV2KDn0QJSPQzKia8GRuTPBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZ3RpgqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EABC433C7;
	Tue,  6 Feb 2024 23:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707262859;
	bh=PRL2AU8Ec4e9wjqPqZ5xSv6RBbyoPP0VSFP7n7tEZso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rZ3RpgqEI9xGCHR5iT0jRJXfgRa1YA/syYc2SWDw4ufHIbG61OvHeoaaF0tzQlCP2
	 pzDR9VPlmI9rbOYkUPvDkMO/kWVdCfwgQTRmJov6TYZcBC7lV3VHDaHDMd+oILJwuL
	 /ds+4i7rTEBSsM9Oab6c4VyN3s+tZJ0ofWbEFNvDnMQ6NcgiqEVkBTlYU2qlLCfUwi
	 lIPaxnb5wW/DXVb4Qgf1NGPGNPNMU4Iqz2FYdoGkx+ziyyQu90FMir/DL4I5h/iUD1
	 1K1JcvUKnnMrm/gf5gXM5GbJJFYu2I6jrUwe5yg9+pisoDAG/uELoZqwKkcmQ23HI4
	 pDnWCVWEp8T1A==
Date: Wed, 7 Feb 2024 08:40:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, Xin Li <xin@zytor.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/kprobes: Boost more instructions from
 grp2/3/4/5
Message-Id: <20240207084054.190a6103e40fe890363fb151@kernel.org>
In-Reply-To: <14799708-1f90-464f-9432-5b11755c3fca@illinois.edu>
References: <20240204031300.830475-1-jinghao7@illinois.edu>
	<20240204031300.830475-4-jinghao7@illinois.edu>
	<20240204210932.bd112a37dd3c276b046f6b16@kernel.org>
	<14799708-1f90-464f-9432-5b11755c3fca@illinois.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Feb 2024 22:39:32 -0600
Jinghao Jia <jinghao7@illinois.edu> wrote:

> On 2/4/24 06:09, Masami Hiramatsu (Google) wrote:
> > On Sat,  3 Feb 2024 21:13:00 -0600
> > Jinghao Jia <jinghao7@illinois.edu> wrote:
> > 
> >> With the instruction decoder, we are now able to decode and recognize
> >> instructions with opcode extensions. There are more instructions in
> >> these groups that can be boosted:
> >>
> >> Group 2: ROL, ROR, RCL, RCR, SHL/SAL, SHR, SAR
> >> Group 3: TEST, NOT, NEG, MUL, IMUL, DIV, IDIV
> >> Group 4: INC, DEC (byte operation)
> >> Group 5: INC, DEC (word/doubleword/quadword operation)
> >>
> >> These instructions are not boosted previously because there are reserved
> >> opcodes within the groups, e.g., group 2 with ModR/M.nnn == 110 is
> >> unmapped. As a result, kprobes attached to them requires two int3 traps
> >> as being non-boostable also prevents jump-optimization.
> >>
> >> Some simple tests on QEMU show that after boosting and jump-optimization
> >> a single kprobe on these instructions with an empty pre-handler runs 10x
> >> faster (~1000 cycles vs. ~100 cycles).
> >>
> >> Since these instructions are mostly ALU operations and do not touch
> >> special registers like RIP, let's boost them so that we get the
> >> performance benefit.
> >>
> > 
> > This looks good to me. And can you check how many instructions in the
> > vmlinux will be covered by this change typically?
> > 
> 
> I collected the stats from the LLVM CodeGen backend on kernel version 6.7.3
> using Gentoo's dist-kernel config (with a mod2yesconfig to make modules
> builtin) and here are the number of Grp 2/3/4/5 instructions that are newly
> covered by this patch:
> 
> Kernel total # of insns:    28552017    (from objdump)
> Grp2 insns:                 286249      (from LLVM)
> Grp3 insns:                 286556      (from LLVM)
> Grp4 insns:                 5832        (from LLVM)
> Grp5 insns:                 146314      (from LLVM)
> 
> Note that using LLVM means we miss the stats from inline assembly and
> assembly source files.

Thanks for checking! so it increases the coverage ~2.5% :)

Thank you,
 

> 
> --Jinghao
> 
> > Thank you,
> > 
> >> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> >> ---
> >>  arch/x86/kernel/kprobes/core.c | 23 +++++++++++++++++------
> >>  1 file changed, 17 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> >> index 7a08d6a486c8..530f6d4b34f4 100644
> >> --- a/arch/x86/kernel/kprobes/core.c
> >> +++ b/arch/x86/kernel/kprobes/core.c
> >> @@ -169,22 +169,33 @@ bool can_boost(struct insn *insn, void *addr)
> >>  	case 0x62:		/* bound */
> >>  	case 0x70 ... 0x7f:	/* Conditional jumps */
> >>  	case 0x9a:		/* Call far */
> >> -	case 0xc0 ... 0xc1:	/* Grp2 */
> >>  	case 0xcc ... 0xce:	/* software exceptions */
> >> -	case 0xd0 ... 0xd3:	/* Grp2 */
> >>  	case 0xd6:		/* (UD) */
> >>  	case 0xd8 ... 0xdf:	/* ESC */
> >>  	case 0xe0 ... 0xe3:	/* LOOP*, JCXZ */
> >>  	case 0xe8 ... 0xe9:	/* near Call, JMP */
> >>  	case 0xeb:		/* Short JMP */
> >>  	case 0xf0 ... 0xf4:	/* LOCK/REP, HLT */
> >> -	case 0xf6 ... 0xf7:	/* Grp3 */
> >> -	case 0xfe:		/* Grp4 */
> >>  		/* ... are not boostable */
> >>  		return false;
> >> +	case 0xc0 ... 0xc1:	/* Grp2 */
> >> +	case 0xd0 ... 0xd3:	/* Grp2 */
> >> +		/*
> >> +		 * AMD uses nnn == 110 as SHL/SAL, but Intel makes it reserved.
> >> +		 */
> >> +		return X86_MODRM_REG(insn->modrm.bytes[0]) != 0b110;
> >> +	case 0xf6 ... 0xf7:	/* Grp3 */
> >> +		/* AMD uses nnn == 001 as TEST, but Intel makes it reserved. */
> >> +		return X86_MODRM_REG(insn->modrm.bytes[0]) != 0b001;
> >> +	case 0xfe:		/* Grp4 */
> >> +		/* Only INC and DEC are boostable */
> >> +		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0b000 ||
> >> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b001;
> >>  	case 0xff:		/* Grp5 */
> >> -		/* Only indirect jmp is boostable */
> >> -		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
> >> +		/* Only INC, DEC, and indirect JMP are boostable */
> >> +		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0b000 ||
> >> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b001 ||
> >> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b100;
> >>  	default:
> >>  		return true;
> >>  	}
> >> -- 
> >> 2.43.0
> >>
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

