Return-Path: <linux-kernel+bounces-146815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F68A6B63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DDF1C2169D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD7B12BEA9;
	Tue, 16 Apr 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="xm6+sYKZ"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FAE12BF2B;
	Tue, 16 Apr 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271501; cv=none; b=R4HEgsGJnpjgcg7mPA8TyTPkK0IoBt89DZSZokLN4kav6v8gDXxERypVy9toLdhgv071xSfY5kt36qMHj7Oqe8v2SBICNDT8FeewoTkl19nHbiNU3yp1wVId/z0Z5bAzvcPkUzom6eeRXqnkJ+XNcDlnmV5HH8lFMsRdDJIIwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271501; c=relaxed/simple;
	bh=Fwc2h9mLFPQ+pMLkXlITsnc+BFgqwxI6MX8hljl7AQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RHBR/p7jcmmf11YI6ZvoQB/H1F5FMLEI3nouc1FOyip/sWmOveAoCi7pOk4fqb5ci94iZZqIVYcbwA0z9p+x6E0vKJgdYEbEmBFhVfz5ZTaU+T77UrSphayAzLME6Rylykh6XAfXWpx3qTTANInAAjzNoQxaqN8mtorOWnqv6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=xm6+sYKZ; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1713271496; x=1713876296; i=christian@heusel.eu;
	bh=IUD8Jjs8JYpUGxZJgs43b1N3UGc4tTFtGJp9VuOo2cI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=xm6+sYKZQbenkTaIQ1k/gRiaSEgLRRhou801Oq/rZi9hn4es7BrgOmXmJLbNwJRh
	 I1ycVhgTQNMNXqqhO92gFyw+5U+oO60tX/cVYqYWLQEee53bf6Yw1HAF0y8VzMqx8
	 P9hxEpTrbzCOrj4NCw5ANAvoBDK0aqkEPwtr87OYnfM56BVgnk9LA9of1asWFyapR
	 IXX2htYDWDTORdHf/L3GxhlWlQSg52+AGaBKrVnh8UNEfsfNHjWJ/Jhw7O1tu6Gnr
	 4F7aylzQQLVT7ZT/K1Kz+emauV7y2hs8cdfOj6wyOIdmH81qtQBe+UaOhx0ThkjJO
	 uGG5C15F8OcYeyh9jg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Msqpq-1slMSU1Xom-00tACu; Tue, 16
 Apr 2024 14:19:26 +0200
Date: Tue, 16 Apr 2024 14:19:24 +0200
From: Christian Heusel <christian@heusel.eu>
To: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: David Runge <dave@sleepmap.de>, 
	"Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>, regressions@lists.linux.dev
Subject: [REGRESSION] Null pointer dereference while shrinking zswap
Message-ID: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c77hs6q24bk2juqy"
Content-Disposition: inline
X-Provags-ID: V03:K1:4da/o3EIRrGjeM25Qy59Ppz83BR5JlO/HHAHd8xhis3qK90zcWs
 DSTJOGMlAsJvkY628cw9q1WdiGkIAxiQw41M2e5nRhpew3NpzBsGDfLsg5/+0oUUJwkBeET
 /BzSDfKdPcjynQfy46dg78gEURXDd35HYszT2dqzd1ip+KNkePY/Y+SiVIl2I26LQ+fyQS4
 39NcQWctB+HRDXIfIFs0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Evir/GG3jJw=;2DsGtnFEA+rceTSqQ8VxBPe5S0d
 j70Adx3Y5xEZFvYynM5mrzvEwo7AJNmLaV10ndmbqDatdlfy9VZp6RZXHJ0EUMwuBmNH4D+TA
 9BC79+AR2LQSQ6sSuF2UJINoX9rcNdaNtdYy/mjEOgUWAb3b1qPmVONDYyrBuDfSpSoMb5vHP
 bmmalX/mQhxF8Pldum1I9oby956vPR+qS6RqB9d4HQLgKbTG0xJF5JtMeo9+NXxUlcKZ4B9l0
 5ssUwxnGJvBNMFGyWQ6eJrPJpQsqLgEylTVWtWZn6zpkiKhF/mV20RP9xq+rOtHZc4yqdv6Rp
 s3OVORjAImsIXt6kdIQ/Bw0oHF1ixh+6qptbBdSlrwNqPJ1udlOHtqXzY5Tjn/xln2FxvUAIw
 cup6/MXOQpFf5V/Ms5Yu8nDs2J+dlkeBnfswEUFODIH4+c8d7LrZ2+2sfk8dbMYY43Iaguad/
 E8say2dJ0z7TE3o6+bcxCNyifbp5xLt9q/ljBaXDo5BwBZFkY/OgigFnKedDZE79nDax5kngf
 Rq5zqGnjOdTV7jqGKmxOkQztTYOUll1tt3K6iYEuRE82OYuKXTJ+vRyyW1JTSUG6Rdfu1DkPP
 rQYdRQqhdl+hwhgijmS7uv2yMrX2uQFPtdFKxHQ7v/JZXYdcIwJgzqCYCRxnsGe3/7kTEiVx5
 jaevBlwfATHt8Mq7robqpD2AV7wLS5+CvWT1CjmtR7yo8pk7lQcBT0vRa62q2xLmQ7k2paYxA
 Ft63qlWgS7muzqVM4S9kawGugAgI2IUsNH9oAk04LxcHRAPqWeE8Cw=


--c77hs6q24bk2juqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

while rebuilding a few packages in Arch Linux we have recently come
across a regression in the linux kernel which was made visible by a test
failure in libguestfs[0], where the booted kernel showed a Call Trace
like the following one:

