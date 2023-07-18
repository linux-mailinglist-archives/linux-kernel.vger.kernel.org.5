Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E118C75782A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGRJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjGRJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:34:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C48E0;
        Tue, 18 Jul 2023 02:34:33 -0700 (PDT)
Received: from mercury (dyndsl-091-248-212-239.ewe-ip-backbone.de [91.248.212.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E103A660703C;
        Tue, 18 Jul 2023 10:34:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689672872;
        bh=pDdoHgD/R4j/O2UCXvRlSSP9z0NmI3OdmRQNP6aFg30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfHkRS1Fnn2sxv+9ZYTgwkAvWjw4/zzVsMiwQ/4Gdpil0vhSHhiMpF70TpvqNPRCx
         czb43+nlO876FJId7eHvLkuwNv6XEl/S6KOT68IL8Fcjnob0znAhqOdrmilUseyPyF
         paXOpv93DV1txJfP089cQv2Am6jjhnAVapnajoZwekrfj1bT5eewHDaFZdM48oGVCb
         MlzuY8rPaDY4UWxlhgVSFcwKUIHazMS5FFU/t5xQm3nWKJohWUUxGqAPjvowUioQnp
         R8MdzbuPa1jyx/Jq1SGdRLfQ79aIynMdmkAoX19cfJSVUhqrUNCXIZF4bSACbuGZZY
         /zsNQJjMMkXLg==
Received: by mercury (Postfix, from userid 1000)
        id EEF551060D95; Tue, 18 Jul 2023 11:34:28 +0200 (CEST)
Date:   Tue, 18 Jul 2023 11:34:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, david.wu@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: add default 'input'
 for clock_in_out
Message-ID: <20230718093428.ofld4ywhwbpmnw5w@mercury.elektranox.org>
References: <20230718090914.282293-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4uagyzg7ikm4k3p"
Content-Disposition: inline
In-Reply-To: <20230718090914.282293-1-eugen.hristev@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4uagyzg7ikm4k3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 18, 2023 at 12:09:14PM +0300, Eugen Hristev wrote:
> 'clock_in_out' property is optional, and it can be one of two enums.
> The binding does not specify what is the behavior when the property is
> missing altogether.
> Hence, add a default value that the driver can use.
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/=
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 176ea5f90251..bb943c96c196 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -80,6 +80,7 @@ properties:
>        "output" means GMAC provides the reference clock.
>      $ref: /schemas/types.yaml#/definitions/string
>      enum: [input, output]
> +    default: input
> =20
>    rockchip,grf:
>      description: The phandle of the syscon node for the general register=
 file.
> --=20
> 2.34.1
>=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--p4uagyzg7ikm4k3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS2XKEACgkQ2O7X88g7
+prE4xAAmh5G/otIOOGE3B28pMwGVdmjdOwa1BRNEfNCHvSeWkh12GQ+Eswe5kqG
BSB2DE/QqMNTqcrBTOlarZ0BWEMGKnWlpm2W0cBzDHro9ASDyikGy5MyNFtb6Pa2
kc8L9JGhZB8NN/GD+qWLTnkg0HB056GGBcZF4pediWVSjJERDM8WXEVkEMjxARa2
PRMpAknIO5kZpHzsekietpLOW4RpfuYCiVVmnCQpURUNK0FH3+la4hLWjvzuiEcM
rUyTJ9MZwx73KEuKDrCPhRfS8bk6gC+QwSbtjTiIn/ZsUOWbcz0ovkzSpEg3ytrM
pwLOCNM127Pvhitp9hV3lqad1yn5cioVfM4lmHjBNKxGxBPdQdiFBVWlczWT//p0
Mg90MJtmkWMqF5OzLQ5UZhRS9Vf9rFROwnrGo6Pl++zAzIesUe62+oSvv2hMo/XG
0UKo1Xwnl8edOORpjuSMtHbyJXIcpQ+hXRF+C21gZT268wWmxC6mBJi5r6Iunp/I
uxqYNAxd3Jtd4Kq3D8omE6f0fewzQL+t4cegcKqEdngl9c+a8FwzkEOHa2RDRReB
1t6XWKsHbgRbrWjt+PmatvnN8Ei/V4gFszQSIWYMhalviQCwqcqBqDKOi33kpFfh
OZFltVUI6Fj1SZCMsAGBaozAXQ+FZF73haMosgXiWPUwQmr52EM=
=9u/K
-----END PGP SIGNATURE-----

--p4uagyzg7ikm4k3p--
