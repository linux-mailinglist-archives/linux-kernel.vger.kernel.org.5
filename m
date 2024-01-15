Return-Path: <linux-kernel+bounces-25643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2D82D3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D3F1F215F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8BC257A;
	Mon, 15 Jan 2024 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UXiGJ3MQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232D5232;
	Mon, 15 Jan 2024 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40F51Zcw030647;
	Mon, 15 Jan 2024 05:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jwCpOnLiQ2u16hSnoHOT6ZwH9ZnGrxTstWp7KG66MIE=; b=UX
	iGJ3MQ44SQumtSkVs02ooeZK0DnVWs+FHXNjtZ+KftNJuWN1NtuxvqiVgPQV6Gew
	jzowHD1uIy8qVzG7FLOFWaEeE6l3wLahGLYlWHaGWsPctpccGfaQEwNz5OP2+7PZ
	l7BFEwAx1JRnZHrmw3QuYh4l6Pv1J2MOFw2TvPkCKhldndICtLv2warctgs6t8M1
	u3NZP569wyHAn3SDxRfDN5SmlYqUTkxEfkJTbi3n9/S7YQ1Smz7A9ou1NWaI6/Gr
	bjO2joreoJHygi6gxxNCmCe986K8qGcR3rW07fiybY3cf332ht1/XaLIxwh2CZ8s
	03AuHxMu0ukNeBR2LkPQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmkcjq6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 05:52:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40F5qwBc014207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 05:52:58 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 14 Jan
 2024 21:52:55 -0800
Message-ID: <8e51796a-49b6-4217-877b-e393d65ff398@quicinc.com>
Date: Mon, 15 Jan 2024 13:52:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: qcom: qcs6490-idp: Add definition for
 three LEDs.
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240112-lpg-v4-1-c4004026686b@quicinc.com>
 <CAA8EJppdjVRpzrdqm4VOZwUO+khjTdRbY6jN2E2VGmCKSd8inA@mail.gmail.com>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <CAA8EJppdjVRpzrdqm4VOZwUO+khjTdRbY6jN2E2VGmCKSd8inA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eqYLJJlo_dll1SZ_-UhIYuEqg_XSjCsM
X-Proofpoint-ORIG-GUID: eqYLJJlo_dll1SZ_-UhIYuEqg_XSjCsM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=707 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150042



On 1/12/2024 11:36 AM, Dmitry Baryshkov wrote:
> On Fri, 12 Jan 2024 at 05:07, Hui Liu via B4 Relay
> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Add definition for three LEDs to make sure they can
>> be enabled base on QCOM LPG LED driver.
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
>> Changes in v4:
>> - Removed "label" definition and added "function" definition.
> 
> You have removed "label", but you didn't add "function".
I added function node "function = LED_FUNCTION_STATUS;"
Don't you mean this function node? I didn't get your mean.
> 
> BTW: the commit subject is still wrong. Compare "qmp6490-idp" vs "qcs6490-idp"
OK, I will update it to qcm6490-idp.
> 
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

