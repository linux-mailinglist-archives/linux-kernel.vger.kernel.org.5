Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF407B0776
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjI0O7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjI0O7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:59:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52066F4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:59:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD49C433C8;
        Wed, 27 Sep 2023 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695826778;
        bh=J5WMHeQmOYa9DaNiL6kj1L9JZ8CZSajg8MxP1uoMKSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQmBq3PQj4PKvUzkHXkkFH9/JcpmiCxSZ2WWd1Rqwr/OIjrCqal+CfgHOkmWb/dEw
         z4+x6qdDG1mLyQF1GXNZslivHxCxIloJMsAzgePtAAQ8SoVJdqWbknQZMZEbb3v1l/
         MpGF3+38TNA9lMfj4wVNYQQGgW9CpoKVnB1yM9FGp+erUuI36ngPz0DaUb8+uaw7cm
         7dwzy7GrXYHz8q+qdee56LVDhvoAPsSEgmDWy6ruOMr/KQasD81JDXYCMqGed26LsW
         MP5UdZSko+ftXTax8zedAE2iRfR4+hQbZGEyw1CoAgRRWh/1MYXIsPmrizuO4uZDpg
         HI1KsWr0aDtwA==
Date:   Wed, 27 Sep 2023 15:59:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: net: snps,dwmac: DMA
 Arbitration scheme
Message-ID: <20230927-dense-scoundrel-22ede0e27973@spud>
References: <20230927122928.22033-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="00CqfJ64cfG+S8hl"
Content-Disposition: inline
In-Reply-To: <20230927122928.22033-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--00CqfJ64cfG+S8hl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 02:29:27PM +0200, Christian Marangi wrote:
> Document new binding snps,arbit to program the DMA to use Arbitration
> scheme. (Rx has priority over Tx)
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..4499f221c29b 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -442,6 +442,12 @@ properties:
>      description:
>        Use Address-Aligned Beats
> =20
> +  snps,arbit:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Program the DMA to use Arbitration scheme.
> +      (Rx has priority over Tx)

Can you explain please what makes this a property of the hardware, or
otherwise makes it suitable for inclusion in DT?

> +
>    snps,fixed-burst:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> --=20
> 2.40.1
>=20

--00CqfJ64cfG+S8hl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRDVAAKCRB4tDGHoIJi
0vXYAQD67f4By+s5MP5vlHvV6WZ1uTkpsDKRXlhwiGwhPFF9aAD8CRBHJ1ufdl98
4zTcZIm8hVr0NdUOXt28M5x1qXtgmgg=
=JEy+
-----END PGP SIGNATURE-----

--00CqfJ64cfG+S8hl--
