Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4DC7E032B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346467AbjKCMvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:51:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B934083;
        Fri,  3 Nov 2023 05:50:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635ADC433C8;
        Fri,  3 Nov 2023 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699015858;
        bh=tpVeCHb6HdnxG19HyK4tr17TCWu8QGpwvVyw91n0C3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dU+t/8GP5PWYnJ3mF/RPJxShcO4CJguARUQx6z/D274XFk1AH0mwXfXZaKyEgi5rC
         qrcOu3uAtFjIoLBqWjVAEmrm+Zw5ReArNCVPDwkgK6s/ZllN1EgVoWrYnUPVpzVGNO
         0f037jv0cGrJANLx3qRS06HCxXy7qaL6BrJVLSlILENz+zP/QLkxcfhn9BQjIu9mbZ
         HEPyYwCbWeDH+kHR5Hz6kQe7Zuu8IC83FNCeI+TRcMKaOzPe5Xoan/ol/Q5o5Hyd2G
         Wv5y5lPcovvDC6SXyfT2JFiEZI4IHsGKVpFKeNG+P1FXEMO1fe9KhTmHPx/ftZlmxt
         fGXqi4BNH13CQ==
Date:   Fri, 3 Nov 2023 12:50:53 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: spi: add stm32f7-spi compatible
Message-ID: <20231103-recognize-unwashed-b8f1a83fe851@spud>
References: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
 <20231102193722.3042245-4-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xFgagCuWH1g6GYrR"
Content-Disposition: inline
In-Reply-To: <20231102193722.3042245-4-ben.wolsieffer@hefring.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xFgagCuWH1g6GYrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 03:37:20PM -0400, Ben Wolsieffer wrote:
> The STM32F7 SPI peripheral is nearly identical to the STM32F4, with the
> only significant differences being support for a wider range of word
> sizes and the addition of 32-bit transmit and receive FIFOs.

A wider range of supported word sizes and some additional buffers,
implies that the F4 could be used as a fallback compatible. Does the
register map change incompatibly in the process of widening the FIFOs or
something like that?

Cheers,
Conor.

>=20
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---
>  Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Do=
cumentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index ae0f082bd377..5754d603f34f 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -23,6 +23,7 @@ properties:
>    compatible:
>      enum:
>        - st,stm32f4-spi
> +      - st,stm32f7-spi
>        - st,stm32h7-spi
> =20
>    reg:
> --=20
> 2.42.0
>=20

--xFgagCuWH1g6GYrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUTsrQAKCRB4tDGHoIJi
0hFgAQDn41RZMbwCjYlwJX5Iqbm4K/r3lki7VmpwDMCGGJwkkQD/Xgytkq5TEODG
DyLPUNhil6uYE+5x8ylXmqmrv8T72gU=
=liLb
-----END PGP SIGNATURE-----

--xFgagCuWH1g6GYrR--
