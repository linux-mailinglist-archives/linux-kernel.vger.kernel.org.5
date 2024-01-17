Return-Path: <linux-kernel+bounces-28449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9E82FEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D312B22105
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA88BE7;
	Wed, 17 Jan 2024 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="URP1xjnl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B879CD;
	Wed, 17 Jan 2024 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456751; cv=none; b=u58Hsz0rDa+IW/xa21GnMeMx9gJJNqrIeXCjmI29b5wa3vjR0aVdBsbW4Y1vZMJxynM4EZ1cCT08Lu9Y2o/0OdqnW+cGGAPpOH6/eyF1kZwccdzSeh/LMQPCQDX/ztsgix+ZQK/Uhd8hQjWN/pKQ15BvXqlQsiZtB3d5rghsOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456751; c=relaxed/simple;
	bh=BaUnPERfltSlweCU2bEsRomZLwKQ8pBH51fb2myjJTk=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=VQHamEN7hdrLzODe/3/yaBKnwXjfRG8vu9cW5kT0pVZ/7VAAKI3SX07WXUNU52icFz/D5i11bnoiPqm3NgSRWYh2JQglKL/YT0x87AHcRWcZWSvKFgHhWYT5+KHjnQXiaOp8rKaWy4iJbErH6w+tynsfVNBRtrXe4noDjCro5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=URP1xjnl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H0vNFc003306;
	Wed, 17 Jan 2024 01:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8ARN7Cx05ObbG1yQxAdeSnIi/eOGIcxsScGIi3qg6wc=; b=UR
	P1xjnlZqjuAmOxARvFuzxkSs+0jp2RQxR7FrMBFkhYEzKuSL9MQmdKstipkm3p5R
	Hfn7yLVZ0nnz42VNn5paiznMK+UfHJ2rBTAtA91uVKGDMHletpr8s1K0tDVEMxcK
	F3SBhP5qsVWQIgM+wxKP2v0sFtQpqHBZplKbWaQxXzDl1fpoOJXtwCkqKwSrNmGo
	qZGQsOqhjHl5zMOLd6gGSQ6GOfuliebbFa5wsWg1+m1TJ7kILNzGbhlF4No57jrd
	wP2onHgXiLIsBvGioGM6jj4jmdYCSq1cYugtgxja1zF5v4fwaN8kxGS55OQJw7Le
	8CG6kFmLoRknM9IYnDHw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnkeag9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 01:58:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H1wm4J002526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 01:58:48 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 17:58:43 -0800
Message-ID: <41429e0b-e7f5-40a3-8dff-ebf1d26c9aac@quicinc.com>
Date: Wed, 17 Jan 2024 09:58:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] coresight: core: Add device name support
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20240115164252.26510-1-quic_jinlmao@quicinc.com>
 <cef041b7-70ac-47c9-888c-696a0cec04d1@arm.com>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <cef041b7-70ac-47c9-888c-696a0cec04d1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cWZZEmT7fsuxPyYV6xQd7TRWZpKmHbVb
X-Proofpoint-ORIG-GUID: cWZZEmT7fsuxPyYV6xQd7TRWZpKmHbVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170011



On 1/16/2024 9:43 PM, Suzuki K Poulose wrote:
> On 15/01/2024 16:42, Mao Jinlong wrote:
>> With current design, the name of the non-cpu bounded coresight
>> component is the device type with the number. And with 'ls' command
>> we can get the register address of the component. But from these
>> information, we can't know what the HW or system the component belongs
>> to. Add device-name in DT to support it.
>>
>> cti_sys0 -> ../../../devices/platform/soc@0/138f0000.cti/cti_sys0
>> cti_sys1 -> ../../../devices/platform/soc@0/13900000.cti/cti_sys1
>> tpdm0 -> ../../../devices/platform/soc@0/10b0d000.tpdm/tpdm0
>> tpdm1 -> ../../../devices/platform/soc@0/10c28000.tpdm/tpdm1
>> tpdm2 -> ../../../devices/platform/soc@0/10c29000.tpdm/tpdm2
> 
> Please could you rebase this on for-next/queue (which has all bells and 
> whistles enabled to report Warnings), fixing the reported issue by 
> kernel test robot ?
> 
I will rebase the patch.

Thanks
Jinlong Mao
> Suzuki
> 
> 
>>
>> Change since V1:
>> 1. Change coresight-name to device name.
>> 2. Add the device-name in coresight dt bindings.
>>
>> Mao Jinlong (2):
>>    coresight: core: Add device name support
>>    dt-bindings: arm: Add device-name in the coresight components
>>
>>   .../bindings/arm/arm,coresight-catu.yaml      |  5 +++
>>   .../bindings/arm/arm,coresight-cpu-debug.yaml |  5 +++
>>   .../bindings/arm/arm,coresight-cti.yaml       |  5 +++
>>   .../arm/arm,coresight-dummy-sink.yaml         |  5 +++
>>   .../arm/arm,coresight-dummy-source.yaml       |  5 +++
>>   .../arm/arm,coresight-dynamic-funnel.yaml     |  5 +++
>>   .../arm/arm,coresight-dynamic-replicator.yaml |  5 +++
>>   .../bindings/arm/arm,coresight-etb10.yaml     |  5 +++
>>   .../bindings/arm/arm,coresight-etm.yaml       |  5 +++
>>   .../arm/arm,coresight-static-funnel.yaml      |  5 +++
>>   .../arm/arm,coresight-static-replicator.yaml  |  5 +++
>>   .../bindings/arm/arm,coresight-stm.yaml       |  5 +++
>>   .../bindings/arm/arm,coresight-tmc.yaml       |  5 +++
>>   .../bindings/arm/arm,coresight-tpiu.yaml      |  5 +++
>>   .../bindings/arm/qcom,coresight-tpda.yaml     |  5 +++
>>   .../bindings/arm/qcom,coresight-tpdm.yaml     |  5 +++
>>   drivers/hwtracing/coresight/coresight-core.c  | 33 ++++++++++---------
>>   .../hwtracing/coresight/coresight-platform.c  | 31 +++++++++++++++++
>>   include/linux/coresight.h                     |  1 +
>>   19 files changed, 130 insertions(+), 15 deletions(-)
>>
> 

