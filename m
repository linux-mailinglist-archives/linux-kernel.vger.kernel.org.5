Return-Path: <linux-kernel+bounces-117077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095288A6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2AD1F619AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B112AAF2;
	Mon, 25 Mar 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xv7KEm+A"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424412AAE0;
	Mon, 25 Mar 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371523; cv=none; b=Snnx61DwjeBSJdV617qpL+BsDN6Ag4YDSvmBwZBahaDImPNoCUjblKpOMsy/7LX6DjIoUJVNel50KyFHuyddSUEP/8R5L+ZnM8baBNuSdonlT8/wGds0dNY3K20afjhlVvFJMRyOO3Xoa3Z3dHWbnrDaf7NFGgyH0jdUeqP+1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371523; c=relaxed/simple;
	bh=X0mMoXhySmQx0Svx/wLI3xWB9TsLJ77ZgdxeEJbZWZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZTv3xL5Pq1JM6H/DFT/BmcbBBBVb+B6BBBpSllZm7C15oya8X0Sr+6V8r/Taig0DIaTl2Sm0HanuOxikY/AHMggGCMMGjZ+A8VSAHGLnJzpZhi2wTqfqTrK+h35ehtA57PmG6VZ2uG9bwr5VVEB2T1/QXGZR08F0vh8IurU7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xv7KEm+A; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711371520;
	bh=X0mMoXhySmQx0Svx/wLI3xWB9TsLJ77ZgdxeEJbZWZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xv7KEm+Au+NvqUEIVp5Kt3xA6YbT8CgSn1tEZAaqSg7sFnGoo/qu7VDPA7Ehhj5yE
	 GOfOetZKsTrzK33PRqHFGqBGSzagefv/NWCj/+pdhY72Nphg5hFmYwdT6BSrwr/4jN
	 e4oe4rC6hCF+QcsJR2Bprk5iQgXJC8Kd/2uIJsfcNQmJayAfyHPJ08aTK+7SU55Uyk
	 VrUuFuca67b7GUrHiJALDvxfKS7JeCg9W5R2i4/Lial+MlUoocGIStJXV9x2DAWRvX
	 gKbzChLT5SHIJfAsn9M0dGX6APN3c1SLL4uJtP9yzxxWicsI/CoRFu33bvYHpFet2p
	 vbjnF/+Uujdqw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5E55A378107C;
	Mon, 25 Mar 2024 12:58:39 +0000 (UTC)
Message-ID: <0e125862-c7f3-4aa0-89d6-ef458654bebb@collabora.com>
Date: Mon, 25 Mar 2024 13:58:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: mediatek: pm-domains: add smi_larb_reset
 function when power on
To: "yu-chang.lee" <yu-chang.lee@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, mandyjh.liu@mediatek.com,
 fan.chen@mediatek.com, xiufeng.li@mediatek.com
References: <20240325121908.3958-1-yu-chang.lee@mediatek.com>
 <20240325121908.3958-2-yu-chang.lee@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240325121908.3958-2-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/03/24 13:19, yu-chang.lee ha scritto:
