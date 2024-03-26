Return-Path: <linux-kernel+bounces-119101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F15288C42E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E71F34528
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB520757FD;
	Tue, 26 Mar 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oifsG60z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F3125C9;
	Tue, 26 Mar 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461430; cv=none; b=rDpIbqHV1GV7WxXKywFweRdNctvsy+qMZH4Zpyq4zfY3mhpGZB0EZ9wPS3GESZYHXqEANAoaeDBp0xoAeaj7jd/gaowlej9JyytwLYNzcg0lJdcZRYAdzGIqY+jNaDL+/0krF0AnvVBtPPU9bkZL+HgS7DPoeckGQvtlsDkdnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461430; c=relaxed/simple;
	bh=8+UkfQFcSGx7Ny6yQMpzS+qDlr7otfWIYw6zuYufEKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYIjT+EVCcJnAeU10uZwLBEeG4RWFUelEJvmNai5Wq+uMkLU5V9Jcl0NPDula7YHjLtXWaCyQ3z8gFfa31Qus8Mr/WqF83dtMGQ7HBWlxHsn9pxAMot7V4Coqnepty2lMem+lAOwsuhJo5GFlUSRIdHPeX8EaK9e0DFiwGOMM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oifsG60z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711461427;
	bh=8+UkfQFcSGx7Ny6yQMpzS+qDlr7otfWIYw6zuYufEKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oifsG60zOHSKEobk5bJ5iEvHc7XpGbb7rkWJyOq0MykFhb0aOPwA8/7HSRYmhAgTB
	 +P9+wxtjg89937bURMkE75oNJCBLf97Ujh7d6SZeblqYvporXF5nOTwlZOFlVRZWgs
	 vmC8G6xQDyAOlAJPQc89A6aK1/XZBl9B64TUkAYgcCc6dr9MbIGMRK8ZOcYGhrWYCN
	 Zp4c9py+DqoM2cB+EbGFj8nGaVadyk+UZRiKHfae0yt6Rl/hbYavRw7GiwassVFEf+
	 kEihc3RTDAP2PQMZ7mHve5pvltCFNI4tBW2J2v0kzfH/jAJDmwS+8Ihpb2+R8ZqMkT
	 azCHOTiWpve3A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 739A537813D7;
	Tue, 26 Mar 2024 13:57:06 +0000 (UTC)
Message-ID: <dbf2b658-43c2-4994-81f9-24fb82d108a2@collabora.com>
Date: Tue, 26 Mar 2024 14:57:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: mediatek: pm-domains: support smi clamp
 protection
To: =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 =?UTF-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 =?UTF-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?= <Xiufeng.Li@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?=
 <fan.chen@mediatek.com>
References: <20240325121908.3958-1-yu-chang.lee@mediatek.com>
 <20240325121908.3958-3-yu-chang.lee@mediatek.com>
 <a6f54fdf-f0a9-4edc-9054-50d5204a6898@collabora.com>
 <c0086465922ec54bed17cee7b9e87d224240f21a.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <c0086465922ec54bed17cee7b9e87d224240f21a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/03/24 03:00, Yu-chang Lee (李禹璋) ha scritto:
