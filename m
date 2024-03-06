Return-Path: <linux-kernel+bounces-93714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1798733B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2381C2354F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE635F852;
	Wed,  6 Mar 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b="OWTTWrHX"
Received: from secondary.pambor.com (secondary.pambor.com [46.38.233.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B71B26E;
	Wed,  6 Mar 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.233.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719859; cv=none; b=IopDxOMjj3SrqglCEnOlqQNHCwfGe6aBkDeGCVft4zABj8MkBcE5pggVBCehZ6tlopiK5yu0H8w3kmzCJpsXZ+eKocoqHa4Fh64LDqNymbh9+CjIQKssqZUY36lWYW7p0SQPIZnDt0x/l3t8vY2uEnYknzuADSx7LN5cTuIo/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719859; c=relaxed/simple;
	bh=vrOYkrsS6W6vE1uoyWq3OsouZ9CbANC70PCMfCEziqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwbkAguAMtYsE/F7e0JUrrGgc9YND3x/IVWnM5INbvRC9hKePFHI4TRKk+K0qfnTM1abfF4aGROxH2IEJrLVHFU7+SVT1POpHD4mjefWKQIQ0uaXswoQLQrzpJ5pdthdLymn1D99jq8i9Pu++82CX+6dN1iblc14kfeUnxMXcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de; spf=pass smtp.mailfrom=osasysteme.de; dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b=OWTTWrHX; arc=none smtp.client-ip=46.38.233.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osasysteme.de
Received: from localhost (localhost [127.0.0.1])
	by secondary.pambor.com (Postfix) with ESMTP id E185F6F03C0;
	Wed,  6 Mar 2024 11:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osasysteme.de;
	s=19022017; t=1709719851;
	bh=vrOYkrsS6W6vE1uoyWq3OsouZ9CbANC70PCMfCEziqE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OWTTWrHXtvvBv1YtPlVxgPln2YaKpFfidNowlMvjWELZjtWM/QlhoPwjTbj/0MF8u
	 0Kw/HptwajsV3eFv+DL2wysSS+5gOzp9JHOkmeGeyKsYVES7Mcyy90oel++xMI7Og4
	 fBUUsYtHJRYOzaAVDKkEVONNzJOffgyKUmc0HE/2Nhf9CsDIKV3JsLAUFtM6JOFjS8
	 pCmN3ygESO98e1vFHs0Wvz1r43JHcVqrkhZyyDBkOrgt2EOk0QLhSRbG4fmj5W0ArF
	 Sh6B5yNKeThhG+C+zgfcdvbLO+R3TsGyaU3nV8xsUS82r9ejHS9FtzNflEiwNFKFrr
	 unBC4I3ArKrwQ==
X-Virus-Scanned: Debian amavisd-new at secondary.pambor.com
Received: from secondary.pambor.com ([127.0.0.1])
	by localhost (secondary.pambor.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fcpgnfepDuAT; Wed,  6 Mar 2024 11:10:48 +0100 (CET)
Received: from chromebook.fritz.box (dynamic-2a01-0c22-d0b2-fe00-bf90-7234-7f03-3ec4.c22.pool.telefonica.de [IPv6:2a01:c22:d0b2:fe00:bf90:7234:7f03:3ec4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.osasysteme.de (Postfix) with ESMTPSA id 8323E6EFAB8;
	Wed,  6 Mar 2024 11:10:48 +0100 (CET)
Message-ID: <db77fa78e75b9712ebba1dfd7e4340603cae4fe3.camel@osasysteme.de>
Subject: Re: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache
 information
From: Tim Pambor <tp@osasysteme.de>
To: Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven
	 <geert+renesas@glider.be>
Cc: Dragan Simic <dsimic@manjaro.org>, AnandMoon <linux.amoon@gmail.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Wed, 06 Mar 2024 11:10:51 +0100
In-Reply-To: <TYCPR01MB112696A947F31C31FE3A3AFF586212@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240305151336.144707-1-tp@osasysteme.de>
	 <TYCPR01MB112696A947F31C31FE3A3AFF586212@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Biju,

thanks for the review.

> Hi Tim Pambor,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: Tim Pambor <tp@osasysteme.de>
> > Sent: Tuesday, March 5, 2024 3:14 PM
> > Subject: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache
> > information
> >=20
> > Based on ARM Cortex-A55 TRM and RZG2/L user's manual, each Cortex-
> > A55 has
>=20
> RZ/G2L
>=20
> > - 32 KB of L1 4-way, set-associative instruction cache
> > - 32 KB of L1 4-way, set-associative data cache
> >=20
> > Each cache has a cache line length of 64B and therefore there are
> > 32768B/(4 * 64B)=3D128 sets for each cache.
> >=20
> > RZG2/L are not configured with the optional per-core L2 cache but
> > only have a L3 cache shared among all
> RZ/G2L
> > cores. In this case, the L3 cache appears as a L2 cache to the
> > system. Therefore, specify "cache-level
> > =3D <2>" for the L3 cache.
>=20

I will send a v2 with the commit message corrected.

> You mean for L3 Cache, cache-level =3D <2> if there is no L2 Cache on
> the system? Does it need any update
> on dt-bindings to make this clear?

I followed the approach chosen for the Rockchip RK356x, which also has
a Cortex-A55 with an L3 cache but no L2 cache [1]. I can add a comment
to the device tree explaining that there is no L2 cache and that
therefore the L3 cache appears as a L2 cache to the system. Do you
consider that sufficient?


Currently, having cache-level =3D <3> also causes a out-of-bounds access
in populate_cache_leaves.

[    0.066217] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.066369] BUG: KASAN: slab-out-of-bounds in populate_cache_leaves+0x25=
c/0x2d0
[    0.066495] Write of size 4 at addr ffff0000082370dc by task swapper/0/1
[    0.066580]=20
[    0.066619] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-00016-g3=
0d5a685c65d #6
[    0.066719] Hardware name: MYC-YG2LX (DT)
[    0.066793] Call trace:
[    0.066836]  dump_backtrace+0x98/0x118
[    0.066900]  show_stack+0x18/0x24
[    0.066959]  dump_stack_lvl+0x60/0xac
[    0.067029]  print_report+0xf8/0x5d8
[    0.067096]  kasan_report+0xc0/0x100
[    0.067159]  __asan_report_store4_noabort+0x20/0x2c
[    0.067235]  populate_cache_leaves+0x25c/0x2d0
[    0.067308]  detect_cache_attributes+0x34c/0x1998
[    0.067384]  update_siblings_masks+0x30/0x554
[    0.067460]  store_cpu_topology+0xe8/0x188
[    0.067528]  smp_prepare_cpus+0x5c/0x238
[    0.067602]  kernel_init_freeable+0x258/0xb18
[    0.067673]  kernel_init+0x30/0x208
[    0.067736]  ret_from_fork+0x10/0x20
[    0.067802]=20
[    0.067835] Allocated by task 1:
[    0.067889]  kasan_save_stack+0x3c/0x64
[    0.067956]  kasan_save_track+0x20/0x3c
[    0.068020]  kasan_save_alloc_info+0x68/0x78
[    0.068090]  __kasan_kmalloc+0xd4/0xd8
[    0.068154]  __kmalloc+0x1c0/0x430
[    0.068215]  allocate_cache_info+0xa8/0x204
[    0.068284]  fetch_cache_info+0xc4/0x200
[    0.068349]  init_cpu_topology+0x348/0x45c
[    0.068423]  smp_prepare_cpus+0x1c/0x238
[    0.068492]  kernel_init_freeable+0x258/0xb18
[    0.068561]  kernel_init+0x30/0x208
[    0.068622]  ret_from_fork+0x10/0x20
[    0.068685]=20
[    0.068719] The buggy address belongs to the object at ffff000008237000
[    0.068719]  which belongs to the cache kmalloc-256 of size 256
[    0.068849] The buggy address is located 4 bytes to the right of
[    0.068849]  allocated 216-byte region [ffff000008237000, ffff0000082370=
d8)
[    0.068984]=20
[    0.069018] The buggy address belongs to the physical page:
[    0.069089] page:(____ptrval____) refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x48236
[    0.069201] head:(____ptrval____) order:1 entire_mapcount:0 nr_pages_map=
ped:0 pincount:0
[    0.069297] flags: 0x840(slab|head|zone=3D0)
[    0.069366] page_type: 0xffffffff()
[    0.069430] raw: 0000000000000840 ffff000008001b40 dead000000000122 0000=
000000000000
[    0.069526] raw: 0000000000000000 0000000080100010 00000001ffffffff 0000=
000000000000
[    0.069616] page dumped because: kasan: bad access detected
[    0.069684]=20
[    0.069717] Memory state around the buggy address:
[    0.069781]  ffff000008236f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[    0.069870]  ffff000008237000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[    0.069958] >ffff000008237080: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc=
 fc fc
[    0.070042]                                                     ^
[    0.070116]  ffff000008237100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[    0.070204]  ffff000008237180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[    0.070290] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[1] https://lore.kernel.org/linux-rockchip/2285ee41e165813011220f9469e28697=
923aa6e0.1709491108.git.dsimic@manjaro.org/

>=20
> Cheers,
> Biju
>=20

