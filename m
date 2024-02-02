Return-Path: <linux-kernel+bounces-50161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BCD84751A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDF21C222ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2F1487D2;
	Fri,  2 Feb 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkktAUJJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C4C2D7;
	Fri,  2 Feb 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892060; cv=none; b=pL80NkbqpEUByQ8uYE0T+TCf9kEM/HWFN9muAGDXYug3u2fcTfkfm1e0jecuBeKw5/xfcd9hR20iFUmOI4N1Y5lQW9bNwGedap6yRCBy+GwwMlEXhXlaxisy0+zcEFWvhObkDwlzfB5JRXMKZ78qXCa3k9hwMYpOqJzXbV6I13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892060; c=relaxed/simple;
	bh=gdl0f+i0PXgN4P/QL2Ew6vbd/GZUjGl8juXLLSYujoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEmWAkzJltq4ZJLZG2yoO5SN9R9DznxeZtrUlpF4927csy8Kvb7jV10hQignM5UBdQWjP1rcCInnfCmk+9Sww3Ro3ltV/ryxJjXKz2pe/yVxMB4IPji/gZmZeJojrOPvzEOnct8DnLevDiczGNd0FmnhiA/z53+lg6ySM+Webc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkktAUJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0723C433F1;
	Fri,  2 Feb 2024 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892059;
	bh=gdl0f+i0PXgN4P/QL2Ew6vbd/GZUjGl8juXLLSYujoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkktAUJJgD8/U43goOnrlxN/8BI4Grw8fY7Ivem2EH6bj4zuizMGLK3b8ViGFF4i2
	 zemezv0z5pdfy7D38bhWWhkyt5USFZkpFHy/hhuoMLqCtT2yvWP44so97ZkeUFbgst
	 hOvk+TDE05yXBqL571gZpqZBSHk8LUgnk1g094RVDqRIAwCl4jGflQXhEEK2kilUPG
	 jsOaYjJwN47qkSujqqFd+Qumyo/816LYwCB+hqxxiheQF3L6wwgDL4Zu01cloxpTuS
	 fSpYguW8Ayt+DqUYfKXTJJk7hbBdublbLK3tn2HRdLenT+JU/wxqH6IHL+w7eNEwID
	 vhjuyLVlBBYfg==
Date: Fri, 2 Feb 2024 16:40:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 8/8] dt-bindings: watchdog: renesas,wdt: Document
 RZ/G3S support
Message-ID: <20240202-bacteria-genre-aeb373023f4b@spud>
References: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
 <20240202075849.3422380-9-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U8/7lj7TDOE26hKX"
Content-Disposition: inline
In-Reply-To: <20240202075849.3422380-9-claudiu.beznea.uj@bp.renesas.com>


--U8/7lj7TDOE26hKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 09:58:49AM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document the support for the watchdog IP available on RZ/G3S SoC. The
> watchdog IP available on RZ/G3S SoC is identical to the one found on
> RZ/G2L SoC.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>=20
> Changes in v3:
> - re-arranged the tags as my b4 am/shazam placed previously the
>   Ab, Rb tags before the author's Sob

What's wrong with that?
You resent the patch, so I don't think there's any chain of custody
issues there.

Cheers,
Conor.

--U8/7lj7TDOE26hKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0bFgAKCRB4tDGHoIJi
0g5pAQCpkJOLa7E3TMp29A7DxaBnGTGsPkm5uwCA2OaeQC4RLgD+Jj74655Uch/a
nzQ+5VvEpBzzO/dpERfeOJ+4Urn40Qw=
=VZJS
-----END PGP SIGNATURE-----

--U8/7lj7TDOE26hKX--

