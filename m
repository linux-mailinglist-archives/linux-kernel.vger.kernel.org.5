Return-Path: <linux-kernel+bounces-66952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2948563F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6050D1F2730A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE312F582;
	Thu, 15 Feb 2024 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsIp3eIk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C858ABC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002254; cv=none; b=Hsy6rZZk7ct3lMTCOLkE0/U2BhWtV3eUgTWCJgozQY/50eMFlgBCsQO6t2Ucf0Ctakp7RY7f78u/SRAk/kTr3CvCEqTuH/JVxBorBRFi3CYbF/JBGT+Zhp5HOhJh1+20K4qXx8M4ZeJTNGjnjvYWcb8Bq4rJkFrq7O4pKhRDJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002254; c=relaxed/simple;
	bh=jBnUeliIM+lDQOZgbKiGk7/I7UGsSjTUdVEOnfuW0DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWrpw9uwmgzRtr1/aQb3i52IEXexqAj9/hDFXBFDGqvwUnQzmkxBsLN2Bp5MXdwuctvm72yGb6JmEbil6Y3YTb7V/3ySAVhg+98Z0+WcfWpVpBan2N05EXABhC24erMdb3LLd7atRcgiFuQ2+6YRq2aJctKa3P3Adw+qHuFnMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsIp3eIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DC6C433F1;
	Thu, 15 Feb 2024 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708002253;
	bh=jBnUeliIM+lDQOZgbKiGk7/I7UGsSjTUdVEOnfuW0DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsIp3eIkzbep+978EXuSlQHGHFHXXIDpPXo9Ejb14D880tN9hQZY+DifP7prpJOmm
	 K5ERDoCj0kVYv3MfsMalmvE7bKn4btkS+U6XXvSvV7vpLz+YRHRtcGX+1m18Y24Dj0
	 2JhvTUS2aSexJuBXAtTrU5R4lPRgN5hx0bMnHboZiNaxfkcJObx6OF3xTS2pfRW9E/
	 1w300QjJ3HoXOMXM+vvKEIQ9miCOPqz8fqvcBZEj6UjOazW9t9xxR2HcfcBTjUfKFP
	 +D6pxbMeB4a5K4V0Ew02/DBXq76YuGMVSqVr+FrzqtVusaz05wSTQmnyQIS+UZpGG8
	 ZYYeaOzSgNNlg==
Date: Thu, 15 Feb 2024 13:04:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
Message-ID: <d2722ae9-d29c-41f9-9eec-f829589adf6e@sirena.org.uk>
References: <20240215065454.2489075-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+BKBLTtfgrcFZnRa"
Content-Disposition: inline
In-Reply-To: <20240215065454.2489075-1-anshuman.khandual@arm.com>
X-Cookie: Pass with care.


--+BKBLTtfgrcFZnRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2024 at 12:24:54PM +0530, Anshuman Khandual wrote:

>  Sysreg	ID_AA64DFR1_EL1	3	0	0	5	1
> -Res0	63:0
> +Field	63:56	ABL_CMPs
> +Field	55:52	DPFZS

This is documented in the architecture as an enumeration, though I'm not
immediately seeing what values to use.

Otherwise this looks good.

--+BKBLTtfgrcFZnRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXOC8gACgkQJNaLcl1U
h9AlYAf/a1uNyhXOXmf4IZzEnudRpCrRszj2uXZDgeE9CJfyleLiiCQHX3Wp6nAN
QgIf7F/ufkNUFL8pu9rRJASURGtXoyh+ZPb+TPoH4vsnIDzyTdjhHp/8MgzhI/7Q
htZlIoqxhzkJxch92UFYcn+OfI9eKaCYiUF/b2CzBjwy8THolRpAfqweTzOGkb0i
jNzNejOZRHFp5ccSoY4uB/C1m2JN40PphYJNrTLkC7+HxJqTko5hPyUnR7YBkNE+
EyivYZHZOsPXFkgBoN8+sqLkg5u8zKWWUNGwW7KEEtGo2WLx6raCFjFLPaA3rAMe
EqIXUrn9xS0JuYQwvtW3vCYi0q9g6Q==
=/8+k
-----END PGP SIGNATURE-----

--+BKBLTtfgrcFZnRa--

