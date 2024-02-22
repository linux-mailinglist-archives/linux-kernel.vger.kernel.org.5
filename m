Return-Path: <linux-kernel+bounces-77402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03AE8604CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8808B1F28193
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD4012D1E5;
	Thu, 22 Feb 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Cxlj8Z+M"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98016AF97;
	Thu, 22 Feb 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637361; cv=none; b=WqUmKrRjUZxbts9UhXO0tk0mx7Wg4SfOuNsx/6GyGS3syw1YQ+QtShj7b1ZwVJvEUhe1K9+INrBWKI250LX2VkQnJdUzi7QRJu2WSypDw6cDiQs5lC+j8nksfu58M2oOun5zTZhlAfHzyzVP0atRQ8fFhWVU9QBZ9eCMJM07WVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637361; c=relaxed/simple;
	bh=HG2D6ZbKX3Ka04Z4EDA+DvlmWQiaZMNyF9JBV70NRas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLpKkHGbZ56TSF+eHmfc08dOgNI8j8F/zFjcMRWathtpYThT1kMmQq+GqoOZ/Sjk9AcZVcAAgmeH9BXOsSb9C8W0v/ycGE+Xv9jAbG+vqKk0XN2WVWXUAyZhXzqj5GZ5JBajdd27766F7dAa0R9Oc5BzbuI8t0gWR3amkDCcNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Cxlj8Z+M; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 95CC11C0080; Thu, 22 Feb 2024 22:29:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708637356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etynK4yl93X6g+f6SCBso0Li4Uq2fgrPp1w3YxRsCeQ=;
	b=Cxlj8Z+M+JOxAVwRX5Of0OcP6qzv8AwTgPRHue1FJQSL4ntClQAtkBWdLMlAiO0nNEvmi4
	6/9qWlc6QumW/aX9Eq0h6hc2uzYQv8Yd53kvdClE1XFT34mBJ+iJnRR6zzArpqO4FQMckK
	1T6fci+LhUratdhhccuxkW2B2lArPL0=
Date: Thu, 22 Feb 2024 22:29:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: analogix,anx7411: drop redundant
 connector properties
Message-ID: <Zde8rC5NYZY9YZFI@duo.ucw.cz>
References: <20240222082819.10321-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x++mmq8JmcAhj/6l"
Content-Disposition: inline
In-Reply-To: <20240222082819.10321-1-krzysztof.kozlowski@linaro.org>


--x++mmq8JmcAhj/6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The binding references usb-connector.yaml schema, which lists all
> allowed properties and ends with unevaluatedProperties:false, so we can
> simplify analogix,anx7411 binding by dropping everything covered by
> usb-connector.yaml.
>=20

Reviewed-by: Pavel Machek <pavel@ucw.cz>

Thank you.

> +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> @@ -23,24 +23,11 @@ properties:
>    connector:
>      type: object
>      $ref: ../connector/usb-connector.yaml

You wanted me to use absolute path here -- $ref:
/schemas/connector/usb-connector.yaml -- so it may be worth fixing
here as well.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--x++mmq8JmcAhj/6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZde8rAAKCRAw5/Bqldv6
8qRtAJ9dfhXehuQIjR04qGEB1GJZVrDMmgCgoZD1Xo3m7sq2+1Zd1eYmg8a0xhk=
=W00v
-----END PGP SIGNATURE-----

--x++mmq8JmcAhj/6l--

