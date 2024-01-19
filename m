Return-Path: <linux-kernel+bounces-31382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB68832D87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1BB28114F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7599A5579A;
	Fri, 19 Jan 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYj2yylc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA855779;
	Fri, 19 Jan 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683282; cv=none; b=Arb032wR+mT3ca9KJb/eke2V3OIA0TDqhOi0Sb0FOUp/2zbm1TuSMUumOIFDm4dCkA0CBaUmRjsMQX84/W6/bxWlvkhEMs7u5w5CjD6J7HGQN3PKwcFA4y0DvU6Ekr3gpbYgPrrT3IgNasRtgBrq6e5vrXKhVwhIDUs7quUUbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683282; c=relaxed/simple;
	bh=VF1Z6l0IbpzY9s0IFYKQ4DO9qjHRXBU3M4HJxWlGq40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy8jJDkzqNAOExvTUJr7KBXuCxDdAAYzoapPevmCRYhAdJCHyweGryXDBdpZPCFsIYA9jQfMfTn+tJV5xQ5aJCh0QckJoPnBaaQgtOC8R1Y0ep7/zskWQz+63j5rW2FoPOeFH6b9DwI7MTKSQWVyyWZXUl7ATw1oXRSHWz45b6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYj2yylc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08DBC433C7;
	Fri, 19 Jan 2024 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705683282;
	bh=VF1Z6l0IbpzY9s0IFYKQ4DO9qjHRXBU3M4HJxWlGq40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYj2yylcbYD0c/JE4Hkfjkc9xVn3OuvjAl1IxoAQv88c9FbUcsW8FkiubfOGa7kW4
	 bpLFNFo5DrzbuwvaxdtBITnaSPmXF4DLNMsN0hkMYeZM7HTCfY+mSny39OG/E93wtv
	 XVw79kvP+kXZE8ofANGnqejrywYEibHBF9CrcMgMtufb5lJyc66CXH0uuPXLMZTLsh
	 Wsye1bhUr+FUrCsQcMvkGlirmSqb8c164AsRfouFc3j7rG+uy2MhUrlwNOXu81kgBB
	 o6vQfFaGZB8RIOeAlcqswaD310RW6h8Ozr5hyvtR1djAKFu48XIZcSTV5j7JsyqAgT
	 JYcWLk6pOocpg==
Date: Fri, 19 Jan 2024 16:54:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	"Paller, Kim Seer" <KimSeer.Paller@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20240119-mammary-another-f060e43bcdf7@spud>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
 <20240118085856.70758-2-kimseer.paller@analog.com>
 <20240118-steadily-coauthor-de8275118901@spud>
 <PH0PR03MB71410860593D3C7253B200FCF9702@PH0PR03MB7141.namprd03.prod.outlook.com>
 <0f32caa9a11305333f1f18b97c97d775f4a5bb9a.camel@gmail.com>
 <20240119-squad-unflawed-934627f0e394@wendy>
 <dd3051170bc9724ca7e2884344dee3bc7b8f0a85.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9HBH4EAVsLhP8n6J"
Content-Disposition: inline
In-Reply-To: <dd3051170bc9724ca7e2884344dee3bc7b8f0a85.camel@gmail.com>


--9HBH4EAVsLhP8n6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > Hmmm, How is the enum easier than a boolean property :)? I guess the =
device has a
> > > default mode. So, if it is Direct IF mode you have 'adi,mixer-mode' t=
o enable
> > > that
> > > mode and that's it. So the code is pretty much just:
> > >=20
> > > if (device_property_read_bool()) {
> >=20
> > device_property_present() is preferred I think.
> >=20
>=20
> Hmm, don't want to start an argument but I'm not sure either :). I would =
argue that
> device_property_read_bool() has more users (according to git grep - and i=
f I did not
> mess the grep) and it pretty much wraps device_property_present(). So, if=
 there was
> no value in it's "meaning" we would/should stop using it and eventually d=
rop it...
> Anyways, not really a big deal.

If there's an actually boolean property that can have a true/false
value, but testing for presence alone device_property_present() is
the more accurate function to use.

--9HBH4EAVsLhP8n6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqpTAAKCRB4tDGHoIJi
0rEOAP9G83tYMDwHe1/1SOd5SpfVPcFG+kAljyMoNIrOdxisAgD7BEnEbR6UIAWO
ci9GeMpBvOEMHO1eTPxQz6drAG7c1wk=
=+I9X
-----END PGP SIGNATURE-----

--9HBH4EAVsLhP8n6J--

