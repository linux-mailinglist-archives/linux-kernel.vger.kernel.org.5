Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4A76B509
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjHAMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjHAMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:49:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F881FE8;
        Tue,  1 Aug 2023 05:48:58 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371BwI94020315;
        Tue, 1 Aug 2023 12:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lO8iRJ5BxseYDtBv/6lCALxp9w+PuCIgdsJZR+zOHTw=;
 b=m6G8LkHGS6zvtqIe7H2dAbMUIL6QpTBvLB5+zVmha8oWbuxEEGYqzzSg042bpAJdjOa/
 J2XfMbBo1MeL+y0TqgfdtFFG436EVXltH70gVRWa3tmI3vrQX65z/pOOexNWiV3YbAQL
 vKxi9utIWS2I9bTHYDMljzF87a2HmM6DcTIJWg2PyJOcBu3cu74ro/cp2R5dvgVHPTvH
 LKV1XkNTsWNmm26tCntD5LWBEMWY/8KIUJWlMez82y6qDAeQsIUvQIo5Yzm092m4sm6N
 XIM3anvmOtPZTaGbAbkfSw2ZrO4hxf7LCmau1eb63VGXfHlKpL0uE1eBMfTZVWFKHJIv fg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8gu0yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 12:48:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371Cmq9X028439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 12:48:52 GMT
Received: from [10.50.50.103] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 1 Aug
 2023 05:48:49 -0700
Message-ID: <93722831-dc83-8ea3-4af9-33eaefcf81be@quicinc.com>
Date:   Tue, 1 Aug 2023 18:18:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] rtc: rtc-pm8xxx: control default alarm wake up capability
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>
References: <20230801114549.26956-1-quic_ajainp@quicinc.com>
 <20230801124056fc665814@mail.local>
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
In-Reply-To: <20230801124056fc665814@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6XknqgoECvmkz7_VDj7s_z0CQaMd5bdR
X-Proofpoint-GUID: 6XknqgoECvmkz7_VDj7s_z0CQaMd5bdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_08,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010115
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In automotive systems, RTC should not wake up the device when it is 
parked or when it is garage to avoid leakage current. providing a 
control from device tree to avoid RTC wake up based on the use case is 
reason for this patch.

On 8/1/2023 6:10 PM, Alexandre Belloni wrote:
> On 01/08/2023 17:15:49+0530, Anvesh Jain P wrote:
>> Enable & disable rtc alarm wake up capability based on
>> default parameter passed from device tree.
>>
> 
> I see what you are doing but not why this is necessary, NAK.
> 
>> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
>> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
>> ---
>>   drivers/rtc/rtc-pm8xxx.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
>> index f6b779c12ca7..bed57be602b6 100644
>> --- a/drivers/rtc/rtc-pm8xxx.c
>> +++ b/drivers/rtc/rtc-pm8xxx.c
>> @@ -523,6 +523,9 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>>   	if (rc)
>>   		return rc;
>>   
>> +	if (of_property_read_bool(pdev->dev.of_node, "disable-alarm-wakeup"))
>> +		device_set_wakeup_capable(&pdev->dev, false);
>> +
>>   	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
>>   	if (rc)
>>   		return rc;
>>
>> base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
>> -- 
>> 2.17.1
>>
> 
