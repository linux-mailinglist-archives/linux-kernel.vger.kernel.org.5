Return-Path: <linux-kernel+bounces-53260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220484A2CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6338287AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347964879E;
	Mon,  5 Feb 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q5xIU91y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658E482DB;
	Mon,  5 Feb 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159234; cv=none; b=IyMsMzEatD4pLEqXMimC6TzRKwXVUGvL8lv0BZFO0W9VA8zKI1sd21m6UwN65Nv3oy6MSVDaN+X8xlb1IGvhxSB+P4EoubyWTNAoQGVILRC+waOV8joPtDgNXpx6PMwl5nczH0/jupgjFYjmv2QxX0mXVARCnfK+uA/fhBTrtVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159234; c=relaxed/simple;
	bh=Wna80yOYPd87z65obyfALV1zKK1OJzoI0xbvAgUfVx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BxZ91DFE9Otc5LcPGslhpJmNaR+gERN1SSxsB5+B+97Jj5/9REdUFtQVyf5UdP88OUO1DC/6T8DnWdjYwz4PINoGgyD7KtwXfuPhZZ8c2xTplKBnd/eulInhN7zwhclqkfxYZYfQnIe9TzekYxO7HpCT9Vv0TeaLvObBnKLYKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q5xIU91y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415HqH90008543;
	Mon, 5 Feb 2024 18:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vhrQ17zeR7q43lj2zjLK1Vr1g0vgVi9UIt6bEjY/f1A=; b=Q5
	xIU91yYGqOESiJGuThpIiLyBwuHlmFR4xK6VkdrYWuY+7XynAF19gUbHHn8D2ZQa
	snZcmNdwV3kf9Fqd4ezILpCvgsqJjL2pdCajyEPy6w1eGqkqhAFBLTcCbLoHw1cC
	hPacNEPrUH1AbS2ycOqckt9MM/stN34A8fdoVOhjI/w4IAKib1KsEMjvThwFHP67
	USgas9wI5rwZPUnRMJWElZ09Ywqohmo/56DzHgVgpwQYlErLimnihjGpAvaWbOnt
	Z+q7TEyTZKC61wPWfogNnkt56ayftpGQwcEJ9I1kxW8IP1Z5noN9lR4tfTbxBsWR
	IIJP+eKpv3LPJeVH/ALg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2s07sq2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:53:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415Irckl017425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 18:53:38 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 10:53:28 -0800
Message-ID: <284883c5-a471-483b-acea-92ab26c0088a@quicinc.com>
Date: Tue, 6 Feb 2024 00:23:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] ufs: core: add support for generate, import and
 prepare keys
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
 <20240127232436.2632187-10-quic_gaurkash@quicinc.com>
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20240127232436.2632187-10-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CyUokBCyreO6dBqwiGbcomvHnqzOwkEK
X-Proofpoint-GUID: CyUokBCyreO6dBqwiGbcomvHnqzOwkEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_13,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050141



On 1/28/2024 4:44 AM, Gaurav Kashyap wrote:
> Block crypto allows storage controllers like UFS to
> register ops to generate, prepare and import wrapped
> keys in the kernel.
> 
> Wrapped keys in most cases will have vendor specific
> implementations, which means these ops would need to have
> corresponding UFS variant ops.
> This change adds hooks in UFS core to support these variant
> ops and tie them to the blk crypto ops.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>

>   drivers/ufs/core/ufshcd-crypto.c | 41 ++++++++++++++++++++++++++++++++
>   include/ufs/ufshcd.h             | 11 +++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
> index c14800eac1ff..fb935a54acfa 100644
> --- a/drivers/ufs/core/ufshcd-crypto.c
> +++ b/drivers/ufs/core/ufshcd-crypto.c
> @@ -143,10 +143,51 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
>   	return true;
>   }
>   
> +static int ufshcd_crypto_generate_key(struct blk_crypto_profile *profile,
> +				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	struct ufs_hba *hba =
> +		container_of(profile, struct ufs_hba, crypto_profile);
> +
> +	if (hba->vops && hba->vops->generate_key)
> +		return  hba->vops->generate_key(hba, lt_key);
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ufshcd_crypto_prepare_key(struct blk_crypto_profile *profile,
> +				     const u8 *lt_key, size_t lt_key_size,
> +				     u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	struct ufs_hba *hba =
> +		container_of(profile, struct ufs_hba, crypto_profile);
> +
> +	if (hba->vops && hba->vops->prepare_key)
> +		return  hba->vops->prepare_key(hba, lt_key, lt_key_size, eph_key);
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ufshcd_crypto_import_key(struct blk_crypto_profile *profile,
> +				    const u8 *imp_key, size_t imp_key_size,
> +				    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	struct ufs_hba *hba =
> +		container_of(profile, struct ufs_hba, crypto_profile);
> +
> +	if (hba->vops && hba->vops->import_key)
> +		return  hba->vops->import_key(hba, imp_key, imp_key_size, lt_key);
> +
> +	return -EOPNOTSUPP;
> +}
> +
>   static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
>   	.keyslot_program	= ufshcd_crypto_keyslot_program,
>   	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
>   	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
> +	.generate_key		= ufshcd_crypto_generate_key,
> +	.prepare_key		= ufshcd_crypto_prepare_key,
> +	.import_key		= ufshcd_crypto_import_key,
>   };
>   
>   static enum blk_crypto_mode_num
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 8a773434a329..fe66ba37e2ee 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -322,6 +322,9 @@ struct ufs_pwr_mode_info {
>    * @config_scaling_param: called to configure clock scaling parameters
>    * @program_key: program or evict an inline encryption key
>    * @derive_sw_secret: derive sw secret from a wrapped key
> + * @generate_key: generate a storage key and return longterm wrapped key
> + * @prepare_key: unwrap longterm key and return ephemeral wrapped key
> + * @import_key: import sw storage key and return longterm wrapped key
>    * @event_notify: called to notify important events
>    * @reinit_notify: called to notify reinit of UFSHCD during max gear switch
>    * @mcq_config_resource: called to configure MCQ platform resources
> @@ -369,6 +372,14 @@ struct ufs_hba_variant_ops {
>   	int	(*derive_sw_secret)(struct ufs_hba *hba, const u8 wkey[],
>   				    unsigned int wkey_size,
>   				    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
> +	int	(*generate_key)(struct ufs_hba *hba,
> +				u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
> +	int	(*prepare_key)(struct ufs_hba *hba,
> +			       const u8 *lt_key, size_t lt_key_size,
> +			       u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
> +	int	(*import_key)(struct ufs_hba *hba,
> +			      const u8 *imp_key, size_t imp_key_size,
> +			      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
>   	void	(*event_notify)(struct ufs_hba *hba,
>   				enum ufs_event_type evt, void *data);
>   	void	(*reinit_notify)(struct ufs_hba *);

