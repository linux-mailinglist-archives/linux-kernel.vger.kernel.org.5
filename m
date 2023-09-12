Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00179D770
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbjILRWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjILRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:22:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184810D9;
        Tue, 12 Sep 2023 10:22:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5492C433C8;
        Tue, 12 Sep 2023 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694539326;
        bh=rRrJDnsPwd8jMYw4Teztqav9PlNugqhsqBqwAuwaVlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iii5UWu1mdHxD2eSbuXqs6kx4AHgW0/LoRft/f7lyOXJm52Rgi8Ss5jvrOQ7BrJTL
         HGjHS80pVjavTF4tfpykYr5T/7fkgKiE9YpmlWEPyBR3aNc+/hYiE191mnmhexl3o1
         CRosDNzzFYjKhuhcjmbbUjN7j01k4T3tOUv4i5jUygNoHPfOGH8XZQUtk5OaNdJ9eW
         pYLBfVy1Flo6/FS3VYYYvSj35AGFS9ADHfByzFRZStVVmWm0ObNv49tZznX+1faQlU
         TpLaRb6QGs2E99A0+EPgis0PHVuXqBCvx2SRZ1SqYeDb/y2Uldr0StaNvnp99RkhVo
         nBx3TcaF+l1Gw==
Date:   Tue, 12 Sep 2023 18:21:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 08/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add support for QMC HDLC
Message-ID: <20230912-capable-stash-c7a3e33078ac@spud>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912101018.225246-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bf5FPf5K5KaccQV9"
Content-Disposition: inline
In-Reply-To: <20230912101018.225246-1-herve.codina@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bf5FPf5K5KaccQV9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 12:10:18PM +0200, Herve Codina wrote:
> The QMC (QUICC mutichannel controller) is a controller present in some
> PowerQUICC SoC such as MPC885.
> The QMC HDLC uses the QMC controller to transfer HDLC data.
>=20
> Additionally, a framer can be connected to the QMC HDLC.
> If present, this framer is the interface between the TDM bus used by the
> QMC HDLC and the E1/T1 line.
> The QMC HDLC can use this framer to get information about the E1/T1 line
> and configure the E1/T1 line.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-sc=
c-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-=
qmc.yaml
> index 82d9beb48e00..b5073531f3f1 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.y=
aml
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.y=
aml
> @@ -101,6 +101,16 @@ patternProperties:
>            Channel assigned Rx time-slots within the Rx time-slots routed=
 by the
>            TSA to this cell.
> =20
> +      compatible:
> +        const: fsl,qmc-hdlc
> +
> +      fsl,framer:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          phandle to the framer node. The framer is in charge of an E1/T=
1 line
> +          interface connected to the TDM bus. It can be used to get the =
E1/T1 line
> +          status such as link up/down.

Sounds like this fsl,framer property should depend on the compatible
being present, no?

Thanks,
Conor.

> +
>      required:
>        - reg
>        - fsl,tx-ts-mask
> @@ -159,5 +169,8 @@ examples:
>              fsl,operational-mode =3D "hdlc";
>              fsl,tx-ts-mask =3D <0x00000000 0x0000ff00>;
>              fsl,rx-ts-mask =3D <0x00000000 0x0000ff00>;
> +
> +            compatible =3D "fsl,qmc-hdlc";
> +            fsl,framer =3D <&framer>;
>          };
>      };
> --=20
> 2.41.0
>=20

--bf5FPf5K5KaccQV9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCeNgAKCRB4tDGHoIJi
0iOYAQDpq19XBQVxAut3ryCZTWFRliPi5kerZHMkKGzgUwIbKwEA+gnc9IR2Iao6
Qt/bYjPuz9mjrBe0gcXcC3CDZicWwAE=
=QoY/
-----END PGP SIGNATURE-----

--bf5FPf5K5KaccQV9--
