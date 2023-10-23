Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D717D3E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjJWRnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjJWRnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:43:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E498;
        Mon, 23 Oct 2023 10:43:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NGrEWF021316;
        Mon, 23 Oct 2023 17:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Thbvvz6X+dAXdwI8GyfmFVSpYdfQyNnRvRh5T6KVgDs=;
 b=dnurKmnxAhvUTlo44pBlF+ZYn8UMDEf2aCqDckdxHoVmISI0dPSFEa6klZCDBWvH1moa
 lChPJ5MkEbpvaUwuWyvWPEkqNIAFgMF0wVZ4LmVS7rLaHXj5zIwt3IHnPd6ygP4IAJVr
 oK3afcJyYH4YUmLmu5uin15Uydp4YOE83PBb47Jazb9ij5z1x0jOL9vs4mW94AHFp9NW
 Q8EGeOHrFZ1OnxRAawB3XvbctXekLr9dpeZPkEXAsBXLJK8oiSDrBUNcBTRo67cea+jU
 bwCid2a/H2ONmnYlFk0uqPDDRkEOSZgl3L/JIMewKNtm5GeqXdpbv72HBQ5UMcO2p4bs rw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twtxwrejb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:42:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NHgqIF007389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:42:52 GMT
Received: from [10.216.7.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 10:42:45 -0700
Message-ID: <faa647ed-9692-4233-b421-b9e6271f8934@quicinc.com>
Date:   Mon, 23 Oct 2023 23:12:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/10] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
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
 <20231007154806.605-10-quic_kriskura@quicinc.com>
 <ZTad-_toGkumYx6O@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTad-_toGkumYx6O@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gM9Yoy4cwfT-mfFK2KJNiKj1cExvwry2
X-Proofpoint-GUID: gM9Yoy4cwfT-mfFK2KJNiKj1cExvwry2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=792 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230154
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 9:53 PM, Johan Hovold wrote:
> On Sat, Oct 07, 2023 at 09:18:05PM +0530, Krishna Kurapati wrote:
>> Enable tertiary controller for SA8295P (based on SC8280XP).
>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 49 ++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> index fd253942e5e5..271000163823 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> @@ -9,6 +9,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include <dt-bindings/spmi/spmi.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> 
> Sort order ('p' < 'r').

ACK

> 
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
>>   &usb_2_hsphy0 {
>>   	vdda-pll-supply = <&vreg_l5a>;
>>   	vdda18-supply = <&vreg_l7g>;
>> @@ -729,3 +740,41 @@ wake-n-pins {
>>   		};
>>   	};
>>   };
>> +
>> +&pmm8540c_gpios {
> 
> Sort order here too ('p' < 't' in "&tlmm").
> 

ACK.

>> +	usb2_en_state: usb2-en-state {
> 
> No need to include '_state' in the labels.
> 
Any specific reason ? I have no problem if removing the suffix but just 
wanted to know the reason.

Regards,
Krishna,
