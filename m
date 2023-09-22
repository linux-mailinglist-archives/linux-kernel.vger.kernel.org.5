Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B57AA704
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjIVChh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVChg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:37:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5869F194;
        Thu, 21 Sep 2023 19:37:30 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M2SNvK026671;
        Fri, 22 Sep 2023 02:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=whvtgILcovoiaOjk4tY+EV0EFqxoiv7FyI5pE1pE//E=;
 b=C1vTUDJEajT1qnSACT1lJrbqM/QXMmCl0Jmz6xuze7a8Wmhmc7sVyw4udoCmE60ND/JF
 cVpRB3D/VVwrAfnIZ8WST5dZXlzv9+xPdK4XIYBtXy36TmolgdDpiNQ4OCTnxYRHUZ6R
 7DGtW/83tTHJHF7o8H/JLBVODs/Udwj3wtv6pg0mlTPlRE8YBWh1RWAtUo7xqZEHIXQQ
 qUO1Q3JWRyISCxXEXGH4flBhGOyI1F6BI3Q5lwb7sPMmn4SvygYYlvI8kQOa2+DKAdRn
 eXRj9x9dFNGJlctbZleB7IADCegCuubFlb9fnryy6htERT+O5UXFdMLNvcw4iLe9lg/i Vw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8tyxgt95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 02:36:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M2as3F004876
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 02:36:54 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 19:36:46 -0700
Message-ID: <e26059d7-5367-49fa-898d-0a14e854de45@quicinc.com>
Date:   Fri, 22 Sep 2023 10:36:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: add uart console support for
 SM4450
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <quic_ajipan@quicinc.com>,
        <kernel@quicinc.com>
References: <20230920065459.12738-1-quic_tengfan@quicinc.com>
 <20230920065459.12738-5-quic_tengfan@quicinc.com>
 <93ff26cc-f9b9-a064-8597-bc1a754d2dc2@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <93ff26cc-f9b9-a064-8597-bc1a754d2dc2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eOF5XcZ3qKceAqcVI7XOHwl079qMIm9w
X-Proofpoint-ORIG-GUID: eOF5XcZ3qKceAqcVI7XOHwl079qMIm9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=891 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/20/2023 6:03 PM, Konrad Dybcio 写道:
> 
> 
> On 9/20/23 08:54, Tengfei Fan wrote:
>> Add base description of UART and TLMM nodes which helps SM4450
>> boot to shell with console on boards with this SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> The SoC change must be separate from the board change.
> 
> [...]
> 
> Please leave a comment explaining what these GPIOs are
> used for.
I checked these gpio setting, the gpio0 ~ gpio3 are for NFC eSE SPI, 
gpio136 is for LPI Debug.
>> +&tlmm {
>> +    gpio-reserved-ranges = <0 4>, <136 1>;
>> +};
> 
> [...]
> 
>> +        qupv3_id_0: geniqup@ac0000 {
>> +            compatible = "qcom,geni-se-qup";
>> +            reg = <0x0 0x00ac0000 0x0 0x2000>;
>> +            ranges;
>> +            clock-names = "m-ahb", "s-ahb";
>> +            clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>> +                 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> property
> property-names
I will adjust these nodes.
> 
> [...]
> 
>> +
>> +            uart7: serial@a88000 {
>> +                compatible = "qcom,geni-debug-uart";
>> +                reg = <0 0x00a88000 0 0x4000>;
> Use 0x0 consistently.
I will update this for using "0x0" instead of "0".
> 
>> +                clock-names = "se";
>> +                clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> property
> property-names
I will adjust these nodes.
> 
>> +                interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>> +                pinctrl-names = "default";
>> +                pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
> ditto
I will adjust these nodes.
> 
> [...]
> 
>> +            compatible = "qcom,sm4450-tlmm";
>> +            reg = <0 0x0f100000 0 0x300000>;
> Use 0x0 consistently
I will update this for using "0x0" instead of "0"
> 
>> +            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +            gpio-ranges = <&tlmm 0 0 137>;
>> +            wakeup-parent = <&pdc>;
>> +
>> +            qup_uart7_rx: qup-uart7-rx-state {
>> +                pins = "gpio23";
>> +                function = "qup1_se2_l2";
>> +                drive-strength = <2>;
>> +                bias-disable;
>> +            };
>> +
>> +            qup_uart7_tx: qup-uart7-tx-state {
>> +                pins = "gpio22";
>> +                function = "qup1_se2_l2";
>> +                drive-strength = <2>;
>> +                bias-disable;
>> +            };
>> +        };
>> +
>>           intc: interrupt-controller@17200000 {
>>               compatible = "arm,gic-v3";
>>               reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
>> @@ -476,7 +525,6 @@
>>                   clocks = <&xo_board>;
>>               };
>>           };
>> -
> Totally unrelated change, fix the patch introducing it instead.
> 
> Konrad
Hi Konrad,
I will remove this rnrelated change.

-- 
Thx and BRs,
Tengfei Fan
