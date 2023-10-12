Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FBF7C65B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377443AbjJLGgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377275AbjJLGge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:36:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1E8BE;
        Wed, 11 Oct 2023 23:36:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C5tu39028698;
        Thu, 12 Oct 2023 06:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Pw3jAkv2N7sjbwu9Davi8lxxfieHB88a1r7zD0/s9K8=;
 b=EHFeLzr2ah6j1pLzojsK/UeNUaY+V5+QybOt6nfl269zp+FCfmuCHvY96elzxhCwMmsj
 RRNYnDMYNYSRmYY+haltVFk/AqqZ36E1chVXVG0oxN2sIMYYW4tAwBUuaOIVHAaqfBo7
 RfYRQvVUeeEWWm2ifVLMjzCjfguDUum3nlpxLxHi5kARUXb3LZkUTjhxNnY9axBKpXd/
 mowJVrnhQ2d6dojZzLx9Lt8sGZrVB1f0hIgg+2FrIc+IHpL85aGs1mEMeZYTquDqSu0I
 ZJjMU4bLy0jrQW7HX5zaXPMKjFa8E743oz2yd4GQ/Lz3R3LXGN4aGRjsiffyPooalOAH Qg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnstytj68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 06:36:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39C6aPGH030709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 06:36:25 GMT
Received: from [10.110.93.117] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 23:36:25 -0700
Message-ID: <845e2747-535e-80e0-342b-e5343bd620aa@quicinc.com>
Date:   Wed, 11 Oct 2023 23:36:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: llcc: Fix LLCC_TRP_ATTR2_CFGn offset
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avinash Philip <quic_avinashp@quicinc.com>,
        Umnathi Chalicheemala <quic_uchalich@quicinc.com>
References: <20231012061127.95637-1-abel.vesa@linaro.org>
Content-Language: en-US
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
In-Reply-To: <20231012061127.95637-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vlfBxGbju9vImbXuTE9pS-u5PmSfuEyb
X-Proofpoint-GUID: vlfBxGbju9vImbXuTE9pS-u5PmSfuEyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=719 lowpriorityscore=0 clxscore=1011
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120056
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2023 11:11 PM, Abel Vesa wrote:
> According to documentation, it has increments of 4, not 8.
>
> Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
> Reported-by: Umnathi Chalicheemala <quic_uchalich@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Thanks Abel.

Reviewed-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>

> ---
>   drivers/soc/qcom/llcc-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 674abd0d6700..fb4085b7cb19 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -47,7 +47,7 @@
>   #define LLCC_TRP_STATUSn(n)           (4 + n * SZ_4K)
>   #define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
>   #define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
> -#define LLCC_TRP_ATTR2_CFGn(n)        (0x21100 + SZ_8 * n)
> +#define LLCC_TRP_ATTR2_CFGn(n)        (0x21100 + SZ_4 * n)
>   
>   #define LLCC_TRP_SCID_DIS_CAP_ALLOC   0x21f00
>   #define LLCC_TRP_PCB_ACT              0x21f04
