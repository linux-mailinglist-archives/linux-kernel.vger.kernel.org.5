Return-Path: <linux-kernel+bounces-97212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C77876707
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E09E1F241CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACC1DDF5;
	Fri,  8 Mar 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT9nEdlV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9E4400;
	Fri,  8 Mar 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910427; cv=none; b=ir9XJeNQBMn6AvOIQGadsffvZejZpqdbNujTNnLr9/dTLVWjcFE3kpD/0b/TuL+FQp+9ACxJhXWnEJzKo2M+PM7gifoG/WvMe/wvepT5DIcGjz5Tl8hz182rnLIzis3zWmh/fhP7157EL6SvGF4DALhTYVvcYESRbE+HsKImjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910427; c=relaxed/simple;
	bh=XegtA60T8R+RLnHB84R9oxyR1uF6txi9d6bccoJqnaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4RWbzjkqvjwrUCNw92pehoFRbPiGNT0d3uyJ4VFIWBpV4F9WbkpEXtFofVw38kebjMDoo73UkxXIbbtqJ0rd6FLYKW0JS8ZehWKyceb0YSemRJfGMldyv2w/DcbamYl8L9sPNQQdOnG26QGwtBQJG/QPla6EF472NDAcwJ9Ud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT9nEdlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E51BC433F1;
	Fri,  8 Mar 2024 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709910427;
	bh=XegtA60T8R+RLnHB84R9oxyR1uF6txi9d6bccoJqnaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tT9nEdlVawAD9BoXU6dAXfeqUsuIstVdxTmbsmAf1mK+ugPjykm80R8v0EdIBZsfr
	 Gc6q5ieDauBNL1OUrrNlD40V5MRsxP3fhPBgjzhVu6Hzm3rwIaekGWFEyrVY3j5C5H
	 O4fB4Jv/C0J9jHm15bvFpphAeuBo10qZOZV0lP5zABUNczHsohJhPDKRkD9QABgQUj
	 uECUJn1XEdR/ccG/UIdlRQ9/gGfwalTMR9CItc7WfPlmF/3tVhHJ12eXCQ3lBjoLv6
	 cSpHpO8x2cBdZzsB5dm1665qTsi/X9UPXEJFgvjvxJvO3ds9EYVdH0wgySJBFobl0n
	 5iYSCmxzqRXSw==
Date: Fri, 8 Mar 2024 15:07:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sakari.ailus@iki.fi
Subject: Re: [PATCH v4 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2
 Deserializer
Message-ID: <20240308-footnote-landmass-e1efcaf72a6d@spud>
References: <20240305152608.287527-1-julien.massot@collabora.com>
 <20240305152608.287527-3-julien.massot@collabora.com>
 <20240307-retract-aloof-9ff1fde79a82@spud>
 <8f6972a1-e174-4c0e-808e-afece9b529bf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Twd3rreSHEktHljN"
Content-Disposition: inline
In-Reply-To: <8f6972a1-e174-4c0e-808e-afece9b529bf@collabora.com>


--Twd3rreSHEktHljN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 03:08:12PM +0100, Julien Massot wrote:
> On 3/7/24 20:21, Conor Dooley wrote:
> > On Tue, Mar 05, 2024 at 04:26:06PM +0100, Julien Massot wrote:
> > > Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.
> > >=20
> > > Signed-off-by: Julien Massot <julien.massot@collabora.com>
> > > ---
> > > Change since v3:
> > >   - Renamed file to maxim,max96714.yaml dropped the 'f' suffix
> >=20
> > Why? The filename should match the compatible, which /does/ have an f.
> All the work has been done on MAX96714F variant of this Maxim GMSL2
> deserializer.
> The driver and the binding remain suitable for all variants of this chips=
et,
> since they share the same
> register mapping, similar features etc..
>=20
> MAX96714 exists in different variant: MAX96714 / MAX96714F / MAX96714K th=
at
> will be easy
> to add support for this binding and driver later.

Either document the non-f version if it really is that similar, using
all of the same properties, or name the file after the version you've
actually documented. I don't see why this particular case should be
given an exception to how bindings are named.

What is the actual difference between the f and non f versions? Is it
visible to software?

> The MAX96714 name looks the most suitable.
> Please have a look at this discussion on the V3 version
> https://lore.kernel.org/lkml/ZdXYpc2csVnhtZH9@valkosipuli.retiisi.eu


--Twd3rreSHEktHljN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZespkwAKCRB4tDGHoIJi
0qDHAQCSxd1xjjCo/nZv8eEWqflQQ8O36V8Sw0ttdF9jgDLs2wEA30sl7I0RGbXs
U1XvYdo1uUEMwWHYkc+terFhxnOUug4=
=desQ
-----END PGP SIGNATURE-----

--Twd3rreSHEktHljN--

