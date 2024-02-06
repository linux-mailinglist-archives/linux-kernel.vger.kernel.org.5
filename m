Return-Path: <linux-kernel+bounces-54616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4791384B189
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAED1F23FED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346812D16D;
	Tue,  6 Feb 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd/PM0gW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668712D145
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212735; cv=none; b=nbPA3fA1xwOoqcA2ANfdB3wSOg+qDNG7HTxeNuPu2RAk0nh3CGlIZpF9PksA9qL0G2l+9tz2Ow0FSP0iV/t2zElZlMpAmZxyrTiHWQ10RdThI6wUkY70XSEss1UDj/ahUxQh9Siewqt18p+KKikEn7qUA+1j30LB3xodjbwzlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212735; c=relaxed/simple;
	bh=FNqxpnmPzeDypyr0PapIxFvem5/h1m4TDwTMiSLWKhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F86wtOC3TpkuADY5mpaAutg4kvQF4IYjtDi1Nfe0BVbBuywWu3jGaNoVHM2+zNltpgzC5DAWSUNHetAyNW8L3bLtVdi90JK1Pcai2gVACb8ivmAhPXBbnhql/oOxrCvHOYbk9WiAZB8zuUMfqxOtBXzgFh72XTtWiNEPTA2ypAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd/PM0gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65C2C433F1;
	Tue,  6 Feb 2024 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707212734;
	bh=FNqxpnmPzeDypyr0PapIxFvem5/h1m4TDwTMiSLWKhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yd/PM0gWwb1+x8TiJ29IOA34CG2QyNc4NlQ/gy1yYLSoNvRhgThNngfUa1edOpsWl
	 5YWj/Cyp/aYq9jBgVauMEdB7Ql5KNgiFdJEVuCCaMv+FIGWcpGmHpkoKKdW8GqXFdr
	 GadFPsW0xttPrGKNM++ws4wGX3QyVT7RxsS1SQzsSdtF8bUMM6HBWRka/qI16Upxwl
	 p+iJeSfMMceinMJl9TojDbsKRnIih08pqTz9zMOjHn0SuRjK77+LFVAI9Rrs0mCBCU
	 52lSZhsIcyp4RXWbDwZ3KsKJLNvRERI8osMYyQ/DOb4c4Rogrxv05NgMkgBoRrbaOT
	 rAr1+72aNP52w==
Date: Tue, 6 Feb 2024 09:45:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Spurious problems when running regmap unit tests in qemu
Message-ID: <ZcH/uglviDbsPIQC@finisterre.sirena.org.uk>
References: <fc1d865d-3e2e-48bc-8cd1-389ec6b15909@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqluStmxa6iNnK3w"
Content-Disposition: inline
In-Reply-To: <fc1d865d-3e2e-48bc-8cd1-389ec6b15909@roeck-us.net>
X-Cookie: You might have mail.


--nqluStmxa6iNnK3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 10:03:01AM -0800, Guenter Roeck wrote:

> Any idea how to debug this problem would be welcome. I'll try to bisect,
> but of course that will only help if the problem was introduced recently.

No real ideas off hand, I wouldn't expect any of these tests to be
intermittent - the only randomness is the data used to fill the buffers
which we're not terribly sensitive to the values of.

--nqluStmxa6iNnK3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXB/7kACgkQJNaLcl1U
h9BBcgf9EL1T6T9PgpHBkxjQ/gk/o05kNb3O/fS9+K9Z6gpNAD+WovaSR+Q/d8zn
6ELEtPeVojTduNEppAs1uRHf1IUE83UCMFaFi5udKug3Z2syJlHaHxWqYZJHyOc9
CXYVcuv5seqx+39pBBOX/O6nSP8CHP7r1ByYOHsp9tkyxu9t8GgW6wPxY2JW27lm
xGXHZgj3KnQagRJ9YAMXSrgrVikyELhvCfZcaW7ieMwnxdfWBe+RI89aTg5uQd3f
I5Hn2Xym9agog98yqESmQE61DeoNxi+EDDnQvyeZ5JDrptIF/FpFmpmWeQxFwhRn
At020fG+8L1XNM4twgYtE+4PyYoJpQ==
=C5RP
-----END PGP SIGNATURE-----

--nqluStmxa6iNnK3w--

