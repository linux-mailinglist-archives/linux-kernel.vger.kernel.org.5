Return-Path: <linux-kernel+bounces-81827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43A867A86
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4C0291D25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ACB12BF1C;
	Mon, 26 Feb 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPxjAqrN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EC12BE9C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962157; cv=none; b=d4EkRDFmEUDh96aW/fuqHg/i/gCXpgiJwDkZp+NAGu9Nzbp5gFKcmUaOTvi9BYO6gl6d7NRAr8RaM15vxaFb+FEwpy5h9sZf75JZEL3kM6brnRtZhVYQQWIwUHFcvsFeZouUFjHTKyLrO0NOY90XD8jQ2T+vD2+TF5T2P570pDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962157; c=relaxed/simple;
	bh=eL3Sq0didjuZIcQ0uUGAVgBF4oFDIInfGkYzwsFtZ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDeO+j/NXLywLvIqKc5xZfbR5yECAcHNONEPp/T+eLOhCZqrBYdQ7x4RjqXisn3DEqIvRSFSkb4xcATtCk6H4F4rOnCJfC4DXAt2f5SHs/40WCi3dX4QHwv4N8n4gMEU0b7pGvY3brvqSHkizYPj1SZXYXuUOXVsQ1nDRLSpuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPxjAqrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBAEC433F1;
	Mon, 26 Feb 2024 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708962157;
	bh=eL3Sq0didjuZIcQ0uUGAVgBF4oFDIInfGkYzwsFtZ5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPxjAqrNQZU6c56kJP7tvRbFozDBHAeT/Ki1LV0YiumSxdtDrvz13EA0H4KhswR51
	 Y42pqnYvuSEXWhAKu4zJrAmA8dw+IOspFIpDgy6jeF2aEgXXVp9/fvvcOsIv/jBcUy
	 YhIhoVAOY6nJfSFI+2lm3thxc5OE85qOK+MQehEgLbvRGa+Svu8CDqcfTDADH9x6rR
	 pg/tC6RN35XNFt+HtOLHmfFbl2MXWFx9MpCZtMhxfskVDrRf9UbmgltQResfhSEAAo
	 CKKCen9AItd4FaRcKTIgeh2LYngENnSn7DBcZla/oSg1zzI7SZd/MaNh1n4LdxQMAr
	 w/AWH3h/w19WQ==
Date: Mon, 26 Feb 2024 15:42:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 6/6] ASoC: meson: axg-fifo: use FIELD helpers
Message-ID: <a828b4f7-282b-4b83-9a64-04557edf9b6a@sirena.org.uk>
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
 <20240223175116.2005407-7-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="US/dKDUluQQUZ0hF"
Content-Disposition: inline
In-Reply-To: <20240223175116.2005407-7-jbrunet@baylibre.com>
X-Cookie: Your mileage may vary.


--US/dKDUluQQUZ0hF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 06:51:12PM +0100, Jerome Brunet wrote:

> Use FIELD_GET() and FIELD_PREP() helpers instead of doing it manually.

This breaks the build for me:

/build/stage/linux/sound/soc/meson/axg-fifo.c: In function =E2=80=98axg_fif=
o_pcm_hw_para
ms=E2=80=99:
/build/stage/linux/sound/soc/meson/axg-fifo.c:149:28: error: implicit decla=
ratio
n of function =E2=80=98FIELD_PREP=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
  149 |                            FIELD_PREP(CTRL0_INT_EN, irq_en));
      |                            ^~~~~~~~~~
/build/stage/linux/sound/soc/meson/axg-fifo.c: In function =E2=80=98axg_fif=
o_pcm_irq_blo
ck=E2=80=99:
/build/stage/linux/sound/soc/meson/axg-fifo.c:207:18: error: implicit decla=
ratio
n of function =E2=80=98FIELD_GET=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
  207 |         status =3D FIELD_GET(STATUS1_INT_STS, status);
      |                  ^~~~~~~~~
cc1: all warnings being treated as errors

--US/dKDUluQQUZ0hF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXcsWgACgkQJNaLcl1U
h9DIlgf/fnA/FeDBqMLROkPy3MIwMuQ3ZxxLtkBhK7VmoZBxa9cH7MWNDQ84B1pt
Ed/CFYuM8JzavBhDYl1s+qGi7RRsz36Zk/FAPftRdm/zCTl7L0oXH5a26CgU2WHJ
DiB6tY1QkkAFWj6nHAlNlNUeIkAXBa8py0pOOv7JKNGiGMVZnEcsRZKtgyhbUdK7
jvUE3YvTXnjxDtBVKat0fe2/rOVqtefqpnKL94l7BkjlIeRgJ8DmWfGH6gibUm1t
GFY9mTOE5niV34ypQlId8dCtJEP6tbplAssdgnw0GbMceZ/xlztKtKNy3wMv+W3m
27/rAv8zQA4CUE078XdfAcxYGntAug==
=GD+7
-----END PGP SIGNATURE-----

--US/dKDUluQQUZ0hF--

