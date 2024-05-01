Return-Path: <linux-kernel+bounces-165616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38468B8EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C071F25458
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6AE8BE5;
	Wed,  1 May 2024 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="enpsAi5z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE814AA9;
	Wed,  1 May 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582588; cv=none; b=MbyrRfR9rJZ3//rAY2uAPymy7CwZoXozmLZvnOAt05dfkkAfy5qNrXrNB2bCHqNFbYsUsmkTqaRlgKMDslcOVVxe7nWR62SzzHdLM4/2z6x4OEqCuvZ3l0MxMkt2cgE0H1JNFD3ajZTkBxfq1x5vm3NgO8pRnY5p7cwkKqDoVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582588; c=relaxed/simple;
	bh=iHONaipDZvD1UONRD53f+sGCw/JieXKbbi/QZKqSAs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RG+lVuRAU15MMvXqdEvszMdjFehP3r7fr2hM1r3RMBvN9GUeDRdYuJ4lX9QfS6Db6gcAe2J/fPs8cgweg0etEvyKkPOL/cokkzeNQHOaL9iotDrTBnJ8BME9jas0VuD+SImYwC+VIhFc+XN/nRq2RBBkdtI/GYaBEwx3IASe16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=enpsAi5z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 441BTb9P013641;
	Wed, 1 May 2024 16:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zECWYs05JeHQyldYsuxmYeYOcdkDI5KRvYBTnkbeCqI=; b=en
	psAi5zalBDvJgRF+vd1QJ1qOXBJzhUOU+VkXHQUqtWtWWB+Z030J/voa4wrny1yP
	Af3twHk5XiyG5qJHtGd94JY8pmGP1t2oL6P9qnUA/2Ub7ae6SM3RhIXi1FxZdAZw
	wnb3vM2+ohFJT5WQNJD1NYJ3QRzQ1gxqt2x1zMv4KshkVVNAhsr/iAqVTSuXJWPJ
	QIZdVJliBDnazPocrrxomq29lXcrWJDWvClVUM+IJxOym0f0KtzZl1jNlPgSGWQI
	cK8AZ5XmoqGKIHMFYJGTiULBius/6G1vIVjoRJhIciRM1e4y/WVuKm/XXV/1Y+hb
	5c2aLRI14XVBHPibjh7g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xud769ekv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 16:56:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 441GuG0B012422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 16:56:16 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 1 May 2024
 09:56:15 -0700
Message-ID: <6336ffc7-d8ae-4cfd-8b66-d6d91cb0d15e@quicinc.com>
Date: Wed, 1 May 2024 09:56:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix remapped ce accessing issue on 64bit OS
Content-Language: en-US
To: Ziyang Huang <hzyitc@outlook.com>, <kvalo@kernel.org>
CC: <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <TYZPR01MB55563B3A689D54D18179E5B4C9192@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <TYZPR01MB55563B3A689D54D18179E5B4C9192@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 38OiJVixgv5rWFUfIZneDCxNTfaV8S1z
X-Proofpoint-GUID: 38OiJVixgv5rWFUfIZneDCxNTfaV8S1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405010119

On 5/1/2024 9:14 AM, Ziyang Huang wrote:
> On 64bit OS, when ab->mem_ce is lower than or 4G far away from ab->mem,
> u32 is not enough to store the offsets, which makes ath11k_ahb_read32()
> and ath11k_ahb_write32() access incorrect address and causes Data Abort
> Exception.

Are you actually observing this issue?
Or is this a hypothetical situation?

> 
> Let's use the high bits of offsets to decide where to access, which is
> similar as ath11k_pci_get_window_start() done. In the future, we can merge
> these functions for unified regs accessing.

Performing unnecessary tests and masking for every ioread/write operation will
potentially impact performance.

What other fixes were considered (i.e. did you consider making all the
register addresses u64?)

