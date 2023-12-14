Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4988A813304
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573469AbjLNOZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573453AbjLNOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:25:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A6B2;
        Thu, 14 Dec 2023 06:25:07 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEEGqWA026264;
        Thu, 14 Dec 2023 14:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lqgfGZSL02s12bV+EZPiVU/q0lVJ2wM7GttJMZHSMg4=;
 b=iC5jqNZg7M5Qeg4VQrkpX2zE+6knUtAznit82kJGdiwdlU3HmcA5VrM/e110No9xaS0F
 UR/Z2LGtFIQ9K0bnOB/DY+QRhusp4wpqxTZSlVslMTCmxomNkWHCwoDkTCS3jeDX5soQ
 rd4EPfAaJLQ7x8lAP3GD0o8jj9j5nDr2dfdX4Yj+6OQrkPOve2Nx9AVa6U5nVuKVrFDY
 dRsYWrGAOghCzKbgS+vwXsnHTDm4WwrQJ5pGJwVexMLsEEhw+XQiHjR6wI5sKjgXjmmV
 +Re+J+KHBL6LeDuqXCLkv9PSrsSgurFClvmSs2NvkrL80Ye9SMcaX1JIqtyWxI/4ACRO dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v03b307wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 14:24:17 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEEHkNK029961;
        Thu, 14 Dec 2023 14:24:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v03b307w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 14:24:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BED9jOp012620;
        Thu, 14 Dec 2023 14:24:14 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jp90pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 14:24:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEEODRr33358310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 14:24:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 644605805F;
        Thu, 14 Dec 2023 14:24:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D15B558051;
        Thu, 14 Dec 2023 14:24:09 +0000 (GMT)
Received: from [9.67.23.198] (unknown [9.67.23.198])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 14:24:09 +0000 (GMT)
Message-ID: <f9f95e8d-02e5-454e-8075-1e4231d385bb@linux.ibm.com>
Date:   Thu, 14 Dec 2023 08:24:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] ARM: dts: aspeed: System1: PS, sensor and more
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org
Cc:     patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-9-ninad@linux.ibm.com>
 <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
 <44abff4a-0a8e-499b-8b98-a4a1680cb431@linux.ibm.com>
 <427fa99c-764c-4d6a-b9f1-cd9089710d5e@linaro.org>
 <edcdcea2-febc-4859-9ccf-b8c59b794f01@linux.ibm.com>
 <1c5ace65-2fd8-4503-b22f-e0f564d1c83f@linaro.org>
Content-Language: en-US
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <1c5ace65-2fd8-4503-b22f-e0f564d1c83f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dw6P0YguG2FsdSKN_nlMIhXcu-QkMI3x
X-Proofpoint-GUID: Fa1OsjgEvz5G5Q94M6u6-pMLI18_E7rH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,


On 12/14/23 01:24, Krzysztof Kozlowski wrote:
> On 13/12/2023 20:49, Ninad Palsule wrote:
>> Hello Krzysztof,
>>
>> On 12/13/23 13:37, Krzysztof Kozlowski wrote:
>>> On 13/12/2023 20:02, Ninad Palsule wrote:
>>>> Hello Krzysztof,
>>>>
>>>> On 12/12/23 14:26, Krzysztof Kozlowski wrote:
>>>>> On 12/12/2023 17:40, Ninad Palsule wrote:
>>>>>> This drop adds following devices in the device tree.
>>>>>> - EEPROM/VPD
>>>>>> - Power supplies
>>>>>> - Humidity, pressure and temperature sensors.
>>>>>> - Trusted platform module(TPM) chip
>>>>>>
>>>>>> Tested:
>>>>>>        This board is tested using the simics simulator.
>>>>>>
>>>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>>>>> ---
>>>>> Don't mix DTS with drivers. DTS and drivers go via different subsystems
>>>>> and cannot have dependencies, so why DTS is patch #6, then driver #7 and
>>>>> now again DTS #7?
>>>> There is a dependency on driver code as patch #8 uses the compatibility
>>>> string added in driver patch #7.  I have now moved driver patch at the
>>>> start. Is that ok? OR you are suggesting something else?
>>> First, there is no dependency. Second, except confusing order anyway DTS
>>> will go via separate trees. Third, again, there is no dependency. If
>>> there is, your patchset is broken and this needs to be fixed. Although I
>>> don't understand how new hardware can depend on driver... it's really odd.
>> Thanks for the quick response.
>>
>> This board uses the nuvoton TPM device. The tpm devices uses
>> "nuvoton,npct75x" driver hence we added it in the device tree. If the
>> driver doesn't have this compatibility string then it won't load. So if
>> someone tries to use this board then tpm won't work unless the
> ... and if there is no board it also fails to load.
>
>> compatibility string is added in the driver. That is the dependency I am
>> talking about.
> This is not a dependency! It's unrelated.

ok, I will send it as a separate patch.

Thanks for the prompt reply.

Regards,

Ninad

>
> Best regards,
> Krzysztof
>
