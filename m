Return-Path: <linux-kernel+bounces-32429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20953835BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFE91F22985
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E017739;
	Mon, 22 Jan 2024 07:35:52 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3EDFBE1;
	Mon, 22 Jan 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908951; cv=none; b=pHciYUmO6k8qxhnBkVZ7w6GlM6P6o5iMbGRv2Sis6PHTeMHwRPf9C5rTsh/h8Ykee6KRGetGSms08WAz5YFhxSmFb855cLWjWAJmVcHdYiAsYdx0YZbtuoaPD+l1o8yCVMiLU1u8Uvn5f9F8S32bT/UjBPw/glUof2Q4IA81E48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908951; c=relaxed/simple;
	bh=a84Ae00L5X+yF+jz93N/QgllxGAF2cgD93WBqZxUQnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW10TVcIURohqx0bQ/7rHrNYFQAJtJUqYCvOAsl2stf/CPvb0akMTZGBAAJJMUvwFAumovSfF+NZphS/s+bS5/+WJU7mET2YxifqrUfys/5/4eOkqeGxd0OPlj3ux4Ix7tPk8mvyBWZYfqmdEceEZ7Edyfz7V54K9j6RbyGWnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 89f05498b4a1435a833053f4f2fd8887-20240122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f3d5e596-f7c8-4dbd-b751-633a1d132f37,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:f3d5e596-f7c8-4dbd-b751-633a1d132f37,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:af3d1c83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240119232059I7ZFFJYE,BulkQuantity:6,Recheck:0,SF:44|64|66|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
	TF_CID_SPAM_FSD
X-UUID: 89f05498b4a1435a833053f4f2fd8887-20240122
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1749565469; Mon, 22 Jan 2024 15:35:30 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E9923E000EB9;
	Mon, 22 Jan 2024 15:35:29 +0800 (CST)
X-ns-mid: postfix-65AE1AC1-869568164
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 810BFE000EB9;
	Mon, 22 Jan 2024 15:35:23 +0800 (CST)
Message-ID: <cf3668f1-cf86-49ff-83f4-47ed8a039d0d@kylinos.cn>
Date: Mon, 22 Jan 2024 15:35:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipvs: Simplify the allocation of ip_vs_conn slab
 caches
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kernel@vger.kernel.org
References: <20240117072045.142215-1-chentao@kylinos.cn>
 <20240117092928.GA618956@kernel.org>
 <ba5b4e70-365f-476a-9969-6f9a891221a7@kylinos.cn>
 <20240119152039.GC89683@kernel.org>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20240119152039.GC89683@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/19 23:20, Simon Horman wrote:
> On Thu, Jan 18, 2024 at 10:22:05AM +0800, Kunwu Chan wrote:
>> Hi Simon,
>>
>> Thanks for your reply.
>>
>> On 2024/1/17 17:29, Simon Horman wrote:
>>> On Wed, Jan 17, 2024 at 03:20:45PM +0800, Kunwu Chan wrote:
>>>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>>>> to simplify the creation of SLAB caches.
>>>>
>>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>>
>>> Hi Kunwu Chan,
>>>
>>> I think this is more of a cleanup than a fix,
>>> so it should probably be targeted at 'nf-next' rather than 'net'.
>> Thanks, I'm confused about when to use "nf-next" or "net" or "net-next".
>> "nf-next" means fixing errors for linux-next.git and linux-stable.git, while
>> "nf" or "next" just means linux-next.git?
> 
> Hi Kunwu,
> 
> nf is for fixes for Netfilter (which includes IPVS). The target tree is nf.git
> nf-next is for non-fixes for Netfilter. The target tree if nf-next.git
> 
> net is for fixes for Networking code, which does not have a more specific
> tree (as is the case for Netfilter). The target tree is net.git.
> Liikewise, net-next is for non-fixes for Networking code.
> The target tree is net-next.git
> 
Hi Simon,

Thank you very much for your detailed guidance.
In the future, I will carefully follow the rules you introduced to set 
the appropriate subject for the patch.


> The MAINTAINERS file, and get_maintainers.pl script are useful here.
> 
> nf is merged into net on request from the Netfilter maintainers,
> this is it's path to released kernels.
> Likewise, nf-next is merged into net-next.
> 
Before send the patch, I'll read the MAINTAINERS file, and search in 
email-list to confirm the correct subject.

And if need a new subject patch, i could resend a new one.
>>
>>>
>>> If it is a fix, then I would suggest targeting it at 'nf'
>>> and providing a Fixes tag.
>> I'll keep it in mind in the future.
>>>
>>> The above notwithstanding, this looks good to me.
>>>
>>> Acked-by: Simon Horman <horms@kernel.org>
>>>
>>>> ---
>>>>    net/netfilter/ipvs/ip_vs_conn.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
>>>> index a743db073887..98d7dbe3d787 100644
>>>> --- a/net/netfilter/ipvs/ip_vs_conn.c
>>>> +++ b/net/netfilter/ipvs/ip_vs_conn.c
>>>> @@ -1511,9 +1511,7 @@ int __init ip_vs_conn_init(void)
>>>>    		return -ENOMEM;
>>>>    	/* Allocate ip_vs_conn slab cache */
>>>> -	ip_vs_conn_cachep = kmem_cache_create("ip_vs_conn",
>>>> -					      sizeof(struct ip_vs_conn), 0,
>>>> -					      SLAB_HWCACHE_ALIGN, NULL);
>>>> +	ip_vs_conn_cachep = KMEM_CACHE(ip_vs_conn, SLAB_HWCACHE_ALIGN);
>>>>    	if (!ip_vs_conn_cachep) {
>>>>    		kvfree(ip_vs_conn_tab);
>>>>    		return -ENOMEM;
>> -- 
>> Thanks,
>>    Kunwu
>>
-- 
Thanks,
   Kunwu