> 
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 34 ++++++++++++++++++++-------
>  drivers/net/wireless/ath/ath11k/hal.c | 17 +++++---------
>  drivers/net/wireless/ath/ath11k/hw.c  | 14 +++++------
>  drivers/net/wireless/ath/ath11k/hw.h  |  7 +++++-
>  4 files changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 7c0a23517949..9e59b4de93a9 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -198,12 +198,30 @@ static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
>  
>  static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
>  {
> -	return ioread32(ab->mem + offset);
> +	switch (offset & ATH11K_REG_TYPE_MASK) {
> +	case ATH11K_REG_TYPE_NORMAL:
> +		return ioread32(ab->mem + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
> +	case ATH11K_REG_TYPE_CE:
> +		return ioread32(ab->mem_ce + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
> +	default:
> +		BUG();

you can WARN but you can't BUG (and even WARN is being discouraged)

> +		return 0;
> +	}
>  }
>  
>  static inline void ath11k_ahb_write32(struct ath11k_base *ab, u32 offset, u32 value)
>  {
> -	iowrite32(value, ab->mem + offset);
> +	switch (offset & ATH11K_REG_TYPE_MASK) {
> +	case ATH11K_REG_TYPE_NORMAL:
> +		iowrite32(value, ab->mem + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
> +		break;
> +	case ATH11K_REG_TYPE_CE:
> +		iowrite32(value, ab->mem_ce + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
> +		break;
> +	default:
> +		BUG();

ditto

> +		break;
> +	}
>  }
>  
>  static void ath11k_ahb_kill_tasklets(struct ath11k_base *ab)
> @@ -275,9 +293,9 @@ static void ath11k_ahb_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
>  	const struct ce_ie_addr *ce_ie_addr = ab->hw_params.ce_ie_addr;
>  	u32 ie1_reg_addr, ie2_reg_addr, ie3_reg_addr;
>  
> -	ie1_reg_addr = ce_ie_addr->ie1_reg_addr + ATH11K_CE_OFFSET(ab);
> -	ie2_reg_addr = ce_ie_addr->ie2_reg_addr + ATH11K_CE_OFFSET(ab);
> -	ie3_reg_addr = ce_ie_addr->ie3_reg_addr + ATH11K_CE_OFFSET(ab);
> +	ie1_reg_addr = ce_ie_addr->ie1_reg_addr;
> +	ie2_reg_addr = ce_ie_addr->ie2_reg_addr;
> +	ie3_reg_addr = ce_ie_addr->ie3_reg_addr;
>  
>  	ce_attr = &ab->hw_params.host_ce_config[ce_id];
>  	if (ce_attr->src_nentries)
> @@ -296,9 +314,9 @@ static void ath11k_ahb_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
>  	const struct ce_ie_addr *ce_ie_addr = ab->hw_params.ce_ie_addr;
>  	u32 ie1_reg_addr, ie2_reg_addr, ie3_reg_addr;
>  
> -	ie1_reg_addr = ce_ie_addr->ie1_reg_addr + ATH11K_CE_OFFSET(ab);
> -	ie2_reg_addr = ce_ie_addr->ie2_reg_addr + ATH11K_CE_OFFSET(ab);
> -	ie3_reg_addr = ce_ie_addr->ie3_reg_addr + ATH11K_CE_OFFSET(ab);
> +	ie1_reg_addr = ce_ie_addr->ie1_reg_addr;
> +	ie2_reg_addr = ce_ie_addr->ie2_reg_addr;
> +	ie3_reg_addr = ce_ie_addr->ie3_reg_addr;
>  
>  	ce_attr = &ab->hw_params.host_ce_config[ce_id];
>  	if (ce_attr->src_nentries)
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index f3d04568c221..f9ba2f821108 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1233,20 +1233,16 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
>  	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
>  
>  	s = &hal->srng_config[HAL_CE_SRC];
> -	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB +
> -		ATH11K_CE_OFFSET(ab);
> -	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP +
> -		ATH11K_CE_OFFSET(ab);
> +	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
> +	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
>  	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
>  		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
>  	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
>  		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
>  
>  	s = &hal->srng_config[HAL_CE_DST];
> -	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB +
> -		ATH11K_CE_OFFSET(ab);
> -	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP +
> -		ATH11K_CE_OFFSET(ab);
> +	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
> +	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
>  	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
>  		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
>  	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
> @@ -1254,9 +1250,8 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
>  
>  	s = &hal->srng_config[HAL_CE_DST_STATUS];
>  	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
> -		HAL_CE_DST_STATUS_RING_BASE_LSB + ATH11K_CE_OFFSET(ab);
> -	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP +
> -		ATH11K_CE_OFFSET(ab);
> +		HAL_CE_DST_STATUS_RING_BASE_LSB;
> +	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
>  	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
>  		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
>  	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
> diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
> index caa6dc12a790..58f39a7eaa1c 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.c
> +++ b/drivers/net/wireless/ath/ath11k/hw.c
> @@ -2268,9 +2268,9 @@ const struct ce_ie_addr ath11k_ce_ie_addr_ipq8074 = {
>  };
>  
>  const struct ce_ie_addr ath11k_ce_ie_addr_ipq5018 = {
> -	.ie1_reg_addr = CE_HOST_IPQ5018_IE_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
> -	.ie2_reg_addr = CE_HOST_IPQ5018_IE_2_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
> -	.ie3_reg_addr = CE_HOST_IPQ5018_IE_3_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
> +	.ie1_reg_addr = ATH11K_REG_TYPE_CE + CE_HOST_IPQ5018_IE_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
> +	.ie2_reg_addr = ATH11K_REG_TYPE_CE + CE_HOST_IPQ5018_IE_2_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
> +	.ie3_reg_addr = ATH11K_REG_TYPE_CE + CE_HOST_IPQ5018_IE_3_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
>  };
>  
>  const struct ce_remap ath11k_ce_remap_ipq5018 = {
> @@ -2801,13 +2801,13 @@ const struct ath11k_hw_regs ipq5018_regs = {
>  	.hal_reo_status_hp = 0x00003070,
>  
>  	/* WCSS relative address */
> -	.hal_seq_wcss_umac_ce0_src_reg = 0x08400000
> +	.hal_seq_wcss_umac_ce0_src_reg = ATH11K_REG_TYPE_CE + 0x08400000
>  		- HAL_IPQ5018_CE_WFSS_REG_BASE,
> -	.hal_seq_wcss_umac_ce0_dst_reg = 0x08401000
> +	.hal_seq_wcss_umac_ce0_dst_reg = ATH11K_REG_TYPE_CE + 0x08401000
>  		- HAL_IPQ5018_CE_WFSS_REG_BASE,
> -	.hal_seq_wcss_umac_ce1_src_reg = 0x08402000
> +	.hal_seq_wcss_umac_ce1_src_reg = ATH11K_REG_TYPE_CE + 0x08402000
>  		- HAL_IPQ5018_CE_WFSS_REG_BASE,
> -	.hal_seq_wcss_umac_ce1_dst_reg = 0x08403000
> +	.hal_seq_wcss_umac_ce1_dst_reg = ATH11K_REG_TYPE_CE + 0x08403000
>  		- HAL_IPQ5018_CE_WFSS_REG_BASE,
>  
>  	/* WBM Idle address */
> diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
> index 14ef4eb48f80..44593b38fc85 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.h
> +++ b/drivers/net/wireless/ath/ath11k/hw.h
> @@ -81,7 +81,12 @@
>  #define ATH11K_M3_FILE			"m3.bin"
>  #define ATH11K_REGDB_FILE_NAME		"regdb.bin"
>  
> -#define ATH11K_CE_OFFSET(ab)	(ab->mem_ce - ab->mem)
> +#define ATH11K_REG_TYPE_MASK		GENMASK(31, 28)
> +#define  ATH11K_REG_TYPE(x)		FIELD_PREP_CONST(ATH11K_REG_TYPE_MASK, x)
> +#define  ATH11K_REG_TYPE_NORMAL		ATH11K_REG_TYPE(0)
> +#define  ATH11K_REG_TYPE_DP		ATH11K_REG_TYPE(1)
> +#define  ATH11K_REG_TYPE_CE		ATH11K_REG_TYPE(2)
> +#define ATH11K_REG_OFFSET_MASK		GENMASK(27, 0)
>  
>  enum ath11k_hw_rate_cck {
>  	ATH11K_HW_RATE_CCK_LP_11M = 0,


