Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB39B78E4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbjHaCvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjHaCvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:51:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B601BF;
        Wed, 30 Aug 2023 19:51:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V2S2aX013410;
        Thu, 31 Aug 2023 02:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gm1AbBaS6tTXaMdt9QpEidBZ5HzmTnaUJfvH6F1e1AI=;
 b=VR4/1wSUs0/rVP5uNhvjT3Qm03HRu8/5r9DXh1Y5ktkca9sq5w8AwV2KnUEhBeeCtbMB
 WWDaELfgyJvU79C9TXPigYs5RKRDAtKxNF5edgpS8rBXAJEGC50FB/o8epBiq3KKWXiV
 fWukEpn3Ho1JNOcK2jwabM0+koe+EVaeUaZiAXSP7ajKx3nzmeG7DzEOqnoahqAIuYho
 qqT4N1YYmwuBUFeYrmRusM9fUSTk1W5+twvQV4Nu10ZjG1iqvDKZM0pQ+P6krPxVPEI7
 7kbG0grbhu44yOA9b/yaOx1leqeVFZ+ct/RvMC6ZAmyIFhT8GSD5yEBIsV4Fkw1MZY/x lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stj378199-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 02:50:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V2ovHb018369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 02:50:57 GMT
Received: from [10.50.47.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 19:50:40 -0700
Message-ID: <732a5351-f51f-59fe-ec5f-88ad638e5c81@quicinc.com>
Date:   Thu, 31 Aug 2023 08:20:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] arm64: dts: qcom: ipq5018: Add USB related nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Amandeep Singh <quic_amansing@quicinc.com>
References: <20230825093531.7399-1-quic_nsekar@quicinc.com>
 <20230825093531.7399-5-quic_nsekar@quicinc.com>
 <CAA8EJprLwi3QKgTksTeSWkjmhFL69PO8Zmc=j3VMfAr_UpXJ=g@mail.gmail.com>
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
In-Reply-To: <CAA8EJprLwi3QKgTksTeSWkjmhFL69PO8Zmc=j3VMfAr_UpXJ=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 18UEUSAl_1CghyGxmk-O1L6pm_KOgJVH
X-Proofpoint-ORIG-GUID: 18UEUSAl_1CghyGxmk-O1L6pm_KOgJVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 mlxlogscore=819 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310024
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/2023 1:45 AM, Dmitry Baryshkov wrote:
> On Fri, 25 Aug 2023 at 12:37, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>> Add USB phy and controller nodes.
>>
>> Co-developed-by: Amandeep Singh <quic_amansing@quicinc.com>
>> Signed-off-by: Amandeep Singh <quic_amansing@quicinc.com>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 54 +++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..ff477923a823 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -238,6 +238,60 @@
>>                                  status = "disabled";
>>                          };
>>                  };
>> +
>> +               usbphy0: phy@5b000 {
>> +                       compatible = "qcom,ipq5018-usb-hsphy";
>> +                       reg = <0x0005b000 0x120>;
>> +
>> +                       clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
>> +
>> +                       resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
>> +
>> +                       #phy-cells = <0>;
>> +
>> +                       status = "disabled";
>> +               };
>> +
>> +               usb: usb2@8a00000 {
>> +                       compatible = "qcom,ipq5018-dwc3", "qcom,dwc3";
>> +                       reg = <0x08af8800 0x400>;
>> +
>> +                       interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "hs_phy_irq";
>> +
>> +                       clocks = <&gcc GCC_USB0_MASTER_CLK>,
>> +                                <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
>> +                                <&gcc GCC_USB0_SLEEP_CLK>,
>> +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>> +                       clock-names = "core",
>> +                                     "iface",
>> +                                     "sleep",
>> +                                     "mock_utmi";
>> +
>> +                       resets = <&gcc GCC_USB0_BCR>;
>> +
>> +                       qcom,select-utmi-as-pipe-clk;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges;
>> +
>> +                       status = "disabled";
>> +
>> +                       usb2_0_dwc: usb@8a00000 {
> Could you please remove the `2_0' part of the label?
Sure.

Regards,
Nitheesh
