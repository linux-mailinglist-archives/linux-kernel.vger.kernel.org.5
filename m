Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00DB813A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573024AbjLNSfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjLNSfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:35:03 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648ED111;
        Thu, 14 Dec 2023 10:35:09 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEIVkrm012030;
        Thu, 14 Dec 2023 18:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aZfItAC16OpY8Y87+kaxK+6Wy7sVgwOm4UYAmq8AAhc=;
 b=IYgjFJMmcgD3ceQdzJU0wRBQXHCOT3CZX9YgqKWvOo2vanSnqkOdQ67Dq92BaM5Z5R5W
 g+e6Rz6YlNVck/VPwy5TxxfLvpYS9XNJA7brDMhS4aUjfUz5NC/hD5WMntYoTbDZxNj2
 81vMhGfewItxp+nBfugU4UA/Zw9DM/e8zhi5aOvwgafkZL+kj2vBFuu73GJKwUrntaIY
 RhbG9AGLb9LC9aKOdVfMMKojC2NPcnwgMxFdpwab8bbKitz4zZAegcYiLCzqwzeqAVVX
 4nBv4FPhaeAyb4fnlaV+Kbltiuu3q46uQgQjLUkiwiOmdYpfG0lSZgl0hWjmK3cyMsME uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v072ag26k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:34:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEIXAjM016214;
        Thu, 14 Dec 2023 18:34:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v072ag264-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:34:21 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BECe1XP014799;
        Thu, 14 Dec 2023 18:34:20 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42khrus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:34:20 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEIYJq69830950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 18:34:20 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D07D65805D;
        Thu, 14 Dec 2023 18:34:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 254E358056;
        Thu, 14 Dec 2023 18:34:16 +0000 (GMT)
Received: from [9.67.23.198] (unknown [9.67.23.198])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 18:34:15 +0000 (GMT)
Message-ID: <8cdadff2-055a-48ab-8495-45c8285d3d8f@linux.ibm.com>
Date:   Thu, 14 Dec 2023 12:34:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] ARM: dts: aspeed: System1: Add i2c and muxes
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
 <20231212164004.1683589-5-ninad@linux.ibm.com>
 <72a749b9-b9be-4496-9bcc-37519044c109@linaro.org>
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <72a749b9-b9be-4496-9bcc-37519044c109@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KIu3tM4aH2p_1s1TvaCGkUi7cGT1eyM9
X-Proofpoint-GUID: 7-F53l8el8CAhlx9LMigtTCwyZjJNqJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140131
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

