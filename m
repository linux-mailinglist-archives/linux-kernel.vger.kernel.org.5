Return-Path: <linux-kernel+bounces-53199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E584A208
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0C11C232AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E979481D8;
	Mon,  5 Feb 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JbYbP1uD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535247F67;
	Mon,  5 Feb 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157394; cv=none; b=GN48K6Who8R9hXVnbrW1sEaJorPHhAnW4c3ROsv4pJ0TkB0xOMv2dGsQt+RPv/rPxsAZ5iCKcmm8TvEueJYmQcKmDmvjKghm0mOsQ+HiM888HvwFPnMCgGFBU9ni5qH3UdqvCA2fvVmYeFu1a2o7uhscG+HymSehgsBCB0rcvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157394; c=relaxed/simple;
	bh=1IgCSO5fXyYE52DwV0JuqU9+gtibNXoj553nuIL0a9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=owJNRoO1p9eh0bqZXQ1CRK85ifXtO2+xo9+GBcrTKmTrDVYJ8ojPtnX3+Bx6LKq9GNv1gEzmDBUcBCidC275YiK9tdGW3w7ZGYfLl2+TB8eYubuMa3yKZFbTJX5JmfmF8Z0nSfBW01Hy3LR6MblaY9k7p0DNqNStncmWQAaUGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JbYbP1uD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415Ewfgf003365;
	Mon, 5 Feb 2024 18:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FEn4SqIgrbfDB+gxpOj0QgyMAFS+cW09sobFdzZvM4g=; b=Jb
	YbP1uDZQ/RCyIG6DYaWUDR8t73v3ASMjqvOxa9ZLDEWIud5cw4IczXHWxpReXDG2
	Ap0kXoniwrMuJaPCVrbg4zW8+HANM17Ffox00vs4L7MxNGD+hDKqthLUDfFSvFL7
	PWGEZ9ceKLq2q/5VpmtdU99mXqFqumraMDCBsfl0jIzXiSLqhNfLK7V6rJDI02ej
	7tGgYQeE3Jl/36K4QVvoxSncddnSUHuHXmVq8jdmNrPJmhckvMwkV/k/NCb8gNpT
	Bt4f5ghuRG+b/oXhCHoj75NZR9kjdSOrBhK4OThkGlym700MYK6pSxowezSqhKTC
	G5JozyAF1sPQtBi7dUAQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w31wnrg9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:22:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415IMvCr008012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 18:22:57 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 10:22:46 -0800
Message-ID: <4b6a8b75-8fc1-4888-a76a-f14a67521359@quicinc.com>
Date: Mon, 5 Feb 2024 23:52:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] soc: qcom: ice: add hwkm support in ice
Content-Language: en-US
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <kernel@quicinc.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <bartosz.golaszewski@linaro.org>, <konrad.dybcio@linaro.org>,
        <ulf.hansson@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <mani@kernel.org>, <davem@davemloft.net>,
        <herbert@gondor.apana.org.au>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
 <20240127232436.2632187-5-quic_gaurkash@quicinc.com>
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20240127232436.2632187-5-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8lmM3iHwCc0-NJVlJAzJ6nzEtdMg0vFR
X-Proofpoint-GUID: 8lmM3iHwCc0-NJVlJAzJ6nzEtdMg0vFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050138



