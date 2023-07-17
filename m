Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F932756C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGQSkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGQSkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51FA1;
        Mon, 17 Jul 2023 11:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8717611EE;
        Mon, 17 Jul 2023 18:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DFDC433C8;
        Mon, 17 Jul 2023 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689619216;
        bh=olt+DMG58ct7l9NxdztWQ0bZHBpSC49ugEic3kozQRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBk0i9toNdi2Ojk8fA7KaYaVwvkNvUFEduF1KULkegnqQPvNwnK4y2q9Uxl3PXq5Y
         a35fPrLaZoQADww1vIjj+9TAajQj13KnzLNksk+11SsvCUGvwWE3ehLjDgRsRR2EdS
         QxlsHgs1cEXvL/qzSr9Ny16fx+ezYN6jNtgLgpvBSLfkn7jP5n9pHAWoLQk9k5cRKO
         xDBMnZSabQNVW83T5a91SWQW0g30ZlioOu4qWomnNRIm1mSMcPfahM/6+wsbMeRf3w
         JvVOwYLbeMkRO98DLPGSd4U9HGWQRVwNzUpo2Jb5Q86ORCtb9enhz+Qg/0widFooe4
         EBj1tvKwe4F+Q==
Date:   Mon, 17 Jul 2023 19:40:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, michal.simek@amd.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Message-ID: <20230717-explode-caucus-82c12e340e39@spud>
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fstMbh8Pe24J1VTz"
Content-Disposition: inline
In-Reply-To: <20230717112348.1381367-2-piyush.mehta@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fstMbh8Pe24J1VTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 04:53:47PM +0530, Piyush Mehta wrote:
> Added documentation and Versal-NET reset indices to describe about
> Versal-Net reset driver bindings.
>=20
> In Versal-NET all reset indices includes Class, SubClass, Type, Index
> information whereas class refers to clock, reset, power etc.,
> Underlying firmware in Versal have such classification and expects
> the ID to be this way.
> [13:0] - Index bits
> [19:14] - Type bits
> [25:20] - SubClass bits
> [31:26] - Class bits.

Riight.. I'm not sure that describing these as "indices" is really all
that valid, given only 13:0 are actually the index.
I'd be inclined to say that the type/class/subclass stuff should not be
part of the dt-bindings, and instead looked up inside the driver
depending on the index.

Hopefully Rob or Krzysztof can comment further.

Thanks,
Conor.

