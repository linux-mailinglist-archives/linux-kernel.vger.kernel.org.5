Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEEF7F5AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjKWJNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjKWJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:13:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B87110;
        Thu, 23 Nov 2023 01:13:10 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN5e16q023357;
        Thu, 23 Nov 2023 09:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=R1MstDJ8CIIiWC33qCoujysCOOyU8yLgfVLN1jiD2TE=;
 b=e0OtR3EpVCON1pYiS0IZ/hi7colb1Jdk8vidZ2C1mtI2HHZvGhC6349Klw+Ndq4eJeLQ
 ZVr1mIA4I7HqvUFy/KFI3VluDP4wiR78j39U0Yy1VV7kOqF6hT36LWpOl87QIaRRMLU7
 8lBv0N/JM5oPgfWyWONrbPGPg6aNmn42yYouwLlYB9zO3rMOy0Z5ig0P3EEruLWphG2Z
 jrUULSQBD+B3IhLk/h8JfHuUCQtUxBjDBOCBF2b7L8UOT5tEKQw5O4qbTyBVt9gr3isJ
 Grwnj6LK6829TYXPJI3d2ok7Ox9p+rF0xQagu2vFWrq7PUoGBa4Sjx6oqq7eXwad4arZ Ow== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhf6ktvdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:13:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AN9D5Gf005021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:13:05 GMT
Received: from [10.216.59.116] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 01:13:01 -0800
Message-ID: <a717ac7d-a112-4259-b28f-17a79069c766@quicinc.com>
Date:   Thu, 23 Nov 2023 14:42:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: Fix hs_phy_irq for
 SDM670/SDM845/SM6350
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_wcheng@quicinc.com>
References: <20231122191452.3183-1-quic_kriskura@quicinc.com>
 <640523aa-6b14-417c-8a62-e02d17a26ce7@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <640523aa-6b14-417c-8a62-e02d17a26ce7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6hKz-unZF0ZBTsiw3422jSb4vadf7zOE
X-Proofpoint-ORIG-GUID: 6hKz-unZF0ZBTsiw3422jSb4vadf7zOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=790 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2023 2:21 PM, Krzysztof Kozlowski wrote:
> On 22/11/2023 20:14, Krishna Kurapati wrote:
>> For sm6350/sdm670/sdm845, although they are qusb2 phy targets, dp/dm
>> interrupts are used for wakeup instead of qusb2_phy irq. These targets
>> were part of a generation that were the last ones to implement QUSB2 PHY
>> and the design incorporated dedicated DP/DM interrupts which eventually
>> carried forward to the newer femto based targets.
>>
>> Add the missing pwr_event irq for these targets.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm670.dtsi |  5 ++++-
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++--
>>   arch/arm64/boot/dts/qcom/sm6350.dtsi |  7 +++++--
>>   3 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> index 6d9843d05cb3..b8888f71b1d6 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> @@ -1296,10 +1296,13 @@ usb_1: usb@a6f8800 {
>>   			assigned-clock-rates = <19200000>, <150000000>;
>>   
>>   			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>>   				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
>>   				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
>>   				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
>> -			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>> +			interrupt-names = "hs_phy_irq",
>> +					  "pwr_event",
>> +					  "ss_phy_irq",
>>   					  "dm_hs_phy_irq", "dp_hs_phy_irq";
> 
> New entries should be added usually to the end of the list. Commit msg
> does not explain this to me why new entry is in the middle of the list.
> 

Actually there is no proper rationale from my end why I added them in 
middle. The only reason I did it was that because in many places the 
interrupt was mis-named or missing. So when making changes, I just put 
the missing interrupt next to hs_phy_irq. But my reasoning doesn't make 
much sense. Sorry for that.

Thanks for the review. Will put the extra interrupt at the end.

Regards,
Krishna,
