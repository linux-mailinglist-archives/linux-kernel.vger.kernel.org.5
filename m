Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD377F196F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjKTRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjKTRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:10:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F46D8;
        Mon, 20 Nov 2023 09:10:09 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKGcCAo011905;
        Mon, 20 Nov 2023 17:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rKRFbcoiJFnyC4kTtbuw38KkKTxXnsEOsT+x/71gpJU=;
 b=TJ34m5VuSY7JtCxQvOUwrBFEF/Mx/4c/wZejY9ck2JFWh8EzEGcqK6W0b3twx2F1Jt8/
 4NbnMeAIstOP/kzO8t78CW7jo7Z4aHStvbV3CmLgAenz8rBqIc+7jquHrE5BZ6zU39U2
 NpH+sKZ8P8wvRO8oSttPCjMctm/9vsIMPyMCLl0lM4Yo3AEl2L4JD+gXQjJRqWQKiIpU
 4o6XieRysHbQFMnV7USHlZNk/G9yXWNuzCIs4hw7/5POLDqb6NwKJly+pR+t4AFAl/aV
 RgORRJQztpMaU/xwFh6HYj2EoVXHix1l5F3hQKyDIckOR3hAv+3ZeA7St1YykcTrlWjG tQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uem9ecnpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 17:09:57 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKH9uK9009254
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 17:09:56 GMT
Received: from [10.110.123.216] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 09:09:55 -0800
Message-ID: <13a254af-415d-4fbe-9f4f-7984e064a880@quicinc.com>
Date:   Mon, 20 Nov 2023 09:09:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: arm: Document reboot mode magic
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
References: <20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com>
 <20231117-arm-psci-system_reset2-vendor-reboots-v1-2-03c4612153e2@quicinc.com>
 <eb2d0992-4d9a-4f59-8e79-da277f39d2d9@linaro.org>
 <51785de6-2a69-482d-b686-c3694f87e6b7@quicinc.com>
 <2d8c7cc2-2c6c-4539-abf3-81700f27b1a7@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <2d8c7cc2-2c6c-4539-abf3-81700f27b1a7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bc3Gi-DKZNJM0qmHVq7a-POPw5mf2NT1
X-Proofpoint-GUID: Bc3Gi-DKZNJM0qmHVq7a-POPw5mf2NT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_17,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2023 8:41 AM, Krzysztof Kozlowski wrote:
> On 20/11/2023 16:45, Elliot Berman wrote:
>>
>>
>> On 11/20/2023 2:56 AM, Krzysztof Kozlowski wrote:
>>> On 17/11/2023 22:18, Elliot Berman wrote:
>>>> -
>>>> -additionalProperties: false
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: arm,psci-1.0
>>>> +    then:
>>>> +      $ref: /schemas/power/reset/reboot-mode.yaml#
>>>> +      properties:
>>>> +        # "mode-normal" is just SYSTEM_RESET
>>>> +        mode-normal: false
>>>> +      patternProperties:
>>>> +        "^mode-.*$":
>>>> +          maxItems: 2
>>>
>>> And if you tested the patch, it would tell you it can be max 1 item.
>>
>> make dt_binding_check DT_SCHEMA_FILES=arm/psci.yaml
> 
> psci.example.dtb: psci: mode-edl: [[0]] is too short
> psci.example.dtb: psci: mode-bootloader: [[1, 2]] is too short
> 
> psci.example.dtb: psci: Unevaluated properties are not allowed
> ('mode-bootloader', 'mode-edl' were unexpected)
> 

Ah, tip of tree for dt-schema doesn't seem to report the error.

Doesn't report the error:
dt-validate --version
2023.10.dev17+g58feadb

Reports the error:
dt-validate --version
2023.9

Looks likely related to generated the processed-schema.json rather
than dt-validate itself. The tip of tree dt-validate does report
the error if processed-schema.json is generated by 2023.9 tool,
but not if the schema was also generated by tip-of-tree mkschema.

I'll try bisecting the error and report back.

>>
>> passes for me. Rob explained why it's working (and why it shouldn't), 
>> so I'll fix it according to his recommendation in v2.
> 
> Then you wanted uint32-matrix.
> 
> 
> Best regards,
> Krzysztof
> 
