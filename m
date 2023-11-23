Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1737F688F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKWUzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:55:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B8ED46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:55:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D482C433C7;
        Thu, 23 Nov 2023 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700772956;
        bh=ljvADzGfj9Rw3shLMI/eqAb24E3mdeOe87KbCWGRLM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLBWv7zMEqF+yj4oGEzvKcMfIXtrFLjMhTQZom5zp50tl+Iktoj/3JwIKiPnFQVGd
         BkkOj0dFz+8dM/wfzZ4b1FbeU91gZ2vkIpCTfJv4+vUfaphrZiKKx2X1n0IJavE1q2
         SAlPOGAjJ4DoygsIyUtme+JNPtVX1S0T4B37ObazruhxMaX3qgneYBuzBRMSf3fjzl
         Bwa8LEh44ObfzVd/a6t59PzsFTeEinGyjXfrFOdeUOt+H2l0XbxCg9IrvUT4WTSfMX
         ZNFlDLfXGsHgFtSC/jxzcl709RqUNsHz6wc+H0RVvsUg2tLTXNQE5CSVCq5wjW/YTG
         oK/CqkpgoizvA==
Date:   Thu, 23 Nov 2023 21:55:53 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Sergey Kozlov <serjk@netup.ru>, linux-i2c@vger.kernel.org,
        Abylay Ospan <aospan@netup.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c:
 Don't let i2c adapters declare I2C_CLASS_SPD support if they support
 I2C_CLASS_HWMON
Message-ID: <ZV+8WZk5ZKAmroED@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sergey Kozlov <serjk@netup.ru>, linux-i2c@vger.kernel.org,
        Abylay Ospan <aospan@netup.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231118180504.1785-1-hkallweit1@gmail.com>
 <20231118180504.1785-9-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PkoxvMO1/HFYCTOF"
Content-Disposition: inline
In-Reply-To: <20231118180504.1785-9-hkallweit1@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PkoxvMO1/HFYCTOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 07:05:02PM +0100, Heiner Kallweit wrote:
> After removal of the legacy eeprom driver the only remaining I2C
> client device driver supporting I2C_CLASS_SPD is jc42. Because this
> driver also supports I2C_CLASS_HWMON, adapters don't have to
> declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
> It's one step towards getting rid of I2C_CLASS_SPD mid-term.
>=20
> Series was created supported by Coccinelle and its splitpatch.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

As I want to apply this cleanup early in the cycle, could we have an ack
for me to modify this subsystem, please?

>=20
> ---
>  drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c b/drivers/=
media/pci/netup_unidvb/netup_unidvb_i2c.c
> index bd38ce444..46676f2c8 100644
> --- a/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
> +++ b/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
> @@ -289,7 +289,7 @@ static const struct i2c_algorithm netup_i2c_algorithm=
 =3D {
>  static const struct i2c_adapter netup_i2c_adapter =3D {
>  	.owner		=3D THIS_MODULE,
>  	.name		=3D NETUP_UNIDVB_NAME,
> -	.class		=3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
> +	.class		=3D I2C_CLASS_HWMON,
>  	.algo		=3D &netup_i2c_algorithm,
>  };
> =20
>=20

--PkoxvMO1/HFYCTOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVfvFQACgkQFA3kzBSg
KbZYAA//fQjEmBOFvualDjpGrgw79fieIiVp81NMn0isd0Yeru7pNMMn40Ce26y/
zC1tWshvD26hOZ5k6siTw5Ia/+lYV62ft2RuInuh7duj2DV3gJ5nEZxvWsOnt1HG
h3OuPDJaA/ZDL/M61Gn2zC8bvHMSTLjEfPorI1NKuKLzwJTkjl2pzCkX1mnnZEXK
1qufBvlzHW5uFTNpV1ta5hG53nmYANKedqIswglmjI35Df0JZ5YdUblvNwnrWbx5
Ws2GjHvv8UPry9VNMxc1I0QOfu/Yw+rv3j0CrFt3DEPkNL6rx6llpwyETNaaLpTz
g8b6ZTy2YjXh1U1AlyyZqK662VhWRo+EOLok1Km9ZbLAfhMgfHthEKMICv2X4JPt
oc4SY2alrTXIEDtK4eLhYMb8t5bCw09cmrnPa5yEe/DHUjW5HKpPH4WVx2v+3Pbe
Cd9OgCEehueRRbo9r48JBGiHzUKmMPW4nzw1vKEgLsxyzyGhcS287oZf0+Ig8OVf
wJu2ghinagfxYZM7hUYMfdv/pB52eWkDv/vvzgkGcNP8kNCJJB5SsL1AS8enwbDf
7gLxVOhSiOJJeKT/8D1nTu7S1aaoFt2/eIbPfrNUwJhbhuQHe03bRI/0OaJuTmMD
uTXkumGEtW+uFpakfoMqezP850oL9Ogh4Tvh5Gi+CIzwOkreGCw=
=jKDE
-----END PGP SIGNATURE-----

--PkoxvMO1/HFYCTOF--
