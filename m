Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B690F76F831
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjHDDEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHDDEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3C4236;
        Thu,  3 Aug 2023 20:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E160261F1C;
        Fri,  4 Aug 2023 03:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABD1C433C9;
        Fri,  4 Aug 2023 03:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691118259;
        bh=E5AW+8FOiatGFHegkfNTd5xukRWfVLb/sZxc4H0rl7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVIIzXBdhWzsRhwMhioiliS0MBfh9cwBNNhxxYv/BsDbMQGrbORvwnGZoQkJkuUC6
         jQE5d2Tn8sweTkUmjFWAlty/QZZo7Pc/bUOZNFXszINiZ347GyHomYCqX8FnF0oYaU
         2YdwABPGTSovU8P5l1uKTi3dWWGbeCTWRXnJPUxxenu/6H6hV49uGd7qhoSvAKymvu
         7zDSTm1LMiTfxagQ1vZEpY1xLoliDZ3G7777HXYEEUMH/DeB6qDRqa/Y4jz+o6Tf3u
         VZs8huE0A/pcX+CpaFGG9QMQZcn4OvFXYmsiVQ8o936T3ZFGA3saPjEnrvtAlo9Vqs
         cJZLDiVGHThkA==
Received: by mercury (Postfix, from userid 1000)
        id 085591061B64; Fri,  4 Aug 2023 05:04:15 +0200 (CEST)
Date:   Fri, 4 Aug 2023 05:04:15 +0200
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
        devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: display: add rotation property to
 sitronix,st7789v
Message-ID: <20230804030415.yrvbq3kc6r2lj3jc@mercury.elektranox.org>
References: <20230718-feature-st7789v-v2-0-207cb1baea0f@wolfvision.net>
 <20230718-feature-st7789v-v2-3-207cb1baea0f@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrx2f36fuc4chij4"
Content-Disposition: inline
In-Reply-To: <20230718-feature-st7789v-v2-3-207cb1baea0f@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jrx2f36fuc4chij4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 03, 2023 at 10:13:50PM +0200, Michael Riesch wrote:
> The sitronix-st7789v driver now considers the rotation property.
> Add the property to the documentation.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml | =
2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7=
789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789=
v.yaml
> index fa6556363cca..694d7f771d0c 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.ya=
ml
> @@ -22,6 +22,7 @@ properties:
>    power-supply: true
>    backlight: true
>    port: true
> +  rotation: true
> =20
>    spi-cpha: true
>    spi-cpol: true
> @@ -52,6 +53,7 @@ examples:
>              reset-gpios =3D <&pio 6 11 GPIO_ACTIVE_LOW>;
>              backlight =3D <&pwm_bl>;
>              power-supply =3D <&power>;
> +            rotation =3D <180>;
>              spi-max-frequency =3D <100000>;
>              spi-cpol;
>              spi-cpha;
>=20
> --=20
> 2.37.2
>=20

--jrx2f36fuc4chij4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTMaq4ACgkQ2O7X88g7
+prVHBAAnranxr8+661icCSUonDadVce0QrTh8fLIimhGKFW3nLjk29h77sHwGHO
JuZwJzIOj6uvfLDRFgavN6NT/R+IW1W+cJ4UfgwaXBTvByIK7RtXDq8FtcHJvdxn
0ub3F2PIEu1FXsme6r7kCcDD6vpef7VRCtHcmscv+FghdN8xT+Qj5lDIdNTQ4a/v
z+HKkmxBTf425t7yZDr6drLqf9q6jdSJDib94svyvzANnHX1CzobRFSRChMpODrR
RT52i4WV6hoPTTdHL/l710QG0okd+kiA7PgiKXCEXeDi90nHlriHNFci4XowT+8h
gDoHXYmc5Mj/+bJdL+2SqO/bNeXLOuVlN0IW1I8M3b0tks4HgduPLalYHhyXxL4p
ATKJbCsdO7cLrll4llAaF/1UVDhzdKZnSeTpbMAgm4ix6LZYO3Habgv1AsZZ9/EM
C07imC5o9bxyIfo7KhiP/aOEywZhLYFBiCvCRIWm1x+IeJsiat4Xp9ONjlZVoQQc
X5zf1vYmB5UPFq0F09gjMoFZxk0vC8LTBBrSxJq+FuhPwWtg4HQ4sfydvnC2XTgG
9/ava273kLsmnOwE+vTmapZOmrRhDIYxfRA8w8/akBqVWlRtBsanleKlBxS6hDbb
PBT3R9iuh9BeX1tpXJUIyz/J5d+aEipYg7nsRx0349vOn+/oD5Y=
=qDfw
-----END PGP SIGNATURE-----

--jrx2f36fuc4chij4--
