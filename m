Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18510808C2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443544AbjLGPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjLGPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:45:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6410CA;
        Thu,  7 Dec 2023 07:45:16 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7B0EB8021167;
        Thu, 7 Dec 2023 15:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ITywNu0Suc/YQC4o3PPSo94jnMG2sJT5GusxuK3R6WY=;
 b=fc2XTcCJTQARMf8TcWc4bz9kJWat5sNobNV31FfQpGtEOMREx24NrSEk/gjQCYojGzee
 t9JktYMdeQbzoSthjqsYbAOI0QZ68xAq8N90xn/t8FJ93M3YUoLd9eqawPsLrAcbrasB
 gnYaFcsGUEWkkqEfmcpeKCcqsboKT1cEVIUtioBwfliPC21u0lxkz6GZmaBxwPs740Bu
 sSLAIE/ZdJwZgYoGnUp2qka7l1a630T7q2uPp5iG8CXVCqoHz9zFpjtM/mPjHTAtmvlH
 8YR1jI/sJQ0Mzi5S2FWH4i77e/2mI3PZS0SHhPIsAsHmgPPdrHH9hvjHrEdx9N/a0CoD dw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utt70bcag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 15:45:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B7Fj7Mb031983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 15:45:07 GMT
Received: from [10.216.4.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 07:45:00 -0800
Message-ID: <028097f3-9056-4c07-a868-4eeac9bc8c94@quicinc.com>
Date:   Thu, 7 Dec 2023 21:14:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20231204100950.28712-1-quic_kriskura@quicinc.com>
 <20231204100950.28712-2-quic_kriskura@quicinc.com>
 <ZXHjXGEbdtbCiOck@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZXHjXGEbdtbCiOck@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1WG_AKh5pcew3-IAAqB3E5qn9KVawZc2
X-Proofpoint-GUID: 1WG_AKh5pcew3-IAAqB3E5qn9KVawZc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312070129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Johan. Thanks for the review.

> 
> And say something about the SS PHY interrupt being treated as optional
> as there are SoCs with multiple controllers where only some supports SS.
> 
> As Krzysztof mentioned you should also add something to motivate why
> this de-facto ABI breakage by reordering interrupts is justified and
> safe in this case.
>   
Sure. Let me come up with a good reason why this breakage is needed.


> 
> Try to use uppercase 'PHY' consistently in text throughout the series.
> 
ACK.

>> +        - qusb2_phy:: SoCs with QUSB2 PHY do not have separate DP/DM IRQs and
>> +                      expose only a single IRQ whose behavior can be modified
>> +                      by the QUSB2PHY_INTR_CTRL register. The required DPSE/
>> +                      DMSE configuration is done in QUSB2PHY_INTR_CTRL register
>> +                      of phy address space.
>> +        - {dp/dm}_hs_phy_irq:: These IRQ's directly reflect changes on the DP/
>> +                               DM pads of the SoC. These are used for wakeup
>> +                               only on SoCs with non-QUSBb2 targets with
> 
> QUSB2 typo
> 
>> +                               exception of SDM670/SDM845/SM6350.
>> +        - ss_phy_irq:: When in super speed mode of operation, interrupts are
> 
> Capitalise 'Super Speed'
> 
>> +                       received when a wakeup event is received on ss_phy_irq.
> 
> The description as it stands sounds circular. And this one is only used
> for remote wakeup right?
> 
Yes. It is used for remote wakeup. Mentioning it as wakeup event should 
be changed ?

>> +        - hs_phY_irq:: Apart from DP/DM/QUSB2 Phy interrupts, there is
> 
> s/phY/phy/
> 
> Perhaps rephrase to sound less like a commit message and to make it a
> bit more concise.
> 
> But this is already an improvement over the current descriptions which
> are too terse and not even correct.
> 
>> +                       hs_phy_irq which is not triggered by default and its
>> +                       functionality is mutually exclusive to that of
>> +                       {dp/dm}_hs_phy_irq and qusb2_phy_irq.
>> +        - pwr_event:: Used for wakeup based on other power events.
> 
> I'm not sure about the free text description of these (format etc), but
> at least this avoid repeating the descriptions for each permutation.
> 
> Perhaps the DT maintainers can chime in here.
> 
> I think you should reorder them to match the permutations below though.
> 
Sure. Will reorder them as per permutations.

>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     interrupt-names:
>> -    minItems: 1
>> -    maxItems: 4
>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     qcom,select-utmi-as-pipe-clk:
>>       description:
>> @@ -359,116 +377,54 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> -              - qcom,ipq4019-dwc3
>> +              - qcom,ipq5018-dwc3
>>                 - qcom,ipq6018-dwc3
>> -              - qcom,ipq8064-dwc3
>>                 - qcom,ipq8074-dwc3
>> -              - qcom,msm8994-dwc3
>> -              - qcom,qcs404-dwc3
>> -              - qcom,sc7180-dwc3
>> -              - qcom,sdm670-dwc3
>> -              - qcom,sdm845-dwc3
>> -              - qcom,sdx55-dwc3
>> -              - qcom,sdx65-dwc3
>> -              - qcom,sdx75-dwc3
>> -              - qcom,sm4250-dwc3
>> -              - qcom,sm6350-dwc3
>> -              - qcom,sm8150-dwc3
>> -              - qcom,sm8250-dwc3
>> -              - qcom,sm8350-dwc3
>> -              - qcom,sm8450-dwc3
>> -              - qcom,sm8550-dwc3
>> -              - qcom,sm8650-dwc3
>> +              - qcom,msm8953-dwc3
>> +              - qcom,msm8998-dwc3
>> +              - qcom,qcm2290-dwc3
>>       then:
>>         properties:
>> -        interrupts:
>> -          items:
>> -            - description: The interrupt that is asserted
>> -                when a wakeup event is received on USB2 bus.
>> -            - description: The interrupt that is asserted
>> -                when a wakeup event is received on USB3 bus.
>> -            - description: Wakeup event on DM line.
>> -            - description: Wakeup event on DP line.
>>           interrupt-names:
>>             items:
>> -            - const: hs_phy_irq
>> -            - const: ss_phy_irq
>> -            - const: dm_hs_phy_irq
>> -            - const: dp_hs_phy_irq
>> +            - const: pwr_event
>> +            - const: qusb2_phy
>> +            - const: ss_phy_irq (optional)
> 
> You should not include the string "(optional)" here. It was only a
> notation I used when we discussed this earlier.
> 
> The fact that these are optional should be expressed using min/maxItems
> as I mentioned earlier. For the above SoCs that would be
> 
> 	minItems: 2
> 	maxItems: 3
>  >> @@ -522,12 +490,13 @@ examples:
>>                             <&gcc GCC_USB30_PRIM_MASTER_CLK>;
>>               assigned-clock-rates = <19200000>, <150000000>;
>>   
>> -            interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>> -                         <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
>> +            interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>,
>>                            <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
>> -                         <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
>> -            interrupt-names = "hs_phy_irq", "ss_phy_irq",
>> -                          "dm_hs_phy_irq", "dp_hs_phy_irq";
>> +                         <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "pwr_event", "hs_phy_irq",
>> +                          "dp_hs_phy_irq", "dm_hs_phy_irq", "ss_phy_irq";
> 
> Perhaps you should align the continuation line here too.
> 
>>   
>>               power-domains = <&gcc USB30_PRIM_GDSC>;
> 
> Also have you set up the tools so that you can verify your bindings
> before posing them? I assume the above wouldn't pass (e.g. due to the
> "(optional)" strings).
> 
> There's some more details here:
> 
> 	https://docs.kernel.org/devicetree/bindings/writing-schema.html
> 
> under "Running checks".

I did do a dt-binding check and got the following line as well:

   DTC_CHK Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb
/local/mnt/workspace/sriramd/upstream/torvalds/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: 
usb@a6f8800: interrupt-names:4: 'ss_phy_irq (optional)' was expected
         From schema:

I ignored this because it isn't a warning and the example dtb too was 
generated. Will remove the optional thing in v3.

Regards,
Krishna,
