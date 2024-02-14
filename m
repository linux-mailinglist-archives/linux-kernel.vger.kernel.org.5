Return-Path: <linux-kernel+bounces-64816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8479A854334
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67891C22CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378421170E;
	Wed, 14 Feb 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E+J278Xi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BC111A2;
	Wed, 14 Feb 2024 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894244; cv=none; b=VJPEL8IfkZXFOu1Q6KvgN7avnna/jVnRGLWOo0FRJzKQngIhoGE/a8LLVxBWwmhikfDolmK5d1R4cU6jPbvYVPguPQtPrEQH8ItRyGEDdWd3neoHNPMJ8VVQEpiif+k56OdCpqCMD/MiHxivq+K8190FQIVjZiHb355TV5ir2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894244; c=relaxed/simple;
	bh=SxDMitXrZdgJSRPQljG5vzYJ75Md+aT0vs0nRf2RU24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=liSjJYAIxwfB8EPKUJZuKQ7UmR0wEIG9xGyU4U6RUiakjxGjg9PRHxDXpPD7UQkV8fpjpv1JfpmbCtpBUWdIT/JroJT/tQnHBMQraSuYQx4f1Gjq4UO9raLX4K/3lcM3sQa5cV6MdrnacYmR1gNxNZjXJBcImODo0LnBXb4f2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E+J278Xi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E6qF7t009288;
	Wed, 14 Feb 2024 07:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4vd+mtJ0l3WUpTERdyjKbKOw7hhg9weB54kH0ZgtkjA=; b=E+
	J278XiRzH08ZcigLN/fLyi4G1gSJ4q5igY6h6Xj70c+IKzxREymoZSoIiaVKY4wF
	h5N0M96bDghF+aY51v+nZyDTBVuBDsXbEUBYEQqO0wuof2DxpfvDdOoQd3u+XVJh
	yJ5iVrDzK7Fw7sr75uo/vECffdW9uOnEDpkVWwvU+1DH8k3P7XFXE7PMQta4Ux7w
	da8nGaPkFPG4c+eictBfkSDSLeuzZZ7J/aibA34uRO4xT/3tea1JXWdd0KwC0P8S
	b0rr0EdIfEFb7+BSmlX7Dz2GKTsiy0M+bJOLuXepDSGtHn2wSe2lURWtdJs7dqwf
	pNTRp7D8gOvLeV81iDng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8k9aggb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 07:03:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E73dJ6026441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 07:03:39 GMT
Received: from [10.216.25.21] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 23:03:32 -0800
Message-ID: <b46e9f4d-4600-d848-7e47-985b013d62b8@quicinc.com>
Date: Wed, 14 Feb 2024 12:33:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] PM: hibernate: Support to select compression algorithm
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        "Len
 Brown" <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Yan-Jie Wang <yanjiewtw@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
References: <3776355f920c1af44490e076072f93bafdf128cc.1707740870.git.quic_nprakash@quicinc.com>
 <1d12e130-d3db-4eb5-a1d0-bc994c97a175@infradead.org>
From: Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <1d12e130-d3db-4eb5-a1d0-bc994c97a175@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YMqGurqrgxzdDzqU0XAo_MHM1vPhjtDF
X-Proofpoint-GUID: YMqGurqrgxzdDzqU0XAo_MHM1vPhjtDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140054



On 2/13/2024 12:34 AM, Randy Dunlap wrote:
> 
> 
> On 2/12/24 04:32, Nikhil V wrote:
>> Currently the default compression algorithm is selected based on
>> compile time options. Introduce a module parameter "hibernate.compressor"
>> to override this behaviour.
>>
>> Different compression algorithms have different characteristics and
>> hibernation may benefit when it uses any of these algorithms, especially
>> when a secondary algorithm(LZ4) offers better decompression speeds over a
>> default algorithm(LZO), which in turn reduces hibernation image restore
>> time.
>>
>> Users can override the default algorithm in two ways:
>>   1) Passing "hibernate.compressor" as kernel command line parameter.
>>      Usage:
>>      	LZO: hibernate.compressor=lzo
>>      	LZ4: hibernate.compressor=lz4
>>
>>   2) Specifying the algorithm at runtime.
>>      Usage:
>> 	LZO: echo lzo > /sys/module/hibernate/parameters/compressor
>> 	LZ4: echo lz4 > /sys/module/hibernate/parameters/compressor
>>
>> Currently LZO and LZ4 are the supported algorithms. LZO is the default
>> compression algorithm used with hibernation.
>>
>> Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
>> ---
>> This patch is dependent on the patch series, [1] (patches 1/4 to 3/4).
>> This is picked in linux-next, [2].
>>   [1] https://lore.kernel.org/all/cover.1705927916.git.quic_nprakash@quicinc.com/
>>   [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/kernel/power?h=next-20240212
>>
>>   .../admin-guide/kernel-parameters.txt         | 10 ++++
>>   kernel/power/hibernate.c                      | 57 ++++++++++++++++++-
>>   2 files changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 31b3a25680d0..522155056645 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1748,6 +1748,16 @@
>>   				(that will set all pages holding image data
>>   				during restoration read-only).
>>   
> 
> Hi,
> Please add something like:
> 
> 
>> +	hibernate.compressor= 	[HIBERNATION] Compression algorithm to be
>> +				used with hibernation.
>> +				Format: { lzo | lz4 }
> 				Default: lzo
>> +
>> +				lzo: Select LZO compression algorithm to
>> +				compress/decompress hibernation image.
>> +
>> +				lz4: Select LZ4 compression algorithm to
>> +				compress/decompress hibernation image.
>> +
>>   	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
>>   			size of <nn>. This works even on boxes that have no
>>   			highmem otherwise. This also works to reduce highmem
> 
> 
> thanks.

Hi @Randy,

Will update the documentation as mentioned and send the patch for review.

Thanks,
Nikhil V

