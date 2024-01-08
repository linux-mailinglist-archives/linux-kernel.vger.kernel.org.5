Return-Path: <linux-kernel+bounces-19085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED098267AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A513281DFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10C849C;
	Mon,  8 Jan 2024 05:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bL66XsM4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCF7465;
	Mon,  8 Jan 2024 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704690143;
	bh=jGUxO4zFaWo/dDYsN94y27oanYz2Av2c4pEPFEnC+Bg=;
	h=Date:From:To:Cc:Subject:From;
	b=bL66XsM4clkMI9moRBzucScVNAvYPSKkMvbMUGjW1EjQYDILRn2n6WpyGVoE/8X2b
	 e5a5DmOUNe4NdqSYHmmNgBhLyOqdss/PE/GYHnfhEd32++Kzve985cftdQyUetLIaD
	 Zs1Xeg4oWHuEvdUfTboWJFp8Iu7sYbNHTzb/ks+9oLAePPUm5kzomTjU6tAbUDOue6
	 gYWjEj0JP1MbQqPVphAINsAx/hEs748QKilGEAwg4FaGwozIobRcmmKW9VMWtdRpf1
	 OX/Ca9HCuShAL9yNY7j92cOcpjk9/47BwvTjVPNjvGg+5eOaZdOy6Zq7vEOgeLy5X9
	 7I8of8XlpgaGQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7hkl3SYrz4wd4;
	Mon,  8 Jan 2024 16:02:23 +1100 (AEDT)
Date: Mon, 8 Jan 2024 16:02:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krishna Kurapati
 <quic_kriskura@quicinc.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the usb tree
Message-ID: <20240108160221.743649b5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oXYenmHC0WV=+bWIswrv1t7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oXYenmHC0WV=+bWIswrv1t7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
Text in column margin in table line 9.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ifname            network device interface name associated with this
                  function instance
qmult             queue length multiplier for high and super speed
host_addr         MAC address of host's end of this
                  Ethernet over USB link
dev_addr          MAC address of device's end of this
                  Ethernet over USB link
max_segment_size  Segment size required for P2P connections. This
                  will set MTU to (max_segment_size - 14 bytes)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize vi=
a configfs")

--=20
Cheers,
Stephen Rothwell

--Sig_/oXYenmHC0WV=+bWIswrv1t7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbgd0ACgkQAVBC80lX
0Gx90gf9GC+XJKEdL4OiEaYuzG60iuJgu732PGq5SzeUzGbmqgvCHD9HWD8xXNGW
65rcI4beQhl/5Av3p7aEeX9omdx5qeXG+qsfN2aI5lV0KCAlDHPcF+VH3SbCaJL5
DQs3t5lo7VTbskKzbDN6AwsqaJPoBZ/Vb1Li0bRrRjF8wZt+OFyTsrUos1satpRM
hdEG0XTKOupr2TFCznpLGeZTl8PD/9ny/+hQNMEEWqip1qK0mOn8Nsr2r0MPwsMC
sder4vbpdyjwTE3B9qmCtEvpzXLNyQtBbgeDPn/97wm7zLrJXV7YzNLpxBoC5Yhy
XHohdgqNiaoeriRx7ZJMaL8k9J0Egw==
=1Z0Z
-----END PGP SIGNATURE-----

--Sig_/oXYenmHC0WV=+bWIswrv1t7--

