Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DED775FDAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjGXR23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGXR21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C44EE76;
        Mon, 24 Jul 2023 10:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEDF3612BB;
        Mon, 24 Jul 2023 17:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52345C433C8;
        Mon, 24 Jul 2023 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690219705;
        bh=twLkaxMgs6piq0ZeQkavdqOEjTHt1kteFtzNVLOvJ9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AI2qiCY24Q0v7zAFtd+xpAyXL5i/UaDHKwIzIK3qeZoo8R/2X9J1RlT9KdArYfCzi
         JTTq7RkzfWDF62FujThw6oJk+v54LH6rGVQCIKx9uPAapbra2cfBmjhs0jue/3hvbx
         bHO+IBkp5pWV5fH1o2Rw16kakYO59StayV0tdEdxqu2dobSjFuiN5LanDgtRlLfzG0
         uBKmBpYJ6cb7vKmSEIc+ezcSfGVUoUo8DtXiqKbNmexpCxv8VMxv1zbL1LRQhExPx7
         ZaSL6WyFUgubnjy6G5X9Eufaukl712lrNotSMybmN9Q5tgykeyuSqF6nyWrfBsNuSU
         /NXWOBotY6vtA==
Date:   Mon, 24 Jul 2023 18:28:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <20230724-slick-shush-5338b16a558c@spud>
References: <20230723161029.1345-1-jszhang@kernel.org>
 <20230723161029.1345-10-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yzmqMJ1ISurXR8jS"
Content-Disposition: inline
In-Reply-To: <20230723161029.1345-10-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzmqMJ1ISurXR8jS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Mon, Jul 24, 2023 at 12:10:28AM +0800, Jisheng Zhang wrote:
> The IP supports per channel interrupt, add support for this usage case.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Silly question perhaps, but the commit message and description for this
property imply that this is an optional feature that software may choose
to make use of, but will function without. Is that the case?

> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index bb80ca205d26..525210c2c06c 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -101,6 +101,11 @@ properties:
>      minItems: 1
>      maxItems: 2
> =20
> +  snps,per-channel-interrupt:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that Rx and Tx complete will generate a unique interrupt=
 for each channel
> +
>    interrupts:
>      minItems: 1
>      items:
> @@ -109,6 +114,8 @@ properties:
>        - description: The interrupt that occurs when Rx exits the LPI sta=
te
>        - description: The interrupt that occurs when Safety Feature Corre=
ctible Errors happen
>        - description: The interrupt that occurs when Safety Feature Uncor=
rectible Errors happen
> +      - description: All of the rx per-channel interrupts
> +      - description: All of the tx per-channel interrupts
> =20
>    interrupt-names:
>      minItems: 1
> @@ -118,6 +125,22 @@ properties:
>        - const: eth_lpi
>        - const: sfty_ce_irq
>        - const: sfty_ue_irq
> +      - const: rx0
> +      - const: rx1
> +      - const: rx2
> +      - const: rx3
> +      - const: rx4
> +      - const: rx5
> +      - const: rx6
> +      - const: rx7
> +      - const: tx0
> +      - const: tx1
> +      - const: tx2
> +      - const: tx3
> +      - const: tx4
> +      - const: tx5
> +      - const: tx6
> +      - const: tx7
> =20
>    clocks:
>      minItems: 1
> --=20
> 2.40.1
>=20

--yzmqMJ1ISurXR8jS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL60swAKCRB4tDGHoIJi
0kp0AP9cl/Kkn46dTmz0i/arZps5F7oU5toWGL4Tz+RgllbJmAD/UV4ChCqmubDi
srI+nEMnjcExH4WbPf9u5fMGWCZ75AM=
=cJ/j
-----END PGP SIGNATURE-----

--yzmqMJ1ISurXR8jS--
