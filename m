Return-Path: <linux-kernel+bounces-40003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC8583D884
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6F4B43248
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6112B74;
	Fri, 26 Jan 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TVYwDy3F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E71FA0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266050; cv=none; b=V/B/FNAg/uP0noTZmXgQlLV1WwFUYR3MyBSByoyBMsR1whLZBbndfKldoILXgIsE0yHEX85u7lXw1ynzCXz9gpKOzKAf89z3+iIKj/bv26VeCdMw4qMmk3+vixYbjng9IEk09m0mUjLlB5hk7TESrDmA7pxfbTJzv7KAeZsppqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266050; c=relaxed/simple;
	bh=7iGPgXhQzjAMgbbLMGBzDKjvZs6QBwPWWlL95HNkfuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dysQ4mBg3gFCTpLnCHvXkJC9zsIKcL0OAeQf1NYoGMNpQ2fMEbMwKg3U/ZNKO5S0jSkVhLinL3EVGrvNwvkCzIM8p4+zmPW2x9kySPS6zLj+kMXtwJxvDY+h7IgkW4NxTxFpCUlX9uNdDamAQTdwExFGyYwhHKBblZenjRZTpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TVYwDy3F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q4OuBC002099;
	Fri, 26 Jan 2024 10:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Dr1b+LNasWBfDiz6qm0FOfD2D0DAEk8L38V0AafYadw=; b=TV
	YwDy3FFHML3PaoRSDH6ATY6Zx8W/OiAu5hJwCGX0BCFHm/9m9AZ9PDCK8Vsj7pL7
	PM7DvyMPnHcxbPpMu6VzFMzPlrryjTihMaeIvTSbI3USy4C/Wp9XAFkBY4ONDAJh
	idzkegrFBuQA6qJowDwwUTSa9p6uuc2vE8Tg6gLGpFMolMRX1IZ7MPqJiNW0HOjJ
	yuYYHDZTDc5GaGeK3W5OZtQ5VSmD6csC8kjTyBPBPxb1izB32D948hf3kf4idNl+
	SRrExxssctfKIA6tRJF334X9i1LQpQUHC1e6C0Fmvx1lSuLmyxJhDQqdpypQCBuw
	JOX2wc5OvqNxyCSgOqfg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv1q596vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 10:47:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QAlCJW031039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 10:47:12 GMT
Received: from [10.216.18.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 02:47:08 -0800
Message-ID: <5adb12eb-8403-5860-28eb-5f6ab12f3c04@quicinc.com>
Date: Fri, 26 Jan 2024 16:17:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
Content-Language: en-US
To: Zach O'Keefe <zokeefe@google.com>
CC: Michal Hocko <mhocko@suse.com>, <akpm@linux-foundation.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>, <vbabka@suse.cz>,
        <hannes@cmpxchg.org>, <quic_pkondeti@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        David Rientjes <rientjes@google.com>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
 <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka>
 <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
 <CAAa6QmRnfTOCD0uaxVbbiDRWtwzC9y+gZDFOjYF2YWDTrXyMNQ@mail.gmail.com>
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAAa6QmRnfTOCD0uaxVbbiDRWtwzC9y+gZDFOjYF2YWDTrXyMNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: juFkEb3_tBv4RmYroSjb6W-T0ad2YZ34
X-Proofpoint-GUID: juFkEb3_tBv4RmYroSjb6W-T0ad2YZ34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=668 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401260078

Hi Michal/Zach,

On 1/25/2024 10:06 PM, Zach O'Keefe wrote:
> Thanks for the patch, Charan, and thanks to Yosry for pointing me towards it.
> 
> I took a look at data from our fleet, and there are many cases on
> high-cpu-count machines where we find multi-GiB worth of data sitting
> on pcpu free lists at the time of system oom-kill, when free memory
> for the relevant zones are below min watermarks. I.e. clear cases
> where this patch could have prevented OOM.
> 
> This kind of issue scales with the number of cpus, so presumably this
> patch will only become increasingly valuable to both datacenters and
> desktops alike going forward. Can we revamp it as a standalone patch?
> 

Glad to see a real world use case for this. We too have observed OOM for
 every now and then with relatively significant PCP cache, but in all
such cases OOM is imminent.

AFAICS, Your use case description to be seen like a premature OOM
scenario despite lot of free memory sitting on the pcp lists, where this
patch should've helped.

@Michal: This usecase seems to be a practical scenario that you were
asking below.
Other concern of racing freeing of memory ending up in pcp lists first
-- will that be such a big issue? This patch enables, drain the current
pcp lists now that can avoid the oom altogether. If this racing free is
a major concern, should that be taken as a separate discussion?

Will revamp this as a separate patch if no more concerns here.

> Thanks,
> Zach
> 
> 
> On Tue, Nov 14, 2023 at 8:37 AM Charan Teja Kalla
> <quic_charante@quicinc.com> wrote:
>>
>> Thanks Michal!!
>>
>> On 11/14/2023 4:18 PM, Michal Hocko wrote:
>>>> At least in my particular stress test case it just delayed the OOM as i
>>>> can see that at the time of OOM kill, there are no free pcp pages. My
>>>> understanding of the OOM is that it should be the last resort and only
>>>> after doing the enough reclaim retries. CMIW here.
>>> Yes it is a last resort but it is a heuristic as well. So the real
>>> questoin is whether this makes any practical difference outside of
>>> artificial workloads. I do not see anything particularly worrying to
>>> drain the pcp cache but it should be noted that this won't be 100%
>>> either as racing freeing of memory will end up on pcp lists first.
>>
>> Okay, I don't have any practical scenario where this helped me in
>> avoiding the OOM.  Will comeback If I ever encounter this issue in
>> practical scenario.
>>
>> Also If you have any comments on [PATCH V2 2/3] mm: page_alloc: correct
>> high atomic reserve calculations will help me.
>>
>> Thanks.
>>

