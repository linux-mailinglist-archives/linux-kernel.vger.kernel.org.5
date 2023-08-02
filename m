Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BCF76D2B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjHBPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjHBPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0C271C;
        Wed,  2 Aug 2023 08:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5574F61A21;
        Wed,  2 Aug 2023 15:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7717AC433C7;
        Wed,  2 Aug 2023 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991032;
        bh=Du2CsHLO5d/i/M3Fj9y48Wpcms60Y+u/5BYuFpeDFF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYe2agKaNMOnyten+KunIHylJv2ZuTqilpnscrAdPZ9vrOvXFHLmHhT2JqfYduiqf
         Wt+OQy9BlGPcBMsCrNByCBUZRkbDEMo2CsjmkwrWCPZAO5Dz3wWL4XQMBYNN05UD7R
         D/vzutXMQsrVRzSihDeHAXNgvHLg0pMp1TsNvpNX0Sqc4TSZjZWFHGdyq7Jg2pSrrt
         6jdKK3mGJRu4mgrjsbJxopIJINf0LWQIfpFuAMdSRIOMlMAIYlkSmTgyOQJ1wOjzey
         xBKzcTSDiBToxFJEoq1TdUbiUE+NEgsg50hnqdFsK8Ydn2HVe3Kz1AXeqEEnwxNTzn
         038J5Gb4vIEIg==
Date:   Wed, 2 Aug 2023 16:43:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: make
 interrupt optional
Message-ID: <20230802-halogen-bungee-63273b2c456c@spud>
References: <20230802150545.3742-1-jszhang@kernel.org>
 <20230802150545.3742-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ii9Kw+VaTpZXCc/w"
Content-Disposition: inline
In-Reply-To: <20230802150545.3742-2-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ii9Kw+VaTpZXCc/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 11:05:44PM +0800, Jisheng Zhang wrote:
> The driver fall back to poll style when there's no irq. "poll" still
> looks better than no support.

What is the user for this where the interrupt is not actually wired up
in the hardware?

>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 3862411c77b5..17c553123f96 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -117,7 +117,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.40.1
>=20

--ii9Kw+VaTpZXCc/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMp5swAKCRB4tDGHoIJi
0ogYAQCiLg+P4MB9aNaGmUsyEKaghSbzawKNscIeyuyuInaVxwD/dKpdhG4z3gtg
WhhEN6qZG8mV9U2lr78IXNg9wjjebAA=
=1yDc
-----END PGP SIGNATURE-----

--ii9Kw+VaTpZXCc/w--
