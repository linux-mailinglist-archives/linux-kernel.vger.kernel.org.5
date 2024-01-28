Return-Path: <linux-kernel+bounces-41834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2283F836
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A101C20307
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171342E64F;
	Sun, 28 Jan 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SkWYpIGT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363628DDE;
	Sun, 28 Jan 2024 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458975; cv=none; b=OfxEfajD5h7h6u34kuG3C0fmdfTWWN0G7mk2xIUz9ZIRBshnYC90HihXY5MPP0ZO51SORaTbCEtrkOczzkUbFvNmRDC3IrpEnJ7puZErlZuXTorAPbkXRym2XErkg/bkWW2Gqmz2yjf8x0kDxyvvUl3Y6Agj8fPG6lZfv1y9A20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458975; c=relaxed/simple;
	bh=vznyjQCwNBtbhgiBWAAfKVKE97uQGRSnyXoBpffD3Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KhySKq1fXBVzfsCLmHuL843qKuI6jAlF6aVzbJ1c9uexw0EiVAIuufFpf4K+3j6pvcK/tQIJj+kjrLKsirIKvALX/GZs/E+xWxxcA8HKuvD8A1iDp4d8sLveD8ju/Aj22xcv2GpqzGkVYIgGPXAJCBt0M/N5Lco07/UeSh4dCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SkWYpIGT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40SFtVFU026312;
	Sun, 28 Jan 2024 16:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gUvqc5cZxjVm/d9JMnpRBPZHn21Mqzr6wO/oybXwk8g=; b=Sk
	WYpIGTOjGftn0A82FkurcsWkV/xp7LfNR5F+THYnMudyWOeJzGEGTfGYGVx2dTTc
	zBZBMSNbsXMxdMim8oeFxP4y45s/Djlmv69QylIHtPGpwlC8ZwtRwg66jeF9XUi8
	syWk/R8WyIgCR8WqrqQAFqqUpYPrfWL6q0wEZF6WGSJcqdZw0zZQ25u1Uq4cehlr
	RZmUJfaCTT1lg9PoDasftxcvyiNaMiLcvqku9KUtdIv5T+BHuGKwDlX8E/WSmz/b
	1UVdB6MFs0CyW1i93V0Ml2cf2h7SuYtQAqz7So3ra/1UilpQKBycLrucEbJ1+Dqa
	LnbLCTbxsIyf+dhrlxnQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvruba1hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 16:22:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40SGMSoq026454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 16:22:28 GMT
Received: from [10.216.53.94] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 28 Jan
 2024 08:22:22 -0800
Message-ID: <8dfb5db7-6da0-4f6f-30ef-8966428e4a1c@quicinc.com>
Date: Sun, 28 Jan 2024 21:51:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
CC: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang
	<wvw@google.com>,
        Rick Yiu <rickyiu@google.com>, Chung-Kai Mei
	<chungkai@google.com>,
        <quic_anshar@quicinc.com>, <quic_atulpant@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_adharmap@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_pkondeti@quicinc.com>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
 <a561029e-993d-726d-18ce-0bc014e6533c@quicinc.com>
 <20240121000444.ghue2miejmiair6l@airbuntu>
From: Ashay Jaiswal <quic_ashayj@quicinc.com>
In-Reply-To: <20240121000444.ghue2miejmiair6l@airbuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7_i7TCGHqRGM89cZxbweJQ6BxzGkhlgH
X-Proofpoint-GUID: 7_i7TCGHqRGM89cZxbweJQ6BxzGkhlgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=534 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401280123

Hello Qais Yousef,

Thank you for your response.

On 1/21/2024 5:34 AM, Qais Yousef wrote:
> Hi Ashay
> 
> On 01/20/24 13:22, Ashay Jaiswal wrote:
>> Hello Qais Yousef,
>>
>> We ran few benchmarks with PELT multiplier patch on a Snapdragon 8Gen2
>> based internal Android device and we are observing significant
>> improvements with PELT8 configuration compared to PELT32.
>>
>> Following are some of the benchmark results with PELT32 and PELT8
>> configuration:
>>
>> +-----------------+---------------+----------------+----------------+
>> | Test case                       |     PELT32     |     PELT8      |
>> +-----------------+---------------+----------------+----------------+
>> |                 |    Overall    |     711543     |     971275     |
>> |                 +---------------+----------------+----------------+
>> |                 |    CPU        |     193704     |     224378     |
>> |                 +---------------+----------------+----------------+
>> |ANTUTU V9.3.9    |    GPU        |     284650     |     424774     |
>> |                 +---------------+----------------+----------------+
>> |                 |    MEM        |     125207     |     160548     |
>> |                 +---------------+----------------+----------------+
>> |                 |    UX         |     107982     |     161575     |
>> +-----------------+---------------+----------------+----------------+
>> |                 |   Single core |     1170       |     1268       |
>> |GeekBench V5.4.4 +---------------+----------------+----------------+
>> |                 |   Multi core  |     2530       |     3797       |
>> +-----------------+---------------+----------------+----------------+
>> |                 |    Twitter    |     >50 Janks  |     0          |
>> |     SCROLL      +---------------+----------------+----------------+
>> |                 |    Contacts   |     >30 Janks  |     0          |
>> +-----------------+---------------+----------------+----------------+
>>
>> Please let us know if you need any support with running any further
>> workloads for PELT32/PELT8 experiments, we can help with running the
>> experiments.
> 
> Thanks a lot for the test results. Was this tried with this patch alone or
> the whole series applied?
> 
I have only applied patch8(sched/pelt: Introduce PELT multiplier) for the tests.

> Have you tried to tweak each policy response_time_ms introduced in patch
> 7 instead? With the series applied, boot with PELT8, record the response time
> values for each policy, then boot back again to PELT32 and use those values.
> Does this produce similar results?
> 
As the device is based on 5.15 kernel, I will try to pull all the 8 patches
along with the dependency patches on 5.15 and try out the experiments as
suggested.

> You didn't share power numbers which I assume the perf gains are more important
> than the power cost for you.
> 
If possible I will try to collect the power number for future test and share the
details.

> 
> Thanks!
> 
> --
> Qais Yousef

