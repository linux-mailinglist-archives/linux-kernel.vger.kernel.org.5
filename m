Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4468B7DD7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbjJaVZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjJaVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:25:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEEAB9;
        Tue, 31 Oct 2023 14:25:44 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VLABc6017291;
        Tue, 31 Oct 2023 21:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=unZ6NqdnfdtI5R71au3Jb8C1wEIqiz3WsgFB3Y+40SM=;
 b=Z0cWYfl6Kc6N50DZ7HUwzemDAH8uazQ7/JRQf5g0dcE21moDSeaGF4msIE9gQyh7VrY9
 TKrAXJ6NxjqgeVD7XlSLkoxCsOz0TgTqCKB0rlsQ8H8iijmmT3honN2N1zUsjQn1NXxU
 pYCPcS/LoMy1tehZq/atsC2/uL+4SurE6lI3B8yZcwQX7o4E+/CZO/r9K+6bxmIpBmEW
 FR9uC12avqeqLEw8lXaMq6i/wA4VNnhu/LOhCgOnBPzy4ZSp28boCNqys3LtmTUm4piF
 AZZYOLaIpSNhWBdoeyw6Pnprr4thBmgj/dx5QR6E4eK+yuvlQnSUDg17lzVQn+H04MTa VA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2fcb40fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 21:25:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39VLPURg021799
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 21:25:30 GMT
Received: from [10.71.108.203] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 14:25:29 -0700
Message-ID: <e8502221-30f7-4f92-9143-0e1a2a66b86b@quicinc.com>
Date:   Tue, 31 Oct 2023 14:25:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] dt-bindings: arm: Document reboot mode magic
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
References: <20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com>
 <20231030-arm-psci-system_reset2-vendor-reboots-v1-1-dcdd63352ad1@quicinc.com>
 <20231031174855.GA1797181-robh@kernel.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20231031174855.GA1797181-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HtKxEB-93UaumR6sj0jkwi9Ucp2TUHvM
X-Proofpoint-GUID: HtKxEB-93UaumR6sj0jkwi9Ucp2TUHvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_07,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2023 10:48 AM, Rob Herring wrote:
> On Mon, Oct 30, 2023 at 02:31:33PM -0700, Elliot Berman wrote:
>> Add bindings to describe vendor-specific reboot modes. Values here
>> correspond to valid parameters to vendor-specific reset types in PSCI
>> SYSTEM_RESET2 call.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
>> index 0c5381e081bd..dc23e901bd0a 100644
>> --- a/Documentation/devicetree/bindings/arm/psci.yaml
>> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
>> @@ -122,6 +122,19 @@ patternProperties:
>>        [3] Documentation/devicetree/bindings/power/power-domain.yaml
>>        [4] Documentation/devicetree/bindings/power/domain-idle-state.yaml
>>  
>> +  "^reboot-mode-.*$":
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 2
>> +    description: |
>> +      Describes a vendor-specific reset type. The string after "reboot-mode-"
>> +      maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
>> +
>> +      Parameters are named reboot-mode-xxx = <type[, cookie]>, where xxx
>> +      is the name of the magic reboot mode, type is the lower 31 bits
>> +      of the reset_type, and, optionally, the cookie value. If the cookie
>> +      is not provided, it is defaulted to zero.
> 
> Please use and possibly extend the existing reboot-mode binding.
> 

Sure, I can do that. I noticed most of the reboot-mode devices not doing that, but they probably should.

I've sent patches to fix that:

https://lore.kernel.org/all/20231031-ref-reboot-mode-v1-1-18dde4faf7e8@quicinc.com/
https://lore.kernel.org/all/20231031-ref-nvmem-reboot-mode-v1-1-c1af9070ce52@quicinc.com/

>> +
>>  required:
>>    - compatible
>>    - method
>>
>> -- 
>> 2.41.0
>>
