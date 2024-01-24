Return-Path: <linux-kernel+bounces-36292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6D839E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB428B936
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86901854;
	Wed, 24 Jan 2024 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DR4uHRrp"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC017CD;
	Wed, 24 Jan 2024 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061685; cv=none; b=XOV0l8vFLc4H7mCma8fUR9DWncn78Nifx6scO6mJrMU5EhlXIoQlPrGehRupSFQ051tXBe7y7Gy6f1265QW58A0D+dCxs+2H8Cx9MMr3cCEjYfl3FTQK9j0oM6sZMm46tzmHZ59840X3UDl2a7fuYKw4kHCXjv3EMCHQupLvxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061685; c=relaxed/simple;
	bh=MRdtvG8pQ96PEh72/XRLyS2XdvhflNuwultr1W9eCo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EAzfJWSoop59MBo4Lqr2f/nYgw26ZfCVcD6uBWNyqhhrUHQi9sY0zZ43c026HinMWZTJXv5AA3YyV8zV/1aKGh53POaLjYWLIsDuWShLUOn34irKFVOwL9pRACN1DylWUmJ9e+yyY5DlxeYAL0g0WgZhKs+8n42WK+hsA10GZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DR4uHRrp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706061678;
	bh=Pgm92d7EvsbO07suhqUnGCLrKYIQcZuz2VMy95wg+gs=;
	h=Date:From:To:Cc:Subject:From;
	b=DR4uHRrp+Bc0Td3Yys5hTTt+XfnudrhCG2BGKc6T+dDaYTcZrMRqhyy3R5CVFKRx9
	 C9jXp8Sbwrp7F33Y01waWFrT9qLr0lDOxodqFt7PPdT+LtRaWwSlvV4Yz0XkA565aM
	 xWTtzUEiaLvJppsbOlBHkD2gbAG/EXTyKnTx2inoyDcRRgg5tby6MRVcFZC8LDJLpz
	 hIDztQSSihL9gWo57PoNoN5bXyT9xjHvHeHdffnIQ+f9hhFx+W6Ztx+ty+ErNVFM0o
	 Gk9XPzhTupS0W28ANdDFcTmL7Pl54CKKZ6hxjdcndx3yavkG13bspoYC8xCkHRamen
	 8ZZ2UWArw08Kg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKRyJ5FJ3z4wcg;
	Wed, 24 Jan 2024 13:01:12 +1100 (AEDT)
Date: Wed, 24 Jan 2024 13:01:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Miller
 <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Hector Martin <marcan@marcan.st>, "Jason
 A. Donenfeld" <Jason@zx2c4.com>, Jean Delvare <jdelvare@suse.de>, Lee Jones
 <lee@kernel.org>, Micah Morton <mortonm@chromium.org>, Mike Marshall
 <hubcap@omnibond.com>, Pavel Machek <pavel@ucw.cz>, Theodore Ts'o
 <tytso@mit.edu>
Subject: linux-next: trees being removed
Message-ID: <20240124130101.428c09a3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bPEb4N_WcQx9cktdPsZTtVv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/bPEb4N_WcQx9cktdPsZTtVv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The following trees are going to be removed from linux-next because they
have not been updated in more than a year.  If you want a tree restored,
just let me know (and update its branch).

Tree			Last commit date
  URL
  commits (if any)
-----------------------------------------
asahi-soc-fixes		2022-08-14 15:50:18 -0700
  https://github.com/AsahiLinux/linux.git#asahi-soc/fixes
backlight-fixes		2023-01-01 13:53:16 -0800
  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git#for-backl=
ight-fixes
broadcom-fixes		2022-10-16 15:36:24 -0700
  https://github.com/Broadcom/stblinux.git#fixes
dmi			2022-09-23 14:53:14 +0200
  git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git#dmi-fo=
r-next
leds			2022-12-25 13:41:39 -0800
  git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git#for-ne=
xt
mfd-fixes		2023-01-01 13:53:16 -0800
  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git#for-mfd-fixes
orangefs		2022-12-07 15:18:30 -0500
  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux#for-next
random			2023-01-04 12:11:29 -0800
  git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git#master
safesetid		2022-07-15 18:24:42 +0000
  https://github.com/micah-morton/linux.git#safesetid-next
sparc			2022-09-30 11:58:23 +0100
  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git#master
  2d2b17d08bfc ("sparc: Unbreak the build")
  (This commit has been included in Linus' tree as part of another commit)
userns			2022-11-30 12:54:24 -0600
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git=
#for-next
  54e1011bd95a ("sysctl: Allow change system v ipc sysctls inside ipc names=
pace")
  f9b90c2062b2 ("docs: Add information about ipc sysctls limitations")
  7608b6a72ed0 ("sysctl: Allow to change limits for posix messages queues")
  a799be9bafe3 ("ipc/ipc_sysctl: Add missing include of linux/cred.h")
  b895e6689ebf ("sysctl: Fix mq permission check")
  295227b10192 ("ucount: Fix atomic_long_inc_below argument type")
  b4b11b58cd02 ("ucount: Use atomic_long_try_cmpxchg in atomic_long_inc_bel=
ow")
  (only these last 2 commits actually change anything in Linus' tree)

--=20
Cheers,
Stephen Rothwell

--Sig_/bPEb4N_WcQx9cktdPsZTtVv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwb10ACgkQAVBC80lX
0GzyrAf/Rbui1YdTbzAVFmoO7OLlNZJc5cCSWUsEy5u7N+BHIZYGt/X/dBNIqikj
OHJzGU5V2MHOvboB/8kjEtbdVY1mIGft5R7mdg6djjUjOsxEG9L6hx3bHteelYIH
lrG/260Muf/xSjBhFn0cKGBaFuJyoBgbaLItKgPIt0yICnKeWfteCz65I6QaQsmT
4mJop9c7eRtHf89z3GzA0+wKGGOUI6SlCnrMG3ZsKBWgf2uxbj1E2MYM+poLIGwd
1pyXKRrio/mRNqIXqrDtmKvQrniggZNsgl2+r/SGjowQhIlUqmw/a2zwF9S/8x2T
TXhhzKYQRPYr4vVssezdkGZofnS66A==
=uKqs
-----END PGP SIGNATURE-----

--Sig_/bPEb4N_WcQx9cktdPsZTtVv--

