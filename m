Return-Path: <linux-kernel+bounces-155604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D088AF4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81333B22511
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1D13D896;
	Tue, 23 Apr 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7pqCXnC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F613D638;
	Tue, 23 Apr 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891376; cv=none; b=ZqjIYux1y/AuBke1NeI0CQ0c2j49LviFFhbGGjrIhsdyFtGj8TJxo2MJZbSZJel5UhnxRnPF9p5v6A14Jks4QJ1ygmfI2ueDQHd0SJHLvBpR1IS8KKKCgECDB+gJz7maLCYgyN/GeGOE3sMeR+kFRkQkfWMk2z+5J7qcW0Lr178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891376; c=relaxed/simple;
	bh=9jKImSKJH//yp89TtUBPLUkHY2ItM8gvJTkZo98APIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCm8ajukOg5hNNIcTRfOHMeSeKAQrxgoTii5mD/euYGeugaRyDyWW6U9yB6sdTE/WUzN54Upuz1HnjvdBQUJtlsn7WesBYlqzGOxmb61EEZ28xVcG9Rlfj94WFQS6TXvGBeYZ1nk17l95NGHjqOZgJnEMUXI3L96tMVai899eMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7pqCXnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EB5C116B1;
	Tue, 23 Apr 2024 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713891375;
	bh=9jKImSKJH//yp89TtUBPLUkHY2ItM8gvJTkZo98APIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7pqCXnC0c+AKjGt7ps4NLqvG1MZr+CIoURfC46QPTZXNrPI+8bc8ubOSgl5YWzxd
	 uOBz2QvIj3WTd+yoNcDW4MMVzP8vNIe4WTudrmYtXAL8oG8gfMIg/v3FL21WqqJhZZ
	 WflEsdgNVsOfXcauiWWXmo3bxoCInTxrPrqJ7byHc8AYM13g9kVzRr7CgtH9+1kexe
	 0HdFKuODKdnNG2qPHQecDVjRTqc5srs8LYv4I3/CRv4Q7JsN2NnMUTEb/lLg6UGIMZ
	 3Md1MBvmSQfzFhCcnX5Kap2+znFipX5HDII2S4djNtKhNZW5CenSshViBS1/KPhUX0
	 hxWVUQdOQjkJw==
Date: Tue, 23 Apr 2024 17:56:10 +0100
From: Conor Dooley <conor@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: u.kleine-koenig@pengutronix.de, neil.armstrong@linaro.org,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, thierry.reding@gmail.com,
	hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 pwm
Message-ID: <20240423-wildcard-smoking-90b50f00da50@spud>
References: <20240423161006.2522351-1-gnstark@salutedevices.com>
 <20240423161006.2522351-2-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kfOnWG+PV/EmHtbK"
Content-Disposition: inline
In-Reply-To: <20240423161006.2522351-2-gnstark@salutedevices.com>


--kfOnWG+PV/EmHtbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 07:10:05PM +0300, George Stark wrote:
> The chip has 3 dual channel PWM modules AB, CD, EF.
>=20
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

a would sort before s.

With the re-order,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Doc=
umentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index 1d71d4f8f328..ef6daf1760ff 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -37,6 +37,7 @@ properties:
>        - enum:
>            - amlogic,meson8-pwm-v2
>            - amlogic,meson-s4-pwm
> +          - amlogic,meson-a1-pwm
>        - items:
>            - enum:
>                - amlogic,meson8b-pwm-v2
> @@ -126,6 +127,7 @@ allOf:
>            contains:
>              enum:
>                - amlogic,meson-s4-pwm
> +              - amlogic,meson-a1-pwm
>      then:
>        properties:
>          clocks:
> --=20
> 2.25.1
>=20

--kfOnWG+PV/EmHtbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZifoKgAKCRB4tDGHoIJi
0pMNAQCxYf8hqWwkb4mI3niPQvLerhHnsj4GAXUEra2Y5SFWyAD+O8aq8lBtJQo7
Ia++PthnUZ+ozioT++tgnXb3SPOeQQ8=
=hN7Z
-----END PGP SIGNATURE-----

--kfOnWG+PV/EmHtbK--

