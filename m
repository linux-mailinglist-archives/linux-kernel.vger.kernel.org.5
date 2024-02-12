Return-Path: <linux-kernel+bounces-61244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52FC850FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CB82840DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D28F12E49;
	Mon, 12 Feb 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kb72wJJv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F715A8;
	Mon, 12 Feb 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730152; cv=none; b=POMwj03s9+iUj3iGsH7uA/HfYL0lUnRtQxyYK3LCtoSf+dtOVcH7UChehJuT3DDOaTnNOUDSDotHY0RreucKYy8Y0pzTYMkxKlwN599WYr/dpFwQm6zw5lTtLoMj0BupTOei7/MAPruXXSoftyoXtAmPpYi0Bk9D5UiY/isFkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730152; c=relaxed/simple;
	bh=+2rAaj0BpxZq0QhkiYUH/at7Shh4pzMJ1CpET3YKsOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tyFz/8ISpg9zEuRztf016z0RAR7Q56+OIfRuCy9sk5B1IuMeSNHB9dYdglLLBYaQ2xzeW1vMsQD3db6KsAM4TKdNwndbRpxNg3W+qvYmBZxUjwinbvkoUlwDU/2M5N+37/c+FH2kAoFenlI8LwKTOPQM673VpM8ka4vRmfSglxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kb72wJJv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C8ILFI008232;
	Mon, 12 Feb 2024 09:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wZb4DeeDCD3DDnyQB8zRGSDNedk50m0/Skjj7EMyFhY=; b=kb
	72wJJvt5tqzXJdX5qObCPUpPcLSXZ/QRfAbhmeSFkr+yszZAbbFD7ldvrtDufddp
	T2obGenTE5JEs4agkvm7S24RPPquIFjPKeUMRV3eMEhaK+gAj/vG8ko8lCcsUhHP
	r5kZD7yZkXcm13HDofUC4eHouVL9ma5rttHHQxfO22n5OEXbMdMh+bWZq4HeE5Px
	QkdxOXXMWVxVzeELSORx0AzSOlegTkBu2FO8kOIwOhweApenVOnCfVgfO5IxN7RS
	ZYpBIT5rAqENCksISpHHMeghbt+9htYMO8XXnfXX5X5MMm038tcY3Ugndnch7jMw
	OppAgkBuYKcqEWJGR4rg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62ps2vkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:29:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C9T3Xh022779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:29:03 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 01:28:59 -0800
Message-ID: <211aee74-30d3-3316-030d-2a4379259eb3@quicinc.com>
Date: Mon, 12 Feb 2024 14:58:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 6/7] arm64: dts: qcom: x1e80100: Enable cpufreq
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-7-quic_sibis@quicinc.com> <ZalDBWwOhD3Gy1Mb@bogus>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZalDBWwOhD3Gy1Mb@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1ZgwgdvRjkp6L1nzn0nvf3O54HkNm0T2
X-Proofpoint-GUID: 1ZgwgdvRjkp6L1nzn0nvf3O54HkNm0T2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_06,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=749
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120071



On 1/18/24 20:55, Sudeep Holla wrote:
> (Generic note: It is middle of merge window and I have seen multiple
> series posted by you. Since I am mainly looking for bug fixes only ATM,
> I may miss to look at few. You may have to ping or repost after the merge
> window, just responding to this for now as it caught my attention)

ack

> 
> On Wed, Jan 17, 2024 at 11:04:57PM +0530, Sibi Sankar wrote:
>> Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 27 ++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index afdbd27f8346..6856a206f7fc 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -62,6 +62,7 @@ CPU0: cpu@0 {
>>   			compatible = "qcom,oryon";
>>   			reg = <0x0 0x0>;
>>   			enable-method = "psci";
>> +			clocks = <&scmi_dvfs 0>;
> 
> I would use genpd bindings Ulf added recently. The reason I ask is I remember
> one of the Qcom platform had both clocks and qcom,freq-domain and each one
> served different purpose with latter one being used for cpufreq. So will
> that be an issue here ?

The cpufreq-hw node that Qualcomm used had a opp-table associated with
it to vote for various buses which in turn required both clock and freq-
domain. However the memory buses voting is done by the vendor protocol 
0x80 on X1E and hence won't be an issue here.

-Sibi

> 

