Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F27FB3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344009AbjK1ILc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1ILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:11:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCDFB0;
        Tue, 28 Nov 2023 00:11:34 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS5l8Mt012065;
        Tue, 28 Nov 2023 08:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BtNV9fxeItkU7fpOKRpTTkq1EpJ8ElvN9qoExmaMMo0=;
 b=F/8PUI6nWUUO7nyDMwGIOLj8+Ygb7FyG+GP9HGSehmaxC7LJlr7oR5i0Os//FSoh2YGK
 6VeV+21rCHeYKp53QVGSWYuWOFVRR5dGZ6qLmtE85kkmb5d88YrH5zhFy7P3+5DsIDWb
 wbLxsEhnFQ+0UAjcgIwtvBPT2Vivv55W8i6ISzcXbN/UpTXtENLS4UK1jxg6TgTcv0L/
 UyS8OXEb0/aHfsM2a5r7cFl4+ZWo9oPKYT/AtjuAsxIyzE3Cfa/L8SLqkjYtlRzLnoZy
 9UD3QI3prPP+wYWjvCkvF/aQNWD8lI5sZa+tlIl42CCdxxeKTOfn/5IekNLgXLfmuloy kw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umsvajsx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 08:11:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS8BJj1021367
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 08:11:19 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 00:11:14 -0800
Message-ID: <420ce17d-279e-47ee-9935-35bc03b89f98@quicinc.com>
Date:   Tue, 28 Nov 2023 16:11:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] arm64: dts: qcom: sm8550-aim300: add pmic glink
 port/endpoints
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-16-quic_tengfan@quicinc.com>
 <e3e27fec-8ab9-4331-a5aa-2958dd630b11@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <e3e27fec-8ab9-4331-a5aa-2958dd630b11@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cNJyJUBvkVNb_T6jO9n5Dp1jNc-2l6xe
X-Proofpoint-GUID: cNJyJUBvkVNb_T6jO9n5Dp1jNc-2l6xe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_07,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=899 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/17/2023 6:32 PM, Dmitry Baryshkov 写道:
> On 17/11/2023 12:18, Tengfei Fan wrote:
>> Add nodes to support Type-C USB/DP functionality.
>>
>> On this platform, a Type-C redriver is added to the SuperSpeed graph.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 88 +++++++++++++++++++++-
>>   1 file changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts 
>> b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>> index 6dc3040b9f76..f3c558dd40f1 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>> @@ -100,7 +100,15 @@
>>                       reg = <1>;
>>                       pmic_glink_ss_in: endpoint {
>> -                        remote-endpoint = <&usb_1_dwc3_ss>;
>> +                        remote-endpoint = <&redriver_ss_out>;
>> +                    };
>> +                };
>> +
>> +                port@2 {
>> +                    reg = <2>;
>> +
>> +                    pmic_glink_sbu: endpoint {
>> +                        remote-endpoint = <&fsa4480_sbu_mux>;
>>                       };
>>                   };
>>               };
>> @@ -519,6 +527,62 @@
>>       };
>>   };
>> +&i2c_master_hub_0 {
>> +    status = "okay";
>> +};
>> +
>> +&i2c_hub_2 {
>> +    status = "okay";
>> +
>> +    typec-mux@42 {
>> +        compatible = "fcs,fsa4480";
>> +        reg = <0x42>;
>> +
>> +        vcc-supply = <&vreg_bob1>;
>> +
>> +        mode-switch;
>> +        orientation-switch;
>> +
>> +        port {
>> +            fsa4480_sbu_mux: endpoint {
>> +                remote-endpoint = <&pmic_glink_sbu>;
>> +            };
>> +        };
>> +    };
>> +
>> +    typec-retimer@1c {
>> +        compatible = "onnn,nb7vpq904m";
>> +        reg = <0x1c>;
>> +
>> +        vcc-supply = <&vreg_l15b_1p8>;
>> +
>> +        orientation-switch;
>> +        retimer-switch;
>> +
>> +        ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            port@0 {
>> +                reg = <0>;
>> +
>> +                redriver_ss_out: endpoint {
>> +                    remote-endpoint = <&pmic_glink_ss_in>;
>> +                };
>> +            };
>> +
>> +            port@1 {
>> +                reg = <1>;
>> +
>> +                redriver_ss_in: endpoint {
>> +                    data-lanes = <3 2 1 0>;
>> +                    remote-endpoint = <&usb_dp_qmpphy_out>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +};
>> +
>>   &gcc {
>>       clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>>            <&pcie0_phy>,
>> @@ -552,6 +616,16 @@
>>       status = "okay";
>>   };
>> +&mdss_dp0 {
>> +    status = "okay";
>> +};
>> +
>> +&mdss_dp0_out {
>> +    data-lanes = <0 1>;
> 
> Why? Are you really limited to two lanes for DP by the hardware?
I got confirmation from a colleague that it is right that limited to two 
lanes.
> 
>> +    remote-endpoint = <&usb_dp_qmpphy_dp_in>;
>> +};
>> +
>> +
>>   &mdss_dsi0 {
>>       vdda-supply = <&vreg_l3e_1p2>;
>>       status = "okay";
>> @@ -861,6 +935,18 @@
>>       status = "okay";
>>   };
>> +&usb_dp_qmpphy_dp_in {
>> +    remote-endpoint = <&mdss_dp0_out>;
>> +};
>> +
>> +&usb_dp_qmpphy_out {
>> +    remote-endpoint = <&redriver_ss_in>;
>> +};
>> +
>> +&usb_dp_qmpphy_usb_ss_in {
>> +    remote-endpoint = <&usb_1_dwc3_ss>;
>> +};
>> +
>>   &xo_board {
>>       clock-frequency = <76800000>;
>>   };
> 

-- 
Thx and BRs,
Tengfei Fan
