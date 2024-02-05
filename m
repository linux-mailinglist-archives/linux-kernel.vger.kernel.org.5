Return-Path: <linux-kernel+bounces-52042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A3284933E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8221F22890
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4273B641;
	Mon,  5 Feb 2024 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vlu0xU7T"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B5B653;
	Mon,  5 Feb 2024 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110120; cv=none; b=TtM+GnQ+GZY2KWRQRhFOCd8yH3Bno1e1nETYz41N27KTTWkylpiELT72NOCNFKlNzxbLAcdgZjn3X7jnCTHvt97MYfygMwx4//GO9HryG3G016wsnSPOadtHZNcc5Z9+kL6B6Azm8fUwbrbotsXXUqeIu28ko51inbB2keHuJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110120; c=relaxed/simple;
	bh=4cshe81c+c4KPXrh4GlD0OY8vPrb9Ydb6nlH4wB5nG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KbJZbgOwehEsz2WJBqkEiX1jU9t8YCSJxJcdk+UDyguJ0OIID7bqEjzUExW/C6q9ew/ghVwZXG0YAKK3H+2lEGRBoXKhKcpqV3nfHui81CHpRmNpTFFj0RUky8zI9jlUcOOdM66rSdozYW8IFxNWnU2YQvZpootA63xWlgPOZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Vlu0xU7T; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707110116;
	bh=SE6rKr345tSTzjzjAAbedmFAtcE9ciFufYS0S09BJ+w=;
	h=Date:From:To:Cc:Subject:From;
	b=Vlu0xU7TE6V7Mfd4qBJY0r0BFAHfl4mUg2qtT9dKp/BxUCmP8+/GiDCnU/mBATkRM
	 /FGrkZtaevMi65o0dTF6QjIFVWayxLlJZXrrSdTpM+LQGLTaVYU9wtbzkfxUJm2Y4/
	 51gl3SCJ8Kx5OFaGyBFsSVJSWRPreR7zxq+rFVGHA+oDxSrHDxR4UNPBj7YLHwq+wV
	 rqNs2DAlR8YDSPRFEt1rmpM5FW+WBnMaWZ/JMB1z8nuMWzorusWGPdUveKT/AhnGD8
	 IFbpqvFGjKkUZXDd7Cpfsps7VErWe1wLdb3r7QtcJdVbsqxldZGCOFPAldRhHVg6Ie
	 XpgwxthKSCwNw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSvhh0Vljz4wd0;
	Mon,  5 Feb 2024 16:15:16 +1100 (AEDT)
Date: Mon, 5 Feb 2024 16:15:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boot failure after merge of the vfs-brauner tree
Message-ID: <20240205161515.598ae7f6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LQu3HP_jhzfTo8giHeSP_CJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LQu3HP_jhzfTo8giHeSP_CJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (powerpc
pseries_le_defconfig) failed like this:

