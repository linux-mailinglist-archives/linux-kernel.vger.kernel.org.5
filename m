Return-Path: <linux-kernel+bounces-117084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA3888B21E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E31DBE8382
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FB2579;
	Mon, 25 Mar 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I83YE3RX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7006E61B;
	Mon, 25 Mar 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371955; cv=none; b=pkan0xnPBoA5vfb+u1pVHrWnJRtKSg4J2y8akutBJ5LskPikZhu/lO6WOKHwfyRUx/BCQbsFj/BEFcGryeSMpxInZN99L84wAySoHomPDz2Ntzdp2bH52FSE4Be482mYj567fEqEZL5oqmAhpAYbzWiIk9uRCP0fzxmQsjryoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371955; c=relaxed/simple;
	bh=pnXYYeoKbGCaZlwTSVSSXwb+6bzzDJZJVhySWWjSWS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYCsCR6bseYtW1WYmyT5Cdd+kjWapuk3mncjjQ7YySiWd9bt73O0hxdDlZABrAG8PrbB0qQSeiSGVyMTbq25LHFp30W9LPmq5Ndv94pFVE//YshME1CBRM0ZHcJwB5PRjxQux0xnYMZUtlPA75DheCt82GVGayvjpUnddGYFXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I83YE3RX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711371949;
	bh=pnXYYeoKbGCaZlwTSVSSXwb+6bzzDJZJVhySWWjSWS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I83YE3RXwci3ILQ2uIgKKUVMxvdVZIO4W6iI2rtYca4AOYj/CFQyPnCzMLulWAtLE
	 alPFIlByK/LOg67oqx9q/Ryq4EOOneHVdKHtb6DIE92Yz07mDAOsE44ME/mzbajB4P
	 Q/caBaghnk8X/bJ5jfPbwXbBXgrrli+8HgPoghioaaDuiKAN0SskYfVQwP1Enwvngj
	 psQ9EG9bjRr1IJAiSbkUcXrFgSyv70W+nzn0UmwEusLA0kGKBEHlHZq9pknj4AypJ7
	 343TPtJ4AA4RnurXLInC2IMx3WdQRUatv3PTsR25CpGJHz+GVx1rolTIUFQ+wqwtlO
	 +C/VylFZzLJ+Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA978378209A;
	Mon, 25 Mar 2024 13:05:48 +0000 (UTC)
Message-ID: <a6f54fdf-f0a9-4edc-9054-50d5204a6898@collabora.com>
Date: Mon, 25 Mar 2024 14:05:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: mediatek: pm-domains: support smi clamp
 protection
To: "yu-chang.lee" <yu-chang.lee@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, mandyjh.liu@mediatek.com,
 fan.chen@mediatek.com, xiufeng.li@mediatek.com
References: <20240325121908.3958-1-yu-chang.lee@mediatek.com>
 <20240325121908.3958-3-yu-chang.lee@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240325121908.3958-3-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/03/24 13:19, yu-chang.lee ha scritto:
