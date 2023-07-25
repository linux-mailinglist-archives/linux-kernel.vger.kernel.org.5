Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77510761E22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGYQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGYQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:12:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507097;
        Tue, 25 Jul 2023 09:12:00 -0700 (PDT)
Received: from mercury (dyndsl-091-248-210-134.ewe-ip-backbone.de [91.248.210.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1380A660211C;
        Tue, 25 Jul 2023 17:11:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690301519;
        bh=4bbTYeg6o3GK3ctlOWBYSlX8MvZxKTA9HCFK8D/JeKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfvTdK/7TxD0CTfGp38Xkh3x9X1hNLdtvJUoqdhQ4vKig7Q7A+IZXwidtsKxWxriE
         5jkZH2Ib6CCChU3mXw/0P3BDKjDa9XlUdnTV1e31eE+o54S+1RNRMqI/JMgAVByS5s
         7FcUa4BjxOdMEzbmlZSVKn4mDyhTNqjijb1AMlQkJu/dbR7Y6hHR3hIGm+mOYGlmpY
         d8FEl281szwDT86G9ey7QorY/oVfz7ONV/NFoWtQ0pQSEp29LP19qUvZxoIrJ3WQWW
         WJYOsHSlRlSsgM+ALJEl6kNG38BCH8MxKQfth3Mbdah3hMhcdlGxr1lpkopWh4N2pu
         t9Q2qHS5DSyBQ==
Received: by mercury (Postfix, from userid 1000)
        id A830310609E8; Tue, 25 Jul 2023 18:11:56 +0200 (CEST)
Date:   Tue, 25 Jul 2023 18:11:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, david.wu@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay
 defaults in schema
Message-ID: <20230725161156.22uscijrot7gbnvj@mercury.elektranox.org>
References: <20230725155254.664361-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ofxuz3hwyjtmd4j4"
Content-Disposition: inline
In-Reply-To: <20230725155254.664361-1-eugen.hristev@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ofxuz3hwyjtmd4j4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 25, 2023 at 06:52:54PM +0300, Eugen Hristev wrote:
> The defaults are specified in the description instead of being specified
> in the schema.
> Fix it by adding the default value in the `default` field.
>=20
> Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-sc=
hema")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---

Maybe also fix the allowed range while at it? I.e.

minimum: 0x00
maximum: 0x7F

-- Sebastian

>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/=
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index bb943c96c196..6d08260ad828 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -92,12 +92,14 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
> =20
>    tx_delay:
> -    description: Delay value for TXD timing. Range value is 0~0x7F, 0x30=
 as default.
> +    description: Delay value for TXD timing. Range value is 0~0x7F.
>      $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x30
> =20
>    rx_delay:
> -    description: Delay value for RXD timing. Range value is 0~0x7F, 0x10=
 as default.
> +    description: Delay value for RXD timing. Range value is 0~0x7F.
>      $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x10
> =20
>    phy-supply:
>      description: PHY regulator
> --=20
> 2.34.1
>=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--ofxuz3hwyjtmd4j4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS/9D4ACgkQ2O7X88g7
+pqWAw//R7tq9H+hx6ddYWSomL1O1WHXSMG7plrm8NK9/POt61Z3yqFvP/yXBTDF
k1S9ivLyv7/A0rA5lu2CzCRxud21fiGTeRd2KpShauXWdvX0kJ9W/tpEInhOqhz4
7K4+ODw8kq+XcL54ZFeGp6fUeGbBrNRMhA2aORfec0QeFlPT1WKQdXnnRsm/PzXf
j7Hg1kk4MrINxtXUHqMqbTI9kduWnUSJIWkAX72lkQdzMjAcBBwhu/7S58VfKVhi
rsermYFcMTE3/R5VIxpMn+AW3691H3fc6GUEE1PTUkyRdK4BCDVVrm1zxuE9xF74
eKEowlL2LPRPVELnykN89ye3brTb0vovCVbcy5EXZj8viiKyclNM7EaX+jXsEJXl
8ohKS0TVDtRfnin+C7d2RM/qADwemGT8v6B0JFFIp+ofNyNv06e5tsHJ8l9GrEof
tVtL8ziPZp7kgTtKv9MiLbw4yzXxPvZfDrZI3y2VE4QGaRZ7JF6opNqtwsZaz19Z
0H4BPh0zCa4HWNrxWg525tOF8VvHS/k3kRvjH6EQwoCipVjdMm+BnmOhPs7PtcBR
Wuay9qKw7uepG9tRdZlMu4PORfpswZvng1nmtcU0rrprFzFL99T0NVqWzHdrP3q9
iTh6q2vKVetxxA4bME4nIDiyr2xTGKb+FDh49TgmQtDfOhJ8vsw=
=vZvT
-----END PGP SIGNATURE-----

--ofxuz3hwyjtmd4j4--
