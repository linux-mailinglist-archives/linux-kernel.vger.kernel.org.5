Return-Path: <linux-kernel+bounces-53242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB56084A28B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676E6B26247
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91338481D3;
	Mon,  5 Feb 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lym1NocI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1A2377E;
	Mon,  5 Feb 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158339; cv=none; b=mnru279zfbhOn+vO4DR+9cVD8lMcsBQWOyuI4PifyQ6Xhx7He0Y7+QAm6v7Qq8wzQaXVUt1Oj8P/JT/avdoCK2+AaSVB4CsSLXu9JorTpLYbZkXcQb1X1xkwdecekR4XNV2kQXTeLbRWfQ0yq0vZVUzz8o08gX+EG4HeN08mp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158339; c=relaxed/simple;
	bh=e0CXKNJgGf+WMWBcYWxEEd3t7kkr/quQD/HmAsyyTIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pkx7CzelGnwsRRMcmhFh1ks3e4vz/6iiRyNe2QLnZ2/Y/tmIOcD+l/nXn1goJWu9PqFmAtACSVWlDoK78RdCDB58XDHARmsYt6CC0IyCzFggE/Fg0JcGbV25tYlzxjxxLC00QVL6nrnJkHdzvUv1GPOxTfybUcgk57MxobI1qbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lym1NocI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415FRcLr010216;
	Mon, 5 Feb 2024 18:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YShS3zbBdGisYtCyvkJzb10FbbiLsHga/Ln8EhUoGyQ=; b=Ly
	m1NocIIL1ZxCb0zTUq8YZ6PSePSzi0yP8WT29ttermwZ2HvOF1tNP1//SL+pk1TQ
	fpVBv+I/6fBj4HZ0IOlW3SChBLQ7GELApjWc9ZUhmkn+hnKFPRwEOyY4U0vZGl0z
	TBE2KlqpG97jRlNTf57e+igJUJ+f7/eRYRTdmKQ6FVBbSXhaYUYN2ZCOEe5yD6oT
	husM0djQDRBbaUYa8w8mQmj8t3HmpZxq6W08Mau1Br5/ghEUti1NE3RbWX5f4QUJ
	ZHSFDRN5qTQyFpuwMKS+83muxxToTuiZmea9Cl1MRnl7g3h25KlYVEvqG7xokTzu
	HhS8kVFN91kmo2f2ESTQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v259akf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:38:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415Icgsv021554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 18:38:42 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 10:38:32 -0800
Message-ID: <1c02f163-f784-4910-ba6f-167cd8617cb8@quicinc.com>
Date: Tue, 6 Feb 2024 00:08:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] soc: qcom: ice: support for hardware wrapped
 keys
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
 <20240127232436.2632187-6-quic_gaurkash@quicinc.com>
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20240127232436.2632187-6-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zvSvjFuzMYq-YL_YNNezPa7U3qfYq1tz
X-Proofpoint-GUID: zvSvjFuzMYq-YL_YNNezPa7U3qfYq1tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050140



On 1/28/2024 4:44 AM, Gaurav Kashyap wrote:
> Now that HWKM support is added to ICE, extend the ICE
> driver to support hardware wrapped keys programming coming
> in from the storage controllers (ufs and emmc). This is
> similar to standard keys where the call is forwarded to
> Trustzone, however certain wrapped key and HWKM specific
> actions has to be performed around the SCM calls.
> 
> Derive software secret support is also added by forwarding the
> call to the corresponding scm api.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>

