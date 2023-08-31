Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA70278E91F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbjHaJMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjHaJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:12:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D1CE6;
        Thu, 31 Aug 2023 02:11:55 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V8tHlv015369;
        Thu, 31 Aug 2023 09:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2Ni+LN54ptRu3wMOurUGZQ7wALqnhaXwi94sDz1xNhw=;
 b=Kk8czsefijKcgPnV6lDlxNKeOZkuDyzes4Sijv7s8aC9P3AQCNGHmx2cZd8y5Vj6I62T
 71LkXvAa5VTrmVBC8RY5BgJfOnw5Pn0Trh0aG+O32dTR6bmiUFtN/P9PAkop/0L/Cj+4
 MO6pZrzTd9gRizh3bPZQ3GGzYXvQgkpgdxdMZNaJBoE0mpOWL9jLAkkQLufIGNfkluAq
 rqEJC60bT912bi0dzZqMcJGyZFVWXMGncSqem2k/8LMiMG2sHz/4NxFXhkH1WPCEG9v7
 WkOLXq5FF883USCupE9eRcS2DnuRywGkTP/Sj49KVuPLe/FPhG9VEfU3VP+D2/a4qOi9 Ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssy5q2nha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 09:11:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V9Bil6020936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 09:11:44 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 02:11:39 -0700
Message-ID: <d7a94b02-ae0a-dc58-f013-ad63333327d4@quicinc.com>
Date:   Thu, 31 Aug 2023 14:41:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V5 4/6] scsi: ufs: qcom: Align unipro clk attributes as
 per Hardware specification
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-5-quic_nitirawa@quicinc.com>
 <20230828080811.GE5148@thinkpad>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230828080811.GE5148@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NOm5rxoqpU0XrSbH_ixV1ynVK_dKDoJr
X-Proofpoint-GUID: NOm5rxoqpU0XrSbH_ixV1ynVK_dKDoJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_07,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310082
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2023 1:38 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 23, 2023 at 09:14:11PM +0530, Nitin Rawat wrote:
>> Currently CORE_CLK_1US_CYCLES, PA_VS_CORE_CLK_40NS_CYCLES are configured
>> in clk scaling post change ops. Move this to clk scaling pre change ops to
>> align with the hardware specification.
>>
> 
> Does this mean, the driver was doing the clk scaling at the wrong time? If so,
> this patch should be moved ahead of all patches, should have fixes tag and CC
> stable list.
> 
> - Mani
> 

-- Functionality wise there is no affect with this patch. Our Qcom 
internal Hardware specification suggest to program these timers
in pre clk scale. SO we wanted to align with the HPG.

-Nitin




>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 8162b19191a9..491c0173603e 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -1399,12 +1399,6 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>>   }
>>
>>   static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>> -{
>> -	/* nothing to do as of now */
>> -	return 0;
>> -}
>> -
>> -static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>
>> @@ -1414,6 +1408,11 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>>   	return ufs_qcom_cfg_core_clk_ctrl(hba);
>>   }
>>
>> +static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>> +{
>> +	return 0;
>> +}
>> +
>>   static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> --
>> 2.17.1
>>
> 
