Return-Path: <linux-kernel+bounces-164998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE52E8B8634
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C131EB226DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2264DA0E;
	Wed,  1 May 2024 07:43:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541F4EB31;
	Wed,  1 May 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549408; cv=none; b=br75AQLMQ5aJbIdAhs/KesBIPU4Z3M87kEKFje7aO2M5Tnkg3KLOs5bNuUOBQyHb/NK+T93gOCMRJIZhmEFB/mfjJynDwt1lV83pCHHF5Hf0VFuua0WKK81+NKy2dbkAeb6tulBP9kOcnw28JjJNQqiHiV0yyzxoLRnBcreWFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549408; c=relaxed/simple;
	bh=7nqU/xTAWIKrs6wJO5+o3gQ7Nxw3CcRjC/R068qB5iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgzbT+Na/QT2Mr1ytkXhKM1bP59NvIIovMO1PuAYzAfCFLkdUM0+j52ZfIwZhjR0lDs+7OMX5owMgmsQUiImaXMNWfXh/dCNgTnHvjD3cLJuyM7aesKB77JW2/xj3XyPtM4pCFi3SUfPzLAEqA+09SOl9YK8MTvBJbduUPHhJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 78cd6df2078e11ef9305a59a3cc225df-20240501
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:8fb245b8-d59c-48f8-aa80-f550bdb94b68,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:11
X-CID-INFO: VERSION:1.1.37,REQID:8fb245b8-d59c-48f8-aa80-f550bdb94b68,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:11
X-CID-META: VersionHash:6f543d0,CLOUDID:a1f90559195b470bc2f19128ca9783ed,BulkI
	D:240501142506Y4TZV215,BulkQuantity:1,Recheck:0,SF:72|19|44|64|66|38|24|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 78cd6df2078e11ef9305a59a3cc225df-20240501
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1203291724; Wed, 01 May 2024 15:43:16 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 79F6E16002082;
	Wed,  1 May 2024 15:43:05 +0800 (CST)
X-ns-mid: postfix-6631F289-3125101
Received: from [10.42.116.201] (unknown [10.42.116.201])
	by node4.com.cn (NSMail) with ESMTPA id 9EBE216002082;
	Wed,  1 May 2024 07:43:04 +0000 (UTC)
Message-ID: <4a1de64c-4be8-450d-9f12-e8ec9ac42778@kylinos.cn>
Date: Wed, 1 May 2024 15:43:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] PM: hibernate: add retry mechanism for S4 image
 loading failures
To: Pavel Machek <pavel@ucw.cz>, Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240501061258.2874092-1-luoxueqin@kylinos.cn>
 <ZjHgLlAC3ArqFLH0@ucw.cz>
Content-Language: en-US
From: xiongxin <xiongxin@kylinos.cn>
In-Reply-To: <ZjHgLlAC3ArqFLH0@ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/1 14:24, Pavel Machek wrote:
>> During the S4 resume process, there's a rare chance of image loading
>> failure. We provide three retries to load it successfully. If the
>> recovery fails after these attempts, print out the handle CRC32
>> value. When the CRC32 value obtained on each retry are inconsistent,
>> there may be a memory anomaly. When the values are consistent, it
>> might indicate corrupted swapped memory data.
>>
>> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> 
> NAK. If machine is so broken it can't load memory image, it is not
> safe to  continue.
> 
> 								Pavel

Through a large number of tests, we found that when the CRC32 check 
fails, the retry mechanism may make Image loading successful again. Even 
if the final loading attempt fails, we can quickly analyze this anomaly 
by examining the CRC32 values. If the CRC32 values from three attempts 
are inconsistent, it may indicate a memory leakage issue; if they are 
consistent, it may suggest changes in data within the disk.

>> ---
>>   kernel/power/hibernate.c |  8 ++++++++
>>   kernel/power/swap.c      | 14 ++++++++------
>>   2 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index 43b1a82e800c..d9bcf38221ef 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -703,6 +703,7 @@ static int load_image_and_restore(void)
>>   {
>>   	int error;
>>   	unsigned int flags;
>> +	int cnt = 0;
>>   
>>   	pm_pr_dbg("Loading hibernation image.\n");
>>   
>> @@ -713,7 +714,14 @@ static int load_image_and_restore(void)
>>   		goto Unlock;
>>   	}
>>   
>> +retry:
>>   	error = swsusp_read(&flags);
>> +	if (error && (cnt++ < 3)) {
>> +		pr_err("Failed to load hibernation image, trying to load again...\n");
>> +		swsusp_free();
>> +		goto retry;
>> +	}
>> +
>>   	swsusp_close();
>>   	if (!error)
>>   		error = hibernation_restore(flags & SF_PLATFORM_MODE);
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index 5bc04bfe2db1..4b866c645cd7 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -1489,15 +1489,17 @@ static int load_compressed_image(struct swap_map_handle *handle,
>>   		ret = snapshot_write_finalize(snapshot);
>>   		if (!ret && !snapshot_image_loaded(snapshot))
>>   			ret = -ENODATA;
>> -		if (!ret) {
>> -			if (swsusp_header->flags & SF_CRC32_MODE) {
>> -				if(handle->crc32 != swsusp_header->crc32) {
>> -					pr_err("Invalid image CRC32!\n");
>> -					ret = -ENODATA;
>> -				}
>> +	}
>> +	if (!ret) {
>> +		if (swsusp_header->flags & SF_CRC32_MODE) {
>> +			if (handle->crc32 != swsusp_header->crc32) {
>> +				pr_err("Invalid image CRC32, swsusp header CRC32: %u, handle CRC32: %u\n",
>> +					 swsusp_header->crc32, handle->crc32);
>> +				ret = -ENODATA;
>>   			}
>>   		}
>>   	}
>> +
>>   	swsusp_show_speed(start, stop, nr_to_read, "Read");
>>   out_clean:
>>   	hib_finish_batch(&hb);
>> 2.25.1


