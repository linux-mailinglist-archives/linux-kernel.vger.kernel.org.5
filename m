Return-Path: <linux-kernel+bounces-160410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59668B3D39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006471C22AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C1158D92;
	Fri, 26 Apr 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQCNwD/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1181DDD6;
	Fri, 26 Apr 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150365; cv=none; b=bQ5XdwkuTatevfoPQDAVEPLTn8HIcX8ov5h7nW7ilWs+8Ouzakokth6yTS9yUZGC3VfqOaR5jdp80q8jSzMFXxyLesEmw037G39CsbzZ5UWcvPojeQldqTH9A7VRyfN4C9fkuydItrQ+xvzuAKYyIp4kGKtzMhriBwr0+MchZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150365; c=relaxed/simple;
	bh=oy7M0iXV3Jc2uK9BPIoM43n9kP46AB/HVoIMmAA8lts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ+bOPF+pydLn+6FdzJE+/rh3H+cprUR3AlCLz/PmBGw2LZy7fIsrxNEvE0XnS5mvhnHCHYQzSRM3DTxQMW3JxwOz28jt+Bjcjxkw/75MxJok+B1w3u4UlyURgzC/PZ+aOhlsvulRU7nOFioa+eJNPpHX3cb0FteXgkdnZHHuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQCNwD/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE999C113CD;
	Fri, 26 Apr 2024 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714150364;
	bh=oy7M0iXV3Jc2uK9BPIoM43n9kP46AB/HVoIMmAA8lts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQCNwD/0EhDY7ObHVfGsSQj0XNHGVJacPU6VY2eYMxEmTaoH8W1073AGtDAfsWJyG
	 gJBC4qg+2dkiysJvKY5U83xLYYNU0KlmEfdHb6Y2m37PQ8FT+r9r3H3b14BaTKjMNF
	 LD6CeURfSLiG++/6jZ4corsGc6FJ2IqncdyxwlYZkHLpym1TR/8fi1b6lySLM7IjnO
	 N3av+NwYEAH1CXkBR6mopyJ4A4ChoiWSBIPEDqAycAwcbFnkziLMCgb+Aq5a6tfKNf
	 S1ENVGFdJbQK9Dh5Sb3Gd5et/ufaBrxjLoDhxkUMapxvhMFXqOS/D3rXhOmXPttLex
	 p8hDxgoobOwJQ==
Date: Fri, 26 Apr 2024 17:52:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
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
Message-ID: <20240426-iodine-unclamped-c5b74361761d@spud>
References: <20240424190612.17349-1-afd@ti.com>
 <20240424190612.17349-2-afd@ti.com>
 <171399099843.670532.4326365049493230346.robh@kernel.org>
 <20240425-herself-brigade-5b6b53dc5133@spud>
 <35e37395-c6d9-42ef-839c-bac47b50f3bf@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+4EvlqZoEW1CXVa2"
Content-Disposition: inline
In-Reply-To: <35e37395-c6d9-42ef-839c-bac47b50f3bf@ti.com>


--+4EvlqZoEW1CXVa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 02:03:36PM -0500, Andrew Davis wrote:
> On 4/25/24 12:15 PM, Conor Dooley wrote:
> > On Wed, Apr 24, 2024 at 03:36:39PM -0500, Rob Herring wrote:
> > >=20
> > > On Wed, 24 Apr 2024 14:06:09 -0500, Andrew Davis wrote:
> > > > From: Hari Nagalla <hnagalla@ti.com>
> > > >=20
> > > > K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> > > > The remote processor's life cycle management and IPC mechanisms are
> > > > similar across the R5F and M4F cores from remote processor driver
> > > > point of view. However, there are subtle differences in image loadi=
ng
> > > > and starting the M4F subsystems.
> > > >=20
> > > > The YAML binding document provides the various node properties to be
> > > > configured by the consumers of the M4F subsystem.
> > > >=20
> > > > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > > > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > > ---
> > > >   .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 126 +++++++++++++=
+++++
> > > >   1 file changed, 126 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/remoteproc/t=
i,k3-m4f-rproc.yaml
> > > >=20
> > >=20
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >=20
> > > yamllint warnings/errors:
> > >=20
> > > dtschema/dtc warnings/errors:
> > >=20
> > >=20
> > > doc reference errors (make refcheckdocs):
> > > Warning: Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc=
=2Eyaml references a file that doesn't exist: Documentation/devicetree/bind=
ings/reserved-memory/reserved-memory.yaml
> > > Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml: Do=
cumentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> >=20
> > The file is now in dt-schema:
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
reserved-memory/reserved-memory.yaml
>=20
> So should I use "reserved-memory/reserved-memory.yaml" here, or just
> drop this line completely?

The only other example that I could find that didn't reference the text
binding (which points to dt-schema) said:
"(see reserved-memory/reserved-memory.yaml in dtschema project)"

--+4EvlqZoEW1CXVa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZivb1wAKCRB4tDGHoIJi
0sFAAQCE26iVq+TBfiAaSZAlbmVskHWiA0rzfsJCTpipRqEv1gD8DwDsmF1fYkkF
Y9pheRDvXsneCjGJmeN7gV3XdJj68QE=
=BPm1
-----END PGP SIGNATURE-----

--+4EvlqZoEW1CXVa2--

