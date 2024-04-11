Return-Path: <linux-kernel+bounces-139804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C548A07E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C8F282F92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287E13CA83;
	Thu, 11 Apr 2024 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UxCR/u/8"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F53EADD;
	Thu, 11 Apr 2024 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814531; cv=none; b=Mt7j4BqyUTlZJRqc1oKWA8U5Lt2AgISkf5l8ukNGaCyAn478yDNse/XB3xqP/P32QXjQix0Y+Vo5CVCeAF1D5i6VaL3a1gHP5lMgXMS+Jju0EVcQR6nwxRugPIxExfOxdu7mP/2fp02+/+3yJatPAmFGw0T6/PCP86BrwtNftfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814531; c=relaxed/simple;
	bh=TU8pzTL5ylH0q8/QhKcKM5ax23QULvYnckxM70k5DlE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rsbk/L1UnLy2nAwaxbyWAcP+2VayvmrqknQ/2Fnngi3ne5AtpzBaBEiqFiiGWn8UYSS3NkeWLPGXrn0Tp9g/azORxZyd/1BUCxJD1SfsT/L/AQzzjsXx5zUiZPe81q+++FKXpAuOGuJQRsbf7SI+KOsXSgLDxk8DY5VcXQe9FCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=UxCR/u/8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712814526;
	bh=0qC5A+Qpnu/8HPYh/bIaOMMtA2cfZj3qktXJKQudP6Y=;
	h=Date:From:To:Cc:Subject:From;
	b=UxCR/u/8/6Pg23CUlb5ZL2nrT1GQdVs4nrNFNovcCba3aaj6YtXdW84xrt9SqM/h5
	 5Lk8c4YCxziOwQqc6XJwiB9dvWd4CsGq/r1azFlBc+GO/gL/HfNwD5TQ1eJ68tChz7
	 OQlgz1J01lrLQ9k1X20O/P4amKrR3qzlCu5XAymA5TaXF5oIxNfHgzUIODUABBbKRS
	 ZgKjTG/PRGo9kMX5djGEG3iKwi2eR5Z2lAzynudjIPdpNEXEJwr26HqvNeZ8De3szz
	 hem+KAdO5++dLxRYV4aEOjwxmYtIlITFEV3KdIaVhS3WBkBiKcVC5McRiZVIapahOq
	 vIMB3XqcOnr+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFTJs5vW4z4wcb;
	Thu, 11 Apr 2024 15:48:45 +1000 (AEST)
Date: Thu, 11 Apr 2024 15:48:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren
 <tony@atomide.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tty tree
Message-ID: <20240411154844.5bbcde63@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GW=+TM2a5dMPle2_JFR_5oo";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GW=+TM2a5dMPle2_JFR_5oo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

ERROR: modpost: "serial_base_add_isa_preferred_console" [drivers/tty/serial=
/8250/8250.ko] undefined!

Caused by commit

  a8b04cfe7dad ("serial: 8250: Add preferred console in serial8250_isa_init=
_ports()")

I have used the tty tree from next-20240410 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/GW=+TM2a5dMPle2_JFR_5oo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXebwACgkQAVBC80lX
0Gz7+Af7Bfx7H3Oo0mVGJsBqhhGFU6paPwZR/QTYx04Ynp51I2VzTJr8/DwQGOPT
6/fr5ov3fRlkdrgirZfKhY/kO84CstLru5LSZ1PsRbMLU8QkHncI47tvE5QDVbGC
j4n73srtAcOx1yDzYmKM5z46MgqSNgp6JAfCJf093hNI5EV+nXG02k2pJ+fJ17F8
Kj8IiJf+N1ZGfiQtgIDw0hwnHK5qY6MoxHdaR3MXBEQG2ssGFYCImlUun33wbIrB
jlklFJbAs6nFM0oAn8MGJ1fE9pDEjBYBf/5S2DGkQX474bMXOFqfwxWuX0O/Hda7
NM6Rz9axAnfGFnqftnOfMSZE4gDlMg==
=NgMD
-----END PGP SIGNATURE-----

--Sig_/GW=+TM2a5dMPle2_JFR_5oo--

