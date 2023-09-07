Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FE7975AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbjIGPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbjIGPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:50:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA91C59CC;
        Thu,  7 Sep 2023 08:40:51 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387DtEDL004974;
        Thu, 7 Sep 2023 14:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t0M+lC4rAAagaeLRUqBbxq9Tce0AeCSEV2tAjKZ6dY8=;
 b=Jwdnhl850xaIrfI9nDU2q0MLnU79ixvnWamUIsjgcX9xmiXN6ErU9xpYydt/t5AkxhbK
 H/C0Ox1QI4Zu2i57/0KSDQWeOySn8FASWLDgmd/Hq+W2VuEMbOn0y9tup4nn0HlFMlJl
 Z7SSXjG+FNlTJg3QF1ETM7r3fC8ihvcPUe82WI8B3A2Fp+Nu59JMuturi7+YXXeU7l47
 l/Vw3c1oBAirI/svlRvNlgVkr0BvAh7T6EGeBTSySrEXnKuaq/9oxDpEuI0QyCOGD5ek
 dUpn6SRTdwz+wqFWqd9Xqr5F+X6D0b6SH08HmNouZ3i3lU0L9G3CMzD8gqLVjG6HNAQ6 LQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy4bqhftn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 14:20:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 387EK1GB011421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 14:20:01 GMT
Received: from [10.110.56.75] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 7 Sep
 2023 07:20:00 -0700
Message-ID: <d79fe150-9930-d351-f096-7d2216526587@quicinc.com>
Date:   Thu, 7 Sep 2023 07:20:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/3] Add qcom hvc/shmem transport
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230811175719.28378-1-quic_nkela@quicinc.com>
 <3342d8bf-5281-c082-cb9a-7a027b413237@quicinc.com>
 <f5b05cfa-f12c-4f4d-a801-3aa76d843d6d@linaro.org>
 <20230907103619.2kqh7tfivwdfm5rd@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230907103619.2kqh7tfivwdfm5rd@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: weVwHyWYPHpU_KGtnAQ4_EN4Hk8UIdIE
X-Proofpoint-ORIG-GUID: weVwHyWYPHpU_KGtnAQ4_EN4Hk8UIdIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070127
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/2023 3:36 AM, Sudeep Holla wrote:
> On Tue, Sep 05, 2023 at 06:37:14PM +0200, Krzysztof Kozlowski wrote:
>> On 05/09/2023 18:06, Nikunj Kela wrote:
>>> On 8/11/2023 10:57 AM, Nikunj Kela wrote:
>>>> This change introduce a new transport channel for Qualcomm virtual
>>>> platforms. The transport is mechanically similar to ARM_SCMI_TRANSPORT_SMC.
>>>> The difference between the two transports is that a parameter is passed in
>>>> the hypervisor call to identify which doorbell to assert. This parameter is
>>>> dynamically generated at runtime on the device and insuitable to pass via
>>>> the devicetree.
>>>>
>>>> The function ID and parameter are stored by firmware in the shmem region.
>>>>
>>>> This has been tested on ARM64 virtual Qualcomm platform.
>>>>
>>>> ---
>>>> v3 -> fix the compilation error reported by the test bot,
>>>>         add support for polling based instances
>>>>
>>>> v2 -> use allOf construct in dtb schema,
>>>>         remove wrappers from mutexes,
>>>>         use architecture independent channel layout
>>>>
>>>> v1 -> original patches
>>>>
>>>> Nikunj Kela (3):
>>>>     dt-bindings: arm: convert nested if-else construct to allOf
>>>>     dt-bindings: arm: Add qcom specific hvc transport for SCMI
>>>>     firmware: arm_scmi: Add qcom hvc/shmem transport
>>>>
>>>>    .../bindings/firmware/arm,scmi.yaml           |  67 ++---
>>>>    drivers/firmware/arm_scmi/Kconfig             |  13 +
>>>>    drivers/firmware/arm_scmi/Makefile            |   2 +
>>>>    drivers/firmware/arm_scmi/common.h            |   3 +
>>>>    drivers/firmware/arm_scmi/driver.c            |   4 +
>>>>    drivers/firmware/arm_scmi/qcom_hvc.c          | 232 ++++++++++++++++++
>>>>    6 files changed, 293 insertions(+), 28 deletions(-)
>>>>    create mode 100644 drivers/firmware/arm_scmi/qcom_hvc.c
>>> Gentle Ping!
> Pong !
>
>> It's third ping these two weeks from Qualcomm. Folks, it is merge
>> window. What do you think will happen with your ping during this time?
>>
> +1
>
> Okay, here is the deal with this patch set. As you are aware that a previous
> merged solution was abandoned by Qcom in a single kernel release cycle. So
> I decided to ignore this for one or 2 kernel release cycle to make sure
> Qcom makes up their mind on the design and then we can see how to proceed.
> Qcom must understand upstream kernel is not a playground to push their
> design which they might decided to drop support for in such short period.
> Please understand the upstream kernel supports platforms that are more than
> few decades old. It is not like the mobile platforms that are hardly supported
> for couple of years. And similarly, we push core support if and only if we
> know for sure it will be used on some platform. I trusted Qcom with the
> previous extension of SMC/HVC transport but I was proven wrong.
>
> Also, I definitely don't like the way you have copied the whole smc.c
> and changed it to Qcom's need and made it qcom_hvc.c. Just add the required
> changes in smc.c.
>
> --
> Regards,
> Sudeep

Completely understand your concerns and extending my apologies once 
again on the patch that was abandoned. I will rework the patch to 
include changes in smc.c. Thanks so much for your response!

