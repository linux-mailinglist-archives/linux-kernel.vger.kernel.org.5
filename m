Return-Path: <linux-kernel+bounces-11079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE281E112
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D73FB21624
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD48524BD;
	Mon, 25 Dec 2023 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Dvikz7Gr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c04IoSZA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8D524B8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id D59C73200564;
	Mon, 25 Dec 2023 09:02:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 Dec 2023 09:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703512959;
	 x=1703599359; bh=IQZdaZOFgePlDjDkaWM55EFDy1RVICtiSZWQjTh1img=; b=
	Dvikz7Gr03DS87u4hqdUPf/K4YOgFuuoMzXZqBXsSO6C+eQNaVpmjpVEhOnvY83a
	tdfgsOB9teO4PjmLHpI43tjWRkzKvJqnVYGjOWxPTRhhc2T7vbN2GxuriLe7hwB5
	vjFwrzohtoOxWvcv5IGpqdFMcdXMFUUGmpcok8yQqNN5IZSjnqywmVGBB5AjuRi4
	4lDjB/MnfgiFE+gCwolmY6T6CeDpBy4O7egb3kl+KStOY25UIP8UPXuBXmgp6MCr
	ioDKIlG5AI+AaDIc6fXVIUpr0E+Mc0nNzrD7rF/PSgyIFFnLya0ARk5l/eu3CBca
	lgVfcI6qeXpOL2/TYxN56A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703512959; x=
	1703599359; bh=IQZdaZOFgePlDjDkaWM55EFDy1RVICtiSZWQjTh1img=; b=c
	04IoSZAueFjR/JRmMXgav+CBczXPe9E7+o9pmmuM8W2Oif75LXR4uYzsZ/iuGVSO
	797rU5QfSGVztOt3aRjWMawf0ZirXh10ZripDThyZpIbr4KCFkFGeXg86pDuXb12
	+UG4MS9ZXIyYp9IGSjY/MtFWTd9/cAGcGQzXLRBvAOWvq5ChtHjSeLOtJbyodRnH
	YO51xRZHu8mOb1DqSK0TGvAVgQic5rzOkjtnlzdkPT70i2Vwo1g5vXgluKkgG/83
	DJvoPYzy9rz6/yyFIHtU1w7Bf8+qzEipbVLdFZWrxJ4daEJ13JuaNsa0FewJBGII
	xkQvkIxNY7kXUGtbdtoSQ==
X-ME-Sender: <xms:fYuJZeotky7UhyIgGYyEXpIkp6ATicFNKC0rjvXekFAzfPCA5IU89g>
    <xme:fYuJZcrkmJdFqbTI2h70KIntiG-wwMBPDjTva4IYpSayJBLZcbe3vCR6HLWNj9oq-
    zyyn8bC0FdKjiE84Yk>
X-ME-Received: <xmr:fYuJZTM-P_d7saXq4up5AM-D-btpbgUUldhtxzPAaBM8AURGJqWI1I5H2lRymy_odhXYyAu7brehYp2luAOnpMJ_OETmQ4o5OuCndfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddvfedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:fouJZd65tu3n6QHJ1FDLfxi8k3hvCvE2Exq82ZV9AZRF6Of6hARUAA>
    <xmx:fouJZd5btnqSsgvdxwWgJm5x0wWhCiZprul7UsQ_og2u97yQGlMGHA>
    <xmx:fouJZdgtvcvRnvArcmxyQfly_ft7S9wnKkP2MOLSai6E-xXmVZqiKg>
    <xmx:f4uJZYY1jQ04Tctaz9IBqWF3yo1nRQxBV30RAI6zKNtdZb1wrzKToQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Dec 2023 09:02:36 -0500 (EST)
Message-ID: <b239bfee-73a7-495d-b094-bdfa31c1500e@flygoat.com>
Date: Mon, 25 Dec 2023 14:02:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: Let cores_io_master cover the largest NR_CPUS
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>, maobibo <maobibo@loongson.cn>
Cc: loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
 Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
 Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20231225070002.1350705-1-chenhuacai@loongson.cn>
 <3db5c086-db9b-cb3a-5521-44f18cb55c4a@loongson.cn>
 <CAAhV-H5Rs4BGKHZrA5bxSh0=4uhPx7vbVwBXtdtfU4hemN2QjA@mail.gmail.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAAhV-H5Rs4BGKHZrA5bxSh0=4uhPx7vbVwBXtdtfU4hemN2QjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/25 09:19, Huacai Chen 写道:
> On Mon, Dec 25, 2023 at 5:13 PM maobibo <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2023/12/25 下午3:00, Huacai Chen wrote:
>>> Now loongson_system_configuration::cores_io_master only covers 64 cpus,
>>> if NR_CPUS > 64 there will be memory corruption. So let cores_io_master
>>> cover the largest NR_CPUS (256).
>>>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>    arch/loongarch/include/asm/bootinfo.h | 4 ++--
>>>    arch/loongarch/kernel/acpi.c          | 2 +-
>>>    arch/loongarch/kernel/smp.c           | 2 +-
>>>    3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
>>> index c60796869b2b..32fd0319594a 100644
>>> --- a/arch/loongarch/include/asm/bootinfo.h
>>> +++ b/arch/loongarch/include/asm/bootinfo.h
>>> @@ -30,7 +30,7 @@ struct loongson_system_configuration {
>>>        int boot_cpu_id;
>>>        int cores_per_node;
>>>        int cores_per_package;
>>> -     unsigned long cores_io_master;
>>> +     unsigned long cores_io_master[4];
>> Can the hardcoded 4 be defined something like this?
>>      DIV_ROUND_UP(CONFIG_NR_CPUS, sizeof(long))
> Can this be used to define arrays?

I think DECLARE_BITMAP should work.

See how are we dealing with cpumask_t:
```
typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
```

Thanks
- Jiaxun
[...]

> 
> Huacai

