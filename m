Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8278EEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjHaNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjHaNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:45:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F1B10CC;
        Thu, 31 Aug 2023 06:44:51 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VAAXEX010942;
        Thu, 31 Aug 2023 13:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CsUqty+tEdcqEjxfZdONlt7bjxSCuO7vjKATurZvY7o=;
 b=meVD1rVw8DuKGsT28FijUoVNWIPwhFAHBzo9lNUYSmGEXz8hs4GSuLBsbbrM7nypTRUv
 dislUC2gGFNcKp1gnQqtFLtN+jxl+uIdERyxzOfPdIU/E0nkRyYN0lBGlD32o3aTAr+J
 w+WY9FNVyQDpFZkUk+Xs4G/nm3h3ZIS6bdDMYXtRdXJ4nZbEvt4qgYKaetMVV0fpIZeQ
 D7A6zMweMjUS7cHiA2gHIrgx1yZYnn4qVSVyG+DaY16INlrXr3dJqhAn4rzeWym/NcAV
 OcnOEgl2dpVtJ1DHodvOFM47lnCN1mtnXId1drPYC2Yyvwy+n8Bn55uXoe+lX3aQtkzn tw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st0taucju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 13:43:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VDhg1n031521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 13:43:42 GMT
Received: from [10.216.37.211] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 06:43:38 -0700
Message-ID: <a02d4c5d-86e4-3e65-bffb-b5310bbd2432@quicinc.com>
Date:   Thu, 31 Aug 2023 19:13:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 3/6] nvmem: core: Add stub for nvmem_cell_read_u8
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <bryan.odonoghue@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
 <20230830105654.28057-4-quic_kbajaj@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230830105654.28057-4-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2N8lzmxzVzd6TjEZKCfw8LPBdkR1j_Zv
X-Proofpoint-ORIG-GUID: 2N8lzmxzVzd6TjEZKCfw8LPBdkR1j_Zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310122
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 4:26 PM, Komal Bajaj wrote:
> Add the stub nvmem_cell_read_u8() function for drivers running with
> CONFIG_NVMEM disabled.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   include/linux/nvmem-consumer.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 4523e4e83319..6ec4b9743e25 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -127,6 +127,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
>   	return -EOPNOTSUPP;
>   }
> 
> +static inline int nvmem_cell_read_u8(struct device *dev,
> +				     const char *cell_id, u8 *val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline int nvmem_cell_read_u16(struct device *dev,
>   				      const char *cell_id, u16 *val)
>   {
> --
> 2.41.0
> 
