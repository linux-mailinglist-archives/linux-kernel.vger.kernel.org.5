Return-Path: <linux-kernel+bounces-7724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B354881AC23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E361F2465A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C894687;
	Thu, 21 Dec 2023 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Uy/hUfDo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE74416;
	Thu, 21 Dec 2023 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703121866;
	bh=7HruLS3pnjwdqjD9+moXiNuhk8TxV6jN/qCcNvU/C+g=;
	h=Date:From:To:Cc:Subject:From;
	b=Uy/hUfDogK2T4i2ujzVsJ+8rOQyXwKEIhsNgWdi5AnYrSdF40wCG53c2oJlF4lUdW
	 X0mMuwW3gKtgnGysdbIHQZGDJ6wx6tylH9c4M9/wlRQnRczQx4BfKgxgrsKmWuC0yb
	 n4q0rhRcR+D9lzlgaJzWnNvjdRwpTOmSHvaWFv2I6Y+OhYOofkuhK67bTH+IfadRcy
	 TvP8nj69d/w8ndVEeyXJP0SGXFvP/xUH4x4dw8Sh/rFqAftD5p0bSBt6Y5b0moQ3e1
	 X+AO4+eV2zmCC8t+MH7Bmv/lHbpftqypN1aySKk9LDdboWVdtsTY75eJIfZJjhdsZ6
	 Zk0ZpFNvnamtw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwXlZ2kbNz4wbn;
	Thu, 21 Dec 2023 12:24:26 +1100 (AEDT)
Date: Thu, 21 Dec 2023 12:24:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20231221122425.5bcaee70@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D9itDLbQPhqKnxCszPnFONB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/D9itDLbQPhqKnxCszPnFONB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the net tree as different commits
(but the same patches):

  01edddb9f366 ("Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis")
  27a4852d53c1 ("Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY h=
as been sent")
  315a4c9045df ("Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_rec=
vmsg")
  37044639ad5e ("Bluetooth: hci_event: shut up a false-positive warning")
  6ab75888baf7 ("Bluetooth: MGMT/SMP: Fix address type when using SMP over =
BREDR/LE")
  8127ee3d7e0f ("Bluetooth: Fix not notifying when connection encryption ch=
anges")
  8d79bc35fb81 ("Bluetooth: Fix deadlock in vhci_send_frame")
  aaa600f30fad ("Bluetooth: Add more enc key size check")
  b207711da3d7 ("Bluetooth: L2CAP: Send reject on command corrupted request=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/D9itDLbQPhqKnxCszPnFONB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWDk8kACgkQAVBC80lX
0GzOUwf+KxJbDywMVDN9LVNJgFUzLxyL+s/hIGozf0/Q2eV9gT+LYofoP1UxQag6
6UDCzBnKZLIq84Dr9NBzqK+E/G/uHfcPeKom2nqi5mvuA3MKnK42Z1yS+cYS64t2
t3Celxvkgc07b7hgtz8EGGaPiKyJwb9LPZApuIiCzo07/tLg+YgN7XyFidX6ReyQ
O1m9swnJtu7/t/2TuH/1ctA/MrvBgrY9ttMTeqaea1E7yxGj4Bfs1A1zCs8fYgQw
ffJzZRMYyp2qobYf2P+mSnDM1kX3duGh6VwojiKpJN6/5N7PV6OojlOHPYsnsitF
ZAnPB5WRzoToLb4Idtxn/qmdt0JtNA==
=abvv
-----END PGP SIGNATURE-----

--Sig_/D9itDLbQPhqKnxCszPnFONB--

