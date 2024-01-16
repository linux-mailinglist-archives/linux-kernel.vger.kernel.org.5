Return-Path: <linux-kernel+bounces-27689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E7382F427
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3381F24B13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96A1CF80;
	Tue, 16 Jan 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udPD62db"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBC1D520;
	Tue, 16 Jan 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429395; cv=none; b=pUNgiuf2QUZxIT1RT4CPBZ3g/nRLqMh2VFaGtaShrlqOd8XXo93JNv2VEPlf7CxygtlZr7eyoF5psx9lYHnfbtyi8k0Sqi8TNlZdBZpn0ST5m2r6QOJ6Q2dEYBLQS/tr+S6Bd+3xU4+5LypP+K02B08rFDkVNZM4jgHSssHjIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429395; c=relaxed/simple;
	bh=BZZrwB54NzVpdIKnJH5IBEBJlnxfuCsPO9zMgTYYx0Q=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=N0hxUpELg5L2X2//+ejvosvbr9dBvyyjQ4uOtsj81niFzVHV5JSd4aL3CIBv9U1tvvWMsXhE3Yi/CMP/94O5h5BOEotijm+9GHzJtb555/HE0uHK/x1ro6G3l6vSmZ0+L+I5Jyd/WZOaBA+k3bO0GYcXVDuXvg11B+ZatFwDtFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udPD62db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9565AC433F1;
	Tue, 16 Jan 2024 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705429394;
	bh=BZZrwB54NzVpdIKnJH5IBEBJlnxfuCsPO9zMgTYYx0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udPD62dbadhMBLT6wXnbk/PYsrCAhEDzjxtawZJ9t1xIzxa7qfbeCQZOMjoea3fNW
	 ny+vVTuIADQ7GD+7sSRh8UkwpzCq8tRLvoVD1YVU3y8RlPNrvhJaPpGtGNVQ7KuO22
	 UY8nTAwYCb42cZNy+jP21tJ/QioS8vTLwiEwsExq/qag4FgJ8znilhvRbhZm7y66b1
	 tRzF0R/qHyskJBWBYZfiOHQgcKgDt0IAHFQ8cv33ftqROoOt7W8C7TJgl137N72wn6
	 VFHO8HARbFh3IEiUgbMNiIv+izNcblv8i63ErRkDoKK+o68aALBny2lm8lYFeq9y9Y
	 QWDaX98aExH2A==
Date: Tue, 16 Jan 2024 18:23:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	robh@kernel.org, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <20240116-retract-conclude-c47a7fc8cb21@spud>
References: <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
 <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
 <ZaWLCrWJEMtFx8cR@lizhi-Precision-Tower-5810>
 <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
 <ZaXqCoCHPWER94Hh@lizhi-Precision-Tower-5810>
 <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>
 <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
 <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qdmJxKjtdyHy6e/u"
Content-Disposition: inline
In-Reply-To: <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>


--qdmJxKjtdyHy6e/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 12:35:44PM -0500, Frank Li wrote:
> On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
> > On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
> > > On 16/01/2024 10:30, Conor Dooley wrote:
> > > > On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> > > >> On 16/01/2024 03:29, Frank Li wrote:
> > > >>>>> 	Patches were accepted after discussion, what you ponit to. So I
> > > >>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> > > >>>>> 	I plan send next version to fix auto build error. Any addition=
al
> > > >>>>> comments about this?
> > > >>>>
> > > >>>> I still do not see how did you address Rob's comment and his poi=
nt is
> > > >>>> valid. You just did not reply to it.
> > > >>>
> > > >>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-=
Tower-5810/
> > > >>
> > > >> First of all, that's not the answer to Rob's email, but some other
> > > >> thread which is 99% ignored by Rob (unless he has filters for
> > > >> "@Rob"...). Therefore no, it does not count as valid answer.
> > > >>
> > > >> Second, explanation does not make sense. There is no argument gran=
ting
> > > >> you exception from SoC specific compatibles.
> > > >=20
> > > > The patch could have been applied two months ago had Frank done as
> > > > was requested (multiple times). I don't understand the resistance
> > > > towards doing so given the process has taken way way longer as a re=
sult.
> > >=20
> > > I think that Rob's comment was just skipped and original master bindi=
ng
> > > was merged without addressing it. I don't want to repeat the same
> > > process for the "target". Indeed I could point this earlier... if I o=
nly
> > > knew that Rob pointed out that issue.
> >=20
> > Oh I think I got confused here. The context for this mail led me to
> > think that this was still trying to push the i3c-master-v1 stuff through
> > and I was commenting on my frustration with the resistance to applying
> > the feedback received. I didn't realise that this was for another
> > patch adding a target.
> >=20
> > I think you already said it, but NAK to adding any more compatibles here
> > until the soc-specific compatible that was asked for for the imx93 is
> > added.
>=20
> Is it okay for 'silvaco,i3c-target-imx93'?

I don't know. Is the device in question capable of also operating in
master mode? I have no idea from the commit message since it contains
zero information on the hardware.
If the exact same controller can operate in master and target mode,
having two compatibles for the same device does not seem okay to me.

Also, "silvaco" does not make the imx93 so that is not a suitable vendor
prefix. If the imx93 only supports i3c IPs in target mode, I would call
it "<vendorofimx>,imx93-i3c" with "silvaco,i3c-target-v1" as a fallback.

Thanks,
Conor.

--qdmJxKjtdyHy6e/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZabJjQAKCRB4tDGHoIJi
0oBVAQDDSQszcWBHPjv+zzPJ4Jwf5F3zvlWOZOaPQSVALMBS1AEAjehMKKMgybnn
hKiuBGxe+C7CLnu7Tf0NAw78Xj6lcQY=
=fPBb
-----END PGP SIGNATURE-----

--qdmJxKjtdyHy6e/u--

