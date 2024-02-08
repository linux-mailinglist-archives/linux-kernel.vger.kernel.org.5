Return-Path: <linux-kernel+bounces-57848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D912984DE28
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180CA1C26B67
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226906F08F;
	Thu,  8 Feb 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZRdGbNty"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5A6D1C9;
	Thu,  8 Feb 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387746; cv=none; b=uot6KCxYnIYSTP+orl7GQlDmRcCOCm7BM7b9La/bTnQftEa3WIXaPf36Zu5IcPAInMdpEUqdL9fkcm1pickcCzSFgq7tgJjlOmdhw4UuHBGLB8H9QPKRihu/EFKyiXXWUlwMCKNgVMALgHctzmJTr7NZwgna2u3CTF9mvlqWMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387746; c=relaxed/simple;
	bh=PfLUmuXo0GEDMmnRiXHPOLXCNaYZZAjXgb0dXfGF/lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LFacqUiDHY0N+QNBZF7cDt0olIcHz293+Dved++vpjcohhiqziBm+FGA0W4eCGS62J/JET2Z03yO7thiq5IDVYuGrFY5OMrIrVNw0WSN/yDqrfGUgUwCa3yUrS55V/MQn5r6UNTzWeop+gJf8+3myNstUjSqqykbaJePs1qfU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZRdGbNty; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4187oU5T002432;
	Thu, 8 Feb 2024 10:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6j2DPWy54VnId1kVZnydmlSBxga3Rz9SWby7Pw3pcyE=; b=ZR
	dGbNtyL8E2INdw8l18s34Kksahdy7oS+8NjgnbKXow+VSUyEHuQ8El46vydUaOmI
	vODtjJYNU4vZTxSj6zlHrXA4hxYi7QaI0toa0nSSUgolgkA1Zi+1NBqg1LKUIOZe
	uDTeZnkQdAyq6RILWx36VJDplWQB/un84ygFM8qFRuasT/5Hrx3MbqnNhY/CuweK
	CHkE/2DTXJ7wo6EVJBmlmB6yAhMLpnzeEsM2LUBUEdCtY98fXhBpa3NQ5aEPf01x
	yupxspvQSb2rSWLgkoNGoPlTFgZ9Au4IaUn2zY815mwuV0LNI/8/MhvcYX03ZXJ7
	WybWEjRcX+TnNswYPZXA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4stxgkcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 10:22:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418AMGMM017355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 10:22:16 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 02:22:11 -0800
Message-ID: <1f0c2767-c489-58a6-e5ba-9f1974072bb7@quicinc.com>
Date: Thu, 8 Feb 2024 15:52:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 1/7] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-2-quic_sibis@quicinc.com>
 <7bf729a4-f3ac-4751-9275-a2aa4d62c036@linaro.org>
Content-Language: en-US
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <7bf729a4-f3ac-4751-9275-a2aa4d62c036@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4QNLi6la1u5zi_sYGFlZlGpXS4GzKd9A
X-Proofpoint-ORIG-GUID: 4QNLi6la1u5zi_sYGFlZlGpXS4GzKd9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 mlxlogscore=534 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080054



On 1/18/24 01:23, Konrad Dybcio wrote:
> 
> 
> On 1/17/24 18:34, Sibi Sankar wrote:
>> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
>> controller.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> 

Hey Konrad,

Thanks for taking time to review the series.

> [...]
> 
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    mailbox@17430000 {
>> +        compatible = "qcom,x1e80100-cpucp-mbox", "qcom,cpucp-mbox";
>> +        reg = <0x17430000 0x10000>, <0x18830000 0x300>;
> 
> These reg spaces are quite far apart.. On 7280-8550, a similar
> mailbox exists, although it's dubbed RIMPS-mbox instead. In
> that case, I separated the mbox into tx (via
> qcom-apcs-ipc-mailbox.c) and rx (with a simple driver). Still
> haven't pushed or posted that anywhere, I'd need to access
> another machine..
> 
> On (some of) these SoCs, one of the channels (rx[1], iirc?) clearly
> bleeds into the CPUFREQ_HW/OSM register region, which gives an
> impression of misrepresenting the hardware. X1E doesn't have a
> node for cpufreq_hw defined, so I can't tell whether it's also the
> case here.

I am aware of ^^ discussion and the X1E doesn't have this problem.
Both the regions described are only used for mailbox communication.
X1E uses the scmi perf protocol for cpu dvfs.

-Sibi

> 
> Konrad