>   drivers/soc/qcom/ice.c | 119 +++++++++++++++++++++++++++++++++++++----
>   include/soc/qcom/ice.h |   4 ++
>   2 files changed, 112 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index c718e8153b23..c3b852269dca 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -27,6 +27,8 @@
>   #define QCOM_ICE_REG_BIST_STATUS		0x0070
>   #define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
>   #define QCOM_ICE_REG_CONTROL			0x0
> +#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16		0x4040
> +
>   /* QCOM ICE HWKM registers */
>   #define QCOM_ICE_REG_HWKM_TZ_KM_CTL			0x1000
>   #define QCOM_ICE_REG_HWKM_TZ_KM_STATUS			0x1004
> @@ -48,6 +50,8 @@
>   #define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
>   #define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
>   
> +#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET	0x80
> +
>   #define QCOM_ICE_HWKM_REG_OFFSET	0x8000
>   #define HWKM_OFFSET(reg)		((reg) + QCOM_ICE_HWKM_REG_OFFSET)
>   
> @@ -68,6 +72,16 @@ struct qcom_ice {
>   	bool hwkm_init_complete;
>   };
>   
> +union crypto_cfg {
> +	__le32 regval;
> +	struct {
> +		u8 dusize;
> +		u8 capidx;
> +		u8 reserved;
> +		u8 cfge;
> +	};
> +};
> +
>   static bool qcom_ice_check_supported(struct qcom_ice *ice)
>   {
>   	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> @@ -273,6 +287,51 @@ int qcom_ice_suspend(struct qcom_ice *ice)
>   }
>   EXPORT_SYMBOL_GPL(qcom_ice_suspend);
>   
> +/*
> + * HW dictates the internal mapping between the ICE and HWKM slots,
> + * which are different for different versions, make the translation
> + * here. For v1 however, the translation is done in trustzone.
> + */
> +static int translate_hwkm_slot(struct qcom_ice *ice, int slot)
> +{
> +	return (ice->hwkm_version == 1) ? slot : (slot * 2);
> +}
> +
> +static int qcom_ice_program_wrapped_key(struct qcom_ice *ice,
> +					const struct blk_crypto_key *key,
> +					u8 data_unit_size, int slot)
> +{
> +	union crypto_cfg cfg;
> +	int hwkm_slot;
> +	int err;
> +
> +	hwkm_slot = translate_hwkm_slot(ice, slot);
> +
> +	memset(&cfg, 0, sizeof(cfg));
> +	cfg.dusize = data_unit_size;
> +	cfg.capidx = QCOM_SCM_ICE_CIPHER_AES_256_XTS;
> +	cfg.cfge = 0x80;
> +
> +	/* Clear CFGE */
> +	qcom_ice_writel(ice, 0x0, QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16 +
> +				  QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET * slot);
> +
> +	/* Call trustzone to program the wrapped key using hwkm */
> +	err = qcom_scm_ice_set_key(hwkm_slot, key->raw, key->size,
> +				   QCOM_SCM_ICE_CIPHER_AES_256_XTS, data_unit_size);
> +	if (err) {
> +		pr_err("%s:SCM call Error: 0x%x slot %d\n", __func__, err,
> +		       slot);
> +		return err;
> +	}
> +
> +	/* Enable CFGE after programming key */
> +	qcom_ice_writel(ice, cfg.regval, QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16 +
> +					 QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET * slot);
> +
> +	return err;
> +}
> +
>   int qcom_ice_program_key(struct qcom_ice *ice,
>   			 u8 algorithm_id, u8 key_size,
>   			 const struct blk_crypto_key *bkey,
> @@ -288,24 +347,39 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>   
>   	/* Only AES-256-XTS has been tested so far. */
>   	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
> -	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
> +	    (key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256 &&
> +	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED)) {
>   		dev_err_ratelimited(dev,
>   				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
>   				    algorithm_id, key_size);
>   		return -EINVAL;
>   	}
>   
> -	memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
> -
> -	/* The SCM call requires that the key words are encoded in big endian */
> -	for (i = 0; i < ARRAY_SIZE(key.words); i++)
> -		__cpu_to_be32s(&key.words[i]);
> +	if (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED) {
> +		/* It is expected that HWKM init has completed before programming wrapped keys */
> +		if (!ice->use_hwkm || !ice->hwkm_init_complete) {
> +			dev_err_ratelimited(dev, "HWKM not currently used or initialized\n");
> +			return -EINVAL;
> +		}
> +		err = qcom_ice_program_wrapped_key(ice, bkey, data_unit_size,
> +						   slot);
> +	} else {
> +		if (bkey->size != QCOM_ICE_CRYPTO_KEY_SIZE_256)
> +			dev_err_ratelimited(dev,
> +					    "Incorrect key size; bkey->size=%d\n",
> +					    algorithm_id);
> +		return -EINVAL;
> +		memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
>   
> -	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> -				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> -				   data_unit_size);
> +		/* The SCM call requires that the key words are encoded in big endian */
> +		for (i = 0; i < ARRAY_SIZE(key.words); i++)
> +			__cpu_to_be32s(&key.words[i]);
>   
> -	memzero_explicit(&key, sizeof(key));
> +		err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> +					   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> +					   data_unit_size);
> +		memzero_explicit(&key, sizeof(key));
> +	}
>   
>   	return err;
>   }
> @@ -313,7 +387,21 @@ EXPORT_SYMBOL_GPL(qcom_ice_program_key);
>   
>   int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
>   {
> -	return qcom_scm_ice_invalidate_key(slot);
> +	int hwkm_slot = slot;
> +
> +	if (ice->use_hwkm) {
> +		hwkm_slot = translate_hwkm_slot(ice, slot);
> +	/*
> +	 * Ignore calls to evict key when HWKM is supported and hwkm init
> +	 * is not yet done. This is to avoid the clearing all slots call
> +	 * during a storage reset when ICE is still in legacy mode. HWKM slave
> +	 * in ICE takes care of zeroing out the keytable on reset.
> +	 */
> +		if (!ice->hwkm_init_complete)
> +			return 0;
> +	}
> +
> +	return qcom_scm_ice_invalidate_key(hwkm_slot);
>   }
>   EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
>   
> @@ -323,6 +411,15 @@ bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
>   }
>   EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
>   
> +int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
> +			      unsigned int wkey_size,
> +			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> +{
> +	return qcom_scm_derive_sw_secret(wkey, wkey_size,
> +					 sw_secret, BLK_CRYPTO_SW_SECRET_SIZE);
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_derive_sw_secret);
> +
>   static struct qcom_ice *qcom_ice_create(struct device *dev,
>   					void __iomem *base)
>   {
> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> index 1f52e82e3e1c..dabe0d3a1fd0 100644
> --- a/include/soc/qcom/ice.h
> +++ b/include/soc/qcom/ice.h
> @@ -17,6 +17,7 @@ enum qcom_ice_crypto_key_size {
>   	QCOM_ICE_CRYPTO_KEY_SIZE_192		= 0x2,
>   	QCOM_ICE_CRYPTO_KEY_SIZE_256		= 0x3,
>   	QCOM_ICE_CRYPTO_KEY_SIZE_512		= 0x4,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED	= 0x5,
>   };
>   
>   enum qcom_ice_crypto_alg {
> @@ -35,5 +36,8 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>   			 u8 data_unit_size, int slot);
>   int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
>   bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
> +int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
> +			      unsigned int wkey_size,
> +			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
>   struct qcom_ice *of_qcom_ice_get(struct device *dev);
>   #endif /* __QCOM_ICE_H__ */

