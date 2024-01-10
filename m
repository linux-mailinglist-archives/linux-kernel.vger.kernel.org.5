Return-Path: <linux-kernel+bounces-22488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13E8829E73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BF5B23A54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB054CB52;
	Wed, 10 Jan 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNFc6vbv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A38487AC;
	Wed, 10 Jan 2024 16:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20634C433C7;
	Wed, 10 Jan 2024 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704903813;
	bh=eNBsfotIxA6oJoW5N6NgGDl5v3asXMtOGMdtipXCqO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNFc6vbvq9MCcj7qHc7w5/8P2zz5HWo6hBJ2ySTcS2Cnfo91MFIcJIzZHGOPCC4LB
	 fVIIeoPbAouT31AT9BTQa65yUCSr+A49sqJYd7d69pFQqZDA8rIg/MRvtOzG52a3fd
	 stIVEXAA37eEfMFj1zm1ADvJu7nviGuC7RPXJpjjE1Pf2sdGa5dQU1BP8DTGcu0oXy
	 ZF+FO7OxEzaZM6oS/z8QyxvVDKN7vKPOfNsQB1U5XXNRyuKPPCcPRkKRsdMnBCm3hK
	 pq6PWAY1djk3nAkAcNcAo4RWC5A+i6N5xVrKmGLYKXEyRxZwjn/kzcN8zMoZci+8Vj
	 nTTk7o9MoupuQ==
Date: Wed, 10 Jan 2024 16:23:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	johannes.holland@infineon.com, broonie@kernel.org,
	patrick.rudolph@9elements.com, vincent@vtremblay.dev,
	peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
	bhelgaas@google.com, naresh.solanki@9elements.com,
	alexander.stein@ew.tq-group.com, festevam@denx.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
	geissonator@yahoo.com
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Message-ID: <20240110-straggler-around-a53bc0a669fb@spud>
References: <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
 <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
 <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
 <20240109-pep-coerce-2a86ae88753d@spud>
 <01974929-dfbf-4989-ba39-369e521827d0@linux.ibm.com>
 <3d194e84-bf1a-48e4-a376-e5c327c6508d@linaro.org>
 <2dd37d2b-28da-4e73-9047-61ec5d64bdb5@linux.ibm.com>
 <edbefdfd-eb59-4d86-ad07-feb066a21082@linaro.org>
 <385b06e9-1daa-408a-a0ed-7b09d7d539df@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nfn0kt/7dCO7kpcR"
Content-Disposition: inline
In-Reply-To: <385b06e9-1daa-408a-a0ed-7b09d7d539df@linux.ibm.com>


--Nfn0kt/7dCO7kpcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 09:54:19AM -0600, Ninad Palsule wrote:
> Hello Krzysztof,
>=20
>=20
> On 1/10/24 09:37, Krzysztof Kozlowski wrote:
> > On 10/01/2024 15:31, Ninad Palsule wrote:
> > > Hello Krzysztof,
> > >=20
> > >=20
> > >=20
> > > > > > > I have send it as a separate commit. https://lore.kernel.org/=
linux-kernel/20231214144954.3833998-1-ninad@linux.ibm.com/
> > > > > > Why did you do that? It now just adds undocumented compatibles =
to the
> > > > > > driver. Please, as Rob requested, work with Lukas on his series=
 to make
> > > > > > sure that these devices are documented.
> > > > > I think krzysztof kozlowski suggested to send these patches separ=
ately:
> > > > > https://lore.kernel.org/linux-kernel/1c5ace65-2fd8-4503-b22f-e0f5=
64d1c83f@linaro.org/
> > > > >=20
> > > > > Did I misunderstood it? Do you guys want me to include that commi=
t again?
> > > > My comment was in DTS thread under specific DTS patch. How did you
> > > > figure out it applies to driver and bindings? This does not make se=
nse.
> > > Sorry for the misunderstanding. Where do you want me to add driver
> > > patch? Before all DTS patches or after all DTS patches?
> > Does not matter, why do you insist on combining them with DTS? Drivers
> > and bindings are going together. DTS better separate, although depending
> > on the case can be together.
> >=20
> I have combined DTS and Driver because DTS was using compatibility string
> which is not upstream yet hence I thought it is logical to send it under
> same patchset.
>=20
> Conor and Rob, Do you have preference?

I'm not sure what you want from me that Krzysztof hasn't already
provided. dt-bindings and drivers usually go together, and the dts
patches are often in the same series. If you send dts separately, note
under the --- line the patches adding the binding so that the platform
maintainer knows that the compatible has not yet been documented.

--Nfn0kt/7dCO7kpcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ7EfQAKCRB4tDGHoIJi
0uh3AQC7n1zpvCOgwRmJ2TWpkVaHRV4kl7Lf3HTTUFgMuyKlOAD+OIT57H0iSn/M
DmPl0DJh1FNbUbHYufAGfUrXlkzyMQU=
=NtVA
-----END PGP SIGNATURE-----

--Nfn0kt/7dCO7kpcR--

