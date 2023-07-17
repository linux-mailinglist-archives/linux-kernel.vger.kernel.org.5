Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7B756C28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGQSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGQSbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:31:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0D99;
        Mon, 17 Jul 2023 11:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE62C611E6;
        Mon, 17 Jul 2023 18:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE2C433C8;
        Mon, 17 Jul 2023 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618698;
        bh=b7VM9RFc+h/oFjhTeBRHaiyt8yHybUrRocsHJcphS54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rn72TW03cSRsln9AXMHMWipd4EqEo6NwepcNesH3upaT3nmUArCGqrpOElyY1iuu+
         CZvXX9fSLSpMNOimNUkd4z6fYYSplkBuhfyb+uk8ZEv9CLKwIiHNOlybq5Gt+NyzAU
         H+05FJk95QpylT91faGNnKxZhM03w3zxJRkuvF9RXdvb31jdyOzUozgHjjxpCTWo6a
         KawJKQ6LJUlDwWZuzD616w0r8viaC3X7nYWMTc+Ix9ddZYH/pFIzsbbSA6h7XQVrKj
         Pi296i/AsFebNCNdpItPLpjRK1DvqT8fNIB9raHyem4ACyocu1P4YWoVJoARAMv19+
         RMLRZsPPok8DA==
Date:   Mon, 17 Jul 2023 19:31:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        jannadurai@marvell.com, cchavva@marvell.com
Subject: Re: [PATCH v4 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Message-ID: <20230717-dirtiness-pardon-a3fbc0925202@spud>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
 <20230717125146.16791-6-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fYdzJ3cGoqsmeGH1"
Content-Disposition: inline
In-Reply-To: <20230717125146.16791-6-pmalgujar@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fYdzJ3cGoqsmeGH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 05:51:45AM -0700, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
>=20
> Add support for SD6 controller on Marvell CN10K series SOCs. The
> existing sd4hc is not compatible with the SD6 changes.
>=20
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 52 ++++++++++++++++---
>  1 file changed, 45 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Docu=
mentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 6c40611405a08717520f4ce3a78a9cb8dd9aac69..51f44c00a50505684c7c7c49c=
59c1ebd8d85d5d0 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -4,19 +4,23 @@
>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
> =20
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> =20
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - amd,pensando-elba-sd4hc
> -          - microchip,mpfs-sd4hc
> -          - socionext,uniphier-sd4hc
> -      - const: cdns,sd4hc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amd,pensando-elba-sd4hc
> +              - microchip,mpfs-sd4hc
> +              - socionext,uniphier-sd4hc
> +          - const: cdns,sd4hc
> +
> +      - items:
> +          - const: marvell,cdns-sd6hc

This seems like a strange compatible. Why have you not gone for
something like:
compatible =3D "marvell,$socname-sd6hc", "cdns,sd6hc";
?

> =20
>    reg:
>      minItems: 1
> @@ -139,6 +143,40 @@ allOf:
>          reg:
>            maxItems: 1
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,cdns-sd6hc
> +
> +    then:
> +      properties:
> +        marvell,iocell-input-delay-ps:
> +          description: Delay in ps across the input IO cells

Are all of these things marvell specific, or would other (future) sd6hc
users need these properties too?

Thanks,
Conor.

> +
> +        marvell,iocell-output-delay-ps:
> +          description: Delay in ps across the output IO cells
> +
> +        marvell,delay-element-ps:
> +          description: Delay element in ps used for calculating phy timi=
ngs
> +
> +        marvell,read-dqs-cmd-delay-ps:
> +          description: Command delay used in HS200 tuning
> +
> +        marvell,tune-val-start-ps:
> +          description: Staring value of data delay used in HS200 tuning
> +
> +        marvell,tune-val-step-ps:
> +          description: Incremental value of data delay used in HS200 tun=
ing
> +
> +      required:
> +        - marvell,iocell-input-delay-ps
> +        - marvell,iocell-output-delay-ps
> +        - marvell,delay-element-ps
> +        - marvell,read-dqs-cmd-delay-ps
> +        - marvell,tune-val-start-ps
> +        - marvell,tune-val-step-ps
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.17.1
>=20

--fYdzJ3cGoqsmeGH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLWJBQAKCRB4tDGHoIJi
0mfaAQDTApvAlStJn77X/J3xS3TnixYN7HlFW7aSinffcJPbewD/W3IbUWlgUyon
NU+xfPE81NTFNwtq7yiaCuUTfSndmAY=
=WM19
-----END PGP SIGNATURE-----

--fYdzJ3cGoqsmeGH1--
