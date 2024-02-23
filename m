Return-Path: <linux-kernel+bounces-77687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01F860904
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88137B2231E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC49BE6F;
	Fri, 23 Feb 2024 02:49:38 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB255BE5A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656578; cv=none; b=DyxcwKsIZxSyOX5xTzv60bexL72XiEjgNWdj/7a+ybjue3xWFYEc3mdI+IfhATEi7chA7dw5L2IGOBxniw0ezqf36B+rZEKDrZ9AFoQywvAdCnjR8sAXmXZqJjxYKiQXSF5J23GpZMlf24KuUaqifMc+DURzrjiakYdsJCcse38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656578; c=relaxed/simple;
	bh=rj5hTq2WHlfjTG+RwYUPSI1SBkn0r4c9eeKYJmFU0Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRcq5T9AGd5ul4CqIeP5IBL/ojpAnP55gb19fcfzhRUCDOmV+Bevq8p+6NtubYkqWDDtLMN95izgIm/zFrXkjnh87BmH7FoUTST7/ARIRm37mvkADgYKgogheY3ApNAVZq8HnJcl9ZGbpFQsLWa+C2A3M4AfbUrHGU6qmvGdEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d198ab4fbfd47d48e982bd5655292c3-20240223
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:306954c1-e5c0-4378-ac73-9f44b39fe19f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:306954c1-e5c0-4378-ac73-9f44b39fe19f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:6df61bff-c16b-4159-a099-3b9d0558e447,B
	ulkID:24022208111331ZIVHI4,BulkQuantity:15,Recheck:0,SF:64|66|24|17|19|44|
	102,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_OBB,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 5d198ab4fbfd47d48e982bd5655292c3-20240223
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 71774859; Fri, 23 Feb 2024 10:49:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 80CC8E000EBC;
	Fri, 23 Feb 2024 10:49:20 +0800 (CST)
X-ns-mid: postfix-65D807B0-444377309
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 83939E000EBC;
	Fri, 23 Feb 2024 10:49:19 +0800 (CST)
Message-ID: <780c9c19-41ca-47f2-bf32-ea09c046988f@kylinos.cn>
Date: Fri, 23 Feb 2024 10:49:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cred: Use KMEM_CACHE instead of kmem_cache_create
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: axboe@kernel.dk, elena.reshetova@intel.com, linux-kernel@vger.kernel.org
References: <20240130094037.76895-1-chentao@kylinos.cn>
 <CAHC9VhQG6XAm3R3wtgFrb0b0UHoxkSV2yziVAnUy2x7Ovun_pQ@mail.gmail.com>
 <CAHC9VhRLNHT0ar2YPkZBsyha_mh6Ggf6=V2gnbFkdo7ryXmHnQ@mail.gmail.com>
 <0f51c6ba-a6c0-4fbf-9b00-21cea6d59ca9@kylinos.cn>
 <CAHC9VhTJXfPztz2W_V6sp41PJW8dzvZH0YdnRXd7tUZOF1Q09Q@mail.gmail.com>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <CAHC9VhTJXfPztz2W_V6sp41PJW8dzvZH0YdnRXd7tUZOF1Q09Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2024/2/23 01:48, Paul Moore wrote:
> On Wed, Feb 21, 2024 at 10:06=E2=80=AFPM Kunwu Chan <chentao@kylinos.cn=
> wrote:
>> Thanks for your reply.
>> On 2024/2/22 08:10, Paul Moore wrote:
>>> On Thu, Feb 15, 2024 at 10:54=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
>>>> On Tue, Jan 30, 2024 at 4:40=E2=80=AFAM Kunwu Chan <chentao@kylinos.=
cn> wrote:
>>>>>
>>>>> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>>>>> introduces a new macro.
>>>>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>>>>> to simplify the creation of SLAB caches.
>>>>>
>>>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>>>> ---
>>>>>    kernel/cred.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> This seems reasonable to me, unless I see any objections I can pull
>>>> this via the LSM tree next week.
>>>
>>> Actually, never mind, the original posting has some non-ASCII junk in
>>> the patch and I'm not able to import it cleanly.
>> Thanks for reply.
>>
>> I checked the patch with the checkpatch.pl script and applied it to
>> another machine to compile and found no issues.
>> Seems ok to me, what should I do next to clean up that non-ASCII junk.
>>
>> And i use :perl -ne 'print if /[^[:ascii:]]/'
>> 0001-cred-Use-KMEM_CACHE-instead-of-kmem_cache_create.patch seems ok t=
oo.
>=20
> Look at the message when in the mailing list archive (link below) and
> you'll notice the extra characters:
> https://lore.kernel.org/all/20240130094037.76895-1-chentao@kylinos.cn/r=
aw
Thanks for your reply. I'll try to figure out what happened and resend a=20
new one.
>=20
> ... and then look at a correctly submitted patch:
> https://lore.kernel.org/all/20240126104403.1040692-1-omosnace@redhat.co=
m/raw
>=20
--=20
Thanks,
   Kunwu


