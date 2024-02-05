Return-Path: <linux-kernel+bounces-53249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3A984A2AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BFEB278D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8301482DD;
	Mon,  5 Feb 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HUHwEJh/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEE481AE;
	Mon,  5 Feb 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158758; cv=none; b=UvTFOaVTqaYWZx5fPIxjxG+ekzlekaYquE1hWq8IZf6LQzCbua/Ji7L0LLxBMAXUtGkeFU+N0laz3ktCpzUWU5izgSUxtM7fSLOgsiuuGaeopVAW9s2xdGQ3ggWDgLYNKk7RmkmQKhXAsXNfsdEpKzAt2m63MSAa9RFtyCP5tf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158758; c=relaxed/simple;
	bh=heNj6/BgBMNT76DCe8GFRn6mIYSxdeYYFSNlkm4XIow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ovayP+iPUWNpuTBRwRNokhAETa5Rrv4RxGNpedkt1ucv2JHGDf0L7k1AAwjZTeHDeTbqotFA2DHLKL1ZSqcNup4UdIreljQc3IjepDXTLtZUbaCYLvylp64cOSyL4GH0b0ltsrjEoDO0F5D21kZW3p4ofJINv4BXv2DrcLAMjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HUHwEJh/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415Copqe024599;
	Mon, 5 Feb 2024 18:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zYEnE8kdsoqUrl02WqEqTUud6+ujtosVwZejnyNc9bY=; b=HU
	HwEJh/M6bpbm4Qs7mDPE9AlAekVtDWthHYpx/Ez+EtITzpxGMRiGS9TcZ2n1znL5
	X6fFT9s1Yb+JhPFdkZl8asg4keU4Avzm9jAxkbTveB0GncKdUndOhOP4CO2+baSo
	boHPx5TOjVWAixK6PBXZHCsMIujl/X1pmLatRKmV1CQs0rnDroxNjE6TOlleY9o2
	gicjPPD/GRybFcLpHuCZHsRRAdYZ7DGRXxOnapMROjuACPFTJ5Q1cfkUtyNuvSIu
	G/Q3uEsIDzRHnCrsFCCCnOE4vsP48jh3GSDgBjmpUKBdxWXvoovW0VpTCK2AD6Ya
	WctjBlu6fOXlC3kduR6Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2r929u35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:45:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415Ijg7b027683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 18:45:42 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 10:45:32 -0800
Message-ID: <7e0886e5-fd2b-4da1-8939-9d5c44673066@quicinc.com>
Date: Tue, 6 Feb 2024 00:15:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] soc: qcom: ice: support for generate, import and
 prepare key
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
 <20240127232436.2632187-7-quic_gaurkash@quicinc.com>
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20240127232436.2632187-7-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: azfeHzAl6Lc8k87ju2q-JCyMsmS9n4pA
X-Proofpoint-ORIG-GUID: azfeHzAl6Lc8k87ju2q-JCyMsmS9n4pA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050141



On 1/28/2024 4:44 AM, Gaurav Kashyap wrote:
> Wrapped key creation and management using HWKM is currently
> supported only through Qualcomm's Trustzone.
> Three new SCM calls have already been added in the scm layer
> for this purpose.
> 
> This patch adds support for generate, prepare and import key
> apis in ICE module and hooks it up the scm calls defined for them.
> This will eventually plug into the new IOCTLS added for this
> usecase in the block layer.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/soc/qcom/ice.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>   include/soc/qcom/ice.h |  8 +++++
>   2 files changed, 74 insertions(+)
> 
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index c3b852269dca..93654ae704bf 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -21,6 +21,13 @@
>   
>   #define AES_256_XTS_KEY_SIZE			64
>   
> +/*
> + * Wrapped key sizes that HWKM expects and manages is different for different
> + * versions of the hardware.
> + */
> +#define QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(v)	\
> +	((v) == 1 ? 68 : 100)
> +
>   /* QCOM ICE registers */
>   #define QCOM_ICE_REG_VERSION			0x0008
>   #define QCOM_ICE_REG_FUSE_SETTING		0x0010
> @@ -420,6 +427,65 @@ int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
>   }
>   EXPORT_SYMBOL_GPL(qcom_ice_derive_sw_secret);
>   
> +/**
> + * qcom_ice_generate_key() - Generate a wrapped key for inline encryption
> + * @lt_key: longterm wrapped key that is generated, which is
> + *          BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
> + *
> + * Make a scm call into trustzone to generate a wrapped key for storage
> + * encryption using hwkm.
> + *
> + * Return: lt wrapped key size on success; err on failure.
> + */
you might consider to change return value based on comment on patch 3/15.
> +int qcom_ice_generate_key(struct qcom_ice *ice,
> +			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	return qcom_scm_generate_ice_key(lt_key,
> +					 QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version));
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_generate_key);
> +
> +/**
> + * qcom_ice_prepare_key() - Prepare a longterm wrapped key for inline encryption
> + * @lt_key: longterm wrapped key that is generated or imported.
> + * @lt_key_size: size of the longterm wrapped_key
> + * @eph_key: wrapped key returned which has been wrapped with a per-boot ephemeral key,
> + *           size of which is BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
> + *
> + * Make a scm call into trustzone to prepare a wrapped key for storage
> + * encryption by rewrapping the longterm wrapped key with a per boot ephemeral
> + * key using hwkm.
> + *
> + * Return: eph wrapped key size on success; err on failure.
> + */
> +int qcom_ice_prepare_key(struct qcom_ice *ice, const u8 *lt_key, size_t lt_key_size,
> +			 u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	return qcom_scm_prepare_ice_key(lt_key, lt_key_size, eph_key,
> +					QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version));
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_prepare_key);
> +
> +/**
> + * qcom_ice_import_key() - Import a raw key for inline encryption
> + * @imp_key: raw key that has to be imported
> + * @imp_key_size: size of the imported key
> + * @lt_key: longterm wrapped key that is imported, which is
> + *          BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
> + *
> + * Make a scm call into trustzone to import a raw key for storage encryption
> + * and generate a longterm wrapped key using hwkm.
> + *
> + * Return: lt wrapped key size on success; err on failure.
> + */
> +int qcom_ice_import_key(struct qcom_ice *ice, const u8 *imp_key, size_t imp_key_size,
> +			u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	return qcom_scm_import_ice_key(imp_key, imp_key_size, lt_key,
> +				       QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version));
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_import_key);
> +
>   static struct qcom_ice *qcom_ice_create(struct device *dev,
>   					void __iomem *base)
>   {
> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> index dabe0d3a1fd0..dcf277d196ff 100644
> --- a/include/soc/qcom/ice.h
> +++ b/include/soc/qcom/ice.h
> @@ -39,5 +39,13 @@ bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
>   int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
>   			      unsigned int wkey_size,
>   			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
> +int qcom_ice_generate_key(struct qcom_ice *ice,
> +			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
> +int qcom_ice_prepare_key(struct qcom_ice *ice,
> +			 const u8 *lt_key, size_t lt_key_size,
> +			 u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
> +int qcom_ice_import_key(struct qcom_ice *ice,
> +			const u8 *imp_key, size_t imp_key_size,
> +			u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
>   struct qcom_ice *of_qcom_ice_get(struct device *dev);
>   #endif /* __QCOM_ICE_H__ */

