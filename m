Return-Path: <linux-kernel+bounces-48624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD0845EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEECD2836E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32607C6D1;
	Thu,  1 Feb 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUOAmdqc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1117C6F5;
	Thu,  1 Feb 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810054; cv=none; b=XjYLc2xw6CmwcfDh7idaQkiBB5cLMHfbJCFgrIEyDr9xnQiH7E3hmYs7+opAvgHSQuH25NS+L1Ibkzpr03GgXYe4C48PNw8qyyXH3MzZvT3W9txuQVYx+X8D2X3UW+/+ROEhL+G27wMrZvnmzNEFsUTgl1xzr0LzGPavEEppC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810054; c=relaxed/simple;
	bh=YUkd7uEqiPVLGruT+0t1YqDa3qzi6unju7/bmhZe0xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwFYwKd5j0ibo/S0rh1ADAoADvbyf42C0tsBOrv6i85/WAyg/st9CKHiXiEhHq2AJvJwKIDT1MlAcM4eIgdpbwwn9gQA5t28XExzxozuJyPRVobmF0kQVRHLwEtr3nXyMN07vSQDeqQmbEXbRZ7Ay+7nNA9YmT1wKExjJvbM2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUOAmdqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71103C433F1;
	Thu,  1 Feb 2024 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810054;
	bh=YUkd7uEqiPVLGruT+0t1YqDa3qzi6unju7/bmhZe0xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUOAmdqclHfNckDU2OLscuSwch1GwgHv4JXGgyHJz8KhQ0ggNI3S0lnPQhbf4tMfR
	 E5WDoHOFruo9dW5rsXPcT4ghU8K2I03dnitcpJNhQbpHRmNImZ4IX4ED2RtOO+fRsP
	 7bnBg5ryc99Cjck5bkPBZ9xWl1iAeAmF7Sl9Z5TT9PRqAe16NJv4x3UQEYYUIj1iJw
	 edhWg50JYat9/kXPVgd29SDU8qVTET1YJL1EPeSZ+1GgseCLpkVcYde/ykLQBglxwM
	 Ks5GPbGbpUpEQOkQypddDbNgnfnlXg43uv8W1Q1NYQ31eNsZ5swVm6blpr7Q4ReoxM
	 HarTHY4fib4Lg==
Date: Thu, 1 Feb 2024 17:54:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>, aishwarya.tcv@arm.com
Subject: Re: [PATCH] Revert "tty: serial: amba-pl011: Remove QDF2xxx
 workarounds"
Message-ID: <1868321d-4e6a-47df-8650-a68bcf82b2ed@sirena.org.uk>
References: <20240201-topic-qdf24xx_is_back_apparently-v1-1-edb112a2ef90@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TvERFRh6Oh0NQ4Td"
Content-Disposition: inline
In-Reply-To: <20240201-topic-qdf24xx_is_back_apparently-v1-1-edb112a2ef90@linaro.org>
X-Cookie: You can't cheat the phone company.


--TvERFRh6Oh0NQ4Td
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 06:01:12PM +0100, Konrad Dybcio wrote:
> The original commit assumed this hardware is long rotting in the
> junkyards, but apparently Qualcomm is still using some of these old
> servers internally and the thing can still run upstream.
>=20
> Adding insult to injury, I apparently managed to overdelete code and broke
> non-QDF2xxx platforms [1].

Thanks, as expected this fixes the issues on at least the Arm FVP for me:

Tested-by: Mark Brown <broonie@kernel.org>

--TvERFRh6Oh0NQ4Td
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW72r8ACgkQJNaLcl1U
h9D8Wwf8CeYtem6ISM3EJ36guOe2y3RFLJxrL4qgDutkeLn/ySnwDAmuD7DyI+Tk
iioVlja9f/g8F+tCN7ISyzo0p2PVaRXQ8bJlTKK9unBNX+mOXL9eEsHz3lRTWU6+
HBvYyjE3D7rEal/Vd3Vxxu90ER41Jb4HzLOFKWEiBXo+2bM7Vti+nBQV5KBOTfw3
5JEeB0+ajipXLI+XniS5bAv3o78g6KOJZlMWPqvPEFTWV9KO07mhhgRUJdCARF4p
Ysh4jHNUuasOwiFiUhSaXVE7AaawD/mpm7ACwhtRzrbysFuVQhZBV+n/2QVTmUu7
lUkqEaAU4bNMB6wZPFqsPypdF0ecFQ==
=zZZF
-----END PGP SIGNATURE-----

--TvERFRh6Oh0NQ4Td--

