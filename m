Return-Path: <linux-kernel+bounces-29655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCD083115E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8182F1F24A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179D63B5;
	Thu, 18 Jan 2024 02:22:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0034612E;
	Thu, 18 Jan 2024 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544541; cv=none; b=Oy7v4VJ3bjMN4DYDY45HNqWzbQnrWzWZlzyoK8BWxC3EWJKI4DEVIAT2Hsr5l5mq4tB4viue5NoH+5xW7Drp9jj9tsIjJNFvQCNx/uuxu8LYXGr0qvLaRAWO99ckGNsNRZ0HBMe7cM3KjNApUR2+ChHucZ6x7i0v2qBRaUDMRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544541; c=relaxed/simple;
	bh=8JHXmYF/SbfhncSbdmAV1mZFnmszoqM2xbG/FA913qo=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=mRLDG4VmpPBA1OndezO0AKKY1g/OymkVN6ncycnXmza1TnjATUmJdRfrTaOjWgUk1ra0dof3fdsUle4+vZMFeOqycumLpiywn76EQRfV8sCbWOpY8x+Z3bk3gRo9CRhXXee2cYRt13hH385LIVobJPU7ft+wvWapGf6wAwJLC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 357999929ba04da58da2de338c6a80bb-20240118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f9c5ad19-ce8d-4590-8d0f-425d94764a99,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:f9c5ad19-ce8d-4590-8d0f-425d94764a99,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:b26a5f8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240117171645NSDDJDUY,BulkQuantity:12,Recheck:0,SF:64|66|24|17|19|44|
	102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_OBB,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: 357999929ba04da58da2de338c6a80bb-20240118
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2100225134; Thu, 18 Jan 2024 10:22:10 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1773FE000EB9;
	Thu, 18 Jan 2024 10:22:10 +0800 (CST)
X-ns-mid: postfix-65A88B51-553218459
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 035EEE000EB9;
	Thu, 18 Jan 2024 10:22:05 +0800 (CST)
Message-ID: <ba5b4e70-365f-476a-9969-6f9a891221a7@kylinos.cn>
Date: Thu, 18 Jan 2024 10:22:05 +0800
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
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20240117092928.GA618956@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

Thanks for your reply.

On 2024/1/17 17:29, Simon Horman wrote:
> On Wed, Jan 17, 2024 at 03:20:45PM +0800, Kunwu Chan wrote:
>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>> to simplify the creation of SLAB caches.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> Hi Kunwu Chan,
> 
> I think this is more of a cleanup than a fix,
> so it should probably be targeted at 'nf-next' rather than 'net'.
Thanks, I'm confused about when to use "nf-next" or "net" or "net-next".
"nf-next" means fixing errors for linux-next.git and linux-stable.git, 
while "nf" or "next" just means linux-next.git?

> 
> If it is a fix, then I would suggest targeting it at 'nf'
> and providing a Fixes tag.
I'll keep it in mind in the future.
> 
> The above notwithstanding, this looks good to me.
> 
> Acked-by: Simon Horman <horms@kernel.org>
> 
>> ---
>>   net/netfilter/ipvs/ip_vs_conn.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
>> index a743db073887..98d7dbe3d787 100644
>> --- a/net/netfilter/ipvs/ip_vs_conn.c
>> +++ b/net/netfilter/ipvs/ip_vs_conn.c
>> @@ -1511,9 +1511,7 @@ int __init ip_vs_conn_init(void)
>>   		return -ENOMEM;
>>   
>>   	/* Allocate ip_vs_conn slab cache */
>> -	ip_vs_conn_cachep = kmem_cache_create("ip_vs_conn",
>> -					      sizeof(struct ip_vs_conn), 0,
>> -					      SLAB_HWCACHE_ALIGN, NULL);
>> +	ip_vs_conn_cachep = KMEM_CACHE(ip_vs_conn, SLAB_HWCACHE_ALIGN);
>>   	if (!ip_vs_conn_cachep) {
>>   		kvfree(ip_vs_conn_tab);
>>   		return -ENOMEM;
-- 
Thanks,
   Kunwu


