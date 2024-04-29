Return-Path: <linux-kernel+bounces-162426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544BC8B5B08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02091F2192D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31BC7BB07;
	Mon, 29 Apr 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRi/v7m6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1599468;
	Mon, 29 Apr 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400001; cv=none; b=ri/jecn9OnSYSciJF5a7k406M++DuHJwpD6r8qWSj8H1wwTlRUuuOqlwWVay5RT5S72D8JmSAhNGEngFxNeaccs399Esxga5U1o6WiIqHDaGNx2P1JzBtGu1caCv49cte6kWwir7aZRiVxqRVptmoVtglBcWbSglwWPO6QHyYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400001; c=relaxed/simple;
	bh=618JHK33NfWpe17uC+zkMyziNzW0BIM5OKg4SY19Z4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHLdib8hjmK1JNF2wnJh0whtn4eYBpY5xMML8bh3Jdv2zXydXCma8kToWMueceahc+/WAHv7DcW1WJ50prkjqxuLdf+mW6Q+Ne2sY6Bde+rJt1dL6gInTRV60WOwydEQUYApj1g+zRlk2SsnvnfV9IgtzUMwGmM3XC5vwKZXpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRi/v7m6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06CDC113CD;
	Mon, 29 Apr 2024 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714400001;
	bh=618JHK33NfWpe17uC+zkMyziNzW0BIM5OKg4SY19Z4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pRi/v7m69mn8YjGwqv5JxC0uIfVArly6v1eFC5p2vwvEERWe47HOeeZv9VFHvg8oy
	 ceOoJLDgAWB8NlyggIdoUfXpf1IdFvvdtvX1xqGlhs1ymXqGrJuILz5ZgDqb/Tb3uY
	 cZZTFB3BZ5736Z9/wwc0OD55Qg+f7JhJakp3ufd5XubEM8sNCYpUvY+OdBrmc1F0T2
	 STml+I0UGIK4YMkQHmzKPdt4RdL/3i3OfBUfYRSkK0yPNlS4aKkoq9NQ9oR09J5mbx
	 mrMxE6GeYQQOG68nIxBIaH1GiHVidZGwFgN8xHiWQcfe93DuacfCx8pjkSOFPVG1Co
	 8ieLALYIWNNMQ==
Message-ID: <c3531f5f-7aaa-4363-8bfe-ac90521d7a0e@kernel.org>
Date: Mon, 29 Apr 2024 17:13:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] soc: mediatek: Add MediaTek DVFS Resource
 Collector (DVFSRC) driver
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 keescook@chromium.org, gustavoars@kernel.org, henryc.chen@mediatek.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, amergnat@baylibre.com,
 Dawei Chien <dawei.chien@mediatek.com>
References: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
 <20240424095416.1105639-5-angelogioacchino.delregno@collabora.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240424095416.1105639-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 12:54, AngeloGioacchino Del Regno wrote:
> The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> Hardware module used to collect all the requests from both software and the
> various remote processors embedded into the SoC and decide about a minimum
> operating voltage and a minimum DRAM frequency to fulfill those requests in
> an effort to provide the best achievable performance per watt.
> 
> This hardware IP is capable of transparently performing direct register R/W
> on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
> 
> This driver includes support for MT8183, MT8192 and MT8195.
> 
> Co-Developed-by: Dawei Chien <dawei.chien@mediatek.com>
> [Angelo: Partial refactoring and cleanups]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks for reviving this patchset!

