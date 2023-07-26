Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43B2762FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjGZIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjGZI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:29:36 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7862D7B;
        Wed, 26 Jul 2023 01:19:22 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D004B847BC;
        Wed, 26 Jul 2023 10:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690359555;
        bh=CrdpJ2vBz6aBd3uf8T7S1gyU7zfMzUcFAcjQO5gqUV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=haA57/3kycbXOLlDQLe79fBqXLLdn4xhUraINZA1noG6zh6WePawdFeS6kblHfU2w
         TUOJ2Jbt+ovepOTnAyF62+9e6O/BtSmGCNY+z/aPlMstjLvbsBKzkRuwfS+LaQRBvc
         Kz983M2QpFFm/LADDXTOUE7ItGhpIfn+ME7Okt6DaFuIhiwrBLUWCAZf8+BfteZSDw
         7Hu4j7Dpc/uTVJwazJhenSOZhgKH5VMetIcMkfQd8yxGIz62YDEwMa3IwqBN1QaOCq
         v31tXF/FWVh+BW9wFHM8f6vrmkPX/sq4kH7Pi/8mQEbZqw/I5J0VbDYiPCRmM+htsW
         tZTUJNAgxCfvA==
Date:   Wed, 26 Jul 2023 10:19:02 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: ksz9477_evb: Add missing timer nodes
Message-ID: <20230726101902.769f6541@wsk>
In-Reply-To: <20230712152111.3756211-1-lukma@denx.de>
References: <20230712152111.3756211-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PExcZCVXoc1GKKSFBr4TB/Z";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PExcZCVXoc1GKKSFBr4TB/Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> Without this change the KSZ9477-EVB board hangs just after passing
> execution flow from u-boot to Linux kernel.
>=20
> This code has been copied from at91-sama5d3_xplained.dts.
>=20
> Test setup: Linux 6.5-rc1
> Config:     arch/arm/configs/sama5_defconfig
> Toolchain:  gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabi
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  .../boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts  | 12
> ++++++++++++ 1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
> b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts index
> 14af1fd6d247..99cd6d15998b 100644 ---
> a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts +++
> b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts @@ -162,6
> +162,18 @@ };
>  };
> =20
> +&tcb0 {
> +	timer0: timer@0 {
> +		compatible =3D "atmel,tcb-timer";
> +		reg =3D <0>;
> +	};
> +
> +	timer1: timer@1 {
> +		compatible =3D "atmel,tcb-timer";
> +		reg =3D <1>;
> +	};
> +};
> +
>  &usb0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_usba_vbus>;

Gentle ping on this fix ...


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/PExcZCVXoc1GKKSFBr4TB/Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTA1vYACgkQAR8vZIA0
zr1+dQf7BycEiyg+LGXfbFNR/xEzwg2yp7sJ8MkBl9M4whE8NSITOKy5WTzjNbzF
uveTVKO6XplzK/en3Hfk2m9hzDEKfr9xOLkQRUICBDdGtC3dcsEyRk+/6IJoDTup
MHFSf134sxK7/cm76oavYQRlA0FALzAGSt/HtXtQjiS0maRPlPE9m3Beig/o2KuE
dI90i01XqFzECbCkFbFdeBwi7VVM2OZ6TeVyFBysXDut2QeGdbJBqZMybRn68bIS
gePAOBuV5RJznc63iWom2jixzaIUXj1PmEz3Zl0HdOYgiOnSSuXt62Pgcka31/j9
GxYJnYZ5yxdR91lGzuFjB0MS5BBvpQ==
=CKhP
-----END PGP SIGNATURE-----

--Sig_/PExcZCVXoc1GKKSFBr4TB/Z--
