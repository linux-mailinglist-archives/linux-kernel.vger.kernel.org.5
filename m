Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5427A28B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbjIOUxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbjIOUxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:53:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F13C3C;
        Fri, 15 Sep 2023 13:50:12 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F127A66072C1;
        Fri, 15 Sep 2023 21:50:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694811010;
        bh=6Cq6hsHz65kS4fD3JlUoqRaENKrLBjOqqyzKhbwFg5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3sMhjoUtawBOczS7RuIGZhWMzLOm6MQdcxVOn3HG31vMIIFwDBsTZ9pb6p/V5Nql
         10rWZlgo6iV0j1KjLMaoqwi+eYd7EZHk+8CnmHZtEgFWbZltoK1rDLaZ0L6s8Tg38v
         3fukfXgh+Avi2U8vlKf7Zx6ZkpVRRgDCktzGvUsgxDvUFtRxwkqzMb9C5eTC8UAJCx
         DbzNZ+OpCBRFePbWuaGibewokvjGFjNoZNNjeKJATx4XBdv1FvNOMdTw2wWh5SCS5h
         zRBcA3A2l22jBYHqwJc8Rhyqe8h+yxphvfHEKC05HIhI+1QzvLTUJXZzv0JvrxqMYt
         JpsqzH3FhWNLg==
Received: by mercury (Postfix, from userid 1000)
        id 4C21C106044B; Fri, 15 Sep 2023 22:50:07 +0200 (CEST)
Date:   Fri, 15 Sep 2023 22:50:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 44/50] power: reset: at91-reset: add reset support for
 sam9x7 SoC
Message-ID: <20230915205007.2r46ottu6vktkkr6@mercury.elektranox.org>
References: <20230728103023.267539-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="olvrigr3nrcgrydu"
Content-Disposition: inline
In-Reply-To: <20230728103023.267539-1-varshini.rajendran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--olvrigr3nrcgrydu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 28, 2023 at 04:00:23PM +0530, Varshini Rajendran wrote:
> Add power reset support for SAM9X7 SoC.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index fff07b2bd77b..518b232bfd3d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -26,7 +26,7 @@ config POWER_RESET_AT91_POWEROFF
>  config POWER_RESET_AT91_RESET
>  	tristate "Atmel AT91 reset driver"
>  	depends on ARCH_AT91
> -	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
> +	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	help
>  	  This driver supports restart for Atmel AT91SAM9 and SAMA5
>  	  SoCs
> --=20
> 2.25.1
>=20

--olvrigr3nrcgrydu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUEw34ACgkQ2O7X88g7
+pqpdg//dzJbxOQxU+ylvkKKdu9WalM13M7YiaS8Mb400gt6e3O5L+1iiD7Fce7W
L02yhMYQ0betbbCUeeoqN7TlMLEYFRaq7Lf/0tGERtVelRlkn/xdM0/+3VyI1gkW
5E8pjKW6d05nCE8u4OcgaLOIGUaXX4gDA8OCC9VwjfTC+sYMja//B2KFGiAjyEh8
fSFAVWXGnIDAP/ukLJUP6V2xasW3cjfhcSRAzzEST/Evfl5isb9uvhqbrQURd37l
3BcYeb8eXJ0jqj0yw2lIr9knVlMZDrz9ZVKYzHT7UsM+7F6DYg/hCoA2mz8Ijn3v
2x63dLVLCHnAiAtvJBAjKH9sSM5hvW7FvUqM6dhDxx3auani+8OAstcWMev7mWGC
XGblyYKNr7+lneASZQoaa3VhXCZb8B8D7W0jL++7eRbdgYCO3b3ySC95HxbTNjya
SDayE23GZ6dIaAn5a02Xr65zf619nvQmU3gLOiFPV59sV3zbbVDqfkJFPGsnhAFI
eM1sS8Ac+oGOk2iQLkQauf6YTrBwBVNMxrtz5NDuJGYIARXaX4Fo3sLtEixyynZ6
K9ry8PoXz0+69FcWeHpE77szwg+JJqs3BrMAxLVUt1QgWs59HWJhlC7ywVjekAKb
+Hhduu3edpFZUfrAxKHOy43FatQPbl6CRVr8pHVzafKAHVHno5Q=
=5SLE
-----END PGP SIGNATURE-----

--olvrigr3nrcgrydu--