> ---
>   drivers/soc/mediatek/Kconfig             |  11 +
>   drivers/soc/mediatek/Makefile            |   1 +
>   drivers/soc/mediatek/mtk-dvfsrc.c        | 551 +++++++++++++++++++++++
>   include/linux/soc/mediatek/dvfsrc.h      |  36 ++
>   include/linux/soc/mediatek/mtk_sip_svc.h |   3 +
>   5 files changed, 602 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
>   create mode 100644 include/linux/soc/mediatek/dvfsrc.h
> 
[..]
> +++ b/drivers/soc/mediatek/mtk-dvfsrc.c
> @@ -0,0 +1,551 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Copyright (c) 2024 Collabora Ltd.
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/dvfsrc.h>
> +#include <linux/soc/mediatek/mtk_sip_svc.h>
> +
> +/* DVFSRC_LEVEL */
> +#define DVFSRC_V1_LEVEL_TARGET_LEVEL	GENMASK(15, 0)
> +#define DVFSRC_TGT_LEVEL_IDLE		0x00
> +#define DVFSRC_V1_LEVEL_CURRENT_LEVEL	GENMASK(31, 16)
> +
> +/* DVFSRC_SW_REQ, DVFSRC_SW_REQ2 */
> +#define DVFSRC_V1_SW_REQ2_DRAM_LEVEL	GENMASK(1, 0)
> +#define DVFSRC_V1_SW_REQ2_VCORE_LEVEL	GENMASK(3, 2)
> +
> +#define DVFSRC_V2_SW_REQ_DRAM_LEVEL	GENMASK(3, 0)
> +#define DVFSRC_V2_SW_REQ_VCORE_LEVEL	GENMASK(6, 4)
> +
> +/* DVFSRC_VCORE */
> +#define DVFSRC_V2_VCORE_REQ_VSCP_LEVEL	GENMASK(14, 12)
> +
> +#define KBPS_TO_MBPS(x)			((x) / 1000)
> +
> +#define DVFSRC_POLL_TIMEOUT_US		1000
> +#define STARTUP_TIME_US			1
> +
> +#define MTK_SIP_DVFSRC_INIT		0x0
> +#define MTK_SIP_DVFSRC_START		0x1
> +
> +struct dvfsrc_bw_constraints {
> +	u16 max_dram_nom_bw;
> +	u16 max_dram_peak_bw;
> +	u16 max_dram_hrt_bw;
> +};
> +
> +struct dvfsrc_opp {
> +	u32 vcore_opp;
> +	u32 dram_opp;
> +};
> +
> +struct dvfsrc_opp_desc {
> +	const struct dvfsrc_opp *opps;
> +	u32 num_opp;
> +};
> +
> +struct dvfsrc_soc_data;
> +struct mtk_dvfsrc {
> +	struct device *dev;
> +	struct platform_device *icc;
> +	struct platform_device *regulator;
> +	const struct dvfsrc_soc_data *dvd;
> +	const struct dvfsrc_opp_desc *curr_opps;
> +	void __iomem *regs;
> +	int dram_type;
> +};
> +
> +struct dvfsrc_soc_data {
> +	const int *regs;
> +	const struct dvfsrc_opp_desc *opps_desc;
> +	u32 (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
> +	u32 (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
> +	u32 (*get_vcore_level)(struct mtk_dvfsrc *dvfsrc);
> +	u32 (*get_vscp_level)(struct mtk_dvfsrc *dvfsrc);
> +	void (*set_dram_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
> +	void (*set_dram_peak_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
> +	void (*set_dram_hrt_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
> +	void (*set_opp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	void (*set_vcore_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	void (*set_vscp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	int (*wait_for_opp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	int (*wait_for_vcore_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	const struct dvfsrc_bw_constraints *bw_constraints;
> +};
> +
> +static u32 dvfsrc_readl(struct mtk_dvfsrc *dvfs, u32 offset)
> +{
> +	return readl(dvfs->regs + dvfs->dvd->regs[offset]);
> +}
> +
> +static void dvfsrc_writel(struct mtk_dvfsrc *dvfs, u32 offset, u32 val)
> +{
> +	writel(val, dvfs->regs + dvfs->dvd->regs[offset]);
> +}
> +
> +#define dvfsrc_rmw(dvfs, offset, val, mask, shift) \
> +	dvfsrc_writel(dvfs, offset, \
> +		(dvfsrc_readl(dvfs, offset) & ~(mask << shift)) | (val << shift))

Nit: The above macro seems unused?

BR,
Georgi

> +enum dvfsrc_regs {
> +	DVFSRC_SW_REQ,
> +	DVFSRC_SW_REQ2,
> +	DVFSRC_LEVEL,
> +	DVFSRC_TARGET_LEVEL,
> +	DVFSRC_SW_BW,
> +	DVFSRC_SW_PEAK_BW,
> +	DVFSRC_SW_HRT_BW,
> +	DVFSRC_VCORE,
> +	DVFSRC_REGS_MAX,
> +};
> +


