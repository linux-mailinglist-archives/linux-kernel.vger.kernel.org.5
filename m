Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226ED81340A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573658AbjLNPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573635AbjLNPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:07:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F2120;
        Thu, 14 Dec 2023 07:07:52 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEF39YV007104;
        Thu, 14 Dec 2023 15:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XLAPwt/xKWgpqNhyPSWPN7P7tLR1EqSOMV1/eU72kZ4=;
 b=KLaU5YH4YiELCKICEf6K/5bLMvFEaMfWy1cnmB2yq3w8r32Z2207faBJ99fMOlgpvaLi
 lSmrFCKOLHBgpOpR/jh3cFVMEeJFoXn7qEuZkR4d7ttuRQwUrTUsJ7YN8oRG/LopdHZw
 kLh6mbwtH9wfR7poABQXYdiVTxTK/JzMBXiZlFCjg+CmTLrGf+OusrAsLv5bgKvIBNJw
 zUIfUs42ethQ4EAr0SQ+iASDmXSIrC0VycYkO1rdV4PbK1l6Ik7TDSdgJQmMvVN11eWn
 8iGaBIYxtSNMJsMM4YOQc2wdTlNCd5/I4zqsmVvXxwAIFOP7l/7W/3u+avcw9rpanlrD NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v040j04vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 15:07:02 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEF434O009478;
        Thu, 14 Dec 2023 15:07:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v040j04u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 15:07:00 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEDnVYD005049;
        Thu, 14 Dec 2023 15:06:59 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4skrwca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 15:06:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEF6vqJ26215096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 15:06:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9B785805D;
        Thu, 14 Dec 2023 15:06:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D145458069;
        Thu, 14 Dec 2023 15:06:54 +0000 (GMT)
Received: from [9.67.23.198] (unknown [9.67.23.198])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 15:06:54 +0000 (GMT)
Message-ID: <e8e4e5fe-5fa6-4098-97fc-7c6a48da9c4e@linux.ibm.com>
Date:   Thu, 14 Dec 2023 09:06:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] ARM: dts: aspeed: System1: IBM system1 BMC board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org
Cc:     Andrew Geissler <geissonator@yahoo.com>,
        patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-4-ninad@linux.ibm.com>
 <81d90c0d-9d7e-43a9-ade8-16b85a242b48@linaro.org>
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <81d90c0d-9d7e-43a9-ade8-16b85a242b48@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _0Y2OpjlnhnlX4ia8j9LaXeQCu3ERE6u
X-Proofpoint-ORIG-GUID: 1pWyN-yfwi67Cf8clBBDrf-toaFCfvnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140105
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


On 12/12/23 14:20, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:39, Ninad Palsule wrote:
>> From: Andrew Geissler <geissonator@yahoo.com>
>>
>> Add a device tree for IBM system1 BMC board. It uses AST2600 SOC.
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 188 ++++++++++++++++++
>>   2 files changed, 189 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>>
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>> index 3e3e6b96cb79..6f7ed11978ff 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>> @@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-bmc-ibm-rainier.dtb \
>>   	aspeed-bmc-ibm-rainier-1s4u.dtb \
>>   	aspeed-bmc-ibm-rainier-4u.dtb \
>> +	aspeed-bmc-ibm-system1.dtb \
>>   	aspeed-bmc-intel-s2600wf.dtb \
>>   	aspeed-bmc-inspur-fp5280g2.dtb \
>>   	aspeed-bmc-inspur-nf5280m6.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> new file mode 100644
>> index 000000000000..01291b407f59
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -0,0 +1,188 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +// Copyright 2023 IBM Corp.
>> +/dts-v1/;
>> +
>> +#include "aspeed-g6.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +#include <dt-bindings/i2c/i2c.h>
>> +#include <dt-bindings/leds/leds-pca955x.h>
>> +
>> +/ {
>> +	model = "System1";
>> +	compatible = "ibm,system1-bmc", "aspeed,ast2600";
>> +
>> +	chosen {
>> +		stdout-path = &uart5;
>> +		bootargs = "console=ttyS4,115200n8 earlycon";
> Drop early con, debugging feature not release. Then use stdout path
> alone, so drop console as well.
Fixed as per your suggestion.
>
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x40000000>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		event_log: tcg_event_log@b3d00000 {
> No underscores in node names.

Fixed.

Thanks for the review.

Regards,

Ninad

>
>
> Best regards,
> Krzysztof
>
