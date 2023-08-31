Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4786178E500
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbjHaDLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHaDLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:11:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45024CC2;
        Wed, 30 Aug 2023 20:11:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V35Iha017109;
        Thu, 31 Aug 2023 03:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YeEzwvxUn1WAX81VaEpzajYtp7+GEhvbmqc3BNHy2nk=;
 b=c7AvZiq/yJ1nn+waI0zq6Isxt7pbsimzYOQtJM1U6Dy35OiN7cMfEa2Z8nwNv+/Rg9VJ
 t1+/G65bb3EHpAj0Yk+2wG8rv9+B34hH4kez2b7XN/QWYUOUWOD3Tp80F6bLz9RUK/Z+
 mb+9LforlBnI8m/9GcCyXYfXQ7J6KcNR6paf3Wi6u7vLXy/hik3d+XHb+P/xO5sjgPw4
 bXDi4lF3pBYGpEPtUmldMWdds69zDOMW7z1QPlaNBJ/YRulCkCEiss7ETkBFVAglMYUS
 1DyPTTqaioMUvx9eUQPgda9Iojbvafsmc5WRShubTWRfpXcyIo1yim0ZoOnZCPz4ErdD XA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssv00aq0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 03:10:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V3Avdt010012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 03:10:57 GMT
Received: from [10.50.47.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 20:10:51 -0700
Message-ID: <bbb42f12-fcb5-ade6-ab67-60a4cdb29c43@quicinc.com>
Date:   Thu, 31 Aug 2023 08:40:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 3/4] arm64: dts: qcom: ipq5018: Add USB related nodes
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
References: <20230830111722.19380-1-quic_nsekar@quicinc.com>
 <20230830111722.19380-4-quic_nsekar@quicinc.com>
 <CAA8EJpr3SnEXRENAgzdemANnYWvwM7Z-xyZYe335O45Jps91kg@mail.gmail.com>
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
In-Reply-To: <CAA8EJpr3SnEXRENAgzdemANnYWvwM7Z-xyZYe335O45Jps91kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z7IT0J9C-ZqezfoN4bp6LT-VzFsQO5jX
X-Proofpoint-GUID: Z7IT0J9C-ZqezfoN4bp6LT-VzFsQO5jX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=798 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310027
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/2023 1:13 AM, Dmitry Baryshkov wrote:
> On Wed, 30 Aug 2023 at 21:30, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>> Add USB phy and controller nodes.
>>
>> Co-developed-by: Amandeep Singh <quic_amansing@quicinc.com>
>> Signed-off-by: Amandeep Singh <quic_amansing@quicinc.com>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> ---
>> V2:
>>          Fix ordering of the USB related nodes and use
>>          generic node names.
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 54 +++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..917e4a2d8e64 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -93,6 +93,19 @@
>>                  #size-cells = <1>;
>>                  ranges = <0 0 0 0xffffffff>;
>>
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
>>                  tlmm: pinctrl@1000000 {
>>                          compatible = "qcom,ipq5018-tlmm";
>>                          reg = <0x01000000 0x300000>;
>> @@ -155,6 +168,47 @@
>>                          status = "disabled";
>>                  };
>>
>> +               usb: usb@8af8800 {
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
> As we have seen from the next patchset, this host supports USB 3.0.
> Can you please drop the 2_0 part of the label?
Sure. Will drop "2_0".

Regards,
Nitheesh
