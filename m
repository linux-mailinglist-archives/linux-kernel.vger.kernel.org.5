Return-Path: <linux-kernel+bounces-51387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D10848ABC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A911F235D7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF0B17F7;
	Sun,  4 Feb 2024 03:00:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB88BF9;
	Sun,  4 Feb 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015636; cv=none; b=n2sNlze4/irYNZv4Ne0Sdhii0YsHq8qBI5X9bY5jmbl/YiER4JDOqjy0A6bAfei4t9yOFZ+mmdpr/baQVxgLJrNpfkmyXqv1i44FNqGXGsYbj+fagGTE154cLvyclXjrKu5EjDU8p1dXXQo7TPDal7eKtvQiz0hEjS1EhozYPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015636; c=relaxed/simple;
	bh=dQ2sNktUa7lj6xnK2aY0LAZoG4fH5NYspNTxVsOhZiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsF5IIDAJ5gBacGBJEQhrM4N0OrkhbJoevNxABINPI2UAuZjitLVcheDS9pdtkJD//ydLCIhJEIZaqXjMvuEuNgSXvq9Gc//E99ihrb0nAnGbr4rtL5SN6jkU6/e8iBq29FqpTpb5ABqFTyRaEEyxZn6gkRWPKxKFf9FiiL8Ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 20d56d1a04a54032ba4b0001ffe4f5a8-20240204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:4b3fb53d-48eb-493c-8dd1-13e2a1d25624,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:4b3fb53d-48eb-493c-8dd1-13e2a1d25624,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:f6029783-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240201204745Y4HHVX4X,BulkQuantity:18,Recheck:0,SF:64|66|24|17|19|44|
	102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_OBB,
	TF_CID_SPAM_SNR
X-UUID: 20d56d1a04a54032ba4b0001ffe4f5a8-20240204
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1514006762; Sun, 04 Feb 2024 11:00:19 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4FEC5E000EBC;
	Sun,  4 Feb 2024 11:00:19 +0800 (CST)
X-ns-mid: postfix-65BEFDC3-240812241
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 37BC8E000EBC;
	Sun,  4 Feb 2024 11:00:14 +0800 (CST)
Message-ID: <e521e162-a749-4987-a040-024635fe52e4@kylinos.cn>
Date: Sun, 4 Feb 2024 11:00:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] rxrpc: Simplify the allocation of slab caches
To: Jiri Pirko <jiri@resnulli.us>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240201100924.210298-1-chentao@kylinos.cn>
 <1706866812511330.14.seg@mailgw>
 <961cc4ad-0133-44ee-be22-ba2fbf4ebe12@kylinos.cn>
 <ZbzD35e4pw5xfzLI@nanopsycho>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <ZbzD35e4pw5xfzLI@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/2 18:28, Jiri Pirko wrote:
> Fri, Feb 02, 2024 at 10:46:33AM CET, chentao@kylinos.cn wrote:
>> On 2024/2/1 20:47, Jiri Pirko wrote:
>>> Thu, Feb 01, 2024 at 11:09:24AM CET, chentao@kylinos.cn wrote:
>>>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>>>> to simplify the creation of SLAB caches.
>>>>
>>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>
>>> btw, why don't you bulk these changes into patchsets of 15 patches? Or,
>>> given the low complexicity of the patch, just merge multiple patches
>>> that are changing similar locations togeter.
>> Sorry, I haven't sent a patchset, I'm worried about messing up.
>> I'll try to deal with these similar issues in the way you recommended in the
>> future, thank you for the reminder.
> 
> Also, please fix your email client. It breaks threads.
Thanks for the reminder. Maybe it's my company email gateway that does 
something bad with email.
The last email was quarantined, this one is the same.
I asked the administrator to release it temporarily, and now it looks 
like there is still a problem with the gateway of my email.

I'll try to use a new email.

> 
>> -- 
>> Thanks,
>>   Kunwu
>>
-- 
Thanks,
   Kunwu


