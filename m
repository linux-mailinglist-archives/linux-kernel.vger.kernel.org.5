Return-Path: <linux-kernel+bounces-56007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3405984C4E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D688A28C67B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E51CFA8;
	Wed,  7 Feb 2024 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U5gwo+mc"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CF1CF8A;
	Wed,  7 Feb 2024 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286668; cv=none; b=RInmz+QN71BaTisQha3I7e9EX+uCTDMOT3wI+wBmMPSOrLcGTd5jL41YuPQHnNCH/Yznfjg7KVYHCJ81i+ds9NE8xqHc3vWG6+oBrveoKTYuSAYf8t7Q48Vd0SWtRl0mZMbUInlw611jtX40E5SGrp33EaZRAExZNVsJaXDDvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286668; c=relaxed/simple;
	bh=yk8VkfK6JqlgbwfJ8elhDe8rYDVY9GE1/9Fde6awSlE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HIY/5wu5ZFy19wab1oeDZxh3wgK+iV3kzsyDewyu3F3L+Bo6f7D5qyh++k8TkVxP+lknH2cIhpHo5FPZB9FuNxNTj17+9PhPCX4pKeHxVJ4TLmoxPBTzqQ8Nu8kob78lVPh3cW++F41ppSXgVlmrURbKdTpN4HKg8634EVnTEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=U5gwo+mc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707286664;
	bh=4HrCo4Go00EXz2MqlF14s4KMx2UZHKzsjS+HN7k95S0=;
	h=Date:From:To:Cc:Subject:From;
	b=U5gwo+mc4QkcLVjBa2BXOhjqnYCqkmCzyoHA7BS0q6iGdkLFR0ILGa8hpqdQBoSev
	 ZqVsA0ZY+TX/Bf90mOzE9ws9mSTXkvqNPKuIvIffF4CsVkBitj/FLj/SPeZjXvyzC8
	 BHEczgSmwMDIaLnGBo0UXnoTLy5WpW/udtRTXnLzEb2EiT+34MtI3Ve9I3FhN5v53C
	 TFWiTYifghrk2dNL5L40szqKAqr6xSDc97VCfip/fjH5WRruKA5ObeXGGEuAll+YiZ
	 1ztPBkn0EDfbIAJzcu5nOM8/eeCFj7PJUq5RgPL+wNnYpAn3k2qTau4mf1lvZLICut
	 F6RVAK233cQig==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TV8zq2X86z4wd0;
	Wed,  7 Feb 2024 17:17:41 +1100 (AEDT)
Date: Wed, 7 Feb 2024 17:17:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240207171741.1f3f090f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SdI4lH_kzqvTR_gswJ2k=GE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/SdI4lH_kzqvTR_gswJ2k=GE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allnodconfig)
failed like this:

mm/memory.c: In function 'do_swap_page':
mm/memory.c:4004:29: error: implicit declaration of function 'swapcache_pre=
pare'; did you mean 'swapcache_clear'? [-Werror=3Dimplicit-function-declara=
tion]
 4004 |                         if (swapcache_prepare(entry))
      |                             ^~~~~~~~~~~~~~~~~
      |                             swapcache_clear

Caused by commit

  1fa5b77af107 ("mm/swap: fix race condition in direct swapin path")

from the mm-unstable branch of the mm tree.

# CONFIG_SWAP is not set

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 7 Feb 2024 17:04:15 +1100
Subject: [PATCH] fix up for "mm/swap: fix race condition in direct swapin
 path"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/swap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 768a9078070d..b4c389b9e4e0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -552,6 +552,11 @@ static inline int swap_duplicate(swp_entry_t swp)
 	return 0;
 }
=20
+static inline int swapcache_prepare(swp_entry_t swp)
+{
+	return 0;
+}
+
 static inline void swap_free(swp_entry_t swp)
 {
 }
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/SdI4lH_kzqvTR_gswJ2k=GE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXDIIUACgkQAVBC80lX
0GyjPAf+NVv5nt0BdXm7Yr8nTfKcUV9Sldle4+ccAHH50Ly8lXY4dZ0srhTIKU7K
yZsXL8YysjPi/U+fDaKXG9G9xU7G9SY4lHgfAoaaG6I+4xOMkgBvPWhd2HmDO7dj
QelE+UfxTMiGWKEf86V9biEapfVE5FnErzkFcBEmlttokM1j0IytYn8LkIa+4iGM
Th5W653WctvWxGo/pfo9698HWcsgMMVB+dnDqDtut6elk/7KJsGa8cCSdIeoW89F
aT8A0Grh49Sfu/yTh1CK348OAqBdbfemHGF7XJOWNnqgxJmoX4ZcZ6wZGlfhn73m
UnUKG6dHOvYfa/8RZBfY+TuFeMD9XA==
=chF1
-----END PGP SIGNATURE-----

--Sig_/SdI4lH_kzqvTR_gswJ2k=GE--

