Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBBB7B07DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjI0PNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjI0PNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:13:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D665F9;
        Wed, 27 Sep 2023 08:13:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E879C433C7;
        Wed, 27 Sep 2023 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827614;
        bh=M59HXSnofJHl+d0SzaDEQ+iFiL1u7mpzFZkkV512/mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRf964xRaUPDySff6eLJgM9Lx2KtcqOwEvT3EgL4trCBHw0lapy0dFi1XIenuyfi+
         6Tvm4uao7BYtDJ4T2HmMhpAEg4vmvzW3gkDRuzH4DxFxrGZKT306CiwuiAwskU5lL9
         mzT01FVQyLty2Hp9nZff35g0YWa7YY60ZtT9X0hCNw4qbg5MYHvXVvRss5ZXvHnz+O
         DzP9h4dPOyFsWg7/0HZSDRaWaNDIkwYdG1STMhDAihjEAcFOX7HLBZsyM0EcJO0ad4
         SQzQp1wtQZH1odv/cu/uIr2mMnNGPg/GRzHanZ9PKF1FvhUIc7Lu0VfrCHy0tNRsP2
         UUOtHQkgIW7yQ==
Date:   Wed, 27 Sep 2023 16:13:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power/supply: sbs-manager: Add missing
 unevaluatedProperties on child node schemas
Message-ID: <20230927-swimming-gender-3579e2771ffa@spud>
References: <20230926164446.101327-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vLhAzWIRrewJs9du"
Content-Disposition: inline
In-Reply-To: <20230926164446.101327-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vLhAzWIRrewJs9du
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 11:44:42AM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
>=20
> Add unevaluatedProperties as needed, and then add any missing properties
> flagged by the addition.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/power/supply/sbs,sbs-manager.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manag=
er.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.ya=
ml
> index f255f3858d08..2e21846463ba 100644
> --- a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
> @@ -47,6 +47,12 @@ patternProperties:
>    "^i2c@[1-4]$":
>      type: object
>      $ref: /schemas/i2c/i2c-controller.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 1
> +        maximum: 4
> =20
>  examples:
>    - |
> --=20
> 2.40.1
>=20

--vLhAzWIRrewJs9du
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRGmgAKCRB4tDGHoIJi
0gypAP0dN5ITkZ+G3bk0n/yF3+Z1vTnBZrJIUo0Jps5Tg7OMigD/adydJeyXH7Cf
C7uGu5/5p/xMHpKf7cDEplM8NlAJuQI=
=e37f
-----END PGP SIGNATURE-----

--vLhAzWIRrewJs9du--
