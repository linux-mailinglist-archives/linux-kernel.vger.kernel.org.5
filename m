Return-Path: <linux-kernel+bounces-164283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474128B7BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6A8287D21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC6C173323;
	Tue, 30 Apr 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Pn5w5B/O"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5A172BBF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491016; cv=none; b=j2N6ya8hhGNLZNLSilNeOgmBHXpb0aBzl3DzrIO8Ur/rSlskBQDuhduGb2S+2AaDpX9mVQ0ovB678uhB7mkf+N0UiAyzr0NfFNoqPFAm0nRuGTFREJM+RjwtpvPnMhh17gMk49bLIxAZms2xxLQQmlCjHN8PmXqprH+sn57Hr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491016; c=relaxed/simple;
	bh=wbobWseKrGYHVkcEwvVX3EY5BtSLI0zg/BxZgONR8Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2pSLRomSk/X4Ai2NJ52+Q3yVG0gSH+YZb/7ru9CwuFyiyRbFtmnxhaVLGUZ+uN8W1275QlCOUs97yeVqpJmTc8HcbQemvOxmmgZjLjD7NnzU7mRRAU7S6u908CP8XMkS2EMkP24pjiUZncBR6npe2RfqmFwVmt8OBixx+S/JA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Pn5w5B/O; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wbob
	WseKrGYHVkcEwvVX3EY5BtSLI0zg/BxZgONR8Ug=; b=Pn5w5B/O1Gt18ZhsqSUe
	uskHgd9433vDvqSAwNMU1CkzdnEb1EQL3fwJi11DO35ZGo0eTuGYcju0EtCXbmz7
	uBuOT3oeJl9sd+xXeXjVbrQzWET77x7T3Z9OUuDZQPP/6AepvrpnCgGSzDwYHsb3
	I1J4gf9UTk4JI9ivcOxL3G/PLBt5KCaWNCJdTZCVnShQ9zGPb1HLF8T+TDpFgE3K
	D1cXn04w3Qv6RUTUOGo84NUb27VZI/iMsS42RplftD4FVhtjt0fG2j7rdbaSR3Wg
	Nz8G6gMuqyimGZIQ9Tt6YmYjFLW0KNIieFIwJ6XEobXvsknyjKXU2UYtp7ErPGkC
	8A==
Received: (qmail 2682117 invoked from network); 30 Apr 2024 17:30:08 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 17:30:08 +0200
X-UD-Smtp-Session: l3s3148p1@gQyHC1IXutxehhrb
Date: Tue, 30 Apr 2024 17:30:08 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 3/3] mmc: renesas_sdhi: Add compatible string for
 RZ/G2L family, RZ/G3S, and RZ/V2M SoCs
Message-ID: <ciqlmdcx6hwvlk3efncupchcao2va64sd3bm2j2e7kyzxnvxd6@uoakx5scqcht>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Prabhakar <prabhakar.csengg@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240430145937.133643-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240430145937.133643-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xron5noqgkndxqqa"
Content-Disposition: inline
In-Reply-To: <20240430145937.133643-4-prabhakar.mahadev-lad.rj@bp.renesas.com>


--xron5noqgkndxqqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 03:59:37PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> - RZ/G2UL and RZ/Five ("r9a07g043")
> - RZ/G2L(C) ("r9a07g044")
> - RZ/V2L ("r9a07g054")
> - RZ/G3S ("r9a08g045")
> - RZ/V2M ("r9a09g011")
>=20
> The above SoCs have HS400 disabled and use fixed address mode. Add a
> generic compatible 'renesas,rzg2l-sdhi' fallback string for these SoCs,
> where fixed_addr_mode and hs400_disabled quirks are applied.
>=20
> For backward compatibility, compatible string 'renesas,sdhi-r9a09g011' for
> RZ/V2M is retained.
>=20
> Also rename sdhi_quirks_r9a09g011->sdhi_quirks_rzg2l and
> of_r9a09g011_compatible->of_rzg2l_compatible to make it generic.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--xron5noqgkndxqqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYxDnwACgkQFA3kzBSg
KbbRgg//S4Xm5OVO1Pr2gWeQssVi/mLM8xNqK39lxA97jrIx9zq8MWyoOex4Jn/M
d4/bjj6XH/H0bk1g9eW3KnLtR+C6ySG3ujtUEAN96zoip1TGueIOPmmfhRuAr+0i
MXeA9Y0kOoNBGhDRFiZW6nrlfBzPiH+DOy32WpVULjncAMuIHX+O9pQtho72SocW
WgRd0F6ox6muEP2dI6ysthrak2C7O8YzKB7P2yGgTYgGtLkMLN8WfUBLnM9POGDI
Mmj5Ry9y7EGH9GpjC8UC37eeeoO7SC7+LGAedc7AKyK4WgghHTWVREBsDzJ02yYz
KgWeFZHdqVwdkvwp1vDq/qkM/gP3ALmRLNz4N5Xh8rv2Vs0hrh5FgF3TcS/Y96uh
7clbxlM8QZKZl5MCjTgzcTNC1vl0JKuafg20ZD//4p1eSrHBn6Lq+i5Sot16UAT6
Mt2RHo2DDx32b/eSjcsRsoaI0m622f7ZZju+wzsxBBau3F4NmgB8+IEjI4wgzSbo
GNwxC7GFk0KHlE23w3OEiE7gEyVopFbvzA0PCCXvACcQprGIAXVqjVP2arVN5x+V
R7HEeW+pyQ4sHlZT086dsZrVU/p7sThEhautNZe5U+k8aPLqdnTDOJOKEJyEghrH
sy9QPuY9BLHli8X/F7NDTr23YP7ws584PKNXn5VUWEizhsmK4EM=
=jowC
-----END PGP SIGNATURE-----

--xron5noqgkndxqqa--

