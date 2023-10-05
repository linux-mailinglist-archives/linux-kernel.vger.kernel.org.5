Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35C7BA1D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbjJEOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbjJEOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:42:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C430D8723C;
        Thu,  5 Oct 2023 07:17:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5929C3277D;
        Thu,  5 Oct 2023 10:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696502472;
        bh=H7QsAgn7LBwCWmNPERn7PZ2ivqiRzZN2vcLos6zUMnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TY0lOBANpSJ4TxeMou7VuKThItJptvQjXX0Y0Xu3mm8YmwEPszlJJ/MErAikK+n+i
         6RDZ256+EU1mMXcXp+m0dIfqL0OhbR2Kl4eSWJZGU/vt4mQLO2voPdAxoPvhU3Xt5L
         1Hr2NsE2qLzE5QIYoRf5V/Y5ZEtMkoiLYz5xxe5Jf3GWZ4EKntLhjh579aBa2g4mHV
         cS6078ZODgR38pDzNZBBxUF05eOIKvqcKLTjWxGoG7VC8UvTIDaE2KMl7FuGA+dxGL
         R02VNMyywG036Phd8x3Hzc+UGj+99bvQBe9Ro+c5p2xcrAbgGU+zo+LRkbIOw5yR7f
         NLNUy1TO7x6fg==
Date:   Thu, 5 Oct 2023 11:41:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: add missing reset-gpios constrain
Message-ID: <20231005-thrift-backer-d2f58a1bd441@spud>
References: <20231005083650.92222-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IP8sdSnYW24Jv8+L"
Content-Disposition: inline
In-Reply-To: <20231005083650.92222-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IP8sdSnYW24Jv8+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 10:36:50AM +0200, Krzysztof Kozlowski wrote:
> The Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> schema does not enforce number of reset GPIOs, thus each device binding
> must do it.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml | 3 ++-
>  Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml    | 3 ++-
>  Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml | 3 ++-
>  Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml=
 b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> index 2594fa192f93..2a04906531fb 100644
> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> @@ -32,7 +32,8 @@ properties:
> =20
>    spi-cpol: true
> =20
> -  reset-gpios: true
> +  reset-gpios:
> +    maxItems: 1
> =20
>    interrupts:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/=
Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> index 4e508bfcc9d8..5121685337b5 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> @@ -78,7 +78,8 @@ properties:
>            - const: -1000
>            - const: 22000
> =20
> -  reset-gpios: true
> +  reset-gpios:
> +    maxItems: 1
> =20
>    adi,dc-dc-ilim-microamp:
>      enum: [150000, 200000, 250000, 300000, 350000, 400000]
> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml=
 b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> index b9b5beac33b2..5b6cde86b5a5 100644
> --- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> @@ -23,7 +23,8 @@ properties:
>      maxItems: 1
>      description: Connected to ADC_RDY pin.
> =20
> -  reset-gpios: true
> +  reset-gpios:
> +    maxItems: 1
> =20
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml=
 b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> index 2958c4ca75b4..167d10bd60af 100644
> --- a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> @@ -23,7 +23,8 @@ properties:
>      maxItems: 1
>      description: Connected to ADC_RDY pin.
> =20
> -  reset-gpios: true
> +  reset-gpios:
> +    maxItems: 1
> =20
>  additionalProperties: false
> =20
> --=20
> 2.34.1
>=20

--IP8sdSnYW24Jv8+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZR6SwwAKCRB4tDGHoIJi
0gJnAQCE6henlUKuR+rKeIPonoiRNWu9XupZ7JL5eHFos8uHxgEAsfvRvMaMcYu6
ZlvDaY0cp2AXNAKJL00y4ydHUa3tSgM=
=Kzfj
-----END PGP SIGNATURE-----

--IP8sdSnYW24Jv8+L--
