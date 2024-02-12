Return-Path: <linux-kernel+bounces-61259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF4850FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06FD1F239E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F5C17BB7;
	Mon, 12 Feb 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZbIdRbB3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836A79FD;
	Mon, 12 Feb 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731257; cv=none; b=cyUOW0hFRshtBWDmtewfA9y5h8m+D2HMHnkCZnc89j+ziNcS5VakcHdDWelhkl4qhxGy5okxm6ofs4BH51m6G8ZfUGa/SYvbxG9qFwKROFjYk/kIDxJMC/mNdDEhoq+Xm4z1WFl/t4Kiuf2DnSj27JzuynKgK+Wf/0TFnyOQSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731257; c=relaxed/simple;
	bh=T07jFuDWwQSFTWtgFD7tQZldLom+Reu5SVY4LzAOFVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M+oSDwyqli1y9oQn+WhoJ25nuxMjCSqDag8jZFJAD3/hzp+3kwXGPud+i6QwoPQz0Q8pWh9jszgmWl53Xn4X0/3ORquUaV/2ctbqMo0qzgmAiRDH6tslQWr0zmB53K34eBUfLAFR86dRzN8OVwfsHLOh6OuVmfLkQshjHDeJcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZbIdRbB3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C8ZD7B007061;
	Mon, 12 Feb 2024 09:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J+7SKv+KgDjifMQXwtNiG9w7gSbJwI2AMpdlLFDIN+E=; b=Zb
	IdRbB3g03oCeqZBjrSkuRliPDph9L+PCwO4xyVEpBUiQ0xRonhcmK9qHOjqgUc9I
	MpjFF+kvOOy52fO1cSD4DkLcr2pjb8Zj7ocF/x3y2laeDpsMYU6HjVMqPsk6op3S
	gpRtO973+GHSXK0eVsXvuAvRhLShkMgdfp9NGAvPdZdtoqvmupzJs4k/2vf6VcRC
	IOsVEGbr7QQA2lgkTzW32wVAMGE0KdpYOXw1qEbuaYRcdzofqxunmehrj/JQzwVB
	3ccvs/z0QuQ1bbVWAjYmgF4XkP/+LhnIrQEk4bHTZz8Uo24i0ljJqLXfPrE1hjM1
	rtJtykaVbEo00zxcsPZw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62ps2wp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:47:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C9lRRd001122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:47:27 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 01:47:22 -0800
Message-ID: <58cdf104-acda-6215-cbaa-188c304da9f3@quicinc.com>
Date: Mon, 12 Feb 2024 15:17:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 7/7] arm64: dts: qcom: x1e80100: Enable LLCC/DDR dvfs
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-8-quic_sibis@quicinc.com>
 <CAA8EJpo5F==whKMVFgPAM+=DpB+=KzPhKt-poGXuHxy-KSxe8Q@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAA8EJpo5F==whKMVFgPAM+=DpB+=KzPhKt-poGXuHxy-KSxe8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RUtiWEuVGOGZlx9UZZ3-skcSgvMcFCtD
X-Proofpoint-GUID: RUtiWEuVGOGZlx9UZZ3-skcSgvMcFCtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_06,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=690
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120072



On 1/18/24 02:17, Dmitry Baryshkov wrote:
> On Wed, 17 Jan 2024 at 19:37, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> Enable LLCC/DDR dvfs through the Qualcomm's SCMI vendor protocol.
> 
> Could you please post DT bindings?

ack, will include it in the next re-spin.

> 
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 48 ++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 6856a206f7fc..3dc6f32fbb4c 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -329,6 +329,54 @@ scmi_dvfs: protocol@13 {
>>                                  reg = <0x13>;
>>                                  #clock-cells = <1>;
>>                          };
>> +
>> +                       scmi_vendor: protocol@80 {
>> +                               reg = <0x80>;
>> +
>> +                               memlat {
> 
> This doesn't look like a generic node name.
> 
>> +                                       #address-cells = <1>;
>> +                                       #size-cells = <0>;
> 
>> +
>> +                                       memory@0 {
>> +                                               reg = <0x0>; /* Memory Type DDR */
>> +                                               freq-table-khz = <200000 4224000>;
>> +
>> +                                               monitor-0 {
>> +                                                       qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
> 
> 
> 
>> +                                                       qcom,cpufreq-memfreq-tbl = < 999000 547000 >,
>> +                                                                                  < 1440000 768000 >,
>> +                                                                                  < 1671000 1555000 >,
>> +                                                                                  < 2189000 2092000 >,
>> +                                                                                  < 2156000 3187000 >,
>> +                                                                                  < 3860000 4224000 >;
> 
> These tables should be rewritten as OPP tables. >
> 
>> +                                               };
>> +
>> +                                               monitor-1 {
>> +                                                       qcom,compute-mon;
>> +                                                       qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
>> +                                                       qcom,cpufreq-memfreq-tbl = < 1440000 200000 >,
>> +                                                                                  < 2189000 768000 >,
>> +                                                                                  < 2156000 1555000 >,
>> +                                                                                  < 3860000 2092000 >;
>> +                                               };
>> +                                       };
>> +
>> +                                       memory@1 {
>> +                                               reg = <0x1>; /* Memory Type LLCC */
>> +                                               freq-table-khz = <300000 1067000>;
>> +
>> +                                               monitor-0 {
>> +                                                       qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
>> +                                                       qcom,cpufreq-memfreq-tbl = < 999000 300000 >,
>> +                                                                                  < 1440000 466000 >,
>> +                                                                                  < 1671000 600000 >,
>> +                                                                                  < 2189000 806000 >,
>> +                                                                                  < 2156000 933000 >,
>> +                                                                                  < 3860000 1066000 >;
>> +                                               };
>> +                                       };
>> +                               };
>> +                       };
>>                  };
>>          };
>>
>> --
>> 2.34.1
>>
>>
> 
> 
> --
> With best wishes
> Dmitry

