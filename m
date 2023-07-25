Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A82762349
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGYU1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGYU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:27:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39F710C9;
        Tue, 25 Jul 2023 13:27:03 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJrNt4017427;
        Tue, 25 Jul 2023 20:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1X8+n3MA1lreH7ZZPB5AlV1O902bAiQGyg3X96D0l+E=;
 b=aK5U3yyQEX0gQfv56006IOEHWYUNn1TK/eXAOFaBBrXi44FeKdaMmoe+k6jesAwZhty0
 I1JNUuXVGVLYmopvO0A8moDdAl+RMc9pVAU9CLp835716rKJPutCvPquMWhBLMkVRNMs
 7oB9KcDQe7aNYmn3YQa7cwyicSgkaH06TK6yYj/MVOog5eGIs6fIzYUUgc4k9LTkhyZ5
 fQZR7vxOO6ZUH09E32OqUZHc2DOZdCKkefD5DHwkBnOvf8Nf5CTRXjM0GWb+cWOy4rcO
 2d0gGcmWNa3tdoqAEQR5W05mwZvf6cOOfkNTlHtNcQLMcwYHDNhSugDhp3PmWca033XB ag== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2mxrg1h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 20:26:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PKQnbu031726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 20:26:49 GMT
Received: from [10.71.109.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 13:26:46 -0700
Message-ID: <586f2ea2-d74e-78f5-4959-4fbbe23ddbae@quicinc.com>
Date:   Tue, 25 Jul 2023 13:26:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 3/4] dt-bindings: power: reset: Document
 arm,psci-vendor-reset
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Prasad Sodagudi" <quic_psodagud@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <20230724223057.1208122-4-quic_eberman@quicinc.com>
 <20230724232328.GA1101352-robh@kernel.org>
 <0e72a1a0-611c-9667-866e-a4a1f67f10f6@quicinc.com>
In-Reply-To: <0e72a1a0-611c-9667-866e-a4a1f67f10f6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WQxOddhYv3sLyNLo9XqPMVBTFVQnXAP6
X-Proofpoint-ORIG-GUID: WQxOddhYv3sLyNLo9XqPMVBTFVQnXAP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_11,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250173
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/2023 11:01 AM, Elliot Berman wrote:
> 
> 
> On 7/24/2023 4:23 PM, Rob Herring wrote:
>> On Mon, Jul 24, 2023 at 03:30:53PM -0700, Elliot Berman wrote:
>>> Add devicetree bindings for using PSCI SYSTEM_RESET2 with vendor 
>>> reset  types.
>>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> ---
>>>   .../power/reset/arm,psci-vendor-reset.yaml    | 35 +++++++++++++++++++
>>>   MAINTAINERS                                   |  1 +
>>>   2 files changed, 36 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml b/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
>>> new file mode 100644
>>> index 000000000000..18b0b8c167a1
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
>>> @@ -0,0 +1,35 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +# Copyright 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>>> http://devicetree.org/schemas/power/reset/arm,psci-vendor-reset.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: PSCI SYSTEM_RESET2 Vendor Resets
>>> +
>>> +maintainers:
>>> +  - Elliot Berman <quic_eberman@quicinc.com>
>>> +
>>> +description: |
>>> +  PSCI SYSTEM_RESET2 supports vendor-defined reset types. This 
>>> describes
>>> +  the conversion of reboot modes to the reset types.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: arm,psci-vendor-reset
>>> +
>>> +allOf:
>>> +  - $ref: reboot-mode.yaml#
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    firmware {
>>> +      psci-vendor-resets {
>>> +        compatible = "arm,psci-vendor-reset";
>>
>> We already have a node for PSCI, we don't need a second one. You can
>> have a separate driver without a separate node.
>>
> 
> I could also place the reboot-mode functionality straight into 
> drivers/firwmare/psci/? I thought that might be more controversial than 
> separate driver, but maybe not?
> 
> Mark/Loreno, do you have any concerns to add the reboot-mode driver 
> functionality directly in drivers/firmware/psci/psci.c?
> 
> Sebastian, do you have any concerns to have this reboot-mode driver 
> outside drivers/power/reset/?
> 

Sebastian, please disregard this question.

Mukesh pointed out that reboot-mode framework isn't the right option 
here since this driver does the actual reset and, as I understand, 
reboot-mode isn't intended to do actual reset. I'm going to implement 
something similar to what reboot-mode framework does but register 
against the restart_handler_list instead of reboot_notifier_list.

>>> +        reboot-normal = <0x100>;
>>
>> Wouldn't 'normal' be the normal PSCI reset?
>>
> 
> Ah, right. I had my head buried in the reboot-mode code when creating 
> the example. I can remove from the example.
> 
>>> +        reboot-bootloader = <0x101>;
>>> +        reboot-fastboot = <0x102>;
>>> +      };
>>> +    };
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index d516295978a4..2da4c5f1917b 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -16982,6 +16982,7 @@ M:    Mark Rutland <mark.rutland@arm.com>
>>>   M:    Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>   L:    linux-arm-kernel@lists.infradead.org (moderated for 
>>> non-subscribers)
>>>   S:    Maintained
>>> +F:    
>>> Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
>>>   F:    drivers/firmware/psci/
>>>   F:    include/linux/psci.h
>>>   F:    include/uapi/linux/psci.h
>>> -- 
>>> 2.41.0
>>>
