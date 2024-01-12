Return-Path: <linux-kernel+bounces-24927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39C82C4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70AA1F2490F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DC517BB8;
	Fri, 12 Jan 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="TMz9U1wX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BETqwby7"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B0A1AAA6;
	Fri, 12 Jan 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id E88BD5C01AB;
	Fri, 12 Jan 2024 12:42:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 12 Jan 2024 12:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705081323; x=1705167723; bh=s11rx7yU1c
	wWsVDclFsnGfU1dha05r3l4G2kyuqKUiM=; b=TMz9U1wX/twIacvV25BZV4T5wz
	bnt2CSBsmXNRr5tWGpzPhB+CABy6F9aXdgFmsSC0zBBRo3plxUUAxvapP4CEiv1S
	1fsceHjdoCuoDor+h8s8orLKmHKZFeIqbg1ufmvvKRordtyjn2hroQCeoi/6Pb1J
	sLm9ygVmsH7JoQzIRb6mB7uqs3QAB/yAV1Z8GBYBTu+C7PqupJNGJnu6XoH0Y6EI
	7BOScYGBMeraMn00dyXana/0WCIJFVDlgCNR4rCryTQ9FPNS7nHq4huZazdrRiK/
	QezVpNOO+QtqdMZHDxJh+47gK4nS0GJR0Ptz1mvTjDpyR7xGKp8MyY6lxxdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705081323; x=1705167723; bh=s11rx7yU1cwWsVDclFsnGfU1dha0
	5r3l4G2kyuqKUiM=; b=BETqwby7pBGbv3c4yt5HkQmjbuMsxezpu6eYRhkSf9lO
	ecHvQdfcK5qD9ELqhMuHXHnJjtq/oXkFoh6Gv1jPz3kve/R7Hs7A35tAGszfQ/5I
	THZMzER1scyVmgeiZSqx7TIFceZS+tjWLrQHAxLZAS0Sew+aCzM83PIcdsC58weV
	0A6XEE1oPiDCvCWJHjVZzEWCDtzvJf4Ocr/g7BGznH2eWuTmHSKPfFPaqre8BXw1
	D6b5YVqDwsQ5/Ja78jjlcm5hM5LjxxxfJ/AGZpy088nWzcCX6CFthJgsVigsuXTC
	Ro6tTkrD8kwKkenG8i5YQIYj4D/gWdQWay8KnslSBA==
X-ME-Sender: <xms:63mhZccNZ43UJ6_cYLiDAlDApogVeJVIwbp6wpAIo9CQnfr-aH1sBw>
    <xme:63mhZePDq1h45LlZ_z23hGVXGsr10wdIYlcTElzsIa28RNm2U0UE4aWxmUQEJbRXM
    hjLNTW8d_j_PoglttY>
X-ME-Received: <xmr:63mhZdixxHmxQ_GNX0i6r7zFDfB5Yb4Cddu1jDrRo7OLIAjX2V4qksplzBODstUTfvf9MB0LUFf870C6Kw6Xpg4FpOl-gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreer
    tddtvdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkh
    esshhtfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepjefgtdelledvfedtgeegffef
    ueefveegjeekleegueejveevueefiefgiedvjeejnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:63mhZR81ixhnsGIUlgjpvayR8hk-oQfrSk7IU1qg-svzBBcDv6DVEw>
    <xmx:63mhZYs815sFK8Fo3bwqKOdzZ2XmgKgsO3aouDKgR-lmPWhCOtG-tg>
    <xmx:63mhZYFFFJb3_0YKoY3tpX_wrIVjzTXFin-ZoqjHlkA3uBejtPHERg>
    <xmx:63mhZVNpUKrEsGl9k9RegQ0EiXC5Qp6_oU2EHBcVQ2w_aBuNm1CT4w>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 12:42:03 -0500 (EST)
Date: Fri, 12 Jan 2024 11:42:02 -0600
From: Patrick Williams <patrick@stwcx.xyz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: nuvoton: add Facebook Yosemite
 4 board
