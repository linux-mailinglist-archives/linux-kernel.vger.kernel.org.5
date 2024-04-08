Return-Path: <linux-kernel+bounces-135489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE989C698
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58381C21BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDE86278;
	Mon,  8 Apr 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMrzckds"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C738614B;
	Mon,  8 Apr 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585629; cv=none; b=tMXTQfuqa1OcMazWwplkVMof4ToBbGrkQOkMijOPdBfwitjZkuZp6yvQBK4vR8iLJurEMCnVoTGUdH0sbAeYlI1+9QOFVCbu+Fnu02RorMOGFeYesFmETl7efm8otDK2Y/S7GtxMQ99sShGbrtirp/6uZPYrbG9zsB5UM7BDy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585629; c=relaxed/simple;
	bh=PN3EVGdIT22p0iInU9eqjAvAlp2yLfTGWwn15PyI1ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9KbGdHWcB55klrGVXkdC3tChpAN5F2LDRi4UcSjRU9Oal8OXq9fnQzPjdlrcg3LbJqrgFAwBYrgNkPcUeW/7FYO4hUZMAu4KqWx6l+Qlw0vMSNMRZWTtvWO1A6HRJLdse7+WWsth3Eqyw4CCxwq8UbQyh5c2OKgAqcrGtmK5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMrzckds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA8CC433F1;
	Mon,  8 Apr 2024 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585628;
	bh=PN3EVGdIT22p0iInU9eqjAvAlp2yLfTGWwn15PyI1ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMrzckdskiXxmdUdDbpLQNJijkSQtzQzAGdNQJww/qHPMHsaV4d3upEhvC594LgCU
	 bP3QqWTw54h28J/kURMz5IoVSPsR3qU/lfRVNjF5LKR2ACKu638c0gbxAwce2IIJNH
	 td6jiRFNqnCV0JL08MPeBs2tOTgp88llY8Ib8R/big+8f2xF8akcHvO7p/eo0ATnRU
	 eOxtiWI+FcOxWH8Rg27nTfbfXYUmy/RVpK7bgxERRr6LyrMGoIQ/zVfJDNP61Mh/DL
	 vf0n7szNdUrzn1kBKSxpr2ob0J0PxYMCIrETDpRaWUD61L8Qx+7i5YUq3jOxOO5vAJ
	 blj6zRhK7FyFw==
Date: Mon, 8 Apr 2024 15:13:42 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 01/11] spi: dt-bindings: cdns,qspi-nor: add
 mobileye,eyeq5-ospi compatible
Message-ID: <6209607d-b7bd-4649-90ba-91edaafb44ec@sirena.org.uk>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-1-956679866d6d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K/ziSruPoakVkQe+"
Content-Disposition: inline
In-Reply-To: <20240405-cdns-qspi-mbly-v2-1-956679866d6d@bootlin.com>
X-Cookie: Drive defensively.  Buy a tank.


--K/ziSruPoakVkQe+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:02:11PM +0200, Th=E9o Lebrun wrote:

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mobileye,eyeq5-ospi
> +    then:
> +      properties:
> +        cdns,fifo-depth: false
> +    else:
> +      required:
> +        - cdns,fifo-depth

My suggestions on the FIFO depth probe patch would mean this would turn
into making cdns,fifo-depth optional for everything.  It certainly seems
like many instances of the hardware should support that anyway.

--K/ziSruPoakVkQe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT+5YACgkQJNaLcl1U
h9CYqwf/ZJ/2hIol91UHwH0JscswvtALjAO38wiPxgUsL1yZbgndn5CnpwJyaAJ3
PYGu1ckOox3ywOyKCgcT9q9JEzDACpq8qDIoM0j6SXrQNpFPPgcs5aLHU58jl0qt
1gLU31AgeJ3nZ19nHV+8uyG56IvQ7jTpI7Biu0BKNbs8uGI9WYUUltlDtBNCrP78
FS04g/RIGmmVEiq/dxNVvkk2o5ZMwcNiIXCPlfQTtolt12rprdC5LYJPqR9dWfOZ
ZYMz3rOzKKv4kTB39aRHesF8Dj/svAg/ypnXWTTLcTfL6E48EXfNgcPco4Dx5VXF
SgkSLtrUqkSyA1ZdVJwuND84KKWRkA==
=WB2t
-----END PGP SIGNATURE-----

--K/ziSruPoakVkQe+--

