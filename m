Return-Path: <linux-kernel+bounces-82327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC4B8682D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F592B234B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA36613175A;
	Mon, 26 Feb 2024 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVZuCtf3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F1130E58;
	Mon, 26 Feb 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982232; cv=none; b=bLX0O46QvsM+vq978w4VdL6H0DTlLoPHsdYFBKeboZFa659ECTVe6gwNXSN5cdKvonBDh/1r7V58dgz3emuXGxi1TCb5TNSutwxGjQyhM+D6gKMJ87SnT9TEuXPKgfSWr6j+IasUURnNWBdVRggr3JZzeNZUsdnvrbGv2k6cNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982232; c=relaxed/simple;
	bh=fwYYpXzdEOYjL8eAtATGi8UM6eh2OJjoljUqW1PwVUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdXrGpfy3lNiNhnwEZb5Ia/RA9PLdeL34WFZ3RWyEfHfgTUVEVUKo6Ujm6S0o6J3mGQuwlIef7G4nQ36eBTz4yhgyYIchX42NiGdL55jsP8Vzq5pM+pip5RqRU8JP42ONP4hAwnmUlVc0FiyUmMerS5xELOh9eozReuDWxh0wKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVZuCtf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B65CC433C7;
	Mon, 26 Feb 2024 21:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982231;
	bh=fwYYpXzdEOYjL8eAtATGi8UM6eh2OJjoljUqW1PwVUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVZuCtf3s3iT2n5OxYC/w3Q38A4FGsmGQ7/1K2UvmYp9ox0/XHcxkwD4MDWP9aqzw
	 7mRS8JYnxGQK+/8E4gofKumBYgFuyu1TtbHALkTRnvmT9gAuKztgFbQPxCQsX3EvOB
	 kIMPjJUfpcVA8xW6/Qmo3PZ8FRID3tHTWuFDpRsG3KRHD/GkZHQbzDMKXgZ+5HSEfE
	 4Pn4RMqzsQFM6Gdi0/FRPI3fM5LqDcw/QtKlIFqD/li46DxYlmCypH3d0euzN4DhGM
	 YuyQw+MI5RMKA/rrkpX/29eUim8Uh5LUNZNnyPvixJ5I1v8y9Gm1tMsRZjAuYG7EDd
	 OO1//B9mq/prw==
Date: Mon, 26 Feb 2024 21:17:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, haibo.chen@nxp.com,
	lars@metafoo.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: drop the 4th interrupt
Message-ID: <20240226-rectangle-pacifist-633ae3b801c7@spud>
References: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
 <20240226-germinate-anymore-fb85ca9bb226@spud>
 <20240226192055.54b4a6b1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tIzW5O2k7AACHYUt"
Content-Disposition: inline
In-Reply-To: <20240226192055.54b4a6b1@jic23-huawei>


--tIzW5O2k7AACHYUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 07:20:55PM +0000, Jonathan Cameron wrote:
> On Mon, 26 Feb 2024 16:24:47 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Mon, Feb 26, 2024 at 09:08:25PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >=20
> > > Per i.MX93 Reference Mannual Rev.4, 12/2013, there is no interrupt 26=
8,
> > > so drop it. =20
> >=20
> > Don't just remove it from the example, drop it from the binding too?
> > It does permit a 4th "self testing" interrupt.
>=20
> I'm missing something. See below...
> >=20
> > Thanks,
> > Conor.
> >=20
> > >=20
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.=
yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > > index dacc526dc695..dfc3f512918f 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > > @@ -31,7 +31,6 @@ properties:
> > >        - description: normal conversion, include EOC (End of Conversi=
on),
> > >            ECH (End of Chain), JEOC (End of Injected Conversion) and
> > >            JECH (End of injected Chain).
> > > -      - description: Self-testing Interrupts.
>=20
> Eyes skipped over this maybe?  The 4th interrupt is removed from binding =
here...

Huh, wonder how I missed that. I thought I double checked...
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--tIzW5O2k7AACHYUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdz/0gAKCRB4tDGHoIJi
0lBjAP9JFqwqtIY93+4RkbvZhkGC9z9gyCJ3zcEeEwVkVbdwtQD/b5+mCGr5wIUP
J5Jf61KY+mwoafOL2mPfd4RwQNzsvAM=
=h2IV
-----END PGP SIGNATURE-----

--tIzW5O2k7AACHYUt--

