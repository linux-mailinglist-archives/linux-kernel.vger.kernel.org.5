Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C646D7A28F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbjIOVGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjIOUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:51:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B2730DE;
        Fri, 15 Sep 2023 13:50:32 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A7C56600B9D;
        Fri, 15 Sep 2023 21:50:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694811031;
        bh=tMa5KHMI9xyhHbWkapaVXRddMW+G7/fhHz/CbsZZBio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kh2wYcPCHxtajuqaVKLwqA2qOglTymKGRPLHHJnfaZUq35xr3RoRvxln+3fo+ijR6
         t86ziJUB/OU7KZZvg7kD40CLWNiWkBNNb0EUJKsiyFJ+jgWYtCtHxHvMggsVaGOX9O
         Yc9Zl9fDmbgePgxp2O2M03LydMQPqLYyMVemKwooFkmeMo/joHkJJAQ+504yoj/ufM
         JhqkQznY6XU22OO+nm8aiZ2TKnUsk+Fw6ci3/diXyMUgCu0KaJztWIxUmTDE/shJWS
         svc41FxO07izU/zCw8ugtVtZdE0WLND9l4kIltMuJQjHZcWK1tmdCSxGC9GBQsxMup
         4J6aVgaGWhvkg==
Received: by mercury (Postfix, from userid 1000)
        id 6CA0D106044B; Fri, 15 Sep 2023 22:50:29 +0200 (CEST)
Date:   Fri, 15 Sep 2023 22:50:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 45/50] power: reset: at91-reset: add sdhwc support for
 sam9x7 SoC
Message-ID: <20230915205029.mqtb2jew5xob65l2@mercury.elektranox.org>
References: <20230728103032.267597-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fcwhesnxamk2gg2p"
Content-Disposition: inline
In-Reply-To: <20230728103032.267597-1-varshini.rajendran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fcwhesnxamk2gg2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 28, 2023 at 04:00:32PM +0530, Varshini Rajendran wrote:
> Add shutdown controller support for SAM9X7 SoC.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 518b232bfd3d..8571b592f257 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -34,7 +34,7 @@ config POWER_RESET_AT91_RESET
>  config POWER_RESET_AT91_SAMA5D2_SHDWC
>  	tristate "Atmel AT91 SAMA5D2-Compatible shutdown controller driver"
>  	depends on ARCH_AT91
> -	default SOC_SAM9X60 || SOC_SAMA5
> +	default SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	help
>  	  This driver supports the alternate shutdown controller for some Atmel
>  	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
> --=20
> 2.25.1
>=20

--fcwhesnxamk2gg2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUEw5UACgkQ2O7X88g7
+pqJOw/+MLLYmGm7IgO4W+jIsY0MrFOqCu63PeTrmYhU9lcDC6ln5wmiQY2Sl340
wxEwLJfGxQZ2IJq3OWqvrAg1WUjMHa+TnxGCMGrIk7OzugP+vTeTlvDc7n1741z6
Tp012hb1Y4flgoR+R13c5EkFws8EjpNSZIVa1ldQJxuFljJddNCjyuMGSiRo4XYV
FnbJJDjW0tD7i39lDSI+nqv/+LDlT9USv7klbNHCfcD24uF8QX5Qj8lBcrryHqiX
+DGBdlvFHf56/I7O9Xioxy5lHcx+EM75pnriPb7fkCI81lsIZ2wYJdydB2j7j0vL
a96wIV5Dd8X6RXnBnOBLbww/qQAjyMn0ifIiQD7TYREpOVU6jV+URi6li4tlvDqj
OLwCzDOn4FO2Utj/3LEyNvDMc5dvuyxhWG7OyRCKadVDIXWLka6AVf0w71gz3zg1
XcoMcbM+0i4urNWzmksZDMBgVd7V9Yfb6SLth3iBH0lDYYuNR9thaUA7ReG3AWOL
pEaRPBcKJZ5WfEmz8jWzDHF4xeXWEoPKdwGWk6vnGFNX3lVoRl5AWFxvymWgt79h
Ac0DRW1igRwDV830dKVJY1kZ/kzCI2UfipeIOQbda/fVFax99At1ug8chJXEuLok
8wK9TFNcHD5W2brPvJd4O3OFvM8oL9cAwojTNGFaG2HWlTxFTrk=
=PShN
-----END PGP SIGNATURE-----

--fcwhesnxamk2gg2p--
