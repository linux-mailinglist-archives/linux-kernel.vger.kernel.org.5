Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED63C7A28AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbjIOUvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbjIOUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:50:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46D12717;
        Fri, 15 Sep 2023 13:49:48 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E3396600B9D;
        Fri, 15 Sep 2023 21:49:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694810987;
        bh=5yDD6r4eMhkhuYuXu4jsxfcUrM6Jrl03ASax41rfrgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVZBWrzKSyibLtpkRJpDWVpUYbWqPMjvWqxWooT8oQvOgq9/SreqOO0P0PXVLZK40
         yqUQDCPzreR8XTsYnoZZpBT920OTsCAUp5BRIrmOoCvLfX9joPrbET7VzucPNWuw/n
         0UJWSh0zWlQD+F9XOGs4FcHCvSdjuoJLeQ/DOy292zT1RRHHqnvqim1a4xraOgVuRp
         IGh65OUqfdkV2XgqnWrLmUqFCoTmnneMWI8bNLJeec0AjUFsFdexV0Q6DpZnN1t/vY
         q/PLN7re3C7EgEM2VzbHE8HFbRbyhu4jzsopSA03IBCWgzeCcb91ZTv67jPe024rM2
         QWBZ9gSgEtxSw==
Received: by mercury (Postfix, from userid 1000)
        id B246B106044B; Fri, 15 Sep 2023 22:49:44 +0200 (CEST)
Date:   Fri, 15 Sep 2023 22:49:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 43/50] power: reset: at91-poweroff: lookup for proper
 pmc dt node for sam9x7
Message-ID: <20230915204944.qspvkvyoclceh2jc@mercury.elektranox.org>
References: <20230728103015.267490-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qwnemobyeccumlju"
Content-Disposition: inline
In-Reply-To: <20230728103015.267490-1-varshini.rajendran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qwnemobyeccumlju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 28, 2023 at 04:00:15PM +0530, Varshini Rajendran wrote:
> Use sam9x7 pmc's compatible to lookup for in the SHDWC driver.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/at91-sama5d2_shdwc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/res=
et/at91-sama5d2_shdwc.c
> index d8ecffe72f16..d0f29b99f25e 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -326,6 +326,7 @@ static const struct of_device_id at91_pmc_ids[] =3D {
>  	{ .compatible =3D "atmel,sama5d2-pmc" },
>  	{ .compatible =3D "microchip,sam9x60-pmc" },
>  	{ .compatible =3D "microchip,sama7g5-pmc" },
> +	{ .compatible =3D "microchip,sam9x7-pmc" },
>  	{ /* Sentinel. */ }
>  };
> =20
> --=20
> 2.25.1
>=20

--qwnemobyeccumlju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUEw2gACgkQ2O7X88g7
+pqrgQ//V8cxMe3i2V3jKHuGWjCgDOULN4UbreBRDHEMmJlPbsbOQBqWo+M1gkUl
Fwx/Ih0zI5I7d6S8cYqkTggHe73Rt/BmLifd4VnWpBfReRM/RnS8eCwnM3s/ike7
eLKagXpczInh+craVFdgZi7mv9zZZtTRJ0THacrU8YS1ct8tCu5soy9k0yA9+EO/
B7apRer3hqW6UeVf5rOCQd92PayY+lnfs6px/RPbFUXaI74+bH7i9kU+i9LhaKBo
l8Io2h2kBsdaBE1L1SemSp+xGGoVISfofeiekJ7MVkyAXZiuQz4zlfoIU0lkItAv
YTClfWoSsJjlaAqQ95TIc99zLsE58lG9Hva33F8HD3SF/PVn4dmZS3jsBGUjdj3O
AOa8oTxdR//HDoX6MJljxr1vg+nYiQfVWSPkvxSjrkd2+hsmOLd2omtB3REJStRe
Hciod0s2PUXwcw4DN92lhR99t3+VrT/XaY501YahrBoFKcXwaFhl+IhjrD46/oBW
282ffRX4Nzqk2ZtMeavE/IVj3wkij9nOK+ISliiHGiBVxxWAm4kOCOaru4s6XOwn
4RTHXat2v21N6qdxYluUZZfBL3WvPRtwlEh/urfW7hw9bxO73jRoVRE7CW0Pfxv3
Z/xIVLfhn1kqo1xjY56begAWPCjA0TTp9djM86oii6fnuUhqlLo=
=IMK1
-----END PGP SIGNATURE-----

--qwnemobyeccumlju--
