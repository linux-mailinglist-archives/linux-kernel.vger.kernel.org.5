Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840AB800C56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379011AbjLANiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378935AbjLANiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:38:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4A5193;
        Fri,  1 Dec 2023 05:38:59 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DYkGS022287;
        Fri, 1 Dec 2023 13:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vVEpKP86CU7nYjYMXZfEOvTvqo1GuRr5nR9ERFbnOc0=;
 b=Nb5gKnVSjEgBMS60bvVJp/fpSMgxXpChyyc3pi5rhA8y7mQCugb+tYQffTKOxYBwQVjq
 1uHz/wW9dX1b/QfhS4IJtKe2CyLXOod99gdqpBKv5WCGnS5mEU7e1SAFjzH59qB4J9IB
 K3OmsvFV2TOtl25Zn8IX4vkv8q89TYk+eUDlHFI9amlWUcX46eATnk2LAdikg/aspKXe
 8CVtVCy0W7n7HboLPO+5eqNvmXFgkUi0FJ2BlorDgFc7cxu5ohCtwcoj0OhE385fdupJ
 dpZh0bijZLg57/IIAWdYwTN/mN9AWO8Qcqau0Z2apP48PzjrNNQI01J3tXmYyMbyRQIO Xw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqggar0n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 13:38:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B1Dcsme002462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 13:38:54 GMT
Received: from [10.216.10.184] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Dec
 2023 05:38:50 -0800
Message-ID: <dad1f9e0-50dc-4d45-ae67-dada197b2a2b@quicinc.com>
Date:   Fri, 1 Dec 2023 19:08:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq9574: enable GPIO based LED
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231025-ipq9574-led-v2-1-59b2725697ad@quicinc.com>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20231025-ipq9574-led-v2-1-59b2725697ad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PsIFAKbVc8Tp9amb3-5ELsBdVgBOtjMc
X-Proofpoint-ORIG-GUID: PsIFAKbVc8Tp9amb3-5ELsBdVgBOtjMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=912 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 7:01 PM, Kathiravan Thirumoorthy wrote:
> Add support for wlan-2g LED on GPIO64.

Gentle Reminder...

> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
> Changes in v2:
> - Added function and color property
> - Link to v1: https://lore.kernel.org/r/20231025-ipq9574-led-v1-1-b8217e997dfb@quicinc.com
> ---
>   arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> index 49c9b6478357..91e104b0f865 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> @@ -10,6 +10,7 @@
>   
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>   #include "ipq9574.dtsi"
>   
>   / {
> @@ -51,6 +52,20 @@ button-wps {
>   			debounce-interval = <60>;
>   		};
>   	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_WLAN;
> +			gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>   };
>   
>   &blsp1_spi0 {
> @@ -117,6 +132,13 @@ gpio_keys_default: gpio-keys-default-state {
>   		drive-strength = <8>;
>   		bias-pull-up;
>   	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio64";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
>   };
>   
>   &usb_0_dwc3 {
> 
> ---
> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
> change-id: 20231025-ipq9574-led-8bdaab4c9cf6
> 
> Best regards,
