Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB35280F77F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377178AbjLLUHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjLLUHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:07:33 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BBA2;
        Tue, 12 Dec 2023 12:07:38 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCJudOR012024;
        Tue, 12 Dec 2023 20:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TmH9w3blNDPKBoDlTf4OpLYjlao5d1XQCukjpJGG/z4=;
 b=e8AbT5JibmPkZ8TLdpystRRxmeii14CJ+sDVjlSzpkXZkZcInk9mGQl5DWk1fBGi57QW
 dOhheEsvVoP1Smi1XBaSugn1zK0IS8qqwnEvMyHsGyyb3+HoK73i+ytJFbGWnQFco2dr
 mfc5T10B7N2af8SnmrpkLdwkRHJKe88SSYY4pkd/J+ozUxR6H9xY6oegzaes9JmlYOoA
 IPKr8PCA/qsSilcDrIO6eGRHHTVPg08jbmOeamPuJ3JG/WvDAE7AxQPlXM6wE0YvfiyH
 x6mzOrVMM/BfN/9kC7chODyWU2LV6X8YienRhY4jaj8Xe3QWAxxsjh8eQu+0cQKdZoSn zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxw6bsu2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 20:06:44 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCJxMk8022179;
        Tue, 12 Dec 2023 20:06:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxw6bsu21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 20:06:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCJ8VKR014808;
        Tue, 12 Dec 2023 20:06:42 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kdecj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 20:06:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCK6ftc66191868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 20:06:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 984E958065;
        Tue, 12 Dec 2023 20:06:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04AB75805E;
        Tue, 12 Dec 2023 20:06:41 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 20:06:40 +0000 (GMT)
Message-ID: <2ddae2e4-de55-41a1-a93e-819f8d55dde6@linux.ibm.com>
Date:   Tue, 12 Dec 2023 14:06:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] dt-bindings: arm: aspeed: add IBM system1-bmc
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org, patrick.rudolph@9elements.com,
        vincent@vtremblay.dev, peteryin.openbmc@gmail.com,
        lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-2-ninad@linux.ibm.com>
 <20231212-thrower-ebook-d29a85a6ed96@spud>
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20231212-thrower-ebook-d29a85a6ed96@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U8PFgQodpMDqjUJfIhz1uaYjKOARbEhV
X-Proofpoint-GUID: IRw5VQBoZgxysgbkI057XToVO0Ukxlaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor,

On 12/12/23 11:09, Conor Dooley wrote:
> On Tue, Dec 12, 2023 at 10:39:57AM -0600, Ninad Palsule wrote:
>> Document the new compatibles used on IBM system1-bmc
>>
>> Tested:
>>      This board is tested using the simics simulator.
> I don't see how this is relevant to dt-bindings patches.
Make sense. Removed it.
>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>   Documentation/devicetree/bindings/trivial-devices.yaml   | 2 ++
> IMO these should be split into two patches.

Make sense. Split it into two patches.

Thank you for the review.

Thanks & Regards,

Ninad

>
> Cheers,
> Conor.
>
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> index 6f7543463d89..ebebe14c42aa 100644
>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> @@ -85,6 +85,7 @@ properties:
>>                 - facebook,yosemite4-bmc
>>                 - ibm,everest-bmc
>>                 - ibm,rainier-bmc
>> +              - ibm,system1-bmc
>>                 - ibm,tacoma-bmc
>>                 - inventec,starscream-bmc
>>                 - inventec,transformer-bmc
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 441b55723675..b12a60d2eb0f 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -135,6 +135,8 @@ properties:
>>             - ibm,cffps1
>>               # IBM Common Form Factor Power Supply Versions 2
>>             - ibm,cffps2
>> +            # Infineon barometric pressure and temperature sensor
>> +          - infineon,dps310
>>               # Infineon IR36021 digital POL buck controller
>>             - infineon,ir36021
>>               # Infineon IR38060 Voltage Regulator
>> -- 
>> 2.39.2
>>
