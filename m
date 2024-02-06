Return-Path: <linux-kernel+bounces-55671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C81784BFC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8C11C22E29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64B1CF8B;
	Tue,  6 Feb 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AzbJ8oAW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B81BF54;
	Tue,  6 Feb 2024 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257115; cv=none; b=WlUBdbGrjDIqSBtBFUhJz9qQF4BlmduNpEL6pWVJTXfjuPaEA3iPrzzpvMqR2zVCRXQ4VFZir90zSZvVDcdqRt53zbHWtOUVyni19nK6OCKO20F1ZMCseMQeL/9zpxW58OipDWYwpFz8kWuaqgccqs7pqVYajoZvYWMkr/UxnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257115; c=relaxed/simple;
	bh=pLx45ZyN16CoVvyCmAES3lZN6QuPwJOPZMLTntdQ++A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei0+4HA9DGFyhh58W9dgV4jJU1nI18/7/j5ki66G8lnVdMiEV2FmjPTFm8w0iuXzzrHr+qc01VTft88IyBjVEqWp4GuvYsbEz/k1+W9Q5YR/dIvrI4z/rC65BM7KS9eQIMnvPF3hSlIfJRZ6q/uE7IF2+xo9Nj3SgZtXAnQUyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=AzbJ8oAW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707257106;
	bh=pLx45ZyN16CoVvyCmAES3lZN6QuPwJOPZMLTntdQ++A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AzbJ8oAWaf/4CMmlwT49aWVBz5WWZurnJ98jL/jRxSgunDt4Th5fAd+oiGBslr+02
	 gWf7w320c/LuivZG6Q5XsILFYcMehKnuKFzyr3gxPPDarSN3hNVP3mKGTg941YLUpL
	 eh1yX+ahlyPMPEJnndN8XVI8q3HmYpH0qdFB98i+2s0T5psLS+v/+O7rJz+OLXvek+
	 N1miqIsZEhNMW1Jof2ifU+5sIiYFF5DFl6/a8Ubb6MOmeFTnnJN/UqgSU21EI9ZP5T
	 jr4IddBThKJ9NvzTNSBvDVWzKG4up9ij+9+hrc5Tb5KHw60SGzaK/r5k7U33s6AZpj
	 xuwqnW3gyLXtg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTy3Q3BNCz4wcR;
	Wed,  7 Feb 2024 09:05:06 +1100 (AEDT)
Date: Wed, 7 Feb 2024 09:05:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: Re: MediaTek for-next: Replace matthias.bgg tree with mediatek
Message-ID: <20240207090505.515d8977@canb.auug.org.au>
In-Reply-To: <00a81be6-7dd7-4959-b1dc-eb94022bf0e5@kernel.org>
References: <00a81be6-7dd7-4959-b1dc-eb94022bf0e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//kqB9L+dqKQom4VAqEr07Kq";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//kqB9L+dqKQom4VAqEr07Kq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Tue, 6 Feb 2024 11:08:25 +0100 AngeloGioacchino Del Regno <angelogioacch=
ino.delregno@kernel.org> wrote:
>
> A while ago we migrated the MediaTek SoC trees from Matthias' GIT repo to=
 the new
> MediaTek collaborative one. I just noticed that the linux-next branch did=
n't get
> replaced (we didn't tell you anything about it, so that's our bad!).
>=20
> Can you please replace the tracked for-next branch?
>=20
> ...The old one, to remove, is:
> git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git#for-=
next
>=20
> ...the new one, to add, is:
> git://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git#for-next

Done.

I have only Matthias listed as a contact for that tree, should I add anyone
else?

--=20
Cheers,
Stephen Rothwell

--Sig_//kqB9L+dqKQom4VAqEr07Kq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXCrREACgkQAVBC80lX
0Gw1Zwf8DBARVS5WGVz//g7J2GVrsXBFlFObC3KucMu6kepa5X3LbqYRhQokYA0N
Ja4nAN+xfl88fC+4IJN4dFICOKwgE2Uuu9PpcLu8fjJE6rVWJemA9o/TzV5kwmIM
jBenYR8HW7LVklJVcGbZlYTdPkGbBiOeaVYru3e++v9dEchAdtKCLX/XIRASMZ/P
A7vMqClMWjjpQZwaueH5jO/+UlZ7uUi44jO+hEEei8Hh+CF/OiUFUcOfqunedhFq
j/dMxf6L47CiVlybvAiN04Y6AkR/Ebq+5rggY1cbSoApAreyAac5DuVyoeQqi2Lb
T6frGdnUjs/R0Ko2+Juh5i0xu5jQGA==
=VFwn
-----END PGP SIGNATURE-----

--Sig_//kqB9L+dqKQom4VAqEr07Kq--

