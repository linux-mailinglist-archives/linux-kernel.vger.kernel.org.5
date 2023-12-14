Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B44813653
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjLNQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:33:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D36A6;
        Thu, 14 Dec 2023 08:33:29 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEGNpfb010000;
        Thu, 14 Dec 2023 16:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k0KaS28pCt49kw9+p3L44QcYWFnIp+iPqyK7JQMB9g8=;
 b=WbnAA5NiNCBVwTq/DRIYImrYFEPSxxVbIoEeLXgDg52nN3jp3kXnLiVm2CfnCh/xC0XS
 uqs4M2/57DXguWWOAHtgWlmqGaA9hSlPoxgHvOtYEessd/axv6/g2QbqQ4pLd50W3BLR
 nJRDs41b8XU6a4fOOlrte6HQ7ygk2NAyhXkvD7fCuw2ZNTdawzqataNh/UdXhQ0tzCpT
 uxllSKmVqsvpmtaig+gq/UrTa0/WQ9f8+oW9p10hz0N2UFOM+YfAt3EjDH/37KDGLcTh
 YtsqXqHX/YDEXd+Nxb7KXcxXDlPjXBSguoe82WDU97HldaVhWfjENixBjMyjS+IbOQ+n hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v03b34rc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 16:32:47 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEGO45B012186;
        Thu, 14 Dec 2023 16:32:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v03b34qmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 16:32:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BECe18w014799;
        Thu, 14 Dec 2023 16:31:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42khd6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 16:31:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEGUxZf10551814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 16:30:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9026358065;
        Thu, 14 Dec 2023 16:30:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC26458052;
        Thu, 14 Dec 2023 16:30:55 +0000 (GMT)
Received: from [9.67.23.198] (unknown [9.67.23.198])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 16:30:55 +0000 (GMT)
Message-ID: <e1ec02cf-072b-4678-8986-336c1cb8ca92@linux.ibm.com>
Date:   Thu, 14 Dec 2023 10:30:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/8] ARM: dts: aspeed: System1: Voltage regulators
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
 <20231212164004.1683589-6-ninad@linux.ibm.com>
 <6a3d4551-66a2-411a-9d5f-cffb57ee0ce2@linaro.org>
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <6a3d4551-66a2-411a-9d5f-cffb57ee0ce2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kuNvJNdtavC_dao6iJnMFctwdS96DrLO
X-Proofpoint-GUID: Tzj1hExUyDRdIPxL0IVPxnja4Z1KmH3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140117
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

On 12/12/23 14:22, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:40, Ninad Palsule wrote:
>> This commit adds different voltage regulators.
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 266 ++++++++++++++++++
> Squash it.
Done.
>
>>   1 file changed, 266 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index 0557bff9f36a..b8e7e52d4600 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -114,10 +114,127 @@ vga_memory: region@bf000000 {
>>   		};
>>   	};
>>   
>> +	iio-hwmon {
>> +		compatible = "iio-hwmon";
>> +		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>,
>> +			<&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
>> +			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>,
>> +			<&adc1 4>, <&adc0 2>, <&adc1 0>,
>> +			<&p2V5_aux_vd 0>, <&adc1 7>;
>> +	};
>> +
>> +	p12v_vd: voltage_divider1 {
> Same comments as in other patches.
Fixed.
>
>> +		compatible = "voltage-divider";
>> +		io-channels = <&adc1 3>;
>> +		#io-channel-cells = <1>;
>> +
>> +		/* Scale the system voltage by 1127/127 to fit the ADC range.
> Use Linux coding style comments. /* and blank line

Fixed.

Thanks for the review.

Regards,

Ninad

>
>
> ....
>
> Best regards,
> Krzysztof
>
