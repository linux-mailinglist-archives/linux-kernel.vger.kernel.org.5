Return-Path: <linux-kernel+bounces-142468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD08A2BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C969A1C21BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B920535BF;
	Fri, 12 Apr 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dS/yLfWb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC7502AC;
	Fri, 12 Apr 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916473; cv=none; b=lyBv4w5Ah4HwBFmcN0E6Spa5fBbSsuxK7pQ4ePWkE3udz0k05CCK1AtblnK9Ny1wPjnfZaKpmpXohS71DdLvO2eku7OVMV6h2rZ69NAWHlg84FDwQ8R8W+ArvIUcSgKtqVBeFROOKPeBuXKm2RGa7JTsiiYv3mFCMB/xfPeiCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916473; c=relaxed/simple;
	bh=rsBOxr6Gjs4j8AYZEtfDkxXxCRpzRRY6DRRlTtZbPbY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ee05clSVrn747Yjp4ZyrYClS7OWRx+axdtLl4cgBVT8FbvrZceJLYlTMMR5oBQjAIPgDO4YxFJD3v+rup5HeBafSRh9zbPBrSfvGMfHglwr8RQXoEr69wL6iaR0mhwqvRNIgzwmXnZKv+69j9zKmO+VxSRMewQUjsgZUL9xAG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dS/yLfWb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C6F8Y0005367;
	Fri, 12 Apr 2024 10:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gIqeReF95pXfXYhYP0AXo2CDiHUnEU8JxPisJt7r5No=; b=dS
	/yLfWbwCT4HcoWPWVa+9gC7uA8ID6SHKt+fGS0Mdz/duNOtcVVMblAHudzfoNb+D
	X7VFSSwYZ4xDBoZ/XN0gz0lVdQBUZ1qy5xhb1qC3qyRFVE3ghZZmTodu/V/YN3Lg
	+IkOzd41hRAIljpwEAcjWiwFp306AjsrSpppGIYM1uruq4jxKufnQsFCuKuKS5wr
	cD132wgz1Hlr+Hl6TNhLv9wu3lpWyBMuICXr/Nucdoif8AKUIbVEQYNT8Awz27zS
	sFMaLvnhUWJefhzWsoDdVCZqeo323mG3Nga5j9I3deNvk9RB/NKZmHL/c4tACPv7
	v0fJB0kvGKjIBKkzEWDw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xev74ruej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 10:07:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CA7S2s002736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 10:07:28 GMT
