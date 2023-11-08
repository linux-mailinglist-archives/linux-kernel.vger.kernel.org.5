Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C407E5610
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjKHMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjKHMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:17:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED41BEF;
        Wed,  8 Nov 2023 04:17:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A168C433C8;
        Wed,  8 Nov 2023 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699445843;
        bh=7V/UrnIoKR1hXQNmM3fHYk4TXHGghxFBDI9RetIrR3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTnF/3EunAy/n/EtkQHaJx3vItL4cSDVDLs/F9tkv5i7pc0qpx9Ljy0DdpI9RNMUj
         y+4ePbrg5HnrgO1qS6jnxhqG7uAnuxEN5M85JJg+3cO6OIM0QseItr2gK/riow4nYO
         GtyTOe6EKUEw+3c0A2sGr6ANhuzP9MDpdxttFp07scZCfMVYn7V81E9oUMoD9asPJZ
         LE5BxKejmYHkTjJ1BSpXqScS1UW/gu9/YXbBr4KN4f7QHEHq8PYzAE7tUw40KifrKV
         loQGxwzW062JR+Bic9nBu+j+mvNX/LyMtwzCcdQbvRmGB29igTeQJ2q5BRz+CpznHE
         ckiETsNNJvO5Q==
Date:   Wed, 8 Nov 2023 12:17:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ryan Lee <ryans.lee@analog.com>, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: use "soundwire" as controller's node
 name in examples
Message-ID: <20231108-outback-composed-c620cd86c234@spud>
References: <20231107101610.13728-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6PrPU5pOkEEUIIG5"
Content-Disposition: inline
In-Reply-To: <20231107101610.13728-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6PrPU5pOkEEUIIG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:16:10AM +0100, Krzysztof Kozlowski wrote:
> Soundwire Devicetree bindings expect the Soundwire controller device
> node to be named just "soundwire".  Correct examples, so the incorrect
> code will not be re-used.
>=20
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

FWIW, there are a few instances of "soundwire-controller" in qcom
devicetrees that you might also want to change.

> ---
>  Documentation/devicetree/bindings/sound/adi,max98363.yaml | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/=
Documentation/devicetree/bindings/sound/adi,max98363.yaml
> index a844b63f3930..c388cda56011 100644
> --- a/Documentation/devicetree/bindings/sound/adi,max98363.yaml
> +++ b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
> @@ -39,7 +39,7 @@ unevaluatedProperties: false
> =20
>  examples:
>    - |
> -    soundwire-controller@3250000 {
> +    soundwire@3250000 {
>          #address-cells =3D <2>;
>          #size-cells =3D <0>;
>          reg =3D <0x3250000 0x2000>;
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml b/=
Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
> index ba572a7f4f3c..8e462cdf0018 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
> @@ -52,7 +52,7 @@ examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> =20
> -    soundwire-controller@3250000 {
> +    soundwire@3250000 {
>          #address-cells =3D <2>;
>          #size-cells =3D <0>;
>          reg =3D <0x3250000 0x2000>;
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml b/=
Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
> index e6723c9e312a..d717017b0fdb 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
> @@ -48,7 +48,7 @@ examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> =20
> -    soundwire-controller {
> +    soundwire {
>          #address-cells =3D <2>;
>          #size-cells =3D <0>;
> =20
> --=20
> 2.34.1
>=20

--6PrPU5pOkEEUIIG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUt8TAAKCRB4tDGHoIJi
0jpSAP48y9NqKH1qbbnEmCHyS9qNSJNgiOaoUevxsgcpPscGzwEAqFquFreorzyT
zAoJ1HXSZDG4PAhSwyJDUwtZ/wPGhQE=
=CPNX
-----END PGP SIGNATURE-----

--6PrPU5pOkEEUIIG5--
