Return-Path: <linux-kernel+bounces-26259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A082DD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AB928291D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9FF17BAF;
	Mon, 15 Jan 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIx8PqGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA317C60;
	Mon, 15 Jan 2024 16:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBFAC433C7;
	Mon, 15 Jan 2024 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705336167;
	bh=v4JtTtNp1XjaHbqrDnU21jrjvuE4hRW/h7O6EdQVHVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIx8PqGDhvLUU6iKrLE9NIqw0b98BVF6tcEZWjKxRok4xzM5ozF7Op+pCsUqPh3O0
	 NPo8qmWgkPBo3IaARReSo3WIJGWIWjUkMKWOiEmIaGfOfrkdTgm8cMgJa6JrTWXp+o
	 xOO+h9Wlet9Mkt9c9bkVdV4WFqeQveQvmXUiDvNgr8e9KdyNp8VZZAJEEoqfNwsdhR
	 F2gmEqrWmu7MZDxO34373mEK3sZz1TNy0WQHwycd8fZP1ud5ZolYEssUh6uV82YFmS
	 /VG2cmDygYplGcxQKv0CrR+fxCNRfyM0qXGeucKjo9I5Uz3varPR3WZpF0DXUled/R
	 wDRnQPACEKWhw==
Date: Mon, 15 Jan 2024 16:29:22 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: ignore paths outside kernel for
 DT_SCHEMA_FILES
Message-ID: <20240115-fragment-clean-95ef01dd8b20@spud>
References: <20231220145537.2163811-1-andre.draszik@linaro.org>
 <170432630603.2042234.10993333941885772911.robh@kernel.org>
 <827695c3-bb33-4a86-8586-2c7323530398@amd.com>
 <bcd89ef7a43eb7d652f045c029d8e108adf7ba32.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BnbWovGOalBWOCff"
Content-Disposition: inline
In-Reply-To: <bcd89ef7a43eb7d652f045c029d8e108adf7ba32.camel@linaro.org>


--BnbWovGOalBWOCff
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 09:40:37AM +0000, Andr=E9 Draszik wrote:
> Hi,
>=20
> On Mon, 2024-01-15 at 10:20 +0100, Michal Simek wrote:
> > This patch is causing issue for me. Look at log below.
> > I am running it directly on the latest linux-next/master.
> >=20
> > Thanks,
> > Michal
> >=20
> > $ make DT_SCHEMA_FILES=3D"Documentation/devicetree/bindings/arm/arm,cci=
-400.yaml"=20
> > dt_binding_check
>=20
> It'll work if you drop the 'Documentation/devicetree/bindings' part from =
the path, as
> it is implied since bindings can only be in that directory anyway:
>=20
>     make DT_SCHEMA_FILES=3D"arm/arm,cci-400.yaml" dt_binding_check
>     make DT_SCHEMA_FILES=3D"arm,cci-400.yaml" dt_binding_check
>=20
> both work.

Requiring that is pretty user unfriendly though I think, passing the
full path from the root directory of the kernel tree would be my
assumption of the "default".

--BnbWovGOalBWOCff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaVdYgAKCRB4tDGHoIJi
0laCAP4jU0j0zR/qRpoaS6nQ8SKWYWKcVvWeRmzVmMAjz9LbVQEAxLCc8b0EM5WB
j1LjeGr6Fpt66iuBc/xm5rVXCCCbVw0=
=dYvI
-----END PGP SIGNATURE-----

--BnbWovGOalBWOCff--

