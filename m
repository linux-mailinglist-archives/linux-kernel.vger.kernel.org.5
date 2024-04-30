Return-Path: <linux-kernel+bounces-164495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80038B7E39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8811F21954
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC75D17BB10;
	Tue, 30 Apr 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPOTRj/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6017B4EB;
	Tue, 30 Apr 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497004; cv=none; b=lAgRbXNQJbLO5RcHaOecn0lnv0n45ZrFP9ceRY4D/eMWsPePsqQ+Wd7+4uvDX5wQZvGp5SLwq0w3MaYdS9cHnUk9FeYfZ201yHKIwqH2cwZ3gvxevrZ4sglI9zzXEgjNs7CY6ciNggCpQPnkbA2d4gZsgkMur4XAxX5OpZBzRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497004; c=relaxed/simple;
	bh=oS0wEIIVuLjHd8cAg9atHETWc00gOO4f/bvn8u2zung=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq8CSyFw2G785UT+mHfY+OIsGLiGOsahP+Gvlp9wMARydQQAMKsoLr0i2+8sBFlKDP4ZyZmcQ/s2r/sPuM6YkGix3bKdjgq0whgP78ZJ0OKX7BX7fIrIM7aiJ3qAG+gYaLpE7mJ9y8wCPXSOjW/5M4+bS3S2sfMtkk+Mb8sg9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPOTRj/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC49C2BBFC;
	Tue, 30 Apr 2024 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714497003;
	bh=oS0wEIIVuLjHd8cAg9atHETWc00gOO4f/bvn8u2zung=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPOTRj/pSHXu7HH0780Zg2qFPwdSz+xI5rhnE8huvbY2M8wUT0TKd6GZO/xcLPmeK
	 nMSpyGD8zgZRw57MnXstP5RUDLKupLULh2avjfOTGfa1nZ1o1RbbOx6cZRhXbVs1fX
	 8/oqsfSXTNR3ZT4aDnl7R/vP131ByBN6rsf+y57o1hhdCHwQfZJETY146WrLSxYpxK
	 NbuKKamoS6EL/jliapcS9kqt3UwgS5leAL0YYlRXjbj9wbKFpgIiTmW4e1I6yATdcc
	 Kv5AnZaZPwoJlM/WZ7QNAlxXzoIILTo+lJQLNQlqpZip9EfbHbd6cKk+KoG49DI77L
	 PgPOuOoxA03hw==
Date: Tue, 30 Apr 2024 18:09:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: renesas,sdhi: Group single
 const value items into an enum list
Message-ID: <20240430-idealness-breeze-4712d0798800@spud>
References: <20240430145937.133643-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240430145937.133643-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G7AmvMY0rSIjFKEZ"
Content-Disposition: inline
In-Reply-To: <20240430145937.133643-2-prabhakar.mahadev-lad.rj@bp.renesas.com>


--G7AmvMY0rSIjFKEZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 03:59:35PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Group single const value items into an enum list.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--G7AmvMY0rSIjFKEZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEl5gAKCRB4tDGHoIJi
0m3CAQDjLgFJMGkDVl6KC0ieY80/I+Y5urG4mVkM7QOuqiWtYgD/d1I3Qf+zy1Ca
KNZIUxZjNEZFpI+93O4C30JqCo0oaQo=
=cL2N
-----END PGP SIGNATURE-----

--G7AmvMY0rSIjFKEZ--

