Return-Path: <linux-kernel+bounces-24253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624882B9C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F278428B887
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477515C9;
	Fri, 12 Jan 2024 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kJdMy8Ng"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1FE4A17;
	Fri, 12 Jan 2024 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C2SG8g003747;
	Fri, 12 Jan 2024 02:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K9rG+1inthzVupqDCl9ITquyQKh0W1FGU7JQyB42Bfc=; b=kJ
	dMy8NgjhnTfxAolMlb7//U1r3TQQx0XRcp1O2GOV/Rjs1ST1k2TZb0zx5IX0qNme
	G4rWUvyxAiax/Ap0IpIvHWkgGSuz0ETo2bHKKYs5ufquRzGSMrojVkkszQS1FZnA
	ijwuhQQjrMJcvE83N7Sxzkdk5gPK6juHZDuVMYndi4KryFgPTTIf9JzDKSht+ov3
	gYVJfM7p8aSPZjoOiOf/FDsvUOqMIVCqGiRmg66v3e/rf2fUHa3VdE/VAG4pfI/A
	vHYku3i6vh4jFrGIN0vn+NJSurAGEJb62q6lHsXP70/joIPihxg+9iPVsWEAA3GC
	kin6wlPbWQ67mk9FTt6A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcsk2b63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:58:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C2wRoY002959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:58:27 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 18:58:24 -0800
Message-ID: <7a3422b4-0f05-4224-b2f5-540b5ad5fdc8@quicinc.com>
Date: Fri, 12 Jan 2024 10:58:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] arm64: dts: qcom: qcs6490-idp: Add definition
 for three LEDs.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss
	<luca.weiss@fairphone.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240111-lpg-v3-1-811c9e82dae4@quicinc.com>
 <CYBQW9KRHVJS.3UOHTOMRWDWVK@fairphone.com>
 <3476ab0f-1589-4023-9951-3c03ab2467c3@linaro.org>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <3476ab0f-1589-4023-9951-3c03ab2467c3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s0cZwc6Ccd6nsgq7Q2eGI8Msdju7A_P9
X-Proofpoint-GUID: s0cZwc6Ccd6nsgq7Q2eGI8Msdju7A_P9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0
 mlxlogscore=930 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120020



On 1/11/2024 4:58 PM, Krzysztof Kozlowski wrote:
> On 11/01/2024 09:47, Luca Weiss wrote:
>> On Thu Jan 11, 2024 at 3:52 AM CET, Hui Liu via B4 Relay wrote:
>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>
>>> Add definition for three LEDs to make sure they can
>>> be enabled base on QCOM LPG LED driver.
>>>
>>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>>> ---
>>> Changes in v3:
>>> - Rephrased commit text and updated the nodes to qcm6490-idp board file.
>>> - Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com/
>>>
>>> Changes in v2:
>>> - Rephrased commit text and updated the nodes to board file.
>>> - Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 25 +++++++++++++++++++++++++
>>>   1 file changed, 25 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> index 37c91fdf3ab9..f801144a1556 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> @@ -5,6 +5,7 @@
>>>   
>>>   /dts-v1/;
>>>   
>>> +#include <dt-bindings/leds/common.h>
>>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>   #include "sc7280.dtsi"
>>>   #include "pm7325.dtsi"
>>> @@ -414,6 +415,30 @@ vreg_bob_3p296: bob {
>>>   	};
>>>   };
>>>   
>>> +&pm8350c_pwm {
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +	status = "okay";
>>> +
>>> +	led@1 {
>>> +		reg = <1>;
>>
>> Hi Hui Liu,
>>
>>> +		color = <LED_COLOR_ID_RED>;
>>> +		label = "red";
>>
>> Please remove the deprecated "label" property. Since you already have
>> "color" set you only need to add "function". On phones for the
>> notification LED we usually use "function = LED_FUNCTION_STATUS;"
>>
>> Also depends on what your hardware looks like, if it's 3 separate LEDs
>> then with label replaced it would be okay.
>> If the 3 LEDs are in one spot (so you can mix the colors with it), then
>> please make it a RGB multi-led like e.g. in sm8550-qrd.dts.
>>
> 
> I already asked for this and it was ignored:
> 
> https://lore.kernel.org/all/6aa67adb-a4d5-40da-a261-c90050ac04b2@linaro.org/
> 
> Let's engage three different community reviewers to repeat the same, one
> feedback. This is just disrespectful to our time.
Sorry, I ignored that comments, I will submit v4 to update it. Thanks 
for your comments.
> 
> Best regards,
> Krzysztof
> 

