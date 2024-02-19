Return-Path: <linux-kernel+bounces-71008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98C859F52
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D1AB2144F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B922EF0;
	Mon, 19 Feb 2024 09:09:45 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCE23753;
	Mon, 19 Feb 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333784; cv=none; b=l+M2eTMRpoJABbbHtSJ1NmqvxU0em0wg3ouepJqLKTCu5GGbMnHmTssGUxcmA7JEyubMMiP+SrLNNed1D7SPVq7Q5vJ8RaL+ASP6aFZyuYvVKfeCmTZBaH4FGPqPMPvg0WKeWKvwnOyABvePEmx7T4WQKkYHr7kybmQlY5Fr3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333784; c=relaxed/simple;
	bh=8GO7HUAvD6Rrp0yzSI3zo5R0DXtbIZ6zr38RYo10f1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egh+fAufxMDEuohRsxh6pkKev+DVTmpFPcyISgiCsm3rWiy1QGocnh5NqY8qDNzCZGF+3NNdozk6R5bnkBKpOonnkwFrAoJ+VP+XJW3BnzafjaQ5l9o9XFI8FmW2J4qT2rtA/RJ09cUI+xqS30rkokiBP1o2R09Q29OU8abV35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f3635d9b7d664e5fb2f8dfac401f0a01-20240219
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b6738b5c-76ff-4ee4-b042-5681fba20d15,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:b6738b5c-76ff-4ee4-b042-5681fba20d15,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:0bf78d80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240219170936VZ9O9Y0O,BulkQuantity:0,Recheck:0,SF:64|66|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: f3635d9b7d664e5fb2f8dfac401f0a01-20240219
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 632622634; Mon, 19 Feb 2024 17:09:32 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B4D1AE000EBC;
	Mon, 19 Feb 2024 17:09:32 +0800 (CST)
X-ns-mid: postfix-65D31ACC-659055207
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 11B54E000EBC;
	Mon, 19 Feb 2024 17:09:31 +0800 (CST)
Message-ID: <c7e92fee-42a0-43c3-8fab-cb0b3ab305ac@kylinos.cn>
Date: Mon, 19 Feb 2024 17:09:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] tcp: Simplify the allocation of slab caches
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240205072013.427639-1-chentao@kylinos.cn>
 <20240205072013.427639-6-chentao@kylinos.cn>
 <CANn89iLkWvum6wSqSya_K+1eqnFvp=L2WLW=kAYrZTF8Ei4b7g@mail.gmail.com>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <CANn89iLkWvum6wSqSya_K+1eqnFvp=L2WLW=kAYrZTF8Ei4b7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Thanks for your reply.
On 2024/2/5 20:29, Eric Dumazet wrote:
> On Mon, Feb 5, 2024 at 8:23=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> =
wrote:
>>
>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>> to simplify the creation of SLAB caches.
>> And change cache name from 'tcp_bind_bucket' to 'inet_bind_bucket',
>> 'tcp_bind2_bucket' to 'inet_bind2_bucket'.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   net/ipv4/tcp.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index a1c6de385cce..2dc3dd4323c2 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -4697,17 +4697,11 @@ void __init tcp_init(void)
>>                              thash_entries, 21,  /* one slot per 2 MB*=
/
>>                              0, 64 * 1024);
>>          tcp_hashinfo.bind_bucket_cachep =3D
>> -               kmem_cache_create("tcp_bind_bucket",
>> -                                 sizeof(struct inet_bind_bucket), 0,
>> -                                 SLAB_HWCACHE_ALIGN | SLAB_PANIC |
>> -                                 SLAB_ACCOUNT,
>> -                                 NULL);
>> +               KMEM_CACHE(inet_bind_bucket,
>> +                          SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCO=
UNT);
>=20
> I would prefer we do not do this.
>=20
> dccp is also using a kmem_cache_create() of "struct inet_bind_bucket"
When i do my work, i found this too, so i just change the cache name in t=
cp.
>=20
> We want different caches for TCP and DCCP.
For distinguishment, I'll delete this patch in next patch series.
>=20
>=20
>>          tcp_hashinfo.bind2_bucket_cachep =3D
>> -               kmem_cache_create("tcp_bind2_bucket",
>> -                                 sizeof(struct inet_bind2_bucket), 0,
>> -                                 SLAB_HWCACHE_ALIGN | SLAB_PANIC |
>> -                                 SLAB_ACCOUNT,
>> -                                 NULL);
>> +               KMEM_CACHE(inet_bind2_bucket,
>> +                          SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCO=
UNT);
>=20
> Same here.
>=20
>>
>>          /* Size and allocate the main established and bind bucket
>>           * hash tables.
>> --
>> 2.39.2
>>
--=20
Thanks,
   Kunwu


