Return-Path: <linux-kernel+bounces-104743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA2987D304
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54112817BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846A4CB55;
	Fri, 15 Mar 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDARwqBG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A950A72;
	Fri, 15 Mar 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524842; cv=none; b=hmPb9M9WrrE5SexmnD6iur6BWVyBIng6mzFN4ccunuRKGCXD2GNyHkJrVuKBbG9CtNPjwEs0wnBmbdOfVc3qCUYi/pP82TJbtd+S15ZVrAmd1u6JhPjhcaj94KNK2OEZCrykrXeHYCGvXGqK869bo5QtAGSVO0dI+/Z9LmW4Jsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524842; c=relaxed/simple;
	bh=/JrYBKJ+RvgdTDc3k2bTdx+kammTQVuU4jdoBxQltsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy1r5Dkb+3cmXjjg4AsdMuqt9sKFKkixQzX/deOSNyE1N3yXl8CqLWMtdSQ4vw4sw+ERqIuFbkyDJkDGGc7t83y0saT2f0kDytHf5WC76Q0jvh4G29cgK30mPnJ/FDRLlrHGQdHBPmtRoLtbv5XsxIcjbQ3GA7W+N/tB9SetjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDARwqBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3B1C433C7;
	Fri, 15 Mar 2024 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710524842;
	bh=/JrYBKJ+RvgdTDc3k2bTdx+kammTQVuU4jdoBxQltsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDARwqBGiGClIz25uGXrpOxGj/1cHQyQTcBsJvIVJxoWfdw5bZFeQUUKB15FuqP2b
	 HCRHvM5mBYugsjRuWMrNkjT+qGGbs/s2nVNR4HIu1R2PP8Stvbb3gvgAlUwhs6v/86
	 LRfRKqBcSC8QuavWPL9aneeHbpDyhfeqx44T4l/CKpJYyKueY5w5107MORP/RYJwlw
	 bUTh1kwZmgwyZhnYCBQZqLIul3RKb/98cR/594A4cvMmPTfAmwKTfBNDg3Pt6csqvQ
	 h9ysLp+9vKiPQdyYbRoCCIsvKdCU+Nc8KnnoEdoNRu1EC2YmAlFMg8KGy2fWKZWpM/
	 3W3pIflDWoDrA==
Date: Fri, 15 Mar 2024 17:47:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mt7621: allow GPIO chip select lines
Message-ID: <6c92fddd-f79b-40b5-bd52-61f43d6a7591@sirena.org.uk>
References: <20240315015708.13948-1-justin.swartz@risingedge.co.za>
 <d562be73-ad76-4450-8bff-38ed5d144714@sirena.org.uk>
 <2dbc59c9133542f6f8bc465113d9630b@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdzcpQVLMTO214wS"
Content-Disposition: inline
In-Reply-To: <2dbc59c9133542f6f8bc465113d9630b@risingedge.co.za>
X-Cookie: A well-known friend is a treasure.


--sdzcpQVLMTO214wS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 06:23:09PM +0200, Justin Swartz wrote:
> On 2024-03-15 16:45, Mark Brown wrote:

> > The core should handle GPIO chip selects for you?

> As far as I can tell, it doesn't - at least as far the state
> of spi-mt7621.c is concerned prior to the patch, plus kernel
> configuration choices, device tree definition, and other
> factors I might not be taking into account.

> But maybe I'm doing something wrong, or perhaps have a
> misconfiguration somewhere. So, if you're able to point out
> something I've done incorrectly, it would be appreciated.

Look at other drivers that support GPIO chip selects?

> To attempt to confirm if the core will handle my desired
> GPIO chip select lines without explicit state toggling,
> I tried to set the value of use_gpio_descriptors to true,
> without any other modifications to spi-mt7621.c as of
> commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

The core needs to know that the GPIO chip selects are there but once it
knows that they're there things like setting the chip select should just
work.

--sdzcpQVLMTO214wS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0iaQACgkQJNaLcl1U
h9ClYgf/VBvBkaKRqN1N5jGqzbE+7ahGMhNcsH8qLPqWGA7txz7YIJ0DYg+F3ySq
QRYJmJCexCEEH9Vmj/49sauUmN0DXGIBjdUNOR5J3jf5KZD0xNIu69/jTxpjxL7l
QBFpRB4Rh+7I7+ObVhluJpBSexUrK73x3xwb+FMjOUV5Leh/fM71E2SWiUG9vX96
Gr3NingqmwpWwnLGkAv/G/45YPo/171bONDqnE7zfslPCSQoexXW0CdDwYiQEU21
SkDozS8Wb+qRUox0uU9Gp10zPNCzwbFh0FVyikmJ3t0RiLSCLSI3RHfhEd4FMi7t
1IaadgvwOf5iayGgCUxilb8PlMZNng==
=HCgu
-----END PGP SIGNATURE-----

--sdzcpQVLMTO214wS--

