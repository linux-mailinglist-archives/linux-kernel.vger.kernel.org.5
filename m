Return-Path: <linux-kernel+bounces-32669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA23835EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D45B28FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2187E3A1BD;
	Mon, 22 Jan 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2m98IRC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C603A1A6;
	Mon, 22 Jan 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917030; cv=none; b=Apky+uZa+vbqcqBnfHZZp6y8XK+Ze7depwzmMvVm1Mk4mNawHXXvNH/jCLHHhvj3ZgJ8ng0LcpT9XIL6un0B/dQSNZmNYJk1RKgGPDIfrFaVrYWxrB1t9t5jUrIaliCRvlRoNUQ9SzXs+KBatCiiL7Fw2toUSbqlC7hQjvvfDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917030; c=relaxed/simple;
	bh=pOqtB62Yq5NAhYfY1JOjJV/ctmZZMPb78a7ST7r73I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6vl0u2KOScB7MsbTBnjmMgqf+WLk8akUc6kKS8/rE+dEtkJHCbRj/8cnZmCqA7pUGcUdR9pxnbLJzf4HThfhsfSjlgKmfY2oa2VOOYSTuuUKL50l8Wo5L5EM9zbt8M+EyeuJz/aMe91Z/m0UfK4MiymWUkEwtTIxJalZB7p/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2m98IRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1753DC43394;
	Mon, 22 Jan 2024 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705917029;
	bh=pOqtB62Yq5NAhYfY1JOjJV/ctmZZMPb78a7ST7r73I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2m98IRCb5dLq8PXrZh4PoiuOsDPXoYBBNkopMYAEiiEHDWJ1xlqeIMyJ3saPJC3s
	 0inoBs8GE5MUaDrEFSQYoRxAMmP6hHZsWxdDQcWGUX08/niwRQQRr/sBhLbJ90Eryx
	 agl1hfrOzstXJxClYlRiFJQcVzqqRh/qxWyQQKKFMDX4Oga70koykh/bKgeQj9fH71
	 pGuzvVpw4BumRtgBixm9Il0KlG119TozoIzxbUTKCdu4TPAfQXT1tzaGu/X8jhI9hq
	 +UoRfV94nFk4dRhbf0qI9Zb469C1a7Nc6SsPEgmhkqTbRFQf2v1MCiSjYFec3rqYXU
	 qynqsdFZp/bzQ==
Date: Mon, 22 Jan 2024 09:50:23 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, abelvesa@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-imx@nxp.com,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] dt-bindings: clock: support NXP i.MX95
Message-ID: <20240122-clamor-cold-e082e5f8d6f4@spud>
References: <20240122013239.1434383-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xP5iYBXW4S7yIZot"
Content-Disposition: inline
In-Reply-To: <20240122013239.1434383-1-peng.fan@oss.nxp.com>


--xP5iYBXW4S7yIZot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 09:32:39AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX95 clock dt-binding header file
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Typo: SENTINEL -> ELE
>=20
>  include/dt-bindings/clock/nxp,imx95-clock.h | 187 ++++++++++++++++++++

I'd expect to see this alongside a compatible addition. Where is that
change?

Thanks,
Conor.

