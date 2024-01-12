Return-Path: <linux-kernel+bounces-24259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CB82B9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BEFA1C21F43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2F1846;
	Fri, 12 Jan 2024 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GSe8TjSo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4F15AF;
	Fri, 12 Jan 2024 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C2SILW003610;
	Fri, 12 Jan 2024 03:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8otuVEwjCSc+GiHaI9tF9+6ZOBSBIdeWeMKNJRMrSFc=; b=GS
	e8TjSopzV5pfSV8tqBYpdNEx19sc8zl469cY9bHVLDtKdbdD45QYD1yA7jphA+QV
	1eSFRs8wZDK9lOfx1GV49epq9sCBkGUSefPq16T1zvLizHKQHgAl5dL3ODOmm2Gv
	gramdmXz7Xu9jZ10wTrBxTxnfnhbF79rmEsZjJgOLaMx4cwZaQSORRuNt22K5NZg
	0mc2aFup3GW4lG777qjgIzxoCFeR1MJnNyJLQLE3hsSJWumu7D5vIzVPr1k8U4Se
	vl0VYO+oj/Tblki6STyVgEth68R8uG6GQ1x4c2TI3flW5sVp0JfKmC5BbAaqdk8l
	nkx+5K3UzzR/OmnuRxaw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcvjta6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 03:04:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C34bfC013592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 03:04:37 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 19:04:34 -0800
Message-ID: <bfccc90c-6f9f-4b30-a795-96d764e56606@quicinc.com>
Date: Fri, 12 Jan 2024 11:04:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] arm64: dts: qcom: qcs6490-idp: Add definition
 for three LEDs.
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240111-lpg-v3-1-811c9e82dae4@quicinc.com>
 <CAA8EJpq-hYrM-JzJ5-0iSfH3gYYJawsDWDj51N1H7_fCJQvaCA@mail.gmail.com>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <CAA8EJpq-hYrM-JzJ5-0iSfH3gYYJawsDWDj51N1H7_fCJQvaCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y3UGGaVuFbG_pVgwDoeNrzWDSFYhflk9
X-Proofpoint-ORIG-GUID: Y3UGGaVuFbG_pVgwDoeNrzWDSFYhflk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=823 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401120021



On 1/11/2024 11:38 AM, Dmitry Baryshkov wrote:
> On Thu, 11 Jan 2024 at 04:54, Hui Liu via B4 Relay
> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Add definition for three LEDs to make sure they can
>> be enabled base on QCOM LPG LED driver.
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
>> Changes in v3:
>> - Rephrased commit text and updated the nodes to qcm6490-idp board file.
> 
> The commit message is the same as in v2.
> 
> Commit subject mentions non-existing board, "qcs6490-idp"
This devicetree file of this board has been merged in linux-next,
https://lore.kernel.org/linux-arm-msm/170157925812.1717511.10611634209504625070.b4-ty@kernel.org/
> 
>> - Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com/
>>
>> Changes in v2:
>> - Rephrased commit text and updated the nodes to board file.
>> - Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
>> ---
>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> index 37c91fdf3ab9..f801144a1556 100644
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
>> @@ -414,6 +415,30 @@ vreg_bob_3p296: bob {
>>          };
>>   };
>>
>> +&pm8350c_pwm {
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       status = "okay";
>> +
>> +       led@1 {
>> +               reg = <1>;
>> +               color = <LED_COLOR_ID_RED>;
>> +               label = "red";
> 
> Is there any reason why Krzysztof's review for v2 was ignored? Let me
> repeat it here: "Drop labels. You already have color, so you miss
> function."
> 
> 
>> +       };
>> +
>> +       led@2 {
>> +               reg = <2>;
>> +               color = <LED_COLOR_ID_GREEN>;
>> +               label = "green";
>> +       };
>> +
>> +       led@3 {
>> +               reg = <3>;
>> +               color = <LED_COLOR_ID_BLUE>;
>> +               label = "blue";
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

