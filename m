Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34660811F56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjLMTue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjLMTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:50:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED26C9;
        Wed, 13 Dec 2023 11:50:38 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDJ7B7j012884;
        Wed, 13 Dec 2023 19:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=L1dGX3bAr3L6MVW5M70dQtsQ2pdKDwOrjjPgZmZ9Nss=;
 b=FaBbWCzkxjdeqtrv+Eyh6JPEdTAC1incrbMiODjMZ5LdIgkOMSg0aM8wu118JoB+uF0g
 yVPGPG92U7Y2OZZmQLpfngXLAZ39HYBmh4u4zWOk7h62WpQyYAQ1zMoviixSGClP7BQh
 tkuvQZ6c3VzW+6D3FPnZ0KGdfe14nsTIGurBgbWGI2gmqi3ItvMApMj0pOYFuVzOqEBw
 6U0HOfxk1PLvGnTTBMCKoeIi1MV2rodl2/wpia1G4XKZ+ddhjOW5GKuwkaQkNcFlnGGq
 w6v9P03ZlrS8zfR6FNRTxwsn7K0dgplQ2nNUHYCVHTCpaa/gK41ekqj5l7nyObynANoE KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyjg30xdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 19:49:26 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDJmEa8010165;
        Wed, 13 Dec 2023 19:49:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyjg30xdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 19:49:25 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDI0FAI004101;
        Wed, 13 Dec 2023 19:49:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4skk2au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 19:49:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDJnNYp27591270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 19:49:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8138F58055;
        Wed, 13 Dec 2023 19:49:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FAA45803F;
        Wed, 13 Dec 2023 19:49:22 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 19:49:21 +0000 (GMT)
Message-ID: <edcdcea2-febc-4859-9ccf-b8c59b794f01@linux.ibm.com>
Date:   Wed, 13 Dec 2023 13:49:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] ARM: dts: aspeed: System1: PS, sensor and more
Content-Language: en-US
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
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <427fa99c-764c-4d6a-b9f1-cd9089710d5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -lbtKMmRARtMlAJmbObK1QI6-3y3Nw92
X-Proofpoint-GUID: HhWJUytBbixy7UlL0_Fe2zPrr42jTffk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_13,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 12/13/23 13:37, Krzysztof Kozlowski wrote:
> On 13/12/2023 20:02, Ninad Palsule wrote:
>> Hello Krzysztof,
>>
>> On 12/12/23 14:26, Krzysztof Kozlowski wrote:
>>> On 12/12/2023 17:40, Ninad Palsule wrote:
>>>> This drop adds following devices in the device tree.
>>>> - EEPROM/VPD
>>>> - Power supplies
>>>> - Humidity, pressure and temperature sensors.
>>>> - Trusted platform module(TPM) chip
>>>>
>>>> Tested:
>>>>       This board is tested using the simics simulator.
>>>>
>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>>> ---
>>> Don't mix DTS with drivers. DTS and drivers go via different subsystems
>>> and cannot have dependencies, so why DTS is patch #6, then driver #7 and
>>> now again DTS #7?
>> There is a dependency on driver code as patch #8 uses the compatibility
>> string added in driver patch #7.  I have now moved driver patch at the
>> start. Is that ok? OR you are suggesting something else?
> First, there is no dependency. Second, except confusing order anyway DTS
> will go via separate trees. Third, again, there is no dependency. If
> there is, your patchset is broken and this needs to be fixed. Although I
> don't understand how new hardware can depend on driver... it's really odd.

Thanks for the quick response.

This board uses the nuvoton TPM device. The tpm devices uses 
"nuvoton,npct75x" driver hence we added it in the device tree. If the 
driver doesn't have this compatibility string then it won't load. So if 
someone tries to use this board then tpm won't work unless the 
compatibility string is added in the driver. That is the dependency I am 
talking about.

Please let me know.

Regards,

Ninad

>
> Best regards,
> Krzysztof
>
