Return-Path: <linux-kernel+bounces-132353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE31899375
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A011F224BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA65179AE;
	Fri,  5 Apr 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ig1fME5y"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC401C687;
	Fri,  5 Apr 2024 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285736; cv=none; b=F0Fg+WxhGRc8yfOYR9hJRAkjLqCG22yxpT/wbhCIVLdd/+fT8ZNyhPlpJkvjlO0sAvUomTrj0O/IK8Q43dFfXd9QQ8WYbeDlMRzgsxycThzoYJpKTuW7ycir5Lq6/atJbXIEYb3z5Vqn7jXfifhAK2ZKFLVI+diC/jioAxJ9wmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285736; c=relaxed/simple;
	bh=+kbTXVFwSt0UMkxpCLRgEYRw05hyqQaZU0yzBJlM1+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hxF1Stit9xGhRYup2zvF6ReFkr+BRpEMww/oTuLbbb3qbUcDgbpaYgqo3veb2WiOwVAEjQragjDwUr6nAmiVBv8rm1cJukfystRORJYTuV6eCCTn7ITcMAW9rdCHJXUq6HNOxMcRb2t9E6wLNQjjO+83sjjG/KRrKTZ+4UHO0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ig1fME5y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712285731;
	bh=qnM+r/5Ta/w3NCYh7ZVWH2pEq3OJKmpTjO4RX2orPl4=;
	h=Date:From:To:Cc:Subject:From;
	b=Ig1fME5y/Ueald1JeeHYN37g+o/iZDPwldfnbArEowAGeY401eIJSnMDOLYYoimI/
	 eQggAxQ1hODPPBxHZaGZ1Ksd0MV5Kne2wXRUMQJi0OsxVRSMVHQ6wV55GCjBdZBrk1
	 XHfV6tmLW/Vnz5xgw3wE1YMOA3LW+FiOmSb4jCdmsPwl7zgQiybwOIJ7py6r8RlEYp
	 I293NF33c8Czfd/COJF2u4THycADVUpOtNMFS43BNkYcVKGZ6KCYKxpmdGvLqyb7EX
	 JIdDzJA0knc4pWfwi5pVDLnWeAGx/KthBQhtL7KEIIZoC/LaZI1qTKTJoEt6/+UwsY
	 eXpGPg0aPPL3Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9jlk6B30z4wcb;
	Fri,  5 Apr 2024 13:55:30 +1100 (AEDT)
Date: Fri, 5 Apr 2024 13:55:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240405135527.4b5daaed@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NoImhhi7JSTuJe.EShoZ1LH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/NoImhhi7JSTuJe.EShoZ1LH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm64 defconfig)
failed like this:

In file included from arch/arm64/include/asm/memory.h:213,
                 from arch/arm64/include/asm/page.h:46,
                 from include/linux/page_counter.h:8,
                 from mm/memcontrol.c:28:
mm/memcontrol.c: In function '__mod_memcg_lruvec_state':
include/linux/mmdebug.h:114:35: error: expected expression before 'do'
  114 | #define VM_WARN_ON_IRQS_ENABLED() do { } while (0)
      |                                   ^~
mm/memcontrol.c:867:29: note: in expansion of macro 'VM_WARN_ON_IRQS_ENABLE=
D'
  867 |                         if (VM_WARN_ON_IRQS_ENABLED())
      |                             ^~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  e04f729678f6 ("__mod_memcg_lruvec_state(): enhance diagnostics")

from the mm-unstable branch of the mm tree.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 5 Apr 2024 13:27:48 +1100
Subject: [PATCH] fix up for "__mod_memcg_lruvec_state(): enhance diagnostic=
s"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 42f82259864f..91ac261877ec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -864,8 +864,12 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, e=
num node_stat_item idx,
 				pr_warn("stat item index: %d\n", idx);
 			break;
 		default:
+#ifdef CONFIG_DEBUG_VM_IRQSOFF
 			if (VM_WARN_ON_IRQS_ENABLED())
 				pr_warn("stat item index: %d\n", idx);
+#else
+			;
+#endif
 		}
 	}
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/NoImhhi7JSTuJe.EShoZ1LH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYPaB8ACgkQAVBC80lX
0GzAaAgAmy7FHNP6Q8kLxHwSI+wEgEuToR/mzlYCiccBO5w75v+vzRs+Y2s748fp
/hmEgbZe6im+ud5ZMgK00XmvE8kkcyVX0HBSHzLVwvB40RRgsDtbfkZXIVcEWTx5
fsiF2cuEC6ELAfL+NZ08C+fwH3arXx8gslIUznOPdJy9Zbe0bb7bHxDR7yaudTxn
c3OWth/ZPLAZ0up6i+lHe/DdKoEKdgL+uf4FQvgL4qjwYRmWE5WZOZ4vlfdnkvkI
oTcKlz2FwbbWQYX6Ib2Sgm3VZw4ptkthsgY/AcBOrz2UkDLorkSZE4osspaj6jly
1k9thZ7v8iFNqbWagZYXEjy2T0HjKA==
=UroZ
-----END PGP SIGNATURE-----

--Sig_/NoImhhi7JSTuJe.EShoZ1LH--

