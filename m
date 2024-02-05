Return-Path: <linux-kernel+bounces-53271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1001A84A2F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294071C2486B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E74D9E4;
	Mon,  5 Feb 2024 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MOmpDQLK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5242E3FD;
	Mon,  5 Feb 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159608; cv=none; b=gkiUSySgPeHw3YbSZXc1tPiY8yTqSGg9Q4aY4L5/ZLSbElLx4Igrqrm3kkrW/yQ7mUBNzfyy4qa9G6PZBnWKQiqOT+74fnLMnhlTK32ESguNnfhwbKHRz0xUrWBDZMSpCRSe8MPE1xLNRuyGWMgfC5BbSrhOBq/7lGMeCM2Z6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159608; c=relaxed/simple;
	bh=HNYrnp9WLIKqhOXfadNXBc7gufyxT44WSMQVNI9swv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mc/8t45TwHEqS2kB8uy7ulOBC+z2ix4IzpNcHlAVxYa917QhmuE8Wq1MHswYY8BR2HGzgutkn72hY1lrowsw82w/PY43T/pZ/IbbA64hLsEpkcXSn5EIBw9L/hMMmhj6VXql5Of8tqwFvCTWO3yFVAQf5erHprV8IJxmQvghGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MOmpDQLK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415EwfiI003365;
	Mon, 5 Feb 2024 18:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LBmqhbGx6f84e6T5h03SQhOocsnVabU6PUYhi2PETL4=; b=MO
	mpDQLKDvDWAwLBja6peMLUL7JSoH8y+pS96NAt2lbWYQgl+mYZUtj0BMHfUz8fpV
	CYBt/AIwi3qRlj+cxxvS+MeGsH+Fq4Lrhxrmv+ZBVjKmcPQ0BCPq/dmEWDLDcEMO
	frA5Zi2nY2jZD0abNi10MQSSxSThTkZivAc4l4EyHvJvppqOAzq6wU/EeOo5ThcC
	xsYI8z0rhJV/yEVxdXUXUhQqmAt87KoDj6zk9UjF2gNelJ3+kM9ndSUlFQQtMU2V
	TqGBWxncVohJCQsVf267e0D4B0yRpkdXfyUzsXz3D6B5BFCj1TtFzHLnVcSf6Qb6
	GchIhTiGvLrr6sHnTEsw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w31wnrjp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:59:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415IxrEW017665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 18:59:53 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 10:59:42 -0800
Message-ID: <ddb49c10-4463-4a8f-b44e-c10d5220d8a5@quicinc.com>
Date: Tue, 6 Feb 2024 00:29:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] ufs: host: wrapped keys support in ufs qcom
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
 <20240127232436.2632187-11-quic_gaurkash@quicinc.com>
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20240127232436.2632187-11-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SHzNTd1x01RGFKe2FX5ORZBspHnLzBtT
X-Proofpoint-GUID: SHzNTd1x01RGFKe2FX5ORZBspHnLzBtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_13,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050141



On 1/28/2024 4:44 AM, Gaurav Kashyap wrote:
> Use the wrapped keys quirk when hwkm is supported/used.
> Whether to use HWKM or not would be decided during an ICE
> probe, and based on this information, UFS can decide to use
> wrapped keys or standard keys.
> 
> Also, propagate the appropriate key size to the ICE driver
> when wrapped keys are used.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
>   drivers/ufs/host/ufs-qcom.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index acf352594362..5c9ba06438a9 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -123,6 +123,8 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
>   
>   	host->ice = ice;
>   	hba->caps |= UFSHCD_CAP_CRYPTO;
> +	if (qcom_ice_hwkm_supported(host->ice))
> +		hba->quirks |= UFSHCD_QUIRK_USES_WRAPPED_CRYPTO_KEYS;
>   
>   	return 0;
>   }
> @@ -160,7 +162,11 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
>   	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
>   		return -EOPNOTSUPP;
>   
> -	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
> +	if (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)
> +		ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED;
> +	else
> +		ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
> +
>   	if (config_enable)
>   		return qcom_ice_program_key(host->ice,
>   					    QCOM_ICE_CRYPTO_ALG_AES_XTS,

