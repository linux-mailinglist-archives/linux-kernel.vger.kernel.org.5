Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD177EE2AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjKPOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjKPOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:22:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F34C4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:22:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF52C433C7;
        Thu, 16 Nov 2023 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700144564;
        bh=IS1DuP8+1kUE365TQJj5hRQ+HcxauE+Dzik9ZXeEijs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tT7pAGH6H3r4emjRDPthCSKY7xssdmajLP+5/xeX438B0cVaprE19Rd+hqlsFDTnA
         lbDytFbjZI0hjk0zl/Tqc/XBmgFoBsYxUZh3aGT5EQ2k49cOD6Y/VY23Zmw/R78wy1
         adQYt0kMhCre5T9OBOZA5Tr4UduG3PTISDvLVwKT8XrHiMfoRfLVEpDOaqWDnvMLJN
         D65c7S2NrUo6z6liQrbz4MPWSgE0lBuDxOn/VXFGyiPZ+zfDMcbuLlLjr3Df1InDIa
         obQHutb1sRJQ36sT7hqMyhRDbxVqcW9hXm5bQAop8cVjHu66hztlz9TVItoS+IT62Y
         +ch0tVomSEpIg==
Date:   Thu, 16 Nov 2023 14:22:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: net: ethernet-controller: add
 10g-qxgmii mode
Message-ID: <20231116-flier-washed-eb1a45481323@squawk>
References: <20231116112437.10578-1-quic_luoj@quicinc.com>
 <20231116112437.10578-3-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eeTAmJq3hbXLEdrA"
Content-Disposition: inline
In-Reply-To: <20231116112437.10578-3-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eeTAmJq3hbXLEdrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:24:33PM +0800, Luo Jie wrote:
> Add the new interface mode 10g-qxgmii, which is similar to
> usxgmii but extend to 4 channels to support maximum of 4
> ports with the link speed 10M/100M/1G/2.5G.
>=20

> This patch is separated from Vladimir Oltean's previous patch
> <net: phy: introduce core support for phy-mode =3D "10g-qxgmii">.

This belongs in the changelog under the --- line.

>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Are you missing a from: line in this patch?

> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.ya=
ml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index d14d123ad7a0..0ef6103c5fd8 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -104,6 +104,7 @@ properties:
>        - usxgmii
>        - 10gbase-r
>        - 25gbase-r
> +      - 10g-qxgmii
> =20
>    phy-mode:
>      $ref: "#/properties/phy-connection-type"
> --=20
> 2.42.0
>=20

--eeTAmJq3hbXLEdrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVYlrgAKCRB4tDGHoIJi
0stsAQC/xl95sWf1KDMyE1ytf/jBbf6R1duIc9zoYY4ivS9IhAD9FebNFMkbQsMM
CW1kP66V0irHHz6eUXF+HF8sOB2uLAE=
=JVOw
-----END PGP SIGNATURE-----

--eeTAmJq3hbXLEdrA--