[  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1-mainline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M
[  218.739007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.3-1-1 04/01/2014^M
[  218.739787] RIP: 0010:memcg_page_state+0x9/0x30^M
[  218.740299] Code: 0d b8 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 <48> 8b 87 00 06 00 00 48 63 f6 31 d2 48 8b 04 f0 48 85 c0 48 0f 48^M
[  218.740727] RSP: 0018:ffffb5fa808dfc10 EFLAGS: 00000202^M
[  218.740862] RAX: 0000000000000000 RBX: ffffb5fa808dfce0 RCX: 0000000000000002^M
[  218.741016] RDX: 0000000000000001 RSI: 0000000000000033 RDI: 0000000000000000^M
[  218.741168] RBP: 0000000000000000 R08: ffff976681ff8000 R09: 0000000000000000^M
[  218.741322] R10: 0000000000000001 R11: ffff9766833f9d00 R12: ffff9766ffffe780^M
[  218.742167] R13: 0000000000000000 R14: ffff976680cc1800 R15: ffff976682204d80^M
[  218.742376] FS:  00007f1479d9f540(0000) GS:ffff9766fbc00000(0000) knlGS:0000000000000000^M
[  218.742569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[  218.743256] CR2: 0000000000000600 CR3: 0000000103606000 CR4: 0000000000750ef0^M
[  218.743494] PKRU: 55555554^M
[  218.743593] Call Trace:^M
[  218.743733]  <TASK>^M
[  218.743847]  ? __die+0x23/0x70^M
[  218.743957]  ? page_fault_oops+0x171/0x4e0^M
[  218.744056]  ? free_unref_page+0xf6/0x180^M
[  218.744458]  ? exc_page_fault+0x7f/0x180^M
[  218.744551]  ? asm_exc_page_fault+0x26/0x30^M
[  218.744684]  ? memcg_page_state+0x9/0x30^M
[  218.744779]  zswap_shrinker_count+0x9d/0x110^M
[  218.744896]  do_shrink_slab+0x3a/0x360^M
[  218.744990]  shrink_slab+0xc7/0x3c0^M
[  218.745609]  drop_slab+0x85/0x140^M
[  218.745691]  drop_caches_sysctl_handler+0x7e/0xd0^M
[  218.745799]  proc_sys_call_handler+0x1c0/0x2e0^M
[  218.745912]  vfs_write+0x23d/0x400^M
[  218.745998]  ksys_write+0x6f/0xf0^M
[  218.746080]  do_syscall_64+0x64/0xe0^M
[  218.746169]  ? exit_to_user_mode_prepare+0x132/0x1f0^M
[  218.746873]  entry_SYSCALL_64_after_hwframe+0x6e/0x76^M

The regression is present in the mainline kernel and also was
independently reported to the redhat bugtracker[1].

I have bisected (see log[2]) the regression between v6.9-rc4 and v6.6
and have landed on the following results (removed unrelated test commit)
as remainders since some of the commits were not buildable for me:
- 7108cc3f765c ("mm: memcg: add per-memcg zswap writeback stat")
- a65b0e7607cc ("zswap: make shrinking memcg-aware")
- b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")

I have decided on good/bad commits with the relevant libguestfs tests,
but I think the reproducer in the redhat bugzilla is simpler (although I
only became aware of it during the bisection and therefore didn't test
it myself):

  LIBGUESTFS_MEMSIZE=4096 LIBGUESTFS_DEBUG=1 LIBGUESTFS_TRACE=1 make -C /build/libguestfs/src/libguestfs-1.52.0/tests -k check TESTS=c-api/tests

I hope I have included everything needed to debug this further, if there
is more to add I'm happy to provide more details!

Cheers,
Christian

[0]: https://github.com/libguestfs/libguestfs/issues/139
[1]: https://bugzilla.redhat.com/show_bug.cgi?id=2275252
[2]: https://gist.github.com/christian-heusel/d5095c36b72ae90871e27dfed32ddc46

--c77hs6q24bk2juqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmYebMwACgkQwEfU8yi1
JYW51g//crfDQssE4eRaxPjjjlY05pwC+XKztfeyE6M6H/LuPGJnUhQZ/SLwvHgX
4uTOdh+6kWr1ykVxIpdSMuPMEdWA78GAkDwapwhXu1Hy3PD7WruSlFrplzWW/uSb
Rfthb76x/jSAl8GTXfO/EeotVfw0FwvzfdeNxgOMTsSG3tEzAyfWs0WXUrfNQvnJ
5AvpfnrsJ5sv2BfSpiwZDTFX+awBrMBgrKD71hEgd9ln79BhZWm3768rLeeWSlOG
51u/vmw5Gia42i7r/ekdeH/P7Tw2Gftj1Ke7BMOmjiPiqQ05MvarN7KVUcmfVMny
PaouhwwEoYtlCgdd//zhmXRKYJL6I5lxfyOv32USYVK25E/jeAQi1aJVSXAnNgsU
lmHj4QirJ3jNgIWtwQyRjKLJPbV+Bw0IBXNXbExSCSLTYJb3UB91WUgeo2nrlULL
Y7aUcFlN0KkM7BuIggSUms16sbMMqMpTx7UELbyPZozA1ALEkq/H8vP3ljcFL9RP
v2YAKkihBfEh7UBnEZ9fHYp/s9kF0Nria8bxVCtgKPSWbqaaO01ow6M8JMfsObIV
QpDMWvcWGROftffBztc+BAFglkDPHKe4bIgV0D0V9nnx+AGktZ2MTBJETbKi1RqX
WKuZDDLTrJBCJxLF1bmlqn0ZuP1a81JgG71CE+8FC599RBGF64Q=
=Djhd
-----END PGP SIGNATURE-----

--c77hs6q24bk2juqy--

