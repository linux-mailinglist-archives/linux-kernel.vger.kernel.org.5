Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4207B2393
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjI1RRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjI1RRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:17:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9CCCD2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:17:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6DCC433C8;
        Thu, 28 Sep 2023 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695921449;
        bh=kp48/6NY2s2Fwy7SPTbkm1Qxejl2zfg3J9xsj/VLKl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frwM8cmwFgXPPt6PQw33IXpDzfdefGVZdi/irC1N2cQJEBvz17+e9WaCpC6UKZCKq
         S+yHTjowoARHIOm0Gaizj5BqYC/eUFb994s7vYCM/NvFo3hFiyR1flVnlv3AWtZAp2
         sdyfP3XMlm+nSwtbyXHiqArvrmdFERQpF2CJeVxwt4RCzIFVTj9Cmza/unomjPzsDo
         t7fwMaJW8dhoh9YZCQjN3GstiXyrkWfTsSd23eSkvxEHnJnNkt7j6lmMt1iKvcM4/B
         KHUIfbPYBM2nxM1X62LiBWFOOTl9ZiEGW6KR7opg7xwwndszH8Yl2SIyg7NdAabq74
         ahJxwYu5Iomew==
Date:   Thu, 28 Sep 2023 18:17:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Christophe Roullier <christophe.roullier@foss.st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/12] dt-bindings: net: add new property
 st,ext-phyclk in documentation for stm32
Message-ID: <20230928-ruse-parsnip-ce691bd4d0c9@spud>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
 <20230928151512.322016-3-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GZ6Z6SVMMl7xgZNo"
Content-Disposition: inline
In-Reply-To: <20230928151512.322016-3-christophe.roullier@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GZ6Z6SVMMl7xgZNo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 05:15:02PM +0200, Christophe Roullier wrote:
> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
> This property can be used with RMII phy without cristal 50Mhz and when we
> want to select RCC clock instead of ETH_REF_CLK
> Can be used also with RGMII phy with no cristal and we select RCC clock
> instead of ETH_CLK125
> This new property replace st,eth-clk-sel and st,eth-ref-clk-sel

I don't really see a response to Rob's comment on v2, either here or in
a reply to his email on v2:
| Certainly 1 property is better than 2 for me, but carrying 3 is not
| great. I don't understand why the we need a new property. What can't be
| supported with the existing properties?

A sentence saying explaining exactly what the old properties do not
support that this one does, would be very helpful.

Thanks,
Conor.

>=20
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Doc=
umentation/devicetree/bindings/net/stm32-dwmac.yaml
> index ca976281bfc22..67840cab02d2d 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -78,12 +78,21 @@ properties:
>        encompases the glue register, the offset of the control register a=
nd
>        the mask to set bitfield in control register
> =20
> +  st,ext-phyclk:
> +    description:
> +      set this property in RMII mode when you have PHY without crystal 5=
0MHz and want to
> +      select RCC clock instead of ETH_REF_CLK. or in RGMII mode when you=
 want to select
> +      RCC clock instead of ETH_CLK125.
> +    type: boolean
> +
>    st,eth-clk-sel:
> +    deprecated: true
>      description:
>        set this property in RGMII PHY when you want to select RCC clock i=
nstead of ETH_CLK125.
>      type: boolean
> =20
>    st,eth-ref-clk-sel:
> +    deprecated: true
>      description:
>        set this property in RMII mode when you have PHY without crystal 5=
0MHz and want to
>        select RCC clock instead of ETH_REF_CLK.
> --=20
> 2.25.1
>=20

--GZ6Z6SVMMl7xgZNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRW1IwAKCRB4tDGHoIJi
0rNRAP9awNrP3aiGsCbGuiS8lMmRYwhVF+LyYev2PPrjoiD9mwD/XczIb1gqXTpN
dTxeIbKTupCl7S7dTc2C+xJDpScgrA8=
=YoXR
-----END PGP SIGNATURE-----

--GZ6Z6SVMMl7xgZNo--
