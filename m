Return-Path: <linux-kernel+bounces-101111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 136B987A28B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772E4B21AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AB125C0;
	Wed, 13 Mar 2024 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGiJZ01g"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB01118C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710306145; cv=none; b=asxuYYnDAHKCoU+tf1wfebRTM0zV2WuFFWb2a/KwHfDU26yXxKFdT1BVBpoDHuRa6ltavkQ0cmg91dnP/G3MJDPoeXWnnTjdkDcqF5r7BELr+pp+uWXsOhANP4yyYiy5xFrA3eUypxtJ3jEFqblu8MF6HH3ZbrikCRbiesVzZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710306145; c=relaxed/simple;
	bh=Yyb/edDixJ6PMI8pB18ALJwd6RVWi/D0e39Drrg2AVY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UTxBLm1m6/U7NVvVqK1NRGno/vUSvAMHfVPVJ7bNFUyC9Iv82xlEgzspWG1BC7sLXGckn/E+/slmcBjuBhhP3fdllaiCfSShCR92/qt9qbQ4RyDoRScPn4/DfVXLMrJJD/hfP7bhy0acmSo+cLRDapp4XAJkwU6KzjpcP2mMFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGiJZ01g; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45cdb790dfso643284866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710306141; x=1710910941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U/UCU3z3uHjS/4SxsGXetsT+b+wK6XSk4tn/jZHKGdI=;
        b=EGiJZ01gL9VvvW4lIv0+wzTvFIxzO5+tIVC+8ygj2PIJI9NBWkGH5KoW94BvVT2vy7
         e9bD2HFBM4/vGzjftM5X6z0N+poqP2p0DIgyid4vkQp+Mpl4JVeTmwvNYVGi+qvx3tDY
         8jlBZay2iaX59HO1z92cN9jta3yJIj1PnpTBsngmq5jywGsrOM9ouvq5UdYxYsVK34u9
         GyDXM9Sfb+AD2SZjzyg9FDCZb+6D+OLHpGKsW44pAPOyA9ud+yl03W4yXsyWxB7pvgWS
         RAVcjj1PUoZSku+T9dPsFMPhEhHsFWVMX9Cu8i4NQVbg6wgc3gpXB7NCfmt47m/UdhBO
         rj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710306141; x=1710910941;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/UCU3z3uHjS/4SxsGXetsT+b+wK6XSk4tn/jZHKGdI=;
        b=k1iEGLccsGxqey+zEKEOVaozJizf4kH0AMYZMFMRwQCKyPzZ6gzqZlMKuTT6i1Tc5h
         yezwaq+dRsjmwiTaGisC8amqhx9qVlnWNoYoD8e/BeymaLVtbXYmxsQBqFNGcxTBqyou
         Xc3Jt2WV7MeHd/2AMp3OY1iWwHco22Z17xVGYmlMVVPkRWk032gG169+L66U2sHMgvCg
         hE6GHgxOSRGb6VDJlJXsm45JcfVULMRZr5wGNrco1nKYWlEL0Gr3u1i4dTJLQDzlADey
         byh45I3P4pajP1JxNnEu2HQZnhWA7bkTZayOS4kN6Nh1Yv4vDC+ZraN2uH9JLkeSA/q2
         Apfg==
X-Forwarded-Encrypted: i=1; AJvYcCWnjpBG9Rg7o0amCB7msiZJCNXE8GYN1ctzOVpZx3opc31Q2shslphRRDfyyTyQUlblIKt+EoXc6bKcNpKR1TKPaq9XaGz1xopV35lQ
X-Gm-Message-State: AOJu0YxIV4tTlkGGGyFPY+kFMOWK6/fd6GhX5ZgmmVjzbt0xOaPuyzWr
	wiafZkFIjer+vm4ZaVb/kdw6eIv9kz4IGre6z9K9LyIWfrxoQ7JHJcBKmFuzs8/A+K0sgzoCJv7
	izgfHyvQLHy0i0ouUoPIdG2Mw14pW5OXWMN9Y1UPv
X-Google-Smtp-Source: AGHT+IH0f77rsKWcWXL6LyXAUnlPY4IAfe37Ht+tLpYcWCEuJtRKAqOQ1BbEZaKmtiebZvMmUNt9oLbU/8Q1BxjBqiM=
X-Received: by 2002:a17:907:3594:b0:a43:f182:66c4 with SMTP id
 ao20-20020a170907359400b00a43f18266c4mr6993857ejc.17.1710306141588; Tue, 12
 Mar 2024 22:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Wed, 13 Mar 2024 13:02:10 +0800
Message-ID: <CAKHoSAurcujiErjTeWM+ZGkSVVOj3zQu2ED5rZsSLq-+FXb1qQ@mail.gmail.com>
Subject: WARNING in kvm_age_gfn
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Syzkaller to fuzz the latest Linux Kernel arm64 version,
the following crash

was triggered on:

HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)

git tree: upstream

console output: https://pastebin.com/raw/3NCyqPUn

kernel config: https://pastebin.com/raw/mXEg4abU

