Return-Path: <linux-kernel+bounces-156043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B78AFD18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B911F22C73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691EC80B;
	Wed, 24 Apr 2024 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rP/dcHbu"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F5360;
	Wed, 24 Apr 2024 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917283; cv=none; b=LSHNY8S+vew4TtZW2HRLYyV2iysGIlhTEfZl4vI1UAb9eGwm/lB3h+ZWHIZ2ITtGSuLe45J9vg+H8sKyNOD0HToOgIgXCoxUWP0Y8N2/hIS+plf4NxwQ0PIpgu2u0/vBj/PzFB9h0wMuDk6WjaAVX4vZmyQnX8VcE6kq6fCswd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917283; c=relaxed/simple;
	bh=EgtmWhSEW8wW2BhIGjhRXOdm7BdPm6JTiRmV2xDgs2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gt9EENPAkOd/PYpGTgEc5oc8clamK1CrVKmSVaEuLxvMwyMafKYrwyUEGiYQswBd7nzIjmUzEEsyfnwtA549N2avJFPuukLsqMPR6s2R3MWb6n61LSaHk+OHKhVj4G6MW7JFacLMvkeCUyLI0ylZOfoKK9cBgXU6/0R4FbbPNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rP/dcHbu; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713917271;
	bh=/Z9S5x1/FS6TdiCI55O0Yjx6AVgpGU8mBrcgq7PONGs=;
	h=Date:From:To:Cc:Subject:From;
	b=rP/dcHbuHnFd5Hm5emxU8p96UN615cF4iomfMJWdqWQDtQFaeVIqlSa6jtW+pJWlo
	 kMOLuoZgM/rT6VdtfSNvoHvk5ANDm0dZ90pTUidTK8puSlxUMQORrfHGcKxeFTr8no
	 eT1dqLKdBO8WMU+CRD8I25pvzC1yU+npC8igqo3xzP3cGxqlOG4W/NDTZ5XgHQRaNv
	 G+Ilr5md3znzf4F9EG0K47usl6NXKk4n8yU+iucb5H+JMlxxNyOiY23qoDdftPv5Gv
	 xSI/jv0OFxQnc/i5zQBKkr8+XMH6lPr9Cj1UllkuwOP8JPOYqf9INeNvaa5pcqiBax
	 jG09wCnSinckg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPK7W4sY9z4wyh;
	Wed, 24 Apr 2024 10:07:51 +1000 (AEST)
Date: Wed, 24 Apr 2024 10:07:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the nfsd tree with the nfsd-fixes tree
Message-ID: <20240424100749.50722ad3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n8.4Y1ZhBV_UkaQ.o/Oq/YE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/n8.4Y1ZhBV_UkaQ.o/Oq/YE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nfsd tree got a conflict in:

  fs/nfsd/nfs4callback.c

between commits:

  173936c54b8f ("Revert "NFSD: Reschedule CB operations when backchannel rp=
c_clnt is shut down"")
  7d32b207859f ("Revert "NFSD: Convert the callback workqueue to use delaye=
d_work"")

from the nfsd-fixes tree and commit:

  7c33236d7e12 ("NFSD: Move callback_wq into struct nfs4_client")

from the nfsd tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfsd/nfs4callback.c
index e88aca0c6e8e,cf87ace7a1b0..000000000000
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@@ -978,12 -978,22 +978,12 @@@ static int max_cb_time(struct net *net
  	return max(((u32)nn->nfsd4_lease)/10, 1u) * HZ;
  }
 =20
- static struct workqueue_struct *callback_wq;
-=20
  static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
  {
- 	trace_nfsd_cb_queue(cb->cb_clp, cb);
- 	return queue_work(callback_wq, &cb->cb_work);
+ 	struct nfs4_client *clp =3D cb->cb_clp;
+=20
+ 	trace_nfsd_cb_queue(clp, cb);
 -	return queue_delayed_work(clp->cl_callback_wq, &cb->cb_work, 0);
 -}
 -
 -static void nfsd4_queue_cb_delayed(struct nfsd4_callback *cb,
 -				   unsigned long msecs)
 -{
 -	struct nfs4_client *clp =3D cb->cb_clp;
 -
 -	trace_nfsd_cb_queue(clp, cb);
 -	queue_delayed_work(clp->cl_callback_wq, &cb->cb_work,
 -			   msecs_to_jiffies(msecs));
++	return queue_work(clp->cl_callback_wq, &cb->cb_work);
  }
 =20
  static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)

--Sig_/n8.4Y1ZhBV_UkaQ.o/Oq/YE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYoTVUACgkQAVBC80lX
0Gxktwf+M9xXo2AibnbLX3JlhH0PCZ3RcyXamAiSik9Hvpkh+K6h95YpRjR5xK/2
MahA8HTV9XTz6Z8kL4Kg0GbJQTEmeActsMLS2miJVB/BhMJgieVxI9ygx4f/Wf0T
RFIchQW9uCmykodBPqltxECxcM1tlNJdA8KUiv2NszGjCIuZySlBt1Q5Jsj0xuIz
SYg+oaOa/Gl7vfjite/20vViaCDTVoVHiMQj4sIKzgcFutMPxW7e9EjDqHgDbe6g
GYPyUCPh5a3639939GGDrsX0uyUkdGrKaMXkVQr0ASxaywQ/7w1ZS2OaclL0hvmu
2gdnALQ3MNzLJ14k4efBRvnhtC9kQQ==
=QMsX
-----END PGP SIGNATURE-----

--Sig_/n8.4Y1ZhBV_UkaQ.o/Oq/YE--

