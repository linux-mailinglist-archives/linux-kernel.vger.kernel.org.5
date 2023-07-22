Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FFC75DBFC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGVLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVLrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:47:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCC3273E;
        Sat, 22 Jul 2023 04:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CDD8608C0;
        Sat, 22 Jul 2023 11:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196E5C433C7;
        Sat, 22 Jul 2023 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690026436;
        bh=qEBn6e+fYz7AhV051ZDXT5ospKb3k9meMO3A37lVuJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2RDHwQcwB/hLm5ypoZMeeWNVB4tQO9WizZ0URooeHAORKqFh15tFh0Or0jb2ZfkS
         cMp4BYRk0nDvV5F0mjuLFC5TffS3fxDPqBYx9O9aJiNZ2ejRMokZCdVJG9U73+DXUF
         ubg9ETXOapXptJTnpVsGsaRjuby9kuZJcI3fZk1wxTg0S7b3K20Znsj4io7IUQGljY
         pMiIBKZAIvQSqn9UIahDsxYgjXG310C8xvcw6yKASZ9qhB7hGapHbEaPGhsGo/uJ7p
         Hvpl3cWiaYgtNQJ4LCq2ACFH2HKqBcnpKL7Ht7z2kGapeb7dYqMw/QB9xpvwViuC2+
         RfGWIWgrH/w1w==
Date:   Sat, 22 Jul 2023 12:47:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Ungerer <gerg@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 2/9] dt-bindings: net: mediatek,net: add
 mt7988-eth binding
Message-ID: <20230722-blip-sleet-8c3a75b1c911@spud>
References: <cover.1689974536.git.daniel@makrotopia.org>
 <5a333fa431562efed461ec5a987d6982db2ed620.1689974536.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S3k3Sb20TyWQtpEz"
Content-Disposition: inline
In-Reply-To: <5a333fa431562efed461ec5a987d6982db2ed620.1689974536.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S3k3Sb20TyWQtpEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 10:32:10PM +0100, Daniel Golle wrote:
> Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
> The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
> 10 Gigabit/sec supported by 2 packet processor engines for
> offloading tasks.
> The first MAC is hard-wired to a built-in switch which exposes
> four 1000Base-T PHYs as user ports.
> It also comes with built-in 2500Base-T PHY which can be used
> with the 2nd GMAC.
> The 2nd and 3rd GMAC can be connected to external PHYs or provide
> SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
> 5GBase-KR or 10GBase-KR.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--S3k3Sb20TyWQtpEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLvBvQAKCRB4tDGHoIJi
0rTAAQDHnk1AXL1i3JuZmYT+/xX+kwzUCVfTJwQJkX31Ipzx2gD+OJ94P3rAvdSL
gWeUD5nqQVtppRlDGSgQ2QX6lSK3Dww=
=dmf1
-----END PGP SIGNATURE-----

--S3k3Sb20TyWQtpEz--
