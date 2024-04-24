Return-Path: <linux-kernel+bounces-156520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6208B03CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC551C23494
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EBE15884D;
	Wed, 24 Apr 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X6H4A+iz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284E1EF1A;
	Wed, 24 Apr 2024 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945755; cv=none; b=tRjQGiacZq//j6nWd/6/KV6EIOSkKxvy02pXMZJV4MAlK5QtGnwF66TlNuCB5EB8kEVGPN8RQ3TcKlGRHhFUAJE2pxlRlUH6HOuSI0MHpP7oEjJ7t/JPQOaVWkG9ePKKGa4lzDRgnbCp2x3+C++Qt7yCG4l1zoPYQwFJqzXQ1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945755; c=relaxed/simple;
	bh=PLuiIItih2q98cMHNdO9+pRyWIVtVPMk4w0qTfXTBjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WjkDYefA0am1RorCWcPylnRoC4mOaafvI3dbDVHMUwV9r1Zlx1fzD1zjIo15Oy8VHqF6V3m4Xaq9CyOgdgcotVjJpHhv2yg3cO313BX8A4XWRfY2MHLKLTySxI9oDGW7R4dN++w+LC7OsNannSU5r6fE3mR15XoCtPbpNhTamVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X6H4A+iz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6X87I014952;
	Wed, 24 Apr 2024 08:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/ZTsXSeLStGaaspxew24zd5tpWbGzfrVHxcwSdmdCOU=; b=X6
	H4A+izNhgwQ29gC7MRegHNj0Mcs3wHa3bVxtlawjMSfoEPPL/7omGT/Tv+Ku3buE
	URX+JQ7m4hGEZFeecORKxijzUfWQc5adp3RQVNWxUw0QSSOTzCm6l6TF7FziCJGU
	Jvy/SYLKApmTGheofFIEMeHiAE04yOTYGZyveN6LYNac4w5mkLBn4Z7idbv/hzw3
	Ox8lVlBFkYYitxxD13fqV+YhAJYlGFF2EI/Yk8YUUoCBZFktWOxLLOWNQZ1YFUvv
	bbJOi4zehaVEdi7HAr3KFMnKddLsLGaOG+JkJFpU5js17f3QDBTe0DsZgFfXn0dV
	0cR15VhyHh48Bvh4r97w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9g884f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 08:01:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O81oFY001068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 08:01:50 GMT
Received: from [10.216.52.243] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 01:01:45 -0700
Message-ID: <3c4fa69c-8ee3-43c9-b328-3efd9c948230@quicinc.com>
Date: Wed, 24 Apr 2024 13:31:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Remove CTS/RTS configuration
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: <cros-qcom-dts-watchers@chromium.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <swboyd@chromium.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rajpat@codeaurora.org>,
        <mka@chromium.org>, <rojay@codeaurora.org>,
        <quic_msavaliy@quicinc.com>, <quic_anupkulk@quicinc.com>
References: <20240416105650.2626-1-quic_vdadhani@quicinc.com>
 <Zh9Sd4QVsN9TWomO@hu-bjorande-lv.qualcomm.com>
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <Zh9Sd4QVsN9TWomO@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WArcAWvHv0L1dX0XOv8rqdvDwO1gulDx
X-Proofpoint-GUID: WArcAWvHv0L1dX0XOv8rqdvDwO1gulDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_05,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240034



On 4/17/2024 10:09 AM, Bjorn Andersson wrote:
> On Tue, Apr 16, 2024 at 04:26:50PM +0530, Viken Dadhaniya wrote:
>> Remove CTS and RTS pinctrl configuration for UART5 node as
>> it's designed for debug UART for all the board variants of the
>> sc7280 chipset.
>>
>> Also change compatible string to debug UART.
>>
> 
> Why are you posting this on the public mailing list without first
> addressing the feedback and questions I gave you on the internal review
> list?
> 
> Now you wasted the time of our community members, just to receive the
> same feedback I gave you last week.
> 
> Regards,
> Bjorn
> 

Sorry, I missed you feedback due to incorrect mail filler.

>> Fixes: 38cd93f413fd ("arm64: dts: qcom: sc7280: Update QUPv3 UART5 DT node")
>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 38c183b2bb26..2a6b4c4639d1 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -1440,12 +1440,12 @@
>>   			};
>>   
>>   			uart5: serial@994000 {
>> -				compatible = "qcom,geni-uart";
>> +				compatible = "qcom,geni-debug-uart";
>>   				reg = <0 0x00994000 0 0x4000>;
>>   				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
>>   				clock-names = "se";
>>   				pinctrl-names = "default";
>> -				pinctrl-0 = <&qup_uart5_cts>, <&qup_uart5_rts>, <&qup_uart5_tx>, <&qup_uart5_rx>;
>> +				pinctrl-0 = <&qup_uart5_tx>, <&qup_uart5_rx>;
>>   				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>>   				power-domains = <&rpmhpd SC7280_CX>;
>>   				operating-points-v2 = <&qup_opp_table>;
>> @@ -5397,16 +5397,6 @@
>>   				function = "qup04";
>>   			};
>>   
>> -			qup_uart5_cts: qup-uart5-cts-state {
>> -				pins = "gpio20";
>> -				function = "qup05";
>> -			};
>> -
>> -			qup_uart5_rts: qup-uart5-rts-state {
>> -				pins = "gpio21";
>> -				function = "qup05";
>> -			};
>> -
>>   			qup_uart5_tx: qup-uart5-tx-state {
>>   				pins = "gpio22";
>>   				function = "qup05";
>> -- 
>> 2.17.1
>>

