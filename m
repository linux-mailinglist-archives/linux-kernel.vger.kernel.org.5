Return-Path: <linux-kernel+bounces-110075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693988859AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3224284CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0A084038;
	Thu, 21 Mar 2024 13:10:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348335474D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026642; cv=none; b=ry0AMmBzjV8eZSotIV433kA44KC2Tq7IyVoc3mZmZtLi4ZFmf1pCcfAgluNQnuKY6MIoXDJMOQICM3N+9cGyPab3vkbs87oq3q3Xg9wSOiV5b49TlJeGjJ79hs83TyrXpjUyd7khtrjMf2D+y3rpOax9HepaJwR9zuuIH4tkOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026642; c=relaxed/simple;
	bh=edFVQdVxNuhAxOV7EF0DZNjEUMjZjDEag/vGyZdRpRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o53dkwdx9MB5MYPl7MFs6z0YytIPROHjF7P6B9WhqVJzH9jQtq4vgauBi3ic7BtxU9wEVMebqmESX9dCIJ5vMzMX/V6xRRdQiKTtxYLnYqAoNQ/pQBS4yWQ0LJafP8T339CGp1Vh0Je2wb9ELb0U/4a8clJ177VRP79JVfhf6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V0m5L2c7KzbdSk;
	Thu, 21 Mar 2024 21:09:42 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C620140FEA;
	Thu, 21 Mar 2024 21:10:31 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 21:10:31 +0800
Message-ID: <73ddccdf-9e4a-9fbd-893a-ab95a62fad44@huawei.com>
Date: Thu, 21 Mar 2024 21:10:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm/slub: remove dummy slabinfo functions
Content-Language: en-US
To: "Song, Xiongwei" <Xiongwei.Song@windriver.com>, Xiu Jianfeng
	<xiujianfeng@huaweicloud.com>, "cl@linux.com" <cl@linux.com>,
	"penberg@kernel.org" <penberg@kernel.org>, "rientjes@google.com"
	<rientjes@google.com>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
	"42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240321084415.265643-1-xiujianfeng@huaweicloud.com>
 <PH0PR11MB51924AC8A58ABB22B8015296EC322@PH0PR11MB5192.namprd11.prod.outlook.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <PH0PR11MB51924AC8A58ABB22B8015296EC322@PH0PR11MB5192.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Hi,

On 2024/3/21 20:20, Song, Xiongwei wrote:
> 
> 
>> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>>
>> Slab has been removed since 6.5, so there is no other versions of
> 
> Removed since 6.8. The changes looks good.

Yes, thanks for correcting!

> 
> Regards,
> Xiongwei
> 
>> slabinfo_show_stats() and slabinfo_write(), then we can remove these
>> two dummy functions.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  mm/slab.h        |  3 ---
>>  mm/slab_common.c |  2 --
>>  mm/slub.c        | 10 ----------
>>  3 files changed, 15 deletions(-)
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index d2bc9b191222..78e205b46e19 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -496,9 +496,6 @@ struct slabinfo {
>>  };
>>
>>  void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo);
>> -void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s);
>> -ssize_t slabinfo_write(struct file *file, const char __user *buffer,
>> -                      size_t count, loff_t *ppos);
>>
>>  #ifdef CONFIG_SLUB_DEBUG
>>  #ifdef CONFIG_SLUB_DEBUG_ON
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index f5234672f03c..67c03d6bd26c 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1078,7 +1078,6 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
>>                    sinfo.limit, sinfo.batchcount, sinfo.shared);
>>         seq_printf(m, " : slabdata %6lu %6lu %6lu",
>>                    sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
>> -       slabinfo_show_stats(m, s);
>>         seq_putc(m, '\n');
>>  }
>>
>> @@ -1155,7 +1154,6 @@ static const struct proc_ops slabinfo_proc_ops = {
>>         .proc_flags     = PROC_ENTRY_PERMANENT,
>>         .proc_open      = slabinfo_open,
>>         .proc_read      = seq_read,
>> -       .proc_write     = slabinfo_write,
>>         .proc_lseek     = seq_lseek,
>>         .proc_release   = seq_release,
>>  };
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 1bb2a93cf7b6..cc7e68fbdbba 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -7099,14 +7099,4 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
>>         sinfo->objects_per_slab = oo_objects(s->oo);
>>         sinfo->cache_order = oo_order(s->oo);
>>  }
>> -
>> -void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s)
>> -{
>> -}
>> -
>> -ssize_t slabinfo_write(struct file *file, const char __user *buffer,
>> -                      size_t count, loff_t *ppos)
>> -{
>> -       return -EIO;
>> -}
>>  #endif /* CONFIG_SLUB_DEBUG */
>> --
>> 2.34.1
>>
> 

