Return-Path: <linux-kernel+bounces-16790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F408243CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F196F1F24771
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD5225D3;
	Thu,  4 Jan 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="Tqh6216P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MS+FNCu9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE879225A5;
	Thu,  4 Jan 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 89CAC5C00D2;
	Thu,  4 Jan 2024 09:28:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 09:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704378533; x=1704464933; bh=DipVrQhrjW
	IAtEKqD45J/bUSQRWUjrpsRHzMOm1b6FI=; b=Tqh6216PYWjOZGszyXs+YuYur2
	GEnYGy75X1hPI/EWurqYWL+a6bKnXfXsJ4swCPD0BHYaBOPMmF82EaA4sqEi37Vv
	hp9X5UgPoxTLQuuzGhdzysVSjBt4v3paMmeISV/HCGKHfHzyH8KWRwM9iTMMY7XH
	jZsjE7NtHYlP+zhgc9CWhdxpeQ+Ku9OK4qF4OU56EFMB514lo+066Ar0hmrxWZ/g
	HL4qohmXRtmDZeG2WSAbeRYQ4Obx+4wvuMSOTXi+JR97lOjVcPfV1weZ0uccxpfg
	X0o9lrXWWTw2E+9rIF9RoH4YiWC84Wh/FOBNeuM0ZRDPV8du8DwcWHfJgnoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704378533; x=1704464933; bh=DipVrQhrjWIAtEKqD45J/bUSQRWU
	jrpsRHzMOm1b6FI=; b=MS+FNCu9SK0W/U8W8PKFHqpkVXomqqsE3pPNMWJUvg29
	8al0XTXEAEub3Zev7V7RZq6SmGJcPuaASjz9EoYSk8YFbsQp1rbFVd+6SXSXHo64
	HNh1A/QjG/9GZ01TcgT1/lp+qOOBUXRH8G53h/oQIon4TM80ltnY9a8hXE6oa1lR
	pkWD8e8CeSa3XK/FNv6EQJVooBN6V1QabY14ut8qk4dkl1ugWSJaXzvSZCnroW2D
	iJs2pjnUHNcKJ7gQSgVWxuwxDXXldT2qxxVGfmlzkcB9NnCp6uDhyrMUAZhqnuFU
	izAyqQmp8d6SIdEb/LG81t61Lod57s8tNZCrbZdd8A==
X-ME-Sender: <xms:pcCWZdwXqpE4ri9YrKfxZoz2T2__PRqECdraozDhBGdzLPhh6mOLYQ>
    <xme:pcCWZdTsoeXQlbV5UuxVdlunf9J03KtVTrbwc6Rzavf-VM0hwfvuesWW60gr8YJCf
    uOLCpxE70sJ0dg1Ads>
X-ME-Received: <xmr:pcCWZXWmiGNwvvglMD5TlFMlziCKMdDOurwL0ePq0Nt7VsivmJAQhzjnsVvVeSBI1q1I0kGE_Kdw9QcrUExqdSMtdXgG8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeejgfdtleelvdeftdeggefffeeu
    feevgeejkeelgeeujeevveeufeeigfeivdejjeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:pcCWZfhpe1Wr7ZEAJBUXIlfTV3k0gPVZgLHbvwE0q9KMcu9rn6MCBw>
    <xmx:pcCWZfCypEM4Y-vmgaap2mwZeEQVNgoMgbs4ybeeX7E4PTzQPu3blQ>
    <xmx:pcCWZYJsClyvl2Kz3e8m0weXZ7LzS_EQiVcJsgKdbOsEF1Qo6dynEQ>
    <xmx:pcCWZT0WstvisP_jeKJGZnVDWd--zUPJ_sF49fc4qfogK3E4PiVB4Q>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 09:28:52 -0500 (EST)
Date: Thu, 4 Jan 2024 08:28:51 -0600
From: Patrick Williams <patrick@stwcx.xyz>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
Message-ID: <ZZbAoxDm39qeBtCy@heinlein.vulture-banana.ts.net>
References: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+82ChjIsQHnggrIX"
Content-Disposition: inline
In-Reply-To: <20240104134532.536793-1-peteryin.openbmc@gmail.com>


--+82ChjIsQHnggrIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 09:45:26PM +0800, Peter Yin wrote:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
>=20
> Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP=
8Qbepm1AVjuCbaKw@mail.gmail.com/
>=20
> Change log:
>=20
> v1 -> v2
>   - Add infineon,slb9670 information for tpm.
>   - Patch 0006 - Add PDB temperature.
>=20
> v1
>   - Patch 0001 - Revise SGPIO line name.
>   - Patch 0002 - Mapping ttyS2 to UART4.
>   - Patch 0003 - Remove Vuart.
>   - Patch 0004 - Add cpu power good line name.
>   - Patch 0005 - Add spi-gpio.
>=20
> Peter Yin (6):
>   ARM: dts: aspeed: Harma: Revise SGPIO line name.
>   ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
>   ARM: dts: aspeed: Harma: Remove Vuart
>   ARM: dts: aspeed: Harma: Add cpu power good line name
>   ARM: dts: aspeed: Harma: Add spi-gpio
>   ARM: dts: aspeed: Harma: Add PDB temperature
>=20
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.25.1
>=20

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--+82ChjIsQHnggrIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmWWwKEACgkQqwNHzC0A
wRmpqA/7BL+RG9Bd7wpYt0zewQCiZlzcRSnSo5oTw4W9jyLABk27jgQ/Pp2UyHpk
pWU6GAcVtsKhJgvvocEHneMhaV5mrTMeKAXtVcva18CbmfrF2rDPj4FX0kPKCGD9
iWNLMCDZib8vRoRv9C2YxoR1jd3t+JFFG7CrUP4ORT5iqq0TzCXRoEm+y+PqFc2U
rbOdXgwgmp1vx5yAJAu7KFZOGn63U8sMX2y5u2xcnuNmW25iYZmQVL/cH50L7zld
XkrCELp7lmlLbd9/+4eKzFbfCkVgWMPblIYBBBo8DP9OoFZCi7Keh1ZFqATzjnI9
7g03Y49uZZsvFrxbe+sNIWw1eFnZp/HG1ePrDNqEFj3KxDNyN9QJNOQqLCKOIBbi
6XmG19UJ3pV+px9Zzt7KtvrxaA4pLah3yTZvMmrqyEAZ1P9m9QDeV1iRvJKwIR0U
9wO5MbB1vS0S3KdrIgmgenT2SFQorkDVfZzvTsU9eQrDsiFQej4fWGI5fdSGqlSc
wdEQqriKFuqvLfZI1oyDymn4DcPCwU32ySh9vjpfibxnBAkh/i1ZbRwN1knrTrZ2
omgOkkJwjOov4chib1B/KWGSOzREhdwLwmDv7vIEtXyTkVeiZgsEx2Jy1Ge9GzrN
QuFp3ujJ7Zf4w9lwDfu1CI6zKs7rpmChAgRfGmFH4zNsuXt3Cds=
=tNZc
-----END PGP SIGNATURE-----

--+82ChjIsQHnggrIX--

