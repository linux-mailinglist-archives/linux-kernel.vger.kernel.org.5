Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58A7EB596
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjKNRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:35:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166CB7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:35:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDADC433C8;
        Tue, 14 Nov 2023 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699983323;
        bh=joZBFhbRQi00kLO+og/cpjGzjAEGwcNlTtDpOtzvBx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAIgU2x4r+gD33pYZ1FMQ0BDGAQh1q8zqYgwk37N5MHp975L0H+s3rOutumry4Ec9
         PwgNwjOt5nIDSPv39RrF1uTMrJkOYujQvrOPKzUK6Dy1clJVllXryZXdpk0rX+MvzH
         AsCLyW1OPfWEQ7lq9krKh9MTg0fwmiQ+6+ZhlZpgfCDKbSyvv6l3LFIwYqws6LTOq3
         YwJwdozdyWKXIvmoDk3RiB6rFStfi8PAN1sal10Wp8EvXI+cjy6gONxiFTHI5m61yg
         dTJgkZtjD640nnxcnYdVjqW2uX9E+mkT5OFMDxzYEYlWJZzmDL4Y9L1rvD20Vjtd+z
         gUDvAixVKn5DQ==
Date:   Tue, 14 Nov 2023 17:35:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 1/5] dt-bindings: clock: sophgo: Add SG2042 clock
 definitions
Message-ID: <20231114-spool-hemlock-f69291a8cfa4@squawk>
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <db59acdc99357d52ede5fc9738bdb161649c8fa1.1699879741.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7cFGeDkzxkeHA1ni"
Content-Disposition: inline
In-Reply-To: <db59acdc99357d52ede5fc9738bdb161649c8fa1.1699879741.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7cFGeDkzxkeHA1ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 09:18:25PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add all clock outputs for the Sophgo SG2042 clock generator.

This patch can be squashed with the patch adding the binding for the
clock controller.

Cheers,
Conor.

