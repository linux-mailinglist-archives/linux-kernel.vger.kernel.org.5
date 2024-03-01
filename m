Return-Path: <linux-kernel+bounces-87811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F5E86D954
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483D5B22264
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DA38F9A;
	Fri,  1 Mar 2024 02:03:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86E3224;
	Fri,  1 Mar 2024 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258589; cv=none; b=RECYbSxZZqUVsgDulGwNIUu0KU3YzOYxLyGwRHcB3tZT0qNFqqNFrUIHhezLLIXi9F8EXu9QGFxcUht1TzY1BXYrJx+1PPR7tm3bvgaCmyIQ7OCUZEi0vSaGzcAGvD9gcJ9+C5j5lz8WUfiKKO2jhwz+kWvLdx5HLxGVNRrFWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258589; c=relaxed/simple;
	bh=9Js/BcMOoQToMxLCHwtKbZX9jOWiO8pycTukIl3M724=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHXjI9KRx5xGyo06eoX1bsRzLAD3PBeE/QpF/DYakjxfTR8xn9DSU/4LnStfL7lX8Va1N7qj1KAYoHcquQGkktYhK/wftY956q/d+lz3tv7NSAN0kdr9CB8gCI/ieODZk8mHdkNMdaL6FgfMMhvenRIPrs3EtLf9O7iwBAEr0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d26e09735bf44176b9060d3fc684d0aa-20240301
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3258d14c-7d03-4d48-a8f2-f0347c4a35d0,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:3258d14c-7d03-4d48-a8f2-f0347c4a35d0,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:cdf07984-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240301000056BMI5A10U,BulkQuantity:8,Recheck:0,SF:64|66|38|24|17|19|4
	4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: d26e09735bf44176b9060d3fc684d0aa-20240301
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 625754827; Fri, 01 Mar 2024 10:02:57 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 57FFCE000EBC;
	Fri,  1 Mar 2024 10:02:57 +0800 (CST)
X-ns-mid: postfix-65E13751-261948242
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id C6881E000EBC;
	Fri,  1 Mar 2024 10:02:55 +0800 (CST)
Message-ID: <e7c115a1-a4cd-4fbd-ac54-2bd60a42dc87@kylinos.cn>
Date: Fri, 1 Mar 2024 10:02:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs: use KMEM_CACHE() to create xfs_defer_pending cache
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, kunwu.chan@linux.dev
Cc: chandan.babu@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229083342.1128686-1-kunwu.chan@linux.dev>
 <ZeEStFZwMu068YTc@dread.disaster.area>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <ZeEStFZwMu068YTc@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/1 07:26, Dave Chinner wrote:
> On Thu, Feb 29, 2024 at 04:33:42PM +0800, kunwu.chan@linux.dev wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>>
>> Use the KMEM_CACHE() macro instead of kmem_cache_create() to simplify
>> the creation of SLAB caches when the default values are used.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   fs/xfs/libxfs/xfs_defer.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
>> index 66a17910d021..6d957fcc17f2 100644
>> --- a/fs/xfs/libxfs/xfs_defer.c
>> +++ b/fs/xfs/libxfs/xfs_defer.c
>> @@ -1143,9 +1143,7 @@ xfs_defer_resources_rele(
>>   static inline int __init
>>   xfs_defer_init_cache(void)
>>   {
>> -	xfs_defer_pending_cache = kmem_cache_create("xfs_defer_pending",
>> -			sizeof(struct xfs_defer_pending),
>> -			0, 0, NULL);
>> +	xfs_defer_pending_cache = KMEM_CACHE(xfs_defer_pending, 0);
>>   
>>   	return xfs_defer_pending_cache != NULL ? 0 : -ENOMEM;
>>   }
> 
> Please stop wasting our time by trying to make changes that have
> already been rejected. I gave you good reasons last time for why we
> aren't going to make this change in XFS, and now you've forced
> Darrick to waste time repeating all those same reasons. You did not
> respond to my review comments last time, and now you are posting
> more patches that make the same rejected change.
> 
Sorry for the bother. It's my bad.That reply email was probably 
quarantined because of my mailbox server, and I just found it on the 
quarantine list.

I'll stop from doing this. Apologies again for my interruption.

> PLease listen to the feedback you are given. Indeed, please respond
> and acknowledge that you have read and understood the feedback you
> have been given, otherwise I'll consider anything from this email
> address as "just another annoying bot" and killfile it.
Thank you very much for your detailed reply and explanation, I just saw 
it, this patch is my problem, I forgot to check the previous mailing 
list at the time.
Sorry again for the bad mood I have caused you.
> 
> -Dave.
-- 
Thanks,
   Kunwu


