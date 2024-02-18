Return-Path: <linux-kernel+bounces-70538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB4E8598F7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BB61C20F8B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977486FBB7;
	Sun, 18 Feb 2024 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZTiTJ3UV"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53B2B9A7;
	Sun, 18 Feb 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283423; cv=none; b=M7z4Gwpq1TDgQPA0aaX95CeFzHgcuXAY3KGn4kUMEJYMxSnRF9pI+2wSBdVm0Jnr4P16vkVjZNyfvXF4fvhHiF2aeaIpKfYTOeMAZEPLZBG3PMQyYHGvjrYxoPWz/9GKJf62fq1svJVmzJ1t3G8/WsWdqCuKhvmU3QO4ZZOxOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283423; c=relaxed/simple;
	bh=/H62QMDTLmM1dXDrq6dNaaqlML8aeDxPeyDcHN0WyrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZWLfAZGGUY6K/k6u0JHoay2YNqo3mOuZgnqTr698854uhsbQsh3CP/3j2cLm58VQmXIXK7GzdW3+qh39sQj0eYMDdd6Se9YJgmDATlHBiciZXMWUxHOLtjkOuEVYDXBCSHLMAr8ABaGuMX3fSiEKm/RtarCMmPds5iMi1cYy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZTiTJ3UV; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9689F1C006B; Sun, 18 Feb 2024 20:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708283419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFAnKsSUhODm3ulUCr0ZKCb5X66vxbSvVEnktFSeTTo=;
	b=ZTiTJ3UVs4a2Vgx5wJ7z2U/BLAVe3GBOVa9rJSP9pZWfwXid2Ga5YyNEW+qIzF7tKld/vm
	BMK0qi2rBhgAwQHYI3elObLrsKLrkActviADTxwwPbma3MrCpGOn8hw4OSoD6MhSIR6AXt
	8wn2nx30JNRD3d9sEyGT05XvxL4TE40=
Date: Sun, 18 Feb 2024 20:10:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>, srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 04/16] ASoC: codecs: wcd934x: drop unneeded
 regulator include
Message-ID: <ZdJWGgYMRoeLEKWh@duo.ucw.cz>
References: <20240207212700.4287-1-sashal@kernel.org>
 <20240207212700.4287-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qa2KFxf9dQT6fA5"
Content-Disposition: inline
In-Reply-To: <20240207212700.4287-4-sashal@kernel.org>


--7qa2KFxf9dQT6fA5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 35314e39dabcfb256832654ad0e856a9fba744bd ]
>=20
> Driver does not use any regulator code, so drop redundant include of
> regulator/consumer.h header.

This is just a cleanup, we should not have it in stable.

Best regards,
								Pavel

> +++ b/sound/soc/codecs/wcd934x.c
> @@ -13,7 +13,6 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/slimbus.h>
>  #include <sound/pcm_params.h>

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--7qa2KFxf9dQT6fA5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdJWGgAKCRAw5/Bqldv6
8iOQAJ9inBpQDN+haYqgeqPuxAw4PDFSwwCfVVi8mLYBEMh2CxLJvoxzV8+OUVc=
=0c1d
-----END PGP SIGNATURE-----

--7qa2KFxf9dQT6fA5--

