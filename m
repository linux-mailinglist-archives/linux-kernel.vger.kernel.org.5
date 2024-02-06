Return-Path: <linux-kernel+bounces-54651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A6E84B20A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634651F24E49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04312DDAB;
	Tue,  6 Feb 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6GlnIVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6712D749;
	Tue,  6 Feb 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214142; cv=none; b=WORB/FFLAzJ3rcfiBjKrCR/UckQn5MXtxHVxOuxG02OM/qkPv7iDehbdhmTGI9vRFSNxnPuJEwONtMVisDzoXSqb51JTPnyCTxN5CNLs+eQYqM//CHQQ2fT7BbQhECy4j4qZKX7KapHOQ3+8+N4SUZo6TOE4teUVTHjJslCudu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214142; c=relaxed/simple;
	bh=6eh7rugcdTI/j4n4bbvxX9jPn6+zlru65TEB6aU9mAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiqSOcYYB+7AvT0BHMPVIqeTFWQ5mK1lTfD8XRpgT2E9hBSfTr/lJijRbB23kLRkuBg7USQb5LrhECt8MG+qMjCV/e80FTaydwxGDuks/kuaaydMkfT3omYHR+kCEOrkGH0KVd9ZRZ+DWkJFgnMlL+BSvZqSkc2pwgAfvyEa9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6GlnIVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491BEC433F1;
	Tue,  6 Feb 2024 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214141;
	bh=6eh7rugcdTI/j4n4bbvxX9jPn6+zlru65TEB6aU9mAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6GlnIVkN55eTnQsnXVV1Si9JIdYeZaBygDWpnXhaezs6c7BhJwZwHqcjdzHvuocJ
	 X1FnvRTTBZX6c6ttOzlVw4itRhxFNPOCpQUmN0QNaiLeH4vQQvGX5nG5AU/LyBSend
	 TViEnaFWX/KpNu7lERTnW/qbWoacNCoLcrNd8RD7g31DXTpAHbJ3VLGlWodRdbnJAS
	 z3eAv9N4JX5MkvD1SHm0z/+1tLxXXHyc/a54hzirjx3iPiq7uP29rhC6F62uwbU9QL
	 s7dksCpA1frqw8e+hDrOd1nquIxZ+D91Cpe3oSfkvHoloeEKy/Pq2KyVitDrezj+bt
	 yjPw0QYmMG5cQ==
Date: Tue, 6 Feb 2024 10:07:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bo Liu <liubo03@inspur.com>, lee@kernel.org, wens@csie.org,
	marek.vasut+renesas@gmail.com, support.opensource@diasemi.com,
	neil.armstrong@linaro.org, ckeepax@opensource.cirrus.com,
	rf@opensource.cirrus.com, mazziesaccount@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org, patches@opensource.cirrus.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/18] mfd: convert to use maple tree register cache
Message-ID: <ZcIE/RMTq34TgpQt@finisterre.sirena.org.uk>
References: <20240206071314.8721-1-liubo03@inspur.com>
 <CAMuHMdU7fYCsNT9ditqJ-saUsRm9J2zLh=-q-zmExhBRJeE8NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3tKV0MZVgabPsZSl"
Content-Disposition: inline
In-Reply-To: <CAMuHMdU7fYCsNT9ditqJ-saUsRm9J2zLh=-q-zmExhBRJeE8NQ@mail.gmail.com>
X-Cookie: You might have mail.


--3tKV0MZVgabPsZSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 10:33:22AM +0100, Geert Uytterhoeven wrote:

> If all of this is true, is there any reason to keep REGCACHE_RBTREE
> around?  If not, perhaps REGCACHE_RBTREE should be treated as
> REGCACHE_MAPLE in the regmap core code first, followed by a single
> tree-wide patch to replace REGCACHE_RBTREE?

There is a very small niche for devices where cache syncs are a
particularly important part of the workload where rbtree's choices might
give better performance, especially on systems with low end CPUs.

--3tKV0MZVgabPsZSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCBPwACgkQJNaLcl1U
h9AzsQf/fvluGCbAx/aIe1RLZpmbVAXZdaP3edZ9jN+FzV+ub/6qY0iiPxN0esI5
jpGS40Z27yNHgk1JIpJR/ZoCUrjeuLDekUhJmu87yhqnK3p+DsT/zfnbqbeSdKXz
FuOUu8Kh+hH4bdbyjTMNvTAzzuPUwgE7DRFGAlu3tPkZXEFtMzpSCImrqxIrsKao
Z7quNE+m6pc4MyiQ09p0cOAK8fjnSHuFNn2wjZX2GgAGnLEYkKrpQwYgkrDRlHqc
C7Cb1gOefwAx/I8mYuP+2TJNV/XVUKWJ0Od8KZ+MVbxaEslqAJaCvMSXzgkj/dqU
ssEshBmXp9EzMJKlUQ967sIEsiM4OQ==
=DPIT
-----END PGP SIGNATURE-----

--3tKV0MZVgabPsZSl--

