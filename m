Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F1771932
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjHGE5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHGE44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:56:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1897710FA;
        Sun,  6 Aug 2023 21:56:55 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3773HAsG031716;
        Mon, 7 Aug 2023 04:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0/lbdb/+7v694KPCB0+Yf6v5bY2sol9CUMzyHX0oeu8=;
 b=fZXVDWPImD626O+lgTBT2W6r3YYX2xdbwEE/D4VyH2lu58TYcDZtq2HW/GMv5Bau8N+Y
 OW66zJgDJ7p4E7TnV7YSmkAXIdvU3U3NtC9XgqONWTUArnwqkO52IbXvoy0PDatWZ7C+
 i+SaVdXYctpiK5sbffMySeIOwWyHnCJXzOozqoFiUNadFPfN0uMgVWxQQ0wngz/FGQhS
 4ZT7vHRtu8DaCRsaX7zE4FdNNSsCRPMDOH3IDho++fE94QfSvbvVpYAWNQa11vFwB87h
 mEQPJL0xAFGGltUchjXV66IjJS+RX6XrvYzw9HHAiXIlRp1jPDU0gz6jUlGImwrcfuOE 5w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9e16tk2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 04:56:43 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3774ugol002413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 04:56:42 GMT
Received: from [10.79.198.38] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 6 Aug
 2023 21:56:40 -0700
Message-ID: <3e88342b-0faa-aca5-118a-6e9ac6955298@quicinc.com>
Date:   Mon, 7 Aug 2023 10:26:37 +0530
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
 <93722831-dc83-8ea3-4af9-33eaefcf81be@quicinc.com>
 <202308011934080c7083b9@mail.local>
 <43055e2f-963c-a738-964e-d483c751d913@quicinc.com>
 <20230803133940eef87e40@mail.local> <20230803134029e0470f25@mail.local>
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
In-Reply-To: <20230803134029e0470f25@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vkqIEqsflGaruOt8RRBfFnUJl2y3v1E1
X-Proofpoint-ORIG-GUID: vkqIEqsflGaruOt8RRBfFnUJl2y3v1E1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070043
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2023 7:10 PM, Alexandre Belloni wrote:
> On 03/08/2023 15:39:41+0200, Alexandre Belloni wrote:
>> On 03/08/2023 19:01:51+0530, Anvesh Jain P wrote:
>>>
>>>
>>> On 8/2/2023 1:04 AM, Alexandre Belloni wrote:
>>>> On 01/08/2023 18:18:46+0530, Anvesh Jain P wrote:
>>>>> In automotive systems, RTC should not wake up the device when it is parked
>>>>> or when it is garage to avoid leakage current. providing a control from
>>>>> device tree to avoid RTC wake up based on the use case is reason for this
>>>>> patch.
>>>>>
>>>>
>>>> Then simply avoid providing an IRQ or setting an alarm.
>>> The purpose of the change is just to block alarms/notifications waking up
>>> the target when it is in Suspend2ram(low power) mode.
>>> if we disable IRQ, alarms/notifications won't come even when the target is
>>> in active mode.
>>> This change will just stop the wake up capability of the alarm when target
>>> is in suspend 2 ram mode based on flag passed from device tree.
>>> Use case of this patch is,
>>> In mobile targets where alarms / notifications will need to wake up the
>>> target when there is a reminder as per user expectation.
>>> where as in automotive targets, when driver is not in Car and target is in
>>> suspend state, alarms/notifications would have no meaning and waking up the
>>> target of no use as there is no user to attend the message. hence blocking
>>> them in automotive use cases based on device tree is the use of this patch.
>>
>> Simply remove the alarm before going to suspend, this is a userspace
>> policy, it has nothing to do in the device or kernel.
> s/device/device tree/ obviously.
> 
How to remove from userspace?, if we remove all alarms from userspace, 
will the alarms expiring after wake up would be restored while target 
resumes from suspend 2 ram?
The change would not change alarms behavior. it blocks all notifications 
causing wake up if "disable-alarm-wakeup" property defined in device 
tree. if it is not defined, current behavior of alarm won't change.
>>
>>>>
>>>>> On 8/1/2023 6:10 PM, Alexandre Belloni wrote:
>>>>>> On 01/08/2023 17:15:49+0530, Anvesh Jain P wrote:
>>>>>>> Enable & disable rtc alarm wake up capability based on
>>>>>>> default parameter passed from device tree.
>>>>>>>
>>>>>>
>>>>>> I see what you are doing but not why this is necessary, NAK.
>>>>>>
>>>>>>> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
>>>>>>> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
>>>>>>> ---
>>>>>>>     drivers/rtc/rtc-pm8xxx.c | 3 +++
>>>>>>>     1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
>>>>>>> index f6b779c12ca7..bed57be602b6 100644
>>>>>>> --- a/drivers/rtc/rtc-pm8xxx.c
>>>>>>> +++ b/drivers/rtc/rtc-pm8xxx.c
>>>>>>> @@ -523,6 +523,9 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>>>>>>>     	if (rc)
>>>>>>>     		return rc;
>>>>>>> +	if (of_property_read_bool(pdev->dev.of_node, "disable-alarm-wakeup"))
>>>>>>> +		device_set_wakeup_capable(&pdev->dev, false);
>>>>>>> +
>>>>>>>     	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
>>>>>>>     	if (rc)
>>>>>>>     		return rc;
>>>>>>>
>>>>>>> base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
>>>>>>> -- 
>>>>>>> 2.17.1
>>>>>>>
>>>>>>
>>>>
>>
>> -- 
>> Alexandre Belloni, co-owner and COO, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
> 