Received: from [10.216.43.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 03:07:20 -0700
Message-ID: <c1f8c627-6497-4598-8b71-6be45e9c12f1@quicinc.com>
Date: Fri, 12 Apr 2024 15:36:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
From: Ashay Jaiswal <quic_ashayj@quicinc.com>
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef
	<qyousef@layalina.io>
CC: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Lukasz Luba
	<lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu
	<rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
        <quic_anshar@quicinc.com>, <quic_atulpant@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_adharmap@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_pkondeti@quicinc.com>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
 <a561029e-993d-726d-18ce-0bc014e6533c@quicinc.com>
 <20240121000444.ghue2miejmiair6l@airbuntu>
 <8dfb5db7-6da0-4f6f-30ef-8966428e4a1c@quicinc.com>
 <CAKfTPtB=nv7DDqTvsdenOg+UNoNFx=f2SLvihHx+CMkeE6NyNA@mail.gmail.com>
 <2270ebb6-3830-d667-1b9e-2efc96746b94@quicinc.com>
Content-Language: en-US
In-Reply-To: <2270ebb6-3830-d667-1b9e-2efc96746b94@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A51eqVVYQa2YnVSeNW0ANGELHT1P6_b9
X-Proofpoint-ORIG-GUID: A51eqVVYQa2YnVSeNW0ANGELHT1P6_b9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120073

On 2/6/2024 10:37 PM, Ashay Jaiswal wrote:
> 
> 
> On 1/30/2024 10:58 PM, Vincent Guittot wrote:
>> On Sun, 28 Jan 2024 at 17:22, Ashay Jaiswal <quic_ashayj@quicinc.com> wrote:
>>>
>>> Hello Qais Yousef,
>>>
>>> Thank you for your response.
>>>
>>> On 1/21/2024 5:34 AM, Qais Yousef wrote:
>>>> Hi Ashay
>>>>
>>>> On 01/20/24 13:22, Ashay Jaiswal wrote:
>>>>> Hello Qais Yousef,
>>>>>
>>>>> We ran few benchmarks with PELT multiplier patch on a Snapdragon 8Gen2
>>>>> based internal Android device and we are observing significant
>>>>> improvements with PELT8 configuration compared to PELT32.
>>>>>
>>>>> Following are some of the benchmark results with PELT32 and PELT8
>>>>> configuration:
>>>>>
>>>>> +-----------------+---------------+----------------+----------------+
>>>>> | Test case                       |     PELT32     |     PELT8      |
>>>>> +-----------------+---------------+----------------+----------------+
>>>>> |                 |    Overall    |     711543     |     971275     |
>>>>> |                 +---------------+----------------+----------------+
>>>>> |                 |    CPU        |     193704     |     224378     |
>>>>> |                 +---------------+----------------+----------------+
>>>>> |ANTUTU V9.3.9    |    GPU        |     284650     |     424774     |
>>>>> |                 +---------------+----------------+----------------+
>>>>> |                 |    MEM        |     125207     |     160548     |
>>>>> |                 +---------------+----------------+----------------+
>>>>> |                 |    UX         |     107982     |     161575     |
>>>>> +-----------------+---------------+----------------+----------------+
>>>>> |                 |   Single core |     1170       |     1268       |
>>>>> |GeekBench V5.4.4 +---------------+----------------+----------------+
>>>>> |                 |   Multi core  |     2530       |     3797       |
>>>>> +-----------------+---------------+----------------+----------------+
>>>>> |                 |    Twitter    |     >50 Janks  |     0          |
>>>>> |     SCROLL      +---------------+----------------+----------------+
>>>>> |                 |    Contacts   |     >30 Janks  |     0          |
>>>>> +-----------------+---------------+----------------+----------------+
>>>>>
>>>>> Please let us know if you need any support with running any further
>>>>> workloads for PELT32/PELT8 experiments, we can help with running the
>>>>> experiments.
>>>>
>>>> Thanks a lot for the test results. Was this tried with this patch alone or
>>>> the whole series applied?
>>>>
>>> I have only applied patch8(sched/pelt: Introduce PELT multiplier) for the tests.
>>>
>>>> Have you tried to tweak each policy response_time_ms introduced in patch
>>>> 7 instead? With the series applied, boot with PELT8, record the response time
>>>> values for each policy, then boot back again to PELT32 and use those values.
>>>> Does this produce similar results?
>>>>
>>> As the device is based on 5.15 kernel, I will try to pull all the 8 patches
>>> along with the dependency patches on 5.15 and try out the experiments as
>>> suggested.
>>
>> Generally speaking, it would be better to compare with the latest
>> kernel or at least close and which includes new features added since
>> v5.15 (which is more than 2 years old now). I understand that this is
>> not always easy or doable but you could be surprised by the benefit of
>> some features like [0] merged since v5.15
>>
>> [0] https://lore.kernel.org/lkml/249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com/
>>
> Thank you Vincent for the suggestion, I will try to get the results on device running
> with most recent kernel and update.
> 
> Thanks,
> Ashay Jaiswal

Hello Qais Yousef and Vincent,

Sorry for the delay, setting up internal device on latest kernel is taking more time than anticipated.
We are trying to bring-up latest kernel on the device and will complete the testing with the latest
cpufreq patches as you suggested.

Regarding PELT multiplier patch [1], are we planning to merge it separately or will it be merged
altogether with the cpufreq patches?

[1]: https://lore.kernel.org/all/20231208002342.367117-9-qyousef@layalina.io/

Thanks and Regards,
Ashay Jaiswal

>>>
>>>> You didn't share power numbers which I assume the perf gains are more important
>>>> than the power cost for you.
>>>>
>>> If possible I will try to collect the power number for future test and share the
>>> details.
>>>
>>>>
>>>> Thanks!
>>>>
>>>> --
>>>> Qais Yousef

