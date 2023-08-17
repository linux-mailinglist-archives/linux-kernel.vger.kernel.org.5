Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935FE77FF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354891AbjHQUfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347201AbjHQUew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:34:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB52698;
        Thu, 17 Aug 2023 13:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C76B63CA4;
        Thu, 17 Aug 2023 20:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F655C433C7;
        Thu, 17 Aug 2023 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692304490;
        bh=EawwIHxts40KJgWHDnnf/ZI2tPV3YLGiiOHqM/k1B64=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jt6WQ2g6JK9heq/R1CrwwHaDTtEzMSsyF8j1ktbc4MTrlAJ1lr9jmkiv03THTkrK7
         5gVyfmZTA+lJK3lSBgJwOEfyfLiBiiV4mE9Q961arTKLnV4bJzZAl9f15wehQCnZAJ
         JWBZ+HjhCjlgQTHfcM+Ijep9jpAoeRPmlcBgpdd02SeiyCAeecxYZ6pZDPqTV/NitS
         bOJP0JEQ0lI3Us6XYyZvPE540EH/tRHpxt8Avn1HftB2vCDy31fspK8biHJmOr578O
         XU068vJvmC+fxHwVH2JrvRDuga3F3qh9AnonqMWylQi0At09pUtm/7butpbU2vTsGj
         lB6WEEpZemoMQ==
Message-ID: <574d3a14-6b6e-3ad2-2ce3-48c9d76e205c@kernel.org>
Date:   Thu, 17 Aug 2023 22:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/4] linux/array_size.h: Add ARRAY_SIZE_OF_FIELD()
Content-Language: en-US
To:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-3-lucas.segarra.fernandez@intel.com>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <20230817143352.132583-3-lucas.segarra.fernandez@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sAmmQOSg4fjhAOuWWb3mO1tT"
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sAmmQOSg4fjhAOuWWb3mO1tT
Content-Type: multipart/mixed; boundary="------------EkpoUnKeBvbrOyfa0IyZSoTF";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
 herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
 andriy.shevchenko@intel.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID: <574d3a14-6b6e-3ad2-2ce3-48c9d76e205c@kernel.org>
Subject: Re: [PATCH 2/4] linux/array_size.h: Add ARRAY_SIZE_OF_FIELD()
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-3-lucas.segarra.fernandez@intel.com>
In-Reply-To: <20230817143352.132583-3-lucas.segarra.fernandez@intel.com>

--------------EkpoUnKeBvbrOyfa0IyZSoTF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 2023-08-17 16:33, Lucas Segarra Fernandez wrote:
> Introduce ARRAY_SIZE_OF_FIELD() in order to get the number of elements
> of an array struct field.
>=20
> Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.c=
om>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  include/linux/array_size.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/include/linux/array_size.h b/include/linux/array_size.h
> index 06d7d83196ca..37dac0473b5c 100644
> --- a/include/linux/array_size.h
> +++ b/include/linux/array_size.h
> @@ -10,4 +10,12 @@
>   */
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_ar=
ray(arr))
> =20
> +/*
> + * ARRAY_SIZE_OF_FIELD - get the number of elements of an array struct=
 field
> + *
> + * @TYPE: The structure containing the field of interest
> + * @MEMBER: The array field to be sized
> + */
> +#define ARRAY_SIZE_OF_FIELD(TYPE, MEMBER) ARRAY_SIZE((((TYPE *)0)->MEM=
BER))

Some comment about the name:

ARRAY_SIZE() is rather ambiguous, as there's array_size()[1], which means=
 the
number of bytes needed to represent the array.  I suggest a name based on=


-  _Lengthof()  It has been proposed to ISO C to get the number of elemen=
ts
                of an array:
                <https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2529.p=
df>.

-  sizeof_field()  The kernel macro for the size of a struct member

So, how about lengthof_field()?


Cheers,
Alex


[1]:  The definition of array_size() is here:

$ grep -rnB10 define.array_size include/linux/overflow.h=20
238-/**
239- * array_size() - Calculate size of 2-dimensional array.
240- * @a: dimension one
241- * @b: dimension two
242- *
243- * Calculates size of 2-dimensional array: @a * @b.
244- *
245- * Returns: number of bytes needed to represent the array or SIZE_MAX=
 on
246- * overflow.
247- */
248:#define array_size(a, b)	size_mul(a, b)


> +
>  #endif  /* _LINUX_ARRAY_SIZE_H */

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------EkpoUnKeBvbrOyfa0IyZSoTF--

--------------sAmmQOSg4fjhAOuWWb3mO1tT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTehGAACgkQnowa+77/
2zLguQ/+PFo7wVSyTzIdvY+q2cLee6kZR3fi9uSP4D5dLInil3oEK4b446gt4oNi
SdGzF+7A81HkZFE70xbrGjsC42ymR+Gqa/4PumYag/E2oYOuyq3esaLxzVtIJimn
g2udYQA5UT/vf8uv0/GPW/53sy0eQatir9R2ns39BCO8uhdoIMqtwkiWY4HLYzd7
l9WHdqwLlJGYga1O3P3blFIxhZhKlaR95RHUPiXtDyqH4+01rEjTXnWfEbXZT313
22Ny03S5DB2bZ/XOJvyO2jzIE9rmVM4BqaL0CxXkmOIATTfayS8RglgCl2VT6EC6
re66+FOOo6m6Ot/LHFJLTqIr03U9lzxH1OU15RWMoJjORcP8ejrQ6fV1SmLOqfrM
m8sMnpIeW62bSw2RPslB+9G77FOuwPXouApEZa3vMUUgShJO6lfaLZ3deLMI+EyM
9l5OHbjH5TidxxiWXGT+3KdRPPAdofn6vNOFsQ34GZ7deq3zWl6ftPfyjUoI4Ulw
15RLh+MZZFVwO1xoNP3EGJSbIa+670C/0y6mj+NppvXFCrAZRWuA3n/CnZQVf1hP
67KTBNt9LgTsaGUKkSlD5/VnPfQYvCtSOGmNXrDO7jioqysR/Fyo2slsM/PQ+0yK
/xxYylN6MoBVNXcE+ZLySGoM1LdtNHcnXG4dAE0EUERr9NzsTPk=
=xQQt
-----END PGP SIGNATURE-----

--------------sAmmQOSg4fjhAOuWWb3mO1tT--
