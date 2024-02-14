Return-Path: <linux-kernel+bounces-64987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FD285463D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DCE1C218BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4761401D;
	Wed, 14 Feb 2024 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7zqyhsq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DCA134A0;
	Wed, 14 Feb 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903519; cv=none; b=LOrf8FVbRUEno7IvOOxKm/3s1ajVzmlceLvQuWE/mIgqt/emjCp5HrRutz9qnPyOVJv3NViraqGEXFRnrKYHS7LFuouXmrL4/SiTJEN5Ax4Pu9kwvl/N5D2fT9PxQgpRPDHZwE2otN5sJlYZN6MVYJsRVWRcaTVtrd1WDj/Bod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903519; c=relaxed/simple;
	bh=dz5V4kR1LuJbVIZ4dAGFdi8A2apYcjn87QSy+rVXNsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnBe06B61FHLQPYxgte4q4zNoSzCArWLX713RXFkmeFCyC9hXVT763STn1AGLd9sRh1BcAgenBPVXjWjdzig6j6fKEk5FSbOJjkQS9uchyvBK7ECfxa7ZA+L2mz0ersXD0EpqDWLTckk5HqQw98gYRBCRz1/XnsZrYvL9sbaxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7zqyhsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFB1C433F1;
	Wed, 14 Feb 2024 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707903518;
	bh=dz5V4kR1LuJbVIZ4dAGFdi8A2apYcjn87QSy+rVXNsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7zqyhsqWntTU0ZYqNqy+uJY0/kpfKgSqfIQgafxHQxLHh/aG4BMvKgKKSEyHKvVQ
	 nN3yua93J85s9bPWXEt48LUbWYNpPCbdHcGSA2ttpnUbsCWllg+dbGTeDKqUxkRhcf
	 DF0Jeyb3ibQCgsqx+F6hfsN4DB0aF+pr9lRdNtq3xH8pbwzzFZ3IMgD2HGkQsF90wD
	 FLFwvGjxZ4A8vJY0BBzkkgh8VPmXKb6D4STEqB+VRZvUapu3Xg8V03swFWwtPNRoNz
	 qS9kkvardxBYPALbHcUkYv/2CGiD42d4SSmPCWAawQCYo2MniV0Ykx2yGVdxHu+Pi0
	 AjUFtD2gJ3U7w==
Date: Wed, 14 Feb 2024 09:38:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: arnd@arndb.de, broonie@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	jpanis@baylibre.com, kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
	lgirdwood@gmail.com, linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, nm@ti.com,
	robh+dt@kernel.org, vigneshr@ti.com
Subject: Re: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI
 TPS65224 PMIC
Message-ID: <20240214-galley-dweller-1e9872229d80@spud>
References: <20240209-blitz-fidgety-78469aa80d6d@spud>
 <20240214093106.86483-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EFq+e2HVA4/N0Ifh"
Content-Disposition: inline
In-Reply-To: <20240214093106.86483-1-bhargav.r@ltts.com>


--EFq+e2HVA4/N0Ifh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 03:01:06PM +0530, Bhargav Raviprakash wrote:
> Hi Conor,
>=20
> On Fri 2/9/2024 10:41 PM, Conor Dooley wrote:
> > On Thu, Feb 08, 2024 at 04:23:33PM +0530, Bhargav Raviprakash wrote:
> > > TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
> > > regulators, it includes additional features like GPIOs, watchdog, ESMs
> > > (Error Signal Monitor), and PFSM (Pre-configurable Finite State Machi=
ne)
> > > managing the state of the device.
> >=20
> > > TPS6594 and TPS65224 have significant functional overlap.
> >=20
> > What does "significant functional overlap" mean? Does one implement a
> > compatible subset of the other? I assume the answer is no, given there
> > seems to be some core looking registers at different addresses.
>=20
> The intention behind =E2=80=9Csignificant functional overlap=E2=80=9D was=
 meant to
> indicate a lot of the features between TPS6594 and TPS65224 overlap,
> while there are some features specific to TPS65224.
> There is compatibility between the PMIC register maps, I2C, PFSM,
> and other drivers even though there are some core registers at
> different addresses.
>=20
> Would it be more appropriate to say the 2 devices are compatible and have
> sufficient feature overlap rather than significant functional overlap?

If core registers are at different addresses, then it is unlikely that
these devices are compatible. In this context, compatible means that
existing software intended for the 6594 would run without modification
on the 65224, although maybe only supporting a subset of features.
If that's not the case, then the devices are not compatible.

--EFq+e2HVA4/N0Ifh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcyKGAAKCRB4tDGHoIJi
0kAGAQCCU0bkl+s+BdL+d40Qr/mkOI5Ie4yq/1oBg7aALwQ3RwEAx4O9b5/Q5bbk
UfmurbkwjbQMV4Ls0UIFvMC7Mi8rxA8=
=byM7
-----END PGP SIGNATURE-----

--EFq+e2HVA4/N0Ifh--

