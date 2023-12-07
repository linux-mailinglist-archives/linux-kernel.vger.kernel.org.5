Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A080832A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378271AbjLGIhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjLGIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:37:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3736ED7E;
        Thu,  7 Dec 2023 00:37:08 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B778A6S008789;
        Thu, 7 Dec 2023 08:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tUM5+ayb6HVh/mMV/yVkH5oTfjcL4aN8S+wZ04hIcZo=;
 b=GB7lHicPYt4tqTYL8ZVLzRrFL86+dT9I8rNfPgydUzyFX9QlcTiEAgIjYLv6IX+3C7NM
 pBBjgIu0SidcBT5KAqVQvZgpgh8f/Cksemoax+0W3pYmNGt87Q4GkqHFc5qI57+qGZgP
 ZPCFwX5fngNXIw22062/02r9KMldzWS5U5GHq/iMiGCTjPLAOh4pb8NngKIiRqArD42P
 o3HKkTAhfHiYNvdr0v1Pxks3WL6+oZmLug9weBm9lkenKqhkMCL4lDIOQe99C8VhgELf
 lc79NyN8j36djoX37+q2TaFLbxPHhO4AgAB+U4WvgCtHprL56dhsN64mjt8naNX9XJol qQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu928g6ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 08:37:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B78b0SU013346
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 08:37:00 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 00:36:56 -0800
Message-ID: <d95cc83b-0a84-a408-00de-42d6ab1c0c9d@quicinc.com>
Date:   Thu, 7 Dec 2023 14:06:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 09/13] scsi: ufs: qcom: Remove redundant error print for
 devm_kzalloc() failure
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-10-manivannan.sadhasivam@linaro.org>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20231201151417.65500-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E5eAyF2vNKCixqYHRSkb3LRHmW4R3TWQ
X-Proofpoint-GUID: E5eAyF2vNKCixqYHRSkb3LRHmW4R3TWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070069
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/2023 8:44 PM, Manivannan Sadhasivam wrote:
> devm_kzalloc() will itself print the error message on failure. So let's get
> rid of the redundant error message in ufs_qcom_init().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index e4dd3777a4d4..218d22e1efce 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1107,10 +1107,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   	struct ufs_clk_info *clki;
>   
>   	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> -	if (!host) {
> -		dev_err(dev, "%s: no memory for qcom ufs host\n", __func__);
> +	if (!host)
>   		return -ENOMEM;
> -	}
>   
>   	/* Make a two way bind between the qcom host and the hba */
>   	host->hba = hba;

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
