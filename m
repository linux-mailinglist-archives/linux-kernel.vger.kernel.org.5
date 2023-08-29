Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE03978C82F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjH2PAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjH2PAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E18BC;
        Tue, 29 Aug 2023 08:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59AEA65BC6;
        Tue, 29 Aug 2023 15:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D445DC433C7;
        Tue, 29 Aug 2023 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693321211;
        bh=ceUTSllSKCAPQG+RRuLHM1ghYUnZrUeBrxRMcn6jQVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnJuG9hGO3t+yTmYVTEOiDWcrnoG5yz0vpGjMLpq1FojJ2LDvg4/YjKzaeGx2Pxry
         rWWdNhHGtYL7n/sd6zSawDGN48gL0Y61pAHLeG4s7/m547dFSi86k0TRkBeMNUkrw1
         iZS+f3GsXrCFalgAkqllwUu4+P9LsxmRjz6OT2nL+t1pnMUZbUA76Ubf1h4IubCsUe
         p4NAdGt1n7ip10vck2eA/j8fKSpyaoocWgTrblqHtAkPRZkJT/95mVOTPYnSOESWN+
         szDMOgx9wlMjQOpUKhWauy/qPxkTaEqjlDOG8Rq4T+x23cOGIKUUS4ZruosT4KrsSO
         v87qltN0F+0jA==
Date:   Tue, 29 Aug 2023 16:00:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: media: add bindings for dcmipp driver
Message-ID: <20230829-juror-decathlon-f7b252a330bf@spud>
References: <20230829132357.192535-1-alain.volmat@foss.st.com>
 <20230829132357.192535-2-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qG2kGaJAeSU28rCp"
Content-Disposition: inline
In-Reply-To: <20230829132357.192535-2-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qG2kGaJAeSU28rCp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Aug 29, 2023 at 03:23:45PM +0200, Alain Volmat wrote:
> Add the yaml binding for the DCMIPP driver.

Please drop all mentions of drivers, bindings are for hardware.

>=20
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  .../bindings/media/st,stm32-dcmipp.yaml       | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmi=
pp.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml=
 b/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> new file mode 100644
> index 000000000000..63f03a1c42b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/st,stm32-dcmipp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 DCMIPP Digital Camera Memory Interface P=
ixel Processor binding

s/binding// to appease the bot.

> +
> +maintainers:
> +  - Hugues Fruchet <hugues.fruchet@foss.st.com>
> +  - Alain Volmat <alain.volmat@foss.st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp13-dcmipp
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
> +  clock-names:
> +    items:
> +      - const: kclk

Can drop the items: here since you only have one. The name is also
pretty pointless when you only have one...

> +
> +  resets:
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description:
> +      DCMIPP supports a single port node with parallel bus.
> +
> +    properties:
> +      endpoint:
> +        $ref: video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          bus-type:
> +            enum: [5, 6]
> +            default: 5
> +
> +          bus-width:
> +            enum: [8, 10, 12, 14]
> +            default: 8
> +
> +          pclk-sample: true
> +          hsync-active: true
> +          vsync-active: true
> +
> +        required:
> +          - pclk-sample
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp13-clks.h>
> +    #include <dt-bindings/reset/stm32mp13-resets.h>
> +    dcmipp: dcmipp@5a000000 {

Neither of the labels here are used AFAICT, please remove them.

Thanks,
Conor.

> +        compatible =3D "st,stm32mp13-dcmipp";
> +        reg =3D <0x5a000000 0x400>;
> +        interrupts =3D <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +        resets =3D <&rcc DCMIPP_R>;
> +        clocks =3D <&rcc DCMIPP_K>;
> +        clock-names =3D "kclk";
> +
> +        port {
> +             dcmipp_0: endpoint {
> +                   remote-endpoint =3D <&mipid02_2>;
> +                   bus-width =3D <8>;
> +                   hsync-active =3D <0>;
> +                   vsync-active =3D <0>;
> +                   pclk-sample =3D <0>;
> +             };
> +        };
> +    };
> +
> +...
> --=20
> 2.25.1
>=20

--qG2kGaJAeSU28rCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO4H9gAKCRB4tDGHoIJi
0k1GAP9lydVZqmkBXhnoBL4BwByU5Brn+WCt7/lNlnhMjoZjLwEAz9Li2WbAIuFZ
FJmcvAGQQsR170zfmTSMHhYOcIbPVAw=
=rxYo
-----END PGP SIGNATURE-----

--qG2kGaJAeSU28rCp--
