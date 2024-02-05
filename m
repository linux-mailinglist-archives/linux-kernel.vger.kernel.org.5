Return-Path: <linux-kernel+bounces-53258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02484A2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBED1C2258A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1B4BAA4;
	Mon,  5 Feb 2024 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jXpc3DWW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CA481DF;
	Mon,  5 Feb 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159159; cv=none; b=jGPQThn2GyKatT43XB764/bCsbjCHDpiUAvzM/j8bMG0JfSn/fDllM6/A2v0lnqUlY99cqKCDQoVSB7Zg9ggUHYtGqij07f+2r1bs65CYbmXxFBlnJpDiMy+wBRIY4QQL6IfsO7C5M8GG9LRRs1Z8hJh8jsIV/WGGtLGNMXmMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159159; c=relaxed/simple;
	bh=hty5bfalgTAxBFUTkl9L2easTarTfXs+9225IUA9VuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iT5mo1TWgCkgx6of2CVqYcn+JEVqC6dScR2vzqaZJb7nbhjVFW10x4RSobMOvrLM7so8BLl0nVWcrn4y83CfbeVa73/CXfO4/8eSCPTGDE4ip3H1DjNpYEA2pRI0u8N7p7XQO3Iqrqr+R7TN8vjxQf4MUlQ8AWAbTVm4jV6ULOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jXpc3DWW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158TS88011321;
	Mon, 5 Feb 2024 18:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kjzGJ6+VG2q6YyyIjm4mdcUaEPT7zDKwvxSE2vY/PKU=; b=jX
	pc3DWW6L3ldASCT3y6aYDErxmHbk0iQVtkO3N9Qec3e4Gg7oM98zYqrGLL9DD356
	hjyRfz1GxL9PAB+UABklUipjSXxXKRTREFIbaySjCTTVINjfR4hmDHIx3eEyY/Tq
	bNfvOdbJL+zeonbdj0bSXU4R3M8qFFQlwelL2fFaAM6Eip7P/lYbtHX3RIZht/Cn
	ZifJYKHi5Dwj0xp1hddMmlXiUWgAWZZE99ZeXkupA1wqXQ+TE0kxA/R84E0ikOX0
	6Zi3pS6hpKjBRMHfJUFqbrCCTBwdwoVvURzoj80JggIY0+6V6bnxfcA2qWNUnw0Q
	oKs01/dUiJ8MCH57VnFQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v729ep9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:52:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415IqNIK015622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 18:52:23 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 10:52:12 -0800
Message-ID: <fdc41db8-da13-4844-8c8b-e78c53050f02@quicinc.com>
Date: Tue, 6 Feb 2024 00:22:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] ufs: core: add support to derive software secret
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
 <20240127232436.2632187-9-quic_gaurkash@quicinc.com>
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20240127232436.2632187-9-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _dhgBUtqDWE-SCwyCYbPVC1wh1FcJJ7A
X-Proofpoint-ORIG-GUID: _dhgBUtqDWE-SCwyCYbPVC1wh1FcJJ7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050141



On 1/28/2024 4:44 AM, Gaurav Kashyap wrote:
> Block crypto allows storage controllers like UFS to
> register an op derive a software secret from wrapped
> keys added to the kernel.
> 
> Wrapped keys in most cases will have vendor specific
> implementations, which means this op would need to have
> a corresponding UFS variant op.
> This change adds hooks in UFS core to support this variant
> ops and tie them to the blk crypto op.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>

>   drivers/ufs/core/ufshcd-crypto.c | 15 +++++++++++++++
>   include/ufs/ufshcd.h             |  4 ++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
> index 399b55d67b3b..c14800eac1ff 100644
> --- a/drivers/ufs/core/ufshcd-crypto.c
> +++ b/drivers/ufs/core/ufshcd-crypto.c
> @@ -119,6 +119,20 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
>   	return ufshcd_clear_keyslot(hba, slot);
>   }
>   
> +static int ufshcd_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
> +					  const u8 wkey[], size_t wkey_size,
> +					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> +{
> +	struct ufs_hba *hba =
> +		container_of(profile, struct ufs_hba, crypto_profile);
> +
> +	if (hba->vops && hba->vops->derive_sw_secret)
> +		return  hba->vops->derive_sw_secret(hba, wkey, wkey_size,
> +						    sw_secret);
> +
> +	return -EOPNOTSUPP;
> +}
> +
>   bool ufshcd_crypto_enable(struct ufs_hba *hba)
>   {
>   	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
> @@ -132,6 +146,7 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
>   static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
>   	.keyslot_program	= ufshcd_crypto_keyslot_program,
>   	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
> +	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
>   };
>   
>   static enum blk_crypto_mode_num
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 680c010a53d4..8a773434a329 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -321,6 +321,7 @@ struct ufs_pwr_mode_info {
>    * @device_reset: called to issue a reset pulse on the UFS device
>    * @config_scaling_param: called to configure clock scaling parameters
>    * @program_key: program or evict an inline encryption key
> + * @derive_sw_secret: derive sw secret from a wrapped key
>    * @event_notify: called to notify important events
>    * @reinit_notify: called to notify reinit of UFSHCD during max gear switch
>    * @mcq_config_resource: called to configure MCQ platform resources
> @@ -365,6 +366,9 @@ struct ufs_hba_variant_ops {
>   	int	(*program_key)(struct ufs_hba *hba,
>   			       const struct blk_crypto_key *bkey,
>   			       const union ufs_crypto_cfg_entry *cfg, int slot);
> +	int	(*derive_sw_secret)(struct ufs_hba *hba, const u8 wkey[],
> +				    unsigned int wkey_size,
> +				    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
>   	void	(*event_notify)(struct ufs_hba *hba,
>   				enum ufs_event_type evt, void *data);
>   	void	(*reinit_notify)(struct ufs_hba *);

