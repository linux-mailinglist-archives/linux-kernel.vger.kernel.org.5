Return-Path: <linux-kernel+bounces-16691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82BE824280
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927B22878B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62822330;
	Thu,  4 Jan 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rj+iS860"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C532230C;
	Thu,  4 Jan 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 25D9740E0177;
	Thu,  4 Jan 2024 13:12:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w3--VQFIp462; Thu,  4 Jan 2024 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704373944; bh=qQuqXJZL7aDM3EdHFv033v3MUj6t+i7wMVqmM1OonM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rj+iS860nEcddAPwD0TQAFDwf+sq6ZVMSL3z+bjEp8oD6qqxyxKvHLcJoDtIo+R9w
	 ajm1JTz0Y9tw3zSmnUByOdxKKde9ZZ8Ai6uLrDawZkkgi8byVqUuta9fujR+8aPofz
	 HyaycQOHJUzFnrHe0UlwO91f+3lVdBjXkLWxe8YoOCtEOsLSNL2idX8fdDixOsxT5l
	 o2kmrAe8OBKA3mFOhCwZikz/rd1OGN8/QCiWEBlk5oVS7s9ovyCAL7s4IuZNN09Gp6
	 J46Z2AEC+9VaR5f+rrQ+aqsu0OqHpOJ05TDE6HYSuDykDPH41yzrOYft/OTN2BnElt
	 sXrf7o0qQttF7lCbCkiYkVBeiZaR8nChgTnLXsshl0oveoifZhmq4zoeUOHN/HvR5m
	 MAhIw58w6d5nT5LvFPao9C+bgxisLYNFhYzbuUn21tihcjzxr3NJ9ZELlVrrAErQcO
	 i76w4mUTH5VINlPDsBzGW8mLKD267+1PVmLTskJyZdMzP/Z2u67TB1qD+9rq4gGUu9
	 OVtlLqkxdQhTbIXksF6JwkyqpcGSfk6dycNSfydgadlOhQWb0z3lML2VxNTDchUnkY
	 u2DFX+7TJaWHJg2LRvjAbRCmmVQlTONviMHiNp6j3jBrT+LlLpphkZzyHcWRjSw6CH
	 C2lIqGk+jQk4WzfABD2sbwZU=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C768E40E00C5;
	Thu,  4 Jan 2024 13:12:16 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:12:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
References: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
 <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>

On Wed, Jan 03, 2024 at 07:46:56PM +0100, Borislav Petkov wrote:
> If only I can remember now how we did trigger the warning in the first
> place in order to test it...

Ok, got tired of trying to make it use the default thunk - it seems
kinda hard to do - which is good - or I simply can't think of a good way
to trigger it.

So I went and replaced the jump to the actual thunk:

Dump of assembler code for function default_idle_call:
   0xffffffff8197bda0 <+0>:     nopw   (%rax)
   0xffffffff8197bda4 <+4>:     nop
   ...
   0xffffffff8197bdda <+58>:    xchg   %ax,%ax
   0xffffffff8197bddc <+60>:    sti
   0xffffffff8197bddd <+61>:    nop
   0xffffffff8197bdde <+62>:    jmp    0xffffffff81988420 <srso_return_thunk>

to what it is at build time. I.e., what should *not* happen after
patch_returns() as run:

Dump of assembler code for function default_idle_call:
   0xffffffff8197bda0 <+0>:     nopw   (%rax)
   0xffffffff8197bda4 <+4>:     nop
   ...
   0xffffffff8197bdda <+58>:    xchg   %ax,%ax
   0xffffffff8197bddc <+60>:    sti
   0xffffffff8197bddd <+61>:    nop
   0xffffffff8197bdde <+62>:    jmp    0xffffffff819884a0 <__x86_return_thunk>

and yap, it fires as expected:

[  209.051694] **********************************************************
[  209.053200] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[  209.054435] **                                                      **
[  209.055687] **   unpatched return thunk in use. This should not     **
[  209.056911] **   on a production kernel. Please report this to      **
[  209.058133] **   x86@kernel.org.                                    **
[  209.059367] **                                                      **
[  209.060587] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[  209.061808] **********************************************************
[  209.063064] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.7.0-rc8+ #15
[  209.064527] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  209.066086] Call Trace:
[  209.066569]  <TASK>
[  209.066975]  dump_stack_lvl+0x36/0x50
[  209.067675]  warn_thunk_thunk+0x1a/0x30
[  209.068405]  do_idle+0x1a5/0x1e0
[  209.069403]  cpu_startup_entry+0x29/0x30
[  209.070147]  rest_init+0xc5/0xd0
[  209.070775]  arch_call_rest_init+0xe/0x20
[  209.071537]  start_kernel+0x425/0x680
[  209.072235]  ? set_init_arg+0x80/0x80
[  209.072931]  x86_64_start_reservations+0x18/0x30
[  209.073803]  x86_64_start_kernel+0xb7/0xc0
[  209.074590]  secondary_startup_64_no_verify+0x175/0x17b
[  209.075584]  </TASK>

Lemme write a proper patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

