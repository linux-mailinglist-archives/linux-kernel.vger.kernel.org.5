Return-Path: <linux-kernel+bounces-164503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94268B7E57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0F281A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF7417F36D;
	Tue, 30 Apr 2024 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lHokgwk4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993117BB20
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497815; cv=none; b=Ek0fNTag0/7HWF2IIaQo0trStOIKjVEQsBmo7+617pxKPktobE4vSFU0//3LgXgGarvt0HHV3hJiHHR3L5kE7LTJKaZOmBx+t5Xvj08nyFYsBYZIGEBCI48zXBhXME8WCSNrDel6knljgdFRlQf2LCQHVvwO7/D9dqw5ORagshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497815; c=relaxed/simple;
	bh=iZh6nM38D/q5GYqv95TwuA9oy58X5NncQScPu9nxBVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKwwHwwY3ECUZds2fFN8PVNo2M7xtReLN3IAMLwVRtns+cCo7NGqgP3gOFCmLfC1iHHVThDecZYRKZ5+vp76uUmLz3ukt4mo4Ro2Ps6/KTX8KMXhMS6XoYZxDff44RMqm7blc9afs9IJnb3MOwbBrD1voEU4b79lslLMku+jtKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lHokgwk4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC29C40E01E8;
	Tue, 30 Apr 2024 17:23:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BQ6V5vVyBBtJ; Tue, 30 Apr 2024 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714497806; bh=rET8PMksvmbezGMLQaabxxRB/3qqHvwmR44sWT2IzuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHokgwk4LUJJr76y3fs0/igOoi5vU1bjyLp1wZEuriOgAchrA2y520oZCE7IHUxac
	 twAcSI1NrhHD8V1vZ00GA4gjPVtB8/+6v7hJMwvkBLW0EiHrsU+30oIH+YFXOvmFd/
	 v8fPaU/b9GxVxie8gK3D379QyR8L/4s1teMDCcSzZDyoTWWuo7xK2nKFFIlZUX6Xb8
	 xLPFtHFnPgosSCmXWG501qet9Cyk8tdRPqa5QhIOa7AwFTXUMbJa/+Innc3C6p5Tb0
	 vtC61890hQKE0tDKEHMKg83jIXqGE3buyTUDzc85x2MS31sC+/HqpOLtmEaQIv+cMv
	 ohW0hdx6MQOdP21ds0WWxkpmzdFsargiPu8TbZCylV+UcrN2UQDH8mCgb8UZr+OPe2
	 4f7Cdb1NaobXUREKpqykDHpp/vEVRImfCLOqwUpQd7W/LN7Ik2cvK0+HWtc/v9uIMw
	 xJBjrNimGVrQtlOpJDyZIYVVkT6UqAI67f4pVWUh4RYA3zJuPrFsuuyPwOvgSzhbVg
	 HZkpaS884y4oJoysDR5/HlQh5IGF+dO3aotaauKyK1Nt0t//pXTkGrFS/oQAmRQp3s
	 55kJmcDR0/pjNZyNHGtRHTbeSzkzq1qNiftc2IMnEtufGHuSDaSbxfKdQv553n5L/l
	 dNLNhxY+qQ1z7vLl9x4t3eyk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A63740E01A3;
	Tue, 30 Apr 2024 17:23:18 +0000 (UTC)
Date: Tue, 30 Apr 2024 19:23:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <oliver.sang@intel.com>,
	Sean Christopherson <seanjc@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202404302233.f27f91b2-oliver.sang@intel.com>

+ Sean.

