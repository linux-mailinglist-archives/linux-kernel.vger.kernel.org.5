Return-Path: <linux-kernel+bounces-21082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C382897A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601DD1F2576E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42173A8CC;
	Tue,  9 Jan 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MoUyfniE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238E3A8C0;
	Tue,  9 Jan 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409D9rjh019968;
	Tue, 9 Jan 2024 15:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RREJkIe8cnOR7GAB9rHBcmsq2eRW8v6ksqyBes3HyDo=; b=Mo
	UyfniEBPohj6dKvVtxtGYWjrOOT+RSOnJdbL2vbi50wmYJ/yT06YzqqDymGfw8k0
	sm/1BRslvSMa5DYbYsgVUkAHb82DtPnmjFsvESZXdOTW5E3CkOP+F6RP8HF1hGxe
	DiPaFnbh2ceg1y0gD2DTrBcksesr7edEy5Qo9QA0IUTRFsrGHah5gUBLBTGCxCWJ
	Dck5fiplOZSn3NDcA5OKinMQOwAUzuvUkKbxrkDFeBwpO9CrDUSPzHCX1FQmPJCz
	Tm3LYrdW6FY3WwnoMrCCNRmfhevlhLJqsnbpKT1ueVKKEnOW/AR3kzLWmyxexY2e
	SSOZkZXDeXqMPaxjJyHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwsjsckx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 15:52:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409FqvfF002774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 15:52:57 GMT
Received: from [10.216.60.40] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 07:52:53 -0800
Message-ID: <960ea567-eed5-4908-a3ad-82add0c6f26c@quicinc.com>
Date: Tue, 9 Jan 2024 21:22:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490: Update PSCI suspend param for
 cluster sleep
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <luca.weiss@fairphone.com>, <cros-qcom-dts-watchers@chromium.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_lsrao@quicinc.com>
References: <20240105070223.11415-1-quic_mkshah@quicinc.com>
 <9e79a460-9a1d-493c-a430-63c416e3d992@linaro.org>
Content-Language: en-US
In-Reply-To: <9e79a460-9a1d-493c-a430-63c416e3d992@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AiWVUXmCwn6Z0UL_-XDQG_jRTuqZ9VpG
X-Proofpoint-ORIG-GUID: AiWVUXmCwn6Z0UL_-XDQG_jRTuqZ9VpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=918
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090129

On 1/5/2024 3:35 PM, Konrad Dybcio wrote:
> On 5.01.2024 08:02, Maulik Shah wrote:
>> QCM6490 uses Trustzone as firmware whereas SC7280 uses arm trusted
>> firmware. The PSCI suspend param is different in Trustzone for cluster
>> sleep. Update the same for qcm6490 based idp and fairphone fp5 boards.
>>
>> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
>> ---
> 
> Nice spot!
> 
> For things that are chrome-specific, I'd prefer them to be moved to
> -chrome.dtsi and then the "normal" (LA+LE+WP+friends) values to
> stay as default.

Thanks for the review.
Moved the chrome specific changes to sc7280-chrome-common.dtsi in v2.

> 
>>   arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 4 ++++
>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts           | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> index 176898c9dbbd..b56f6f26d96f 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> @@ -446,6 +446,10 @@
>>   	};
>>   };
>>   
>> +&CLUSTER_SLEEP_0 {
>> +	arm,psci-suspend-param = <0x4100b344>;
>>
> 
> I think the residency times should also be updated here.
> 
> Moreover, I'm seeing additional sleep states here (APSS PC, CX RET
> and this one being AOSS SLEEP), with values 0x4<<4, 0x134<<4,
> 0xb34<<4 (the one you added here) respectively.
> 
> Could you please add them as well, similar to [1]?
> 
> Konrad
> 
> [1] https://lore.kernel.org/linux-arm-msm/20230619-topic-sc8280xp-idle-v2-1-cde50bf02f3c@linaro.org/

Sure, added additional sleep stats with updated residency time in v2.

Thanks,
Maulik

