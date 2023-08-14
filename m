Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB03577BDCE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHNQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjHNQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B0E61;
        Mon, 14 Aug 2023 09:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AE9A6425E;
        Mon, 14 Aug 2023 16:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6FFC433C7;
        Mon, 14 Aug 2023 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692029947;
        bh=1HXaR1YqLupXBHwp85bkyMqldMzywffwekLUEAu17lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQpOKl/8SHJMA4ovCGZI5y3v9Q2m5JuInPWTmDYCAFpKJo66441o5sowDMYYJV23v
         PurzGhRTt6wWzVnit+s4Q7vQ6Sm/flka8NxVydQo+Bxi1E0/WcKEmbKxuubgQpP1HF
         7pMboXgBFOPLezf+don9/x/Gt863YXBzOg79jbJzZXhXhd8btAf62gQBVDbJR4YojW
         xCBdXZIFJaeG1etr3MgbT4zHjxhv1EMeUVp5nhnOATFf7fTh/mpyaLEaGbnvMNbYmZ
         lYtGLoXh4N+taPt424ET5oKphQfFdG93LBakDyyDUBan3LsAZqhmGPQfr08iC/geQ2
         kMiJJodjH+M7Q==
Date:   Mon, 14 Aug 2023 17:19:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-mediatek@lists.infradead.org, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        sam.shih@mediatek.com, jieyy.yang@mediatek.com,
        frank-w@public-files.de, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.obbard@collabora.com,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek,tphy: allow simple
 nodename pattern
Message-ID: <20230814-isolating-faceless-72835873207e@spud>
References: <20230814093931.9298-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g/mf8JY5atzBFUNd"
Content-Disposition: inline
In-Reply-To: <20230814093931.9298-1-eugen.hristev@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g/mf8JY5atzBFUNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 12:39:30PM +0300, Eugen Hristev wrote:
> The pattern for the nodename only allows t-phy@... , however, for the case
> when the t-phy has no `reg` and only `ranges` (basically when the t-phy
> is just a parent node), dtc will throw this warning:
>=20
> Warning (unit_address_vs_reg): /t-phy@1a243000: node has a unit name, but=
 no reg or ranges property
>=20
> For a node like this:
>=20
> 	sata_phy: t-phy@1a243000 {
> 		ranges;
>=20
> 		sata_port: sata-phy@1a243000 {
> 			reg =3D <0 0x1a243000 0 0x0100>;
> 		};
> 	};
>=20
> it is normal that the parent node 't-phy' would be without any address, a=
s in:
>=20
> 	sata_phy: t-phy {
> 		ranges;
>=20
> 		sata_port: sata-phy@1a243000 {
> 			reg =3D <0 0x1a243000 0 0x0100>;
> 		};
> 	};
>=20
> because being just a holder it does not have its own reg.
>=20
> However the binding does not allow such a name for the t-phy, so with this
> patch, making the `@[0-9a-f]+` part optional, such node is possible.
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

This seems reasonable to me, perhaps the lads will scream.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> Changes in v2:
> - none
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/D=
ocumentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 230a17f24966..2bb91542e984 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -64,7 +64,7 @@ description: |
> =20
>  properties:
>    $nodename:
> -    pattern: "^t-phy@[0-9a-f]+$"
> +    pattern: "^t-phy(@[0-9a-f]+)?$"
> =20
>    compatible:
>      oneOf:
> --=20
> 2.34.1
>=20

--g/mf8JY5atzBFUNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNpT9QAKCRB4tDGHoIJi
0jU2AP9qah5UHtzzFaDMKPLx4YhxWLbBsHowrT9XMVj560Z2twD9FGmBUyZvKKW2
UNhseLnLrkSED1LMAEZNSFekdLZpGgk=
=dvtZ
-----END PGP SIGNATURE-----

--g/mf8JY5atzBFUNd--
