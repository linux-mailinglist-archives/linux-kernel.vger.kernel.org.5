Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9DC7F0676
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjKSNhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:37:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6214ED8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:37:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C3CC433C7;
        Sun, 19 Nov 2023 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700401055;
        bh=2fexIX8Wllal1qs9XQNtQXc+WrSDQ3whn+AUI85d1mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dojdJKck+Y9O7k5rdfKnG08U6mBKW0yzAyatUWilOu1QJjyvkXsuWEupI2hp8nn1d
         ILSIVbXXXSDURd9yDkvbJ0jpPPfPjIOdO1Z/b4D4TtOxXlmNJMyqpp1CBECnyE9DNk
         bP2vP8DWGH1UBmdR/uwJ+sIXZ5w/2r5Z4SkHKpot8tiGD4ENOiKvcPU97OXJJEt7MC
         F9yNEqTW239br5FnQaCc9w5P3fLB9MD8UGRG/QzDoZL2vJv/5hztp0EToBADUcUEF3
         PUrkZOBbVHyniVmoYuNqJorvnpFZWKS83ynooRCViqs62zkJ/21SAjzik9nHy7BtEc
         2s7NkQPGEHiNA==
Date:   Sun, 19 Nov 2023 13:37:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, git@amd.com,
        michal.simek@xilinx.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        appana.durga.rao@xilinx.com, naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v5 1/3] dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc'
 optional property
Message-ID: <20231119-dotted-feast-eb01cbebde42@spud>
References: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
 <1700213336-652-2-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8WwOMIKNYsPT2CWN"
Content-Disposition: inline
In-Reply-To: <1700213336-652-2-git-send-email-srinivas.goud@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8WwOMIKNYsPT2CWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 02:58:54PM +0530, Srinivas Goud wrote:
> ECC feature added to CAN TX_OL, TX_TL and RX FIFOs of
> Xilinx AXI CAN Controller.
> Part of this feature configuration and counter registers added in

"ECC is an IP configuration option where counter registers are added..."
The sentence is hard to parse for the important bit of information - the
justification for this being a property rather than based on compatible
or autodetectable based on some IP version etc.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> IP for 1bit/2bit ECC errors.
>=20
> 'xlnx,has-ecc' is optional property and added to Xilinx AXI CAN Controller
> node if ECC block enabled in the HW
>=20
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
> Changes in v5:
> Update property description
>=20
> Changes in v4:
> Fix binding check warning
> Update property description
>=20
> Changes in v3:
> Update commit description
> =20
> Changes in v2:
> None
>=20
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/=
Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> index 64d57c3..8d4e5af 100644
> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> @@ -49,6 +49,10 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  xlnx,has-ecc:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: CAN TX_OL, TX_TL and RX FIFOs have ECC support(AXI CAN)
> +
>  required:
>    - compatible
>    - reg
> @@ -137,6 +141,7 @@ examples:
>          interrupts =3D <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
>          tx-fifo-depth =3D <0x40>;
>          rx-fifo-depth =3D <0x40>;
> +        xlnx,has-ecc;
>      };
> =20
>    - |
> --=20
> 2.1.1
>=20

--8WwOMIKNYsPT2CWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVoPmAAKCRB4tDGHoIJi
0gIVAQCmItBnILexQiAoXNdAAsHy5rgfRr4rjnM34BOJAlWaNQEA92zmPiiA1wxS
KxWwYSuiX1hAlANo8CLa5w7qWaHayQY=
=jE3W
-----END PGP SIGNATURE-----

--8WwOMIKNYsPT2CWN--
