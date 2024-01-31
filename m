Return-Path: <linux-kernel+bounces-46763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E58443CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899EC1C21DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2373A12AAFC;
	Wed, 31 Jan 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxkfYglX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C812BE8F;
	Wed, 31 Jan 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717442; cv=none; b=Hx2I3tgEJRMufa6njlUZcbS9QIrRfMRyXkcA0+WDualUiU3jlR3Rw5r5jWpxiWz2RZvmILt0wYkW48AyMIjhF1mYh7Ncf02Ezt8VTw7TMFBFUzyRNUaYbmNmRLTnsYUtQxq9cl/Gl046VeljTEog+asqXEV67iCaKVD8h8/KRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717442; c=relaxed/simple;
	bh=hwmB+C/u/by+wrZ26oOJ2Ax1b/vEvnFtb7tDhr+WVQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGpZPFcyYf1IqjAMHJeJ4Vq5V/okYLYciRe8uc7ejIxtjQ9CONlPq5b3RrGM4aUf2mksNZ6R9wGBK4g5Hwxvnr08FaSeHkyFnpdYURqR45j/PgHkIN56TXNGBW89KMT2LeTUSpi9kBbuhRstADX2rAwtK5YA7I5NDZD/NGYVP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxkfYglX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56196C43399;
	Wed, 31 Jan 2024 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706717441;
	bh=hwmB+C/u/by+wrZ26oOJ2Ax1b/vEvnFtb7tDhr+WVQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxkfYglXwQLizeqK+ZLtRxhktWMZu9Hg2cZMRNwxV4MIBcpQr69apiNbJmt1qBkv3
	 iuxbzov2L0+anI1U4WGNp1XChsDh6KVt8Yc/VnQXUduuIagmwuaLjyvJeWf/lV6vNC
	 xlk/v3hyJ9D8/0TzAQLPSbCm8FW+B1ZygM1gtidZxYtRONu/cKgX0ikE0RCZo8Q9xj
	 bL93Oo1JYqUwNGUTwy1aoBONgyVuivcRNDoddOYCWICSB57x1pZ5/V6+i8SRbQ4QD4
	 jucz5CfjY3QUwLGtNA293v150PPQ/JT/bRy7Y/BggqHLnOV+rRpUi9beHxJB+WuMoT
	 4E7seT4G8sngQ==
Date: Wed, 31 Jan 2024 16:10:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav <clamor95@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add LG Electronics,
 Inc. prefix
Message-ID: <20240131-undercoat-rewash-1770ce13b556@spud>
References: <20240131105153.8070-1-clamor95@gmail.com>
 <20240131105153.8070-2-clamor95@gmail.com>
 <20240131-elderly-passover-341b89f65189@spud>
 <656FDD69-D7B1-4910-B848-108CB985AAAC@gmail.com>
 <20240131-tractor-roundish-f6f90b5bd640@spud>
 <BCBF1994-C5AE-4D2B-B645-C3C67BE19000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G4dIpqmRG0duvBE0"
Content-Disposition: inline
In-Reply-To: <BCBF1994-C5AE-4D2B-B645-C3C67BE19000@gmail.com>


--G4dIpqmRG0duvBE0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 06:06:58PM +0200, Svyatoslav wrote:
>=20
>=20
> 31 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 18:02:31 GMT+02:00=
, Conor Dooley <conor@kernel.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> >On Wed, Jan 31, 2024 at 05:30:58PM +0200, Svyatoslav wrote:
> >>=20
> >>=20
> >> 31 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 17:28:49 GMT+02=
:00, Conor Dooley <conor@kernel.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
> >> >On Wed, Jan 31, 2024 at 12:51:50PM +0200, Svyatoslav Ryhel wrote:
> >> >> Add missing LG Electronics, Inc. prefix used by some older devices.
> >> >
> >> >Is it? You're only adding these devices now as far as I can see.
> >> >
> >>=20
> >> Hammerhead (LG Nexus 5)
> >
> >I have absolutely no idea what this means. Please link me the in-tree
> >devicetree of the user (or the patchset adding it).
> >
> >Thanks,
> >Conor
> >
>=20
> Sure, here you go
> <https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/ar=
ch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts?h=3Dlinux-6.4.y#n11>
>=20
> So devices I have sent are not the first.

Thanks.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--G4dIpqmRG0duvBE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbpw/AAKCRB4tDGHoIJi
0kuxAP9L5NyTrY0gnYlNY5TKeYQVjvpJcrsKdkdNiyFCpnjlgQD/cIOPTZUVf3Ns
BJYUPoowiN6VqIj9snqVCmoG8Ph2nQE=
=SEyq
-----END PGP SIGNATURE-----

--G4dIpqmRG0duvBE0--

