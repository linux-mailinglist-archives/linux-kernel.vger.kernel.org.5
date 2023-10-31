Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC257DC93F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbjJaJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343740AbjJaJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:16:41 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBD89F;
        Tue, 31 Oct 2023 02:16:38 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5CBFA1C006B; Tue, 31 Oct 2023 10:16:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1698743796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jn+Evfzcr75myizwywLoe/KMO2gJIGhQeoCHBpAkFXk=;
        b=VV9lesz2cKbKq5VdigAlQcC45nA8q2Ij4Wf2JscnIKd0xePTYcbgEzu1SPZsHaT0fpVm68
        +b8cxI2wl2rAv0Lav3nm+67AN3JmSWJHD8h+i+50e5R+O5eEPA7dvtifaBbUOwx89bFfpU
        C40xSsaMcsEoz1iIWvajYfmeqo8kvpE=
Date:   Tue, 31 Oct 2023 10:16:35 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap4: embt2ws: add LED
Message-ID: <ZUDF8zuKdYp/k0ox@duo.ucw.cz>
References: <20230819143109.471615-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="F0bfpAw7xJvIBZth"
Content-Disposition: inline
In-Reply-To: <20230819143109.471615-1-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F0bfpAw7xJvIBZth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add LED since the driver is now available.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Is it one LED or three LEDs?

If it is one, we should use multicolor...

BR,
										Pavel
									=09
> @@ -206,7 +207,31 @@ &i2c3 {
> =20
>  	clock-frequency =3D <100000>;
> =20
> -	/* TODO: BD2606MVV at 0x66 */
> +	led-controller@66 {
> +		compatible =3D "rohm,bd2606mvv";
> +		reg =3D <0x66>;
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		led@0 {
> +			reg =3D <0>;
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			function =3D LED_FUNCTION_STATUS;
> +		};
> +
> +		led@2 {
> +			reg =3D <2>;
> +			color =3D <LED_COLOR_ID_BLUE>;
> +			function =3D LED_FUNCTION_STATUS;
> +		};
> +
> +		led@4 {
> +			reg =3D <4>;
> +			color =3D <LED_COLOR_ID_RED>;
> +			function =3D LED_FUNCTION_STATUS;
> +		};
> +	};
>  };
> =20
>  &i2c4 {

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--F0bfpAw7xJvIBZth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZUDF8wAKCRAw5/Bqldv6
8mWnAKCiBU5Ff0xWIgBXzcW1R+AgdHju8gCgkai3U4j4/etK2ZP+ugVFix21tec=
=yOLR
-----END PGP SIGNATURE-----

--F0bfpAw7xJvIBZth--
