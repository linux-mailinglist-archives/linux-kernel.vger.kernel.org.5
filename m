Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14137701EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjHDNgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjHDNfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D635AA;
        Fri,  4 Aug 2023 06:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E8BE62012;
        Fri,  4 Aug 2023 13:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B48C433C9;
        Fri,  4 Aug 2023 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691156115;
        bh=55GKLfQUDd7jd/htYCG3E6Mbp9SgTzcWlvaJcSZqRy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYv5dwwduUmp20l4s/RiGDtReNDfaU0i2nKybfHSOEShyjHIZO5UiwcWGoo5NBaiw
         PnBKGVfC8lZYoXBZP8twEI+49N0QPMrEQp7lRfu9yvFuVqmbmACU2HpLuz3+wXL3ZZ
         BbB4G0Ewf0xTPeHTJIilW9g9L9iFhEZXtBa7MYKp+i7oMGtyJSnh5qhDcfch2lvhCy
         z7dUXnMFIJYzxUGeYMm12pA3Pn/qxu+N3xJ2+AOWTK4I4kJD72JoVKASRi/pCmJLgd
         7yZ20Ep3ZXZv7GQy7KxwlUAC/GpMFX6wCQ+7CJXsTtfjgv/2NDSXLq1s60R4iNugbI
         2nrtSSP2AQmHQ==
Date:   Fri, 4 Aug 2023 15:35:12 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/4] drm/panel: sitronix-st7789v: add support for
 partial mode
Message-ID: <s3fybvufmrmu4mkksbmbxec25nfkwxp5ts5hfk7pgult2aaoyc@724uq3ei3ch7>
References: <20230718-feature-lcd-panel-v2-0-2485ca07b49d@wolfvision.net>
 <20230718-feature-lcd-panel-v2-3-2485ca07b49d@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="narolssei6psadaw"
Content-Disposition: inline
In-Reply-To: <20230718-feature-lcd-panel-v2-3-2485ca07b49d@wolfvision.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--narolssei6psadaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 03:02:34PM +0200, Michael Riesch wrote:
> The ST7789V controller features support for the partial mode. Here,
> the area to be displayed can be restricted in one direction (by default,
> in vertical direction). This is useful for panels that are partially
> occluded by design. Add support for the partial mode.
>=20
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 43 ++++++++++++++++++++=
++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu=
/drm/panel/panel-sitronix-st7789v.c
> index 0ded72ed2fcd..ebc9a3bd6db3 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -118,6 +118,9 @@ struct st7789_panel_info {
>  	u32 bus_format;
>  	u32 bus_flags;
>  	bool invert_mode;
> +	bool partial_mode;
> +	u16 partial_start;
> +	u16 partial_end;
>  };
> =20
>  struct st7789v {
> @@ -345,9 +348,14 @@ static enum drm_panel_orientation st7789v_get_orient=
ation(struct drm_panel *p)
>  static int st7789v_prepare(struct drm_panel *panel)
>  {
>  	struct st7789v *ctx =3D panel_to_st7789v(panel);
> -	u8 pixel_fmt, polarity;
> +	u8 mode, pixel_fmt, polarity;
>  	int ret;
> =20
> +	if (!ctx->info->partial_mode)
> +		mode =3D ST7789V_RGBCTRL_WO;
> +	else
> +		mode =3D 0;
> +
>  	switch (ctx->info->bus_format) {
>  	case MEDIA_BUS_FMT_RGB666_1X18:
>  		pixel_fmt =3D MIPI_DCS_PIXEL_FMT_18BIT;
> @@ -487,6 +495,37 @@ static int st7789v_prepare(struct drm_panel *panel)
>  						MIPI_DCS_EXIT_INVERT_MODE));
>  	}
> =20
> +	if (ctx->info->partial_mode) {
> +		u8 area_data[4] =3D {
> +			(ctx->info->partial_start >> 8) & 0xff,
> +			(ctx->info->partial_start >> 0) & 0xff,
> +			((ctx->info->partial_end - 1) >> 8) & 0xff,
> +			((ctx->info->partial_end - 1) >> 0) & 0xff,
> +		};
> +
> +		/* Caution: if userspace ever pushes a mode different from the
> +		 * expected one (i.e., the one advertised by get_modes), we'll
> +		 * add margins.
> +		 */

The comment format is incorrect. Since Neil applied the patches already,
please send a patch to fix it.

Looks good to me otherwise, thanks for sticking up with this :)

Maxime

--narolssei6psadaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMz+iwAKCRDj7w1vZxhR
xXakAPkBwCoM6Xdg4Yxk/nzhw+E46uELeruCkDx9+pXmw0lYbQEAmyRaw6DpdZQR
ymcJ0NxItol7pxU8jgaXkHxCk3J6HAU=
=Lie8
-----END PGP SIGNATURE-----

--narolssei6psadaw--
