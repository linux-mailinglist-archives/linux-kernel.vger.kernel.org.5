Return-Path: <linux-kernel+bounces-94983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3CE8747A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5ADE2877BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D2B1BC4E;
	Thu,  7 Mar 2024 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P4DkRNr9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B799B800;
	Thu,  7 Mar 2024 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709789407; cv=none; b=Cb8sYWEAjrjkezzsawKb5IEm6241TY8UuU7HIdgNpbrw8kZGbhQA+wdG1PDwqnuy8jNQfY2l93vtoQjxlNJTVq/WUdfrEd1CV7HDcETepP/LBF5cYs5BAagC6RmXtyHhAK/Imn3+lslki9vfl1p3ZCxI+ER7biQbQQTdOulkIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709789407; c=relaxed/simple;
	bh=oixThpyCLljScgfQH67hpTvybQrzQZQ0uWP9nr8hF2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pBlX8o5NS6e+53ULlBa7bX6w7nkMKlECHeqhptlkkNOXHMBBQYKR49CES25xOjut3gVSP6yim7gSzAj0C4Kmq7J/tB9JlV7/Kc6SnXCPRmWVDFqQn1XRLV7CdYxe3QXUwshOn1p2lh2j4gjXabu4vZiwUMV8P5pYb1U0lgaOUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=P4DkRNr9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709789400;
	bh=WwRVVZpoM6Mq2BVwpn+UlVgzSpO6s1x9V6sisuhzZcM=;
	h=Date:From:To:Cc:Subject:From;
	b=P4DkRNr9fEZQWMRbmRafufpJ70QN4hDNjXOwDen0EFKra/1CS7m233w8pgVzO2/r+
	 WbrkPHym/hFMg3z2HdWgTz9sJDE2R+mTx7fWjSHKRs2TaCr+1blslDFb+nzD5EQhCL
	 6mDS6P/0Tdogf+fHddNohVt9gZDwb/1EcSpfmFh/jjdR+k7THWH3gcxXLuTgY8+2dp
	 C4O8++KhpBPE02MXAAFJe9j5AnvuHt+n0Y9WoSnhUXjPLo0spH9FX6UKDt7+0HggZy
	 eJCqXobVIRLS/4NkZoL4jM4RbnZKlYeaUmZPUATiQ2vkuxnFa5J9fO7FpHaBWj7Lth
	 qiaiyGKIF6FLA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqyYN2Hwwz4wb2;
	Thu,  7 Mar 2024 16:30:00 +1100 (AEDT)
Date: Thu, 7 Mar 2024 16:29:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: linux-next: manual merge of the kspp tree with the net-next tree
Message-ID: <20240307162958.02ec485c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KKC=VkzxSjzYUXLCCYks1rQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/KKC=VkzxSjzYUXLCCYks1rQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the kspp tree got conflicts in:

  drivers/net/ethernet/intel/ice/ice_lib.c
  drivers/net/ethernet/intel/ice/ice_xsk.c

between commits:

  3e5fb691faee ("ice: make ice_vsi_cfg_rxq() static")
  a292ba981324 ("ice: make ice_vsi_cfg_txq() static")

from the net-next tree and commit:

  014dc22af922 ("overflow: Change DEFINE_FLEX to take __counted_by member")

from the kspp tree.

I fixed it up (I used those files from the former and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 7 Mar 2024 16:26:02 +1100
Subject: [PATCH] fix up for "overflow: Change DEFINE_FLEX to take __counted=
_by
 member"

comflcting with commits

  3e5fb691faee ("ice: make ice_vsi_cfg_rxq() static")
  a292ba981324 ("ice: make ice_vsi_cfg_txq() static")

from the net-nect tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethern=
et/intel/ice/ice_base.c
index d2fd315556a3..a545a7917e4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -956,7 +956,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring=
 *ring,
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_ri=
ngs,
 			   u16 q_idx)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
=20
 	if (q_idx >=3D vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
 		return -EINVAL;
@@ -978,7 +978,7 @@ int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct =
ice_tx_ring **tx_rings,
 static int
 ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_tx_ring **rings, u16 coun=
t)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
 	int err =3D 0;
 	u16 q_idx;
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/KKC=VkzxSjzYUXLCCYks1rQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpUNYACgkQAVBC80lX
0GwYzAf/cHz58I+sxWEDTrf4mBIxC5PNSoHCBag8/DrJXT4Grd3/Do7R3R8S2A1j
uEpkOoUSt8OHtDaUfppBZIgjtZAIpgc1f0CId0I/JxedDDQXnR7btTvo0rkg8mhE
NovOfdyO5kYUE+Go8LXinYXyp2m5pWPoNHgg+c9ChbSSQq8MgZkriH/ltbre31P3
CIsfO16mo6bsAHvGiZ1fBN2/N4ECnxdf8TP/X940qvbd7ukYu3MgRaZx4dA30axs
rNdoQKPvjFgJs2P9p5dS9Gu0JhCd9TmauMLd13TLrlyY5SnMLX6u2ROrsb3XqkC7
9bigJeN/QfWqszXAxAS4O3EZ8bzn1w==
=NF51
-----END PGP SIGNATURE-----

--Sig_/KKC=VkzxSjzYUXLCCYks1rQ--

