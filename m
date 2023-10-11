Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74D67C58A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjJKP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJKP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:56:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B99D;
        Wed, 11 Oct 2023 08:55:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5EBC433C9;
        Wed, 11 Oct 2023 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697039758;
        bh=l9SFEh6GumGFUG+DXwfjem9vY8NkT0tXT2M7UKxvr+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixz6+3ToD5gCvDW97nhaKCvGkg+zuAa66qnUIYhJxKe8kNBhHm2Kcov3Ggelcst9i
         gCuJyp9AUNk/QELshcUjFj0lTDxx2hxty9VRcvCceAtmIYNmsQaSYciVbweYPfD+QT
         PaAS5v9GBATPOL+MQPemncG7EnSSAETrqt1nMcyVyZho0hjP69D9eJHZcSPQLh0gLq
         Zcwghmsthja+tv1QeN0SZmKhbZ87cTA90Ijeuct3i+wfsAUXKNED9EUCKIKU5HBlwY
         DqbyU8yLOZk9J+mr71itTN70mVjLDa/ElG2Fn+OZAaLbYJefXMY+gAPTBnvyrilY3U
         vhMRPbSWgnBQQ==
Date:   Wed, 11 Oct 2023 16:55:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: media: Document STM32MP25 VDEC &
 VENC video codecs
Message-ID: <20231011-jogger-designing-0eb6e2daacba@spud>
References: <20231010091643.3666290-1-hugues.fruchet@foss.st.com>
 <20231010091643.3666290-2-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HQXQfP5KdaxdfgWJ"
Content-Disposition: inline
In-Reply-To: <20231010091643.3666290-2-hugues.fruchet@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HQXQfP5KdaxdfgWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Oct 10, 2023 at 11:16:39AM +0200, Hugues Fruchet wrote:
> Add STM32MP25 VDEC video decoder & VENC video encoder bindings.
>=20
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> ---
>  .../media/st,stm32mp25-video-codec.yaml       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-=
video-codec.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-video-c=
odec.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-video-code=
c.yaml
> new file mode 100644
> index 000000000000..479566171568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.ya=
ml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/st,stm32mp25-video-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32MP25 VDEC video decoder & VENC video enco=
der
> +
> +maintainers:
> +  - Hugues Fruchet <hugues.fruchet@foss.st.com>
> +
> +description:
> +  The STMicroelectronics STM32MP25 SOCs embeds a VDEC video hardware
> +  decoder peripheral based on Verisilicon VC8000NanoD IP (former Hantro =
G1)
> +  and a VENC video hardware encoder peripheral based on Verisilicon
> +  VC8000NanoE IP (former Hantro H1).
> +
> +properties:
> +  compatible:
> +    items:

This "items:" is not needed, the enum on its own is enough.

> +      - enum:
> +          - st,stm32mp25-vdec
> +          - st,stm32mp25-venc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    vdec: video-codec@580d0000 {

The node labels for both nodes here are not used & should be dropped.

Otherwise, this seems fine to me.

Cheers,
Conor.

> +        compatible =3D "st,stm32mp25-vdec";
> +        reg =3D <0x580d0000 0x3c8>;
> +        interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&ck_icn_p_vdec>;
> +    };
> +  - |
> +    venc: video-codec@580e0000 {
> +        compatible =3D "st,stm32mp25-venc";
> +        reg =3D <0x580e0000 0x800>;
> +        interrupts =3D <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&ck_icn_p_venc>;
> +    };
> --=20
> 2.25.1
>=20

--HQXQfP5KdaxdfgWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSbFhgAKCRB4tDGHoIJi
0t0uAQCP6ge+y1j9+kMRyc0k7z2mmqF+5BxIUEKWEn3WUxp1vgD+NYj7GsuoXHij
EdPldWL1H+xzD4wuI5OWRDd2WLQiMQY=
=H1kq
-----END PGP SIGNATURE-----

--HQXQfP5KdaxdfgWJ--
