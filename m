Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2C76EEAD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbjHCPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjHCPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9442690;
        Thu,  3 Aug 2023 08:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95E9161E16;
        Thu,  3 Aug 2023 15:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C9C433C8;
        Thu,  3 Aug 2023 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691077935;
        bh=shdLTUl/hzYbRD8G510/eXZG57dpgv2R1y08l4NSUis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqQsbbvug9fDxopaztR1czHBNQ3OAniPfAUled1HxzUfts/5zXHHqEPkwrphh1f1S
         1F0TBFJnSDipaN8aXHBM8mq6NZMlrmdsRVM5UvvpLqja6mX2TVt4yU5WG0f6SDUc7O
         i8JLcjlj2YB09/zdeDIow4JnHJIX9Cp/CTPiW9Br809/3iFMwIAF074AUlO29evUUQ
         hC8RDESoFZYtlOqY7DwcUt57hPZnHLJCw7uGlWdurdWHNQgmL2Pgf75SN6B2I/a0V7
         CyGSwlhYKJxU3Kf4nQMfjtx4jt69tXjpI+GSO5QJSRxCVKiO2jS+gMUVfrgPA8Hb2A
         UKcPFj8ez6TRw==
Date:   Thu, 3 Aug 2023 16:52:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <20230803-balance-octopus-3d36f784f776@spud>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YjjCSeNwyEiwRtye"
Content-Disposition: inline
In-Reply-To: <20230802201824.3683-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YjjCSeNwyEiwRtye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 03:18:22PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> Provide access to the register regions and interrupt for Universal
> MAC(UMAC). The driver under the hpe,gxp-umac binding will provide an
> interface for sending and receiving networking data from both of the
> UMACs on the system.
>=20
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> ---
>=20
> v2:
>  *Move mac-addresses into ports
>  *Remove | where not needed
> ---
>  .../devicetree/bindings/net/hpe,gxp-umac.yaml | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml b/Do=
cumentation/devicetree/bindings/net/hpe,gxp-umac.yaml
> new file mode 100644
> index 000000000000..ff1a3a201dcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/hpe,gxp-umac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Unified MAC Controller
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +description:
> +  HPE GXP 802.3 10/100/1000T Ethernet Unifed MAC controller.
> +  Device node of the controller has following properties.
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-umac
> +

> +  use-ncsi:
> +    type: boolean
> +    description:
> +      Indicates if the device should use NCSI (Network Controlled
> +      Sideband Interface).

How is one supposed to know if the device should use NCSI? If the
property is present does that mean that the mac hardware supports
it? Or is it determined by what board this mac is on?
Or is this software configuration?

Thanks,
Conor.

--YjjCSeNwyEiwRtye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvNKQAKCRB4tDGHoIJi
0vEOAP9KpKkL8uHbXhp1szAIL+d8eDVx+Zy0uYlk5Nh7tT45gQD+NASu+mEXy4Hv
WnInK04BprIpkAZdykvcmILghGdm8wA=
=Bm8/
-----END PGP SIGNATURE-----

--YjjCSeNwyEiwRtye--
