Return-Path: <linux-kernel+bounces-72141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7364185AFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F123281FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB8856B6E;
	Mon, 19 Feb 2024 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vp63fIFO"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7254F88;
	Mon, 19 Feb 2024 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708386461; cv=none; b=K0Pcwutqd4X/w+GJ5XDoLJW3Mh+PdPMCl0N8IHWfevga9ci7ZOUh5KMpJC3mOgwLlbZHKrQxXI4x4ixaLN3nIe8QKB/PRGd8oMh8p+SZzwk1RHe1ap7mq6xHb8A+3vz0ZCxF0ehEAg9DLWqpg6fNMEdlp6Tm0x+4FE7tztN9fCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708386461; c=relaxed/simple;
	bh=BoVuk4vYVH1KQiewU9Rb/pfiM4VbOHHnHGr1G2X81tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RSdoFE+LpOhlCiPHvZOnQ6KO6LaUX83EXonRMXxLbUiUzwlBkLg00VXm2T8R7njclY92eakgQauOpJn008aOh5ErTGRwrSu2BScxpWHQcF5+l429LolJHy3U1FleyI2ACXV51YlY3w/BdZEwQItP1daz19eLgpxfPE4fUYhtetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Vp63fIFO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708386455;
	bh=xpo4e8w1Thae4/drj+3nMzTBEU1APmbxscTSnLgVPF4=;
	h=Date:From:To:Cc:Subject:From;
	b=Vp63fIFOmaKlCVtUDMYsZVcabjKZaA/osntOnWZy4iMs7ocJWnKgbtq5j4Oe3Wexc
	 2uLogmq5Y9yAH0qokm4xpXUtFY5jsqSmuiAzSqGxhlVh7YxarYMwa75grKzGVKBEh7
	 sRJaIgjQTKiJN4hRZSDHM/a6c47KFkVopg+bIDM7s7SkiX77s6TY2m8v68gN5DdJbY
	 AQ0elX5/e4Su/AGXYZPDl1xpnUjZ9StJd78l3uD1F+ACbRxb6Uh42fTNMW10juJIpu
	 SaDEugv8hWzbbMGEx2nvJnqy56TszOYGg/Ro133WPdlOYoaXYCbncYgQxD99L90uYf
	 GEu/ZJuZyAwRg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tdzjg59rCz4wbp;
	Tue, 20 Feb 2024 10:47:35 +1100 (AEDT)
Date: Tue, 20 Feb 2024 10:47:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20240220104733.62aa45d3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HDTYqCsE=Fe9fA7uk0JCPfH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/HDTYqCsE=Fe9fA7uk0JCPfH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  01e165497ea7 ("btrfs: defrag: avoid unnecessary defrag caused by incorrec=
t extent size")
  da4cb9663e2f ("btrfs: fix deadlock with fiemap and extent locking")
  ffdc36daabf2 ("btrfs: do not skip re-registration for the mounted device")

--=20
Cheers,
Stephen Rothwell

--Sig_/HDTYqCsE=Fe9fA7uk0JCPfH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXT6JUACgkQAVBC80lX
0GxJGggAg0XCCIVahj+ypdh4s9dVqfCHC0sdRDIXZYEa09Dl2uLZc886NgJ2CaKu
/rC8eEJO789TyeyDiXIhKaXWlzEvn+GeerMs6gG7w7LqXBb9wcnmBJ9PRgxDfaIn
GlAUmq60Khnnsx/HZuXkK7n68+0k734i5jkZrXwH2uq7pjivXwVbV2pQNv7Ba/GK
sUOigG97CbwPgbmKYx0qr4mOkX5cyrHRf3enF0AV7vvXKd/ZynPcSgFoSbx9ksou
fmtDMTH+67nNNWPsOTISGDDBfOOmq1pc9d+lenlhEqi9q4fUvXsURTb+LyF6sOEF
+6cQhaACLGmyLL7SZufqPgNCgcQazA==
=LFPB
-----END PGP SIGNATURE-----

--Sig_/HDTYqCsE=Fe9fA7uk0JCPfH--

