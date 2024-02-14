Return-Path: <linux-kernel+bounces-65020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EB78546CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8A51C22F48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F931756F;
	Wed, 14 Feb 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEIeFAEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC085171AE;
	Wed, 14 Feb 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905210; cv=none; b=lmiJs/RJlM2E1XyxhY4xuOf9dXwiEqQXFcsrBpM4iydM7R29I4HkOEcOWKYVETd4uo0oZJH0HfnUSVJuRRhxj2wmnfpfYNuhoim6P1hwSzkPOn70EkQWBaIQK6PuZ5peXgptf07DmsEsIxgZ1zREVHfAX2vTDsYypdp9iMuTw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905210; c=relaxed/simple;
	bh=xnJOc4z//DOjfKlx8+OsKAL8Ga16tYDqx+CAITnN62Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8aZo8Mgex5kVFWVQ/ltApnh3m4F27CtZpPm1Q4Vapu3Ony9lH3k3nN3hsC7DYkLA9uXwz4SwVq1NNMgAi+uh421fCgLrXgfd9NsdH5zx/14/fLgTfIC19smMfFuGk5ujNckFmCgflCwbepo1qFwz6bn1kh0sNj3KjueJWEc2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEIeFAEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67D9C433F1;
	Wed, 14 Feb 2024 10:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707905209;
	bh=xnJOc4z//DOjfKlx8+OsKAL8Ga16tYDqx+CAITnN62Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEIeFAEabfVaJlHVQUx7gy7CMJqfiDCHXwmKI2Q3EtXXl9CIlPPmPNdGwOMm4GlXw
	 pVqe8n/wjChC71Gw2lWLq6cMk7djaFqNGOikZZORFb4CTlg4tNp7KkrHy4pLrFMqvl
	 do8Sherb+C43R2vc80w14BFe457qgOs7vXRiUrPLeJPQ7spwnj0f4pStnCX245WD2f
	 7s6yiZY3uz5/7EeHiit/dcsoudDQBOfL5yZfib9JkAUA/oVO/LJc65zjEkzoTBKVmI
	 QC4/wvHjEJn0eVGbiz9bhn9UBM48Yjht46O51IoP8o1dcthzymMThf6tyl2FbxWL+/
	 sARjWgrYJXTkw==
Date: Wed, 14 Feb 2024 10:06:44 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible
 for MT7988
Message-ID: <20240214-reversion-arguably-37bbee9caf78@spud>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213-resource-evaluator-0754cfd5882d@spud>
 <d4391868-ddcd-4f66-b539-28d245fa83df@gmail.com>
 <e957b044-fe84-4b72-bdf1-cbc40c722019@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mPF6YbHq+X8lxM7g"
Content-Disposition: inline
In-Reply-To: <e957b044-fe84-4b72-bdf1-cbc40c722019@collabora.com>


--mPF6YbHq+X8lxM7g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:27:54AM +0100, AngeloGioacchino Del Regno wrote:
> Il 14/02/24 07:34, Rafa=C5=82 Mi=C5=82ecki ha scritto:
> > On 13.02.2024 19:18, Conor Dooley wrote:
> > > On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafa=C5=82 Mi=C5=82ecki wro=
te:
> > > > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > > >=20
> > > > MT7988 has on-SoC controller that can control up to 8 PWMs.
> > >=20
> > > I see a binding and a dts patch, but no driver patch, how come?
> >=20
> > I believe that to avoid cross-trees patchsets (which are sometimes
> > tricky for maintainers) there are two ways of submiting such changes:
> > 1. dt-binding + driver; then (separately) DTS
> > 2. dt-binding + DTS; then (separately) driver
> >=20
> > I chose later in this case as my personal priority right now is to deal
> > with all MediaTek DTS files.
> >=20
> > Is that wrong or unacceptable?
> >=20
>=20
> It's not wrong but it's partially unacceptable, at least on my side.

> I want to put emphasis on sending the binding with the driver, as this al=
lows
> for a better review on everyone's side because we do see the full picture=
 and
> we can give better advices: in this case, I'm not sure whether adding a n=
ew
> compatible for MT7988 in an enum is a good idea, as the compatible string=
 may
> be shared with one of the *eleven* SoCs that are supported in the PWM dri=
ver,
> meaning that (hardware speaking!) the PWM controller in 7988 might be the=
 same
> as the one in mt1234.

Re-ordering to make my reply make more sense...

> In my opinion (and I believe many do agree with me), sending the binding =
along
> with the driver is the right choice, and if you also want to include the =
dts
> that is also appreciated: series can go through multiple maintainers appl=
ying
> subsets - it's ok to do.

Ye, either of those two makes my life a lot easier. I can then at least
go and check the driver patch to see if things match up. In this case, I
would want to check that the driver requires changes to support this
device, given the commit message mentions nothing about the difference
between this device and others. I'd still probably request that the
commit message be improved to explain the lack of a fallback, but at
least I would be clear about what I want and could provide a conditional
Ack.

If you're not sending the bindings patch with the driver, there's an
extra onus on you to explain exactly what makes this device incompatible
with the other devices in the enum, although in an ideal world it'd make
no difference and every bindings patch would contain that information.

> >=20
> > > Also, what makes this incompatibly different with the other devices in
> > > the binding, like the 8183?
> >=20
> > It can control 8 PWMs unlike any other SoC block except for MT2712.
> > It uses different registers than MT2712 thought.

Put this information in your commit message next time :)

Cheers,
Conor.

--mPF6YbHq+X8lxM7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcyQtAAKCRB4tDGHoIJi
0ueXAQDCS+trr+ex9ySxR5bxD0kVm8SrRFLeLixgJlLEsQasHAEAiqnEQG8s/IH4
xMOno6DMMEiw9aCzIyGoQTTN4Ied7wg=
=QoHf
-----END PGP SIGNATURE-----

--mPF6YbHq+X8lxM7g--

