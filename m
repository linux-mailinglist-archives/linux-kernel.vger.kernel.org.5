Return-Path: <linux-kernel+bounces-135555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F289C782
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709882848FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1B13F01A;
	Mon,  8 Apr 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP+n2FXG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B381CD21;
	Mon,  8 Apr 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587893; cv=none; b=iWLOEHyjBW5whBckIpG2tf2x3CToaSl80EoFOCE+zug9zJSdOzJz3CoE1gkGb52EAIUojRZ5tdqd1jYWuU/UpT7h5M5/uCv6F431+7bJUhc266eyNQLtFZ8JnFqWlMO3Ij15kNApQmfsmoh6pqMCrEey74+gjO//jxlRyRxuAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587893; c=relaxed/simple;
	bh=Q72eGkMQIkbUraoQjSqOSGcDf1l8YhSQtcDUSUpsuyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkoTnIR3DmMIRgMhonrc7oqmDuoVl3S+kRB/x00sBW8vjIVdoVNZEAoRosjRgsMqL7qHI2Y7QL8LCQ32ZrGnp85+2v4ob6kfpR/POlcWkWcDQb1AEOhgSXhJWpL1z8yfHRWq51CrKTdzYtVRDEvWls6uUHd1Fvq5GDsNLBFDLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP+n2FXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818A7C433F1;
	Mon,  8 Apr 2024 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587892;
	bh=Q72eGkMQIkbUraoQjSqOSGcDf1l8YhSQtcDUSUpsuyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QP+n2FXG8CIeuo6RXVpKpHkZfGE+1aDoiNTNwH+a1ISHlWe2VGLtqnc8FJUHN/5tj
	 22ni8Jhd0P7gioR8Ojv9m4wUqvV3wLxVtv5Hd6lDo9tnkzhuUYpejfbnamTk8MUji1
	 GV2zYsfxceR8NjliZ++hnXAQnU4WUAAXOwM8mm06QVDnan+RluzQjJ18F9kS3FzBxQ
	 vEsm9XoO+1trbI36nvYhnjbKzEJacE5MNTqFeFy+u4zH/gymoE3juoAF5qR8wkrVfJ
	 2zTc9uqC5tWxu1nd9vDR8KX9tso1DvjstI40v4/ojGXSpzkxG3/y0m4fvTgriDVyGw
	 4FDd6OCZTILZA==
Date: Mon, 8 Apr 2024 15:51:26 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 05/11] spi: cadence-qspi: add FIFO depth detection
 quirk
Message-ID: <66bf7d58-a726-49ba-9765-f769f6189310@sirena.org.uk>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-5-956679866d6d@bootlin.com>
 <551bea0a-1c9e-4e04-87db-c643fdaee85e@sirena.org.uk>
 <D0ETH1AG1ONG.1M1FPSZM69H0Z@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Md8nckiub8eKqQle"
Content-Disposition: inline
In-Reply-To: <D0ETH1AG1ONG.1M1FPSZM69H0Z@bootlin.com>
X-Cookie: Drive defensively.  Buy a tank.


--Md8nckiub8eKqQle
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 04:38:56PM +0200, Th=E9o Lebrun wrote:
> On Mon Apr 8, 2024 at 4:10 PM CEST, Mark Brown wrote:
> > On Fri, Apr 05, 2024 at 05:02:15PM +0200, Th=E9o Lebrun wrote:

> > > +	if (ddata && ddata->quirks & CQSPI_DETECT_FIFO_DEPTH) {
> > > +		cqspi->fifo_depth =3D fifo_depth;
> > > +		dev_dbg(dev, "using FIFO depth of %u\n", fifo_depth);
> > > +	} else if (fifo_depth !=3D cqspi->fifo_depth) {
> > > +		dev_warn(dev, "detected FIFO depth (%u) different from config (%u)=
\n",
> > > +			 fifo_depth, cqspi->fifo_depth);
> > > +	}

> > It's not obvious to me that we should ignore an explicitly specified
> > property if the quirk is present

> DT value isn't expected for compatibles with CQSPI_DETECT_FIFO_DEPTH
> quirk, therefore we do not ignore a specified property. Bindings agree:
> prop is false with EyeQ5 compatible.

Sure, but it's not obvious that that is the most helpful or constructive
way to handle things.

> > - if anything I'd more expect to see
> > the new warning in that case, possibly with a higher severity if we're
> > saying that the quirk means we're more confident that the data reported
> > by the hardware is reliable.  I think what I'd expect is that we always
> > use an explicitly specified depth (hopefully the user was specifying it
> > for a reason?).

> The goal was a simpler devicetree on Mobileye platform. This is why we
> add this behavior flag. You prefer the property to be always present?
> This is a only a nice-to-have, you tell me what you prefer.

I would prefer that the property is always optional, or only required on
platforms where we know that the depth isn't probeable.

> I wasn't sure all HW behaved in the same way wrt read-only bits in
> SRAMPARTITION, and I do not have access to other platforms exploiting
> this driver. This is why I kept behavior reserved for EyeQ5-integrated
> IP block.

Well, if there's such little confidence that the depth is reported then
we shouldn't be logging an error.

> > Pulling all the above together can we just drop the quirk and always do
> > the detection, or leave the quirk as just controlling the severity with
> > which we log any difference between detected and explicitly configured
> > depths?

> If we do not simplify devicetree, then I'd vote for dropping this patch
> entirely. Adding code for detecting such an edge-case doesn't sound
> useful. Especially since this kind of error should only occur to people
> adding new hardware support; those probably do not need a nice
> user-facing error message. What do you think?

I'm confused why you think dropping the patch is a good idea?

--Md8nckiub8eKqQle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYUBG4ACgkQJNaLcl1U
h9AL0Af/U7DCdZKJHDJmT8nlFD+XSvXWPLfX3HQFd2vtIKE3B0P62gaA4Y0k2PYv
AenR0tZ8/6pQ+1Vgc3jfiS7rteofgsrHjw9OK/h4thSLtXP3GdVCssNFxuS2ue5n
khD+CU8XXcUDzcSdwIF6O08/td5vVhTZIwk6VH3K4RgbVew3CzNOGZfxa8Tl5iRP
hTvjIBi8jURysKSBVkhTi8S7v1tvEmW3F841jIUESMaZ9rD/mOaQPnFc6f9f4eHW
rgvXHkoII7vrdVCtKTgCpXMB0xPu6J0wTWdS1z+7gFrR+elfQLJqU9QW/OspLpLT
ztkc6DBUNfEJW4GV+qjZ+lBaOmflpg==
=jfLC
-----END PGP SIGNATURE-----

--Md8nckiub8eKqQle--

