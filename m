Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40B07FD933
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjK2OXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjK2OXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:23:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1131DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:23:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4E8C433C8;
        Wed, 29 Nov 2023 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701267817;
        bh=uEINnHilNNToAZ1GUBzJz7tVwPdn3y3/jPZhz8a3h3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L80lP7/DmFjx490yhyox7mwpHFUwjNzTYtOjS2so9TvD4ri5AnHVF3lE0FbCWeVpX
         riTz70eyypHC9pvz2VTcNGuSaKjNgAqPV7b3nhobMqbe0tc860r0tI2NrIyRUgjnO9
         DRK5oFj7Dd+jtzQMWsgBgs43xVCPA9l0odYE6PX2f7Wb5hkQcIzM3S7kpImE/bopUX
         QojwpElox1iuTbWfjDCPqion/nebzRC1EJX3PkPK1Z9M0Pz7gAHMbHNfiqvMB8vPHx
         8e6Lflr9nevBFjB3KuP7Pd9w+VzqAjCBvfOIaRJTMliS3wJpDx5136pJRNTHh7CUxF
         W2+7eVJkjqL8w==
Date:   Wed, 29 Nov 2023 14:23:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: i2c: document st,stm32mp25-i2c
 compatible
Message-ID: <20231129-haste-emperor-3a8ba335b267@spud>
References: <20231129125920.1702497-1-alain.volmat@foss.st.com>
 <20231129125920.1702497-4-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zQpTz0PrtyWzX5co"
Content-Disposition: inline
In-Reply-To: <20231129125920.1702497-4-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zQpTz0PrtyWzX5co
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 01:59:12PM +0100, Alain Volmat wrote:
> Add a new compatible st,stm32mp25-i2c for the STM32MP25 series which
> has only one interrupt line for both events and errors and differs in
> term of handling of FastModePlus.
>=20
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  .../devicetree/bindings/i2c/st,stm32-i2c.yaml | 49 +++++++++++++++----
>  1 file changed, 39 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml b/Do=
cumentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
> index 94b75d9f66cd..6a69bb6de23e 100644
> --- a/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
> @@ -19,6 +19,7 @@ allOf:
>                - st,stm32f7-i2c
>                - st,stm32mp13-i2c
>                - st,stm32mp15-i2c
> +              - st,stm32mp25-i2c
>      then:
>        properties:
>          i2c-scl-rising-time-ns:
> @@ -41,6 +42,43 @@ allOf:
>          clock-frequency:
>            enum: [100000, 400000]
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32f4-i2c
> +              - st,stm32f7-i2c
> +              - st,stm32mp13-i2c
> +              - st,stm32mp15-i2c
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: interrupt ID for I2C event
> +            - description: interrupt ID for I2C error
> +
> +        interrupt-names:
> +          items:
> +            - const: event
> +            - const: error
> +

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp25-i2c
> +    then:

Should this not just be "else:"?

> +      properties:
> +        interrupts:
> +          items:
> +            - description: common interrupt for events and errors
> +
> +        interrupt-names:
> +          items:
> +            - const: event
> +

Cheers,
Conor.

--zQpTz0PrtyWzX5co
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdJYAAKCRB4tDGHoIJi
0g/dAQD+vb0YxP+0kOTPgO9Ix2HQBWIP8nOO1XqZgVw+O7daxQD9HemclzlDL37e
tMu44zbX0HySlWbw3cPX0YDONRIM3Q8=
=2fR5
-----END PGP SIGNATURE-----

--zQpTz0PrtyWzX5co--
