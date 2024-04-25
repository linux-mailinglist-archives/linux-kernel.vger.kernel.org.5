Return-Path: <linux-kernel+bounces-158963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C408B2767
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A347E1C2420D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C514E2CC;
	Thu, 25 Apr 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExqcqHuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6714A61B;
	Thu, 25 Apr 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065308; cv=none; b=EM3xrI5jxsUcv5zl8MFKiBRrvMxmSPom5JbqCLIhk/vTsEzcfHDmjKJKBnVnyhq8ZhicMuNL5Kkch1ge2fQH7YINAwItRVlRHDDl/w8vHmURMuahkkTUxJRnYHwu9pGBvIra5UyAOzfCrfQTSKe0lOKPjJy3/tBJZ5+JMirNZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065308; c=relaxed/simple;
	bh=m+ephHm0ktzUHv+2tMHBzb7a/y8rw/VfVyjK2cEuWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/hCO/Gdd8EyjZwuDKDuFt9N6GP0+48D6u1el7BGwDM4fizdJUkM3m6qZPVXZjv9n+ZdiNCGZVvUTLwdTBHC/anI0x3zDpKkvfIy1e+EWAoeJSDcZpAfG7UtNB5W/nLRIytXV5OKiXF3yoUOunYshiRsql5KHyb7wKzc1QkzMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExqcqHuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE9AC113CC;
	Thu, 25 Apr 2024 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714065307;
	bh=m+ephHm0ktzUHv+2tMHBzb7a/y8rw/VfVyjK2cEuWxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExqcqHuT/50DwLLO+RyJy0maUckYmNplHrF+X8bS2/2+2GfMfo0PeVaoA2YB49Scq
	 +KIFcZa131OFqCqeB/NZVbKlG+XoHcmvc67iVyoy+WS+rxBaFZ8mPzMaB9XjqYhvE7
	 FlMWWPNx2SF+4VNR6Snu6Xwllbre+37DQVbYoC1epUsfWkywWQjPNev0jm16i6/WGR
	 9b75RZxk45nThFadmZbcjg7k4wwy2jZRIk77ZAy6M2hBn+Y51jxa9N1hYuaDVXGb2n
	 u4Io65aoeRa2ZgS/zUX8ugjWMOdTaBR8bwG0EsB2hyVjgVQGO8/O0ZHbNOsyugWMG2
	 6ybwhCpdakKIQ==
Date: Thu, 25 Apr 2024 18:15:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
	linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-remoteproc@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v8 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Message-ID: <20240425-herself-brigade-5b6b53dc5133@spud>
References: <20240424190612.17349-1-afd@ti.com>
 <20240424190612.17349-2-afd@ti.com>
 <171399099843.670532.4326365049493230346.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TCVN+A/7bPxeCTEb"
Content-Disposition: inline
In-Reply-To: <171399099843.670532.4326365049493230346.robh@kernel.org>


--TCVN+A/7bPxeCTEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 03:36:39PM -0500, Rob Herring wrote:
>=20
> On Wed, 24 Apr 2024 14:06:09 -0500, Andrew Davis wrote:
> > From: Hari Nagalla <hnagalla@ti.com>
> >=20
> > K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> > The remote processor's life cycle management and IPC mechanisms are
> > similar across the R5F and M4F cores from remote processor driver
> > point of view. However, there are subtle differences in image loading
> > and starting the M4F subsystems.
> >=20
> > The YAML binding document provides the various node properties to be
> > configured by the consumers of the M4F subsystem.
> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 126 ++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-=
m4f-rproc.yaml
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
>=20
>=20
> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yam=
l references a file that doesn't exist: Documentation/devicetree/bindings/r=
eserved-memory/reserved-memory.yaml
> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml: Docume=
ntation/devicetree/bindings/reserved-memory/reserved-memory.yaml

The file is now in dt-schema:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/rese=
rved-memory/reserved-memory.yaml

--TCVN+A/7bPxeCTEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiqPlgAKCRB4tDGHoIJi
0sbaAQDUEiX6pWAsD/ZrFUySgnDTCekGE9Qk4UGS04emWMM5gQEAvfTX55Juni7i
C/c/kdcf21tIlJbRPz6ahqTIWokjAgc=
=X94X
-----END PGP SIGNATURE-----

--TCVN+A/7bPxeCTEb--