> On Mon, 2024-03-25 at 14:05 +0100, AngeloGioacchino Del Regno wrote:
>> Il 25/03/24 13:19, yu-chang.lee ha scritto:
>>> In order to avoid power glitch, this patch use smi clamp
>>> to disable/enable smi common port.
>>>
>>> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
>>> ---
>>>    drivers/pmdomain/mediatek/mt8188-pm-domains.h |  41 ++++-
>>>    drivers/pmdomain/mediatek/mtk-pm-domains.c    | 147
>>> ++++++++++++++----
>>>    drivers/pmdomain/mediatek/mtk-pm-domains.h    |   1 +
>>>    3 files changed, 156 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
>>> b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
>>> index 7bbba4d56a77..39f057dca92c 100644
>>> --- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
>>> +++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
>>> @@ -573,6 +573,18 @@ static const struct scpsys_domain_data
>>> scpsys_domain_data_mt8188[] = {
>>>    		.pwr_sta2nd_offs = 0x170,
>>>    		.sram_pdn_bits = BIT(8),
>>>    		.sram_pdn_ack_bits = BIT(12),
>>> +		.bp_cfg = {
>>> +			BUS_PROT_WR(SMI,
>>> +				    MT8188_SMI_COMMON_SMI_CLAMP_DIP_TO_
>>> VDO0,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
>>> +			BUS_PROT_WR(SMI,
>>> +				    MT8188_SMI_COMMON_SMI_CLAMP_DIP_TO_
>>> VPP1,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
>>> +		},
>>>    		.reset_smi = {
>>>    			SMI_RESET_WR(MT8188_SMI_LARB10_RESET,
>>>    				     MT8188_SMI_LARB10_RESET_ADDR),
>>> @@ -585,7 +597,7 @@ static const struct scpsys_domain_data
>>> scpsys_domain_data_mt8188[] = {
>>>    			SMI_RESET_WR(MT8188_SMI_LARB15_RESET,
>>>    				     MT8188_SMI_LARB15_RESET_ADDR),
>>>    		},
>>> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>>> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF |
>>> MTK_SCPD_CLAMP_PROTECTION,
>>>    	},
>>>    	[MT8188_POWER_DOMAIN_IPE] = {
>>>    		.name = "ipe",
>>> @@ -595,11 +607,18 @@ static const struct scpsys_domain_data
>>> scpsys_domain_data_mt8188[] = {
>>>    		.pwr_sta2nd_offs = 0x170,
>>>    		.sram_pdn_bits = BIT(8),
>>>    		.sram_pdn_ack_bits = BIT(12),
>>> +		.bp_cfg = {
>>> +			BUS_PROT_WR(SMI,
>>> +				    MT8188_SMI_COMMON_SMI_CLAMP_IPE_TO_
>>> VPP1,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
>>> +		},
>>>    		.reset_smi = {
>>>    			SMI_RESET_WR(MT8188_SMI_LARB12_RESET,
>>>    				     MT8188_SMI_LARB12_RESET_ADDR),
>>>    		},
>>> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>>> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF |
>>> MTK_SCPD_CLAMP_PROTECTION,
>>>    	},
>>>    	[MT8188_POWER_DOMAIN_CAM_VCORE] = {
>>>    		.name = "cam_vcore",
>>> @@ -676,13 +695,20 @@ static const struct scpsys_domain_data
>>> scpsys_domain_data_mt8188[] = {
>>>    		.pwr_sta2nd_offs = 0x170,
>>>    		.sram_pdn_bits = BIT(8),
>>>    		.sram_pdn_ack_bits = BIT(12),
>>> +		.bp_cfg = {
>>> +			BUS_PROT_WR(SMI,
>>> +				    MT8188_SMI_COMMON_SMI_CLAMP_IPE_TO_
>>> VPP1,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
>>> +		},
>>>    		.reset_smi = {
>>>    			SMI_RESET_WR(MT8188_SMI_LARB16A_RESET,
>>>    				     MT8188_SMI_LARB16A_RESET_ADDR),
>>>    			SMI_RESET_WR(MT8188_SMI_LARB17A_RESET,
>>>    				     MT8188_SMI_LARB17A_RESET_ADDR),
>>>    		},
>>> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>>> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF |
>>> MTK_SCPD_CLAMP_PROTECTION,
>>>    	},
>>>    	[MT8188_POWER_DOMAIN_CAM_SUBB] = {
>>>    		.name = "cam_subb",
>>> @@ -692,13 +718,20 @@ static const struct scpsys_domain_data
>>> scpsys_domain_data_mt8188[] = {
>>>    		.pwr_sta2nd_offs = 0x170,
>>>    		.sram_pdn_bits = BIT(8),
>>>    		.sram_pdn_ack_bits = BIT(12),
>>> +		.bp_cfg = {
>>> +			BUS_PROT_WR(SMI,
>>> +				    MT8188_SMI_COMMON_SMI_CLAMP_CAM_SUB
>>> B_TO_VDO0,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_SET,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
>>> +				    MT8188_SMI_COMMON_CLAMP_EN_STA),
>>> +		},
>>>    		.reset_smi = {
>>>    			SMI_RESET_WR(MT8188_SMI_LARB16B_RESET,
>>>    				     MT8188_SMI_LARB16B_RESET_ADDR),
>>>    			SMI_RESET_WR(MT8188_SMI_LARB17B_RESET,
>>>    				     MT8188_SMI_LARB17B_RESET_ADDR),
>>>    		},
>>> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>>> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF |
>>> MTK_SCPD_CLAMP_PROTECTION,
>>>    	},
>>>    };
>>>    
>>> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c
>>> b/drivers/pmdomain/mediatek/mtk-pm-domains.c
>>> index 9ab6fa105c8c..3c797e136c0e 100644
>>> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
>>> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
>>> @@ -47,9 +47,10 @@ struct scpsys_domain {
>>>    	struct clk_bulk_data *subsys_clks;
>>>    	struct regmap *infracfg_nao;
>>>    	struct regmap *infracfg;
>>> -	struct regmap *smi;
>>> +	struct regmap **smi;
>>>    	struct regmap **larb;
>>>    	int num_larb;
>>> +	int num_smi;
>>>    	struct regulator *supply;
>>>    };
>>>    
>>> @@ -122,29 +123,19 @@ static int scpsys_sram_disable(struct
>>> scpsys_domain *pd)
>>>    					MTK_POLL_TIMEOUT);
>>>    }
>>>    
>>> -static struct regmap *scpsys_bus_protect_get_regmap(struct
>>> scpsys_domain *pd,
>>> -						    const struct
>>> scpsys_bus_prot_data *bpd)
>>> -{
>>> -	if (bpd->flags & BUS_PROT_COMPONENT_SMI)
>>> -		return pd->smi;
>>> -	else
>>> -		return pd->infracfg;
>>> -}
>>> -
>>>    static struct regmap *scpsys_bus_protect_get_sta_regmap(struct
>>> scpsys_domain *pd,
>>>    							const struct
>>> scpsys_bus_prot_data *bpd)
>>>    {
>>>    	if (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO)
>>>    		return pd->infracfg_nao;
>>>    	else
>>> -		return scpsys_bus_protect_get_regmap(pd, bpd);
>>> +		return pd->infracfg;
>>>    }
>>>    
>>>    static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
>>> -				    const struct scpsys_bus_prot_data
>>> *bpd)
>>> +				    const struct scpsys_bus_prot_data
>>> *bpd,
>>> +					struct regmap *sta_regmap,
>>> struct regmap *regmap)
>>>    {
>>> -	struct regmap *sta_regmap =
>>> scpsys_bus_protect_get_sta_regmap(pd, bpd);
>>> -	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
>>>    	u32 sta_mask = bpd->bus_prot_sta_mask;
>>>    	u32 expected_ack;
>>>    	u32 val;
>>> @@ -165,10 +156,9 @@ static int scpsys_bus_protect_clear(struct
>>> scpsys_domain *pd,
>>>    }
>>>    
>>>    static int scpsys_bus_protect_set(struct scpsys_domain *pd,
>>> -				  const struct scpsys_bus_prot_data
>>> *bpd)
>>> +				  const struct scpsys_bus_prot_data
>>> *bpd,
>>> +				  struct regmap *sta_regmap, struct
>>> regmap *regmap)
>>>    {
>>> -	struct regmap *sta_regmap =
>>> scpsys_bus_protect_get_sta_regmap(pd, bpd);
>>> -	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
>>>    	u32 sta_mask = bpd->bus_prot_sta_mask;
>>>    	u32 val;
>>>    
>>> @@ -182,19 +172,32 @@ static int scpsys_bus_protect_set(struct
>>> scpsys_domain *pd,
>>>    					MTK_POLL_DELAY_US,
>>> MTK_POLL_TIMEOUT);
>>>    }
>>>    
>>> -static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>>> +static int _scpsys_clamp_bus_protection_enable(struct
>>> scpsys_domain *pd, bool is_smi)
>>>    {
>>> +	int smi_count = 0;
>>> +
>>>    	for (int i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
>>>    		const struct scpsys_bus_prot_data *bpd = &pd->data-
>>>> bp_cfg[i];
>>> +		struct regmap *sta_regmap, *regmap;
>>> +		bool is_smi = bpd->flags & BUS_PROT_COMPONENT_SMI;
>>>    		int ret;
>>>    
>>>    		if (!bpd->bus_prot_set_clr_mask)
>>>    			break;
>>>    
>>> +		if (is_smi) {
>>> +			sta_regmap = pd->smi[smi_count];
>>> +			regmap = pd->smi[smi_count];
>>> +			smi_count++;
>>> +		} else {
>>> +			sta_regmap =
>>> scpsys_bus_protect_get_sta_regmap(pd, bpd);
>>> +			regmap = pd->infracfg;
>>> +		}
>>> +
>>>    		if (bpd->flags & BUS_PROT_INVERTED)
>>> -			ret = scpsys_bus_protect_clear(pd, bpd);
>>> +			ret = scpsys_bus_protect_clear(pd, bpd,
>>> sta_regmap, regmap);
>>>    		else
>>> -			ret = scpsys_bus_protect_set(pd, bpd);
>>> +			ret = scpsys_bus_protect_set(pd, bpd,
>>> sta_regmap, regmap);
>>>    		if (ret)
>>>    			return ret;
>>>    	}
>>> @@ -202,19 +205,32 @@ static int scpsys_bus_protect_enable(struct
>>> scpsys_domain *pd)
>>>    	return 0;
>>>    }
>>>    
>>> -static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>>> +static int _scpsys_clamp_bus_protection_disable(struct
>>> scpsys_domain *pd, bool is_smi)
>>>    {
>>> +	int smi_count = pd->num_smi - 1;
>>> +
>>>    	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
>>>    		const struct scpsys_bus_prot_data *bpd = &pd->data-
>>>> bp_cfg[i];
>>> +		struct regmap *sta_regmap, *regmap;
>>> +		bool is_smi = bpd->flags & BUS_PROT_COMPONENT_SMI;
>>>    		int ret;
>>>    
>>>    		if (!bpd->bus_prot_set_clr_mask)
>>>    			continue;
>>>    
>>> +		if (is_smi) {
>>> +			sta_regmap = pd->smi[smi_count];
>>> +			regmap = pd->smi[smi_count];
>>> +			smi_count--;
>>> +		} else {
>>> +			sta_regmap =
>>> scpsys_bus_protect_get_sta_regmap(pd, bpd);
>>> +			regmap = pd->infracfg;
>>> +		}
>>> +
>>>    		if (bpd->flags & BUS_PROT_INVERTED)
>>> -			ret = scpsys_bus_protect_set(pd, bpd);
>>> +			ret = scpsys_bus_protect_set(pd, bpd,
>>> sta_regmap, regmap);
>>>    		else
>>> -			ret = scpsys_bus_protect_clear(pd, bpd);
>>> +			ret = scpsys_bus_protect_clear(pd, bpd,
>>> sta_regmap, regmap);
>>>    		if (ret)
>>>    			return ret;
>>>    	}
>>> @@ -222,6 +238,50 @@ static int scpsys_bus_protect_disable(struct
>>> scpsys_domain *pd)
>>>    	return 0;
>>>    }
>>>    
>>> +static int scpsys_clamp_protection(struct scpsys_domain *pd)
>>> +{
>>> +	int ret;
>>> +
>>
>> You can directly call _scpsys_clamp_bus_protection_enable(), no need
>> for a helper.
>>
>>> +	ret = _scpsys_clamp_bus_protection_enable(pd, true);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int scpsys_clamp_protection_disable(struct scpsys_domain
>>> *pd)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = _scpsys_clamp_bus_protection_disable(pd, true);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>>
>> Unused function, please remove.
> 
> I think this is used in scpsys_power_off function. Do you mean I
> should directly call _scpsys_clamp_bus_protection_disable?
> 

Yes, please.

Cheers,
Angelo



