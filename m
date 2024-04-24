Return-Path: <linux-kernel+bounces-157681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A8F8B1487
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60C71C21B69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8D714264F;
	Wed, 24 Apr 2024 20:25:11 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6313A3E6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990311; cv=none; b=rH1aSE3hOQVgoxj9jhLq5Ib3Fq3wcAw/n3oto24TiWXP2U012ZmNzYl3AFNifjbrmkfNrxY0bSTiTKF5eMNkXKOYywCzXZqRpZUEI0+tRPYFGD9dexfaNIz0llLESSt7RtO6YSBtGG5WSu61oksTtOp8GNs7/xeZHI8v3rmK438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990311; c=relaxed/simple;
	bh=lHySUGua+4sJCvnfPToabXRHDk6ZdvTCJDMOG0eaCJo=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=cwL1sfCZZ+vZgUNtoGqr0y+EbeZajZSdWbIrjWHleLQI839bFiaCOm+2q7xx7E10jc+snSChaf40Y65pvkT9Nn7GpWuNBVbBT9DUz7psl99yn7am71rHoLBh7sPCG1PTtqa0W3rxMfYY6jpbxr/H/xdPKnOlnfvR9T9h9Gt5Ou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:44578)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rzir3-00CtOb-8V; Wed, 24 Apr 2024 14:04:33 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56944 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rzir2-00BaKD-48; Wed, 24 Apr 2024 14:04:32 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org,  x86@kernel.org,  Ard Biesheuvel
 <ardb@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  kexec@lists.infradead.org,  Nathan Chancellor <nathan@kernel.org>,  Nick
 Desaulniers <ndesaulniers@google.com>,  Kees Cook <keescook@chromium.org>,
  Bill Wendling <morbo@google.com>,  Justin Stitt <justinstitt@google.com>,
  Masahiro Yamada <masahiroy@kernel.org>
References: <20240424155309.1719454-11-ardb+git@google.com>
Date: Wed, 24 Apr 2024 15:04:02 -0500
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com> (Ard Biesheuvel's
	message of "Wed, 24 Apr 2024 17:53:10 +0200")
Message-ID: <87bk5yv87h.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rzir2-00BaKD-48;;;mid=<87bk5yv87h.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/ePpyQ5pyFK6twschP4ln4lEVPApbMIwA=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4833]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Ard Biesheuvel <ardb+git@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 546 ms - load_scoreonly_sql: 0.02 (0.0%),
	signal_user_changed: 4.0 (0.7%), b_tie_ro: 2.8 (0.5%), parse: 0.76
	(0.1%), extract_message_metadata: 18 (3.3%), get_uri_detail_list: 2.9
	(0.5%), tests_pri_-2000: 33 (6.1%), tests_pri_-1000: 2.1 (0.4%),
	tests_pri_-950: 1.12 (0.2%), tests_pri_-900: 0.81 (0.1%),
	tests_pri_-90: 84 (15.4%), check_bayes: 83 (15.2%), b_tokenize: 9
	(1.7%), b_tok_get_all: 11 (2.0%), b_comp_prob: 2.4 (0.4%),
	b_tok_touch_all: 57 (10.5%), b_finish: 0.67 (0.1%), tests_pri_0: 392
	(71.8%), check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 3.0
	(0.6%), poll_dns_idle: 0.79 (0.1%), tests_pri_10: 1.67 (0.3%),
	tests_pri_500: 6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/9] kexec x86 purgatory cleanup
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Ard Biesheuvel <ardb+git@google.com> writes:

> From: Ard Biesheuvel <ardb@kernel.org>
>
> The kexec purgatory is built like a kernel module, i.e., a partially
> linked ELF object where each section is allocated and placed
> individually, and all relocations need to be fixed up, even place
> relative ones.
>
> This makes sense for kernel modules, which share the address space with
> the core kernel, and contain unresolved references that need to be wired
> up to symbols in other modules or the kernel itself.
>
> The purgatory, however, is a fully linked binary without any external
> references, or any overlap with the kernel's virtual address space. So
> it makes much more sense to create a fully linked ELF executable that
> can just be loaded and run anywhere in memory.

It does have external references that are resolved when it is loaded.

Further it is at least my impression that non-PIC code is more
efficient.  PIC typically requires silly things like Global Offset
Tables that non-PIC code does not.  At first glance this looks like a
code passivization.

Now at lot of functionality has been stripped out of purgatory so maybe
in it's stripped down this make sense, but I want to challenge the
notion that this is the obvious thing to do.

> The purgatory build on x86 has already switched over to position
> independent codegen, which only leaves a handful of absolute references,
> which can either be dropped (patch #3) or converted into a RIP-relative
> one (patch #4). That leaves a purgatory executable that can run at any
> offset in memory with applying any relocations whatsoever.

I missed that conversation.  Do you happen to have a pointer?  I would
think the 32bit code is where the PIC would be most costly as the 32bit
x86 instruction set predates PIC being a common compilation target.

> Some tweaks are needed to deal with the difference between partially
> (ET_REL) and fully (ET_DYN/ET_EXEC) linked ELF objects, but with those
> in place, a substantial amount of complicated ELF allocation, placement
> and patching/relocation code can simply be dropped.

Really?  As I recall it only needed to handle a single allocation type,
and there were good reasons (at least when I wrote it) to patch symbols.

Again maybe the fact that people have removed 90% of the functionality
makes this make sense, but that is not obvious at first glance.

> The last patch in the series removes this code from the generic kexec
> implementation, but this can only be done once other architectures apply
> the same changes proposed here for x86 (powerpc, s390 and riscv all
> implement the purgatory using the shared logic)
>
> Link: https://lore.kernel.org/all/CAKwvOd=3Jrzju++=Ve61=ZdeshxUM=K3-bGMNREnGOQgNw=aag@mail.gmail.com/
> Link: https://lore.kernel.org/all/20240418201705.3673200-2-ardb+git@google.com/
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
>
> Ard Biesheuvel (9):
>   x86/purgatory: Drop function entry padding from purgatory
>   x86/purgatory: Simplify stack handling
>   x86/purgatory: Drop pointless GDT switch
>   x86/purgatory: Avoid absolute reference to GDT
>   x86/purgatory: Simplify GDT and drop data segment
>   kexec: Add support for fully linked purgatory executables
>   x86/purgatory: Use fully linked PIE ELF executable
>   x86/purgatory: Simplify references to regs array
>   kexec: Drop support for partially linked purgatory executables
>
>  arch/x86/include/asm/kexec.h       |   8 -
>  arch/x86/kernel/kexec-bzimage64.c  |   8 -
>  arch/x86/kernel/machine_kexec_64.c | 127 ----------
>  arch/x86/purgatory/Makefile        |  17 +-
>  arch/x86/purgatory/entry64.S       |  96 ++++----
>  arch/x86/purgatory/setup-x86_64.S  |  31 +--
>  arch/x86/purgatory/stack.S         |  18 --
>  include/asm-generic/purgatory.lds  |  34 +++
>  kernel/kexec_file.c                | 255 +++-----------------
>  9 files changed, 125 insertions(+), 469 deletions(-)
>  delete mode 100644 arch/x86/purgatory/stack.S
>  create mode 100644 include/asm-generic/purgatory.lds

Eric

