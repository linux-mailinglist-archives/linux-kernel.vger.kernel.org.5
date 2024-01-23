Return-Path: <linux-kernel+bounces-35465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE89839194
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC93289B96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4531B5FBA5;
	Tue, 23 Jan 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IyNy1pia"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299150A64
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020829; cv=none; b=Vcgp58N1j2fjPNwFj0wTogg6MT/NjmV8HtCjzfNT+sugpbS6DTDBdWM0eVUrTpfiaBvdDxdyeQOUb1LIuYtYLZiSjQm50Tmlb/ElqK3Wwz0Ix4pDajX1iZ90Tm89m1wmeivFytWCvUJE2tsGui7uzRfivW77XInQQS9EvAL6y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020829; c=relaxed/simple;
	bh=QsPYV2qvgYRd7cxIorUZgUazlpt60R9Ft46HukO+PW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SDn1asCWF1ghrkpWzhEo9bWI6kcCZeHNQF4WRZ1NcbZluglgFCZ5rV+s6YEFnUWsW+q/R12FctpVNrwER2hsdcV9//xk8KtzoSmZ/2iE0D1z3mDZVFb+Qgn4Fmz5QuJIMFcOhpkRaa7amtI5cBo+b8+0hnNrGohY2vTHfH1niRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IyNy1pia; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NBKCFZ028942;
	Tue, 23 Jan 2024 14:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WAdESOtkLz220Vg5JKel2RUagTbLvZfxpmC2wH3/tdI=; b=Iy
	Ny1piaq7ZK0ZYPKb/nGRONLmNs/P/EW45Y5qLoA7JYg3omeJMQ6DJfgMl26imOg0
	SRKmNJxeiXjrhJbIP24gitUHFtqP93WHkMQBWSVlnVwX7tDOHpirBdrsZYmM93Nu
	0FrhimRBHVQANkxnjbYGVcT0pAomw/IoxNb56y1qaTIxsfeO/o3XesXj1n8Gkhlz
	aI31QuW4eIaGT4k0z7zLoBozsjZIr9rrijyr3NJhclAqHzC99MUo44iKNChpQjm2
	+qqsMPD0Y/bdnVtDVI4H9R7290JPdV/5Q0/xFh/KjdEDwqG+W8g2Pm7YbLqeBp7D
	V8d0upwIJnJLhUPqz1jA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt81414he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:40:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NEeCw5005986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:40:12 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 06:40:10 -0800
Message-ID: <81b61c42-3c2b-bce3-d667-b45478d5fccd@quicinc.com>
Date: Tue, 23 Jan 2024 20:10:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Purpose of maple_node objects to be its size aligned
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
CC: <Liam.Howlett@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML
	<linux-kernel@vger.kernel.org>
References: <56154bf4-c1e2-16d5-c6e2-c2dee42d3377@quicinc.com>
 <Za--f_sJ8cbgqn80@casper.infradead.org>
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <Za--f_sJ8cbgqn80@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e05rKQiGUqFio0K0MKmMVr1KdnA_ONuA
X-Proofpoint-ORIG-GUID: e05rKQiGUqFio0K0MKmMVr1KdnA_ONuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=810 clxscore=1011 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230106

Thanks Matthew!!

On 1/23/2024 6:56 PM, Matthew Wilcox wrote:
>> I am just curious about the purpose of maple node slab objects to be its
>> size aligned, but I can understand why they need to be cache aligned.
> Because we encode various information in the bottom few bits of the
> maple node pointer.
> 
> /*
>  * The Maple Tree squeezes various bits in at various points which aren't
>  * necessarily obvious.  Usually, this is done by observing that pointers are
>  * N-byte aligned and thus the bottom log_2(N) bits are available for use.  We
>  * don't use the high bits of pointers to store additional information because
>  * we don't know what bits are unused on any given architecture.
>  *
>  * Nodes are 256 bytes in size and are also aligned to 256 bytes, giving us 8
>  * low bits for our own purposes.  Nodes are currently of 4 types:
>  * 1. Single pointer (Range is 0-0)
>  * 2. Non-leaf Allocation Range nodes
>  * 3. Non-leaf Range nodes
>  * 4. Leaf Range nodes All nodes consist of a number of node slots,
>  *    pivots, and a parent pointer.
>  */
> 

I got it. Looks like I need to revisit the maple tree documentation
before asking such questions.

> That seems like a very badly implemented patch.  Rather than make all
> objects left & right redzone, we should simply insert a redzone at
> the beginning of the slab.  ie
> 
> 0	redzone
> 256	node
> 512	redzone
> 768	node
> 1024	redzone
> 1280	node
> [...]
> 3072	redzone
> 3382	node
> 3584	redzone
> 3840	wasted space
> 
This seems to work when only redzone is enabled?

I think it will again 768b aligned if any other debug option enabled,
say U. It is:
(size aligned red zone + maple node +  right red zone (size of (void*))
+ alloc/free track).

My understanding to have both left and right red zone is:
                /*
                 * Add some empty padding so that __we can catch
                 * overwrites from earlier objects rather than let
                 * tracking information or the free pointer be
                 * corrupted if a user writes before the start
                 * of the object__.
                 */

When all the debug options enabled, the slab object will roughly look
like below:

Left red zone | object | right red zone | free pointer | alloc/free
track | padding

> Instead of getting only five nodes per 4kB page, we'd get seven; about
> a 30% reduction in memory usage.
> 
> Slab redzoning is not a feature people turn on often, so I'm not
> surprised nobody's noticed before now.

+Vlastimil. The patch in discussion is d86bd1bece6f ("mm/slub: support
left redzone").

Thanks,
Charan

