Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F357F17BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjKTPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjKTPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:45:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D89124;
        Mon, 20 Nov 2023 07:45:43 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDLsFf004570;
        Mon, 20 Nov 2023 15:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tMbiJn1665rv9zGgWLRfYM/xK3klBLtoSVU9vhIpy8g=;
 b=o2t7qt5X/ZKoz/wAt3dFEi9hhR3pQfgL3GXT37XnU7NER+iez0OTaMGy1i6KFGJGPD4G
 SuVzFcV9JxvHTtwnLwlTnkuSqBEqQ/TbGr/QIvvUEDH1OFoKG4vkkemMDrQRniBk3Njm
 SQ0zfGsEoGmpa5syhGao6kIAYcb0r3mfSJ6g7cxY7rM43w9nli8fhTzGyMCYrZLVCbIm
 BSJ5A1boic11W91aK1lmy+VKIX1h32BEXSUpeLaCSMZrCepOxLkZaM2/rRwzRB6zPwjU
 pWWMxqmDTaZIHof4oSyDJv+1BLZsUk9B2uOiPMtpjKqzFuu/JFjzNqDfMBKbnSKBD+pU wQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug26ts8uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 15:45:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKFjTfI026470
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 15:45:29 GMT
Received: from [10.110.123.216] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 07:45:29 -0800
Message-ID: <51785de6-2a69-482d-b686-c3694f87e6b7@quicinc.com>
Date:   Mon, 20 Nov 2023 07:45:28 -0800
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
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <eb2d0992-4d9a-4f59-8e79-da277f39d2d9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4PiT0cZP_0z-TCuA6kMTc_Y1BkXDfpKv
X-Proofpoint-GUID: 4PiT0cZP_0z-TCuA6kMTc_Y1BkXDfpKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_15,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2023 2:56 AM, Krzysztof Kozlowski wrote:
> On 17/11/2023 22:18, Elliot Berman wrote:
>> -
>> -additionalProperties: false
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: arm,psci-1.0
>> +    then:
>> +      $ref: /schemas/power/reset/reboot-mode.yaml#
>> +      properties:
>> +        # "mode-normal" is just SYSTEM_RESET
>> +        mode-normal: false
>> +      patternProperties:
>> +        "^mode-.*$":
>> +          maxItems: 2
> 
> And if you tested the patch, it would tell you it can be max 1 item.

make dt_binding_check DT_SCHEMA_FILES=arm/psci.yaml

passes for me. Rob explained why it's working (and why it shouldn't), 
so I'll fix it according to his recommendation in v2.

Thanks,
Elliot
