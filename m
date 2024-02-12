Return-Path: <linux-kernel+bounces-61282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D985104F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF37928244E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6918041;
	Mon, 12 Feb 2024 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ivvO55xk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD4182BE;
	Mon, 12 Feb 2024 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732357; cv=none; b=keGuvbO0aImDR/eu7htXKXnsk7NOIvq4l9bvDD8ChogyTWvIaqu1hWSe1mom7SBw07LhghyJMIy4869nEeNf1cc64Yg7PHkbrnWsMpsNeyadukD/otkYYJRZ5yCWXqeJhw7N4YBdctZ4VvEi+V9GsHP60jhriu2RIk4/rIcST6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732357; c=relaxed/simple;
	bh=VlobJCbEhktN2sWIOp5CzBCzz7nlGt2v0Z1QQfCgaXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LKNnbCERsW9xbeQqVNwytwtbRGUofsiIYmtHY7Dt9V20ojIGC3YvaOaD/2KIJsjQBEe/rzAT6/dvzLKrXcj6Szr8GbutL6ytl+8LClsI/9Pw3SbTZVyhhMklCwfmWygXUqDCqEMfQ976AgK/5zJ39sZp2cW/AQlt5THT0+Zx0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ivvO55xk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C8kaVt005198;
	Mon, 12 Feb 2024 10:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MVR0zcAnL8Cu0YgirqoUDIbWMji9NuHXihmmIiCsX2E=; b=iv
	vO55xkIbAELQf5Z6Pt6eIdVOeQDXQNABKzJkY/pOMJG7unR+3lfCTkazSbyPdM4R
	ko0ets+fH3qUPhKnXh97swijpOxjp3bcS6b9m48z71uUU2UaNb27xz76hd/vO590
	IrRgTzYvN2hYZ44P+YL/QBSAkpEfcx5xAnoIv3xdQKFvuJhW/gM4ST2SfaVX3hNI
	6L1QF+l08OiOOW3Hx5RxuE3xdnSPYXyJmAY3ap6+jxARBeIIj2IRU2u2vorka/X9
	hMdROctDQQgBOvx9jWfavNizjTzS3KhgNDc7vdwNGjXbZQZX3lAuTR0TJSuLBs51
	RmbfySGVt4Vsd9Onz+9g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62n02ygs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:05:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CA5m17030490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:05:48 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 02:05:36 -0800
Message-ID: <a7cc457b-dd84-cce2-84d7-4b6ab69a72d0@quicinc.com>
Date: Mon, 12 Feb 2024 15:35:33 +0530
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
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-8-quic_sibis@quicinc.com>
 <2cbdbe92-ce36-4147-a64f-7f86ee3761bc@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <2cbdbe92-ce36-4147-a64f-7f86ee3761bc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TmXItcpkCulrQGcJDYmSHrheLyWXcWBA
X-Proofpoint-ORIG-GUID: TmXItcpkCulrQGcJDYmSHrheLyWXcWBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 mlxlogscore=736 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120076



On 1/18/24 02:08, Konrad Dybcio wrote:
> 
> 
> On 1/17/24 18:34, Sibi Sankar wrote:
>> Enable LLCC/DDR dvfs through the Qualcomm's SCMI vendor protocol.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 48 ++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi 
>> b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 6856a206f7fc..3dc6f32fbb4c 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -329,6 +329,54 @@ scmi_dvfs: protocol@13 {
>>                   reg = <0x13>;
>>                   #clock-cells = <1>;
>>               };
>> +
>> +            scmi_vendor: protocol@80 {
>> +                reg = <0x80>;
>> +
>> +                memlat {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    memory@0 {
>> +                        reg = <0x0>; /* Memory Type DDR */
> 
> I'm not sure reg is the best property to (ab)use..

I'm ok with introducing a custom property as well. I went
ahead with reg mainly because the overall structure looked
similar to audio apr.

> 
> You could very well define a new one, like qcom,memory type,
> then the subnodes could look like:
> 
> memory-0 {
>      qcom,memory-type = <QCOM_MEM_TYPE_DDR>;
>      [...]
> };
> 
>> +                        freq-table-khz = <200000 4224000>;
>> +
>> +                        monitor-0 {
>> +                            qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 
>> &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
> 
> I fail to see the usefulness in checking which CPUs make use of
> the same DRAM or LLC pool. If that's something that may not be
> obvious in future designs like on dual-socket x86 servers,
> I think it can be deferred until then and for now, AFAIU you
> can just unconditionally assume all CPUs count.

we list all the cpus here because on X1E they are identical
and have the same cpu frequency to memory frequency mapping.
But doesn't really apply to other SoCs in general. But dropping
this would mean that driver assumes a table applies to all
cpus by default.

> 
>> +                            qcom,cpufreq-memfreq-tbl = < 999000 
>> 547000 >,
>> +                                           < 1440000 768000 >,
>> +                                           < 1671000 1555000 >,
>> +                                           < 2189000 2092000 >,
>> +                                           < 2156000 3187000 >,
>> +                                           < 3860000 4224000 >;
> 
> I.. can't seem to think of a future where this doesn't explode.

Not really ... You can already see a more or less standard table
being used across various skus on older SoCs that uses memlat
running from the kernel downstream. So that should count for
something.

> 
> When you release a different bin/SKU/fuse config of this SoC where
> the CPU frequencies are different, this will likely also need to be
> updated. We don't want that manual cruft in the devicetree.

Also unlike cpufreq map, if you notice this table doesn't list all
possible cpu frequencies but list broad ranges instead. This way
the table rarely needs updates unless we want to scale to max llcc/ddr
at a lower CPU frequency for a particular SKU.

> 
> Since both previously cpufreq-hw and now cpufreq-scmi generally
> operate on levels that map to some frequencies in the firmware,
> could it be bound to that instead?

At this point the only decision is whether the table lies in dt
or in the driver. But driver wouldn't even have a way to distinguish
between various skus so the dt looks like the only option.

-Sibi

> 
> Konrad
> 

