Return-Path: <linux-kernel+bounces-166707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7858B9E66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EA828A23F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205B15E1EF;
	Thu,  2 May 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO84u2It"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73414A634;
	Thu,  2 May 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666864; cv=none; b=EGnxediQ5I2QVCXyR31EweeiiZruy1hO84OApuPqI9qNrRyMRPv3vIKr7mHdomqc9qAr1ShTNFa4IcJ6T8uRcuxuk8m6TORYGHN8rK1BOraYn5msmPPjUSaH+hWTSHaWgzN4P3wKwOLtDXF4bWBhWA5872pZROhjGFLmQGXduVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666864; c=relaxed/simple;
	bh=WleDPBDuGpkWYaKIN5o6wY74OKM8aEWx5ZRGLFVujOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1iRyi0evMyJWL0bemee9AbI8CsQjKOGju2TrxvvBrN/9CsPFsuN0qx4+jHauvWNAwN/SmmaFJU2/t8s7ApYQck/uJUGQGzTKW9MqoQOIWiqnx+jf4b/V8IOwN+hTbpegcgnA/u0v0IyYXGBlnta/vWLzsUoRFVZlpqDuRLfzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO84u2It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D72C113CC;
	Thu,  2 May 2024 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666864;
	bh=WleDPBDuGpkWYaKIN5o6wY74OKM8aEWx5ZRGLFVujOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GO84u2ItR5Rr4hpqiC0d9PsHJCwKEEg+nLUQ9CRVhpHu2VD0bwPC7JMGH4KBtLkp2
	 WM4XouZZzLXEgFSCGESPV3BRfFT9t6mMS7GcnZtC8r4xb4eQimd0GqAooYbrwsXTLf
	 I9+SBPe32rta1CSCKrc/emOsNatWjznN+xbxXxrhTrKnAkcJWCW6cFBnD8AEETI9iZ
	 AFmF9nKvhOn6P4/DtXxSO1dxgzRGzldQBXLxYGurhifbNsm+CvPFLlm6DaQY5L2j7Y
	 +s+nncxdHPn1GaXBlucr7UrOWpMNja0dFDyBcRyrnlBmWUh9IT5yyAiXbbTWSqHiH0
	 RSE3KK+YVKk5g==
Date: Thu, 2 May 2024 17:20:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 1/6] dt-bindings: ROHM BD96801 PMIC regulators
Message-ID: <20240502-vitalize-oat-ecbc14647df8@spud>
References: <cover.1714478142.git.mazziesaccount@gmail.com>
 <c747a3395a52bdb9b9697f814cd781fb0903b894.1714478142.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pkgSKLeZe7hVqg4G"
Content-Disposition: inline
In-Reply-To: <c747a3395a52bdb9b9697f814cd781fb0903b894.1714478142.git.mazziesaccount@gmail.com>


--pkgSKLeZe7hVqg4G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 02:59:50PM +0300, Matti Vaittinen wrote:
> ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
> DT bindings for the BD96801 regulators.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
> RFCv2 =3D> v1

RFC is a status, not a version - ideally this would have been v3 and the
next version v4.

>     - Drop regulator-name pattern requirement
>     - do not require regulator-name


Krzysztof had some comments on the buck/ldo node names and on the
initial value properties that I'm not sure if have been addressed, so
gonna leave this series to him.

Cheers,
Conor.


--pkgSKLeZe7hVqg4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjO9awAKCRB4tDGHoIJi
0jr+AQCQt6Z+SetdU9x2J/oqB3jM4GsDUaIIBK2HqhEaBSlUHQEAq3UG5y0PLiXN
TH7mteDIKPhBUiBOtcmWzO+dHOcXYA4=
=OtgH
-----END PGP SIGNATURE-----

--pkgSKLeZe7hVqg4G--