>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  include/dt-bindings/clock/sophgo-sg2042-clk.h | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sophgo-sg2042-clk.h
>=20
> diff --git a/include/dt-bindings/clock/sophgo-sg2042-clk.h b/include/dt-b=
indings/clock/sophgo-sg2042-clk.h
> new file mode 100644
> index 000000000000..a8e05c00c3bf
> --- /dev/null
> +++ b/include/dt-bindings/clock/sophgo-sg2042-clk.h
> @@ -0,0 +1,169 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
> +#define __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
> +
> +/* Divider clocks */
> +#define DIV_CLK_MPLL_RP_CPU_NORMAL_0 0
> +#define DIV_CLK_MPLL_AXI_DDR_0 1
> +#define DIV_CLK_FPLL_DDR01_1 2
> +#define DIV_CLK_FPLL_DDR23_1 3
> +#define DIV_CLK_FPLL_RP_CPU_NORMAL_1 4
> +#define DIV_CLK_FPLL_50M_A53 5
> +#define DIV_CLK_FPLL_TOP_RP_CMN_DIV2 6
> +#define DIV_CLK_FPLL_UART_500M 7
> +#define DIV_CLK_FPLL_AHB_LPC 8
> +#define DIV_CLK_FPLL_EFUSE 9
> +#define DIV_CLK_FPLL_TX_ETH0 10
> +#define DIV_CLK_FPLL_PTP_REF_I_ETH0 11
> +#define DIV_CLK_FPLL_REF_ETH0 12
> +#define DIV_CLK_FPLL_EMMC 13
> +#define DIV_CLK_FPLL_SD 14
> +#define DIV_CLK_FPLL_TOP_AXI0 15
> +#define DIV_CLK_FPLL_TOP_AXI_HSPERI 16
> +#define DIV_CLK_FPLL_AXI_DDR_1 17
> +#define DIV_CLK_FPLL_DIV_TIMER1 18
> +#define DIV_CLK_FPLL_DIV_TIMER2 19
> +#define DIV_CLK_FPLL_DIV_TIMER3 20
> +#define DIV_CLK_FPLL_DIV_TIMER4 21
> +#define DIV_CLK_FPLL_DIV_TIMER5 22
> +#define DIV_CLK_FPLL_DIV_TIMER6 23
> +#define DIV_CLK_FPLL_DIV_TIMER7 24
> +#define DIV_CLK_FPLL_DIV_TIMER8 25
> +#define DIV_CLK_FPLL_100K_EMMC 26
> +#define DIV_CLK_FPLL_100K_SD 27
> +#define DIV_CLK_FPLL_GPIO_DB 28
> +#define DIV_CLK_DPLL0_DDR01_0 29
> +#define DIV_CLK_DPLL1_DDR23_0 30
> +
> +/* Gate clocks */
> +#define GATE_CLK_RP_CPU_NORMAL_DIV0 31
> +#define GATE_CLK_AXI_DDR_DIV0 32
> +
> +#define GATE_CLK_RP_CPU_NORMAL_DIV1 33
> +#define GATE_CLK_A53_50M 34
> +#define GATE_CLK_TOP_RP_CMN_DIV2 35
> +#define GATE_CLK_HSDMA 36
> +#define GATE_CLK_EMMC_100M 37
> +#define GATE_CLK_SD_100M 38
> +#define GATE_CLK_TX_ETH0 39
> +#define GATE_CLK_PTP_REF_I_ETH0 40
> +#define GATE_CLK_REF_ETH0 41
> +#define GATE_CLK_UART_500M 42
> +#define GATE_CLK_EFUSE 43
> +
> +#define GATE_CLK_AHB_LPC 44
> +#define GATE_CLK_AHB_ROM 45
> +#define GATE_CLK_AHB_SF 46
> +
> +#define GATE_CLK_APB_UART 47
> +#define GATE_CLK_APB_TIMER 48
> +#define GATE_CLK_APB_EFUSE 49
> +#define GATE_CLK_APB_GPIO 50
> +#define GATE_CLK_APB_GPIO_INTR 51
> +#define GATE_CLK_APB_SPI 52
> +#define GATE_CLK_APB_I2C 53
> +#define GATE_CLK_APB_WDT 54
> +#define GATE_CLK_APB_PWM 55
> +#define GATE_CLK_APB_RTC 56
> +
> +#define GATE_CLK_AXI_PCIE0 57
> +#define GATE_CLK_AXI_PCIE1 58
> +#define GATE_CLK_SYSDMA_AXI 59
> +#define GATE_CLK_AXI_DBG_I2C 60
> +#define GATE_CLK_AXI_SRAM 61
> +#define GATE_CLK_AXI_ETH0 62
> +#define GATE_CLK_AXI_EMMC 63
> +#define GATE_CLK_AXI_SD 64
> +#define GATE_CLK_TOP_AXI0 65
> +#define GATE_CLK_TOP_AXI_HSPERI 66
> +
> +#define GATE_CLK_TIMER1 67
> +#define GATE_CLK_TIMER2 68
> +#define GATE_CLK_TIMER3 69
> +#define GATE_CLK_TIMER4 70
> +#define GATE_CLK_TIMER5 71
> +#define GATE_CLK_TIMER6 72
> +#define GATE_CLK_TIMER7 73
> +#define GATE_CLK_TIMER8 74
> +#define GATE_CLK_100K_EMMC 75
> +#define GATE_CLK_100K_SD 76
> +#define GATE_CLK_GPIO_DB 77
> +
> +#define GATE_CLK_AXI_DDR_DIV1 78
> +#define GATE_CLK_DDR01_DIV1 79
> +#define GATE_CLK_DDR23_DIV1 80
> +/* DPLL0 */
> +#define GATE_CLK_DDR01_DIV0 81
> +/* DPLL1 */
> +#define GATE_CLK_DDR23_DIV0 82
> +
> +#define GATE_CLK_DDR01 83
> +#define GATE_CLK_DDR23 84
> +#define GATE_CLK_RP_CPU_NORMAL 85
> +#define GATE_CLK_AXI_DDR 86
> +#define GATE_CLK_RXU0 87
> +#define GATE_CLK_RXU1 88
> +#define GATE_CLK_RXU2 89
> +#define GATE_CLK_RXU3 90
> +#define GATE_CLK_RXU4 91
> +#define GATE_CLK_RXU5 92
> +#define GATE_CLK_RXU6 93
> +#define GATE_CLK_RXU7 94
> +#define GATE_CLK_RXU8 95
> +#define GATE_CLK_RXU9 96
> +#define GATE_CLK_RXU10 97
> +#define GATE_CLK_RXU11 98
> +#define GATE_CLK_RXU12 99
> +#define GATE_CLK_RXU13 100
> +#define GATE_CLK_RXU14 101
> +#define GATE_CLK_RXU15 102
> +#define GATE_CLK_RXU16 103
> +#define GATE_CLK_RXU17 104
> +#define GATE_CLK_RXU18 105
> +#define GATE_CLK_RXU19 106
> +#define GATE_CLK_RXU20 107
> +#define GATE_CLK_RXU21 108
> +#define GATE_CLK_RXU22 109
> +#define GATE_CLK_RXU23 110
> +#define GATE_CLK_RXU24 111
> +#define GATE_CLK_RXU25 112
> +#define GATE_CLK_RXU26 113
> +#define GATE_CLK_RXU27 114
> +#define GATE_CLK_RXU28 115
> +#define GATE_CLK_RXU29 116
> +#define GATE_CLK_RXU30 117
> +#define GATE_CLK_RXU31 118
> +#define GATE_CLK_MP0 119
> +#define GATE_CLK_MP1 120
> +#define GATE_CLK_MP2 121
> +#define GATE_CLK_MP3 122
> +#define GATE_CLK_MP4 123
> +#define GATE_CLK_MP5 124
> +#define GATE_CLK_MP6 125
> +#define GATE_CLK_MP7 126
> +#define GATE_CLK_MP8 127
> +#define GATE_CLK_MP9 128
> +#define GATE_CLK_MP10 129
> +#define GATE_CLK_MP11 130
> +#define GATE_CLK_MP12 131
> +#define GATE_CLK_MP13 132
> +#define GATE_CLK_MP14 133
> +#define GATE_CLK_MP15 134
> +
> +/* MUX clocks */
> +#define MUX_CLK_DDR01 135
> +#define MUX_CLK_DDR23 136
> +#define MUX_CLK_RP_CPU_NORMAL 137
> +#define MUX_CLK_AXI_DDR 138
> +
> +/* PLL clocks */
> +#define MPLL_CLK	139
> +#define FPLL_CLK	140
> +#define DPLL0_CLK	141
> +#define DPLL1_CLK	142
> +
> +#endif /* __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__ */
> --=20
> 2.25.1
>=20

--7cFGeDkzxkeHA1ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVOv1AAKCRB4tDGHoIJi
0s1bAP4l95TtR+AmLoNNf0pqp9QhukBdzCRCW2o3ePS6f25UcgEAyRh6YiAyAt1T
w4DGzzqpJ0I3uc+c/wxgB4z1K95TnAc=
=F1WB
-----END PGP SIGNATURE-----

--7cFGeDkzxkeHA1ni--
