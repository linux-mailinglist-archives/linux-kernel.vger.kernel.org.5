Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F6789DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjH0MT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 08:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjH0MTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 08:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05910D;
        Sun, 27 Aug 2023 05:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB8561234;
        Sun, 27 Aug 2023 12:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2446CC433C8;
        Sun, 27 Aug 2023 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693138772;
        bh=U6oncp/62KbVKV/+0RJgkny9X6hK/dhm6Fjvyy8daa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SiX9ewwVM8stjlc3yHy6qyMofFxpTWcdQLHShhUMpus91DfcAarz4CuOLVMjXG791
         yF5+KueOpjXT3bPoggDkrw6EJqOl8sA1TOkeGl9naLY9AT2t7AeYACawEbX7a0HqE7
         fKek9IyfRW+imHnLonYYde7pP/xcpDwn4EYo4prxYE+fxqTG97wh9V9BweT4gqBXBy
         tWxJDMzRBX+B4Q4KezVdEkDndAnBxOSSqhRp+KGu5xMkoKSH2Qml3cy2qetH2B6UQQ
         +LhnX9C0h75V4xCYBzd5NRIZh4PBqSSa61OPaN/PpCyiJoMMgPz4ETcr6O6+K6bKKQ
         7XTq9Gxl22i9w==
Date:   Sun, 27 Aug 2023 13:19:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] ASoC: dt-bindings: fsl_easrc: Add support for
 imx8mp-easrc
Message-ID: <20230827-cackle-unseated-089a2d61ad4b@spud>
References: <20230827023155.467807-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pLdAo1ePdGPvAelT"
Content-Disposition: inline
In-Reply-To: <20230827023155.467807-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pLdAo1ePdGPvAelT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 09:31:53PM -0500, Adam Ford wrote:
> The i.MX8MP appears to have the same easrc support as the Nano, so
> add imx8mp as an option with a fallback to imx8mn.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Fixed errors:
>      ['fsl,imx8mn-easrc'] is too short
>       'fsl,imx8mn-easrc' is not one of ['fsl,imx8mp-easrc']
>        =20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Doc=
umentation/devicetree/bindings/sound/fsl,easrc.yaml
> index bdde68a1059c..a680d7aff237 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> @@ -14,7 +14,13 @@ properties:
>      pattern: "^easrc@.*"
> =20
>    compatible:
> -    const: fsl,imx8mn-easrc
> +    oneOf:
> +      - enum:
> +          - fsl,imx8mn-easrc

This one should probably stay const, no?
Either way,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +      - items:
> +          - enum:
> +              - fsl,imx8mp-easrc
> +          - const: fsl,imx8mn-easrc
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.39.2
>=20

--pLdAo1ePdGPvAelT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOs/TgAKCRB4tDGHoIJi
0jH9AQCC7Npm9ae30q6QfswRgEaeaCzWpth2K8fmNPeg0llAZgD/SpwyM8EKqToW
1FU3s1ZufKnuqW2q/m7hE+yXGXitfgw=
=PtcV
-----END PGP SIGNATURE-----

--pLdAo1ePdGPvAelT--