>=20
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
>  .../bindings/reset/xlnx,zynqmp-reset.yaml     |   4 +
>  .../reset/xlnx-versal-net-resets.h            | 127 ++++++++++++++++++
>  2 files changed, 131 insertions(+)
>  create mode 100644 include/dt-bindings/reset/xlnx-versal-net-resets.h
>=20
> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.ya=
ml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> index 0d50f6a54af3..b996fc1d4e53 100644
> --- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> @@ -27,11 +27,15 @@ description: |
>    For list of all valid reset indices for Versal
>    <dt-bindings/reset/xlnx-versal-resets.h>
> =20
> +  For list of all valid reset indices for Versal-NET
> +  <dt-bindings/reset/xlnx-versal-net-resets.h>
> +
>  properties:
>    compatible:
>      enum:
>        - xlnx,zynqmp-reset
>        - xlnx,versal-reset
> +      - xlnx,versal-net-reset
> =20
>    "#reset-cells":
>      const: 1
> diff --git a/include/dt-bindings/reset/xlnx-versal-net-resets.h b/include=
/dt-bindings/reset/xlnx-versal-net-resets.h
> new file mode 100644
> index 000000000000..b3e7d5e4c33e
> --- /dev/null
> +++ b/include/dt-bindings/reset/xlnx-versal-net-resets.h
> @@ -0,0 +1,127 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_VERSAL_NET_RESETS_H
> +#define _DT_BINDINGS_VERSAL_NET_RESETS_H
> +
> +#define PM_RST_PMC_POR                          (0xc30c001U)
> +#define PM_RST_PMC                              (0xc410002U)
> +#define PM_RST_PS_POR                           (0xc30c003U)
> +#define PM_RST_PL_POR                           (0xc30c004U)
> +#define PM_RST_NOC_POR                          (0xc30c005U)
> +#define PM_RST_PS_SRST                          (0xc41000aU)
> +#define PM_RST_PL_SRST                          (0xc41000bU)
> +#define PM_RST_NOC                              (0xc41000cU)
> +#define PM_RST_NPI                              (0xc41000dU)
> +#define PM_RST_SYS_RST_1                        (0xc41000eU)
> +#define PM_RST_SYS_RST_2                        (0xc41000fU)
> +#define PM_RST_SYS_RST_3                        (0xc410010U)
> +#define PM_RST_PL0                              (0xc410012U)
> +#define PM_RST_PL1                              (0xc410013U)
> +#define PM_RST_PL2                              (0xc410014U)
> +#define PM_RST_PL3                              (0xc410015U)
> +#define PM_RST_ACPU_GIC                         (0xc41001aU)
> +#define PM_RST_ADMA                             (0xc410026U)
> +#define PM_RST_OCM                              (0xc410028U)
> +#define PM_RST_IPI                              (0xc41002aU)
> +#define PM_RST_QSPI                             (0xc10402dU)
> +#define PM_RST_OSPI                             (0xc10402eU)
> +#define PM_RST_SDIO_0                           (0xc10402fU)
> +#define PM_RST_SDIO_1                           (0xc104030U)
> +#define PM_RST_GPIO_PMC                         (0xc104032U)
> +#define PM_RST_GEM_0                            (0xc104033U)
> +#define PM_RST_GEM_1                            (0xc104034U)
> +#define PM_RST_USB_0                            (0xc104036U)
> +#define PM_RST_UART_0                           (0xc104037U)
> +#define PM_RST_UART_1                           (0xc104038U)
> +#define PM_RST_SPI_0                            (0xc104039U)
> +#define PM_RST_SPI_1                            (0xc10403aU)
> +#define PM_RST_CAN_FD_0                         (0xc10403bU)
> +#define PM_RST_CAN_FD_1                         (0xc10403cU)
> +#define PM_RST_GPIO_LPD                         (0xc10403fU)
> +#define PM_RST_TTC_0                            (0xc104040U)
> +#define PM_RST_GPIO_LPD                         (0xc10403fU)
> +#define PM_RST_TTC_0                            (0xc104040U)
> +#define PM_RST_TTC_1                            (0xc104041U)
> +#define PM_RST_TTC_2                            (0xc104042U)
> +#define PM_RST_TTC_3                            (0xc104043U)
> +#define PM_RST_WWDT                             (0xC410079U)
> +#define PM_RST_SYS_1                            (0xC41007AU)
> +#define PM_RST_SYS_3                            (0xC41007BU)
> +#define PM_RST_SYS_2                            (0xC41007CU)
> +#define PM_RST_I2C                              (0xC410085U)
> +#define PM_RST_FPD_SWDT_2                       (0xC41008AU)
> +#define PM_RST_FPD_SWDT_1                       (0xC41008CU)
> +#define PM_RST_APU3_CORE1_WARM                  (0xC514099U)
> +#define PM_RST_APU3_CORE3_COLD                  (0xC61809AU)
> +#define PM_RST_APU3_CORE0_COLD                  (0xC61809BU)
> +#define PM_RST_APU3_CORE1_COLD                  (0xC61809CU)
> +#define PM_RST_APU3_CLUSTER_COLD                (0xC61809DU)
> +#define PM_RST_APU3_CORE0_WARM                  (0xC51409EU)
> +#define PM_RST_APU3_CLUSTER_COLD                (0xC61809DU)
> +#define PM_RST_APU3_CORE0_WARM                  (0xC51409EU)
> +#define PM_RST_APU3_CORE2_COLD                  (0xC61809FU)
> +#define PM_RST_APU3_CORE2_WARM                  (0xC5140A0U)
> +#define PM_RST_APU3_CORE3_WARM                  (0xC5140A1U)
> +#define PM_RST_APU3_CLUSTER_WARM                (0xC5140A2U)
> +#define PM_RST_FPD_SWDT_3                       (0xC4100A3U)
> +#define PM_RST_APU1_CORE1_WARM                  (0xC5140A4U)
> +#define PM_RST_APU1_CORE3_COLD                  (0xC6180A5U)
> +#define PM_RST_APU1_CORE0_COLD                  (0xC6180A6U)
> +#define PM_RST_APU1_CORE1_COLD                  (0xC6180A7U)
> +#define PM_RST_APU1_CLUSTER_COLD                (0xC6180A8U)
> +#define PM_RST_APU1_CORE0_WARM                  (0xC5140A9U)
> +#define PM_RST_APU1_CORE2_COLD                  (0xC6180AAU)
> +#define PM_RST_APU1_CORE2_WARM                  (0xC5140ABU)
> +#define PM_RST_APU1_CORE3_WARM                  (0xC5140ACU)
> +#define PM_RST_APU1_CLUSTER_WARM                (0xC5140ADU)
> +#define PM_RST_APU0_CORE1_WARM                  (0xC5140AFU)
> +#define PM_RST_APU0_CORE3_COLD                  (0xC6180B0U)
> +#define PM_RST_APU0_CORE0_COLD                  (0xC6180B1U)
> +#define PM_RST_APU0_CORE1_COLD                  (0xC6180B2U)
> +#define PM_RST_APU0_CLUSTER_COLD                (0xC6180B3U)
> +#define PM_RST_APU0_CORE0_WARM                  (0xC5140B4U)
> +#define PM_RST_APU0_CORE2_COLD                  (0xC6180B5U)
> +#define PM_RST_APU0_CORE2_WARM                  (0xC5140B6U)
> +#define PM_RST_APU0_CORE3_WARM                  (0xC5140B7U)
> +#define PM_RST_APU0_CLUSTER_WARM                (0xC5140B8U)
> +#define PM_RST_FPD_SWDT_0                       (0xC4100B9U)
> +#define PM_RST_APU2_CORE1_WARM                  (0xC5140BAU)
> +#define PM_RST_APU2_CORE3_COLD                  (0xC6180BBU)
> +#define PM_RST_APU2_CORE0_COLD                  (0xC6180BCU)
> +#define PM_RST_APU2_CORE1_COLD                  (0xC6180BDU)
> +#define PM_RST_APU2_CORE0_COLD                  (0xC6180BCU)
> +#define PM_RST_APU2_CORE1_COLD                  (0xC6180BDU)
> +#define PM_RST_APU2_CLUSTER_COLD                (0xC6180BEU)
> +#define PM_RST_APU2_CORE0_WARM                  (0xC5140BFU)
> +#define PM_RST_APU2_CORE2_COLD                  (0xC6180C0U)
> +#define PM_RST_APU2_CORE2_WARM                  (0xC5140C1U)
> +#define PM_RST_APU2_CORE3_WARM                  (0xC5140C2U)
> +#define PM_RST_APU2_CLUSTER_WARM                (0xC5140C3U)
> +#define PM_RST_USB_1                            (0xC1040C6U)
> +#define PM_RST_SWDT_1                           (0xC4100C7U)
> +#define PM_RST_SWDT_0                           (0xC4100C8U)
> +#define PM_RST_RPU_A_GD                         (0xC4100C9U)
> +#define PM_RST_RPU_B_GD                         (0xC4100CAU)
> +#define PM_RST_RPU_CORE0A                       (0xC4100CBU)
> +#define PM_RST_RPU_CORE0A_POR                   (0xC30C0CCU)
> +#define PM_RST_RPU_CORE0B_POR                   (0xC30C0CDU)
> +#define PM_RST_RPU_A_GD_TOP                     (0xC4100CEU)
> +#define PM_RST_RPU_CORE1B                       (0xC4100CFU)
> +#define PM_RST_RPU_B_TOPRESET                   (0xC4100D0U)
> +#define PM_RST_RPU_CORE1B_POR                   (0xC30C0D1U)
> +#define PM_RST_RPU_CORE1A                       (0xC4100D2U)
> +#define PM_RST_RPU_B_GD_TOP                     (0xC4100D3U)
> +#define PM_RST_RPU_A_TOPRESET                   (0xC4100D4U)
> +#define PM_RST_RPU_B_DBGRST                     (0xC2080D5U)
> +#define PM_RST_RPU_A_DCLS_TOPRESET              (0xC4100D6U)
> +#define PM_RST_RPU_CORE1A_POR                   (0xC30C0D7U)
> +#define PM_RST_RPU_B_DCLS_TOPRESET              (0xC4100D8U)
> +#define PM_RST_RPU_A_DBGRST                     (0xC2080D9U)
> +#define PM_RST_RPU_CORE0B                       (0xC4100DAU)
> +#define PM_RST_I3C_1                            (0xC4100DFU)
> +#define PM_RST_I3C_0                            (0xC4100E0U)
> +
> +#endif
> --=20
> 2.25.1
>=20

--fstMbh8Pe24J1VTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLWLCwAKCRB4tDGHoIJi
0i4vAP4isHh5j6EF2H+G1JKq2KFqgZgjJESmZiL9we4MINBAUAEAqoykHCVzi5t7
lcoDM15r5qMU8jqJ3sNFP4JmZaNV0QU=
=M7EI
-----END PGP SIGNATURE-----

--fstMbh8Pe24J1VTz--
