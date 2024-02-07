Return-Path: <linux-kernel+bounces-56750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B547284CE98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E61728BC51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E008062C;
	Wed,  7 Feb 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCaJYNCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5D20DCF;
	Wed,  7 Feb 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322048; cv=none; b=KZjkoevMqrPaEu3saz4S8Ir7ppyGwjjoEW10leMfs4axvzyFYNYBTSsaAsVGRLXp8G8XdL9lVplJ8Oe6I1NLhrMSqdUvEYdk2qpRAiEzffnhT15jBDrP1mCUlt4XKVlzzVYLc4zL/Z+uMvhSvpYfHrNXgeKHF0GZtbIDzhV0KKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322048; c=relaxed/simple;
	bh=w89gPUiH2GFyzMuya9r1GY0cQM/mwmbHow3AGlWcAZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCbmCqyTClBJjdZqQtxydKYB7RLqW15gd6OiD777Oy7WkoRYKgakUVsVG3j/Pf5nkNybktKNKhn50CloHi/z7g8sxI295Kb6JoCwbwmWJ5lAuBCGfy/3ndj3w/yzx1Krp1iBjDoC5l/dIb6PHSaHEtpS4E1xmC31K4sD8hkF4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCaJYNCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406DAC433C7;
	Wed,  7 Feb 2024 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707322048;
	bh=w89gPUiH2GFyzMuya9r1GY0cQM/mwmbHow3AGlWcAZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCaJYNCfowgodW1MO1w12b/zjLj2VrhP+WN5E+ktslv0h3/s4QbKY9nniB1FEBJE9
	 A6E3U/gOcG5Sw0X7sHSK12csUTYOeIz8/tzbEikUnZ+ea9cn2YmIP+NDxMsiAfdvdx
	 UZoXzJ49zBTqNK7KD//xsnnQQCAs/HXAHKnrmlMWfN3yUC3Ob6LSo6WE2L7y66VLpu
	 mjUnDICGUO5L4xo6XCZz0ekOxc/2LXnNAoTofLADqdP5ggm1XM6HWSsjzlQlSs4+Jt
	 RlEBvQssJcnCGMv/NymY45f/PSVmVgt/5w1NQGElLZ+M8IhFVjaiUa2p2cYj322cy9
	 1t0qj0YkjKbpQ==
Date: Wed, 7 Feb 2024 16:07:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com,
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] spi: s3c64xx: explicitly include <linux/types.h>
Message-ID: <ZcOqvEPJIff69L8H@finisterre.sirena.org.uk>
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <20240206085238.1208256-2-tudor.ambarus@linaro.org>
 <CAPLW+4=Xd+B=ZncqPgU4qaJ8zY8JJvJZApdUW_v0w6yr2cy9Sg@mail.gmail.com>
 <16a5e423-1111-49ff-ad6c-b0bb89a4879a@linaro.org>
 <CAPLW+4n_1yBOuzW3Ke2DKh_0EBZMUrd3nyGd=U0TeOML_2dXuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EMSNjjacnJJg0VVX"
Content-Disposition: inline
In-Reply-To: <CAPLW+4n_1yBOuzW3Ke2DKh_0EBZMUrd3nyGd=U0TeOML_2dXuw@mail.gmail.com>
X-Cookie: You might have mail.


--EMSNjjacnJJg0VVX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 09:42:20AM -0600, Sam Protsenko wrote:
> On Wed, Feb 7, 2024 at 12:21=E2=80=AFAM Tudor Ambarus <tudor.ambarus@lina=
ro.org> wrote:

> > Yes, because in patch 3/4 I use u8 and u16 and I don't want to use those
> > without having the header included. Do you find this wrong?

> I'd say if this header is really needed for your patch 3/4 to have a
> successful build, just merge this patch into the patch 3/4 then.

The series was already resent, not worth a new version just for this...

--EMSNjjacnJJg0VVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDqrkACgkQJNaLcl1U
h9B9/Qf+Pfv7AOc3q7abu46R1WsdYSCk01fP9ut5hrYz6KPZdbf4QA9wq3+uqWWy
W2A13zVcPV25wslX16UekFIXAaVu4uLH9R3nNY2m0XUzMDWqeS8kXSitV/gjyPLs
M0iaLPctUa10ny39CddPXR7sBG16vJSUCyd1bz7vEWE2YeKgBScTooJ576rm5F7J
twRkSDnSnmlqDMwU7nlSuDUk2wT5NbOF8DdbqVjVzcb+awOY/PkUwrhmU/V/x7tn
70zTdvvFE6skI+TxEURqRsX6d74phHQ14uLplqtv9peTDsi3ZSfWrAEsMkkodSaa
pXtz6O0UpWZtoAEzxSnbfPbVpSHcMQ==
=iScE
-----END PGP SIGNATURE-----

--EMSNjjacnJJg0VVX--

