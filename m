Return-Path: <linux-kernel+bounces-260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0D813E68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972311F22B19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9492DB6E;
	Thu, 14 Dec 2023 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZKcQ49B5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCA2DB61;
	Thu, 14 Dec 2023 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702597943;
	bh=rMQwh6ZcWzINIjfHJVIKMLZyamBUqrB0RFZAYZl7Zb8=;
	h=Date:From:To:Cc:Subject:From;
	b=ZKcQ49B5I/Jh5muyWnok/xCBnkIK+8G2HMRiJ/im9+jVFpiXFFqrtXu/jKk3N2DTX
	 4TUt9/t/Lnf1PJbB+FpbZxXMfDr+DOzMJVdmnWbTLR695N/9unuF2c9nmIeSoaXBE8
	 /Skj2UAjxjnvmq/brgKRxTUuMupW/jirv3w7M4Wa0WOGQ/VaMubkF8HlpfsQnrwkHf
	 JIxWg8ZMZZOiT8p3Prvs+7HJqPnyyeo8XPNLdfbiQNFBcrz9zGT9xCn9Bq1me0NrhW
	 ePw6bPUmVnpwcUpIRco6es3qWWws8TBLkjV36ohZuW/p6g3N1LrenzBtO+xD2eLelF
	 7U4cgLqu0oThg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Srq0629Nwz4wb2;
	Fri, 15 Dec 2023 10:52:21 +1100 (AEDT)
Date: Fri, 15 Dec 2023 10:52:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Petr Oros <poros@redhat.com>, Piotr Gardocki
 <piotrx.gardocki@intel.com>, Ranganatha Rao <ranganatha.rao@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: linux-next: manual merge of the net-next tree with Linus' tree
Message-ID: <20231215105219.118a1ea5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+IvAp3H7R_mPW8u+BQNbQvZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+IvAp3H7R_mPW8u+BQNbQvZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/intel/iavf/iavf_ethtool.c

between commit:

  3a0b5a2929fd ("iavf: Introduce new state machines for flow director")

from Linus' tree and commit:

  95260816b489 ("iavf: use iavf_schedule_aq_request() helper")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index dc499fe7734e,f147743792fb..000000000000
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@@ -1436,16 -1435,11 +1435,16 @@@ static int iavf_add_fdir_ethtool(struc
  	spin_lock_bh(&adapter->fdir_fltr_lock);
  	iavf_fdir_list_add_fltr(adapter, fltr);
  	adapter->fdir_active_fltr++;
 -	fltr->state =3D IAVF_FDIR_FLTR_ADD_REQUEST;
 +	if (adapter->link_up) {
 +		fltr->state =3D IAVF_FDIR_FLTR_ADD_REQUEST;
- 		adapter->aq_required |=3D IAVF_FLAG_AQ_ADD_FDIR_FILTER;
 +	} else {
 +		fltr->state =3D IAVF_FDIR_FLTR_INACTIVE;
 +	}
  	spin_unlock_bh(&adapter->fdir_fltr_lock);
 =20
 -	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
 +	if (adapter->link_up)
- 		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
++		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
+=20
  ret:
  	if (err && fltr)
  		kfree(fltr);
@@@ -1475,12 -1469,6 +1474,11 @@@ static int iavf_del_fdir_ethtool(struc
  	if (fltr) {
  		if (fltr->state =3D=3D IAVF_FDIR_FLTR_ACTIVE) {
  			fltr->state =3D IAVF_FDIR_FLTR_DEL_REQUEST;
- 			adapter->aq_required |=3D IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 +		} else if (fltr->state =3D=3D IAVF_FDIR_FLTR_INACTIVE) {
 +			list_del(&fltr->list);
 +			kfree(fltr);
 +			adapter->fdir_active_fltr--;
 +			fltr =3D NULL;
  		} else {
  			err =3D -EBUSY;
  		}

--Sig_/+IvAp3H7R_mPW8u+BQNbQvZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV7lTMACgkQAVBC80lX
0Gy/mAgApKLj8MZ8Tj4vPsNMSJX4ZEnZKrPuG7GFI8vxQRBnWX7UTGKp7/VgExSD
CaAi0PlBXduMSpPe48YimsvLKDEfDqVJiUMEcmh8FoA1rt5aBxuuxrGT3CcWP4JH
bmq1IOR77r4WGzszSyYzeJyHj7Fc9JcTlNE7L5p1/P47fxplVktF3vEN8NRj3XqY
COokn62mquj7YdCXwHBdWmLk+0yMBa13JYCcwxefLHF4inq2ZGxZh+iVOHrKFy0f
YvdHi/c9hKWqL8PUcIWpEGDYgwk1qT6HSxZIu0s7TAY8JjnRuiFvAL3E3zLXHsGX
IQRK6xKacRJgH8gZUzjfYuC97ujGow==
=Przn
-----END PGP SIGNATURE-----

--Sig_/+IvAp3H7R_mPW8u+BQNbQvZ--

