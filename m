Return-Path: <linux-kernel+bounces-70076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0FC8592BC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E3F28348D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADE7F464;
	Sat, 17 Feb 2024 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/ZaQpbK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7565436A6;
	Sat, 17 Feb 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708202112; cv=none; b=suy8T7tmrokS+YcGJDiDGnE2q2VvPPbkRQHLDsRxrGjj9LPy041J7N6XmEDSeuG7MAHd1lcX0jAX3Bo2XTxAogl9dcyot9YYvzc0d4ZZXUNt78NwschjtUfBXhKpo4p+w2oGMoDel7lkoRkFGiKLRz8ypOAX1nQ//9YTsXliLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708202112; c=relaxed/simple;
	bh=lN8jemn949tn1fSt6HujRxLyBpIYuMpqclzbVBpro4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcdGQVUy06wIO6M23nbTAvs2keI94u5p+8EqiwSPsEw4mOGUXt9DVQLI6r4JmvuKNy8fKu72CTyzaRsn5l8U6kMKveWlki8bzGwkqL1yhgLRV9grG+rFtYrCoT6cUTjehL1zbJ7z7tfIdWOn3XSfY57YMz8IInv02zUL4ThAHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/ZaQpbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA7BC433C7;
	Sat, 17 Feb 2024 20:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708202112;
	bh=lN8jemn949tn1fSt6HujRxLyBpIYuMpqclzbVBpro4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/ZaQpbKqCBenTEpC679IwGfz1VIvTkgidljZW0vQRh634FS1iE/4c9Guyum/ZrKP
	 dequtXOiJ4Nbn20idl4xwtTB0wmq9iqVSENBQKju/oKXxoFgQX8/nlFo/lN5KAWHq1
	 Z7yYSEWsVt0ykeq/kf/VCcBX6F8fDMxGbIIq768cEUBsCnhWNsMPMI6D6VMWaoqKir
	 gVYkojOtJbe+VW9Nc6ux8zjXX3iR/f6j/pM+DsVw/6gnS3jw5jC6gXqDKS532UwEXY
	 wdrGJmrjh24R5XVssK9cajeGYnTL6CMW39hexvfERAxFRZYj80zSN1xUD1PAfgHptk
	 uWnthW/fW+PZA==
Date: Sat, 17 Feb 2024 20:35:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: drop obsolete brcm,bcm2835-pm-wdt
 bindings
Message-ID: <20240217-unbroken-scanner-ae1e97b02d5a@spud>
References: <ZdC/624d1c8O3NRG@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7dSGml3en2apojE8"
Content-Disposition: inline
In-Reply-To: <ZdC/624d1c8O3NRG@standask-GA-A55M-S2HP>


--7dSGml3en2apojE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 03:17:15PM +0100, Stanislav Jakubek wrote:
> These bindings are already (better) described in soc/bcm/brcm,bcm2835-pm.
> Drop these obsolete bindings.
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/watchdog/brcm,bcm2835-pm-wdog.txt | 18 ------------------
>  1 file changed, 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm28=
35-pm-wdog.txt
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-w=
dog.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.t=
xt
> deleted file mode 100644
> index f801d71de1cd..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -BCM2835 Watchdog timer
> -
> -Required properties:
> -
> -- compatible : should be "brcm,bcm2835-pm-wdt"
> -- reg : Specifies base physical address and size of the registers.
> -
> -Optional properties:
> -
> -- timeout-sec   : Contains the watchdog timeout in seconds
> -
> -Example:
> -
> -watchdog {
> -	compatible =3D "brcm,bcm2835-pm-wdt";
> -	reg =3D <0x7e100000 0x28>;
> -	timeout-sec =3D <10>;
> -};
> --=20
> 2.34.1
>=20

--7dSGml3en2apojE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdEYegAKCRB4tDGHoIJi
0pDtAQD++HW96qI2wAr71D7yUlTXn5HeQJvcaQNRsjnD3M3DXAD/RuUYeBE0JNaR
n4dJSIHFEViCCSBleYNqlYkFsmKqgAc=
=cMHI
-----END PGP SIGNATURE-----

--7dSGml3en2apojE8--

