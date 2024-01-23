Return-Path: <linux-kernel+bounces-34910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C17A83891A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455361C2111D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47BC57896;
	Tue, 23 Jan 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAdoutgQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C856B92;
	Tue, 23 Jan 2024 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998849; cv=none; b=p6dHGwRCojm9dyQsyD7ACepBJXkz80Wms+HmjaV7TpGmsN6clpms62HOl/oQdflrmlW5ZZqMwb2UO1FKuctq/oC8YYAHPyJoHJvXDrE6vBVKG0tNyDiAyCUF2La9yXJxPetqnOo92focZNHCEHFUwHBfLxKaFplei6mAKe1aDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998849; c=relaxed/simple;
	bh=uu/UrPYghNR4U5sRW6Qlp+lVme52+r5hsD7sS1eyNRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGy4wvMFQnr0U1Yfmv7qoQv289SWmvMpWmAVMnZL+eLx0IwwBurYJjPvSxIC+u2DFwWdqa2Js6Z7LS4s/720cFNfN2oMp20dv14oJTuxia/JjPSrgV+EtQS3XuJAsJvq2+8hQF06uNrbU6t6ohzGd7WIjne59KEApotZ6Y3QaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAdoutgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1C1C433C7;
	Tue, 23 Jan 2024 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705998848;
	bh=uu/UrPYghNR4U5sRW6Qlp+lVme52+r5hsD7sS1eyNRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAdoutgQDyyKKbpsGXwgTTHcBPw+6PWfLQjVdyq0E1gUsEirKQQ4A0nfyTVk/ESzQ
	 3ChB6nqC+n0tExtnfEF4Ttz+qpuUDSmbL09JQkO93O74bBUHrE7S/K5HxT/pHoW3Ab
	 +44/wMQehcrbTaaiqvX1U+1iRpBXUP+ZCj8wCrleJWoWtSTBCmPuz5q1yLhJy4xY+Y
	 LiLItGt3vVIIuu8apfU6OXS8aT3G82I3zZabZhSrWfoYlAGsZf2jXB+hmYchU6PlsK
	 Hm+GApDiFlX1uLA8HU2DU2ZBSfGjmsPZSl3fFmB7gdnkY3MNuV+FvL1YnXHCRwQM0V
	 Zft539LpYjPOg==
Date: Tue, 23 Jan 2024 08:34:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Seven Lee <wtli@nuvoton.com>, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Message-ID: <20240123-bottle-elevating-9fbba5424014@spud>
References: <20240122095650.60523-1-wtli@nuvoton.com>
 <20240122-daunting-woof-19fac5689bb2@spud>
 <04945799-eded-42f9-b8fa-8907be44c400@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K+axl3EeoQm3ZSCb"
Content-Disposition: inline
In-Reply-To: <04945799-eded-42f9-b8fa-8907be44c400@sirena.org.uk>


--K+axl3EeoQm3ZSCb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 07:40:51PM +0000, Mark Brown wrote:
> On Mon, Jan 22, 2024 at 06:00:14PM +0000, Conor Dooley wrote:
> > On Mon, Jan 22, 2024 at 05:56:49PM +0800, Seven Lee wrote:
>=20
> > > +    enum:
> > > +      - 0 # VDDA
> > > +      - 1 # VDDA*1.5/1.8V
> > > +      - 2 # VDDA*1.6/1.8V
> > > +      - 3 # VDDA*1.7/1.8V
>=20
> > I would also rather than this enum was used to have sensible values for
> > the enum itself (which I suppose means strings here), rather than the
> > register values. Seeing "nuvoton,dac-vref =3D <2>" in a devicetree is n=
ot
> > very meaningful IMO.
>=20
> Do you have a concrete suggestion for how to more clearly write these
> directly?

I would use what's been given as the explanation comments for each of
the current enum values in the patch.



--K+axl3EeoQm3ZSCb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa959wAKCRB4tDGHoIJi
0irOAQDRL7yl6C/+n2xvB8NKEx9GHhK0OMyyTPuFK8pZ7FzO0wEAh+Kw6TfejHXO
fxYlVmNXWliNfWXXjY1AtBaOaIKg3Qo=
=wpIP
-----END PGP SIGNATURE-----

--K+axl3EeoQm3ZSCb--

