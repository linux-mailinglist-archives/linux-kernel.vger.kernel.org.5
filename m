Return-Path: <linux-kernel+bounces-86105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D486BFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEDF1C22B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF0376EC;
	Thu, 29 Feb 2024 03:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XcSg23SD"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496D2E622;
	Thu, 29 Feb 2024 03:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178948; cv=none; b=ZEBdpvTS0pWIrW43M97ewMdBVY8xmjoC4UoimiKxM8NzWTI7KJO9fqnaJ3yIjVKybOwFq1nRR7+v4dKWEVmqHHDvu01JVmrgZDYzgNcWngOqWWLlK0uHckXxt9bCyLLRQlFsoNM8+fqvJI5UFTnwMSIlaKbJCo8aBEbgIGcgQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178948; c=relaxed/simple;
	bh=M+UWb7fNySUL+AJldbjJw5JJRDjm5EIMuTngT6A0PZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=a6PgMZF7xbDXBcmEHBaomKjNS9ctv5P+5u/iK457EGRihZDTxrzItcbIssW1Ux2tt4Ig0p6AhM3U6LtxFoW/jMoFyQI+whsJvtDj88P6LT263dpe8nxNeNBHUsX45jw+ryQTkPsvTxtK41INdJalj8cSn4K91nfOJbyi4bBu51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=XcSg23SD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709178933;
	bh=OpNbp8d1YF2XW6sykFctPdcp+rmpSt/kHysKtQHWJfo=;
	h=Date:From:To:Cc:Subject:From;
	b=XcSg23SDi2boLI01u39sSDAorBfJC8QVJiHGGr4UGbYNqYmcijtbp6+oehiWaifrY
	 x2fu5MHcZX0gYMpGNYKKXF/CQGCi3EtzGiUCNTpHMBLvndhUK+lQYpXpf2PefFmqa4
	 O/y59kV9XJvCmTKsTp3X0/jhlPKG11pRMisdVJxfI4+kVXwIVWVdxH5T8U655mhcyq
	 CW4o7aWYCYvZa7wzSNqUAoQXZUS4Vn75PRP7NQ8ElKydp78O3yICcPBG0d2gE58vz5
	 MD2B9/XL8vr/LdID7b+LOjV1wj+nCjX++5ll+Qq+xznrvFiGTxZcnd6B3mGD/C79sP
	 pjLfdepX+wsOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tlcnc3mB4z4wc5;
	Thu, 29 Feb 2024 14:55:32 +1100 (AEDT)
Date: Thu, 29 Feb 2024 14:55:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vhost tree
Message-ID: <20240229145531.7f7369cb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hs+KkPLtLZI=Xg3e3us3Wyd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hs+KkPLtLZI=Xg3e3us3Wyd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/virtio/virtio_pci_modern.c: In function 'vp_modern_create_avq':
drivers/virtio/virtio_pci_modern.c:755:34: warning: passing argument 5 of '=
vp_dev->setup_vq' makes integer from pointer without a cast [-Wint-conversi=
on]
  755 |                               avq->name, NULL, VIRTIO_MSI_NO_VECTOR=
);
      |                               ~~~^~~~~~
      |                                  |
      |                                  char *
drivers/virtio/virtio_pci_modern.c:755:34: note: expected 'u16' {aka 'short=
 unsigned int'} but argument is of type 'char *'
drivers/virtio/virtio_pci_modern.c:754:14: error: too many arguments to fun=
ction 'vp_dev->setup_vq'
  754 |         vq =3D vp_dev->setup_vq(vp_dev, &vp_dev->admin_vq.info, avq=
->vq_index, NULL,
      |              ^~~~~~

Caused by commit

  4cceb2591a87 ("virtio: find_vqs: pass struct instead of multi parameters")

I have used the vhost tree from next-20240228 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/hs+KkPLtLZI=Xg3e3us3Wyd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXgADMACgkQAVBC80lX
0GypqQf/ZcwTFzT6yNpK29vWn3UgEfYUf2/epE7q6RyCpjZfvDzHUo26T4Ill5ZC
s/vw3LEI9nGa69rzOn0SJ0noj5INJIbJeXRgVbftJ5jXAoE9DUdzwJ9TcEekdk2/
dF44XbqiNbQs1bejwHXvsGvw/g9hb2u5IWfD88H7hN4FBQNe7aWh1Qcp4K21fmh4
Bra4g533XQJuukt8qs8AT70FMbTvAnS85yT538mU+68rrx9M1DFCX3TCQXUpqHq9
eMhjPU3Sw6aVkMIUai8RRkv8i6zOtLjvVSqK0rVWjTF5/wPFMunIPdmELgCUiPyf
/sKeeN5sQgKQu9+oPeEDUZUxjdjXhA==
=eY1t
-----END PGP SIGNATURE-----

--Sig_/hs+KkPLtLZI=Xg3e3us3Wyd--

