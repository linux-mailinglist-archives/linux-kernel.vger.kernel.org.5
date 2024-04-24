Return-Path: <linux-kernel+bounces-156620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9868B05DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7B01F25711
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7726E159598;
	Wed, 24 Apr 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN5S1jlO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC6158867;
	Wed, 24 Apr 2024 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950166; cv=none; b=sPb4j0fh+lxm8lmJ8Y8YtxPG/HvcIOACHpGS2PvI5CcDQ46EONQij0wqnq5pucu4GmlmGbCLA6a0jGOBK4/13y8T8sgYWoXqA/uUArKlePxS4CXWDYisdoDiyb0bwX4uSARCVv2cVRWlSDt68SmRpxRtsDHwj6Y3VunxuXt1EqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950166; c=relaxed/simple;
	bh=IrR6AXdLOvki8vwe1yOiucSte8ILSh4EklzoMTtkN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cymQtmkooeRXZJo9Z3LwmZk3Hdo1+vMnQO6x9p8JZWOne8AXWm3yz7eMAMgH3yBP9OYsK5FzCswXOGvxaBw2g9Y5H3A+2aqBpDi1VQ2GLVBw80hxQl/W9VFjmmJv7PUruuAaIy7FLUoM5ZoBAONsoTsU+w2C+l8b0Vsl5Ug1+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN5S1jlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F646C113CE;
	Wed, 24 Apr 2024 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713950166;
	bh=IrR6AXdLOvki8vwe1yOiucSte8ILSh4EklzoMTtkN+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZN5S1jlOj4vMMvYMtWX55yDS3aKRbL0Aqsujba+w0kEr3yXZJwtbgf7P47oddxeNi
	 ykVcjkGpA7WvRCVc/lz1B88UGIaq6MTyFsm+ymYx9a3eREV6CDyxX5xtcCVajZ5RM+
	 phNptJDQjxdm0qmaDt80Z2WJVjBmDd7kiFKAa0aCi5SrIngYd4ULJLPhHuNPaaiRet
	 vlPl0C48wtvMbGNtK9H4QeZFZFB9FQtekm8kNZVHX2RoQhFH/F6OWpAW4loRsQNUEO
	 edt7f3Eaxjx3RxVmC1H91V8bX1zzy523SF0Q8q7ivA/9t7HV0xt8OBRJE+NWiHdr3B
	 EwtGbHYLKgKMQ==
Date: Wed, 24 Apr 2024 12:14:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: boot failure after merge of the modules tree
Message-ID: <ZijNiXzNpfoyokrh@kernel.org>
References: <20240424183503.2a6ce847@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424183503.2a6ce847@canb.auug.org.au>

On Wed, Apr 24, 2024 at 06:35:03PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the modules tree, today's linux-next boot (powerpc
> pseries_le_defconfig) failed like this:
> 
> BUG: Kernel NULL pointer dereference at 0x00000030
> Faulting instruction address: 0xc00000000057a4ec
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5-08179-ga5ea707d10dc #1
> Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,HEAD pSeries
> NIP:  c00000000057a4ec LR: c0000000002cd32c CTR: c0000000002cd304
> REGS: c000000004997700 TRAP: 0380   Not tainted  (6.9.0-rc5-08179-ga5ea707d10dc)
> MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 84002484  XER: 20000000
> CFAR: c0000000002cd328 IRQMASK: 0 
> GPR00: c0000000002cd32c c0000000049979a0 c00000000163a500 0000000000010000 
> GPR04: 0000000000010000 0000000000004000 0000000000000000 0000000000002cc0 
> GPR08: 0000000000000030 0000000000000100 ffffffffffffffff 0000000000002000 
> GPR12: c0000000002cd304 c000000002b70000 c00000000001111c 0000000000000000 
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR24: 0000000000000000 0000000000000000 c000000002aa0940 c0000000026c0a40 
> GPR28: 0000000000010000 c0000000002cd32c 0000000000000030 c0000000027d0f78 
> NIP [c00000000057a4ec] execmem_alloc+0x5c/0x12c
> LR [c0000000002cd32c] alloc_insn_page+0x28/0x70
> Call Trace:
> [c000000004997a40] [c0000000002cd32c] alloc_insn_page+0x28/0x70
> [c000000004997a60] [c0000000002d07a4] __get_insn_slot+0x1cc/0x29c
> [c000000004997aa0] [c00000000005c434] arch_prepare_kprobe+0xbc/0x31c
> [c000000004997b20] [c0000000002d1b40] register_kprobe+0x54c/0x878
> [c000000004997b90] [c000000002018828] arch_init_kprobes+0x28/0x40
> [c000000004997bb0] [c00000000204b33c] init_kprobes+0x138/0x218
> [c000000004997c30] [c000000000010da8] do_one_initcall+0x80/0x2f8
> [c000000004997d00] [c000000002005aa8] kernel_init_freeable+0x1f8/0x520
> [c000000004997de0] [c000000000011148] kernel_init+0x34/0x26c
> [c000000004997e50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
> --- interrupt: 0 at 0x0
> Code: fbe1fff8 3940ffff 38e02cc0 7c9c2378 7fa802a6 e8c91e48 f8010010 fb41ffd0 39200100 fb61ffd8 f821ff61 7fc64214 <7ca6402a> eb5e0020 837e0028 e8de0008 
> ---[ end trace 0000000000000000 ]---
> 
> note: swapper/0[1] exited with irqs disabled
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Bisected to commit
> 
>   18da532eefc8 ("mm/execmem, arch: convert remaining overrides of module_alloc to execmem")
> 
> I have used the modules tree from next-20240423 for today.
> 
> This is a qemu boot test using:
> 
> qemu-system-ppc64 -M pseries -cpu POWER8 -m 2G -vga none -nographic -kernel ~/next/powerpc_pseries_le_defconfig/vmlinux -initrd ./ppc64le-rootfs.cpio.gz

This should fix it for now, I'll rework initialization a bit in v6
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..bea33bf538e9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -176,6 +176,7 @@ config PPC
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if PPC_RADIX_MMU
+	select ARCH_WANTS_EXECMEM_EARLY         if EXECMEM
 	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF


> -- 
> Cheers,
> Stephen Rothwell

-- 
Sincerely yours,
Mike.

