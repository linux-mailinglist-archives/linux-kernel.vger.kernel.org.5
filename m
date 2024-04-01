Return-Path: <linux-kernel+bounces-127183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F18947CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0181C2197B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5D5730A;
	Mon,  1 Apr 2024 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qsQszD+6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8656B91;
	Mon,  1 Apr 2024 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014634; cv=none; b=bK5iZe6oICzeCA+vdf7uqJYZpb3c2v9YDwrKBlFUeiQxMZn4jn9cW7dVVX2m0Z2fRwThMmPMOezT4tPuWvLiZhEgjVU3BsNic0PJ5U3R9G8oiC33P4rhKILTNnyHqbrEjceWPSaEBOsrre2Y+Sd0fI7zQIzx/zM7GWlN9XK/0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014634; c=relaxed/simple;
	bh=cxQWEl2bXe1KXR4K9NXaIPfSpa9M5S9NI7JMYsGlyL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IjXtooratMbHixtOMNoGbRQ4K59hcQ+vcrlnyppeIiSmAy5l8EXVgY6XUIsNCvyLjjuw4ypJ4KbjcgRWDLUZHMLan+4aP4fN6murw1YjwekFabVKqkZXdDsTnVXw9ptyft0/1JozTagraKmL9Tb1ykhWzfWzEl/AsjZIDVZvODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qsQszD+6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712014630;
	bh=7N1IadMbQesE6rixW+2z5mzW3WljWUZ1MS6lgFxh57w=;
	h=Date:From:To:Cc:Subject:From;
	b=qsQszD+6MQ6cWYjGx0ywaxMwIN9tLnPESKCBmKB9iBZfX+lbB+Ujt0djbeGFrzpjS
	 RDtIuicGQO3QvIGG9POMY/gsI2Qu9sPRASXm7NDKHJ3anXYIUG460nbbWxeIHAgFnL
	 ka967qPlMQLxuvpmgq8yNdlz+FglVuSpWJeNXtGHRsw0b54j+OI7PWbuoDH1apVprQ
	 7myFHBEpCY7AePNAnpOdiQCCMXrJV4poaPQn4tMxmxSVWSY2RVevCtlC/Nu30jOgVB
	 KyE1rNANH6+n0mqhHu/D1+t7FW3vfNNDE05+tyK2aZI/PrirmlIQenY51pj+p7ieRL
	 rYVrNmrppN1uQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7nVG46bvz4wxt;
	Tue,  2 Apr 2024 10:37:10 +1100 (AEDT)
Date: Tue, 2 Apr 2024 10:37:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20240402103708.0b157270@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2jGNmjQ/t8ctfUBKS5mkfp.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2jGNmjQ/t8ctfUBKS5mkfp.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the net tree as different commits
(but the same patches):

  019b9f7b4ed6 ("dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'=
")
  19b8ed600761 ("Bluetooth: add quirk for broken address properties")
  1c3366abdbe8 ("Bluetooth: hci_sync: Fix not checking error on hci_cmd_syn=
c_cancel_sync")
  399a043aaa60 ("Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode ex=
ists in DT"")
  a2a52ae8fe1f ("Bluetooth: hci_event: set the conn encrypted before conn e=
stablishes")
  b8f2609aee86 ("arm64: dts: qcom: sc7180-trogdor: mark bluetooth address a=
s broken")
  d39a2734bf62 ("Bluetooth: qca: fix device-address endianness")
  db4597cc88b2 ("Bluetooth: Fix TOCTOU in HCI debugfs implementation")

--=20
Cheers,
Stephen Rothwell

--Sig_/2jGNmjQ/t8ctfUBKS5mkfp.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLRSQACgkQAVBC80lX
0GxZCQf/fJ8ramxfTGt/LFQmUXPkCv6czPN1FTbrQOYYrKH69q2NCqrAJ3MaruUq
GmEJ/44EkVVwf3rhpHdjhHmbSrnyuD2xXmaDZuD7g0xdfXw5S1/TVqAvsmPqwZij
A8IAai2CWyBvyDjujz6y20HWokFofbW1pfUlflkpRwYVuSZeMgQ57V6SfjPQSrVy
LfagZu7GDdZ3cY2Oyrx6gwsYdnmvwcaLTA+W0bMBJvCvP0F4hXXlfuwEc2W0R1DE
wr1CwjRDMxeMTUH+Tv4zrDcLRVCqsU5YwyA15VUvvlLcKGPgEgFT1FCtJ+pGsIdd
dIZvUY3nvErOff2BOUA8brvnauCGrA==
=Z7yN
-----END PGP SIGNATURE-----

--Sig_/2jGNmjQ/t8ctfUBKS5mkfp.--

