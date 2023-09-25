Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735D27AD58A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjIYKLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjIYKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:11:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EDACC0;
        Mon, 25 Sep 2023 03:10:51 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P9WaoX014344;
        Mon, 25 Sep 2023 10:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1Dg1AF+QNqKPLVes4rcD/6Z3XXkbKJBsfaWUKNHAO5Y=;
 b=fu9qhDcSxbfQKytaDCjBqpM+0yuFkVRgTbb5RWs/YgDy0SNxlRE35Ds1C/4ubIIxc72b
 1xHlIBPXGpF86pcs09XuJAvcqNfOqi8IoEx94d/CBPOUvehbWpdA3S1QC1lhFaQkSW+/
 fjaUL1Rp0ONvb9g/cIASg93A4ufBU5tJ2XtRzBL1Ft/ryXebH+6inHC7UOWcy0J2etfm
 eFDyNOAVClOFWd0MGaCuYBV85G+dPNRtjF5PB7vo2K99KL0WH3rGXEGj62ZlDdPOjnyK
 Ti4o2N5OafPnMMRdGSuj7ulMJjQLUy/wuetH91jxt9pNG4Qvi75J1Ytw6yxIvKHKTBAf MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb3hfruh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:10:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PAAiDl031058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:10:44 GMT
Received: from [10.216.42.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 03:10:39 -0700
Message-ID: <ae3a4224-ddf1-4a48-8fff-001318070b67@quicinc.com>
Date:   Mon, 25 Sep 2023 15:40:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: Add USB3 and PHY support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1695383434-24705-1-git-send-email-quic_rohiagar@quicinc.com>
 <1695383434-24705-3-git-send-email-quic_rohiagar@quicinc.com>
 <29b774d4-3759-4b49-926e-551c92d3f8c7@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <29b774d4-3759-4b49-926e-551c92d3f8c7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cwei_RV7itqWXPrPcoHvSqmGbRNnn_k_
X-Proofpoint-ORIG-GUID: cwei_RV7itqWXPrPcoHvSqmGbRNnn_k_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/2023 12:49 AM, Dmitry Baryshkov wrote:
> On 22/09/2023 14:50, Rohit Agarwal wrote:
>> Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
>> HS PHY on SDX75.
>
> Please fix the subject to mention the platform.
>
> Other than that, LGTM.
Oh missed it.

Thanks,
Rohit.
>
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 116 
>> ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> index dd3a525..c44cdd1 100644
>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -473,6 +473,47 @@
>>               };
>>           };
>>   +        usb_hsphy: phy@ff4000 {
>> +            compatible = "qcom,sdx75-snps-eusb2-phy", 
>> "qcom,sm8550-snps-eusb2-phy";
>> +            reg = <0x0 0x00ff4000 0x0 0x154>;
>> +            #phy-cells = <0>;
>> +
>> +            clocks = <&rpmhcc RPMH_CXO_CLK>;
>> +            clock-names = "ref";
>> +
>> +            resets = <&gcc GCC_QUSB2PHY_BCR>;
>> +
>> +            status = "disabled";
>> +        };
>> +
>> +        usb_qmpphy: phy@ff6000 {
>> +            compatible = "qcom,sdx75-qmp-usb3-uni-phy";
>> +            reg = <0x0 0x00ff6000 0x0 0x2000>;
>> +
>> +            clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
>> +                 <&gcc GCC_USB2_CLKREF_EN>,
>> +                 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
>> +                 <&gcc GCC_USB3_PHY_PIPE_CLK>;
>> +            clock-names = "aux",
>> +                      "ref",
>> +                      "cfg_ahb",
>> +                      "pipe";
>> +
>> +            power-domains = <&gcc GCC_USB3_PHY_GDSC>;
>> +
>> +            resets = <&gcc GCC_USB3_PHY_BCR>,
>> +                 <&gcc GCC_USB3PHY_PHY_BCR>;
>> +            reset-names = "phy",
>> +                      "phy_phy";
>> +
>> +            #clock-cells = <0>;
>> +            clock-output-names = "usb3_uni_phy_pipe_clk_src";
>> +
>> +            #phy-cells = <0>;
>> +
>> +            status = "disabled";
>> +        };
>> +
>>           system_noc: interconnect@1640000 {
>>               compatible = "qcom,sdx75-system-noc";
>>               reg = <0x0 0x01640000 0x0 0x4b400>;
>> @@ -493,6 +534,81 @@
>>               #hwlock-cells = <1>;
>>           };
>>   +        usb: usb@a6f8800 {
>> +            compatible = "qcom,sdx75-dwc3", "qcom,dwc3";
>> +            reg = <0x0 0x0a6f8800 0x0 0x400>;
>> +            #address-cells = <2>;
>> +            #size-cells = <2>;
>> +            ranges;
>> +
>> +            clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
>> +                 <&gcc GCC_USB30_MASTER_CLK>,
>> +                 <&gcc GCC_USB30_MSTR_AXI_CLK>,
>> +                 <&gcc GCC_USB30_SLEEP_CLK>,
>> +                 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
>> +            clock-names = "cfg_noc",
>> +                      "core",
>> +                      "iface",
>> +                      "sleep",
>> +                      "mock_utmi";
>> +
>> +            assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
>> +                      <&gcc GCC_USB30_MASTER_CLK>;
>> +            assigned-clock-rates = <19200000>, <200000000>;
>> +
>> +            interrupts-extended = <&intc GIC_SPI 131 
>> IRQ_TYPE_LEVEL_HIGH>,
>> +                          <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
>> +                          <&pdc 9 IRQ_TYPE_EDGE_RISING>,
>> +                          <&pdc 10 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "hs_phy_irq",
>> +                      "ss_phy_irq",
>> +                      "dm_hs_phy_irq",
>> +                      "dp_hs_phy_irq";
>> +
>> +            power-domains = <&gcc GCC_USB30_GDSC>;
>> +
>> +            resets = <&gcc GCC_USB30_BCR>;
>> +
>> +            interconnects = <&system_noc MASTER_USB3_0 0 &mc_virt 
>> SLAVE_EBI1 0>,
>> +                    <&gem_noc MASTER_APPSS_PROC 0 &system_noc 
>> SLAVE_USB3 0>;
>> +            interconnect-names = "usb-ddr",
>> +                         "apps-usb";
>> +
>> +            status = "disabled";
>> +
>> +            usb_dwc3: usb@a600000 {
>> +                compatible = "snps,dwc3";
>> +                reg = <0x0 0x0a600000 0x0 0xcd00>;
>> +                interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +                iommus = <&apps_smmu 0x80 0x0>;
>> +                snps,dis_u2_susphy_quirk;
>> +                snps,dis_enblslpm_quirk;
>> +                phys = <&usb_hsphy>,
>> +                       <&usb_qmpphy>;
>> +                phy-names = "usb2-phy",
>> +                        "usb3-phy";
>> +
>> +                ports {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    port@0 {
>> +                        reg = <0>;
>> +
>> +                        usb_1_dwc3_hs: endpoint {
>> +                        };
>> +                    };
>> +
>> +                    port@1 {
>> +                        reg = <1>;
>> +
>> +                        usb_1_dwc3_ss: endpoint {
>> +                        };
>> +                    };
>> +                };
>> +            };
>> +        };
>> +
>>           pdc: interrupt-controller@b220000 {
>>               compatible = "qcom,sdx75-pdc", "qcom,pdc";
>>               reg = <0x0 0xb220000 0x0 0x30000>,
>
