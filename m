Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DFB773C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjHHQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHHQER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46E2107;
        Tue,  8 Aug 2023 08:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB620623EE;
        Tue,  8 Aug 2023 12:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCADC433C8;
        Tue,  8 Aug 2023 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691496486;
        bh=iKFqjhht/NXdZgjGWSjxol/XyOZYksQmyjVTIwqbqok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+WW0w8h/Gbs8bpKCSYCtqnRjZTq3Ub0tNBt5pnkvUPjXE/936GbOIZKmpx8L8zKr
         HlQYtOfpaqqwpjC9h7cRK8rPo2E6b0Qw75oyRooQGgEtTKNtcUkG+SWeCiYLV77O2M
         sqQBJtRZ4GYHzpsl9r83Giab/iOx+A2Yudx/YRS/Kcyu9xRAPUsBZXhGLQ7sDr6/cu
         NzoSNRXCOzp5fygWFv4De+UcwhH/7LCqYMMoaYu86hGf13POhB1y3L1xq1v1Yct9OG
         6ovdTEIzSiIM49GuhPzeTTr19gS6H3iTpJ2gONcX0JGEIXr7yqcyQyAy/T4O5Sw1BK
         Y2nrkJa66ea7g==
Date:   Tue, 8 Aug 2023 13:08:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <20230808-unnerving-press-7b61f9c521dc@spud>
References: <20230807110048.2611456-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Wq7r3DP1wfOlIpT"
Content-Disposition: inline
In-Reply-To: <20230807110048.2611456-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Wq7r3DP1wfOlIpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ICSSG ethernet ports.
>=20
> This series also adds 10M full duplex support for ICSSG ethernet driver.
>=20
> There are two IEP instances. IEP0 is used for packet timestamping while I=
EP1
> is used for 10M full duplex support.
>=20
> This is v2 of the series [v1]. It addresses comments made on [v1].
> This series is based on linux-next(#next-20230807).=20
>=20
> Changes from v1 to v2:
> *) Addressed Simon's comment to fix reverse xmas tree declaration. Some A=
PIs
>    in patch 3 and 4 were not following reverse xmas tree variable declara=
tion.
>    Fixed it in this version.
> *) Addressed Conor's comments and removed unsupported SoCs from compatible
>    comment in patch 1.=20

I'm sorry I missed responding there before you sent v2, it was a bank
holiday yesterday. I'm curious why you removed them, rather than just
added them with a fallback to the ti,am654-icss-iep compatible, given
your comment that "the same compatible currently works for all these
3 SoCs".

Thanks,
Conor.

> *) Addded patch 2 which was not part of v1. Patch 2, adds IEP node to dt
>    bindings for ICSSG.
>=20
> [v1] https://lore.kernel.org/all/20230803110153.3309577-1-danishanwar@ti.=
com/
>=20
> Thanks and Regards,
> Md Danish Anwar
>=20
> Grygorii Strashko (1):
>   net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support
>=20
> MD Danish Anwar (1):
>   dt-bindings: net: Add iep node in ICSSG driver dt binding
>=20
> Md Danish Anwar (1):
>   dt-bindings: net: Add ICSS IEP
>=20
> Roger Quadros (2):
>   net: ti: icss-iep: Add IEP driver
>   net: ti: icssg-prueth: add packet timestamping and ptp support
>=20
>  .../devicetree/bindings/net/ti,icss-iep.yaml  |  37 +
>  .../bindings/net/ti,icssg-prueth.yaml         |   7 +
>  drivers/net/ethernet/ti/Kconfig               |  12 +
>  drivers/net/ethernet/ti/Makefile              |   1 +
>  drivers/net/ethernet/ti/icssg/icss_iep.c      | 961 ++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icss_iep.h      |  41 +
>  drivers/net/ethernet/ti/icssg/icssg_config.c  |   6 +
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  21 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 433 +++++++-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  28 +-
>  10 files changed, 1540 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
>=20
> --=20
> 2.34.1
>=20

--3Wq7r3DP1wfOlIpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIwIAAKCRB4tDGHoIJi
0g2dAP9kfFgMp83Kr/SnIeHz0AcFRVRxFOM13wTotQ4N7927ZwD/TYglqmJwOtcE
rW1EGcQQYNr+DLVPAzsiIpVYIj4QOgs=
=f/yq
-----END PGP SIGNATURE-----

--3Wq7r3DP1wfOlIpT--
