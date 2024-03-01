Return-Path: <linux-kernel+bounces-89150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69E86EB27
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9072728948A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CEF58ACE;
	Fri,  1 Mar 2024 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbYHNsu+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7B58AC5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328570; cv=none; b=N0CNb4+jh14hCHXpgzOfvsBVzt7lg//GVxhiRe2tb+S8rBvDod92knDlp2Hp46ETCg+ukKovPzwnvzaHRd/buD5qRff1feL+LFtaUE9Y0zVg7LxqCct+nL4qGU5QOuVoQstdhc8u+JAICTcPBiuDr4EIDNnkJOzB/1UDahQTDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328570; c=relaxed/simple;
	bh=pxAnCgtXnHsOiMTW3ZMSzEI1GBVzSdFKM38ZllF+d08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ktz3OAywEu7cNgLk0udM+MHSKQIQkH5RceXor7u0XLcAntVXVyh1gKKdP48XuC5AHbd5B574RFfbf8x6qKAaBYfvEYUp32bV0hVQATXxhftAzsrvjqNcokyphd5D4ADoPubZoNQs1cko3L6CtTKcHO48fvkOTXG+OItKfdQaZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbYHNsu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A571C433A6;
	Fri,  1 Mar 2024 21:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328569;
	bh=pxAnCgtXnHsOiMTW3ZMSzEI1GBVzSdFKM38ZllF+d08=;
	h=Date:From:To:Cc:Subject:From;
	b=DbYHNsu+ctfLpiYryb1RGanZThfJbdxE1j5KabdlpXW4wrDyjrzxY/F8svvrk+E3D
	 Xk/094vdoylBEcKGmaEs5G+cNfQxkeuE3arwb8/zES7ridP73OwINsL3pmJW8FTxIb
	 /AKJiVvrTcroOS6bUrs7DU4J74014w5ldaKnJEYE5v9xUJkHoT6J0zbOKzHbSdGUHs
	 nlcOD+ggNbrxQWM/qM3cpwCCNL7M5hZ3xYdK4PnA4ThoPkZeqttKps7uIlgD7oZ+DJ
	 uv6qUrDvdw56J9z8F7dZCysvjBE5/zqnbyrCMRYTqd0KpMGmehaGfF7HZpIrhBK40Y
	 nQv5smliCeACw==
Date: Fri, 1 Mar 2024 21:29:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: x86 boot issues in -next
Message-ID: <05a45cc8-e0fc-422e-80d2-596ed63202a3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zv4FRpGtRGmXx0w6"
Content-Disposition: inline
X-Cookie: Schizophrenia beats being alone.


--Zv4FRpGtRGmXx0w6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

For the past few days -next has been failing to boot an x86_64 defconfig
on the x86 machine Linaro has available in their lab.  DMI says it's a
"Dell Inc. PowerEdge R200/0TY019, BIOS 1.4.3 05/15/2009" and the CPU is
described as "Intel(R) Xeon(R) CPU X3220  @ 2.40GHz (family: 0x6, model:
0xf, stepping: 0xb)", it's running happily with mainline and
pending-fixes.

The kernel crashes with:

[    2.012730] PCI: CLS 64 bytes, default 64
[    2.016743] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.023181] software IO TLB: mapped [mem 0x00000000cbeb2000-0x00000000cf=
eb2000] (64MB)
[    2.032236] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[    2.032914] #PF: supervisor read access in kernel mode
[    2.032914] #PF: error_code(0x0000) - not-present page
[    2.032914] PGD 0 P4D 0=20
[    2.032914] Oops: 0000 [#1] PREEMPT SMP PTI
[    2.032914] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc6-next-202=
40229 #1
[    2.032914] Hardware name: Dell Inc. PowerEdge R200/0TY019, BIOS 1.4.3 0=
5/15/2009
[    2.032914] RIP: 0010:exra_is_visible+0xf/0x20
[    2.032914] Code: b7 46 08 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d 1b f0 c9 01 01 7e 04 <0f=
> b7 46 08 c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[    2.032914] RSP: 0000:ffffac7cc001bdd0 EFLAGS: 00010202
[    2.032914] RAX: 0000000000000000 RBX: ffffffff90812ea0 RCX: ffffffff8ee=
0ef00
[    2.032914] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff97a6810=
64c00
[    2.032914] RBP: 0000000000000001 R08: 0000000000000228 R09: ffff97a6801=
27310
[    2.032914] R10: ffff97a68049ddd0 R11: 0000000000000000 R12: ffff97a6810=
64c00
[    2.032914] R13: ffffffff90812dc0 R14: 0000000000000001 R15: 00000000000=
00000
[    2.032914] FS:  0000000000000000(0000) GS:ffff97a7a7c00000(0000) knlGS:=
0000000000000000
[    2.032914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.032914] CR2: 0000000000000008 CR3: 00000000bf42e000 CR4: 00000000000=
006f0
[    2.032914] Call Trace:
[    2.032914]  <TASK>
[    2.032914]  ? __die+0x1e/0x60
[    2.032914]  ? page_fault_oops+0x17b/0x480
[    2.032914]  ? search_module_extables+0x14/0x50
[    2.032914]  ? exc_page_fault+0x6b/0x150
[    2.032914]  ? asm_exc_page_fault+0x26/0x30
[    2.032914]  ? __pfx_exra_is_visible+0x10/0x10
[    2.032914]  ? exra_is_visible+0xf/0x20
[    2.032914]  internal_create_group+0x9c/0x400
[    2.032914]  internal_create_groups+0x3d/0xa0
[    2.032914]  pmu_dev_alloc+0xbb/0xe0
[    2.032914]  perf_event_sysfs_init+0x51/0xa0

A full boot log for a sample failure can be seen at:

    https://validation.linaro.org/scheduler/job/4045256

I bisected this, the bisect seemed to run smoothly and landed on commit
f031242dbf22 ("Merge branch into tip/master: 'x86/apic'") with both
parents being fine (full log below) - an issue in the x86 tree does seem
plausible but I haven't investigated further.

git bisect start
# bad: [1870cdc0e8dee32e3c221704a2977898ba4c10e8] Add linux-next specific f=
iles for 20240301
git bisect bad 1870cdc0e8dee32e3c221704a2977898ba4c10e8
# good: [d1e87c1d8f90f27a1ca3c90d9de048602beabc61] Merge branch 'for-linux-=
next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
git bisect good d1e87c1d8f90f27a1ca3c90d9de048602beabc61
# good: [907d374fa897fbbcdce1e027297d933bbab025e1] Merge branch 'main' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 907d374fa897fbbcdce1e027297d933bbab025e1
# good: [c32a1272f32bf6189357816f510edf7411ecd0ba] Merge branch 'next-integ=
rity' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
git bisect good c32a1272f32bf6189357816f510edf7411ecd0ba
# bad: [2faf0484495c5288200f710966ec252fee2415a9] Merge branch 'next' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
git bisect bad 2faf0484495c5288200f710966ec252fee2415a9
# bad: [0fa7bf8bf39eff1d304d2d46c92d94131205036f] Merge branch 'master' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 0fa7bf8bf39eff1d304d2d46c92d94131205036f
# bad: [f031242dbf22fc9c850946253324c72611a8b253] Merge branch into tip/mas=
ter: 'x86/apic'
git bisect bad f031242dbf22fc9c850946253324c72611a8b253
# good: [f631c66c30faa6900e05aec06e7d0a541040dbde] Merge branch into tip/ma=
ster: 'irq/msi'
git bisect good f631c66c30faa6900e05aec06e7d0a541040dbde
# good: [7f204eefe00c7a6677fc1dd515a02eb8b9c57495] Merge branch into tip/ma=
ster: 'timers/core'
git bisect good 7f204eefe00c7a6677fc1dd515a02eb8b9c57495
# good: [c0a66c2847908e41c771ca2355fba935a82a9f62] x86/cpu/topology: Move r=
egistration out of APIC code
git bisect good c0a66c2847908e41c771ca2355fba935a82a9f62
# good: [882e0cff9ef340e7a47659a9aab9da64f4b9b847] x86/cpu/topology: Mop up=
 primary thread mask handling
git bisect good 882e0cff9ef340e7a47659a9aab9da64f4b9b847
# good: [6be4ec29685c216ebec61d35f56c3808092498aa] x86/apic: Build the x86 =
topology enumeration functions on UP APIC builds too
git bisect good 6be4ec29685c216ebec61d35f56c3808092498aa
# good: [9be3b2f057d7a6752e8cf25c1d456198b4d3bd6a] ptp/kvm, arm_arch_timer:=
 Set system_counterval_t.cs_id to constant
git bisect good 9be3b2f057d7a6752e8cf25c1d456198b4d3bd6a
# good: [27f6a9c87a97f5ea7459be08d5be231af6b32c20] kvmclock: Unexport kvmcl=
ock clocksource
git bisect good 27f6a9c87a97f5ea7459be08d5be231af6b32c20
# good: [9b9c280b9af2aa851d83e7d0b79f36a3d869d745] Merge branch 'x86/urgent=
' into x86/apic, to resolve conflicts
git bisect good 9b9c280b9af2aa851d83e7d0b79f36a3d869d745
# good: [670c000c11ec5c5131cdf502d062075a803214af] Merge branch into tip/ma=
ster: 'timers/ptp'
git bisect good 670c000c11ec5c5131cdf502d062075a803214af
# first bad commit: [f031242dbf22fc9c850946253324c72611a8b253] Merge branch=
 into tip/master: 'x86/apic'

--Zv4FRpGtRGmXx0w6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXiSLQACgkQJNaLcl1U
h9Bsdwf/eITSF+S/YeOWpFP+WYDHVs0RhkGJBR1MGlypfywJo4Gi4UhMEsIa8ue+
0L57ea4kILxQRR3hhMf+zjiTEGhbTHxUymnvMqes8dvtJKTN/x+GUH6Gd6XSlYJt
9NILkUIf/4xVj2d7cviyheEy/x+DaGXmMDYGcNYd9P18ke5J4DnCEnvEbQWuCed8
KyQ9CxjJDPJtNizkOJJEEprgUN1iVh/VYhm9LHXrv7sU9L3frlUCIAwtayScexkb
WPNGHpRKd8wF/AP/oLFYV2oZgdnxojhBrJmtFWoLEMyRUaYXoKS0chO/+xs8ArpD
D9AYptlVzHx9hzDtgS8SNNJfQiiSdQ==
=ibMi
-----END PGP SIGNATURE-----

--Zv4FRpGtRGmXx0w6--