> In order to avoid power glitch, this patch use smi clamp
> to disable/enable smi common port.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
> ---
>   drivers/pmdomain/mediatek/mt8188-pm-domains.h |  41 ++++-
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    | 147 ++++++++++++++----
>   drivers/pmdomain/mediatek/mtk-pm-domains.h    |   1 +
>   3 files changed, 156 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> index 7bbba4d56a77..39f057dca92c 100644
> --- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> @@ -573,6 +573,18 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   		.pwr_sta2nd_offs = 0x170,
>   		.sram_pdn_bits = BIT(8),
>   		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(SMI,
> +				    MT8188_SMI_COMMON_SMI_CLAMP_DIP_TO_VDO0,
> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
> +			BUS_PROT_WR(SMI,
> +				    MT8188_SMI_COMMON_SMI_CLAMP_DIP_TO_VPP1,
> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
> +		},
>   		.reset_smi = {
>   			SMI_RESET_WR(MT8188_SMI_LARB10_RESET,
>   				     MT8188_SMI_LARB10_RESET_ADDR),
> @@ -585,7 +597,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   			SMI_RESET_WR(MT8188_SMI_LARB15_RESET,
>   				     MT8188_SMI_LARB15_RESET_ADDR),
>   		},
> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
>   	},
>   	[MT8188_POWER_DOMAIN_IPE] = {
>   		.name = "ipe",
> @@ -595,11 +607,18 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   		.pwr_sta2nd_offs = 0x170,
>   		.sram_pdn_bits = BIT(8),
>   		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(SMI,
> +				    MT8188_SMI_COMMON_SMI_CLAMP_IPE_TO_VPP1,
> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
> +		},
>   		.reset_smi = {
>   			SMI_RESET_WR(MT8188_SMI_LARB12_RESET,
>   				     MT8188_SMI_LARB12_RESET_ADDR),
>   		},
> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
>   	},
>   	[MT8188_POWER_DOMAIN_CAM_VCORE] = {
>   		.name = "cam_vcore",
> @@ -676,13 +695,20 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   		.pwr_sta2nd_offs = 0x170,
>   		.sram_pdn_bits = BIT(8),
>   		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(SMI,
> +				    MT8188_SMI_COMMON_SMI_CLAMP_IPE_TO_VPP1,
> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
> +		},
>   		.reset_smi = {
>   			SMI_RESET_WR(MT8188_SMI_LARB16A_RESET,
>   				     MT8188_SMI_LARB16A_RESET_ADDR),
>   			SMI_RESET_WR(MT8188_SMI_LARB17A_RESET,
>   				     MT8188_SMI_LARB17A_RESET_ADDR),
>   		},
> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
>   	},
>   	[MT8188_POWER_DOMAIN_CAM_SUBB] = {
>   		.name = "cam_subb",
> @@ -692,13 +718,20 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>   		.pwr_sta2nd_offs = 0x170,
>   		.sram_pdn_bits = BIT(8),
>   		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(SMI,
> +				    MT8188_SMI_COMMON_SMI_CLAMP_CAM_SUBB_TO_VDO0,
> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
> +		},
>   		.reset_smi = {
>   			SMI_RESET_WR(MT8188_SMI_LARB16B_RESET,
>   				     MT8188_SMI_LARB16B_RESET_ADDR),
>   			SMI_RESET_WR(MT8188_SMI_LARB17B_RESET,
>   				     MT8188_SMI_LARB17B_RESET_ADDR),
>   		},
> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
>   	},
>   };
>   
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 9ab6fa105c8c..3c797e136c0e 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -47,9 +47,10 @@ struct scpsys_domain {
>   	struct clk_bulk_data *subsys_clks;
>   	struct regmap *infracfg_nao;
>   	struct regmap *infracfg;
> -	struct regmap *smi;
> +	struct regmap **smi;
>   	struct regmap **larb;
>   	int num_larb;
> +	int num_smi;
>   	struct regulator *supply;
>   };
>   
> @@ -122,29 +123,19 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>   					MTK_POLL_TIMEOUT);
>   }
>   
> -static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
> -						    const struct scpsys_bus_prot_data *bpd)
> -{
> -	if (bpd->flags & BUS_PROT_COMPONENT_SMI)
> -		return pd->smi;
> -	else
> -		return pd->infracfg;
> -}
> -
>   static struct regmap *scpsys_bus_protect_get_sta_regmap(struct scpsys_domain *pd,
>   							const struct scpsys_bus_prot_data *bpd)
>   {
>   	if (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO)
>   		return pd->infracfg_nao;
>   	else
> -		return scpsys_bus_protect_get_regmap(pd, bpd);
> +		return pd->infracfg;
>   }
>   
>   static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
> -				    const struct scpsys_bus_prot_data *bpd)
> +				    const struct scpsys_bus_prot_data *bpd,
> +					struct regmap *sta_regmap, struct regmap *regmap)
>   {
> -	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
> -	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
>   	u32 sta_mask = bpd->bus_prot_sta_mask;
>   	u32 expected_ack;
>   	u32 val;
> @@ -165,10 +156,9 @@ static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
>   }
>   
>   static int scpsys_bus_protect_set(struct scpsys_domain *pd,
> -				  const struct scpsys_bus_prot_data *bpd)
> +				  const struct scpsys_bus_prot_data *bpd,
> +				  struct regmap *sta_regmap, struct regmap *regmap)
>   {
> -	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
> -	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
>   	u32 sta_mask = bpd->bus_prot_sta_mask;
>   	u32 val;
>   
> @@ -182,19 +172,32 @@ static int scpsys_bus_protect_set(struct scpsys_domain *pd,
>   					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   }
>   
> -static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
> +static int _scpsys_clamp_bus_protection_enable(struct scpsys_domain *pd, bool is_smi)
>   {
> +	int smi_count = 0;
> +
>   	for (int i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
>   		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
> +		struct regmap *sta_regmap, *regmap;
> +		bool is_smi = bpd->flags & BUS_PROT_COMPONENT_SMI;
>   		int ret;
>   
>   		if (!bpd->bus_prot_set_clr_mask)
>   			break;
>   
> +		if (is_smi) {
> +			sta_regmap = pd->smi[smi_count];
> +			regmap = pd->smi[smi_count];
> +			smi_count++;
> +		} else {
> +			sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
> +			regmap = pd->infracfg;
> +		}
> +
>   		if (bpd->flags & BUS_PROT_INVERTED)
> -			ret = scpsys_bus_protect_clear(pd, bpd);
> +			ret = scpsys_bus_protect_clear(pd, bpd, sta_regmap, regmap);
>   		else
> -			ret = scpsys_bus_protect_set(pd, bpd);
> +			ret = scpsys_bus_protect_set(pd, bpd, sta_regmap, regmap);
>   		if (ret)
>   			return ret;
>   	}
> @@ -202,19 +205,32 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>   	return 0;
>   }
>   
> -static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> +static int _scpsys_clamp_bus_protection_disable(struct scpsys_domain *pd, bool is_smi)
>   {
> +	int smi_count = pd->num_smi - 1;
> +
>   	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
>   		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
> +		struct regmap *sta_regmap, *regmap;
> +		bool is_smi = bpd->flags & BUS_PROT_COMPONENT_SMI;
>   		int ret;
>   
>   		if (!bpd->bus_prot_set_clr_mask)
>   			continue;
>   
> +		if (is_smi) {
> +			sta_regmap = pd->smi[smi_count];
> +			regmap = pd->smi[smi_count];
> +			smi_count--;
> +		} else {
> +			sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
> +			regmap = pd->infracfg;
> +		}
> +
>   		if (bpd->flags & BUS_PROT_INVERTED)
> -			ret = scpsys_bus_protect_set(pd, bpd);
> +			ret = scpsys_bus_protect_set(pd, bpd, sta_regmap, regmap);
>   		else
> -			ret = scpsys_bus_protect_clear(pd, bpd);
> +			ret = scpsys_bus_protect_clear(pd, bpd, sta_regmap, regmap);
>   		if (ret)
>   			return ret;
>   	}
> @@ -222,6 +238,50 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>   	return 0;
>   }
>   
> +static int scpsys_clamp_protection(struct scpsys_domain *pd)
> +{
> +	int ret;
> +

You can directly call _scpsys_clamp_bus_protection_enable(), no need for a helper.

> +	ret = _scpsys_clamp_bus_protection_enable(pd, true);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int scpsys_clamp_protection_disable(struct scpsys_domain *pd)
> +{
> +	int ret;
> +
> +	ret = _scpsys_clamp_bus_protection_disable(pd, true);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int scpsys_bus_protect_enable(struct scpsys_domain *pd)

Unused function, please remove.

> +{
> +	int ret;
> +
> +	ret = _scpsys_clamp_bus_protection_enable(pd, false);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> +{

Unused function, please remove.

> +	int ret;
> +
> +	ret = _scpsys_clamp_bus_protection_disable(pd, false);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static int scpsys_regulator_enable(struct regulator *supply)
>   {
>   	return supply ? regulator_enable(supply) : 0;
> @@ -272,6 +332,12 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	bool tmp;
>   	int ret;
>   
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
> +		ret = scpsys_clamp_protection(pd);

		ret = scpsys_clamp_bus_protection_enable(pd, true);

> +		if (ret)
> +			return ret;
> +	}
> +
>   	ret = scpsys_regulator_enable(pd->supply);
>   	if (ret)
>   		return ret;
> @@ -318,6 +384,12 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	if (ret < 0)
>   		goto err_disable_subsys_clks;
>   
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
> +		ret = scpsys_clamp_protection_disable(pd);

		ret = scpsys_clamp_bus_protection_disable(pd, true);

> +		if (ret)
> +			return ret;
> +	}
> +
>   	ret = scpsys_bus_protect_disable(pd);
>   	if (ret < 0)
>   		goto err_disable_sram;
> @@ -353,6 +425,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	bool tmp;
>   	int ret;
>   
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
> +		ret = scpsys_clamp_protection(pd);

ret = scpsys_clamp_bus_protection_enable(pd, true);

> +		if (ret)
> +			return ret;
> +	}
> +
>   	ret = scpsys_bus_protect_enable(pd);
>   	if (ret < 0)
>   		return ret;

Regards,
Angelo



