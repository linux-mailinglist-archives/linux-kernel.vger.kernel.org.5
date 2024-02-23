Return-Path: <linux-kernel+bounces-78950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD4A861B44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450B1B22151
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACBF143C59;
	Fri, 23 Feb 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVl4fIJJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639A12BE98;
	Fri, 23 Feb 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711989; cv=none; b=DThNnqyL37KxSz9xKH99BJxhHuoNV67waTgGdLjC24apvy0g7amXitxEH5JkEUAqKq9ltALnx8xaONfLU9BO/T9KohhKBhgm8wkCpdJ83RwCwyvUWHINEw8D2pXg++I7BBBTW2OFoi1akoCwQ4EK+tvCLJGw1ExLohyOI3RFQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711989; c=relaxed/simple;
	bh=enx2K6Ij/uIYYAm7cQJRoqrjG1WQH3iZrnwhAqZPM1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU1XlxdfjC3DpVtn7Zqm2XaW5RIu06JlkdO5iWVycz9gHZa9PwO1iZsRKz0VKlXY34vJDPjd/LFkXJtxOYGjT46fSYFJpkQpLrVQQMQx7de76HA6mx25IkRqWFvBMuByMBiArKxu0PTIos4zkhwYbGhugj1S++fQrZ2TgpHWx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVl4fIJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F96AC433F1;
	Fri, 23 Feb 2024 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708711989;
	bh=enx2K6Ij/uIYYAm7cQJRoqrjG1WQH3iZrnwhAqZPM1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVl4fIJJ/kyILqO+C8u8rYp4xL+FmdcgJSasyiEJXulGM15WTbcMgEVns36Sz9Si5
	 l/sdpgC7+JJ8SeFuxyI1mv/D/Ju1zxJtKEBkmRIAyWZKTvkILPpI5MlZd9i000ggcf
	 2kFmKm+srRzA2HzR+62WHy0POxEooXtPgfElpOGeYC0aJBxe9mwem9zHKlGj7bdF0P
	 PGW/14TDQcG9L3NUs97BKZ5PziP9SDkoj8AIwC3Bys09iQ6RXuQPL3szxT7qg5NtMx
	 fKAc9o2a8ewWB4CxnX4yH55I+MmRilPAGVnFNeBywBdaaJs+SzqdYzqXxQKIUt2dZw
	 8CS179C0yXzFw==
Date: Fri, 23 Feb 2024 18:13:03 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Kevin Hilman <khilman@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/8] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
Message-ID: <20240223-defog-uniformed-b438aefdbc39@spud>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-2-b41c9893a130@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/uJ1wrvYWe5uH29q"
Content-Disposition: inline
In-Reply-To: <20240223-j7200-usb-suspend-v3-2-b41c9893a130@bootlin.com>


--/uJ1wrvYWe5uH29q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 05:05:26PM +0100, Th=E9o Lebrun wrote:
> On J7200, the controller & its wrapper are reset on resume. This makes
> it have a different behavior from other platforms.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Do=
cumentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 949f45eb45c2..d52d5b2965aa 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - ti,j721e-usb
>        - ti,am64-usb
> +      - ti,j7200-usb

This patch will change with what I mentioned on the other binding patch,
but the patch itself is reasonable.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> =20
>    reg:
>      maxItems: 1
>=20
> --=20
> 2.43.2
>=20

--/uJ1wrvYWe5uH29q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjgLwAKCRB4tDGHoIJi
0q5fAP4oulDax7SvhnhcoSGCAjQmWMy//bqFcPSkOPTit0YlTgEAvVvQZiZEGs4x
K8+bZuKQoaJBqC4R7SUtG/A0HUsQjwo=
=CEwO
-----END PGP SIGNATURE-----

--/uJ1wrvYWe5uH29q--

