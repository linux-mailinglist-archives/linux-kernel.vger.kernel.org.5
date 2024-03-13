Return-Path: <linux-kernel+bounces-102542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A087B3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8708B1F23830
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC259158;
	Wed, 13 Mar 2024 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iJ88g9MY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C95787D;
	Wed, 13 Mar 2024 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366062; cv=none; b=G970h5xWew6LXuw6ZTUklrCOUmlQw5mF8Mem+kjbi6FPU3PnaWs4D1oypwGFICxy+FYeoKzGpBDnS2znr58R1XuBG3yJlqU5CTLx6ksZsgn1UxNXIiuERlMIZA1BM+WXRQw4lTlz+X8f7E3rGa8W8MUQs51plxLnrcbyqrF3ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366062; c=relaxed/simple;
	bh=SxqjRWGD7n9bBE3YoVgb8xa4tnyqzh6D/786Rf7k8zg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Vw0zvTKb+z9vtfN8+ef3kxqoKA4x6zBoJxv+wF6o1zkNihzuF2vjyZADXlcKs4G5TaM8X9t0IU9JgZehheAtPfEv+1RQB56PRircOFequ5lwQqweutodxWsyPJOluOsfDyH1pc8qipH0H9tAFDYC+vVm18PBlUB/oWVDCmvSDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iJ88g9MY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710366052;
	bh=lN5s0tY5NPrhuMY9w//wlduHfMOojKurZ/wQGoi4/qA=;
	h=Date:From:To:Cc:Subject:From;
	b=iJ88g9MYtWPNZT3FzVM2JeTaLbKHR1w7y3V/BgfGnVvycef5QgDOT0InPbJO7nZ5x
	 R4sS2b6rck6WPj4jMjjCagofl9PwfelfuSM0o1YdB6Nq/mjN9OidnrDp6cb5GxrhU5
	 LcG2xpop6aCSvx53B9rkETbiaWzxGj+vAXnyPnoyh+E4vi/ii4/b87JMBW5vU5/gDH
	 ugkXwAtsRZfOcBVqRuh9Z5PWwxtHxVdskJa34tMCBFWo7P9UDVngD6crIQgWBxr74P
	 fUSksAGWm/qxyUX+q1z0OEUTIa3wKViiAWyhhglnsFKza6Z6Trp9WzofKisT15rY2E
	 DpSetuyPLcUBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw3pr1jYFz4wcR;
	Thu, 14 Mar 2024 08:40:52 +1100 (AEDT)
Date: Thu, 14 Mar 2024 08:40:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the device-mapper tree
Message-ID: <20240314084050.2fe3eb9f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pJoU3O.5n/8y8gkNX+fwP/D";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pJoU3O.5n/8y8gkNX+fwP/D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  2da6b3c1317e ("Revert "dm: use queue_limits_set"")

This is commit

  bff4b74625fe ("Revert "dm: use queue_limits_set"")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/pJoU3O.5n/8y8gkNX+fwP/D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXyHWIACgkQAVBC80lX
0GxB9AgAlXOG0hFLt94qOV3Bk3GvL5y95/zN0VKxRnyAPwgJkSI2i/LAPe7osIu1
JWOsM0a7ALIhnmrKuYeyy+/uW2mzX0UTTXW4QWrEtv2sOTfdYC7HL68AG7nNMloS
P9axZWrNvoSdAU16Q2H61LOK9HoRhGPnSpcy54iAW+Q+zW7PQ5HZUNQiTBrlZP87
7nsiv5OGHZNaxapkqtYA9H9i3Lr64jHoN6zg852/U2hmyfOKZFzFE22zivFgkQwg
IL7dHccYvq2ZLEPJvhFTZECtJAlqSiAhS+T1O5IEJihbsaYjdpEtV7JsJd7qcBwC
AT596DyRI8o3GuhE963MLsjnQ4F3GQ==
=kuwA
-----END PGP SIGNATURE-----

--Sig_/pJoU3O.5n/8y8gkNX+fwP/D--

