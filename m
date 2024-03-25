Return-Path: <linux-kernel+bounces-117060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE788A68D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF00A1F61FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFDD73503;
	Mon, 25 Mar 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EVV/4Pxj"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E601E4BA;
	Mon, 25 Mar 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371043; cv=none; b=p+aMzInp5zv/RPqvDGa3f/bt/KNr6zDX3RcCskalBWYbPFiRFlRmhdms7N5CC69YcBYXiCTSWnLGjabCHtet+UIBESNnqPX3SHXvb1tjGLFM8ZwZ26O4OkngrEpGwFrqdcgFqvUcnLMO/epBRC0n+BeKOF4Xw8jrCi+HgCDrpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371043; c=relaxed/simple;
	bh=zvuonmBq4u3KPX2lMCTQexlT0daqIbyrfZaxn3w1U0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eJvpugJpcgubumVY45iVcZ5diiZMTawSBV8vVQARKd9xyTAWRqesb+dUemao3AxaMr3kiBF/M38/6AtkWGT14cqa0ir2+E4E8RAwxnDi+2APaykymMFnBVIj7IrT/QjF4E7wUQKht0WXObFakhj4I+9BP88ykKaMHOcM5Xf/FAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EVV/4Pxj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E0EE240E0174;
	Mon, 25 Mar 2024 12:50:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sfin19pqNbs8; Mon, 25 Mar 2024 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711371033; bh=L4B2Nrh/zKRS3rEQRcUVPajF1EamFs7aVTAi/97U3YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EVV/4PxjZfR2SBqLLDMTZQEMKs3ZK6n4oHDhFl0H7pAasdOWH25sIkjDn+ikYRKLz
	 /7o9Jkd6WEMV6Tn9t2xSPf3LKy7gkEC6RpGxCgaghof6J4tq01zNRFxKKPtyG9/RsU
	 dX9tl1fN7fz55JiFMGDz9TXUKmqi7npgyko+wpP2l4OhYkh9PlY4s+BDY1RdaWAFes
	 5konHAiz41NCxFOs9w77ZyvWsBIB4RvF0AoR20J7eR4lL8gfLBU4Q7wnoFK9fp2LL7
	 etq/cwfoy8880DDCvOlwvTdjwcndWzdidDj4cQ+nL8BsxNFx49pzEzYaH8bd4sJEgD
	 rICEU/1RE/BDJ/FtJ6HEEp5suFaR3SOoC2FvCA4RJXQyTX5so712Y9A0BTAUGeeQ+x
	 wGQU2vtRIhIuVcAurBATcf3RfqMnRKoU+DTvhtv7zWj/tVLNBtJACPjxz7u9KkIwgg
	 6vNRNjahh3aFhc0mhHXUXkrJYT4PThYOLzaxAqeATt+WWj9w5uJj3K+d03RVeKZGuR
	 50yQMcQWeAPaSSe8fFc2I3Y3jYaka5A0+2+EJ9aRWdNenQ9J1jl//gPKS9v7qaV3iw
	 Pe3OgtMwiHhMnSPwbUYGXB4zcqFI5IKYbcUnSZCMTcRIkxZsXxlYiL6oAI85JJ6/5z
	 x0LizSyEbEx2KVjHoEDWW/OA=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C926740E016C;
	Mon, 25 Mar 2024 12:50:22 +0000 (UTC)
Date: Mon, 25 Mar 2024 13:50:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: "V, Narasimhan" <Narasimhan.V@amd.com>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Aithal, Srikanth" <Srikanth.Aithal@amd.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure with kernel BUG at mm/usercopy.c on next-20240325
Message-ID: <20240325125017.GBZgFzCXVxeF50uGVE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5086E76CF24A39017DA8567189362@DM4PR12MB5086.namprd12.prod.outlook.com>

Adding more people from that

328c801335d5 ("cpumask: create dedicated kmem cache for cpumask var")

in linux-next.

On Mon, Mar 25, 2024 at 01:40:20PM +0100, V, Narasimhan wrote:
> [AMD Official Use Only - General]
> 
> Hi,
> There is a boot failure as below.
> On bisecting, the bad commit is found to be 328c801335d5f7edf2a3c9c331ddf8978f21e2a7.
> Boots fine if we revert the above bad commit.

Narasimhan,

please send your .config and reproduction instructions. I'm guessing
you're simply booting it, right?

Leaving in the rest for the newly CCed people.

> kernel BUG at mm/usercopy.c:102!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 15 PID: 567 Comm: systemd-udevd Not tainted 6.9.0-rc1-next-20240325-1711333827684 #1
> Hardware name: AMD Corporation Shale96/Shale96, BIOS RSH100BD 12/11/2023
> RIP: 0010:usercopy_abort+0x72/0x90
> Code: 4f f7 b8 50 48 c7 c2 31 a6 f4 b8 57 48 c7 c7 50 10 fe b8 48 0f 44 d6 48 c7 c6 32 30 f5 b8 4c 89 d1 49 0f 44 f3 e8 5e 2b d1 ff <0f> 0b 49 c7 c1 1c 60 f4 b8 4c 89 cf 4d 89 c8 eb a9 66 66 2e 0f 1f
> RSP: 0018:ff855d5641947e08 EFLAGS: 00010246
> RAX: 0000000000000060 RBX: 0000000000000000 RCX: ff44c5dccd9ff8a8
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
> RBP: ff855d5641947e20 R08: 0000000000000060 R09: 6c656e72654b203a
> R10: ffffffffba1edd60 R11: 657275736f707865 R12: 0000000000000008
> R13: ff44c5cd80037800 R14: 0000000000000001 R15: 0000000000000000
> FS:  00007fbc2be258c0(0000) GS:ff44c5dc86f80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbc2c459230 CR3: 0000000103f54004 CR4: 0000000000771ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? show_regs+0x6d/0x80
>  ? die+0x3c/0xa0
>  ? do_trap+0xcf/0xf0
>  ? do_error_trap+0x75/0xa0
>  ? usercopy_abort+0x72/0x90
>  ? exc_invalid_op+0x57/0x80
>  ? usercopy_abort+0x72/0x90
>  ? asm_exc_invalid_op+0x1f/0x30
>  ? usercopy_abort+0x72/0x90
>  ? usercopy_abort+0x72/0x90
>  __check_heap_object+0xd6/0x110
>  __check_object_size+0x28a/0x2f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  __x64_sys_sched_getaffinity+0xda/0x120
>  do_syscall_64+0x76/0x120
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_syscall_64+0x85/0x120
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? syscall_exit_to_user_mode+0x75/0x190
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_syscall_64+0x85/0x120
>  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> RIP: 0033:0x7fbc2c507d6a
> Code: d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 f0 be ff ff ff 7f b8 cc 00 00 00 49 39 f0 49 0f 46 f0 0f 05 <48> 3d 00 f0 ff ff 77 2e 41 89 c1 83 f8 ff 74 38 48 98 48 83 ec 08
> RSP: 002b:00007ffceab058d8 EFLAGS: 00000297 ORIG_RAX: 00000000000000cc
> RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007fbc2c507d6a
> RDX: 000055b26dfa3040 RSI: 0000000000000008 RDI: 0000000000000000
> RBP: 000055b26dfa3040 R08: 0000000000000008 R09: 00000000ffffffff
> R10: 000055b26dfa3030 R11: 0000000000000297 R12: 0000000000000008
> R13: 000000000000003c R14: 00007ffceab05ac8 R15: 000055b258445078
>  </TASK>
> Modules linked in: aesni_intel crypto_simd cryptd
> ---[ end trace 0000000000000000 ]---

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

