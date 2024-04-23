Return-Path: <linux-kernel+bounces-155673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1338AF579
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5780828891E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AEC13DDD1;
	Tue, 23 Apr 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eriDnqXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149631BC23;
	Tue, 23 Apr 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893150; cv=none; b=sbH1EXQYkfX+imaJaIVDeQ0qR7YaqGwXJV4My2vcGraBf/ozLFsTtWYQP1Mtl0BgJBwOp5/pji7Y/LG0N1dCEWamOatguKeI1FTcPW2H7GI7wdOZYC4CXd+FbQYdFryN0lFoHFIfzVkg5PeC6v8O3beJsvg1Pjjhfb0kPq7hs8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893150; c=relaxed/simple;
	bh=EF0yWbo4WiBBXL3dWcr/3LxSe7IVVaPwqZJ7quETboE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPs1ahVFSfG3+SLcCFGBRntOmsWJh5D7BPsLaNsoD+m9iG1GCljMqHStXu/QTuXe83vmmlyi7RzIHWPeYFrqkTd2J1wvqU/RAOZ7dYlxt9jm/DOWhXZV0l2ofo+IAiHNPB1e+vCg+/kCcvVCAur5C6b+HwW9H9nTmYN9KcLCJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eriDnqXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C6C116B1;
	Tue, 23 Apr 2024 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713893149;
	bh=EF0yWbo4WiBBXL3dWcr/3LxSe7IVVaPwqZJ7quETboE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eriDnqXZpCfZ/tEJjVYj+Mi1ZFtRE8gkBeAFG7sQwG+MyCOGb26QxwnIWDjtIxSuL
	 eWD4zJIlg98rxtB4aSKISfMwFYtn1Yoz7MTxlYGS81d5R17xJ/WOdE+X08H6fTUckD
	 2JxQ2HX8smMXFv1PQxGkIwf7QzNbjraBax7+D2wspeatpDd/KV7x6gTSLnw7ZhszU4
	 /4Ywx3F2pAsPJFU1L/TrjvXaWrHPpJ0U1X0urJTub+MMclR7UO0PlppV48orMA8y2X
	 w4Ql5MOo+RHBMILQesT3Bo3jpFkE8AGk0+YV50PsfIAEnts7R812U0QjgRtQrWD0XP
	 b0FvfdVARr63Q==
Date: Tue, 23 Apr 2024 18:25:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: interrupt-controller: fsl, irqsteer:
 Add imx8qxp support
Message-ID: <20240423-velocity-italicize-c4f1f22c2ef4@spud>
References: <20240422064949.70778-1-alexander.stein@ew.tq-group.com>
 <20240422-channel-emission-d485dee6ae48@spud>
 <6041240.lOV4Wx5bFT@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eGhzn0VEzH+sEQMJ"
Content-Disposition: inline
In-Reply-To: <6041240.lOV4Wx5bFT@steina-w>


--eGhzn0VEzH+sEQMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 08:26:55AM +0200, Alexander Stein wrote:
> Hi Conor,
>=20
> cc'ed imx@lists.linux.dev
>=20
> Am Montag, 22. April 2024, 17:48:20 CEST schrieb Conor Dooley:
> > On Mon, Apr 22, 2024 at 08:49:49AM +0200, Alexander Stein wrote:
> > > Some SoC like i.MX8QXP use a power-domain for this IP. Add a SoC-spec=
ific
> > > compatible, which also requires a power-domain.
> > >=20
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > > Thanks for the feedback.
> > >=20
> > > Changes in v3:
> > > * Move 'allOf' before 'additionalProperties'
> > > * Remove superfluous 'minItems: 1'
> > >=20
> > >  .../interrupt-controller/fsl,irqsteer.yaml      | 17 +++++++++++++++=
+-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/f=
sl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/f=
sl,irqsteer.yaml
> > > index 20ad4ad82ad64..3d33b75d6ecfa 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqs=
teer.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqs=
teer.yaml
> > > @@ -14,7 +14,9 @@ properties:
> > >      oneOf:
> > >        - const: fsl,imx-irqsteer
> > >        - items:
> > > -          - const: fsl,imx8m-irqsteer
> > > +          - enum:
> > > +              - fsl,imx8m-irqsteer
> > > +              - fsl,imx8qxp-irqsteer
> > >            - const: fsl,imx-irqsteer
> > > =20
> > >    reg:
> > > @@ -42,6 +44,9 @@ properties:
> > >    clock-names:
> > >      const: ipg
> > > =20
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > >    interrupt-controller: true
> > > =20
> > >    "#interrupt-cells":
> > > @@ -70,6 +75,16 @@ required:
> > >    - fsl,channel
> > >    - fsl,num-irqs
> > > =20
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: fsl,imx8qxp-irqsteer
> > > +    then:
> > > +      required:
> > > +        - power-domains
> >=20
> > Provided the power domains are optional on the existing platforms,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > otherwise,
> > else:
> >   properties:
> >     power-domains: false
>=20
> A power-domain is used on imx8mp, but imx8mq does not.

So then make the contains be an enum with both of the one supporting it
& add the else please.

--eGhzn0VEzH+sEQMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZifvGQAKCRB4tDGHoIJi
0tskAP48o/+s5lq1jpc+7TE1+8Thqvqyi8lpX4xp9HbEQYDoeAD/aucpundN/HbF
FwX9e75oP9cKObcaPj16TtFGFHbq8ww=
=RUuj
-----END PGP SIGNATURE-----

--eGhzn0VEzH+sEQMJ--

