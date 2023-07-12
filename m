Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9A751080
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjGLS1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjGLS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF91FE3;
        Wed, 12 Jul 2023 11:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D4D618CD;
        Wed, 12 Jul 2023 18:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7C0C433C7;
        Wed, 12 Jul 2023 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689186416;
        bh=Q7hIJjg1COAF/FMM7M3FxLlMT24gT6lBvHIoG1GKhJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2OO0NQ0az6y2fxQoi+xkXsK5eWKHyB0cfC0t79Gkr1u0XTOD3Qg+mRiEgii/CAJp
         od5LYXHZNnYgevU4Wre5AfUkJioAgYcqtvqoqxWB52CSoGaScpLwbfVkGXxL9TgwSP
         QHhFJ2jTNriV5zAw/Djxoosa1D79mF0y30oK7eRrW4RGQ9vDq6v+qKFNpDYIROuHTu
         +aH5/vlay8Q9mrkp8ftptoOfv4Rivr3ClgR08WdeAXj9WCYjoUV1fuoDmmR1EY/9IU
         3OglgSMetPXl9ng5FjB0FSJuIsrE0bcyiiH4UPX2v38/r46HQsgQZ6UrKlYVTPdY/m
         bGj1QwFpXwFZA==
Date:   Wed, 12 Jul 2023 19:26:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw binding doc
Message-ID: <20230712-step-dimple-31746cd3a640@spud>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-2-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MVVWJK8Ul290dK88"
Content-Disposition: inline
In-Reply-To: <20230712121219.2654234-2-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MVVWJK8Ul290dK88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jul 12, 2023 at 05:42:13PM +0530, Pankaj Gupta wrote:
> The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
> secure enclave within the SoC boundary to enable features like
> - HSM
> - SHE
> - V2X
>=20
> Communicates via message unit with linux kernel. This driver
> is enables communication ensuring well defined message sequence
> protocol between Application Core and enclave's firmware.
>=20
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications can communicate on single MU.
>=20
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,se-fw.yaml     | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,s=
e-fw.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.ya=
ml b/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> new file mode 100644
> index 000000000000..7567da0b4c21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,se-fw.yaml#

I think on v3 you were asked to use a filename that matches the
compatibles?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX EdgeLock Enclave Firmware (ELEFW)
> +
> +maintainers:
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>

> +  value, i.e., supported SoC(s) are imx8ulp, imx93.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx-ele

This looks like a generic compatible, not a specific one, but you use it
on the imx8ulp. I would have expected that you would have something like
"fsl,imx8ulp-ele" for that.

> +      - fsl,imx93-ele


> +
> +  mboxes:
> +    description:
> +      A list of phandles of TX MU channels followed by a list of phandle=
s of
> +      RX MU channels. The number of expected tx and rx channels is 1 TX,=
 and
> +      1 RX channels. All MU channels must be within the same MU instance.
> +      Cross instances are not allowed. The MU instance to be used is S4M=
UAP
> +      for imx8ulp & imx93. Users need to ensure that used MU instance do=
es not
> +      conflict with other execution environments.
> +    items:
> +      - description: TX0 MU channel
> +      - description: RX0 MU channel
> +
> +  mbox-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  fsl,mu-did:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Owner of message-unit, is identified via Domain ID or did.

On v3 you had constraints:
	enum: [0, 1, 2, 3, 4, 5, 6, 7]
Do constraints no longer apply? If they do, you can use minimum &
maximum to specify them.

> +  fsl,mu-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Identifier to the message-unit among the multiple message-unit tha=
t exists on SoC.
> +      It is used to create the channels, default to 2

Are there constraints here? If so, same applies.
You should use "default:" for defaults, rather than describing them in
freeform text.

Thanks,
Conor.

--MVVWJK8Ul290dK88
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7waAAKCRB4tDGHoIJi
0hFZAP9rTx13tffIjqCTITFWtmu6nm0KredohfkX/h4BpEkC9wEA354/9tSp0y3x
Ed3lRny+J9oPVoUqCp3JeHTYp+SvYgQ=
=IDyi
-----END PGP SIGNATURE-----

--MVVWJK8Ul290dK88--
