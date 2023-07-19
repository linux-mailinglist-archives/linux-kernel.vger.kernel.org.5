Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A31759796
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGSN7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGSN7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:59:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523C91;
        Wed, 19 Jul 2023 06:59:01 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JDbaao011166;
        Wed, 19 Jul 2023 13:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Cvx7lE61Bczyl3Hf+n6uK9UzB172L3V3Dtrks/ggwBY=;
 b=CFBTi7jhYfreTUAc8D7jXJQ7oF6HRAk3q+fX6POVelmyACb0DewMZn/337tRo8SSC43Y
 A/1+TT5qhzdh8y7vLv+IWR+GsVTtm77cSFsmbcbmwHYqNvMfBeo2epQvD5PA9qmfF4q+
 HRHDnwyNHJrH7qk7d0Yp5yV4I4NDI6jj7zslR3L8OOkwzJTHPvlHqADvKfUo6f0kqKGS
 Sk3oUndtn8251kips7mfC2f4NYAxM5MBUki13mGbBVibI6eKpcS9qj4g9gEmD3xMEILK
 0N8StfHM3g6zSktONMdivlwLzHzCrNuj1VDhOVRiMq6pCPPq3/5ZyR1m9f4/9HcouOAb cQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxd7urm44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 13:58:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JDwlFh007888
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 13:58:47 GMT
Received: from [10.110.49.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 06:58:46 -0700
Message-ID: <d1d98ad5-73f0-e42d-70ef-804c945f70cc@quicinc.com>
Date:   Wed, 19 Jul 2023 06:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add qcom specific hvc transport for
 SCMI
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-2-quic_nkela@quicinc.com>
 <20230719103917.f4dnsujub7pfqr26@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230719103917.f4dnsujub7pfqr26@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VgzsL3s0U_WFXsuwdzOUSmycLPME5uV9
X-Proofpoint-ORIG-GUID: VgzsL3s0U_WFXsuwdzOUSmycLPME5uV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_09,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/2023 3:39 AM, Sudeep Holla wrote:
> On Tue, Jul 18, 2023 at 09:08:32AM -0700, Nikunj Kela wrote:
>> Introduce compatible "qcom,scmi-hvc-shmem" for SCMI
>> transport channel for Qualcomm virtual platforms.
>> The compatible mandates a shared memory channel.
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>   .../bindings/firmware/arm,scmi.yaml           | 69 +++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> index b138f3d23df8..605b1e997a85 100644
>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> @@ -45,6 +45,9 @@ properties:
>>         - description: SCMI compliant firmware with OP-TEE transport
>>           items:
>>             - const: linaro,scmi-optee
>> +      - description: SCMI compliant firmware with Qualcomm hvc/shmem transport
>> +        items:
>> +          - const: qcom,scmi-hvc-shmem
>>   
>>     interrupts:
>>       description:
>> @@ -321,6 +324,16 @@ else:
>>         required:
>>           - linaro,optee-channel-id
>>   
>> +    else:
>> +      if:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              const: qcom,scmi-hvc-shmem
>> +      then:
>> +        required:
>> +          - shmem
>> +
> Since this was done after we merged the support recently for extension of
> SMC/HVC, I need the reason(s) why this can't be used and based on the response
> this is new change so it can't be because there is a product already
> supporting this. So for now, NACK until I get the response for these.
Our hypervisor deals with objects and uses object-ids to identify them. 
The hvc doorbell object is independent of the shmem object created by 
hypervisor. Hypervisor treats them independently. With the patch you 
mentioned, hypervisor need to create an association between the doorbell 
object and shmem object which will make it SCMI specific change in 
hypervisor. Hypervisor doesn't really care if doorbell is for SCMI or 
for other purposes hence we are adding this new driver so it can work 
with our hypervisor ABIs specification.
