Return-Path: <linux-kernel+bounces-16494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC0823F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A158E1F25210
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA120B1F;
	Thu,  4 Jan 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d+2dV+LL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FC210E7;
	Thu,  4 Jan 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4045c2b3002185;
	Thu, 4 Jan 2024 10:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KwMij2SG2PvQhi8h7xHrNorkASMycb45hj8OGRx8f0Q=; b=d+
	2dV+LLfapkEOh6/uM4goiFijaeB/awEXX5FrrBpyj9RI3xSCWEkJqX8Xa3ATIIGM
	vJKkyVuZ6DABpsD1cNWh0J1+1CAhVfYkiCjTOeitladNakBSI1/Ny4MHbtAcF35R
	yc3vVFN9p1ANTegIsGq0r89IZJQi0zmraSycVndoivKeMujaV6oWIwswe1P1beZc
	8a6FbTkvOABmcNFeFcDYjOAqIDFWesa+TegxSEZJkLXJLz8+8n8XhUlffK4Tr3vl
	O/3a24ZZA97mG+T4oS/01mUl6dqFeVGJak7yLlCSU0VHsW1JwgWPC+FXi5d12zyW
	q1MLVSCwUoMdylNegnaw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vdchnhxhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 10:14:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404AE15a031170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 10:14:01 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 02:13:55 -0800
Message-ID: <724f608a-cbfe-48f6-a1f7-59b961a7d724@quicinc.com>
Date: Thu, 4 Jan 2024 18:13:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, <quic_tdas@quicinc.com>,
        <quic_aiquny@quicinc.com>
CC: <kernel@quicinc.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
 <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: baXiAJOpXXOGjiqjqKgU4U7boWzG372q
X-Proofpoint-GUID: baXiAJOpXXOGjiqjqKgU4U7boWzG372q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401040075



On 1/4/2024 5:53 PM, Dmitry Baryshkov wrote:
> On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>>
>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>
>> Property '#power-domain-cells' is required as per defined in qcom,gcc.yaml
>> so add it for ipq6018 gcc device node to eliminate following warning in
>> dtbs_check:
>>
>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
>>          '#power-domain-cells' is a required property
>> from schema $id: http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#
> 
> But ipq6018 doesn't implement GDSC support. So for the sake of fixing
> the warning you are adding a bogus property.
> 
I agree. However, there are also some gcc drivers not implementing GDSC 
support but the bindings are adding '#power-domain-cells' in the DT 
example, such as: qcom,gcc-apq8064.yaml, qcom,gcc-ipq4019.yaml, 
qcom,gcc-ipq6018.yaml, qcom,gcc-ipq8064.yaml, qcom,gcc-msm8660.yaml.

Actually I thought that maybe we should do a clean up by removing 
'#power-domain-cells' out of the qcom,gcc.yaml binding and only adding 
it into individual qcom,gcc-xxx.yaml for the driver which has 
implemented GDSC support. I checked this with Taniya offline, but she 
prefers only fixing it in ipq6018.dtsi as it doesn't hurt anything by 
adding the property, and she expects the GDSC support should be existing 
in most of qcom,gcc drivers especially the newer Qcom chipsets.


>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index 39cd6b76b4c1..54914912d610 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -386,6 +386,7 @@ gcc: gcc@1800000 {
>>                          reg = <0x0 0x01800000 0x0 0x80000>;
>>                          clocks = <&xo>, <&sleep_clk>;
>>                          clock-names = "xo", "sleep_clk";
>> +                       #power-domain-cells = <1>;
>>                          #clock-cells = <1>;
>>                          #reset-cells = <1>;
>>                  };
>>
>> ---
>> base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
>> change-id: 20240103-gcc-docs-update-fa604579e468
>>
>> Best regards,
>> --
>> Fenglin Wu <quic_fenglinw@quicinc.com>
>>
>>
> 
> 