On Tue, Apr 30, 2024 at 11:00:52PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap" on:
> 
> commit: ee8962082a4413dba1a1b3d3d23490c5221f3b8a ("x86/alternatives: Catch late X86_FEATURE modifiers")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/alternatives
> 
> [test failed on linux-next/master bb7a2467e6beef44a80a17d45ebf2931e7631083]
> 
> in testcase: lkvs
> version: lkvs-x86_64-b07d44a-1_20240401
> with following parameters:
> 
> 	test: xsave
> 
> 
> 
> compiler: gcc-13
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202404302233.f27f91b2-oliver.sang@intel.com
> 
> 
> [    0.055225][    T0] ------------[ cut here ]------------
> [ 0.055225][ T0] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:118 do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
> [    0.055225][    T0] Modules linked in:
> [    0.055225][    T0] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.9.0-rc3-00001-gee8962082a44 #1
> [    0.055225][    T0] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
> [ 0.055225][ T0] RIP: 0010:do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
> [ 0.055225][ T0] Code: 89 c1 83 e0 07 48 c1 e9 03 83 c0 03 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 b7 00 00 00 8b 15 f4 f7 7c 04 85 d2 0f 84 f2 fd ff ff <0f> 0b e9 eb fd ff ff 48 c7 c7 c0 eb 89 85 e8 41 fd ff ff 49 8d bf
> All code
> ========
>    0:	89 c1                	mov    %eax,%ecx
>    2:	83 e0 07             	and    $0x7,%eax
>    5:	48 c1 e9 03          	shr    $0x3,%rcx
>    9:	83 c0 03             	add    $0x3,%eax
>    c:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
>   10:	38 d0                	cmp    %dl,%al
>   12:	7c 08                	jl     0x1c
>   14:	84 d2                	test   %dl,%dl
>   16:	0f 85 b7 00 00 00    	jne    0xd3
>   1c:	8b 15 f4 f7 7c 04    	mov    0x47cf7f4(%rip),%edx        # 0x47cf816
>   22:	85 d2                	test   %edx,%edx
>   24:	0f 84 f2 fd ff ff    	je     0xfffffffffffffe1c
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	e9 eb fd ff ff       	jmpq   0xfffffffffffffe1c
>   31:	48 c7 c7 c0 eb 89 85 	mov    $0xffffffff8589ebc0,%rdi
>   38:	e8 41 fd ff ff       	callq  0xfffffffffffffd7e
>   3d:	49                   	rex.WB
>   3e:	8d                   	.byte 0x8d
>   3f:	bf                   	.byte 0xbf
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	e9 eb fd ff ff       	jmpq   0xfffffffffffffdf2
>    7:	48 c7 c7 c0 eb 89 85 	mov    $0xffffffff8589ebc0,%rdi
>    e:	e8 41 fd ff ff       	callq  0xfffffffffffffd54
>   13:	49                   	rex.WB
>   14:	8d                   	.byte 0x8d
>   15:	bf                   	.byte 0xbf
> [    0.055225][    T0] RSP: 0000:ffffc900001f7cd0 EFLAGS: 00010002
> [    0.055225][    T0] RAX: 0000000000000003 RBX: ffff888817ca9020 RCX: 1ffffffff0b13da3
> [    0.055225][    T0] RDX: 0000000000000001 RSI: 0000000000000085 RDI: ffffc900001f7d68
> [    0.055225][    T0] RBP: ffffc900001f7d08 R08: 0000000000000000 R09: fffffbfff0962288
> [    0.055225][    T0] R10: ffffffff84b11443 R11: 0000000000000001 R12: 0000000000000085
> [    0.055225][    T0] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8683dee0
> [    0.055225][    T0] FS:  0000000000000000(0000) GS:ffff888817c80000(0000) knlGS:0000000000000000
> [    0.055225][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.055225][    T0] CR2: 0000000000000000 CR3: 000000089c85a001 CR4: 00000000003706b0
> [    0.055225][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    0.055225][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    0.055225][    T0] Call Trace:
> [    0.055225][    T0]  <TASK>
> [ 0.055225][ T0] ? __warn (kernel/panic.c:694) 
> [ 0.055225][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
> [ 0.055225][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
> [ 0.055225][ T0] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1)) 
> [ 0.055225][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
> [ 0.055225][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> [ 0.055225][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
> [ 0.055225][ T0] ? __pfx_do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:109) 
> [ 0.055225][ T0] init_ia32_feat_ctl (arch/x86/kernel/cpu/feat_ctl.c:181)

Yap, works as designed:

..
                goto update_sgx;

        if ( (tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
            (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
                if (IS_ENABLED(CONFIG_KVM_INTEL))
                        pr_err_once("VMX (%s TXT) disabled by BIOS\n",
                                    tboot ? "inside" : "outside");
                clear_cpu_cap(c, X86_FEATURE_VMX);			<--- here
        } else {

Clearing feature flags after alternatives have been applied means that
code which does

	alternative(, ... X86_FEATURE_VMX, ...)

won't work as expected because the patching has already happened.

And I'm not sure even the dynamic testing *cpu_has() does will always
work as we do this dance in get_cpu_cap() with forced flags.

So, I'm thinking init_ia32_feat_ctl() should run in early_init_intel()
which is before alternatives.

And looking at init_ia32_feat_ctl(), all it does is set and clear
a bunch of bits so I think it should be ok.

Sean?

> [ 0.055225][ T0] init_intel (arch/x86/include/asm/msr.h:146 arch/x86/include/asm/msr.h:300 arch/x86/kernel/cpu/intel.c:583 arch/x86/kernel/cpu/intel.c:687) 
> [ 0.055225][ T0] identify_cpu (arch/x86/kernel/cpu/common.c:1824) 
> [ 0.055225][ T0] identify_secondary_cpu (arch/x86/kernel/cpu/common.c:1949) 
> [ 0.055225][ T0] smp_store_cpu_info (arch/x86/kernel/smpboot.c:333) 
> [ 0.055225][ T0] start_secondary (arch/x86/kernel/smpboot.c:197 arch/x86/kernel/smpboot.c:281) 
> [ 0.055225][ T0] ? __pfx_start_secondary (arch/x86/kernel/smpboot.c:231) 
> [ 0.055225][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
> [    0.055225][    T0]  </TASK>
> [    0.055225][    T0] ---[ end trace 0000000000000000 ]---
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240430/202404302233.f27f91b2-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

