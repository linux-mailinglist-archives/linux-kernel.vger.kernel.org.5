Return-Path: <linux-kernel+bounces-56280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E284C842
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B6C28642D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC824A1A;
	Wed,  7 Feb 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4+L7DNx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C525620;
	Wed,  7 Feb 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300396; cv=none; b=corI9uv2xendBwcitNl/PoCqSqFJHcNkBVzjibJeBwohoaDEUQ3uJuFInSr/xUYd1s4QM2t4LdU7GTQYkAtTjpJ/gzV57zrAQr2SHemGSN5OXUahCaQJ8nlpUL9HGZxMgitPK3yBgBPzJjSNgjklgCNCzy4vEQHdnQf+0Gn7fF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300396; c=relaxed/simple;
	bh=8SIztSSdRHmnv6/+sGa3e7hEC65ih9fcCTIUIr5N3ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwxUvfdynWpnjGn9GamV/MxWV0acbuU0SLrv0mdnXnqkDzCuldiEmQhbr6KbRG850YIscOeMYUJmdhklzX1y7WtmJqiHQW9UUQKvX/CFF+LmIzFlpDtc0u8Cv1uugG7RcSoCqsN/Vz7bvoA8uqrtCSiFw5bPLA+dlCQsbtRfK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4+L7DNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F61C433C7;
	Wed,  7 Feb 2024 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707300396;
	bh=8SIztSSdRHmnv6/+sGa3e7hEC65ih9fcCTIUIr5N3ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4+L7DNxS+nHECEWBlPGeUjLKef0rkZ84tpxsN4MDZTx5siH0x7IfNdN2KWCLA0aF
	 enMLJUn3mMAjKREoqZ50HO2RFWxoa0ZCsojrmXXmLnUdWimd7BOpKqMudltLzpvq7V
	 nHo4mSRhIh+XY/X1+1La1Lbh/NXGGefRtpR0utlGHrglVSYY4OUswKtNZrpve7666C
	 cFl3aEF+QdvNE0JWkLelRyrKZs8BHLl9MV/ry4hiqq6c5SOlNENK4alIV9pTZYUS3B
	 3wRaT8dJVxwyeFLq23XlwzhNGIm3+VLHikl8cFTpNdfMbAsH69qgTChqbmqKVhgaBS
	 N3TKC4z0Tjaig==
Date: Wed, 7 Feb 2024 10:06:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tas2781: remove unused acpi_subysystem_id
Message-ID: <ZcNWKUByQZM6nayY@finisterre.sirena.org.uk>
References: <df5c94396256e9573b772962182def52d20c50d4.1707250969.git.soyer@irl.hu>
 <631722b9ec0a4a2667d68f4747f01f3f7eb8ceb8.1707255177.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2001rdQd9M4MkVU"
Content-Disposition: inline
In-Reply-To: <631722b9ec0a4a2667d68f4747f01f3f7eb8ceb8.1707255177.git.soyer@irl.hu>
X-Cookie: You might have mail.


--r2001rdQd9M4MkVU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 10:34:15PM +0100, Gergo Koteles wrote:
> The acpi_subysystem_id is only written and freed, not read, so
> unnecessary.
>=20
> Fixes: ef3bcde75d06 ("ASoC: tas2781: Add tas2781 driver")
> CC: stable@vger.kernel.org

This is clearly a cleanup, not a bugfix.

--r2001rdQd9M4MkVU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDVigACgkQJNaLcl1U
h9BTKgf/Y91pr9e8zpI9HU+whTgfiYK/+lW5+OM8y2XgQUls1VnMG5fVUBPwlAa9
UyVXNUZGpGb7tpN4zdhNZmyl7m8IuN0JLPAaquDFPJycaRcck83Me89KhkKiZpFz
mvAQTULEv4BcF4R4fPgqhPRNTy7CxNAynHbSsuISfaFBjcjn0m7CkCUF626shYmp
wV39QOKWsLqJCJH0jGVEaxTgsn2rKvotCL2Bl7Eklb9qdRxDBwm/5g9q/ThGyP8s
P6bw2nYu1cLdIfWJvVbKahQBxdiYeKyzUK91jEew1Vy9bcCyPZ2VWe5pdXzTz4J/
7TJoritrxIq6p9JKAgjDwZzTLNqi0g==
=cqxc
-----END PGP SIGNATURE-----

--r2001rdQd9M4MkVU--

