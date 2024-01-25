Return-Path: <linux-kernel+bounces-37825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2925983B61D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E131C22363
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61DEA9;
	Thu, 25 Jan 2024 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EuYad+ao"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173662B;
	Thu, 25 Jan 2024 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142932; cv=none; b=SXxBWHZWZCeUf2986Wyr7oIfFeyb01l8ny+NzlCHzuBb3tSDcISUMeVqMLNLY2WjMFBBVvZGSm5U3TxXsiIGllevxTgiHYcY9shmLnbUdriZ6Ei/UdLqI8VX7fvtOGsytGtjpbhW8P9IbX3APj6mBlsoLJxlIfgVP6/cT7JwojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142932; c=relaxed/simple;
	bh=pnuY73pnTk9N20u9/XkueNa08lmEBKvjn9wDYqGlZ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZ+suYEwes39VbQ6/xvqb8cbG60IsAEYuem0kZWxS1N35zc9ncvUBS3bfY07fsJQFkjwPkWnAEkaK+TmtcuunQAURdboF0ilSQFSeSEkzjiNon1zesSIWvhaCamoaP7SmhV1KVLVXXY+Vb4lZTzub96YM9mAQkwoyplOQ2n5CIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EuYad+ao; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706142928;
	bh=YIl7VTl6hGh6wuSyr02Ur9LBwD53oMGhBZ7e8gRdACY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EuYad+aog2I4BDDoK1raH31IMUskZsi93NSIxy0HWXSO2Z5i5KfrCvnf9l2p6u1kT
	 EqucPap2uxuL7UJnQ7gR/0DzFLIq5TjtFVGr18O84nAnbA5sZedhAQG09GvsPhIMQX
	 cadkMkhtaopK8eDr3z6IMeAcI28sPVBXwVSisGczlco1PUOHA4PhdO08ZPP+OjUTaG
	 hDL7WKF8dQVcdA/nEXHytAPkq4cAzYrAPdunyndpgqLqxb89a6j8j08+d94RNgDepw
	 G9Yj9MJ4w6xYkstF0XXTwouPlvk9tyIRNgpHc4HpSECiw5hmXiSIN6E1bVikmPELQe
	 9OiPUMzVZlPQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TL20w3VW3z4wc8;
	Thu, 25 Jan 2024 11:35:28 +1100 (AEDT)
Date: Thu, 25 Jan 2024 11:35:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <20240125113527.5c9fca93@canb.auug.org.au>
In-Reply-To: <2024010816-fabric-cassette-1548@gregkh>
References: <20240108160221.743649b5@canb.auug.org.au>
	<2024010816-fabric-cassette-1548@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s5Imj5dLVlAQBB2pNcOek8k";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/s5Imj5dLVlAQBB2pNcOek8k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 8 Jan 2024 08:54:39 +0100 Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jan 08, 2024 at 04:02:21PM +1100, Stephen Rothwell wrote:
> >=20
> > After merging the usb tree, today's linux-next build (htmldocs) produced
> > this warning:
> >=20
> > Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
> > Text in column margin in table line 9.
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ifname            network device interface name associated with this
> >                   function instance
> > qmult             queue length multiplier for high and super speed
> > host_addr         MAC address of host's end of this
> >                   Ethernet over USB link
> > dev_addr          MAC address of device's end of this
> >                   Ethernet over USB link
> > max_segment_size  Segment size required for P2P connections. This
> >                   will set MTU to (max_segment_size - 14 bytes)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Introduced by commit
> >=20
> >   1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSiz=
e via configfs") =20
>=20
> Krishna, can you send a fixup patch for this?

I am still seeing this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/s5Imj5dLVlAQBB2pNcOek8k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWxrM8ACgkQAVBC80lX
0GwURQf/RWJFdPXKIS85vKhCEHzniFjrERSQ+CIqdWKw3Hv0gbZb8JdyOwEPuYw1
qgNLNC2H8lwvJLkBcxlImP1SVPvEstireJzgoYmYLlpzk+uATnlPD2784351r0JP
+tPI1QZq4klNjezW2STuAAdeoauEioVDTNBgC7GZwfezAR6U/V1Ufl8BDomRgVjp
NoaGhbN6GLUGH/YVGmFYDxEuMlDd1c5U1Bn2QUCkTseGvagv/MG0vYrvHPNMqspA
Pjq2kYaIWX3dOBxpV9k+PsVzFECwmefh3h9Gs9c5v2lTC6W9tlfQLjoefPyq0oY8
fDNN8H5xCkDlDxFuBrQNhjxx0IOjiQ==
=OmB1
-----END PGP SIGNATURE-----

--Sig_/s5Imj5dLVlAQBB2pNcOek8k--

