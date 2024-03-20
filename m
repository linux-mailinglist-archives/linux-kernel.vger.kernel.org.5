Return-Path: <linux-kernel+bounces-109176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE798815C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26C81F2205D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755DA15CB;
	Wed, 20 Mar 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7A6Ko2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226CA47;
	Wed, 20 Mar 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952707; cv=none; b=VSHs6LsW8ELcIXQRcXNSNMEr+wz++aDaoSipGjPdP/lSOgsWt9ZRA2r4oskXfxAekDjlJq41VUpmRbd2CFFIPovgBrLK3n68qwx8iR7uJxYx72ziFpUWispR6S4nX2Aqy8+C63RmZfbo3hVAMLOF+3n78QMNDXGPoS6vPQ+WyVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952707; c=relaxed/simple;
	bh=LfhemfK7EXzpmS+yo/9x2s9Dw48aQ75sJV6RERhj+as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9QFQkXo+8d/pCCuH83u7UjQ3te9gLxeqiLaH68+dH5Fin/V6y9+46moMGfR72/Yj8J+HQUaSziFjYveYqwG8r65wV2VyMZlSkfsfES3AxDpW80YlD7NRb5dEcLOgiG1rvaquWesmUe5Q5PaT2gWM1buvStaxdwbIwphmMfHQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7A6Ko2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1918C433F1;
	Wed, 20 Mar 2024 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710952707;
	bh=LfhemfK7EXzpmS+yo/9x2s9Dw48aQ75sJV6RERhj+as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7A6Ko2RVqQghkOeZydShEtgZmkJRgHMoJdMVxeES4UpvjlL8yvrm+DwaQSQIDauU
	 kK9PmThsri5iCKSU9PmsKlw2uyNG48amVxRoFo/ceDdE70cA4uoDjksvBLo8eSD7rz
	 sGSoOlb3Pgga2RYkRf0wOp0ztSnGDxnzpQCjgiFJYXeZX+kFM4MT2WHIfS+6alO0xH
	 2VLrMiRTa831bK0zvXc7nrPNDleL2ENjSMWrucq2iTxtl5K4VPls1yn3rfmeaKGJuJ
	 Sv8DG+x6nzA4XnSW6+Whm0sSfvb8KvG4z8i/uSGVHC7bWFp9MCF4jtDy9LVbQutA7M
	 294FXG+F8Ey7g==
Date: Wed, 20 Mar 2024 16:38:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, eblanc@baylibre.com
Subject: Re: [PATCH v4 09/11] regulator: tps6594-regulator: Add TI TPS65224
 PMIC regulators
Message-ID: <a3ec3c14-eed3-429d-b3f6-0764bcfb8dc4@sirena.org.uk>
References: <20240320102559.464981-1-bhargav.r@ltts.com>
 <20240320102559.464981-10-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z9H/iAfII3PBOX7h"
Content-Disposition: inline
In-Reply-To: <20240320102559.464981-10-bhargav.r@ltts.com>
X-Cookie: Androphobia:


--z9H/iAfII3PBOX7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2024 at 03:55:57PM +0530, Bhargav Raviprakash wrote:

> +static struct tps6594_regulator_irq_type tps65224_buck1_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_BUCK1_UVOV, "BUCK1", "voltage out of range",
> +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +};

These all look like they should be _REGULATION_OUT given that the
interrupt names are _UVOV which look like they could be either under or
over voltage.

Otherwise this all looks good.

--z9H/iAfII3PBOX7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX7EPwACgkQJNaLcl1U
h9C33Qf/SK43LIIBuu6A1cE5VdiwLJ+7i3NH/P3xXDF4J9G2ic8BC68uYOV1rekm
CmKoq6tpnTt/JjjUXTqrp85gD2QmFzcUElvR5AJgwSQKvWvMSYSyC0MSe0PGBg6P
VruWKljEYGHSgxvdC4fkOQTlsp8Qntk2EXUXIL3QbtL+auVsKhmkQJBmG1xIPy1H
YeHN+XmIMuORdXttP0REyjc1C3/oWOo5WW0R5dgsRbgndF6jfufoU3k0JsvDoyPj
wAA3z0M7giEnfG7hwn16avEhFa2bo8FV2euj7p2KLJNuvwNeF9DBOyefMOOaEv9F
1Z7HvBMpq+qoeU0g2CwExaT/rE+VgQ==
=zsxV
-----END PGP SIGNATURE-----

--z9H/iAfII3PBOX7h--