>  1 file changed, 187 insertions(+)
>  create mode 100644 include/dt-bindings/clock/nxp,imx95-clock.h
>=20
> diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bin=
dings/clock/nxp,imx95-clock.h
> new file mode 100644
> index 000000000000..de7af0f29f09
> --- /dev/null
> +++ b/include/dt-bindings/clock/nxp,imx95-clock.h
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_IMX95_H
> +#define __DT_BINDINGS_CLOCK_IMX95_H
> +
> +/* The index should match i.MX95 SCMI Firmware */
> +#define IMX95_CLK_32K                       1
> +#define IMX95_CLK_24M                       2
> +#define IMX95_CLK_FRO                       3
> +#define IMX95_CLK_SYSPLL1_VCO               4
> +#define IMX95_CLK_SYSPLL1_PFD0_UNGATED      5
> +#define IMX95_CLK_SYSPLL1_PFD0              6
> +#define IMX95_CLK_SYSPLL1_PFD0_DIV2         7
> +#define IMX95_CLK_SYSPLL1_PFD1_UNGATED      8
> +#define IMX95_CLK_SYSPLL1_PFD1              9
> +#define IMX95_CLK_SYSPLL1_PFD1_DIV2         10
> +#define IMX95_CLK_SYSPLL1_PFD2_UNGATED      11
> +#define IMX95_CLK_SYSPLL1_PFD2              12
> +#define IMX95_CLK_SYSPLL1_PFD2_DIV2         13
> +#define IMX95_CLK_AUDIOPLL1_VCO             14
> +#define IMX95_CLK_AUDIOPLL1                 15
> +#define IMX95_CLK_AUDIOPLL2_VCO             16
> +#define IMX95_CLK_AUDIOPLL2                 17
> +#define IMX95_CLK_VIDEOPLL1_VCO             18
> +#define IMX95_CLK_VIDEOPLL1                 19
> +#define IMX95_CLK_RESERVED20                20
> +#define IMX95_CLK_RESERVED21                21
> +#define IMX95_CLK_RESERVED22                22
> +#define IMX95_CLK_RESERVED23                23
> +#define IMX95_CLK_ARMPLL_VCO                24
> +#define IMX95_CLK_ARMPLL_PFD0_UNGATED       25
> +#define IMX95_CLK_ARMPLL_PFD0               26
> +#define IMX95_CLK_ARMPLL_PFD1_UNGATED       27
> +#define IMX95_CLK_ARMPLL_PFD1               28
> +#define IMX95_CLK_ARMPLL_PFD2_UNGATED       29
> +#define IMX95_CLK_ARMPLL_PFD2               30
> +#define IMX95_CLK_ARMPLL_PFD3_UNGATED       31
> +#define IMX95_CLK_ARMPLL_PFD3               32
> +#define IMX95_CLK_DRAMPLL_VCO               33
> +#define IMX95_CLK_DRAMPLL                   34
> +#define IMX95_CLK_HSIOPLL_VCO               35
> +#define IMX95_CLK_HSIOPLL                   36
> +#define IMX95_CLK_LDBPLL_VCO                37
> +#define IMX95_CLK_LDBPLL                    38
> +#define IMX95_CLK_EXT1                      39
> +#define IMX95_CLK_EXT2                      40
> +
> +#define IMX95_CCM_NUM_CLK_SRC               41
> +
> +#define IMX95_CLK_ADC                      (IMX95_CCM_NUM_CLK_SRC + 0)
> +#define IMX95_CLK_TMU                      (IMX95_CCM_NUM_CLK_SRC + 1)
> +#define IMX95_CLK_BUSAON                   (IMX95_CCM_NUM_CLK_SRC + 2)
> +#define IMX95_CLK_CAN1                     (IMX95_CCM_NUM_CLK_SRC + 3)
> +#define IMX95_CLK_I3C1                     (IMX95_CCM_NUM_CLK_SRC + 4)
> +#define IMX95_CLK_I3C1SLOW                 (IMX95_CCM_NUM_CLK_SRC + 5)
> +#define IMX95_CLK_LPI2C1                   (IMX95_CCM_NUM_CLK_SRC + 6)
> +#define IMX95_CLK_LPI2C2                   (IMX95_CCM_NUM_CLK_SRC + 7)
> +#define IMX95_CLK_LPSPI1                   (IMX95_CCM_NUM_CLK_SRC + 8)
> +#define IMX95_CLK_LPSPI2                   (IMX95_CCM_NUM_CLK_SRC + 9)
> +#define IMX95_CLK_LPTMR1                   (IMX95_CCM_NUM_CLK_SRC + 10)
> +#define IMX95_CLK_LPUART1                  (IMX95_CCM_NUM_CLK_SRC + 11)
> +#define IMX95_CLK_LPUART2                  (IMX95_CCM_NUM_CLK_SRC + 12)
> +#define IMX95_CLK_M33                      (IMX95_CCM_NUM_CLK_SRC + 13)
> +#define IMX95_CLK_M33SYSTICK               (IMX95_CCM_NUM_CLK_SRC + 14)
> +#define IMX95_CLK_MQS1                     (IMX95_CCM_NUM_CLK_SRC + 15)
> +#define IMX95_CLK_PDM                      (IMX95_CCM_NUM_CLK_SRC + 16)
> +#define IMX95_CLK_SAI1                     (IMX95_CCM_NUM_CLK_SRC + 17)
> +#define IMX95_CLK_ELE                      (IMX95_CCM_NUM_CLK_SRC + 18)
> +#define IMX95_CLK_TPM2                     (IMX95_CCM_NUM_CLK_SRC + 19)
> +#define IMX95_CLK_TSTMR1                   (IMX95_CCM_NUM_CLK_SRC + 20)
> +#define IMX95_CLK_CAMAPB                   (IMX95_CCM_NUM_CLK_SRC + 21)
> +#define IMX95_CLK_CAMAXI                   (IMX95_CCM_NUM_CLK_SRC + 22)
> +#define IMX95_CLK_CAMCM0                   (IMX95_CCM_NUM_CLK_SRC + 23)
> +#define IMX95_CLK_CAMISI                   (IMX95_CCM_NUM_CLK_SRC + 24)
> +#define IMX95_CLK_MIPIPHYCFG               (IMX95_CCM_NUM_CLK_SRC + 25)
> +#define IMX95_CLK_MIPIPHYPLLBYPASS         (IMX95_CCM_NUM_CLK_SRC + 26)
> +#define IMX95_CLK_MIPIPHYPLLREF            (IMX95_CCM_NUM_CLK_SRC + 27)
> +#define IMX95_CLK_MIPITESTBYTE             (IMX95_CCM_NUM_CLK_SRC + 28)
> +#define IMX95_CLK_A55                      (IMX95_CCM_NUM_CLK_SRC + 29)
> +#define IMX95_CLK_A55MTRBUS                (IMX95_CCM_NUM_CLK_SRC + 30)
> +#define IMX95_CLK_A55PERIPH                (IMX95_CCM_NUM_CLK_SRC + 31)
> +#define IMX95_CLK_DRAMALT                  (IMX95_CCM_NUM_CLK_SRC + 32)
> +#define IMX95_CLK_DRAMAPB                  (IMX95_CCM_NUM_CLK_SRC + 33)
> +#define IMX95_CLK_DISPAPB                  (IMX95_CCM_NUM_CLK_SRC + 34)
> +#define IMX95_CLK_DISPAXI                  (IMX95_CCM_NUM_CLK_SRC + 35)
> +#define IMX95_CLK_DISPDP                   (IMX95_CCM_NUM_CLK_SRC + 36)
> +#define IMX95_CLK_DISPOCRAM                (IMX95_CCM_NUM_CLK_SRC + 37)
> +#define IMX95_CLK_DISPUSB31                (IMX95_CCM_NUM_CLK_SRC + 38)
> +#define IMX95_CLK_DISP1PIX                 (IMX95_CCM_NUM_CLK_SRC + 39)
> +#define IMX95_CLK_DISP2PIX                 (IMX95_CCM_NUM_CLK_SRC + 40)
> +#define IMX95_CLK_DISP3PIX                 (IMX95_CCM_NUM_CLK_SRC + 41)
> +#define IMX95_CLK_GPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 42)
> +#define IMX95_CLK_GPU                      (IMX95_CCM_NUM_CLK_SRC + 43)
> +#define IMX95_CLK_HSIOACSCAN480M           (IMX95_CCM_NUM_CLK_SRC + 44)
> +#define IMX95_CLK_HSIOACSCAN80M            (IMX95_CCM_NUM_CLK_SRC + 45)
> +#define IMX95_CLK_HSIO                     (IMX95_CCM_NUM_CLK_SRC + 46)
> +#define IMX95_CLK_HSIOPCIEAUX              (IMX95_CCM_NUM_CLK_SRC + 47)
> +#define IMX95_CLK_HSIOPCIETEST160M         (IMX95_CCM_NUM_CLK_SRC + 48)
> +#define IMX95_CLK_HSIOPCIETEST400M         (IMX95_CCM_NUM_CLK_SRC + 49)
> +#define IMX95_CLK_HSIOPCIETEST500M         (IMX95_CCM_NUM_CLK_SRC + 50)
> +#define IMX95_CLK_HSIOUSBTEST50M           (IMX95_CCM_NUM_CLK_SRC + 51)
> +#define IMX95_CLK_HSIOUSBTEST60M           (IMX95_CCM_NUM_CLK_SRC + 52)
> +#define IMX95_CLK_BUSM7                    (IMX95_CCM_NUM_CLK_SRC + 53)
> +#define IMX95_CLK_M7                       (IMX95_CCM_NUM_CLK_SRC + 54)
> +#define IMX95_CLK_M7SYSTICK                (IMX95_CCM_NUM_CLK_SRC + 55)
> +#define IMX95_CLK_BUSNETCMIX               (IMX95_CCM_NUM_CLK_SRC + 56)
> +#define IMX95_CLK_ENET                     (IMX95_CCM_NUM_CLK_SRC + 57)
> +#define IMX95_CLK_ENETPHYTEST200M          (IMX95_CCM_NUM_CLK_SRC + 58)
> +#define IMX95_CLK_ENETPHYTEST500M          (IMX95_CCM_NUM_CLK_SRC + 59)
> +#define IMX95_CLK_ENETPHYTEST667M          (IMX95_CCM_NUM_CLK_SRC + 60)
> +#define IMX95_CLK_ENETREF                  (IMX95_CCM_NUM_CLK_SRC + 61)
> +#define IMX95_CLK_ENETTIMER1               (IMX95_CCM_NUM_CLK_SRC + 62)
> +#define IMX95_CLK_MQS2                     (IMX95_CCM_NUM_CLK_SRC + 63)
> +#define IMX95_CLK_SAI2                     (IMX95_CCM_NUM_CLK_SRC + 64)
> +#define IMX95_CLK_NOCAPB                   (IMX95_CCM_NUM_CLK_SRC + 65)
> +#define IMX95_CLK_NOC                      (IMX95_CCM_NUM_CLK_SRC + 66)
> +#define IMX95_CLK_NPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 67)
> +#define IMX95_CLK_NPU                      (IMX95_CCM_NUM_CLK_SRC + 68)
> +#define IMX95_CLK_CCMCKO1                  (IMX95_CCM_NUM_CLK_SRC + 69)
> +#define IMX95_CLK_CCMCKO2                  (IMX95_CCM_NUM_CLK_SRC + 70)
> +#define IMX95_CLK_CCMCKO3                  (IMX95_CCM_NUM_CLK_SRC + 71)
> +#define IMX95_CLK_CCMCKO4                  (IMX95_CCM_NUM_CLK_SRC + 72)
> +#define IMX95_CLK_VPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 73)
> +#define IMX95_CLK_VPU                      (IMX95_CCM_NUM_CLK_SRC + 74)
> +#define IMX95_CLK_VPUDSP                   (IMX95_CCM_NUM_CLK_SRC + 75)
> +#define IMX95_CLK_VPUJPEG                  (IMX95_CCM_NUM_CLK_SRC + 76)
> +#define IMX95_CLK_AUDIOXCVR                (IMX95_CCM_NUM_CLK_SRC + 77)
> +#define IMX95_CLK_BUSWAKEUP                (IMX95_CCM_NUM_CLK_SRC + 78)
> +#define IMX95_CLK_CAN2                     (IMX95_CCM_NUM_CLK_SRC + 79)
> +#define IMX95_CLK_CAN3                     (IMX95_CCM_NUM_CLK_SRC + 80)
> +#define IMX95_CLK_CAN4                     (IMX95_CCM_NUM_CLK_SRC + 81)
> +#define IMX95_CLK_CAN5                     (IMX95_CCM_NUM_CLK_SRC + 82)
> +#define IMX95_CLK_FLEXIO1                  (IMX95_CCM_NUM_CLK_SRC + 83)
> +#define IMX95_CLK_FLEXIO2                  (IMX95_CCM_NUM_CLK_SRC + 84)
> +#define IMX95_CLK_FLEXSPI1                 (IMX95_CCM_NUM_CLK_SRC + 85)
> +#define IMX95_CLK_I3C2                     (IMX95_CCM_NUM_CLK_SRC + 86)
> +#define IMX95_CLK_I3C2SLOW                 (IMX95_CCM_NUM_CLK_SRC + 87)
> +#define IMX95_CLK_LPI2C3                   (IMX95_CCM_NUM_CLK_SRC + 88)
> +#define IMX95_CLK_LPI2C4                   (IMX95_CCM_NUM_CLK_SRC + 89)
> +#define IMX95_CLK_LPI2C5                   (IMX95_CCM_NUM_CLK_SRC + 90)
> +#define IMX95_CLK_LPI2C6                   (IMX95_CCM_NUM_CLK_SRC + 91)
> +#define IMX95_CLK_LPI2C7                   (IMX95_CCM_NUM_CLK_SRC + 92)
> +#define IMX95_CLK_LPI2C8                   (IMX95_CCM_NUM_CLK_SRC + 93)
> +#define IMX95_CLK_LPSPI3                   (IMX95_CCM_NUM_CLK_SRC + 94)
> +#define IMX95_CLK_LPSPI4                   (IMX95_CCM_NUM_CLK_SRC + 95)
> +#define IMX95_CLK_LPSPI5                   (IMX95_CCM_NUM_CLK_SRC + 96)
> +#define IMX95_CLK_LPSPI6                   (IMX95_CCM_NUM_CLK_SRC + 97)
> +#define IMX95_CLK_LPSPI7                   (IMX95_CCM_NUM_CLK_SRC + 98)
> +#define IMX95_CLK_LPSPI8                   (IMX95_CCM_NUM_CLK_SRC + 99)
> +#define IMX95_CLK_LPTMR2                   (IMX95_CCM_NUM_CLK_SRC + 100)
> +#define IMX95_CLK_LPUART3                  (IMX95_CCM_NUM_CLK_SRC + 101)
> +#define IMX95_CLK_LPUART4                  (IMX95_CCM_NUM_CLK_SRC + 102)
> +#define IMX95_CLK_LPUART5                  (IMX95_CCM_NUM_CLK_SRC + 103)
> +#define IMX95_CLK_LPUART6                  (IMX95_CCM_NUM_CLK_SRC + 104)
> +#define IMX95_CLK_LPUART7                  (IMX95_CCM_NUM_CLK_SRC + 105)
> +#define IMX95_CLK_LPUART8                  (IMX95_CCM_NUM_CLK_SRC + 106)
> +#define IMX95_CLK_SAI3                     (IMX95_CCM_NUM_CLK_SRC + 107)
> +#define IMX95_CLK_SAI4                     (IMX95_CCM_NUM_CLK_SRC + 108)
> +#define IMX95_CLK_SAI5                     (IMX95_CCM_NUM_CLK_SRC + 109)
> +#define IMX95_CLK_SPDIF                    (IMX95_CCM_NUM_CLK_SRC + 110)
> +#define IMX95_CLK_SWOTRACE                 (IMX95_CCM_NUM_CLK_SRC + 111)
> +#define IMX95_CLK_TPM4                     (IMX95_CCM_NUM_CLK_SRC + 112)
> +#define IMX95_CLK_TPM5                     (IMX95_CCM_NUM_CLK_SRC + 113)
> +#define IMX95_CLK_TPM6                     (IMX95_CCM_NUM_CLK_SRC + 114)
> +#define IMX95_CLK_TSTMR2                   (IMX95_CCM_NUM_CLK_SRC + 115)
> +#define IMX95_CLK_USBPHYBURUNIN            (IMX95_CCM_NUM_CLK_SRC + 116)
> +#define IMX95_CLK_USDHC1                   (IMX95_CCM_NUM_CLK_SRC + 117)
> +#define IMX95_CLK_USDHC2                   (IMX95_CCM_NUM_CLK_SRC + 118)
> +#define IMX95_CLK_USDHC3                   (IMX95_CCM_NUM_CLK_SRC + 119)
> +#define IMX95_CLK_V2XPK                    (IMX95_CCM_NUM_CLK_SRC + 120)
> +#define IMX95_CLK_WAKEUPAXI                (IMX95_CCM_NUM_CLK_SRC + 121)
> +#define IMX95_CLK_XSPISLVROOT              (IMX95_CCM_NUM_CLK_SRC + 122)
> +#define IMX95_CLK_SEL_EXT                  (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 0)
> +#define IMX95_CLK_SEL_A55C0                (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 1)
> +#define IMX95_CLK_SEL_A55C1                (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 2)
> +#define IMX95_CLK_SEL_A55C2                (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 3)
> +#define IMX95_CLK_SEL_A55C3                (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 4)
> +#define IMX95_CLK_SEL_A55C4                (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 5)
> +#define IMX95_CLK_SEL_A55C5                (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 6)
> +#define IMX95_CLK_SEL_A55P                 (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 7)
> +#define IMX95_CLK_SEL_DRAM                 (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 8)
> +#define IMX95_CLK_SEL_TEMPSENSE            (IMX95_CCM_NUM_CLK_SRC + 123 =
+ 9)
> +
> +#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */
> --=20
> 2.37.1
>=20

--xP5iYBXW4S7yIZot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa46XwAKCRB4tDGHoIJi
0vorAQDDLPFvC5R2xlTb+fycVSFF5k/ny7Lx/oLEY9yOMZa+dAEAwuNpjwwyHj+3
+oGWreW3iIce0LI4gIlr1nSd0qN3ggw=
=N/CV
-----END PGP SIGNATURE-----

--xP5iYBXW4S7yIZot--

