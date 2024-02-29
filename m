Return-Path: <linux-kernel+bounces-87215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6186D134
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81C91C20E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9547580A;
	Thu, 29 Feb 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7dVqRy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50508651A1;
	Thu, 29 Feb 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229256; cv=none; b=ktzZisH0YwCRG1TIvYRUJRmuDY4nBg3DoElFgC4R0L+ZSGsN3jTm6KGf22oOVFYZFhan678TgjtRnNcOPEcR7GxiOVRUmlGmZYpir0hkHM33cCxhsold29SAP2p3vgoMK7O3xe7UiCnc8TO7wiNQ40eil9Wr1DlaTRulYHp2vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229256; c=relaxed/simple;
	bh=/UMEnyyhRyF9Pjefi/dD8N9hm6l2W4RsvKVlb5y5evo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G58u9M3Ngugm6ZqwEYPLCdPdV8y5l6iAFpr0FhWNZGFyz1Pi8SoXJZuoSxW36X3OS3BWSmqe4wMrbISV2wWEVq/7Qd7afvWI2MyAO8gMHbmZzy8V0zbleNVwrZQpii8yVi8c94puoCOVqdVhCmTP550lmvWr0fSjK2k+SKjICOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7dVqRy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C54BC433C7;
	Thu, 29 Feb 2024 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709229255;
	bh=/UMEnyyhRyF9Pjefi/dD8N9hm6l2W4RsvKVlb5y5evo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7dVqRy9GIaUv6QtQsaFe5PfURVdXM1AshXWiT9ZJk3hepfHhWf2+eOuJkSfHGUkx
	 qKWFnAcghZd6QgXCnaput2tZ3AwmvJK93Ygdl7JI0P/HmjfiOzSW1F6Aq87edhAE4V
	 bEu3w6l7MXSRUz8zBHNTUWhJ5Sz52Ujwytby7Bvg4GFZynIF0LvzeJnN7EkBVe0qUp
	 H/hXkUGZuFHfSdPLw7pnbiprrkd138ETnbAOkjCIhC1r0GwxxfNO0EH+DZHooZB70i
	 WsgC+07jq6CPfp2vJZbzBsxT8F35mqwy85gwHEUiXR6hBMt5HaH3wbDYa2Vhbc3JDj
	 B1myWaajAeJKA==
Date: Thu, 29 Feb 2024 17:54:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add Crystal Clear Technology vendor
 prefix
Message-ID: <20240229-woven-lively-1d90687b2d03@spud>
References: <20240223134517.728568-1-jeremie.dautheribes@bootlin.com>
 <20240223134517.728568-2-jeremie.dautheribes@bootlin.com>
 <20240223-prepay-stadium-f09044e3e123@spud>
 <23832e29-5bf4-4dab-ac00-4a4090233c3f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q7xXagaWtGMrPzGa"
Content-Disposition: inline
In-Reply-To: <23832e29-5bf4-4dab-ac00-4a4090233c3f@linaro.org>


--q7xXagaWtGMrPzGa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 09:54:59AM +0100, Neil Armstrong wrote:
> Hi J=E9r=E9mie,
>=20
> On 23/02/2024 19:22, Conor Dooley wrote:
> > On Fri, Feb 23, 2024 at 02:45:15PM +0100, J=E9r=E9mie Dautheribes wrote:
> > > Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
> > > include "cct" as a vendor prefix for "Crystal Clear Technology". CCT =
is
> > > the vendor of the CMT430B19N00 TFT-LCD panel.
> > >=20
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > And add a
> > Link: http://www.cct.com.my/
> > as that actually explains why "cct" is the right choice.
>=20
> Can you send a v2 with this change ?

Does your workflow not allow you to pick up Link: tags while applying
patches?

--q7xXagaWtGMrPzGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDEwQAKCRB4tDGHoIJi
0gOYAQD8gdAfyltMcKsTe8gtkAcHUuFJ103breikb9/WgYuaKgD8Cwb3P1gxWrRS
Gs+AZRfEnLD5LcwisP3RADU1M85cfQw=
=867m
-----END PGP SIGNATURE-----

--q7xXagaWtGMrPzGa--