On 12/12/23 14:21, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:40, Ninad Palsule wrote:
>> This commit adds i2c devices and muxes.
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 577 ++++++++++++++++++
>>   1 file changed, 577 insertions(+)
>>
> Why do you split new submission into multiple chunks? The logical
> feature here is new board, so all your DTS patches adding new board
> should be in one patch.
Oh,ok. I thought it might be easier to review but now I squashed them 
together.
>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index 01291b407f59..0557bff9f36a 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -11,6 +11,65 @@ / {
>>   	model = "System1";
>>   	compatible = "ibm,system1-bmc", "aspeed,ast2600";
>>   
>> +	aliases {
>> +		i2c16 = &i2c8mux1chn0;
>> +		i2c17 = &i2c8mux1chn1;
>> +		i2c18 = &i2c8mux1chn2;
>> +		i2c19 = &i2c8mux1chn3;
>> +		i2c20 = &i2c8mux1chn4;
>> +		i2c21 = &i2c8mux1chn5;
>> +		i2c22 = &i2c8mux1chn6;
>> +		i2c23 = &i2c8mux1chn7;
>> +		i2c24 = &i2c3mux0chn0;
>> +		i2c25 = &i2c3mux0chn1;
>> +		i2c26 = &i2c3mux0chn2;
>> +		i2c27 = &i2c3mux0chn3;
>> +		i2c28 = &i2c3mux0chn4;
>> +		i2c29 = &i2c3mux0chn5;
>> +		i2c30 = &i2c3mux0chn6;
>> +		i2c31 = &i2c3mux0chn7;
>> +		i2c32 = &i2c6mux0chn0;
>> +		i2c33 = &i2c6mux0chn1;
>> +		i2c34 = &i2c6mux0chn2;
>> +		i2c35 = &i2c6mux0chn3;
>> +		i2c36 = &i2c6mux0chn4;
>> +		i2c37 = &i2c6mux0chn5;
>> +		i2c38 = &i2c6mux0chn6;
>> +		i2c39 = &i2c6mux0chn7;
>> +		i2c40 = &i2c7mux0chn0;
>> +		i2c41 = &i2c7mux0chn1;
>> +		i2c42 = &i2c7mux0chn2;
>> +		i2c43 = &i2c7mux0chn3;
>> +		i2c44 = &i2c7mux0chn4;
>> +		i2c45 = &i2c7mux0chn5;
>> +		i2c46 = &i2c7mux0chn6;
>> +		i2c47 = &i2c7mux0chn7;
>> +		i2c48 = &i2c8mux0chn0;
>> +		i2c49 = &i2c8mux0chn1;
>> +		i2c50 = &i2c8mux0chn2;
>> +		i2c51 = &i2c8mux0chn3;
>> +		i2c52 = &i2c8mux0chn4;
>> +		i2c53 = &i2c8mux0chn5;
>> +		i2c54 = &i2c8mux0chn6;
>> +		i2c55 = &i2c8mux0chn7;
>> +		i2c56 = &i2c14mux0chn0;
>> +		i2c57 = &i2c14mux0chn1;
>> +		i2c58 = &i2c14mux0chn2;
>> +		i2c59 = &i2c14mux0chn3;
>> +		i2c60 = &i2c14mux0chn4;
>> +		i2c61 = &i2c14mux0chn5;
>> +		i2c62 = &i2c14mux0chn6;
>> +		i2c63 = &i2c14mux0chn7;
>> +		i2c64 = &i2c15mux0chn0;
>> +		i2c65 = &i2c15mux0chn1;
>> +		i2c66 = &i2c15mux0chn2;
>> +		i2c67 = &i2c15mux0chn3;
>> +		i2c68 = &i2c15mux0chn4;
>> +		i2c69 = &i2c15mux0chn5;
>> +		i2c70 = &i2c15mux0chn6;
>> +		i2c71 = &i2c15mux0chn7;
>> +	};
>> +
>>   	chosen {
>>   		stdout-path = &uart5;
>>   		bootargs = "console=ttyS4,115200n8 earlycon";
>> @@ -54,10 +113,12 @@ vga_memory: region@bf000000 {
>>   			reg = <0xbf000000 0x01000000>;  /* 16M */
>>   		};
>>   	};
>> +
> You need to clean your patchset...
I made changes about the stdout-path, is that what you mean?
>
>
>>   };
>>   
>>   &adc1 {
>>   	status = "okay";
>> +
> Really.
I need to add "status = okay" otherwise its not instantiated.
>
>>   	aspeed,int-vref-microvolt = <2500000>;
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&pinctrl_adc8_default
>> @@ -186,3 +247,519 @@ &kcs3 {
>>   	aspeed,lpc-io-reg = <0xca2>;
>>   	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>>   };
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c2 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c3 {
>> +	status = "okay";
>> +
>> +	i2c-mux@70 {
>> +		compatible = "nxp,pca9548";
>> +		reg = <0x70>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		status = "okay";
> Drop
Done.
>
>> +		i2c-mux-idle-disconnect;
>> +
>> +		i2c3mux0chn0: i2c@0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0>;
>> +		};
>> +
>> +		i2c3mux0chn1: i2c@1 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <1>;
>> +		};
>> +
>> +		i2c3mux0chn2: i2c@2 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <2>;
>> +		};
>> +
>> +		i2c3mux0chn3: i2c@3 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <3>;
>> +		};
>> +
>> +		i2c3mux0chn4: i2c@4 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <4>;
>> +		};
>> +
>> +		i2c3mux0chn5: i2c@5 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <5>;
>> +		};
>> +
>> +		i2c3mux0chn6: i2c@6 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <6>;
>> +		};
>> +
>> +		i2c3mux0chn7: i2c@7 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <7>;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c4 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c5 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c6 {
>> +	status = "okay";
>> +
>> +	i2c-mux@70 {
>> +		compatible = "nxp,pca9548";
>> +		reg = <0x70>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		status = "okay";
> Drop

Done

Thanks for the review.

Regards,

Ninad

>
> Other places as well.
>
>
> Best regards,
> Krzysztof
>