Message-ID: <ZaF56lwEi1MES89Q@heinlein.vulture-banana.ts.net>
References: <20240112013654.1424451-1-Delphine_CC_Chiu@wiwynn.com>
 <20240112013654.1424451-2-Delphine_CC_Chiu@wiwynn.com>
 <8efef092-e70f-46c0-a60a-e62e676d6eb2@linaro.org>
 <ZaFydbPxbeczo97t@heinlein.vulture-banana.ts.net>
 <c0a83358-09a3-4c51-b8b6-6d6ea8b4f196@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hWV98mDElNT6jKhP"
Content-Disposition: inline
In-Reply-To: <c0a83358-09a3-4c51-b8b6-6d6ea8b4f196@linaro.org>


--hWV98mDElNT6jKhP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 06:14:26PM +0100, Krzysztof Kozlowski wrote:
> On 12/01/2024 18:10, Patrick Williams wrote:
> > On Fri, Jan 12, 2024 at 08:10:25AM +0100, Krzysztof Kozlowski wrote:
> >> On 12/01/2024 02:36, Delphine CC Chiu wrote:
> >>> Document the new compatibles used on Facebook Yosemite 4.
> >>
> >> There is Yosemite4 board already supported. What is this for?
> >> https://lore.kernel.org/all/20240109072053.3980855-5-Delphine_CC_Chiu@=
wiwynn.com/
> >=20
> > Yosemite4 is a server chassis which is managed by a BMC.  The BMC is on
> > a pluggable module card.  Typically we've used Aspeed chips for this,
> > but we are building an alternative BMC module using Nuvoton BMC chips.
>=20
> There are few ways to solve this, like having different compatibles or
> having some shared compatibles to note common part of hardware. However
> usually the final compatible represents the final device, which here you
> use for two entirely different products. This works only for the cases
> of carrier boards, where that compatible indeed represents the same
> hardware.
>=20
> Not your case. This needs fixing.

This patch:
+	model =3D "Facebook Yosemite 4 BMC";
+	compatible =3D "facebook,yosemite4-n-bmc", "nuvoton,npcm845";

Aspeed patch:
+       model =3D "Facebook Yosemite 4 BMC";
+       compatible =3D "facebook,yosemite4-bmc", "aspeed,ast2600";

These have different compatibles already ('-n' for Nuvoton).  Do we just
need the model to be clearly different also?  Maybe there is something
else I'm not understanding.

--=20
Patrick Williams

--hWV98mDElNT6jKhP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmWheegACgkQqwNHzC0A
wRmuSg/+IUyH4CzVAeyui/NfgsYtbgD5YYyLywW9Gdl3td9rcUn702bmrtZ5t3QD
PmOf443x6sTrZqED46Sw0EiL2/6F9p09IQCfcP0xIDAilhystlZh/aIffi0N2r7Q
meD5whSSe5ur+xNd4T6Y+CW3bBzN9b2NAjhTKaX7t6b+j2otf7quEXW9yenUO8He
hEUqBwrexdtTV6PQSuPDoAbMWmUxdjrU+SFWnP7D98R2HWixaqwG/JcSDYCsrwQc
7LMiO+ICcV2POevQC7zqWKel1T3VXqZa2ShCsWJxW/hyHhl/aWWM+4cwvm6z2XwI
NmQRyfXpqMUcHDFTH3sLnG/pgc1IXbnGmmKXyLFbj97AtORkU9z0zwie6y1z6F9D
/7PY0oBS+mX0NPMHSPVMxQ2UZkUuhyDggTu5T6gdgph/mGFd0hlEWruW7CrxiTfY
z88y48PAJsUzf+fdkeVB7XRE45LPRL64b7pqQGlWbZQEwpHWIL4VDisL+W+Oj7bV
IL2v3BiKKfzt5w0yA5sA7hMhE/k3jvTKkzKqLBsVRpwq4wa5peypz0rcb685dqzZ
GOAHvvZmQaCelXfbZXne8X/cSPuzWJI/XT8MeDJuAzNa/bCVxJuMONNTECxvOMDT
xItWvlKKXLPA+P56a3As6iZAc+ynu+mYghxeKgAF9U4OXFWq0kY=
=3qaC
-----END PGP SIGNATURE-----

--hWV98mDElNT6jKhP--

