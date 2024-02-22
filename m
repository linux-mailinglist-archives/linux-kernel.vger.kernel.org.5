Return-Path: <linux-kernel+bounces-75832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A485EFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B231C21D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632217C71;
	Thu, 22 Feb 2024 03:05:11 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7D1799F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571111; cv=none; b=lnWF/wPHyA21MbrJEY+sSsIDr3LMVswwABgdPwNp5l+ztiIvgAHe5AXOq3a65hgyQxug+sCWuCcn/aD6yzhuErz6I8YFK/JUJkS8VAWt+v5hLWMpb6ZM/EwElC62z0yVb0qMCVwstddsH10Dw5/m/gqpQm1B0p7BxIOF2hTO7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571111; c=relaxed/simple;
	bh=VMRkbLEjqUTkcPnLk3R6EX0JT8iU2w6INN6blLRwMh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbiDrF4ODRLfPnuM90L0a3iL21QhUSJNkHw+my6/8IqyiQ8Upx4u7/+m5SQnWVV2RYWUPSqAdbM2ZgeXFYl13gpBa/lJ6WcvrQ4Cpt4oXNDVDiOVZ4Bg9oZlSnYFXMKkLGq1ABy2woznMHTH3GufDJWWpDHfouGMZFMQ6et3RNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dec48d24f8744cd390939199d634908f-20240222
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:2a7a28f5-87e9-4e39-82bc-737083c6beef,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:2a7a28f5-87e9-4e39-82bc-737083c6beef,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:65d82b84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:24022208111331ZIVHI4,BulkQuantity:5,Recheck:0,SF:64|66|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,
	TF_CID_SPAM_SNR
X-UUID: dec48d24f8744cd390939199d634908f-20240222
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 204878516; Thu, 22 Feb 2024 11:04:57 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A2911E000EBC;
	Thu, 22 Feb 2024 11:04:57 +0800 (CST)
X-ns-mid: postfix-65D6B9D9-567320297
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 72739E000EBC;
	Thu, 22 Feb 2024 11:04:56 +0800 (CST)
Message-ID: <0f51c6ba-a6c0-4fbf-9b00-21cea6d59ca9@kylinos.cn>
Date: Thu, 22 Feb 2024 11:04:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cred: Use KMEM_CACHE instead of kmem_cache_create
To: Paul Moore <paul@paul-moore.com>
Cc: axboe@kernel.dk, elena.reshetova@intel.com, linux-kernel@vger.kernel.org
References: <20240130094037.76895-1-chentao@kylinos.cn>
 <CAHC9VhQG6XAm3R3wtgFrb0b0UHoxkSV2yziVAnUy2x7Ovun_pQ@mail.gmail.com>
 <CAHC9VhRLNHT0ar2YPkZBsyha_mh6Ggf6=V2gnbFkdo7ryXmHnQ@mail.gmail.com>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <CAHC9VhRLNHT0ar2YPkZBsyha_mh6Ggf6=V2gnbFkdo7ryXmHnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Thanks for your reply.
On 2024/2/22 08:10, Paul Moore wrote:
> On Thu, Feb 15, 2024 at 10:54=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
>> On Tue, Jan 30, 2024 at 4:40=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn=
> wrote:
>>>
>>> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>>> introduces a new macro.
>>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>>> to simplify the creation of SLAB caches.
>>>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> ---
>>>   kernel/cred.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> This seems reasonable to me, unless I see any objections I can pull
>> this via the LSM tree next week.
>=20
> Actually, never mind, the original posting has some non-ASCII junk in
> the patch and I'm not able to import it cleanly.
Thanks for reply.

I checked the patch with the checkpatch.pl script and applied it to=20
another machine to compile and found no issues.
Seems ok to me, what should I do next to clean up that non-ASCII junk.

And i use :perl -ne 'print if /[^[:ascii:]]/'=20
0001-cred-Use-KMEM_CACHE-instead-of-kmem_cache_create.patch seems ok too.
>=20
--=20
Thanks,
   Kunwu


