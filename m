Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0675FD79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGXRXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGXRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F46187;
        Mon, 24 Jul 2023 10:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D465612BB;
        Mon, 24 Jul 2023 17:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D8C433C8;
        Mon, 24 Jul 2023 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690219398;
        bh=OKnfsi7SbxV3y3/SPI75aMywZMXuayUur6Ej80BIsR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jydDktQIuXY6UVtiIoIHjnpRq93L2hxMOk8stRNn4hoZxqztsvMDa5PNnd+PM06fE
         sIajf5jQ7Wsq2JzJvTEt6CDWeEw9Q9xWKgeLsKCReuSnGi0ELT4tV+wdsIZBguivXL
         iT+NQ7voUzu19KcI47ZCNzhX4zBzCycOlQXTHnnwrBqbG8apiOug7kfMufB01V1uFM
         LDmPImBTyvB96kCPYxxrZHj0RUhXqkzkFLujmLa7z8/oUV3Nsch/xDjGoOp9i79HZu
         ccSMcNz0VOBkY6+BWqoMLe/TPdqr/PalMacLsL6B9KFpk2ipr98j0JCpmSMZaliGE8
         OMVPlRhX4OsoA==
Date:   Mon, 24 Jul 2023 18:23:13 +0100
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
Subject: Re: [PATCH net-next 07/10] dt-bindings: net: snps,dwmac: add safety
 irq support
Message-ID: <20230724-cleat-tricolor-e455afa60b14@spud>
References: <20230723161029.1345-1-jszhang@kernel.org>
 <20230723161029.1345-8-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqqukai8rpLna7CS"
Content-Disposition: inline
In-Reply-To: <20230723161029.1345-8-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqqukai8rpLna7CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 12:10:26AM +0800, Jisheng Zhang wrote:
> The snps dwmac IP support safety features, and those Safety Feature
> Correctible Error and Uncorrectible Error irqs may be separate irqs.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..bb80ca205d26 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -107,6 +107,8 @@ properties:
>        - description: Combined signal for various interrupt events
>        - description: The interrupt to manage the remote wake-up packet d=
etection
>        - description: The interrupt that occurs when Rx exits the LPI sta=
te
> +      - description: The interrupt that occurs when Safety Feature Corre=
ctible Errors happen
> +      - description: The interrupt that occurs when Safety Feature Uncor=
rectible Errors happen
> =20
>    interrupt-names:
>      minItems: 1
> @@ -114,6 +116,8 @@ properties:
>        - const: macirq
>        - enum: [eth_wake_irq, eth_lpi]
>        - const: eth_lpi
> +      - const: sfty_ce_irq
> +      - const: sfty_ue_irq

Putting _irq in an interrupt name seems rather redundant to me although,
clearly not the first time for it here.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--fqqukai8rpLna7CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL6zgQAKCRB4tDGHoIJi
0vkYAP9J8lPgD4xupXtsbQ1efG2n9/QVww6TtsOCmWLaKw64kQEAvrv88XWaAORI
GW9S99iXG7nk2yZwWIPw+pGskFn0zAU=
=3/uV
-----END PGP SIGNATURE-----

--fqqukai8rpLna7CS--
