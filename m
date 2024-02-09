Return-Path: <linux-kernel+bounces-59015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C367A84EFD5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D6288E06
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90A956B74;
	Fri,  9 Feb 2024 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pS6kbBZa"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B156B6C;
	Fri,  9 Feb 2024 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455226; cv=none; b=ItfIjpn8Gis0EbTDkVR7yToC/aophEksQgmxeIYfikT5QYSenxfXuYfmc+e++EZYdrCk2UHs32iRxd4JSZYsLMlJeFmTfRv121h/XxmesM3GE9XAh22tMUnpu/bGZz6H+a/4wY5DcsX0NQEjXwlsWvFIzzvkV+i9BvxZIASGfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455226; c=relaxed/simple;
	bh=aO7a1MtLTm/+G5RHnZp+yc9I1B+xUuzNZB+DJOKkcgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MgZcK+WaosUpG1axAl9kYL26SDzgEWN8Sc6UKJ2DIEyrZHkTYgB3weWpplPb2BNtPlmYi4Sd5zcYSrQ9gZdswsO1xS/LsWGbPrZq6ts1/RJUN51W/HLLqh3ebf6cuhr76DJ0OCp/KATCyamf3n1T480LO/rPD/Us9kFuO8gSEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pS6kbBZa; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707455217;
	bh=EJlvcOxUW9ur/kZ60Z9zEPUQXIamDEP1ReVFJZqCWHo=;
	h=Date:From:To:Cc:Subject:From;
	b=pS6kbBZapVeSVPFi0eE6AzNKuYZVmNKl5iFzvFGTZ7CYPMzz1/yjQ8Yx130YvCwlt
	 cGDM53kBV8oPdridtuoRqBpC29NJVmNteTtEnio66ZQhyWfaIz4k/yq3DaMcNvkqGZ
	 kBJC7a4/FzXeGRhVNVT0rZO215oFgM59pwuDbUd2ES4yx5lRkyZiMTUsENxWXb2gxy
	 Q+Ikc7uwuwEzgwGZJdUUDquGYV0gxrE6K43WyMwhpL/eDzFWHStFyM5lKELdHAtkGx
	 gxQQfenlX4Y++tqGWZLSvz4WHfPf2dy/7byLC9miwS/tV2IHV8GA6ovdv87C7hRqnc
	 z1bXXe7kd0fhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TWMKD63Xxz4wys;
	Fri,  9 Feb 2024 16:06:56 +1100 (AEDT)
Date: Fri, 9 Feb 2024 16:06:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourav Panda <souravpanda@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: boot failure after merge of the mm tree
Message-ID: <20240209160654.498f39b5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tiozr0emFyu5ajXK1ul1jC7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Tiozr0emFyu5ajXK1ul1jC7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next boot (powerpc
pseries_le_defconfig) failed like this:

numa:   NODE_DATA [mem 0x7ffd8800-0x7ffdffff]
BUG: Kernel NULL pointer dereference at 0x00000030
Faulting instruction address: 0xc00000000045322c
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-rc3-05899-ga19e02faed6b #1
Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf0000=
04 of:SLOF,HEAD pSeries
NIP:  c00000000045322c LR: c00000000045332c CTR: c0000000000e72c0
REGS: c00000000292f8e0 TRAP: 0380   Not tainted  (6.8.0-rc3-05899-ga19e02fa=
ed6b)
MSR:  8000000000001033 <SF,ME,IR,DR,RI,LE>  CR: 48004888  XER: 20000000
CFAR: c000000000453328 IRQMASK: 1=20
GPR00: c0000000011d4688 c00000000292fb80 c0000000015c9900 c00000007ffd8800=
=20
GPR04: 000000000000002f 0000000000000001 40066bdea7000015 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000030 0000000000000030 0000000000004000=
=20
GPR12: c00000000292f968 c000000002b60000 0000000080000000 0000000000000004=
=20
GPR16: 0000000000000004 0000000000000060 0000000000000002 00000000017d2358=
=20
GPR20: 0000000000000000 0000000000000000 0000000008000000 c00c000000004000=
=20
GPR24: 0000000000000000 c0000000029d0260 0000000000000000 0000000000000000=
=20
GPR28: c00c000000000000 0000000000000000 0000000000004000 0000000000000001=
=20
NIP [c00000000045322c] __mod_node_page_state+0x30/0x100
LR [c00000000045332c] mod_node_page_state+0x30/0x50
Call Trace:
[c00000000292fb80] [c00c000000000000] 0xc00c000000000000 (unreliable)
[c00000000292fbb0] [c0000000011d4688] __populate_section_memmap+0x10c/0x1b4
[c00000000292fc20] [c000000002060e20] sparse_init_nid+0x210/0x7e0
[c00000000292fcf0] [c0000000020618d4] sparse_init+0x3c4/0x5f0
[c00000000292fdc0] [c00000000202185c] initmem_init+0x1d4/0x278
[c00000000292fea0] [c00000000200d774] setup_arch+0x4fc/0x618
[c00000000292ff30] [c000000002004ee0] start_kernel+0x9c/0x8cc
[c00000000292ffe0] [c00000000000e99c] start_here_common+0x1c/0x20
Code: 3c4c0117 38426704 60000000 60000000 e9037600 3924fffb 28090001 394800=
01 7d4a2214 40810040 e8ed0030 7d495378 <7d2748ae> 7d0740ae 7d290774 7d08077=
4=20
---[ end trace 0000000000000000 ]---

Kernel panic - not syncing: Attempted to kill the idle task!

Bisected to commit

  a1a91b2f3883 ("mm: report per-page metadata information")

=46rom the mm-unstable branch of the mm tree.

I reverted that commit for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/Tiozr0emFyu5ajXK1ul1jC7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXFsu4ACgkQAVBC80lX
0GwfFgf/eAVD2x3Jbmy7Fb5XYnE7N6MMQ4yFgynJkNewpQkgVWh1ZhyBh828dTDV
Nd4SJn2Aau604NeRx9X79mh2vclhyISbV9gMXfNK0T+qqUsw6pg+0DgxxGlSKH9a
EPF2XWW/2eYctmabD700fLlmUGy/0YkWzUEHu1EHg/Pwbd05GRvi5tH6IMi5hIZv
EM2fPY5DwbdZAsJPI7MMcPq6NJLGbw+q7QJNEbXKg35Y59SKwj+jFjGuirB2FyrR
cgCy9ubGvjSDX6VsCKlmW1DQqU+uVQ6i1NpMs6d1jWNeMb/Sr00eedCmBDjrVyz2
Dll0lujAwNd269fmE47KU9Jk8/V/Lg==
=bD+j
-----END PGP SIGNATURE-----

--Sig_/Tiozr0emFyu5ajXK1ul1jC7--