C reproducer: https://pastebin.com/raw/N0gEqk5x

Syzlang reproducer: https://pastebin.com/raw/mJKwrP6m


If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

WARNING: CPU: 0 PID: 711 at arch/arm64/kvm/mmu.c:1592
kvm_age_gfn+0x64/0xdc
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kvm/mmu.c:1592
Modules linked in:
CPU: 0 PID: 711 Comm: syz-executor.0 Not tainted 6.1.61 #3
Hardware name: linux,dummy-virt (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvm_age_gfn+0x64/0xdc
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kvm/mmu.c:1592
lr : kvm_age_gfn+0x64/0xdc
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kvm/mmu.c:1592
sp : ffff80000a153350
x29: ffff80000a153350 x28: 0000000000000030 x27: ffffffffffffffe0
x26: 0000000000000fff x25: ffff3f0640df85a0 x24: 0000000000000000
x23: 0000000000000000 x22: ffff3f064205aa00 x21: ffff3f0640df8000
x20: ffff80000a153410 x19: 0000000000002000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000028
x14: 00000000000048c9 x13: 0000000000000005 x12: 0000000000000003
x11: 0000000000000000 x10: fffffffffffcbda8 x9 : ffffd1a886f24000
x8 : 0000000042b8808b x7 : 0000000000000053 x6 : 00000000000014f2
x5 : ffffd1a8859b7000 x4 : ffffd1a883a72ec8 x3 : ffffd1a883a00000
x2 : 0000000000000000 x1 : ffff3f0642374c80 x0 : 0000000000000000
Call trace:
 kvm_age_gfn+0x64/0xdc
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kvm/mmu.c:1592
 __kvm_handle_hva_range
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kvm/../../../virt/kvm/kvm_main.c:635
[inline]
 kvm_handle_hva_range
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kvm/../../../virt/kvm/kvm_main.c:672
[inline]
 kvm_mmu_notifier_clear_flush_young+0x11c/0x300
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kvm/../../../virt/kvm/kvm_main.c:870
 __mmu_notifier_clear_flush_young+0xa0/0x110
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/mmu_notifier.c:377
 mmu_notifier_clear_flush_young
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/./include/linux/mmu_notifier.h:423
[inline]
 folio_referenced_one+0x334/0x3e4
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/rmap.c:846
 rmap_walk_anon+0x1e0/0x3cc
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/rmap.c:2451
 rmap_walk data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/rmap.c:2527
[inline]
 rmap_walk data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/rmap.c:2522
[inline]
 folio_referenced+0x1b4/0x270
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/rmap.c:933
 folio_check_references
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/vmscan.c:1456
[inline]
 shrink_folio_list+0x720/0x108c
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/vmscan.c:1789
 reclaim_folio_list+0x94/0x194
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/vmscan.c:2688
 reclaim_pages+0x128/0x1c0
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/vmscan.c:2724
 madvise_cold_or_pageout_pte_range+0x5d8/0xc90
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:403
 walk_pmd_range
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/pagewalk.c:128
[inline]
 walk_pud_range
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/pagewalk.c:205
[inline]
 walk_p4d_range
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/pagewalk.c:240
[inline]
 walk_pgd_range+0x4c0/0x734
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/pagewalk.c:277
 __walk_page_range+0x1c8/0x1d0
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/pagewalk.c:379
 walk_page_range+0x1cc/0x240
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/pagewalk.c:477
 madvise_pageout_page_range
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:552
[inline]
 madvise_pageout+0x120/0x2f0
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:589
 madvise_vma_behavior
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:1021
[inline]
 madvise_walk_vmas
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:1250
[inline]
 do_madvise+0x698/0x1310
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:1429
 __do_sys_madvise
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:1442
[inline]
 __se_sys_madvise
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:1440
[inline]
 __arm64_sys_madvise+0x2c/0x40
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/mm/madvise.c:1440
 __invoke_syscall
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/syscall.c:38
[inline]
 invoke_syscall+0x5c/0x164
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x6c/0x15c
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x4c/0x100
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/syscall.c:206
 el0_svc+0x48/0xc0
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0xf4/0x120
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x18c/0x190
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/entry.S:585
irq event stamp: 1994
hardirqs last  enabled at (1993): [<ffffd1a884ff0538>]
__exit_to_kernel_mode
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/entry-common.c:84
[inline]
hardirqs last  enabled at (1993): [<ffffd1a884ff0538>]
exit_to_kernel_mode+0x38/0x140
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (1994): [<ffffd1a884fefd14>]
el1_dbg+0x24/0x90
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (1962): [<ffffd1a883a178cc>]
__put_cpu_fpsimd_context
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/fpsimd.c:260
[inline]
softirqs last  enabled at (1962): [<ffffd1a883a178cc>]
put_cpu_fpsimd_context+0x2c/0x74
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/fpsimd.c:272
softirqs last disabled at (1960): [<ffffd1a883a17834>]
get_cpu_fpsimd_context+0x0/0x6c
data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kernel/fpsimd.c:261

