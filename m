Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F375A0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGSViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:38:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0B81FD7;
        Wed, 19 Jul 2023 14:38:03 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1A4B660297B;
        Wed, 19 Jul 2023 22:38:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689802682;
        bh=EnEs82eF+dr1j4F/YP1kngG0fotAyDYVnHdP/EJWms0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyqzAd41kmVn2VbW1QE7z3FsqbVDaKRa6y3OQ25KLW4/abvSjIjeMGzRWVSTnfZop
         Zzd7ZjijIV1e+UtfO2UfuxWcvEwTh0tGnWt3oQ2Y+4ZPmLhlZsLZiNgNdAyEcUVevY
         dO4CdJORmwvqKaqSaFYBU3GLMrsgW/NMMJPErLH3cI75GUAbrOhfC9evBzY4dooiA9
         DMDzimrFuU9Le9uYefgZ2PEZvFKUcuvcb3xip0Gbcn15KFpW6InYt/tOtfn7o9s7Xt
         W3vVdiup2rYEJuRT2EFZULkrqwk3HCL0I7F091nEWtqSYH8L7GyuYg8z7+9Lbjr0hh
         8F+wKDoEs10pw==
Received: by mercury (Postfix, from userid 1000)
        id F14141061639; Wed, 19 Jul 2023 23:37:59 +0200 (CEST)
Date:   Wed, 19 Jul 2023 23:37:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] power: reset: at91-poweroff: Convert to
 devm_platform_ioremap_resource()
Message-ID: <20230719213759.y73xa2wjru7jjryl@mercury.elektranox.org>
References: <20230704130309.16444-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="as4yegxfbg2texhw"
Content-Disposition: inline
In-Reply-To: <20230704130309.16444-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--as4yegxfbg2texhw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 04, 2023 at 09:03:03PM +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Thanks, whole series queued.

-- Sebastian

>  drivers/power/reset/at91-poweroff.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index 9e74e131c675..dd5399785b69 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -151,13 +151,11 @@ static void at91_poweroff_dt_set_wakeup_mode(struct=
 platform_device *pdev)
> =20
>  static int __init at91_poweroff_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	struct device_node *np;
>  	u32 ddr_type;
>  	int ret;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	at91_shdwc.shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	at91_shdwc.shdwc_base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(at91_shdwc.shdwc_base))
>  		return PTR_ERR(at91_shdwc.shdwc_base);
> =20
> --=20
> 2.39.0
>=20

--as4yegxfbg2texhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4V7EACgkQ2O7X88g7
+ppt5w/+PPKuf20lGBmwO8uWzO/WVSzFUkLfDLf4W6BB48ISIv3BA6WKV505f6Z/
ISjTh97lvssI8vNxrntWD6U4EfV/+nuz7CCkl/WhGlQ8ktg7MeMmWMdEOLQFJov4
DYp3Bq2xuDmKTrobfjELeeBUyiIPO8n3YKzg0R8OT2dVQFknwnlSXnS3gbUkDsdJ
K0h8r5YAsl2afDjU+aN/e/6Wga8ZfuBiPUo52RftpJacTaoIfOjT5O6sOcm4WnjC
ZEyo/qNbfT1i2+IdkGqL57pYFYS9ocHjCdapbjkTWSbbeb64A8qQ+84+l7ObogYP
mqruS5VlLMwCVq1jjRh+ODTJygT/xdvL4/aYmMEJqbi3TDSUGMuHnAs7H3Qcshbm
OOKcnaTKyg/J1ej5nDf/XswFtmHoLcOqaXL7vQ3Gdwx1y2T2MCENzRqu/H7oowsa
ByBdRVBRL5Uo5CC+NLC2KHsAv7oDbZpEsD2l3TaM+j9jULxFIuxKvCrTThebU339
l/7Z9WD0msWt9TmkxD/L3JyLAT73G8D81x3PsODZDrSZvvfbEL4XdomBrgvaQVKk
G/uPxJRoEWOHIJsvMh7CoWmfm9E4lEl+9RlrvCw9+Zx28uOCGoXHEE8FcOMmOV5Y
sfMTvycOqZZTuCX78DIMbjZ64/K7ZXWRd7COp7KxwuV8FK0yUy0=
=y7wK
-----END PGP SIGNATURE-----

--as4yegxfbg2texhw--
