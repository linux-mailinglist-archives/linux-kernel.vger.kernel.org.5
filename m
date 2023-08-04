Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD876F82A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjHDDDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjHDDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1983AB2;
        Thu,  3 Aug 2023 20:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5016D61F1F;
        Fri,  4 Aug 2023 03:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665A9C433C8;
        Fri,  4 Aug 2023 03:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691118218;
        bh=wQi4O6ly+eUlZYhtMPrhugkQ4uSMqOeQCD3jPU6NyI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5W5ROnX4tvsEsY+aLY3J9kKhdAy4nlASBQW2opGuywPDvpYa1Tum/xl1sDxMxeWp
         UU3ESIOOtzy01E9yfslqpRDaxWo1zTfKK6CHEV7kru6UqaPIMDvuYWmqtXOdmMYSix
         Gea+u1Mylw+0Toh+9alR3idZPH3A/M5Sc+7h5lRoztWq49fo4WMEsS/XD1v82d1R9H
         c6ZU3qp8yf9jgsMheYLSPSsV4WLlGj/mwheW20c0uVPTnjCi/a9LF342yo3ePeLrJr
         Cb6UR0fCZSIeIWQKuJVKPxXSZfkEuORRZz7/G4OsQxMCCCgbazBaILHH25xAkB9aIE
         OopCE7phmNmtw==
Received: by mercury (Postfix, from userid 1000)
        id 0E7351061B64; Fri,  4 Aug 2023 05:03:34 +0200 (CEST)
Date:   Fri, 4 Aug 2023 05:03:34 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/panel: sitronix-st7789v: fix indentation in
 drm_panel_funcs
Message-ID: <20230804030334.uhpvfgb7sxa2vhyo@mercury.elektranox.org>
References: <20230718-feature-st7789v-v2-0-207cb1baea0f@wolfvision.net>
 <20230718-feature-st7789v-v2-1-207cb1baea0f@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2f6b7q34iuajawm"
Content-Disposition: inline
In-Reply-To: <20230718-feature-st7789v-v2-1-207cb1baea0f@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d2f6b7q34iuajawm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 03, 2023 at 10:13:48PM +0200, Michael Riesch wrote:
> Fix indentation of the callbacks in struct drm_panel_funcs.
> No functional changes.
>=20
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu=
/drm/panel/panel-sitronix-st7789v.c
> index bbc4569cbcdc..c7cbfe6ca82c 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -346,11 +346,11 @@ static int st7789v_unprepare(struct drm_panel *pane=
l)
>  }
> =20
>  static const struct drm_panel_funcs st7789v_drm_funcs =3D {
> -	.disable	=3D st7789v_disable,
> -	.enable		=3D st7789v_enable,
> -	.get_modes	=3D st7789v_get_modes,
> -	.prepare	=3D st7789v_prepare,
> -	.unprepare	=3D st7789v_unprepare,
> +	.disable =3D st7789v_disable,
> +	.enable	=3D st7789v_enable,
> +	.get_modes =3D st7789v_get_modes,
> +	.prepare =3D st7789v_prepare,
> +	.unprepare =3D st7789v_unprepare,
>  };
> =20
>  static int st7789v_probe(struct spi_device *spi)
>=20
> --=20
> 2.37.2
>=20

--d2f6b7q34iuajawm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTMaoIACgkQ2O7X88g7
+prXgw/9GqjjI/+WSYF0peUSaXCJfmPJsVSfPdgQd5JDp7V9iGkBwU1qWuvKQRTP
fJncB4DhFF00yN8+hvJUwl1R85V9lisWQo4n9lGdv7BrJQARMYCxGYKSptnxJz/Z
pjMX+bY19DMfDndq0CRxCMolxHod0Srptunq34DuwYdrdh2kADbkbrE2rcj+3BKT
XOM3EdFaR4AtQcuPgMSx4USbAT0eQDiURaXVUo7tb1DrLyj3FYyzjcIeK75lq9uC
gPiLsoEoib/AkEMkoamgwcP/ehBU3BKlU1YSpxVGFMc35iEXKPczjPGAp7UkJmtM
08Xnype0lSsKYxpKXec/4rmkgRyXYVgLAMpboimLYe7DGm7LYZc+wVKogxOIj++C
MNxi6IB6Mp3txlOnSMAjsr343S/NZJyXvNbaE4RV6JeSnPRHcJa08FYxc0iH6RAk
n0omNPNFNsJhQepFzTaw8a9sHjJZ6obaVOY5F6Qw79H+8yLrL8sz6tv428QuaInj
ycDkoB1PZf96fkCrrODS6AoPgiN/ph+WTG2Fpu2Dh9Is37sp7BP1L05KcP16hYr7
z/igKszwRuJZrD7eeK8aeSFbuXy2YKwgJYA4B7NewArlzlD0hQgZHRDqW9gkNQRJ
bHNDITs2UQBtshIzBUuLczKvn/7et1zE2kpLOmb2HJCQfp1Yf8o=
=SZVh
-----END PGP SIGNATURE-----

--d2f6b7q34iuajawm--