> This patch avoid mtcmos power glitch from happening by set and clear
> smi larb reset.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
> ---
>   drivers/pmdomain/mediatek/mt8188-pm-domains.h | 28 +++++++++
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    | 59 +++++++++++++++++++
>   drivers/pmdomain/mediatek/mtk-pm-domains.h    | 12 ++++
>   3 files changed, 99 insertions(+)
> 
> diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> index 06834ab6597c..7bbba4d56a77 100644
> --- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> @@ -573,6 +573,18 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   		.pwr_sta2nd_offs = 0x170,
>   		.sram_pdn_bits = BIT(8),
>   		.sram_pdn_ack_bits = BIT(12),
> +		.reset_smi = {
> +			SMI_RESET_WR(MT8188_SMI_LARB10_RESET,
> +				     MT8188_SMI_LARB10_RESET_ADDR),
> +			SMI_RESET_WR(MT8188_SMI_LARB11A_RESET,
> +				     MT8188_SMI_LARB11A_RESET_ADDR),
> +			SMI_RESET_WR(MT8188_SMI_LARB11C_RESET,
> +				     MT8188_SMI_LARB11C_RESET_ADDR),
> +			SMI_RESET_WR(MT8188_SMI_LARB11B_RESET,
> +				     MT8188_SMI_LARB11B_RESET_ADDR),
> +			SMI_RESET_WR(MT8188_SMI_LARB15_RESET,
> +				     MT8188_SMI_LARB15_RESET_ADDR),
> +		},
>   		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>   	},
>   	[MT8188_POWER_DOMAIN_IPE] = {
> @@ -583,6 +595,10 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   		.pwr_sta2nd_offs = 0x170,
>   		.sram_pdn_bits = BIT(8),
>   		.sram_pdn_ack_bits = BIT(12),
> +		.reset_smi = {
> +			SMI_RESET_WR(MT8188_SMI_LARB12_RESET,
> +				     MT8188_SMI_LARB12_RESET_ADDR),
> +		},
>   		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>   	},
>   	[MT8188_POWER_DOMAIN_CAM_VCORE] = {
> @@ -660,6 +676,12 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   		.pwr_sta2nd_offs = 0x170,
>   		.sram_pdn_bits = BIT(8),
>   		.sram_pdn_ack_bits = BIT(12),
> +		.reset_smi = {
> +			SMI_RESET_WR(MT8188_SMI_LARB16A_RESET,
> +				     MT8188_SMI_LARB16A_RESET_ADDR),
> +			SMI_RESET_WR(MT8188_SMI_LARB17A_RESET,
> +				     MT8188_SMI_LARB17A_RESET_ADDR),
> +		},
>   		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>   	},
>   	[MT8188_POWER_DOMAIN_CAM_SUBB] = {
> @@ -670,6 +692,12 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   		.pwr_sta2nd_offs = 0x170,
>   		.sram_pdn_bits = BIT(8),
>   		.sram_pdn_ack_bits = BIT(12),
> +		.reset_smi = {
> +			SMI_RESET_WR(MT8188_SMI_LARB16B_RESET,
> +				     MT8188_SMI_LARB16B_RESET_ADDR),
> +			SMI_RESET_WR(MT8188_SMI_LARB17B_RESET,
> +				     MT8188_SMI_LARB17B_RESET_ADDR),
> +		},
>   		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>   	},
>   };
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index e274e3315fe7..9ab6fa105c8c 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -48,6 +48,8 @@ struct scpsys_domain {
>   	struct regmap *infracfg_nao;
>   	struct regmap *infracfg;
>   	struct regmap *smi;
> +	struct regmap **larb;
> +	int num_larb;
>   	struct regulator *supply;
>   };
>   
> @@ -230,6 +232,39 @@ static int scpsys_regulator_disable(struct regulator *supply)
>   	return supply ? regulator_disable(supply) : 0;
>   }
>   
> +static int _scpsys_smi_larb_reset(const struct smi_reset_data bpd,
> +				  struct regmap *regmap)
> +{
> +	int ret;
> +	u32 mask = bpd.smi_reset_mask;
> +
> +	if (!mask)
> +		return 0;
> +
> +	ret = regmap_set_bits(regmap, bpd.smi_reset_addr, mask);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(regmap, bpd.smi_reset_addr, mask);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int scpsys_smi_larb_reset(struct scpsys_domain *pd)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < pd->num_larb; i++) {
> +		ret = _scpsys_smi_larb_reset(pd->data->reset_smi[i], pd->larb[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int scpsys_power_on(struct generic_pm_domain *genpd)
>   {
>   	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
> @@ -279,6 +314,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	if (ret < 0)
>   		goto err_disable_subsys_clks;
>   
> +	ret = scpsys_smi_larb_reset(pd);
> +	if (ret < 0)
> +		goto err_disable_subsys_clks;
> +
>   	ret = scpsys_bus_protect_disable(pd);
>   	if (ret < 0)
>   		goto err_disable_sram;
> @@ -355,6 +394,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   	struct scpsys_domain *pd;
>   	struct device_node *root_node = scpsys->dev->of_node;
>   	struct device_node *smi_node;
> +	struct device_node *larb_node;
>   	struct property *prop;
>   	const char *clk_name;
>   	int i, ret, num_clks;
> @@ -418,6 +458,25 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   			return ERR_CAST(pd->smi);
>   	}
>   
> +	pd->num_larb = of_count_phandle_with_args(node, "mediatek,larb", NULL);

You must update bindings/power/mediatek,power-controller.yaml to allow the
mediatek,larb property in the power controller binding, otherwise this will
be unusable. Please do so.

Cheers,
Angelo


