Return-Path: <linux-kernel+bounces-141633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310468A20F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C426A1F243D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21433D3A2;
	Thu, 11 Apr 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b3cMzLWA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1323BBE3;
	Thu, 11 Apr 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871269; cv=none; b=cKt5wJq5BVCLbQbEyB8VcCWwDFpxndjv9jh2sahzXwh51btBYpxPEpzIizuE5BIjBX9fuNIdtompf+45rXIUs7M+L8dDRvfHanjntgIoGi2SYn59/Ok+/+9Fra6PdkIX4T9//zmkSDL7vCKRd7gR6dpaOy2Ss26ZwzetddLjDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871269; c=relaxed/simple;
	bh=W3MvQH8SSPbBSlxe8iZX890gWDzm/xPRkbtRmrpC09A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pW+1nUsyKuVIE82aJaWHNQGXjZaOoDnizwLQfc6Elr36R6/vcIQC8O4M3tPqrPgN6j56oa/oquPtLjVJIcPGY/L9ymEtrfgTGvhNJej/YEmVDyqO33jeQIpqQXmBzw4W+p9BHLDU2fA7l5U1G5w0bcgZKbAutK5qIVIpUrbmZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=b3cMzLWA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712871262;
	bh=bID0WC4uQ435fYxe8ZAH6Gg6WRcTNxszYe3iGagWjjc=;
	h=Date:From:To:Cc:Subject:From;
	b=b3cMzLWAagmgp8xd5wIGOLW0iyXDAUu7H9XQXOS2Iq8yWqNShvGBU9Hm0sxLlTZCl
	 CzxaHOhhBnYzFscXyP74egFsMXV7T20DiFBBnFSaaOCNx577WpxdK+Qss1dhh6a8SA
	 nvkjXXIwjqIogUhftus7gSgITyiCt9N0ydCnpt9sgDs9DeEcAne6t35yA+ldaScy/n
	 4UBBDzlXLERO154H99dbIeKc44FBciSGdj6Qgii82USfHqvfzXGd+ZDfUMHJZsy0I0
	 MW6JIqLrD1F4CRqGYl8FWQiP2MD3wsd2JdXjBojpKhkxqE66/3wmU2UQgVL7+1gIn9
	 fzjylRAtj7YEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFtHy0XGQz4wyS;
	Fri, 12 Apr 2024 07:34:21 +1000 (AEST)
Date: Fri, 12 Apr 2024 07:34:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20240412073420.718fa77a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fgP+r/BndnO+Gj+gzxx6AX8";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fgP+r/BndnO+Gj+gzxx6AX8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  01841038e1d2 ("Bluetooth: Fix memory leak in hci_req_sync_complete()")
  2151391668d9 ("Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are =
unset")
  289bfd91fcf2 ("Bluetooth: SCO: Fix not validating setsockopt user input")
  35d2c39b23ff ("Bluetooth: hci_sock: Fix not validating setsockopt user in=
put")
  5a5010485400 ("Bluetooth: ISO: Fix not validating setsockopt user input")
  a95f9d212d1b ("Bluetooth: L2CAP: Fix not validating setsockopt user input=
")
  b191fb7a3075 ("Bluetooth: hci_sync: Fix using the same interval and windo=
w for Coded PHY")
  e6bb15dbae90 ("Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNE=
CTED bit")
  ee77912bc0bb ("Bluetooth: RFCOMM: Fix not validating setsockopt user inpu=
t")

--=20
Cheers,
Stephen Rothwell

--Sig_/fgP+r/BndnO+Gj+gzxx6AX8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYV1wACgkQAVBC80lX
0Gw5AAf+JXMBLZycMpyAysHSYsj+XTRHq+Q9A/DDk2x6MW2R1HokcmSRcTekdYQ/
O6oP9Em9pR3mj1mdntmmwJEm+Oi01zbJz1DQL0iTYC7052IZ/P+f9n88uZ+Z3kA2
Scw/JEqx7ITsyS2XVnFm5D+9katBMscBRdfqKTIqdvn2YLJN4e4SkLEq0C/m/Lap
bY5qZq66aou9fiL22yh3KSrh++zuq2nOfPORazigNgnvJXN2bc1rTEIXHsWbzbLe
jgKXiBhGSWm5XmhjbiD/xmLbtaPqlaE0yoO6Xrt4bMGnoxOIZFDtBppn0Ng5F/CL
p8+DnSyCkLEGKZys+IdWHneLHcoM8Q==
=x0Vm
-----END PGP SIGNATURE-----

--Sig_/fgP+r/BndnO+Gj+gzxx6AX8--

