Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92D7A098D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbjINPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjINPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:44:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B2B99;
        Thu, 14 Sep 2023 08:44:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EFE4kh019136;
        Thu, 14 Sep 2023 15:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3URuZ09QSAKbBw6gINqV6mSQ/w4QlMbyqprEySlnHgk=;
 b=LAdnh+d4ilMfzDSnW9b1pUJOafFqnCIqMNX55X46+zzfI1pnrQ71DYNCEMHae8FFTr2D
 kjL7/gGyVy7LvJX8edGENEQ4a0P/4KtF4eMp7++hz8hckp1Kc/1hTX7pAPX0xITttxeX
 CFRu9vnnfTUj9zAwRXREqD1xe8W+0gbKndFumN1h0sw8PM/mIV30Hz3D72pfKMRe9hRb
 ANf7bLh9b48W27Vm08gNm3DTomHg/mhnW3K2Y4DK+qZQs4k9n5wPH8gUZm+jZ5PubOAS
 hugCLhNzdOjkeuI8ld9JvPJCGKStn0X5EvlO+qzpIy1EiwcbEKoxEbMEVG9eczygN79S GA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3h0dk63x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:44:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EFiFSN011248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:44:15 GMT
Received: from [10.216.57.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 08:44:07 -0700
Message-ID: <d69d480a-181b-52d8-e9f1-a80f1bdcb96c@quicinc.com>
Date:   Thu, 14 Sep 2023 21:14:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v11 12/13] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-13-quic_kriskura@quicinc.com>
 <f57229ea-69be-4df4-871e-65dfb0d56f5f@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <f57229ea-69be-4df4-871e-65dfb0d56f5f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _6q4ql8E1qgd2ZUlJawOgsWiQpJ_J39I
X-Proofpoint-GUID: _6q4ql8E1qgd2ZUlJawOgsWiQpJ_J39I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=850 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2023 5:41 PM, Konrad Dybcio wrote:
> On 28.08.2023 15:30, Krishna Kurapati wrote:
>> Enable tertiary controller for SA8295P (based on SC8280XP).
>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 53 ++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> index fd253942e5e5..473fe858fbed 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> @@ -9,6 +9,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include <dt-bindings/spmi/spmi.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>   
>>   #include "sa8540p.dtsi"
>>   #include "sa8540p-pmics.dtsi"
>> @@ -584,6 +585,20 @@ &usb_1_qmpphy {
>>   	status = "okay";
>>   };
>>   
>> +&usb_2 {
>> +	pinctrl-0 = <&usb2_en_state>,
>> +		    <&usb3_en_state>,
>> +		    <&usb4_en_state>,
>> +		    <&usb5_en_state>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_2_dwc3 {
>> +	dr_mode = "host";
> I believe you mentioned that the MP controller is host-only
> by design. If that's true, move this property to the SoC dtsi
> and leave an appropriate comment.
> 
Hi Konrad,

  Yes, it is host only controller. We can move this to sc8280xp.dtsi but 
wanted to keep uniformity, so made the change here. I can move it to 
base DT.

Regards,
Krishna,
