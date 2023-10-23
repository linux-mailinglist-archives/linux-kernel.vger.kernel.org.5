Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE47D3DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjJWRfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJWRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:35:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449994;
        Mon, 23 Oct 2023 10:35:01 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFINoQ009003;
        Mon, 23 Oct 2023 17:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yvlCbiRr18FdVxgfxneGyjIS4OoyzH6zgRsET/Jvi98=;
 b=cN/m+cgb4c7nh3fve4+y6YT7hVUwJeS6ieqdGF6RWBYFOnlXV3EfpDY9LeoZL10yoPeh
 nxY41pEJsan9ZcDOrExwBOGEMmJGqqEs63U1mX+fnyPC3PPJZEWBuihz0xe/nwfPLhKb
 1RG6pU1z76ZDtJ1J1zL/mgyaL+jsBgTpNFLafZ/NvVYHECSY3pxKz5FpqM32iu68kGfe
 OkSTXo49bwSaCFe/TARbOnm3Wj7tZFDuyBNfsuFV/bfarmDpm4AOpc8Mpo6CSUquqznr
 00y4nSGjGH2E+aT9F0qS5wIAiZhTus4sXbw85sjv3CW/PE7yyM08JuO3kpI3ZvJUIeHs pQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6r2cr1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:34:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NHYpPf017938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:34:51 GMT
Received: from [10.216.7.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 10:34:43 -0700
Message-ID: <c50e9266-2308-4fd5-b102-f604bf4ce2e8@quicinc.com>
Date:   Mon, 23 Oct 2023 23:04:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-9-quic_kriskura@quicinc.com>
 <ZTaauQewazaaFonF@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTaauQewazaaFonF@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f7QCm6TWSGo2izP2PykhLjqDjP3EZzbk
X-Proofpoint-GUID: f7QCm6TWSGo2izP2PykhLjqDjP3EZzbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=695 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 9:39 PM, Johan Hovold wrote:
> On Sat, Oct 07, 2023 at 09:18:04PM +0530, Krishna Kurapati wrote:
>> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
>> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
>> platforms.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 84 ++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index cad59af7ccef..5f64f75b07db 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -3330,6 +3330,90 @@ system-cache-controller@9200000 {
>>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>>   
>> +		usb_2: usb@a4f8800 {
>> +			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
> 
> So you went with a dedicated compatible even though you are now
> inferring the number of ports from the interrupts property.
> 
> Should we drop that compatible again or is there any other reason to
> keep a separate one?
>  >> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 129 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 128 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 131 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 130 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 133 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 132 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interrupt-names = "dp_hs_phy_1", "dm_hs_phy_1",
>> +					  "dp_hs_phy_2", "dm_hs_phy_2",
>> +					  "dp_hs_phy_3", "dm_hs_phy_3",
>> +					  "dp_hs_phy_4", "dm_hs_phy_4",
>> +					  "ss_phy_1", "ss_phy_2",
>> +					  "pwr_event_1",
>> +					  "pwr_event_2",
>> +					  "pwr_event_3",
>> +					  "pwr_event_4";
> 
> The interrupt order does not match the binding, where the power event
> interrupts come first.
> 
> And we probably also want the hs_phy_irqs here after fixing the
> incomplete binding.

You want to update the driver code for this as well ? I have no problem 
in adding it in DT and binding but not in driver.

> 
>> +			usb_2_dwc3: usb@a400000 {
>> +				compatible = "snps,dwc3";
>> +				reg = <0 0x0a400000 0 0xcd00>;
>> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> 
> I'd also like to know what that second dwc3 interrupt is for and whether
> it should be defined here as well.

Second interrupts is for HW acceleration I believe for which support is 
not there currently.

Regards,
Krishna,
