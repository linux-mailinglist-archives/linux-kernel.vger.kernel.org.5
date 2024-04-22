Return-Path: <linux-kernel+bounces-152665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 836358AC279
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FE51F2155E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A92F2D;
	Mon, 22 Apr 2024 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ceCPMWlZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75481E;
	Mon, 22 Apr 2024 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713747391; cv=none; b=qehBZ8V0kEKSXG+JsrLPOGHmCVVo/sIBRqPKSYFHO9URDz6iBE/wdAeupMocjVqcslQt+NhZKsvD8ZfLVrWNRuvC45PJKQTnLoy/P8oK16S85BJBpFEujzrG2Z+e/6ZCslQzkNNZEtBfeO3w6fSnfEUVi6mpDDkEAm+MmRZ2Abk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713747391; c=relaxed/simple;
	bh=371jyJprDRfHOmCH/Fxpr8y4E1O0YN2AgmEBCXGdqEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iaL9FKynvJYw0Eq5CFMdQfJIx8QyrSivTjeMuo/+U07kKIuXDQb4UKFrJp37m5DLyDZ+ZXFGYVaeO8pvCvOIVm92WRRC52gpLHOztPfRybkhtqGgNekUSMIP+wYmr4X22CpstcEdzB78++J3E0//L7Indb/eYNwJn/U+LhAcxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ceCPMWlZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713747385;
	bh=o2iiRfsgDlxie7Sw96O890/W7qDYXB9sJMVK0j1DSqY=;
	h=Date:From:To:Cc:Subject:From;
	b=ceCPMWlZI1hKoou3tOvDZFlglDWoeB2cC2dgP9246mKnjDagMNCCjyMKQi5izduYl
	 nyQ3VxLupN1H4LqyS5Cq0a0OunCZKzW0g0veL+COrgECXh5/BkvQyYJQHtW/RJ74vX
	 Q11LLYY4T9/t+H+d3zU9nBnoNRayPIC1vtcF4FH/dHmcfVByXSkS4pDz+dHV7FxMcZ
	 K94WcPJwCMxOYt7MTP2vpoacgN5ai9ahqRw06SilNrnWvV3qUmJ+N6rPxsaUfRgYVs
	 qp6JoHL9vOk7jv3CKogKYWDrppFvfBS3A9H/Gs03D70fQCNROakJn8/iNi4Mfy9jgi
	 C6yENISOEWJVQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VN6JS24rfz4wcb;
	Mon, 22 Apr 2024 10:56:24 +1000 (AEST)
Date: Mon, 22 Apr 2024 10:56:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Johannes Berg
 <johannes.berg@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20240422105623.7b1fbda2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P0JkuJR6=UOwV3U=MCBrQxx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/P0JkuJR6=UOwV3U=MCBrQxx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/mac80211/chan.c

between commit:

  89884459a0b9 ("wifi: mac80211: fix idle calculation with multi-link")

from the wireless tree and commit:

  87f5500285fb ("wifi: mac80211: simplify ieee80211_assign_link_chanctx()")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/mac80211/chan.c
index 4e0c1a6e509f,dedf11eeb43c..380695fdc32f
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@@ -800,8 -819,7 +819,8 @@@ static int ieee80211_assign_link_chanct
  	struct ieee80211_local *local =3D sdata->local;
  	struct ieee80211_chanctx_conf *conf;
  	struct ieee80211_chanctx *curr_ctx =3D NULL;
 +	bool new_idle;
- 	int ret =3D 0;
+ 	int ret;
 =20
  	if (WARN_ON(sdata->vif.type =3D=3D NL80211_IFTYPE_NAN))
  		return -EOPNOTSUPP;
@@@ -822,17 -840,24 +841,22 @@@
  		ieee80211_recalc_chanctx_min_def(local, new_ctx, link);
 =20
  		ret =3D drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
- 		if (ret)
- 			goto out;
-=20
- 		conf =3D &new_ctx->conf;
- 		list_add(&link->assigned_chanctx_list,
- 			 &new_ctx->assigned_links);
+ 		if (assign_on_failure || !ret) {
+ 			/* Need to continue, see _ieee80211_set_active_links */
+ 			WARN_ON_ONCE(ret && !local->in_reconfig);
+ 			ret =3D 0;
+=20
+ 			/* succeeded, so commit it to the data structures */
+ 			conf =3D &new_ctx->conf;
+ 			list_add(&link->assigned_chanctx_list,
+ 				 &new_ctx->assigned_links);
+ 		}
+ 	} else {
+ 		ret =3D 0;
  	}
 =20
- out:
  	rcu_assign_pointer(link->conf->chanctx_conf, conf);
 =20
 -	sdata->vif.cfg.idle =3D !conf;
 -
  	if (curr_ctx && ieee80211_chanctx_num_assigned(local, curr_ctx) > 0) {
  		ieee80211_recalc_chanctx_chantype(local, curr_ctx);
  		ieee80211_recalc_smps_chanctx(local, curr_ctx);

--Sig_/P0JkuJR6=UOwV3U=MCBrQxx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYltbcACgkQAVBC80lX
0GxfBAf/TGFiNoDJ4g3bno2FzMVTWyL/dQDogND/PFuxrVZLDHZcFn8sHXOclrfn
I5PRAXTs6J7X3zYtrmoQyJN/BuhkAocmDtHPgFTx1BAnrO42/GmbKC1/SpWdG47V
JxwX/s16So6O2sGNKCDFpyVcjAAFkeZvRX4td6XJNkLA6zH0LIABVzWYzsw3Bg//
R3Vi8wsjkcrqGD8DEdheyw54bSKnNSxIFan4/1ivIsmvDWDpEkwGof2fKTbY/3XJ
KgVjOFmrzC071pmhplBzmQDA0f5AaTV3wTuB3GeY/89aajf6lvN+/QNGXZXWbo3o
kk+ON7Ib/KGj/+z/RAlmEuNvUBaekQ==
=aLjw
-----END PGP SIGNATURE-----

--Sig_/P0JkuJR6=UOwV3U=MCBrQxx--

