Return-Path: <linux-kernel+bounces-162464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C868B5B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80871C21E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934BE7E77B;
	Mon, 29 Apr 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCKmi2iE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38867D414;
	Mon, 29 Apr 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401750; cv=none; b=mZgoj3vg44CyYj42OTlRPFEYWGg/MWDzLqOv5RRQh3qJzRhsGJCBK3J2vfySVCxFCHSRLVoC3V4fnnfcbszj4VtcDUlclzxJBOB1D19HDMrrL9QzufsW8NhIKQgESitNOwaoLvppAdUS9FDDp4oaK2ZUMAXmQJr2iK0qqLH+4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401750; c=relaxed/simple;
	bh=ESPEiYovVv3XkYy8Mx42aYeRfwJkKA0HprZUzwWWUZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG8uorCzlYe9ZmzMgpb3mHpJAK3txXTqxoA6YQBGf8l5DqwcvXcdtKHniUOphk2IEoNMo2PPLteYh4DOj3UCp7t+5M/AO/KPqxOMhKpH4lgO17p+JR/yW9XCfZ1PsYtcDzb7pq7tekdGTZ3+5sbYoh6A7tPzh33hvrX7xM5Cxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCKmi2iE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C50C113CD;
	Mon, 29 Apr 2024 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401750;
	bh=ESPEiYovVv3XkYy8Mx42aYeRfwJkKA0HprZUzwWWUZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCKmi2iE/eif5hjX2tMjSqXi793M4C1rGm9/PNK6djMIA9Mle8wqm/bBFZergzFFT
	 jVuRI1HQhc2lzlF2+g5HJUktV1xKmgf+scuO6FY4bjHxSd0X3RgtkXdkrA+XNug7HN
	 W/yGABM1bSmBdT8B8Gfy/xsngcopdZmKSQv+IZn0bBiQovF1g8HsminZ6oHWM55rdy
	 0I4Im9t0ezdKBihNbpPMHJWJ7q4PGperbJkATZTtiwe99vGAuGR9VGz4qy1p6OZtOe
	 W878PBdjG8kCJN/zjeD/g2hqmTWvTnKfL6my+qJWq1AWHo3vHTTKo2rdNJTKtiu5nk
	 DZeVf6oGIHJmw==
Date: Mon, 29 Apr 2024 23:42:28 +0900
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] ASoC: doc: dapm: clarify it's an internal API
Message-ID: <Zi-x1FAWnCgjT5RD@finisterre.sirena.org.uk>
References: <20240426-dapm-docs-v2-0-87b07547eb5b@bootlin.com>
 <20240426-dapm-docs-v2-5-87b07547eb5b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="okcnfWCniRhdttra"
Content-Disposition: inline
In-Reply-To: <20240426-dapm-docs-v2-5-87b07547eb5b@bootlin.com>
X-Cookie: TANSTAAFL


--okcnfWCniRhdttra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2024 at 06:56:38PM +0200, Luca Ceresoli wrote:

> Clarify DAPM does not expose any API to user space, and adapt the paragraph
> accordingly.

That's not strictly true, there's a couple of sysfs tuneables and all
the routing is via userspace controls plus we've got stuff like pin
switches.

--okcnfWCniRhdttra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvsdMACgkQJNaLcl1U
h9CHKgf+NI5rxfj0/p54kNQfC7O+ab8f85GuVlJbbMOwKx+k+/OSh0NuEsmhMbbS
JD8IM8Xo0Cx0GlhJdHTIgvje9Cib4mgl095NUSW/rWNGY551iXGQ2B3zSQwtqBfh
P2LXCDMKglpnSF2pH8TlgrH6mTFGgMlTYEyn6+8jzo1NnzkkK8wNrewo2c1Vto+B
Hp81aYEOnNTlKO0Df6K0+VXRuhoOwftJcao5JIKwnweXtvjwaUtTKRxgY9DSg/yQ
2eFUuSt8NsQcoBku5qTdJeKVst4auxTbjnhENeGtEMCuoDNOyoAZK5QHC+4aHmsh
XV3AJuUbIKzVYkvNEXjjwMJnzyZ1fA==
=YaVk
-----END PGP SIGNATURE-----

--okcnfWCniRhdttra--

