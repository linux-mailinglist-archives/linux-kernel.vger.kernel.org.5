Return-Path: <linux-kernel+bounces-87639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE3A86D6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8846B1F24909
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7348D74C10;
	Thu, 29 Feb 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jd3ijOUY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339446D53D;
	Thu, 29 Feb 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245567; cv=none; b=CsMwGrgXoyvBSsvmncjqHxIt+b2Dr105siuxYuN65i1Kh+/WwA0nrH3EwROnLX4j0PAvTwjtoDtUa1uxNm3m/26IydXn6E3PL9/5EsJhjAi/iitbwHZA02wUxKON0iPWW6LrcrUZmGDZhXVR1VsE7TCGruGiQsPN/qytoniPffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245567; c=relaxed/simple;
	bh=E9m6Zo8Uif+WnkraC5S4fEqqz9edJTPoUmJDKqarSS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=j5Kr3ScZSlvupXwJ0IFbr1Hj+qR5tjdXfZZKmwahs1/52AYvTcGq49G4NrXmLoLPG8rPegOZHTLbacfjVB+NNkhurZazwaWW5JBJ/LTPJI0UEo0oSaqjE9VNXt0EDDNAnJuntmFeh0KUIMF+m02nZNKibbU6aR+0KYoKP2IEqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jd3ijOUY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709245560;
	bh=0n1bA5SiHK2wBetkmMJKfRWf3uRLRYvi88heuEZlT08=;
	h=Date:From:To:Cc:Subject:From;
	b=jd3ijOUYM0tpU3c9banalfBj3YK62CzhRQjD4wm1mUARbBD65ir1BzSVHiRiv9W5u
	 z6EgOpsXdlN4wJIvSyi5vw6Eak25zjNT0L2oogZjQTxL4fcUzs7f2/5ZEOFDzu4sZY
	 RVKhQsWZwgm5iPpOJMd6VjVm5YpkirWzjXLH9pixyMIl/t0zJUTQpcHUpOlLefvUms
	 +/IrbIhccYJiRl8iv3RnNIHItfcLDhLnr+41IqK++m9uCPyf2r6mSg4ePmsZ2KUDEK
	 3XNZOiUdFW9T02b6AGqQHd4rK5xyswDKFlG3cXflOjUy+nuJ686yd8KB9S3DWzeZ4N
	 P0IJZszdaVmMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tm5Qw3v78z4wc6;
	Fri,  1 Mar 2024 09:26:00 +1100 (AEDT)
Date: Fri, 1 Mar 2024 09:25:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20240301092539.584c26b7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fz6vq1oknyxue1rEE73yG/l";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fz6vq1oknyxue1rEE73yG/l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  2d958ee64d5e ("Bluetooth: qca: Fix triggering coredump implementation")
  30a746ee2438 ("Bluetooth: Enforce validation on max value of connection i=
nterval")
  464f888b0534 ("Bluetooth: hci_sync: Check the correct flag before startin=
g a scan")
  5197b25a3803 ("Bluetooth: hci_sync: Fix accept_list when attempting to su=
spend")
  51fda2df0c7a ("Bluetooth: mgmt: Fix limited discoverable off timeout")
  571dd44ebd09 ("Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR")
  5befbb8e4260 ("Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUE=
ST")
  83fd7383955f ("Bluetooth: hci_bcm4377: do not mark valid bd_addr as inval=
id")
  b44647f271b1 ("Bluetooth: Avoid potential use-after-free in hci_error_res=
et")
  c64e95bdf43b ("Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_secu=
rity")
  dae9093faed4 ("Bluetooth: qca: Fix wrong event type for patch config comm=
and")
  e8aacc745769 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in =
DT")

--=20
Cheers,
Stephen Rothwell

--Sig_/fz6vq1oknyxue1rEE73yG/l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhBGMACgkQAVBC80lX
0GzhywgAlsozYk9dDmcDsEh+LYKKxM2GkRHJGK0NyHhvZyycJncgy5S6dc5BjNNC
Dg1t2msAJhJrCkroVoSTNjEGuH1HZl3PQvtZ0Hj41SC67oV4DIFTHi29ddWZrfAs
5XKz/BvyXWKlDHR4lGZU5JOnEuYCdgefLIjkQJYuVsXfT9AeubETmtVVi36anNXx
WpsH40u+2lXqbQEmpzkCk5r0QMM22rMHQ9trx2WjKQ3xGQ8Ola8STq14EBxA9nXa
aGDt/o72ZnN1hHnrmIozO0JsjH15VKNp1MF7HcQ2v8d2wSS6LVnEL+IRWDr2Mirl
nTDw3doGUzcrmIa7oCRM9+iVxdEAmA==
=/tlo
-----END PGP SIGNATURE-----

--Sig_/fz6vq1oknyxue1rEE73yG/l--

