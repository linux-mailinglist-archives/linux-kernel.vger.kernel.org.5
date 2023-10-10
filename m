Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D27C005A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjJJP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjJJP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:26:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B66AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:26:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AF7C433C8;
        Tue, 10 Oct 2023 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696951560;
        bh=YodDTkaZ+bcycK00pqPePN0/QiKatfmhX9P+LMDLFh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciJ9Kh17CIbzsZylz9Dhiv6Ic/cVCJqmhTy+BBoVtfI8Cq2soIFi/cdmTU2nP5Ali
         vFevqR3JKFBHM3dPd7Yjp6Fgr78K7+ZW91WBFidPz16aEv6054jmYAfpnLUEXBqn6I
         biD0Ujni2GK+/Vt2ilLkU5DGIDbwREo3BpRuWCTdBG2YQLaRKepC907LBuUNUAAA/V
         1ni/Upg+byAdumPHsEEJMu7YgpWhFbHPkEFI72rBl5oMhGphoAKw4Xch9YrgBmUJ+d
         hsRwrpOO7T2Z5LOtnR2fn+cqWFPFeAU0BSDM/9BfhHweYHwoxXbypQYlqdzaw9Gniq
         /C+0yQquSzcKw==
Date:   Tue, 10 Oct 2023 16:25:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <20231010-unwired-trench-c7a467118879@spud>
References: <cover.1693482665.git.ante.knezic@helmholz.de>
 <df8490e3a39a6daa66c5a0dd266d9f4a388dfe7b.1693482665.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZK4vbLQNLyDEl6PG"
Content-Disposition: inline
In-Reply-To: <df8490e3a39a6daa66c5a0dd266d9f4a388dfe7b.1693482665.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZK4vbLQNLyDEl6PG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 03:18:54PM +0200, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=
 b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index e51be1ac0362..3df5d2e72dba 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -49,6 +49,12 @@ properties:
>        Set if the output SYNCLKO clock should be disabled. Do not mix with
>        microchip,synclko-125.
> =20
> +  microchip,rmii-clk-internal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set if the RMII reference clock should be provided internally.

> Applies only
> +      to KSZ88X3 devices.

This should be enforced by the schema, the example schema in the docs
should show you how to do this.

Thanks,
Conor.

> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.11.0
>=20
>=20

--ZK4vbLQNLyDEl6PG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSVtAgAKCRB4tDGHoIJi
0izpAP4vBdiuYP3WAEbZcqrN4YsfFf6tlXSryyiZH534hE8mvAD/V8bf4jyCgfGx
pDCsIx/r0oOw16zOeOu4EirMC52AUw8=
=hpzs
-----END PGP SIGNATURE-----

--ZK4vbLQNLyDEl6PG--
