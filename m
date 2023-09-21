Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4177AA19E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjIUVEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjIUVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:03:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDF885D3A;
        Thu, 21 Sep 2023 10:37:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8547CC4E687;
        Thu, 21 Sep 2023 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695304054;
        bh=Oo9AjLmvT40iXA2aHlcvjH+u91I2XspBDwHA99rab5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/nzU1poVexwNkd1uy8NYKF7nqNzSxBZguu99fbkUbbpOGB0M5SIkbkOKFB0tLFHK
         4u4LRILb6bb/hPssO9FbQR6ITa+eINX7rERGA+6Cm+/Gj80MA+4Exh1CEGWqwfVHIw
         TF8e19PDWWeOZsXJPl4Be7LrH+8OQstaf+zWw17Icr8pueLiaA+2Ej3awqB6c7juJ6
         dOZmyoJP7YtQKWwVuQFnrxB4DFhB5Uk7lIMntm6OTJc+PVGtrJD0x4Bde1AVh2BU28
         UrlntiPzMnfdfLtkDt2FL5PD5hbJIDFLdSf7nrXjg4A7Vg349CbDEHDgKKnuWPNq93
         j0lnhWD/kOxbQ==
Date:   Thu, 21 Sep 2023 14:47:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: sc16is7xx: add vendor prefix to
 irda-mode-ports property
Message-ID: <20230921-epidermis-labrador-3e51bb0b2cb9@spud>
References: <20230920152015.1376838-1-hugo@hugovil.com>
 <20230920152015.1376838-4-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dITO17on8mP4IvAa"
Content-Disposition: inline
In-Reply-To: <20230920152015.1376838-4-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dITO17on8mP4IvAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 11:20:14AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> The NXP-specific "irda-mode-ports" property lacks a proper vendor
> prefix. Add "nxp," prefix to comply with DT best practises.

Looks like you've made changes to the driver in a way both will work,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../devicetree/bindings/serial/nxp,sc16is7xx.txt          | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b=
/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> index 1a7e4bff0456..d89815c5c562 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -21,8 +21,8 @@ Optional properties:
>    the second cell is used to specify the GPIO polarity:
>      0 =3D active high,
>      1 =3D active low.
> -- irda-mode-ports: An array that lists the indices of the port that
> -		   should operate in IrDA mode.
> +- nxp,irda-mode-ports: An array that lists the indices of the port that
> +		       should operate in IrDA mode.
>  - nxp,modem-control-line-ports: An array that lists the indices of the p=
ort that
>  				should have shared GPIO lines configured as
>  				modem control lines.
> @@ -80,8 +80,8 @@ Optional properties:
>    the second cell is used to specify the GPIO polarity:
>      0 =3D active high,
>      1 =3D active low.
> -- irda-mode-ports: An array that lists the indices of the port that
> -		   should operate in IrDA mode.
> +- nxp,irda-mode-ports: An array that lists the indices of the port that
> +		       should operate in IrDA mode.
>  - nxp,modem-control-line-ports: An array that lists the indices of the p=
ort that
>  				should have shared GPIO lines configured as
>  				modem control lines.
> --=20
> 2.30.2
>=20

--dITO17on8mP4IvAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQxJcgAKCRB4tDGHoIJi
0i60AQDkv6NAQfFJKu9ceTROjQsUq5KvzHpILZ/l5wPEFqql6wEA16WdTQeQYNUJ
S1/xZghGAvjC+nLpApgENKAvRXOFJg4=
=eS7q
-----END PGP SIGNATURE-----

--dITO17on8mP4IvAa--
