Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B41F786B63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjHXJRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjHXJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:17:14 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF2B198A;
        Thu, 24 Aug 2023 02:17:11 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6313186537;
        Thu, 24 Aug 2023 11:17:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1692868629;
        bh=MjCYFkH+kWFgdHXjUV3IPSIdSKo1123l7R50xgXphJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wH/SP0401DvS3UXyFIV0UCPuBuH5eED4hHKap1Qf2v0YH/Ry2kUwM0CxDw2iobSTM
         ArkNkFrY4HQYakEDJLUqVk7nyWwE1NUz/Nk8b8S1+YFPUM7VjOXg7TYSRUrS4baj82
         bV/3heEAwPuj27tcLmTbrLkKAWqbtzDS3Q3MN6a4MvCw7qHwD0Z6PvJ0np25pDRaCO
         ycvYw4um1vD2NuHXOSQBrZjx/rUVL/fV3Wh8GQ3E6c712XlJTNjP+Yz7TJznMx0qVQ
         tYP1TQUhiO9Ykgu6/gQ9+mesr2O4RCesf7jrofCO8UM/iLtCp6VwfE5QQYr3iAugtm
         fZgTdMLVcUkFQ==
Date:   Thu, 24 Aug 2023 11:17:02 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: ksz9477_evb: Add tx-internal-delay-ps
 property for port5
Message-ID: <20230824111702.1a034801@wsk>
In-Reply-To: <20230727080656.3828397-1-lukma@denx.de>
References: <20230727080656.3828397-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vzI0HJKtdWEXGL/5zVg7OHh";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vzI0HJKtdWEXGL/5zVg7OHh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> Without this change the KSZ9477 Evaluation board's Linux (v6.5-rc1)
> shows following device warning:
>=20
> 'ksz-switch spi1.0: Port 5 interpreting RGMII delay settings based on
> "phy-mode" property, please update device tree to specify
> "rx-internal-delay-ps" and "tx-internal-delay-ps"'
>=20
> This is not critical, as KSZ driver by itself assigns default value of
> tx delay to 2000 ps (as 'rgmii-txid' is set as PHY mode).
>=20
> However, to avoid extra warnings in logs - the missing
> 'tx-internal-delay-ps' has been specified with the default value of
> 2000 ps.
>=20

Gentle ping on this patch.

Claudiu, could you pick it as well?

> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
> b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts index
> 99cd6d15998b..b66570080894 100644 ---
> a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts +++
> b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts @@ -152,6
> +152,7 @@ label =3D "cpu";
>  				ethernet =3D <&macb0>;
>  				phy-mode =3D "rgmii-txid";
> +				tx-internal-delay-ps =3D <2000>;
> =20
>  				fixed-link {
>  					speed =3D <1000>;

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/vzI0HJKtdWEXGL/5zVg7OHh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTnIA4ACgkQAR8vZIA0
zr2P5AgAoIPPnd/GsYkKjJRm0/8xk7A3nzmKSkn+olPPZMFBzLZP9EWnvI+3eYFw
QzxvJPJyIt4bRcgtj5Ei/r4MrtiD/BU3g92sT4Q1uK4pIpAuLJvGI0b658k9zpA2
FWK5KD035vX1QSn45CTq9/vlFGqBGSm9OKM30FtuayR/tZwxSdH58tqMwVCzc30c
Jjy0DRS9s0YLTIGVyStrYkm5Tz0AMxhdO3tbm0nIi48/O8BQIQgxlRiNSbpbogvf
lmvbO4sh+7ZjVvbjLoB73SRxAj4Fd4RXdqBMf+Z14O7kEknvCPDnEf8zQoyTpUsw
ST7GuHD5WyPAuiQ55Ol4/VgCZMhSLA==
=L7OX
-----END PGP SIGNATURE-----

--Sig_/vzI0HJKtdWEXGL/5zVg7OHh--
