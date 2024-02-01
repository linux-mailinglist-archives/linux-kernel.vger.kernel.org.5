Return-Path: <linux-kernel+bounces-47634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB84845084
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C6A283372
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225C73C067;
	Thu,  1 Feb 2024 04:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AyWy8rI/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49C3B7AA;
	Thu,  1 Feb 2024 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763073; cv=none; b=Aei3W+CtK3/AejI772xU+t4LycrXJ2B1umQ88RvHIfa7XnKlTly1fZiA6r9cDx+EgL3WM01G8W2/OKHgA29Re1fFw2sIt6t74tcz/3lKvBk0e33W77M8CN2dU75t1o4rYCKIQPXBKTD2sTy4DV41agxXQv2BT4T/rF3FzvGPZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763073; c=relaxed/simple;
	bh=BPNgLmQqDG9aZXg+504dHaJy893J5WwQ6hHfO8GBYt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XeckNLvaUFNFO4QRnHzStuK7rqLskI632mlWT67W+kW3lpgyVjS3SrwIA0wuHs2jr+S/ai0GtikVh0UXaBiVDS0bSI/1l9iNJ5sEVGuaE5hqFrByCCPx7n2ozhxYAhveva5F0X4GatAeJ3k6qI2kbn7JL4XZfLjLrq5tBBVivmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AyWy8rI/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4114DdcY022765;
	Thu, 1 Feb 2024 04:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sPmKqUeaGGE21COXs6bla+PDHox2iV3csT2Ni2XMB1U=; b=Ay
	Wy8rI//bkX0xZ2s6czVk9LxbwmN+ev1pQkGVikpL/S1ikVhWoAAL8rL3fMcbG0ww
	7TZ+Kjro0QXj8lhB2m48TmBiiiWRIENBkoN0+B3ISVpmQA+H+nrX2yds4p0gadBO
	YZgJ3Vm1WUU9gdA+e3ZG3bR1bjS1W/daQ3R6RBTh57l+6iDln4kuZ+AxPP3Yaa9c
	Mqx8F61KN3VFLa3/4LucDEWUDgHRy5ubu4owYO6Ops4BEBG5sCrofjNFiGOofUaF
	3lJ201T+tAfxMp4RUbRKnfajADI3IIVSxyb+9wiVAwuQyIRp55xvXPOobd6eOjSP
	zukHoPYyv447br9MjgWw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyqvehx3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 04:50:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4114onnE021345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 04:50:49 GMT
Received: from [10.216.17.54] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 20:50:42 -0800
Message-ID: <8ce3c64a-344c-c2cb-7d36-4bd854a9ab7a@quicinc.com>
Date: Thu, 1 Feb 2024 10:20:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 0/4] PM: hibernate: LZ4 compression support
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E.
 McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (Google)"
	<rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, Yan-Jie Wang
	<yanjiewtw@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
References: <cover.1705927916.git.quic_nprakash@quicinc.com>
 <CAJZ5v0idcSPdwp7=WED0hYJ9s1KY_9w8Rkut8PCVGh56L0F5JA@mail.gmail.com>
Content-Language: en-US
From: Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <CAJZ5v0idcSPdwp7=WED0hYJ9s1KY_9w8Rkut8PCVGh56L0F5JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WsdXySX-n2K0Vor7eCgZTguyAyzxdUe5
X-Proofpoint-GUID: WsdXySX-n2K0Vor7eCgZTguyAyzxdUe5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2402010036



On 1/31/2024 7:50 PM, Rafael J. Wysocki wrote:
> On Mon, Jan 22, 2024 at 2:16 PM Nikhil V <quic_nprakash@quicinc.com> wrote:
>>
>> This patch series covers the following:
>> 1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
>> used in the next patch where we move to crypto based APIs for
>> compression. There are no functional changes introduced by this
>> approach.
>>
>>
>> 2. Replace LZO library calls with crypto generic APIs
>>
>> Currently for hibernation, LZO is the only compression algorithm
>> available and uses the existing LZO library calls. However, there
>> is no flexibility to switch to other algorithms which provides better
>> results. The main idea is that different compression algorithms have
>> different characteristics and hibernation may benefit when it uses
>> alternate algorithms.
>>
>> By moving to crypto based APIs, it lays a foundation to use other
>> compression algorithms for hibernation.
>>
>>
>> 3. LZ4 compression
>>
>> Extend the support for LZ4 compression to be used with hibernation.
>> The main idea is that different compression algorithms have different
>> characteristics and hibernation may benefit when it uses any of these
>> algorithms: a default algorithm, having higher compression rate but is
>> slower(compression/decompression) and a secondary algorithm, that is
>> faster(compression/decompression) but has lower compression rate.
>>
>> LZ4 algorithm has better decompression speeds over LZO. This reduces
>> the hibernation image restore time.
>> As per test results:
>>                                      LZO             LZ4
>> Size before Compression(bytes)   682696704       682393600
>> Size after Compression(bytes)    146502402       155993547
>> Decompression Rate               335.02 MB/s     501.05 MB/s
>> Restore time                       4.4s             3.8s
>>
>> LZO is the default compression algorithm used for hibernation. Enable
>> CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.
>>
>> Compression Benchmarks: https://github.com/lz4/lz4
>>
>>
>> 4. Support to select compression algorithm
>>
>> Currently the default compression algorithm is selected based on
>> Kconfig. Introduce a kernel command line parameter "hib_compression" to
>> override this behaviour.
>>
>> Users can set "hib_compression" command line parameter to specify
>> the algorithm.
>> Usage:
>>      LZO: hib_compression=lzo
>>      LZ4: hib_compression=lz4
>> LZO is the default compression algorithm used with hibernation.
>>
>>
>> Changes in v3:
>>   - Rebased to v6.8-rc1 after resolving the minor conflicts.
>>   - Link to v2:
>>   https://lore.kernel.org/all/cover.1700048610.git.quic_nprakash@quicinc.com/
> 
> I've applied the first 3 patches in the series (as 6.9 material), but
> I'm not particularly happy with the last one.
> 
> First off, I'm not sure if a kernel command line parameter is the most
> convenient way of selecting the compression algorithm.  Since (AFAICS)
> the restore kernel will detect the compression algo in use anyway (or
> at least it can be made do so), a modparam should work for this and it
> would be far more convenient to use.
> 
> Second, if I can be convinced that indeed, using a kernel command line
> option for this is the way to go, I don't particularly like the name
> used in that patch.
> 
> Please feel free to send a replacement for patch [4/4] separately.
> 
> Thanks!

Hi @Rafael,

Thanks for the update.

Regarding patch[4/4], will work on modifying the code as mentioned by 
adding module parameter instead of kernel cmdline parameter. Will send a 
separate patch for this after testing with the changes. Thanks for the 
input.

Thanks,
Nikhil V

