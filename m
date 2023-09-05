Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBCE792BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351144AbjIERFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354398AbjIELTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:19:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F9A1AB;
        Tue,  5 Sep 2023 04:19:46 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3859dRqR022051;
        Tue, 5 Sep 2023 11:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A5t1dlkYJ0wOotUEYyQn+vL7gadDWE9jXO6dxQeebf8=;
 b=pT5tYCH5Z0MV2uthVO76ZpxcV9gvNgS9n+qBRow17z8zjlN/+8KjJiqGYuDTvdjtMNbT
 tRjLjlwAxTiqLdoAxrhZHbPrvlCnUwHJfGPFo80DqSmfSJis3KIJN3IKNwyed/Apk7uS
 OsTr46SNlk8Ax9em87RG3ZAt26mynPGiCRow76F3674N3LDQmty2IiqLTP2nfiGb3/xv
 YPh7e+AiwkZ8yPMC296a44ollc1T2+TQxKrgarKP7oeC70idxvd1rMur0WCT27BZQFfW
 HypsQnMreN4RjSljwA/Frf677wjYofDL5oY/WBjWE6Em3R4WSws4ftXeutvn4GMfr7h8 Bg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swpr6h5fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 11:19:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385BJZNH026931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 11:19:35 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 5 Sep
 2023 04:19:31 -0700
Message-ID: <7355fb0a-f2a7-1af6-3369-a5996610e9cc@quicinc.com>
Date:   Tue, 5 Sep 2023 16:49:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] arm64: dts: ipq5018: Correct uart1_pins pinconf
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Ziyang Huang <hzyitc@outlook.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_gokulsri@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <b6fa8337-a5c0-172a-a41b-ab18de3f4f72@linaro.org>
 <TYZPR01MB555673C1E12A27DA8109DBEAC9EAA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <c6f4b93c-aa80-e250-d06b-6b3bdfbfc64b@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <c6f4b93c-aa80-e250-d06b-6b3bdfbfc64b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tGCfYoTi52mR0a0gyY9FY5HTxnNHlmKn
X-Proofpoint-GUID: tGCfYoTi52mR0a0gyY9FY5HTxnNHlmKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050100
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2023 6:27 AM, Bryan O'Donoghue wrote:
> On 03/09/2023 14:02, Ziyang Huang wrote:
>> 在 2023/9/1 23:04, Bryan O'Donoghue 写道:
>>> <...>
>>>
>>> The assignment of pins 20 and 21 to blsp1_uart1 is not correct.
>>>
>>> The blspX_uartY in pinctrl should match what is in the dtsi so 
>>> assigning pins_a above to blsp1_uart1 is not right. The dts name and 
>>> pinctrl name should be the same.
>>>
>>> Your console is on blsp0_uart0.
>>>
>>> https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot-2016/-/blob/5343739b4070bcec2fecd72f758c16adc31a3083/arch/arm/dts/ipq5018-mp03.3.dts#L33 
>>>
>>>
>>> So roughly speaking
>>>
>>> arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>>>
>>> aliases {
>>>      serial0 = &blsp0_uart0;
>>> };
>>>
>>> chosen {
>>>      stdout-path = "serial0:115200n8";
>>> };
>>>
>>> &blsp0_uart0 {
>>>          pinctrl-0 = <&uart0_pins>;
>>>          pinctrl-names = "default";
>>>          status = "okay";
>>> };
>>>
>>>
>>> arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>
>>> blsp0_uart0: serial@78af000
>>>
>>> either that or  blsp0_uart1 for pins28 and pins29 - you seem to 
>>> indicate pins_1 => blsp0_uart0.
>>>
>>> The two roots of the problem are
>>>
>>> 1. Mislabeling of the uart block in the dtsi
>>> 2. Invalid miscongiruation of pins for that misnamed block
>>>
>>> The fix should be
>>>
>>> 1. Fix the labeling of uart in the dtsi
>>> 2. Decide on which pins gpio20, gpio21 ? are the right ones to configure
>>>
>>> I thought you said in a previous email if you changed pins gpio28 and 
>>> gpio29 that the UART would fail if so that implies blsp0_uart1.
>>>
>>> Either way the pinctrl and dts should agree.
>>>
>>> ---
>>> bod
>>>
>>
>> No, please read my commit message carefully.
>>
>> The Y of pinctrl is the index of pinmux config. So it can't be used in 
>> the serial node definition.
>>
>> Please note that the physical port of first serial is configurable. It 
>> can use gpio20, gpio21 or/and gpio28,29. All of these pins are for the 
>> first serial.
>>
>> Let's take the second serial as an example. It has 3 configurable 
>> physical port groups - "blsp1_uart0" (pinconfig name, use GPIO 
>> 10,11,12,13), "blsp1_uart1" (gpio 31,32,33,34), "blsp1_uart2" (gpio 
>> 23,24,25,26).
>>
>> But the dts name of the second serial definition is "blsp1_uart2". 
>> Because it the second serial of the first BLSP block.
>>
>> Same logic. The dts name of the first serial definition is 
>> "blsp1_uart1". Because it the first serial of the first BLSP block.
>>
>> I think I need to introduce the architecture of these SoC. It has two 
>> BLSP block. Each BLSP block has several uart port.
>>
>> So the dts name of serial contains the BLSP index and the serial index 
>> inside BLSP. But pinconf name doesn't care about it. So it use global 
>> index. And due to the physical ports are configurable, it need pinmux 
>> index.
>>
>> The equation will be like this:
>>
>> dts name of serial definition: "blspX_uartY"
>> pinconf name: "blspU_uartV"
>> U = (uart_number_inside_each_blsp * (X - 1)) + (Y - 1)
> 
> I've checked the documentation for this chip.
> 
> gpio20, gpio21 = blsp0_uart0
> gpio28, gpio29 = blsp0_uart0
> 
> These pins are muxed to UART0, I agree, the u-boot dts also indicates 
> this also.
> 
> If we open the documentation further we see
> 
> 0x78AF000 = BLSP1_BLSP_UART0
> 0x79b0000 = BLSP1_BLSP_UART1
> 
> So for starters the dtsi has the _wrong_ label.
> 
> Here/anseo
> 
> grep uart0: arch/arm64/boot/dts/qcom/*
> arch/arm64/boot/dts/qcom/ipq5332.dtsi:        blsp1_uart0: serial@78af000 {
> arch/arm64/boot/dts/qcom/ipq9574.dtsi:        blsp1_uart0: serial@78af000 {
> 
> That's how that label ought to be the main hint something is askance is 
> assigning a pin named "blsp0_uart0" to a dts entry named "blsp1_uart1".
> 
> Please update the label in your next revision.
> 

   Agree here, both label (to blsp1_uart0) and pins needs to be updated
    (as in this patch).

Regards,
  Sricharan
