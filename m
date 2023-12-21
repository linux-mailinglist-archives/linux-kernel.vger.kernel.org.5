Return-Path: <linux-kernel+bounces-9092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B6281C05F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C601C23ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21BD7763A;
	Thu, 21 Dec 2023 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h2J3pc0d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9E768EF;
	Thu, 21 Dec 2023 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703194881;
	bh=LLwn0bXTzEtLZgXJFyrR3N2SO0obanZicVjfnAtabY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h2J3pc0dezuHGyBx9ILXQdBVbip9cMvAV0c5L4jNW/TwqWUHeoF/HNqMlCZHv4DdX
	 I7RQ9M59jtMOXlmGbvh7InQSlA6Lvn1EAiQi1FKLsxaLKSlUXvMIBalPyk5hqtDV8g
	 TRQco/5kEtu24kUtXQUzagE1ITRjyqRLlpRUziNv4Udk9SBOV+mS3OuM817ytu/Uni
	 UPsCHSubStJ31WaiWyPpmgP9btO+0MelRGqBg8Z7A7GgBPb/n3nJU8NYa/K9yZpzY1
	 c5PK9s0OKfFoYzQe99ko4aEY39KaxzQ5bt5oRErRfTmVCF4HQMbMmeqOMTmZ48wwNm
	 ++DMU4U0xAKDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx3lj0cmHz4xNG;
	Fri, 22 Dec 2023 08:41:20 +1100 (AEDT)
Date: Fri, 22 Dec 2023 08:41:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20231222084120.2700e077@canb.auug.org.au>
In-Reply-To: <20231221122425.5bcaee70@canb.auug.org.au>
References: <20231221122425.5bcaee70@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wf7ME7ys3kMae_t9=Xb6gOF";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Wf7ME7ys3kMae_t9=Xb6gOF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 21 Dec 2023 12:24:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> The following commits are also in the net tree as different commits
> (but the same patches):
>=20
>   01edddb9f366 ("Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis")
>   27a4852d53c1 ("Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY=
 has been sent")
>   315a4c9045df ("Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_r=
ecvmsg")
>   37044639ad5e ("Bluetooth: hci_event: shut up a false-positive warning")
>   6ab75888baf7 ("Bluetooth: MGMT/SMP: Fix address type when using SMP ove=
r BREDR/LE")
>   8127ee3d7e0f ("Bluetooth: Fix not notifying when connection encryption =
changes")
>   8d79bc35fb81 ("Bluetooth: Fix deadlock in vhci_send_frame")
>   aaa600f30fad ("Bluetooth: Add more enc key size check")
>   b207711da3d7 ("Bluetooth: L2CAP: Send reject on command corrupted reque=
st")

These are now duplicating commits in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wf7ME7ys3kMae_t9=Xb6gOF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWEsQAACgkQAVBC80lX
0Gwyrwf/VF3T8NPf0gjFL/oMwa0JveXBwLhmYFnyh+s+eBtDOpaOP8z5j7IWEVFl
qdfV2+3Hx9PPfcmjdEpmx9/WqvYzapciOPNGT/3SUqg297te0FLEPrm/Jvy8gkh/
QiyElLR4fFYbOjtm6BWRgDWM43PRGw63MdKQLY6Ij+h8QfScwd3icJmuLhPf8mQ2
JC6xej8Kyu1A5FnXikhE7du+EX78M9SIK9sMJKWozbuxy8npzUsFAOrvreIvh0jI
9v+xMM93Wtyz8O4r0/u8TtCjpB2Ebyvn54utugB3p00zhzRd3bYTGhuxRf/ufMKi
OK/DNwD9ivWaSftQN1J8M3dvO5CCDA==
=+Z/8
-----END PGP SIGNATURE-----

--Sig_/Wf7ME7ys3kMae_t9=Xb6gOF--

