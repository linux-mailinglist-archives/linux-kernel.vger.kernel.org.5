Return-Path: <linux-kernel+bounces-50154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46438474FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36743B2BBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A11487D0;
	Fri,  2 Feb 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol+CT98m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4D1474D2;
	Fri,  2 Feb 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891771; cv=none; b=MF2tEUx4go1HjTOfDMe3NLWMR6gsPdaJYD/5tGfAt1FUVr9ZLgilFrwP1ZeAQ7A1HIRsk2tCRs3B0xZtYERS04KCFw/A1fWTrDQ1R0sWNFqUdd/yVZm+WSwJMSgXhcMMw3TH0wGnKqqb8ZdozcixB9bMrnYZ+DLpfvaP2cL6Bks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891771; c=relaxed/simple;
	bh=arzyIYOYtqrlqTyYOOX+PFd1VhqAUTVPhh5mK5F2ZKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD/FIEozkY5Y1vsk12F35wOunaXON3Xp2t4oz+VV8KUw5tj95WO6MfgYVDinB10jPEqK3yghcZYad1lUpGqLO3WMnQ2H6R9YmbkLPlRhZHU7oBpxN72pZJsjhE559uJJKC1rh7fXOobOxt9Hf/YIl+KJmSxPWeBproqB8HAL83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol+CT98m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F64C433F1;
	Fri,  2 Feb 2024 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891771;
	bh=arzyIYOYtqrlqTyYOOX+PFd1VhqAUTVPhh5mK5F2ZKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ol+CT98mOTuP5PPkbccLG/tvqVpithWKV27/5J9Y55e2H6sHCslKuRpO+0Sa/qJvM
	 QdzrP7lBLTpNYd6T/l2ml9Xlh1PXmpB7JrQyFyL5DjKxjJHG/1RNhfnzSc0RoUSxGH
	 fG6rr01SfEdgMvS+smS2CUBtNVlP4G+zfz1tIB+bImLLsf05pCsTFBxbpmL9TfK7cC
	 45ttsKyyRTHPRTUzinXPRUsk+FPhp5iYTQAJwb157plRz87BH622TDkIB4fN5cBMI+
	 8jjdgGKkKherSrF7nzszQ16IQQX9H78Z1DWTCHgw6XzT3cpvFRl2YWN1MhTI/Xg/mq
	 aLbOxVkhlZjXw==
Date: Fri, 2 Feb 2024 16:36:05 +0000
From: Conor Dooley <conor@kernel.org>
To: AS50 WTLi <WTLI@nuvoton.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Message-ID: <20240202-tripod-clumsily-ff7c19515acf@spud>
References: <20240122095650.60523-1-wtli@nuvoton.com>
 <20240122-daunting-woof-19fac5689bb2@spud>
 <04945799-eded-42f9-b8fa-8907be44c400@sirena.org.uk>
 <20240123-bottle-elevating-9fbba5424014@spud>
 <185f3912-5a92-4ef2-aac4-0df8363d8727@sirena.org.uk>
 <20240123-brewery-roving-b9ebc70468f4@spud>
 <591e12e6-117d-28b5-986c-83414ebc6b4e@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CMNQgfuuSMLBnyM2"
Content-Disposition: inline
In-Reply-To: <591e12e6-117d-28b5-986c-83414ebc6b4e@nuvoton.com>


--CMNQgfuuSMLBnyM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > At the end of the day, if it is too painful on the driver, then I'll
> > live with another enum. This is one of the worse cases of this sort of
> > enum that is clearly a bunch of register values, given there's not a
> > "nice" explanation for them.
>=20
>=20
>=20
>=20
> I will modify as follows,
>=20
> +    enum:
> +      - VDDA
> +      - VDDA*1.5
> +      - VDDA*1.6
> +      - VDDA*1.7


To be clear, since I was not in my earlier mail, you can leave this as it
was, given Mark's complaints about what the handling for it in the driver
would look like with the special characters.

Thanks,
Conor.

--CMNQgfuuSMLBnyM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0Z9QAKCRB4tDGHoIJi
0k4vAQDWeO2U42KxwOZd1oONkkxLORevf0jKg9VDOGSICLk3FQEA8ZAeCgaITd8x
PBDJw8quHX0cC54LzWTFtTppI7fDOAg=
=MoNi
-----END PGP SIGNATURE-----

--CMNQgfuuSMLBnyM2--

