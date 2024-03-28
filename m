Return-Path: <linux-kernel+bounces-122777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB4A88FD18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C9E1F28E35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964047CF18;
	Thu, 28 Mar 2024 10:32:37 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB9374EF;
	Thu, 28 Mar 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621957; cv=none; b=GUjHvFUan4EJP1jXpKQ0tYyQAvktgBM8yFHnr3cs/89J8RuAToAsOEqwO42nv8gym+DAmiSTSHscCxXZHcQLAxOeDse21BRozLfGmhMG/j7+Puu1Vq/g3bmMp9KN3SOd9XIXUcwmM5aeGryJo1ja10/6vYz2Gv+ozIvIwpfBAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621957; c=relaxed/simple;
	bh=gJjwnPA5KjooGl87TFDJ3ZltuPlXUlbe+Rsm9exKeC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRY+J2hvK8AnDRuDTEjDrBkevFHQGAlKHHNBVvN2Ar9eTcnkPVGYdGxf0DMYT7rFCiPlHhEX6PNnhzeAXkrNHU3EnqVFwZ4jbzXg0rmkjnEFwlpPK/ny1KlGCJGg36LroEQXsRpqZjmpYS1MWAIKpv5geZ5g8TfDc5KB9gG7gNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3E65D1C0081; Thu, 28 Mar 2024 11:32:33 +0100 (CET)
Date: Thu, 28 Mar 2024 11:32:32 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Chanho Min <chanho.min@lge.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6.1 039/451] arm64: dts: Fix dtc interrupt_provider
 warnings
Message-ID: <ZgVHQOxoMtMyoM5X@duo.ucw.cz>
References: <20240324231207.1351418-1-sashal@kernel.org>
 <20240324231207.1351418-40-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D92MlPntT2pFP0sD"
Content-Disposition: inline
In-Reply-To: <20240324231207.1351418-40-sashal@kernel.org>


--D92MlPntT2pFP0sD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 91adecf911e5df78ea3e8f866e69db2c33416a5c ]
>=20
> The dtc interrupt_provider warning is off by default. Fix all the warnings
> so it can be enabled.

Does not fix a bug, does not belong in stable.

Best regards,
								Pavel

> Signed-off-by: Rob Herring <robh@kernel.org>
> Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com> #
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com> #Broadcom
> Acked-by: Chanho Min <chanho.min@lge.com>
> Link: https://lore.kernel.org/r/20240213-arm-dt-cleanups-v1-3-f2dee129252=
5@kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--D92MlPntT2pFP0sD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVHQAAKCRAw5/Bqldv6
8pKJAJoD29/iXsgbXvJqPWh8fvbA3zP1sgCgpeXKl2soxiMgFzR66rrOw+Ne7ng=
=Nu0/
-----END PGP SIGNATURE-----

--D92MlPntT2pFP0sD--

