Return-Path: <linux-kernel+bounces-40169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917183DB91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EF128400D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718121C2A5;
	Fri, 26 Jan 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X6jWZwJf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA11C287;
	Fri, 26 Jan 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278476; cv=none; b=jMccUmijEAACM3sHVoEbHJhrEBO93f54PaXwqlvvIDqJWhfy4beTyFUx5N50ftmZeOIEoEt1SigQoHICru6CGujXMqtrB4Y76+siqEgOZEvXadcRhPN/Xfj3ouQfEFSDnF7RpeUzsyxAw0aoOwqmL74Y2IyK2NSxyQQzUcu1yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278476; c=relaxed/simple;
	bh=ftLuAd9U3YPVeEzec70Y/JSfQC6jcmT5YJPmcGrNDAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PdhEFnRYqa8PVYokJEoB5hAyZ33cq0YhqDJjP9zKlKg/toFKYf5qoUumQx+2geeDySeSojbl/h0ZzolA7rXUez1t4DdQtAB381dw80NFJu+lWxYgSR3MqjP/1PmEUysexEzTFParc9k2VJKkuxLwZyr25XI/v4eSFEzT8cRoazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X6jWZwJf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QCQ7rC005300;
	Fri, 26 Jan 2024 14:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+SpPdyF3w8Fw1tNKmk5zm/UXCiCDAnEu7aqBtZrqwjQ=; b=X6
	jWZwJfqWJPYU5LXTLKDWkbD+7zYLaFPX1QRZo5/CLcwK3CRrlN6650Q/XVQ1GZIT
	rJKow7yXKXeFpImvwVqa+WGTCuXO/v//TwQsP9mWIXNyzfyA5EiSBa7fi63rZSff
	hjBandhIkhAS3GSqEcEYRNIsqckzmLvmn99PnAXclcyKi251cXpOE6xFxwzNwCXt
	ROJxMfjSameupDRSdQL8tHbFVGzn0OPfx74gOJDTKwFWZakN4wShkmjzXVZ1ZwzY
	592H4qbSoDvQY44XPPohaFkQrmKKg7EvzZmdEt400LpgslAaBiWaf243yEH1AM6F
	TCHAKVOm1g89Tji5YSig==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4f9h8yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:14:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QEENYu021168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:14:23 GMT
Received: from [10.216.50.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 06:14:19 -0800
Message-ID: <a4606673-64e9-4e16-8d9e-307fb37d8763@quicinc.com>
Date: Fri, 26 Jan 2024 19:44:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
To: Bjorn Andersson <andersson@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240120191904.15408-1-quic_kriskura@quicinc.com>
 <20240120191904.15408-2-quic_kriskura@quicinc.com>
 <wqdqkzvni4roqulgsiqxzubxcblzxnoydcwvv2av2pobjjx5o6@b7kwl6lq7hij>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <wqdqkzvni4roqulgsiqxzubxcblzxnoydcwvv2av2pobjjx5o6@b7kwl6lq7hij>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6bLippXMlQBWho7Sf-qbyUXJAPAqgD9h
X-Proofpoint-GUID: 6bLippXMlQBWho7Sf-qbyUXJAPAqgD9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260104



On 1/25/2024 3:16 AM, Bjorn Andersson wrote:
> On Sun, Jan 21, 2024 at 12:49:01AM +0530, Krishna Kurapati wrote:
>> On several QUSB2 Targets, the hs_phy_irq mentioned is actually
>> qusb2_phy interrupt specific to QUSB2 PHY's. Rename hs_phy_irq
>> to qusb2_phy for such targets.
>>
>> In actuality, the hs_phy_irq is also present in these targets, but
>> kept in for debug purposes in hw test environments. This is not
>> triggered by default and its functionality is mutually exclusive
>> to that of qusb2_phy interrupt.
>>
>> Add missing hs_phy_irq's, pwr_event irq's for QUSB2 PHY targets.
>> Add missing ss_phy_irq on some targets which allows for remote
>> wakeup to work on a Super Speed link.
>>
>> Also modify order of interrupts in accordance to bindings update.
>> Since driver looks up for interrupts by name and not by index, it
>> is safe to modify order of these interrupts in the DT.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 13 +++++++++++++
>>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 14 ++++++++++++++
>>   arch/arm64/boot/dts/qcom/msm8953.dtsi |  7 +++++--
>>   arch/arm64/boot/dts/qcom/msm8996.dtsi |  8 ++++++--
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi |  7 +++++--
>>   arch/arm64/boot/dts/qcom/sdm630.dtsi  | 17 +++++++++++++----
>>   arch/arm64/boot/dts/qcom/sm6115.dtsi  |  9 +++++++--
>>   arch/arm64/boot/dts/qcom/sm6125.dtsi  |  9 +++++++--
>>   8 files changed, 70 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index 5e1277fea725..ea70b57d1871 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -418,6 +418,12 @@ usb2: usb@70f8800 {
>>   					  <&gcc GCC_USB1_MOCK_UTMI_CLK>;
>>   			assigned-clock-rates = <133330000>,
>>   					       <24000000>;
>> +
>> +			interrupts-extended = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> 
> interrupts-extended takes a reference to a interrupt-controller as well,
> so this doesn't build.
> 
> Did you mean "interrupts" here instead? Please update these and build
> test...
> 

Hi Bjorn,

  Thanks for the catch. I was using DTC version 1.4.0.
When I moved to 1.5.0, I did see these warnings. Fixed them up and sent v3.

Thanks,
Krishna,

