Return-Path: <linux-kernel+bounces-29141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2048B830970
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B5E285A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60566224CE;
	Wed, 17 Jan 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb1HAWvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144F219F9;
	Wed, 17 Jan 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504448; cv=none; b=JyV1EK5no2ZOgQiJqMygTCplTDhUYBVe9GLxSc+a3DZOGnjRzyosaRBsTsfsy1jP2uY6AFXvqKXKLzmG/LxMNpYtwcZQzc/sV+aUpNkwkQyZCNLG8n7SftCZAlF6g0NR8sA05CbSL/So3om8r+LGo0XAzm+LGPJid45AXHekgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504448; c=relaxed/simple;
	bh=yIvwf7wNoEAO6MI1GMACRShu7NDGDDIrbkkSNppYfu0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=M66eB1YPfuLMPfueCJrToN30NZYIzGfx02FQIno9EI37Z554ekok+ySLcVvtOG3at/V5MZiGWqh9P0XzHhIFDEumeWfuXCTW6ObDo9O/ZFOH756YOIhoB/O9VLNZfag5PhDb6DmltS4Pv+MmPOvoZXeVkDegoxayG8Cbs3rN2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb1HAWvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7F4C433C7;
	Wed, 17 Jan 2024 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705504448;
	bh=yIvwf7wNoEAO6MI1GMACRShu7NDGDDIrbkkSNppYfu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cb1HAWvl9uQnhJ4NzockLmOP/ggSO4BrBLJ6Af/o6hVHVB+3b+P6gAqb7tGTrhs1p
	 glATM1Y5uoveItyrKqBcmWfWSpGz59xmcVDxtxtKwvvIupC6yTFZBWC3lHnRdlQBr+
	 /1qDSStK5xbccfGNFArI4GG0q5wRF4GsrrnlIRjhmAGUg2k1snPfZh0ybvXscE4eUc
	 tnTNmuvtdHJCQ7aHt/8XZ4W222qK0hpzSrxQMA6gb1U1Wj901UtyNyMUisu30sFpBA
	 l+PehzoM3sTpz1SvQGfE1eCWHLiXg03BTvEszKl/uDh6a4F2lJv0gfsL97jD0ICpRZ
	 MGse9CWxPBCwQ==
Date: Wed, 17 Jan 2024 15:14:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: interrupt-controller: fsl, irqsteer:
 Add power-domains
Message-ID: <20240117-deceptive-knapsack-ba9885f7b35e@spud>
References: <20240110094338.472304-1-alexander.stein@ew.tq-group.com>
 <9230083.CDJkKcVGEf@steina-w>
 <20240111-dullness-blooper-37644405c825@spud>
 <13433324.uLZWGnKmhe@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T3KERiiprjwKtIAN"
Content-Disposition: inline
In-Reply-To: <13433324.uLZWGnKmhe@steina-w>


--T3KERiiprjwKtIAN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 08:31:26AM +0100, Alexander Stein wrote:
> Hi Conor,
>=20
> Am Donnerstag, 11. Januar 2024, 17:49:03 CET schrieb Conor Dooley:
> > On Thu, Jan 11, 2024 at 09:59:54AM +0100, Alexander Stein wrote:
> > > Hi Conor,
> > >=20
> > > Am Mittwoch, 10. Januar 2024, 17:09:07 CET schrieb Conor Dooley:
> > > > On Wed, Jan 10, 2024 at 10:43:38AM +0100, Alexander Stein wrote:
> > > > > Some SoC like i.MX8QXP use a power-domain for this IP add it to t=
he
> > > > > supported proerties. Fixes the dtbs_check warning:
> > > > > freescale/imx8qxp-tqma8xqp-mba8xx.dtb: irqsteer@56000000:
> > > > > 'power-domains'
> > > > >=20
> > > > >  does not match any of the regexes: 'pinctrl-[0-9]+'
> > > > >=20
> > > > > from schema $id:
> > > > > http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.y=
aml#
> > > > >=20
> > > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > ---
> > > > >=20
> > > > > Notes:
> > > > >     Please note that both the board dts and the DT node for irqst=
eer
> > > > >     being
> > > > >     used, are still work-in-progress.
> > > >=20
> > > > The binding doesn't even support the imx8qxp's irqsteer yet, I think
> > > > this should be added alongside support for that SoC. Am I missing
> > > > something?
> > >=20
> > > I'm not sure if any additional SoC support is actually needed. 'fsl,i=
mx-
> > > irqsteer' is available and that's what I use in my WiP. Also imx8mp a=
lso
> > > just uses the generic compatible. Only imx8mq uses 'fsl,imx8m-irqstee=
r'.
> > Why doesn't it used "imx8mq-irqsteer"? Should it not have its own
> > soc-specific compatible?
>=20
> I would assume that "fsl,imx8m-irqsteer" is for the whole i.MX8M family. =
I=20
> don't think a soc-specific compatible is needed at all. On top I can't se=
e any=20
> difference between i.MX8M and i.MX8/i.MX8X.
> If a soc-specific compatible is preferred, fine by me. But I don't expect=
 any=20
> difference despite imx8qxp/imx8qm requiring a power-domain.

Specific imx8mq compatibles exist for a wide range of peripherals, I'm
not sure why the irqsteer would be an exception.

Cheers,
Conor.

--T3KERiiprjwKtIAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZafuvAAKCRB4tDGHoIJi
0ulnAP0fdOE5875N8QKNp6ri57q+vfJtAe+TtOeYTqrY+JryVAD+JzfzSt8WyMx4
KJ1I3FC2Gdujite2qjcvvK5du14d0w0=
=Efw8
-----END PGP SIGNATURE-----

--T3KERiiprjwKtIAN--