[    2.498347][    T1] Loading compiled-in X.509 certificates
[    2.514931][   T53] BUG: Kernel NULL pointer dereference at 0x00000038
[    2.515067][   T53] Faulting instruction address: 0xc0000000011c9e14
[    2.515629][   T53] Oops: Kernel access of bad area, sig: 11 [#1]
[    2.515749][   T53] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUM=
A pSeries
[    2.516160][   T53] Modules linked in:
[    2.516586][   T53] CPU: 0 PID: 53 Comm: cryptomgr_probe Not tainted 6.8=
0-rc3-04019-g26b3eeef9e0f #1
[    2.516849][   T53] Hardware name: IBM pSeries (emulated by qemu) POWER8=
 (raw) 0x4d0200 0xf000004 of:SLOF,HEAD pSeries
[    2.517084][   T53] NIP:  c0000000011c9e14 LR: c0000000001dd7b4 CTR: c00=
000000029c820
[    2.517163][   T53] REGS: c00000000786fa00 TRAP: 0380   Not tainted  (6.=
8.0-rc3-04019-g26b3eeef9e0f)
[    2.517288][   T53] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  C=
R: 28004208  XER: 20000000
[    2.517612][   T53] CFAR: c0000000001dd7b0 IRQMASK: 1=20
[    2.517612][   T53] GPR00: c0000000001dd7b4 c00000000786fca0 c0000000015=
c9900 0000000000000038=20
[    2.517612][   T53] GPR04: 0000000000000003 0000000000000001 00000000000=
00051 fffffffffffe0000=20
[    2.517612][   T53] GPR08: 0000000000000000 0000000000000001 c0000000079=
554c8 0000000000002000=20
[    2.517612][   T53] GPR12: c00000000029c820 c000000002b60000 c0000000001=
8fa0c c00000000404cec0=20
[    2.517612][   T53] GPR16: 0000000000000000 0000000000000000 00000000000=
00000 0000000000000000=20
[    2.517612][   T53] GPR20: 0000000000000000 0000000000000000 c000000006e=
0e580 0000000000000000=20
[    2.517612][   T53] GPR24: c000000002951080 c000000002a0e848 00000000000=
00000 0000000000000051=20
[    2.517612][   T53] GPR28: c0000000048cc100 0000000000000038 00000000000=
00001 0000000000000001=20
[    2.518535][   T53] NIP [c0000000011c9e14] _raw_spin_lock_irqsave+0x34/0=
xc0
[    2.519499][   T53] LR [c0000000001dd7b4] __wake_up+0x44/0xa4
[    2.519797][   T53] Call Trace:
[    2.519944][   T53] [c00000000786fca0] [0000000000002000] 0x2000 (unreli=
able)
[    2.520411][   T53] [c00000000786fcd0] [c00000000786fd10] 0xc00000000786=
fd10
[    2.520523][   T53] [c00000000786fd20] [c00000000016d240] pidfd_wake_up_=
poll+0x50/0x64
[    2.520597][   T53] [c00000000786fd40] [c000000000189460] __change_pid+0=
x84/0x16c
[    2.520669][   T53] [c00000000786fd70] [c000000000158dec] release_task+0=
x338/0x788
[    2.520740][   T53] [c00000000786fe10] [c00000000015aa9c] do_exit+0x6d8/=
0xd38
[    2.520812][   T53] [c00000000786fef0] [c00000000018f9c4] kthread_exit+0=
x3c/0x40
[    2.521033][   T53] [c00000000786ff20] [c00000000023f2bc] __module_put_a=
nd_kthread_exit+0x38/0x3c
[    2.521120][   T53] [c00000000786ff50] [c00000000095cdc4] cryptomgr_prob=
e+0xc8/0xcc
[    2.521204][   T53] [c00000000786ff90] [c00000000018fb3c] kthread+0x138/=
0x140
[    2.521283][   T53] [c00000000786ffe0] [c00000000000ded8] start_kernel_t=
hread+0x14/0x18
[    2.521512][   T53] Code: 3842fb20 7c0802a6 60000000 fbe1fff8 f821ffd1 8=
bed0932 63e90001 992d0932 a12d0008 3ce0fffe 5529083c 61290001 <7d001829> 7d=
063879 40c20018 7d063838=20
[    2.522412][   T53] ---[ end trace 0000000000000000 ]---
[    2.545459][   T53] pstore: backend (nvram) writing error (-1)
[    2.545630][   T53]=20
[    2.545995][   T53] note: cryptomgr_probe[53] exited with irqs disabled
[    2.546329][   T53] Fixing recursive fault but reboot is needed!
[    2.560506][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: fcc64ee53479274966d371cbdc225bca2574aaaf'

Bisected to commit

  7a1cac7d58e3 ("pidfd: convert to wake_up_poll()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/LQu3HP_jhzfTo8giHeSP_CJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAbuMACgkQAVBC80lX
0GztiQf+Kj17VvxUzJ8GtyZD9faCQFC/3aZL2aiyZEIy+i/yKSjhnex4BTUrWh1q
SINgRh/CKn5N53NL5ppGzRugu/Q8qpnv930DwjGRtHBMLfp69cdkck6UZOMffplP
vFnUe1k2vXJm00EKtUS+sdhecXYi3vpBXwcEqz3lvKaQzDWEn1iA92GT2Qhmr12Z
Yw7NWY9OBW73obRK/ASz8u2yZ2KR9cDhsj52LnZ/E+giGT8FPNDBFRihFdTqg7TN
GGSVPQeaHA/By1fqLiPd23WtMSp4M9wlZuRBbWtXF12AGatkW3UKAOY6eaVVyh9M
PzrKYMosCsthpYfU/j4Rm2/UPPiZJQ==
=FBUu
-----END PGP SIGNATURE-----

--Sig_/LQu3HP_jhzfTo8giHeSP_CJ--

