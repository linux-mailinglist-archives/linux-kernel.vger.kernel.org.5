Return-Path: <linux-kernel+bounces-162686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EC8B5EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660691F249BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF984D27;
	Mon, 29 Apr 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nFSL4xYs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95038824AA;
	Mon, 29 Apr 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408144; cv=none; b=XRVwHRKvak+HrWqJdSu9IU1r07lLRZWyzqGn9dd9/gmrCtB1CK43eDrCaEpn9MDbK/TAQFgcEbwcOuOdm3IJ7mcohV8x1mmSws6moHXsc+5fKJWHvYOgxePyhAmtRHYz4fNRCJ6xtNp/AgR4/KZl0ZM3xW0S0skIXxTnL3Z0daQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408144; c=relaxed/simple;
	bh=/rhfbBArK1vuX55gWRri0xcPJM+jiH9RSzxzjjGEBaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a5wrtBzAh/uCSZF2L4sXAVsDCbD6RLW5OFigaqOFd+NG8dS3r6ajx0UEx4kB7spcgA7XjCRculoJbEL4kCSjyrMrkr+kSr0oX1RuNJTUjsYIMqRI7dq8TJ3BdO/Vv6MGk+P2rN/XZ7XKTeBbydPYBlT//wxvIC4GoSdqdYnZPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nFSL4xYs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TFucHQ003792;
	Mon, 29 Apr 2024 16:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8aEzxpcfWPZRrq+K6Lw7TglFRUXWgUOU+zQ+AjNDdGU=; b=nF
	SL4xYszEGgM11oxNQYEyCYje9JaFMVDVHQjObtRqOCQwd4k+77F4qtHJbBI0BBzn
	7mokjnptD/9umDH7shc3IR3VUr3RmUaLfa+Z6IKwu74NIonvJbBMU01/M63hYIGv
	MLw0IyQX9ye+6gf3SIN5u920gyVeZ/sKwSdmOznKzSu+bM6HRAkKLea/2CLva45p
	vMwubcG9su7IRNg760s5cBtTz2X02HtTlPWj6p2HPoifTtjNRstVseItKPLkkTfP
	XY7BacktNb9ErvhI1DOkongOaw7H9GEcGH6M+Y+V1EuwG6yqEJ8SchzEEmvt6AtP
	yTuLcZNdotmb0+4MQQUg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtd8kgqyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:28:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TGSexC028096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:28:40 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 09:28:37 -0700
Message-ID: <b7296e60-1911-4302-b472-b0ae11cd3d87@quicinc.com>
Date: Mon, 29 Apr 2024 09:28:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>
CC: <akpm@linux-foundation.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <kernel@quicinc.com>, Rob Herring <robh@kernel.org>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
 <6ba5b226dfcbae3d9c789bb6943089621b315d65.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <6ba5b226dfcbae3d9c789bb6943089621b315d65.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LA1Li0h98ffn-aMf74TbmVylhmK6Oive
X-Proofpoint-ORIG-GUID: LA1Li0h98ffn-aMf74TbmVylhmK6Oive
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290105


On 4/29/2024 2:03 AM, John Paul Adrian Glaubitz wrote:
> Hi Oreoluwa,
>
> On Tue, 2024-04-23 at 16:31 -0700, Oreoluwa Babatunde wrote:
>> The unflatten_device_tree() function contains a call to
>> memblock_alloc(). This is a problem because this allocation is done
>> before any of the reserved memory is set aside in paging_init().
>> This means that there is a possibility for memblock to allocate from
>> any of the memory regions that are supposed to be set aside as reserved.
>>
>> Hence, move the call to paging_init() to be earlier in the init
>> sequence so that the reserved memory regions are set aside before any
>> allocations are done using memblock.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>> v2:
>> - Added Rob Herrings Reviewed-by.
>> - cc Andrew Morton to assist with merging this for sh architecture.
>>   Similar change made for loongarch and openrisc in v1 have already
>>   been merged.
> Could you link the changes for references so I can have a look?
Hi John,

Here are links to the corresponding changes on Loongarch and Openrisc.

- Loongarch:
https://lore.kernel.org/all/20240218151403.2206980-1-chenhuacai@loongson.cn/

- Openrisc:
https://lore.kernel.org/all/1707524971-146908-3-git-send-email-quic_obabatun@quicinc.com/


Thank you!
Oreoluwa
>
>> v1:
>> https://lore.kernel.org/all/1707524971-146908-4-git-send-email-quic_obabatun@quicinc.com/
>>
>>  arch/sh/kernel/setup.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
>> index 620e5cf8ae1e..98c8473e130d 100644
>> --- a/arch/sh/kernel/setup.c
>> +++ b/arch/sh/kernel/setup.c
>> @@ -322,6 +322,8 @@ void __init setup_arch(char **cmdline_p)
>>  	/* Let earlyprintk output early console messages */
>>  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
>>  
>> +	paging_init();
>> +
>>  #ifdef CONFIG_OF_EARLY_FLATTREE
>>  #ifdef CONFIG_USE_BUILTIN_DTB
>>  	unflatten_and_copy_device_tree();
>> @@ -330,8 +332,6 @@ void __init setup_arch(char **cmdline_p)
>>  #endif
>>  #endif
>>  
>> -	paging_init();
>> -
>>  	/* Perform the machine specific initialisation */
>>  	if (likely(sh_mv.mv_setup))
>>  		sh_mv.mv_setup(cmdline_p);
> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>
> Adrian
>

