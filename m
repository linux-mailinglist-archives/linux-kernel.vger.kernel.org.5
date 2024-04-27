Return-Path: <linux-kernel+bounces-160836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7258B4368
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398B4283ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A4B2E416;
	Sat, 27 Apr 2024 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uo8bzQGl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B952D627;
	Sat, 27 Apr 2024 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714179836; cv=none; b=mEut1vzQ6kkHD8iMaXLcB0GJCZ731Spi3TNYCf8chxpm3navRiudANKjoVYjcrhvvdQIt+3gZ0/XkU5GSEWwlvxHriI8rSRopNFh89UbrGqvEGxqO5BYBAXHygI8v0lY53OtFm6RpnRl+t3I1YKWiOYHShNGkgglelUOB2jxMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714179836; c=relaxed/simple;
	bh=wYFR5Jwm6sJT7rAqaF5ytlgZfLgTIhtKlQoOLL4qvGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y4wdF2XVaBM6TzTUxhdRsEBVb00kOp0+etjUECrCyq3bD/kObKwiE9bGlCQ3OmEDrIo4yqPapbucH/OQThNjuO9v/kZd9f+o3jreAGB+YpuxDs+yX4N9E5LnbkesbuJeaohAsV13UFgFB4BXsaXs45fdNY1tpg4pEOr4n8czHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uo8bzQGl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43R0guAm002902;
	Sat, 27 Apr 2024 01:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+/vH5sNN1cJT9Kyhu3EW40Dh97RLGyJ0/8gBBv7WljQ=; b=Uo
	8bzQGld610YvOw+pdW0HPHemdbU/YyEo+DuwAEpk/LXI/IybGB1qbpNXfa+BxAfz
	jMdurpkmQ69z92iQY9iiYOkpxQ4oTR3uGuPCCCfWSNmMG1uizEqtTS1gXyeDx0vI
	rlxZwM24bb+ybpy5ZvlnERUrUnxonajJSz0QpS7yZPaY/arlCOBxaKYVzXtVcnxx
	SfEihrp88ZKPkwLXlxLhbTTCAWTsQbpb7DV31Q2+Qto7HuccE+fFFnYEGnVpzqpM
	qKXb1N8xlUNncydrjYiS0aaqwBFWLuiO2Eh+hPDaaQ31r4wZehaKXi0UWmCrvjvn
	BhE8ViSw81MzAAmrLJIQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr7yg23n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 01:03:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43R13kSx015509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 01:03:47 GMT
Received: from [10.110.11.138] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 18:03:46 -0700
Message-ID: <f1ee1fc0-64cb-5610-db92-3a06d477e8b8@quicinc.com>
Date: Fri, 26 Apr 2024 18:03:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 6/6] remoteproc: qcom: enable in-kernel PD mapper
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Xilin Wu <wuxilin123@gmail.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
 <20240424-qcom-pd-mapper-v7-6-05f7fc646e0f@linaro.org>
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240424-qcom-pd-mapper-v7-6-05f7fc646e0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dDFGYWOFj9rGgfhMFqOThmJg_v9db-1p
X-Proofpoint-ORIG-GUID: dDFGYWOFj9rGgfhMFqOThmJg_v9db-1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_21,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404270005



On 4/24/2024 2:28 AM, Dmitry Baryshkov wrote:
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 1d24c9b656a8..02d0c626b03b 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -23,6 +23,7 @@
>   #include <linux/remoteproc.h>
>   #include <linux/reset.h>
>   #include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/soc/qcom/pd_mapper.h>
>   #include <linux/soc/qcom/smem.h>
>   #include <linux/soc/qcom/smem_state.h>
>   
> @@ -375,10 +376,14 @@ static int adsp_start(struct rproc *rproc)
>   	int ret;
>   	unsigned int val;
>   
> -	ret = qcom_q6v5_prepare(&adsp->q6v5);
> +	ret = qcom_pdm_get();
>   	if (ret)
>   		return ret;

Would it make sense to try and model this as a rproc subdev? This 
section of the remoteproc code seems to be focused on making specific 
calls to setup and enable hardware resources, where as pd mapper is 
software.

sysmon and ssr are also purely software and they are modeled as subdevs 
in qcom_common. I'm not an expert on remoteproc organization but this 
was just a thought.

Thanks!
Chris

>   
> +	ret = qcom_q6v5_prepare(&adsp->q6v5);
> +	if (ret)
> +		goto put_pdm;
> +
>   	ret = adsp_map_carveout(rproc);
>   	if (ret) {
>   		dev_err(adsp->dev, "ADSP smmu mapping failed\n");
> @@ -446,6 +451,8 @@ static int adsp_start(struct rproc *rproc)
>   	adsp_unmap_carveout(rproc);
>   disable_irqs:
>   	qcom_q6v5_unprepare(&adsp->q6v5);
> +put_pdm:
> +	qcom_pdm_release();
>   
>   	return ret;
>   }


