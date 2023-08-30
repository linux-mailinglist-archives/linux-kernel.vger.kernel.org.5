Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22A78D868
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjH3SaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343959AbjH3Rhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:37:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B61193;
        Wed, 30 Aug 2023 10:37:32 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UBRKTb032392;
        Wed, 30 Aug 2023 17:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nNy7eSzdBf2dY0Kyt3YqfNUI/M99itlZDAn9BbT5trI=;
 b=TF9isnwfS8XY1QQ6BaN82nXZG4D54otecktDD8E8xMBuOHdhjHRgX3sgizPR6GnE2dRm
 +94TnTpCpyWKUMLmnUUHSTiWIXPSThGYHQS0DkADL0Xu+7pP5/rVcqUda2k8v/n90YAY
 9Q8ISUyMVx2oXf67pHdatWOofUfvZieFSo/JY5PTto2bMJ74VC7fSxcAtGNwH0TX9BHZ
 3koSrzvV/Kos/wVsWwHco03SBFBB6QndYTAcPFSUr1Yo2HxEHZ1xXgLn1akE2+LLalep
 3bOhvTs6qp8X+cp3HhkkL6cg+8gMX9VP3kXn94lZdtyZzhYPgXKJ1Kp/+xxWhq7eM6l6 jQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st159s9df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 17:37:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UHbIBK001773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 17:37:18 GMT
Received: from [10.216.23.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 10:37:13 -0700
Message-ID: <5bfd0788-d9a5-40e9-225d-a5f6bbd80c29@quicinc.com>
Date:   Wed, 30 Aug 2023 23:07:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V5 1/6] scsi: ufs: qcom: Update offset for
 core_clk_1us_cycles
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-2-quic_nitirawa@quicinc.com>
 <20230828073849.GB5148@thinkpad>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230828073849.GB5148@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FbilSMZ2WT9ZkUHFXATDvkflrJlYQAn1
X-Proofpoint-GUID: FbilSMZ2WT9ZkUHFXATDvkflrJlYQAn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308300162
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/2023 1:08 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 23, 2023 at 09:14:08PM +0530, Nitin Rawat wrote:
>> This Patch updates offset for core_clk_1us_cycles in DME_VS_CORE_CLK_CTRL
> 
> Please do not use "This patch" in commit message. Just reword it in imperative
> form.

Thanks Mani for the review. We Will address the commit text in next 
patchset.

-Nitin


> 
>> register. Offset for core_clk_1us_cycles is changed from Qualcomm UFS
>> Controller V4.0.0 onwards.
>>
>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 19 ++++++++++++++-----
>>   drivers/ufs/host/ufs-qcom.h |  2 ++
>>   2 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index f88febb23123..1108b0cd43b3 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -1297,12 +1297,21 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>>   }
>>
>>   static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -						       u32 clk_cycles)
>> +						       u32 clk_1us_cycles)
> 
> How about "cycles_in_1us", since this value specifies "Number of clk cycles in
> 1us"?
I Will take care of this in next patchset

-Nitin

> 
>>   {
>> -	int err;
>> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	u32 mask = DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
>>   	u32 core_clk_ctrl_reg;
>> +	u32 offset = 0;
>> +	int err;
>> +
>> +	/* Bit mask and offset changed on UFS host controller V4.0.0 onwards */
> 
> This is not offset value, but rather shift. Still, if you use bitfield macros
> as I suggested below, you could get rid of this variable.

I Will take care of this in next patchset

-Nitin

> 
>> +	if (host->hw_ver.major >= 4) {
>> +		mask = MAX_CORE_CLK_1US_CYCLES_MASK_V4;
>> +		offset = MAX_CORE_CLK_1US_CYCLES_OFFSET_V4;
>> +	}
>>
>> -	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
>> +	if (clk_1us_cycles > mask)
>>   		return -EINVAL;
> 
> 	if (!FIELD_FIT(mask, cycles_in_1us))
> 		return -ERANGE;
> 
>>
>>   	err = ufshcd_dme_get(hba,
>> @@ -1311,8 +1320,8 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>>   	if (err)
>>   		return err;
>>
>> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
>> -	core_clk_ctrl_reg |= clk_cycles;
>> +	core_clk_ctrl_reg &= ~(mask << offset);
>> +	core_clk_ctrl_reg |= clk_1us_cycles << offset;
>>
> 
> 	core_clk_ctrl_reg &= ~mask;
> 	core_clk_ctrl_reg |= FIELD_PREP(mask, cycles_in_1us);
> 
>>   	/* Clear CORE_CLK_DIV_EN */
>>   	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
>> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>> index d6f8e74bd538..a829296e11bb 100644
>> --- a/drivers/ufs/host/ufs-qcom.h
>> +++ b/drivers/ufs/host/ufs-qcom.h
>> @@ -129,6 +129,8 @@ enum {
>>   #define PA_VS_CONFIG_REG1	0x9000
>>   #define DME_VS_CORE_CLK_CTRL	0xD002
>>   /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
> 
>> +#define MAX_CORE_CLK_1US_CYCLES_MASK_V4		0xFFF
> 
> #define MAX_CORE_CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
> #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	GENMASK(7, 0)
> 
> - Mani


I will update it. Thanks
-Nitin

> 
>> +#define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
>>   #define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
>>   #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
>>
>> --
>> 2.17.1
>>
> 
