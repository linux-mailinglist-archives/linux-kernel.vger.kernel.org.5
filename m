Return-Path: <linux-kernel+bounces-17464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2C824D95
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489391C21D51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA105255;
	Fri,  5 Jan 2024 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AAtIi2Ei"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5E522C;
	Fri,  5 Jan 2024 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704427597;
	bh=eexsCRR0vFhYtSyAyhCPE/A7PMuaV9PMVzYADLl9gM8=;
	h=Date:From:To:Cc:Subject:From;
	b=AAtIi2EiZjC/PKahHYHkQO4wO0NWmitSPIp1f+zlU2tr6yn3xd5jie1z/No3FIL91
	 eU6U9z1htijYpfS2LTzIMzZA7AgxgcJ0bgSylN+pSflWsdLBW4fF/u5ji8KfCxTyZk
	 kkEhewNwoDYRyZ6O8Ky0hBplOi79uDyDx7IsiqS00n76bpvgweWl7B/Ri15vmhob5i
	 ntYEVm4oVVGGGvSTOEKaHQWtaWilkavQfs7WXpYTZz1uXxhJFgGk1fhjoGr2HlMcn+
	 Tx0iErBzIuA55LS76Alb02UOy2pcgDgWzVXjd9QqwLRWRb3GvsGuirshF/yFW7gYF0
	 WvkQX8sH+OyYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5qdn0d7zz4wcg;
	Fri,  5 Jan 2024 15:06:36 +1100 (AEDT)
Date: Fri, 5 Jan 2024 15:06:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vhost tree
Message-ID: <20240105150635.2bdc667e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FJjWhmfKghEt2Z_rZ=b6iYP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FJjWhmfKghEt2Z_rZ=b6iYP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the net tree as a different commit
(but the same patch):

  d2c4f1928a3f ("virtio_net: fix missing dma unmap for resize")

This is commit

  2311e06b9bf3 ("virtio_net: fix missing dma unmap for resize")

in the net tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/FJjWhmfKghEt2Z_rZ=b6iYP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXgEsACgkQAVBC80lX
0GyHdAf/SdX8yVbM3Nlw1DxZTNBYg4COvs8JFI+2/AHBH9bb8IDPqcmqZUNR51+Q
yxZ8W/Rr05OslvMGY9GGrl5WWCnItVKdb7yYrOvIH8p0AwAytr5jOmypmyO6iszo
1DqLV7eZlDbAh+PFjHfHA+UbXfFJkW2NhKDkE6JFds/f4as/Kli03uUIhKOaeEUF
BKe2rzuMu94RjTLENZ2J3fBkTVCqyVHVnqJ3vLqNgR1zqAnUUJhv0F8bHqlRJH+I
1M7/A3IxClO5BBaVYbAH/LmjrC+992xuGNJNMsts7w/8qB2Wt/M0r+s0IS3LV5yl
X2J23tp0i6LBlxL1DnUGWy9Nt5A0Hw==
=s94k
-----END PGP SIGNATURE-----

--Sig_/FJjWhmfKghEt2Z_rZ=b6iYP--

