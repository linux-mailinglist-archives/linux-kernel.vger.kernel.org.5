Return-Path: <linux-kernel+bounces-77046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944A860070
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5FD1C229BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C42A157E97;
	Thu, 22 Feb 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P0YJ/UxV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E9C4776E;
	Thu, 22 Feb 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625275; cv=none; b=eVEeCd3fH2uS6I3+zsi+ZhllDLkyX/Yq8hyfY6mY0GdefSHPj9/g7acqgAzVny8g67MRvgmZGCI8M4nYO3Axvd00QHpHxVtmz4Ixhco0jRUG9Pe5GaudOfxOu51ByyKy+csA4yrMmVZJVjItHqrjCGwsNkYHOfkhIaBgCWEcpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625275; c=relaxed/simple;
	bh=Ih7Pi+SaZomKmu1sS1WB9r48p2Ihj8fBaf1HV/905pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=skGVD9inN2JHsyefcOPfQZmX+McGrBYoI5TtMGTHW7IfjSClaAJyLFSn0o9k7eUusIUzm97Aq+htF1QiofXPa5mGWy3JMd/JLvdbIcLe0sd4no2ZYzii8cL0YJ9AMHzcYcTBlJfciMewm8pkDixZ+Qg+VgcP/d/cHB6Rti0AD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P0YJ/UxV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MGtPmK005583;
	Thu, 22 Feb 2024 18:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hyACU/l3dezHvpP436sZGmd4EqRm3eY2Q3+fxNTMyO8=; b=P0
	YJ/UxVVwYkeY7bCN1jVZ5UW2+zV8bQ+kDMJ179Yxd0j636i13Djt+5xKWNugrCiL
	dHd0xKgUrzFNyFGu4xfsQeaBNGmkne3aogUCbNPAkez5psqgXkAihQik5YvXg8aG
	2AKODsZ2fd6aw8XJHDr1GddZ5vA4a7L7HTgo01xsCKv2N7y8IxeMb20NTeAfcD5j
	7vaOdPbnxdCF0eeX04qiUmL+OpwWLXkaP8QLV2ap8EdppAEWbCNA3J91WK65/KJP
	XenLrtHPJYVO5nDDOInDa9XlM8S8gqox8kng4OBV8Ffbg9U6xFjyc1RXNOhlmdU8
	R0jnEkhzA3rzL6vz7CVg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wea7crc09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:07:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI7opn004616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:07:50 GMT
Received: from [10.216.17.87] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 10:07:48 -0800
Message-ID: <c60638be-e12e-4148-8c20-1dbba9c817da@quicinc.com>
Date: Thu, 22 Feb 2024 23:37:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: llcc: Add llcc device availability check
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240220122805.9084-1-quic_mojha@quicinc.com>
From: Sahil Chandna <quic_chandna@quicinc.com>
In-Reply-To: <20240220122805.9084-1-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZF2_eKywI2SVGE_ia8RXTNWssGMPbOdp
X-Proofpoint-GUID: ZF2_eKywI2SVGE_ia8RXTNWssGMPbOdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220142

On 2/20/2024 5:58 PM, Mukesh Ojha wrote:
> When llcc driver is enabled  and llcc device is not
> physically there on the SoC, client can get
> -EPROBE_DEFER on calling llcc_slice_getd() and it
> is possible they defer forever.
> 
> Let's add a check device availabilty and set the
> appropriate applicable error in drv_data.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 4ca88eaebf06..cb336b183bba 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -769,6 +769,27 @@ static const struct qcom_sct_config x1e80100_cfgs = {
>   };
>   
>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
> +static DEFINE_MUTEX(dev_avail);
what is the requirement for mutex lock here? Since we are only trying to 
find if node present or not
> +
> +static bool is_llcc_device_available(void)
> +{
> +	static struct llcc_drv_data *ptr;
> +
> +	mutex_lock(&dev_avail);
> +	if (!ptr) {
> +		struct device_node *node;
> +
> +		node = of_find_node_by_name(NULL, "system-cache-controller");
> +		if (!of_device_is_available(node)) {
> +			pr_warn("llcc-qcom: system-cache-controller node not found\n");
> +			drv_data = ERR_PTR(-ENODEV);
> +		}
> +		of_node_put(node);
> +		ptr = drv_data;
> +	}
> +	mutex_unlock(&dev_avail);
> +	return (PTR_ERR(ptr) != -ENODEV) ? true : false;
> +}
>   
>   /**
>    * llcc_slice_getd - get llcc slice descriptor
> @@ -783,7 +804,7 @@ struct llcc_slice_desc *llcc_slice_getd(u32 uid)
>   	struct llcc_slice_desc *desc;
>   	u32 sz, count;
>   
> -	if (IS_ERR(drv_data))
> +	if (!is_llcc_device_available() || IS_ERR(drv_data))
>   		return ERR_CAST(drv_data);
>   
>   	cfg = drv_data->cfg;