On 1/28/2024 4:44 AM, Gaurav Kashyap wrote:
> Qualcomm's ICE (Inline Crypto Engine) contains a proprietary
> key management hardware called Hardware Key Manager (HWKM).
> This patch integrates HWKM support in ICE when it is
> available. HWKM primarily provides hardware wrapped key support
> where the ICE (storage) keys are not available in software and
> protected in hardware.
> 
> When HWKM software support is not fully available (from Trustzone),
> there can be a scenario where the ICE hardware supports HWKM, but
> it cannot be used for wrapped keys. In this case, standard keys have
> to be used without using HWKM. Hence, providing a toggle controlled
> by a devicetree entry to use HWKM or not.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/soc/qcom/ice.c | 126 ++++++++++++++++++++++++++++++++++++++++-
>   include/soc/qcom/ice.h |   1 +
>   2 files changed, 124 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index 6f941d32fffb..c718e8153b23 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -26,6 +26,20 @@
>   #define QCOM_ICE_REG_FUSE_SETTING		0x0010
>   #define QCOM_ICE_REG_BIST_STATUS		0x0070
>   #define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
> +#define QCOM_ICE_REG_CONTROL			0x0
> +/* QCOM ICE HWKM registers */
> +#define QCOM_ICE_REG_HWKM_TZ_KM_CTL			0x1000
> +#define QCOM_ICE_REG_HWKM_TZ_KM_STATUS			0x1004
> +#define QCOM_ICE_REG_HWKM_BANK0_BANKN_IRQ_STATUS	0x2008
> +#define QCOM_ICE_REG_HWKM_BANK0_BBAC_0			0x5000
> +#define QCOM_ICE_REG_HWKM_BANK0_BBAC_1			0x5004
> +#define QCOM_ICE_REG_HWKM_BANK0_BBAC_2			0x5008
> +#define QCOM_ICE_REG_HWKM_BANK0_BBAC_3			0x500C
> +#define QCOM_ICE_REG_HWKM_BANK0_BBAC_4			0x5010
> +
> +/* QCOM ICE HWKM BIST vals */
> +#define QCOM_ICE_HWKM_BIST_DONE_V1_VAL		0x14007
> +#define QCOM_ICE_HWKM_BIST_DONE_V2_VAL		0x287
>   
>   /* BIST ("built-in self-test") status flags */
>   #define QCOM_ICE_BIST_STATUS_MASK		GENMASK(31, 28)
> @@ -34,6 +48,9 @@
>   #define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
>   #define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
>   
> +#define QCOM_ICE_HWKM_REG_OFFSET	0x8000
> +#define HWKM_OFFSET(reg)		((reg) + QCOM_ICE_HWKM_REG_OFFSET)
> +
>   #define qcom_ice_writel(engine, val, reg)	\
>   	writel((val), (engine)->base + (reg))
>   
> @@ -46,6 +63,9 @@ struct qcom_ice {
>   	struct device_link *link;
>   
>   	struct clk *core_clk;
> +	u8 hwkm_version;
> +	bool use_hwkm;
> +	bool hwkm_init_complete;
>   };
>   
>   static bool qcom_ice_check_supported(struct qcom_ice *ice)
> @@ -63,8 +83,21 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
>   		return false;
>   	}
>   
> -	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
> -		 major, minor, step);
> +	if (major >= 4 || (major == 3 && minor == 2 && step >= 1))
> +		ice->hwkm_version = 2;
> +	else if (major == 3 && minor == 2)
> +		ice->hwkm_version = 1;
> +	else
> +		ice->hwkm_version = 0;
> +
> +	if (ice->hwkm_version == 0)
> +		ice->use_hwkm = false;
> +
> +	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d, HWKM v%d\n",
> +		 major, minor, step, ice->hwkm_version);
> +
> +	if (!ice->use_hwkm)
> +		dev_info(dev, "QC ICE HWKM (Hardware Key Manager) not used/supported");
>   
>   	/* If fuses are blown, ICE might not work in the standard way. */
>   	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
> @@ -113,10 +146,14 @@ static void qcom_ice_optimization_enable(struct qcom_ice *ice)
>    * fails, so we needn't do it in software too, and (c) properly testing
>    * storage encryption requires testing the full storage stack anyway,
>    * and not relying on hardware-level self-tests.
> + *
> + * However, we still care about if HWKM BIST failed (when supported) as
> + * important functionality would fail later, so disable hwkm on failure.
>    */
>   static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
>   {
>   	u32 regval;
> +	u32 bist_done_reg;
>   	int err;
>   
>   	err = readl_poll_timeout(ice->base + QCOM_ICE_REG_BIST_STATUS,
> @@ -125,15 +162,85 @@ static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
>   	if (err)
>   		dev_err(ice->dev, "Timed out waiting for ICE self-test to complete\n");
>   
> +	if (ice->use_hwkm) {
> +		bist_done_reg = (ice->hwkm_version == 1) ?
> +				 QCOM_ICE_HWKM_BIST_DONE_V1_VAL :
> +				 QCOM_ICE_HWKM_BIST_DONE_V2_VAL;
> +		if (qcom_ice_readl(ice,
> +				   HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_STATUS)) !=
> +				   bist_done_reg) {
> +			dev_err(ice->dev, "HWKM BIST error\n");
err is not upsated to capture this failure.
> +			ice->use_hwkm = false;
> +		}
> +	}
>   	return err;
>   }
>   
> +static void qcom_ice_enable_standard_mode(struct qcom_ice *ice)
> +{
> +	u32 val = 0;
> +
> +	/*
> +	 * When ICE is in standard (hwkm) mode, it supports HW wrapped
> +	 * keys, and when it is in legacy mode, it only supports standard
> +	 * (non HW wrapped) keys.
> +	 *
> +	 * Put ICE in standard mode, ICE defaults to legacy mode.
> +	 * Legacy mode - ICE HWKM slave not supported.
> +	 * Standard mode - ICE HWKM slave supported.
> +	 *
> +	 * Depending on the version of HWKM, it is controlled by different
> +	 * registers in ICE.
> +	 */
> +	if (ice->hwkm_version >= 2) {
> +		val = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
> +		val = val & 0xFFFFFFFE;
do not use constant "0xFFFFFFFE". Better to define bits that are being set.
> +		qcom_ice_writel(ice, val, QCOM_ICE_REG_CONTROL);
> +	} else {
> +		qcom_ice_writel(ice, 0x7, HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_CTL));
do not use constant "0x7". Better to define bits that are being set.
> +	}
> +}
> +
> +static void qcom_ice_hwkm_init(struct qcom_ice *ice)
> +{
> +	/* Disable CRC checks. This HWKM feature is not used. */
> +	qcom_ice_writel(ice, 0x6,
> +			HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_CTL));
> +
> +	/*
> +	 * Give register bank of the HWKM slave access to read and modify
> +	 * the keyslots in ICE HWKM slave. Without this, trustzone will not
> +	 * be able to program keys into ICE.
> +	 */
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_0));
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_1));
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_2));
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_3));
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_4));
> +
> +	/* Clear HWKM response FIFO before doing anything */
> +	qcom_ice_writel(ice, 0x8, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BANKN_IRQ_STATUS));
Do not use constant "0x8". Please define bits that are being set.
> +	ice->hwkm_init_complete = true;
> +}
> +
>   int qcom_ice_enable(struct qcom_ice *ice)
>   {
> +	int err;
> +
>   	qcom_ice_low_power_mode_enable(ice);
>   	qcom_ice_optimization_enable(ice);
>   
> -	return qcom_ice_wait_bist_status(ice);
> +	if (ice->use_hwkm)
> +		qcom_ice_enable_standard_mode(ice);
> +
> +	err = qcom_ice_wait_bist_status(ice);
> +	if (err)
> +		return err;
> +
> +	if (ice->use_hwkm)
> +		qcom_ice_hwkm_init(ice);
> +
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(qcom_ice_enable);
>   
> @@ -149,6 +256,10 @@ int qcom_ice_resume(struct qcom_ice *ice)
>   		return err;
>   	}
>   
> +	if (ice->use_hwkm) {
> +		qcom_ice_enable_standard_mode(ice);
> +		qcom_ice_hwkm_init(ice);
> +	}
>   	return qcom_ice_wait_bist_status(ice);
>   }
>   EXPORT_SYMBOL_GPL(qcom_ice_resume);
> @@ -156,6 +267,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
>   int qcom_ice_suspend(struct qcom_ice *ice)
>   {
>   	clk_disable_unprepare(ice->core_clk);
> +	ice->hwkm_init_complete = false;
>   
>   	return 0;
>   }
> @@ -205,6 +317,12 @@ int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
>   }
>   EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
>   
> +bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
> +{
> +	return ice->use_hwkm;
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
> +
>   static struct qcom_ice *qcom_ice_create(struct device *dev,
>   					void __iomem *base)
>   {
> @@ -239,6 +357,8 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
>   		engine->core_clk = devm_clk_get_enabled(dev, NULL);
>   	if (IS_ERR(engine->core_clk))
>   		return ERR_CAST(engine->core_clk);
> +	engine->use_hwkm = of_property_read_bool(dev->of_node,
> +						 "qcom,ice-use-hwkm");
>   
>   	if (!qcom_ice_check_supported(engine))
>   		return ERR_PTR(-EOPNOTSUPP);
> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> index 9dd835dba2a7..1f52e82e3e1c 100644
> --- a/include/soc/qcom/ice.h
> +++ b/include/soc/qcom/ice.h
> @@ -34,5 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>   			 const struct blk_crypto_key *bkey,
>   			 u8 data_unit_size, int slot);
>   int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
> +bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
>   struct qcom_ice *of_qcom_ice_get(struct device *dev);
>   #endif /* __QCOM_ICE_H__ */

