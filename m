Return-Path: <linux-kernel+bounces-49611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA820846CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620A51F2758F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8BE7A70E;
	Fri,  2 Feb 2024 09:46:56 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768087762B;
	Fri,  2 Feb 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867215; cv=none; b=DZwNbMd+4QwsuefRBXH+xjA/koBVdr/oHXfmwjm2qskwOBkHnkX6nvvdPQCVSi/mXeWlGORQ8wODwjT4Q1ofF2Vtq+bmjTjrrCB7U0RqoN/b3wfcfNeY1Z5tT02ZqtjflqASY2j2oARbJBe3EDx0p0IMMfbhxmLJCUUJFJ823NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867215; c=relaxed/simple;
	bh=WNz1nXGRiJEtTEPFc3N/58Kj62b4hXYnhcOMWc6UIP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URKwLRv314h/p2rx9fqNJcqhf4RjmDD0us3SUn2c7BO4y1RQREAjVsKtUrx05Vp/i7DQ3q0g1XmsZYfKIzpawGzlOfHwd7/+VCXJ+tWzTnR9w1a1nSngdlyrdtzWH71qSdnt7I/XAtRFAdP/wofIPcFKLO/tBJLQrqfjgiVl998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 068a9a6a435c4571865aa591ef64006d-20240202
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:98750a05-eb2c-4d51-baa9-8ecba345d77b,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:98750a05-eb2c-4d51-baa9-8ecba345d77b,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:e68c8c83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240201204745Y4HHVX4X,BulkQuantity:6,Recheck:0,SF:17|19|44|64|66|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 068a9a6a435c4571865aa591ef64006d-20240202
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1085833606; Fri, 02 Feb 2024 17:46:38 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 56DB2E000EBC;
	Fri,  2 Feb 2024 17:46:38 +0800 (CST)
X-ns-mid: postfix-65BCB9FE-2849541295
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3B86BE000EBC;
	Fri,  2 Feb 2024 17:46:33 +0800 (CST)
Message-ID: <961cc4ad-0133-44ee-be22-ba2fbf4ebe12@kylinos.cn>
Date: Fri, 2 Feb 2024 17:46:33 +0800
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
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <1706866812511330.14.seg@mailgw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/1 20:47, Jiri Pirko wrote:
> Thu, Feb 01, 2024 at 11:09:24AM CET, chentao@kylinos.cn wrote:
>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>> to simplify the creation of SLAB caches.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> btw, why don't you bulk these changes into patchsets of 15 patches? Or,
> given the low complexicity of the patch, just merge multiple patches
> that are changing similar locations togeter.
Sorry, I haven't sent a patchset, I'm worried about messing up.
I'll try to deal with these similar issues in the way you recommended in 
the future, thank you for the reminder.
-- 
Thanks,
   Kunwu


