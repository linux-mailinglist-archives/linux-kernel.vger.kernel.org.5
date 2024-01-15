Return-Path: <linux-kernel+bounces-25871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 381F782D711
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF141B213B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710B81E86C;
	Mon, 15 Jan 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PcNn570d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37415F9C2;
	Mon, 15 Jan 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40F8CFDM028424;
	Mon, 15 Jan 2024 10:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BcTltSVcdGatbrBUU6zTKBg6pJMPZtwaqVsNWEXHsVQ=; b=Pc
	Nn570deNxiOAGf4LVoqq41hLF22XRiVYM8WdW3IoFDjc5S7rL7nvUPO4OARRMQFl
	wEd0lvNGOekV2z+J9QHr2jDKv27dmNh7x+XnX/2XxFX9y6pSbnLX73OTBU3HrFr7
	jcA4MP7VY8G3PlJKIfUAv3GxVDGYHL3ZBAiuO9VZ2mPa7VOE8FTnYTpRe4njPvKM
	sijepxsMqkUjZC4HM2dB1izcxBq0OEdO5TuIDPgsaPAWPmRk9bN+1cB9y8EqJmR7
	ZV3gzy4u8OEoXlgQPCpeYf+l6ywBc5FMCG9QnK7iyWHv7zFLLDARAIreLlQutG7d
	IhSeAcwDF23yTYJLZSAQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmefu5uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 10:18:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40FAIB3n019860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 10:18:11 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 02:18:08 -0800
Message-ID: <e16f5ff1-9b12-4f90-89d5-f95cbfb859e7@quicinc.com>
Date: Mon, 15 Jan 2024 18:18:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: qcom: qcm6490-idp: Add definition for
 three LEDs
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240115-lpg-v5-1-3c56f77f9cec@quicinc.com>
 <CAA8EJpoemnXTmshWrArVOCm0GRSkWZ5tH557nbAjRL1Tgg-Dig@mail.gmail.com>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <CAA8EJpoemnXTmshWrArVOCm0GRSkWZ5tH557nbAjRL1Tgg-Dig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U7i25dWANcFUdMluCwtOkccBACL9wKdR
X-Proofpoint-ORIG-GUID: U7i25dWANcFUdMluCwtOkccBACL9wKdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxlogscore=815 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150074



On 1/15/2024 5:56 PM, Dmitry Baryshkov wrote:
> On Mon, 15 Jan 2024 at 11:48, Hui Liu via B4 Relay
> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Add definition for three LEDs to make sure they can
>> be enabled base on QCOM LPG LED driver.
> 
> The "function" property is still placed incorrectly. Posting the next
> iteration before concluding the discussion on the previous one is not
> the best idea.
Do you mean I should update it as below? Seems there is no consumer to 
use the function config, do we need to add now?
pm8350c_pwm {
  +       function = LED_FUNCTION_STATUS;
  +       #address-cells = <1>;
  +       #size-cells = <0>;
  +       status = "okay";
  +
  +       led@1 {
  +               reg = <1>;
  +               color = <LED_COLOR_ID_RED>;
  +		 function = LED_FUNCTION_STATUS;
  +       };
  + ...

> 
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
>> Changes in v5:
>> - Rephrased commit text, replaced qcs6490-idp to qcm6490-idp.
>> - Removed the unnecessary full.
>> - Link to v4: https://lore.kernel.org/r/20240112-lpg-v4-1-c4004026686b@quicinc.com
>>
>> Changes in v4:
>> - Removed "label" definition and added "function" definition.
>> - Link to v3: https://lore.kernel.org/r/20231215-lpg-v3-1-4e2db0c6df5f@quicinc.com
>>
>> Changes in v3:
>> - Rephrased commit text and updated the nodes to qcm6490-idp board file.
>> - Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com/
>>
>> Changes in v2:
>> - Rephrased commit text and updated the nodes to board file.
>> - Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
>> ---
>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> index 37c91fdf3ab9..8268fad505e7 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> @@ -5,6 +5,7 @@
>>
>>   /dts-v1/;
>>
>> +#include <dt-bindings/leds/common.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include "sc7280.dtsi"
>>   #include "pm7325.dtsi"
>> @@ -414,6 +415,28 @@ vreg_bob_3p296: bob {
>>          };
>>   };
>>
>> +&pm8350c_pwm {
>> +       function = LED_FUNCTION_STATUS;
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       status = "okay";
>> +
>> +       led@1 {
>> +               reg = <1>;
>> +               color = <LED_COLOR_ID_RED>;
>> +       };
>> +
>> +       led@2 {
>> +               reg = <2>;
>> +               color = <LED_COLOR_ID_GREEN>;
>> +       };
>> +
>> +       led@3 {
>> +               reg = <3>;
>> +               color = <LED_COLOR_ID_BLUE>;
>> +       };
>> +};
>> +
>>   &qupv3_id_0 {
>>          status = "okay";
>>   };
>>
>> ---
>> base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
>> change-id: 20231215-lpg-4aadd374811a
>>
>> Best regards,
>> --
>> Hui Liu <quic_huliu@quicinc.com>
>>
>>
> 
> 

