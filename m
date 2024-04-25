Return-Path: <linux-kernel+bounces-157960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844EF8B1956
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF471F22FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E7C1DDF5;
	Thu, 25 Apr 2024 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XmdDvHNF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB22231C;
	Thu, 25 Apr 2024 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015054; cv=none; b=U2etjc/dLgI5uLS3A2eFVzSChlzpGEetPLEG6bTbC/aDsGqidwHxqBi3GkWFwuzOGph8ZxGsa2Ml9g6yL9OJSZOxrG1Kbt81tBAP2cESr2JO8bNvf9L/VWQX3Mv2EFC+qASJcH8v5iV1cJEoo5QyppKO+Is/otkxUvG+LgJOpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015054; c=relaxed/simple;
	bh=AO537cZ2Lsukt3eGqvguYisrw83+HAERh0Uhw6sZGMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u6ViUP01LoiFKpaJUVBAL1RZyJLA1kMCXaLV1rUDaWqLcrz85saUEOb4Cq7xNk+0tmEYKewDnjGi5h23UPw7d3PKDNOqjBdNmLTCc2IyQKhN1Ze+QVv6m1IT9EFrfFbjHHwgF0Ou+Nyu2++S6OJG02m4h0KjdHwVJxrSMkI2g48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XmdDvHNF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P2jSY9021922;
	Thu, 25 Apr 2024 03:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3QXohaXz49mNqLubAbiZtNkrF0Go0ow3pd2pYAISnRs=; b=Xm
	dDvHNFC+ydcXz5WAMF4On7OGLZOg3wxM7KG6wpoRmK3X7PYVthvu9eC1Rm3ciecF
	UzX6Ta3n60JXUCbygFV6tv6nvDip25WNF2VAX2n4Jw16U81umHr8MlLpgBSrwQmi
	n0F19anoE55beUe/q/+aR3z/IQbn6Jx0q4vW63z4doRObk0O+gKCkOVhv1STDjAQ
	wyM6LmzTSB0kHJla0OS0pKYqEjsW9hlvMvLYEfDxr03uoFD4wjHRJ/9FAOiBU1+g
	GUqR/V7MHJFwkrGALwx/o8z8FP1OdBddGWchWxh5OJyyKLKdIp71GDE4+ZzGzBwb
	FP34Zjf9LDvp7uw1TXwQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenp826g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:17:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P3HOb4017582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:17:24 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 20:17:22 -0700
Message-ID: <82372421-2d5f-4706-b7a1-30b098c739d6@quicinc.com>
Date: Thu, 25 Apr 2024 11:17:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm4450: Supply clock from cpufreq
 node to CPUs
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240424101503.635364-1-quic_tengfan@quicinc.com>
 <20240424101503.635364-4-quic_tengfan@quicinc.com>
 <CAA8EJpqiXqsNq0B6EHnqubPcUzwJ0bc0y3rJ4RfrRimKifPf0Q@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJpqiXqsNq0B6EHnqubPcUzwJ0bc0y3rJ4RfrRimKifPf0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VZqXlrQs8WY4X0bpqyaQ-D_cUlZUNXcO
X-Proofpoint-ORIG-GUID: VZqXlrQs8WY4X0bpqyaQ-D_cUlZUNXcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_02,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250023



On 4/24/2024 7:23 PM, Dmitry Baryshkov wrote:
> On Wed, 24 Apr 2024 at 13:17, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>> Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
>> clocks to the CPU cores. But this relationship is not represented in DTS
>> so far.
>>
>> So let's make cpufreq node as the clock provider and CPU nodes as the
>> consumers. The clock index for each CPU node is based on the frequency
>> domain index.
> 
> Is there any reason why this is not a part of the previous patch?

Before, I understood that clock and cpufreq support are two functions, 
so they were divided into two patches.

I will squash this patch in cpufreq support patch in the new version 
patch series.

> 
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> index 92badfd5b0e1..8d75c4f9731c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> @@ -47,6 +47,7 @@ CPU0: cpu@0 {
>>                          device_type = "cpu";
>>                          compatible = "arm,cortex-a55";
>>                          reg = <0x0 0x0>;
>> +                       clocks = <&cpufreq_hw 0>;
>>                          enable-method = "psci";
>>                          next-level-cache = <&L2_0>;
>>                          power-domains = <&CPU_PD0>;
>> @@ -72,6 +73,7 @@ CPU1: cpu@100 {
>>                          device_type = "cpu";
>>                          compatible = "arm,cortex-a55";
>>                          reg = <0x0 0x100>;
>> +                       clocks = <&cpufreq_hw 0>;
>>                          enable-method = "psci";
>>                          next-level-cache = <&L2_100>;
>>                          power-domains = <&CPU_PD0>;
>> @@ -91,6 +93,7 @@ CPU2: cpu@200 {
>>                          device_type = "cpu";
>>                          compatible = "arm,cortex-a55";
>>                          reg = <0x0 0x200>;
>> +                       clocks = <&cpufreq_hw 0>;
>>                          enable-method = "psci";
>>                          next-level-cache = <&L2_200>;
>>                          power-domains = <&CPU_PD0>;
>> @@ -110,6 +113,7 @@ CPU3: cpu@300 {
>>                          device_type = "cpu";
>>                          compatible = "arm,cortex-a55";
>>                          reg = <0x0 0x300>;
>> +                       clocks = <&cpufreq_hw 0>;
>>                          enable-method = "psci";
>>                          next-level-cache = <&L2_300>;
>>                          power-domains = <&CPU_PD0>;
>> @@ -129,6 +133,7 @@ CPU4: cpu@400 {
>>                          device_type = "cpu";
>>                          compatible = "arm,cortex-a55";
>>                          reg = <0x0 0x400>;
>> +                       clocks = <&cpufreq_hw 0>;
>>                          enable-method = "psci";
>>                          next-level-cache = <&L2_400>;
>>                          power-domains = <&CPU_PD0>;
>> @@ -148,6 +153,7 @@ CPU5: cpu@500 {
>>                          device_type = "cpu";
>>                          compatible = "arm,cortex-a55";
>>                          reg = <0x0 0x500>;
>> +                       clocks = <&cpufreq_hw 0>;
>>                          enable-method = "psci";
>>                          next-level-cache = <&L2_500>;
>>                          power-domains = <&CPU_PD0>;
>> @@ -167,6 +173,7 @@ CPU6: cpu@600 {
>>                          device_type = "cpu";
>>                          compatible = "arm,cortex-a78";
>>                          reg = <0x0 0x600>;
>> +                       clocks = <&cpufreq_hw 1>;
>>                          enable-method = "psci";
>>                          next-level-cache = <&L2_600>;
>>                          power-domains = <&CPU_PD0>;
>> @@ -186,6 +193,7 @@ CPU7: cpu@700 {
>>                          device_type = "cpu";
>>                          compatible = "arm,cortex-a78";
>>                          reg = <0x0 0x700>;
>> +                       clocks = <&cpufreq_hw 1>;
>>                          enable-method = "psci";
>>                          next-level-cache = <&L2_700>;
>>                          power-domains = <&CPU_PD0>;
>> --
>> 2.25.1
>>
>>
> 
> 

-- 
Thx and BRs,
Tengfei Fan

