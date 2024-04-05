Return-Path: <linux-kernel+bounces-133273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E089A183
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E298CB2683F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8F16FF3F;
	Fri,  5 Apr 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kHCC7GFO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F01DFE4;
	Fri,  5 Apr 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331639; cv=none; b=KeAoc0+jEjQPV3p46psV0UsnZTY1vYrnFDBhKmgK/GfRb22SY9QERSRkyDfUDlMcxS65uluRIacCTOf6ZpS0jSAH8M3m7wmrfhGDxw8RXMx8Tu49C31qDrwKgAjvHSrHcHyLq6g/+wkw5sBI2qUd/AAzJsfn2b3Q0/+Gxa8/Lko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331639; c=relaxed/simple;
	bh=4UDA8EzJ3gi3sEkXmx8zXPtWkdeeRDoSfpA2OojKLk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lKfty24x1h2q9hXp/fm83Q1gjPXds/1VbD5IJ52EJXchmVmVJXHGYrQ23LFEGwd3kk1D7RQvxDcCmWa9Hk3NlcfkGKLjEDOo+Gey5A6YmmtBd/ZWfrpa5N2cDGLSf9AzaFDiiKSe5QplIib590YJVmQ5oyHxK3MmsY5Ybd5OuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kHCC7GFO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4358pWOO029031;
	Fri, 5 Apr 2024 15:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=X+Y5OX1FpF9VGjA2FJHiIXJLIoXc2ByicoZVy2EgtYk=; b=kH
	CC7GFOOZtMslgpfDymwTT5rZ1bsKTI4oUKD5qQfCNY6bUAKOd8QIQE8e+NZR2zWS
	imF4d7OXcrYn/7hIhU9RCH1MirBZVSc3HiKDA+l8T2AHgP1rbuCiL+YwwxP35Woe
	cGk/1NUqSXv+rGvkAeRObCG//SxcvZ4l74JjP932RZzJ9Y+Z7cRrkW6+M7lzscCe
	vW3cyyz0YZ6a012q59HF1HjyRhBkmeKgXhv5XWSBEew1/zVkFcnaiMR80zXyrWow
	IYVy8jOX3jamLrCjR4B0FZ6r2q/nO7JPQdClYhBnEOHbMU3mf+WzXJo/tWkrk8/M
	7o+PSm+ypCt26oPgU4mg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa4ej9wx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:40:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FeXLJ006442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:40:33 GMT
Received: from [10.216.23.38] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:40:31 -0700
Message-ID: <88d2f908-0b29-8ba2-04aa-adab13bf77fc@quicinc.com>
Date: Fri, 5 Apr 2024 21:10:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] firmware: qcom: scm: Remove log reporting memory
 allocation failure
Content-Language: en-US
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LnTB7ACKVvgXu35v4H0DuEBECzYT-ycb
X-Proofpoint-GUID: LnTB7ACKVvgXu35v4H0DuEBECzYT-ycb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050112

Gentle ping..

-Mukesh

On 3/21/2024 8:53 PM, Mukesh Ojha wrote:
> Remove redundant memory allocation failure.
> 
> WARNING: Possible unnecessary 'out of memory' message
> +       if (!mdata_buf) {
> +               dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
> Changes in v2: https://lore.kernel.org/lkml/20240227155308.18395-7-quic_mojha@quicinc.com/
>   - Added R-by tag
> 
>   drivers/firmware/qcom/qcom_scm.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 49ddbcab0680..a11fb063cc67 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -554,10 +554,9 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>   	 */
>   	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
>   				       GFP_KERNEL);
> -	if (!mdata_buf) {
> -		dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
> +	if (!mdata_buf)
>   		return -ENOMEM;
> -	}
> +
>   	memcpy(mdata_buf, metadata, size);
>   
>   	ret = qcom_scm_clk_enable();

