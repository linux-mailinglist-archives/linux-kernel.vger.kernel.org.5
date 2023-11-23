Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED37F653B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbjKWRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKWRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:20:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A55D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:20:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC74C433C8;
        Thu, 23 Nov 2023 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700760054;
        bh=HZ2it2SDpc8JXOsPY263SXF+iKCLC0kpnH0sDhz3fiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TauTI7yXz/EXK19sGpqXQIgeQSXWk/7tN1aZXr8i97YqI4fGEAFMoL4QD4jgJgLoO
         BDUnxt6Ty380NwBjw6btK2JI8oU/fWfEX1mIDN9xTa1IPdYpmJ0BEVFJfSZEb+Szsz
         sDhkyR8NQ+YMweQNFJrrr+0qSqt6YT5eU43vEWKLq/Dh10SFwUCLj4vuBn10U8gCAV
         lWPwy2WeOTnTOTGnz+33/XXlDlx7vLbna1/0ygieyz62GwgVJWnST9zalRgrdKMkXR
         RN0+I4MdzkOTOVf8sO+xANqjUk0MqpAGi98RRZrv5bWgbwRZwJh4dB2XXDjfaNOgIq
         KWjPCPfKAm2jw==
Date:   Thu, 23 Nov 2023 17:20:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH RFC WIP 1/2] dt-bindings: net: rockchip-dwmac: add
 rockchip,phy-wol property
Message-ID: <20231123-operable-frustrate-6c71ab0dafbf@spud>
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
 <20231123-dwmac-rk_phy_wol-v1-1-bf4e718081b9@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bTHzhB7hdNw7bvKU"
Content-Disposition: inline
In-Reply-To: <20231123-dwmac-rk_phy_wol-v1-1-bf4e718081b9@wolfvision.net>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bTHzhB7hdNw7bvKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 01:14:13PM +0100, Javier Carrasco wrote:
> This property defines if PHY WOL is preferred. If it is not defined, MAC
> WOL will be preferred instead.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/=
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 70bbc4220e2a..fc4b02a5a375 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -91,6 +91,12 @@ properties:
>        The phandle of the syscon node for the peripheral general register=
 file.
>      $ref: /schemas/types.yaml#/definitions/phandle
> =20
> +  rockchip,phy-wol:
> +    type: boolean
> +    description:
> +      If present, indicates that PHY WOL is preferred. MAC WOL is prefer=
red
> +      otherwise.

Although I suspect this isn't, it sounds like software policy. What
attribute of the hardware determines which is preferred?

--bTHzhB7hdNw7bvKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+J8AAKCRB4tDGHoIJi
0myVAQCJk+QzYHl+/O3ThabjS9+O5WSkS3WxXLaSPMYQlO5sSAEA4U1Db0x5jGIy
glMeVXSf9fk0MYLSsWmvHvpZkUexmwI=
=CSe+
-----END PGP SIGNATURE-----

--bTHzhB7hdNw7bvKU--
