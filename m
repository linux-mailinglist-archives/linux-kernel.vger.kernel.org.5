Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4378672C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 07:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbjHXF1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 01:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbjHXF0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 01:26:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D584CD0;
        Wed, 23 Aug 2023 22:26:31 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O2dY7A027342;
        Thu, 24 Aug 2023 05:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cR9r0HbqbixacVcNUJfujbEbOF2OUeDJHRF2a00IxU0=;
 b=I/292nJWrI7vtpLcA7HibzN5WXozIMOWCBhZzioZAXMHu7M4olI/DIi9XKtfsqlBZaf/
 IiobuYb85xVbYXc1wYxSag1uaurD0qCbNMN70zBVUHRo/1q1rIjmp5o3KVo+oxcwImfK
 b/uT/zxpPddUGF5HyRRGDrOmi+hyIpgtexd8ap3QNc+9QcziCdszGv2H7XU1Vuv4Rc/p
 SA7nYEDD80jK0A0rj8ZUy2t9l3cY7Hwpu98kSWb7JRTTz5/Cjn6csyDhRHkZF/fetcZ0
 4ihxtkPfBD8TxtZyUqzpL3tqAz0Yh31JGjipdeBNiZIKD4QASan+J61J4f9Hy6erLTVj rQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2exukxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 05:26:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O5PWY4032278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 05:25:32 GMT
Received: from [10.216.48.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 22:25:24 -0700
Message-ID: <17a4b36b-4c46-86f6-5b93-b30171c324f2@quicinc.com>
Date:   Thu, 24 Aug 2023 10:55:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq9574: Add support for nsscc node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-6-quic_devipriy@quicinc.com>
 <05554015-6b08-c194-9d27-af5539e3ce46@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <05554015-6b08-c194-9d27-af5539e3ce46@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k80k8rolSFTOWiLC5rDJLv-HBqSOxo8_
X-Proofpoint-ORIG-GUID: k80k8rolSFTOWiLC5rDJLv-HBqSOxo8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_02,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240043
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2023 3:27 PM, Krzysztof Kozlowski wrote:
> On 11/07/2023 11:35, Devi Priya wrote:
>> Add a node for the nss clock controller found on ipq9574 based devices.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 44 +++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index f120c7c52351..257ce4a5bfd5 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -10,6 +10,8 @@
>>   #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
>> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -17,6 +19,30 @@
>>   	#size-cells = <2>;
>>   
>>   	clocks {
>> +		bias_pll_cc_clk: bias-pll-cc-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <1200000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		bias_pll_nss_noc_clk: bias-pll-nss-noc-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <461500000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <353000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		gcc_gpll0_out_aux: gcc-gpll0-out-aux {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <800000000>;
>> +			#clock-cells = <0>;
>> +		};
> 
> Isn't this GCC clock?
Yes, will register this in the gcc driver.

Thanks,
Devi Priya
> 
>> +
>>   		sleep_clk: sleep-clk {
>>   			compatible = "fixed-clock";
>>   			#clock-cells = <0>;
>> @@ -620,6 +646,24 @@
>>   				status = "disabled";
>>   			};
>>   		};
>> +
>> +		nsscc: nsscc@39b00000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> Best regards,
> Krzysztof
> 
