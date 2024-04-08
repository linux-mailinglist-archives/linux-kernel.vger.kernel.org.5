Return-Path: <linux-kernel+bounces-135974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1760789CE70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C190E283B1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913341EEF7;
	Mon,  8 Apr 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l2dGt1Z2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AB7462;
	Mon,  8 Apr 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615634; cv=none; b=UaIi+314JiI67oWQwTT3VhdebkkGjsFolxJw6l2XK+iCYD0oQJftITucbuY0aZZe951/gEbXtdyC0mz/B0Gx8x33z77pUTjYhLRAGWemXuwt4bmZM8tkc/cGb0XWnxRn5kRc6qxVG7X/wcgYY40DMATpXiYmwxeHYaELL/TGlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615634; c=relaxed/simple;
	bh=E810jBGAK64VhzZw3D7+umxL/CQhDPc+nvZhUihM1QI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F84FnIM0oGq+D3nA3/iUVBEg4E6M5xkNvw9epSpjnj4t2InYug94O8/p1tGglGmJ2tLEX6h5HO8eIrn52hjzgm5Kh0/FeqrIvvhqQDRAsOEhcMgyHd+l/GS2Fmybl9vKIU0NOLYEZMhB8/I47GhSvS+SM4IxRZwcqqD/BIJECW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=l2dGt1Z2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712615625;
	bh=E810jBGAK64VhzZw3D7+umxL/CQhDPc+nvZhUihM1QI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l2dGt1Z2zqvhYzv3GAf4BWYdEJ+caQ0yo2Ezhz7qJbDhvGzMadzDki21QhiS7yHal
	 oH1kwedzecbYjrHcds/JH7jO4T6rUo8EefU/ENEc67uwP55QJnX/5TgyhMGBZ39zo+
	 I+pj4GtywoS1y/lV4a9feTuvdZhiowl9FCxakMsZ+3qyDHJVvWGoaNbhY+dJ5xvxJO
	 e9Ip326LNE4JzbpAyTl9lvtFxr4vEvRyOsveEiT2sBQIw5ATz3NrKmjBKlEp1CcpPO
	 l1GIpClZsuL7bwYyHZlHhZibA2YZu6iNgwIQ6Srz0C2lDJM+pefPx5SBr2VZ2d09YA
	 VqZguOqf0RU9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VD3ls0LLFz4wb0;
	Tue,  9 Apr 2024 08:33:44 +1000 (AEST)
Date: Tue, 9 Apr 2024 08:33:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20240409083341.05419e72@canb.auug.org.au>
In-Reply-To: <00016dca-9e32-4cc1-8d0e-36eaf12dc466@intel.com>
References: <20240408141216.3eb1128c@canb.auug.org.au>
	<00016dca-9e32-4cc1-8d0e-36eaf12dc466@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JCXYvRXIXDDAmDVl3FKnaP0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/JCXYvRXIXDDAmDVl3FKnaP0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Cezary,

On Mon, 8 Apr 2024 10:24:28 +0200 Cezary Rojewski <cezary.rojewski@intel.co=
m> wrote:
>
> Thank you for the report. I do not believe the patch above is the correct=
 fix.

Sure, I just used that to get the build to work so I could continue.

> Below is the context and the proposed fix [1] has just been sent to alsa-=
devel.
>=20
> [1]: https://lore.kernel.org/alsa-devel/20240408081840.1319431-1-cezary.r=
ojewski@intel.com/

I will apply that fix from today (until it appears in the sound-asoc
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/JCXYvRXIXDDAmDVl3FKnaP0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYUcMYACgkQAVBC80lX
0GyPfAgAj2t8Dm8caIhzpi1i6yiebZqfnGf6epL+CiU2Yf5OHXHc0Z3MIzPzc3zy
o91BBks7G1RngdaqYq5Aqoa4bxpeq+EoftXUYLzhrK4xxohWQ7Vu9OKMn1FtqgGk
GbX0ULZGZwXhn/kZ8RPnTkPPq1xumT3NihjgcZQOEP6DMuaen+ABX0tc00HpGS1H
AUG5gAUmZstq/e/vVrnCitLwDughGo65zpcp8p3FYENC84/f6X2bTf63wXu7aX/i
JhHOkKJ0a5iQLDwp+Y619WfyOEM0wbVQDLCa0ZfvZcCgFVkfRw3JLVFz7RIwhkZJ
WlDvzXcR9nDMsB3V+F1hxIcpYg6cOw==
=nTFd
-----END PGP SIGNATURE-----

--Sig_/JCXYvRXIXDDAmDVl3FKnaP0--

