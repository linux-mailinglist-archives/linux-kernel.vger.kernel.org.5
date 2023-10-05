Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B9B7BAE2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjJEVv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJEVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:51:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80E9E;
        Thu,  5 Oct 2023 14:51:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395Lk9ID008481;
        Thu, 5 Oct 2023 21:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Viu3LjCg+nNUsV+HufaTsTHKmI5wxtsYvzyN9kVT2XI=;
 b=S4R2zfLxczirmvgMYFY1qLQ8rFmAj1CsN0x0FWPYn52yfthFC4ake9hYYs+p6eHQQRyI
 XdDCDdStD/OrgADASq3qrrCsH+4aGu7X59sXv7y3Cgut1Kx8N/iUxb24Yoc6L/uphqAx
 xJ8B0molGCpUBxpH7urvtehuO+IWkDPTtMQFWPthA9w2bqSHwO4IPD+aTBjsQludXR8F
 rD88RzCeFKe21yVrr2449DGD0OiltX8Ewa5qVvf9i6VM+JkeDZ12BBrIvm0mN0zs/dRW
 h1x2tX1kXC5YDI2pqJrwXxRYaoDYjrUglqCB/+MCcjCQ/HgFKxWJospG3ad8043Zz/eF iw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8e1v0hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 21:51:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395LpT2R011848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 21:51:29 GMT
Received: from [10.110.20.163] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 5 Oct
 2023 14:51:29 -0700
Message-ID: <2c196f9a-b61e-914b-1999-e9e82d16dc6e@quicinc.com>
Date:   Thu, 5 Oct 2023 14:51:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/4] dt-bindings: arm: Add new compatible for smc/hvc
 transport for SCMI
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-4-quic_nkela@quicinc.com>
 <20231003104404.o7yxg3y7dn7uhrq4@bogus>
 <7c871b23-5544-6604-257d-f0c8fd5afd06@quicinc.com>
 <20231004155310.zqwlj6boy65atoyq@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231004155310.zqwlj6boy65atoyq@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3IJBeV3tF0Is9MaS0KLzcGoF_PMa2-QG
X-Proofpoint-ORIG-GUID: 3IJBeV3tF0Is9MaS0KLzcGoF_PMa2-QG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_16,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050166
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/2023 8:53 AM, Sudeep Holla wrote:
> On Tue, Oct 03, 2023 at 08:59:45AM -0700, Nikunj Kela wrote:
>> On 10/3/2023 3:44 AM, Sudeep Holla wrote:
>>> On Mon, Sep 11, 2023 at 12:43:58PM -0700, Nikunj Kela wrote:
>>>> Introduce compatible "qcom,scmi-hvc-shmem" for SCMI smc/hvc
>>>> transport channel for Qualcomm virtual platforms.
>>>> The compatible mandates a shared memory channel.
>>>>
>>>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    .../devicetree/bindings/firmware/arm,scmi.yaml       | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>>> index 8d54ea768d38..4090240f45b1 100644
>>>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>>> @@ -45,6 +45,9 @@ properties:
>>>>          - description: SCMI compliant firmware with OP-TEE transport
>>>>            items:
>>>>              - const: linaro,scmi-optee
>>>> +      - description: SCMI compliant firmware with Qualcomm hvc/shmem transport
>>>> +        items:
>>>> +          - const: qcom,scmi-hvc-shmem
>>> Can it be simply "qcom,scmi-smc" for 2 reasons ?
>>> 1. We don't support SMC/HVC without shmem, so what is your argument to add
>>>      '-shmem' in the compatible here ?
>> In our platforms, there are multiple ways to allocate memory. One is
>> preallocated shmem as used here, another is dynamically by hypervisor APIs.
>> shmem was to just to indicate it is preallocated.
>>
> Let us keep it without shmem. If it is dynamically allocated, you must not
> need another compatible as you can check it at the runtime.
>
>>> 2. The exact conduit(SMC/HVC) used is detected runtime, so I prefer to keep
>>>     '-smc' instead of '-hvc' in the compatible just to avoid giving an illusion
>>>     that HVC is the conduit chosen here based on the compatible. It can be true
>>>     for other reason but I don't want to mislead here by using HVC.
>> IUUC, currently, conduit comes from PSCI dt node. We have been using smc for
>> PSCI but want to use hvc here. That being said, I am fine to explore if we
>> can change PSCI to use hvc too.
>>
> I think only OPTEE has explicit conduit other than PSCI and it is continued
> for legacy/compatibility reasons IIUC and IIRC. Anything else depends on
> the conduit used by PSCI to be consistent. So yes you need to use what the
> PSCI conduit is and you don't need the extra information from the DT either
> as new property or in the compatible.

Ok, will use conduit then. Thanks!


>
