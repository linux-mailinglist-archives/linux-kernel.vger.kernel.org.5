Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2103811E29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441983AbjLMTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjLMTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:07:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E522DD;
        Wed, 13 Dec 2023 11:07:34 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDI80RH015603;
        Wed, 13 Dec 2023 19:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WU69mRx/2t70ZYVvogDHcoeIHud6TOTte0D67PV0eeE=;
 b=F85YGi8eodicIV8Qt8cx4FRchYH6uCA0EM1aFdWpeymTNW8TXrDzDB/rGjf1IDl3brIV
 5X/+GW/C++nm3/ySVb63ftSEgxw2zEsjwLNrnFg2s3KTAIDhG+/GugKt0/vWu572wcEw
 vw05YNu/NGAHtbiFJ/1bAWO31mLkaXt+iwexnug/x7Zx28G44MxIaeIXG2808GCtSK6V
 PuTrLUT+x6jtYAHxNRlZQvoGrPv+85rJVOoDn+Kf9j+w4KT6p4nTWhA9yAS7cLkWjtWL
 D9o1jSD/y/H/44IVV852qSa+tphEGnclTMW2e6RibfxUpMo5x5FmVHXTppPtfW++jv1U Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyhm8hfwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 19:06:49 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDIk18s008722;
        Wed, 13 Dec 2023 19:06:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyhm8hfum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 19:06:48 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDIJU1M013937;
        Wed, 13 Dec 2023 19:02:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592akej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 19:02:08 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDJ279236700690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 19:02:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADEE55804E;
        Wed, 13 Dec 2023 19:02:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53CE65803F;
        Wed, 13 Dec 2023 19:02:06 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 19:02:06 +0000 (GMT)
Message-ID: <44abff4a-0a8e-499b-8b98-a4a1680cb431@linux.ibm.com>
Date:   Wed, 13 Dec 2023 13:02:06 -0600
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
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6gt9fVUlqjHL0gsjqMLmdLt93rvE4Yox
X-Proofpoint-ORIG-GUID: QbgE13nengHynFcCRNb7fZ0kokK2ce_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130137
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

On 12/12/23 14:26, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:40, Ninad Palsule wrote:
>> This drop adds following devices in the device tree.
>> - EEPROM/VPD
>> - Power supplies
>> - Humidity, pressure and temperature sensors.
>> - Trusted platform module(TPM) chip
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
> Don't mix DTS with drivers. DTS and drivers go via different subsystems
> and cannot have dependencies, so why DTS is patch #6, then driver #7 and
> now again DTS #7?

There is a dependency on driver code as patch #8 uses the compatibility 
string added in driver patch #7.  I have now moved driver patch at the 
start. Is that ok? OR you are suggesting something else?

v1-0001-tpm-tis-i2c-Add-more-compatible-strings.patch
                         |
v1-0009-ARM-dts-aspeed-System1-PS-sensor-and-more.patch

>
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 76 +++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index 75562aa63701..d960b938fe8d 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -461,6 +461,11 @@ &kcs3 {
>>   &i2c0 {
>>   	status = "okay";
>>   
>> +	eeprom@50 {
>> +		compatible = "atmel,24c64";
>> +		reg = <0x50>;
>> +	};
>> +
>>   	regulator@60 {
>>   		compatible = "maxim,max8952";
>>   		reg = <0x60>;
>> @@ -655,6 +660,25 @@ pca0: pca9539@74 {
>>   
>>   &i2c2 {
>>   	status = "okay";
>> +
>> +	power-supply@58 {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x58>;
>> +	};
>> +
>> +	power-supply@59 {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x59>;
>> +	};
>> +
>> +	power-supply@5a {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x5a>;
>> +	};
> Missing blank line

Fixed it.

Thanks for the review.

Regards,

Ninad

>
>> +	power-supply@5b {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x5b>;
>> +	};
>
> Best regards,
> Krzysztof
>
