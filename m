Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D517F17FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjKTP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjKTP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:58:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A7F5;
        Mon, 20 Nov 2023 07:58:55 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7M0sF003799;
        Mon, 20 Nov 2023 15:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Buto7YAuizlWKHBJom/4G4saqxZd9k57iG5CSXv+TV8=;
 b=icxN/HI2A56Sk3e+uWSq5rL+6VU4Ni5OwZaWB3gSRnB0u/tUF4NOzkKk/fXDqS1XBmYv
 /y4vwM0f2oaXBh7B6vdlkMtXCW7sPwdmff7jwpx/Nf4dEfW5wpx41sgjHdVzp2pdkAa8
 qWFxycu3o6tqfjZyxbX707Ma4XrpW0tBRmf5qQo/JDxcSfySmFb5QrEmdut81YXZkwrg
 jsOiScGsborAL2v/xUjm3l8RaIv39cRKujMFwc27c3ubq/E+fSmWSxnEXbcadM7k7/MV
 na/Pga2/bQXTEJcMg4i+A1dL7w05z6uhS0NsioLPcYKq+kHdcdI8Vrxbx548Yxe7qOBV gw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug30mh537-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 15:58:46 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKFwkTc020791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 15:58:46 GMT
Received: from [10.110.123.216] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 07:58:45 -0800
Message-ID: <a57f3edd-1468-476f-8170-be1a678b764f@quicinc.com>
Date:   Mon, 20 Nov 2023 07:58:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: reset: Convert mode-.* properties
 to array
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
 <20231117-arm-psci-system_reset2-vendor-reboots-v1-1-03c4612153e2@quicinc.com>
 <79d78b39-e537-4143-af2e-44539cc6448c@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <79d78b39-e537-4143-af2e-44539cc6448c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XF-CrqZNhtpgB1xdbHUtRcycv28MNfz8
X-Proofpoint-ORIG-GUID: XF-CrqZNhtpgB1xdbHUtRcycv28MNfz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_15,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=964 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 11/20/2023 2:52 AM, Krzysztof Kozlowski wrote:
> On 17/11/2023 22:18, Elliot Berman wrote:
>> PSCI reboot mode will map a mode name to multiple magic values instead
>> of just one. Convert the mode-.* property to an array with default
>> number of items limited to 1.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> index ad0a0b95cec1..2c786e783464 100644
>> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> @@ -28,13 +28,16 @@ description: |
>>  
>>  properties:
>>    mode-normal:
>> -    $ref: /schemas/types.yaml#/definitions/uint32
>> +    $ref: "#/patternProperties/^mode-.*$"
>>      description:
>>        Default value to set on a reboot if no command was provided.
>>  
>>  patternProperties:
>>    "^mode-.*$":
>> -    $ref: /schemas/types.yaml#/definitions/uint32
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    # Default to one value. Bindings that reference this schema could override.
>> +    minItems: 1
>> +    maxItems: 1
> 
> I don't understand. Array with one value is the same as uint32.
> 

PSCI SYSTEM_RESET2 can have multiple values per reboot type. In other words:
a given reboot mode could refer to a tuple with N values, where N
is device-specific. The current schema only allows for N=1 and PSCI
SYSTEM_RESET2 uses N=2. This patch was to update the reboot-mode.yaml
to allow me to specify N=2 in the psci bindings.

Thanks,
Elliot
