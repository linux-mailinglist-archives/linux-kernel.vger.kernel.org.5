Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD89179DD68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbjIMBKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIMBKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:10:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE05310F6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:10:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68e3c6aa339so1154844b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694567417; x=1695172217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eohFATvRETBvRjM1zaZLKbfO2pb4xmpUg9USI0k+7o=;
        b=N2LFuAxd0qlj1mIoWK0kN4DnQ6K9qhowUE3q2unlQ2H+QdjADwJXj0+Pg61sqEv4rI
         Iqaz3ZcqakCIP2IiekNnxh+D1b2PTTXlFVNo9q0FavqwMQ/AruZfUXtYiEv0CH/PC7G0
         54NjAW1eEd5ds9yCTjJFX7eBd1jQg94XMME75KL+zqLQthgJnsO96VjP5NsawWHFFGVk
         bdAHssFqx14+WTY/cI6AhgXUrPmAN4gQnulY7hLKQgrEU1BBxDmjVtUWfp+VOLQO8/ZK
         bqgSIw75zltIAdGEYm/MfkweN7Q+k7lpIVXlizWVgqgK6HZDB8ofn8YlsTP91bd6yF9S
         rN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694567417; x=1695172217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eohFATvRETBvRjM1zaZLKbfO2pb4xmpUg9USI0k+7o=;
        b=PhGPMn9a27FHdI6gCV3nAFr+YfAQ3OLlUK79jETqU+3Yc85pngu9yMTHSZ9xdvVKCa
         iHclCo/Lpi3z8jiRFqdieV+AFfio9GcylfL5Wdx9o5G833jAnJUJfC6RsmyUWRBnqnAt
         1w4m1fPe1XFgkl3O4xTxpzqhmFbwUh09rVZKEFhNUjPj+bD/SWhPk2NU41jnMBsHpSVk
         aFl0EP6RsYuCJrMC4I/HIoVUWT8pCA1vLEfyM+q09PQE7HcxJaWbN3k6HUNQbebWEZmD
         OhwQP5ctVrR2ZPr8e+/pOdYz4lBi5IkDpnBdHUuDRxC/Zt5DnzbqQxv8ZHCkWYlEmRcc
         mZgg==
X-Gm-Message-State: AOJu0YwnizRjJ7ICDwzAMlsHbbW0nGyy+iBP/sFyF3TQfnUhxMOCogpg
        8M0YdZgT/56UnDU6hRi2OLe4fw==
X-Google-Smtp-Source: AGHT+IE20gXr2nHuxsup4nD7Fg5WPeK0R7jsymLGc6sCi48rI7lU+3bvdlQyMVyV9Six3ws/KG17Zg==
X-Received: by 2002:a05:6a00:2da0:b0:68e:2bba:b5fe with SMTP id fb32-20020a056a002da000b0068e2bbab5femr1458412pfb.0.1694567417216;
        Tue, 12 Sep 2023 18:10:17 -0700 (PDT)
Received: from [10.84.155.178] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b006732786b5f1sm2743169pfn.213.2023.09.12.18.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 18:10:16 -0700 (PDT)
Message-ID: <ada473e9-aa2f-c6ff-b869-cf94942ddd20@bytedance.com>
Date:   Wed, 13 Sep 2023 09:10:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230912120429.7852428f@canb.auug.org.au>
 <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
 <20230913093553.4290421e@canb.auug.org.au>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230913093553.4290421e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2023/9/13 07:35, Stephen Rothwell wrote:
> Hi Qi,
> 
> Thanks for the corrections.  See below.
> 
> On Tue, 12 Sep 2023 10:47:14 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>> diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
>>> index 245ddd92b2d1..7f0eded6c296 100644
>>> --- a/fs/bcachefs/btree_cache.c
>>> +++ b/fs/bcachefs/btree_cache.c
>>> @@ -285,7 +285,7 @@ static int btree_node_write_and_reclaim(struct bch_fs *c, struct btree *b)
>>>    static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
>>>    					   struct shrink_control *sc)
>>>    {
>>> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
>>> +	struct bch_fs *c = container_of(&shrink, struct bch_fs,
>>>    					btree_cache.shrink);
>>
>> The shrink passed in here will be a local variable, so its address can
>> not be used directly. So need to be modified as follows:
>>
>> 	struct bch_fs *c = shrink->private_data;
> 
> OK.
> 
>>> @@ -384,7 +384,7 @@ static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
>>>    static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
>>>    					    struct shrink_control *sc)
>>>    {
>>> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
>>> +	struct bch_fs *c = container_of(&shrink, struct bch_fs,
>>>    					btree_cache.shrink);
>>
>> Ditto.
> 
> OK
> 
>>>    > @@ -473,12 +474,14 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
>>>    >   	mutex_init(&c->verify_lock);
>>>    > -	bc->shrink.count_objects	= bch2_btree_cache_count;
>>> -	bc->shrink.scan_objects		= bch2_btree_cache_scan;
>>> -	bc->shrink.seeks		= 4;
>>> -	ret = register_shrinker(&bc->shrink, "%s/btree_cache", c->name);
>>> -	if (ret)
>>> +	shrink = shrinker_alloc(0, "%s/btree_cache", c->name);
>>> +	if (!shrink)
>>>    		goto err;
>>
>> Here the 'ret' needs to be set to -ENOMEM.
>>
>> 	if (!shrink) {
>> 		ret = -ENOMEM;
>> 		goto err;
>> 	}
> 
> Except err: does this:
> 
>      return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> 
> so ret does not need to be set.
> 
>>> +	bc->shrink = shrink;
>>> +	shrink->count_objects	= bch2_btree_cache_count;
>>> +	shrink->scan_objects	= bch2_btree_cache_scan;
>>> +	shrink->seeks		= 4;
>>
>> 	shrink->private_data = c;
> 
> OK
> 
>>> diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
>>> index 505e7c365ab7..88d33690233b 100644
>>> --- a/fs/bcachefs/btree_key_cache.c
>>> +++ b/fs/bcachefs/btree_key_cache.c
>>> @@ -838,7 +838,7 @@ void bch2_btree_key_cache_drop(struct btree_trans *trans,
>>>    static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
>>>    					   struct shrink_control *sc)
>>>    {
>>> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
>>> +	struct bch_fs *c = container_of(&shrink, struct bch_fs,
>>>    					btree_key_cache.shrink);
>>
>> 	struct bch_fs *c = shrink->private_data;
>>
> 
> OK
> 
>>> @@ -936,7 +936,7 @@ static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
>>>    static unsigned long bch2_btree_key_cache_count(struct shrinker *shrink,
>>>    					    struct shrink_control *sc)
>>>    {
>>> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
>>> +	struct bch_fs *c = container_of(&shrink, struct bch_fs,
>>>    					btree_key_cache.shrink);
>>
>> Ditto.
> 
> OK
> 
>>> @@ -957,7 +957,7 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
>>>    	int cpu;
>>>    #endif
>>>    > -	unregister_shrinker(&bc->shrink);
>>> +	shrinker_free(bc->shrink);
>>>    >   	mutex_lock(&bc->lock);
>>>    > @@ -1031,6 +1031,7 @@ void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
>>>    int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
>>>    {
>>>    	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
>>> +	struct shrinker *shrink;
>>>    >   #ifdef __KERNEL__
>>>    	bc->pcpu_freed = alloc_percpu(struct btree_key_cache_freelist);
>>> @@ -1043,11 +1044,14 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
>>
>> 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
> 
> Already done n this function.
> 
>>>    >   	bc->table_init_done = true;
>>>    > -	bc->shrink.seeks		= 0;
>>> -	bc->shrink.count_objects	= bch2_btree_key_cache_count;
>>> -	bc->shrink.scan_objects		= bch2_btree_key_cache_scan;
>>> -	if (register_shrinker(&bc->shrink, "%s/btree_key_cache", c->name))
>>> +	shrink = shrinker_alloc(0, "%s/btree_key_cache", c->name);
>>> +	if (!shrink)
>>>    		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
>>> +	bc->shrink = shrink;
>>> +	shrink->seeks		= 0;
>>> +	shrink->count_objects	= bch2_btree_key_cache_count;
>>> +	shrink->scan_objects	= bch2_btree_key_cache_scan;
>>
>> 	shrink->private_data = c;
> 
> OK
> 
> So the merge resolution patch now looks like this:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 12 Sep 2023 11:27:22 +1000
> Subject: [PATCH] bcachefs: convert to dynamically allocated shrinkers
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   fs/bcachefs/btree_cache.c     | 22 ++++++++++++----------
>   fs/bcachefs/btree_key_cache.c | 21 ++++++++++++---------
>   fs/bcachefs/btree_types.h     |  4 ++--
>   fs/bcachefs/fs.c              |  2 +-
>   fs/bcachefs/sysfs.c           |  2 +-
>   5 files changed, 28 insertions(+), 23 deletions(-)

This version looks good to me.

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks,
Qi

> 
> diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
> index 245ddd92b2d1..d8cd0bbc33cc 100644
> --- a/fs/bcachefs/btree_cache.c
> +++ b/fs/bcachefs/btree_cache.c
> @@ -285,8 +285,7 @@ static int btree_node_write_and_reclaim(struct bch_fs *c, struct btree *b)
>   static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
>   					   struct shrink_control *sc)
>   {
> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
> -					btree_cache.shrink);
> +	struct bch_fs *c = shrink->private_data;
>   	struct btree_cache *bc = &c->btree_cache;
>   	struct btree *b, *t;
>   	unsigned long nr = sc->nr_to_scan;
> @@ -384,8 +383,7 @@ static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
>   static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
>   					    struct shrink_control *sc)
>   {
> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
> -					btree_cache.shrink);
> +	struct bch_fs *c = shrink->private_data;
>   	struct btree_cache *bc = &c->btree_cache;
>   
>   	if (bch2_btree_shrinker_disabled)
> @@ -400,7 +398,7 @@ void bch2_fs_btree_cache_exit(struct bch_fs *c)
>   	struct btree *b;
>   	unsigned i, flags;
>   
> -	unregister_shrinker(&bc->shrink);
> +	shrinker_free(bc->shrink);
>   
>   	/* vfree() can allocate memory: */
>   	flags = memalloc_nofs_save();
> @@ -454,6 +452,7 @@ void bch2_fs_btree_cache_exit(struct bch_fs *c)
>   int bch2_fs_btree_cache_init(struct bch_fs *c)
>   {
>   	struct btree_cache *bc = &c->btree_cache;
> +	struct shrinker *shrink;
>   	unsigned i;
>   	int ret = 0;
>   
> @@ -473,12 +472,15 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
>   
>   	mutex_init(&c->verify_lock);
>   
> -	bc->shrink.count_objects	= bch2_btree_cache_count;
> -	bc->shrink.scan_objects		= bch2_btree_cache_scan;
> -	bc->shrink.seeks		= 4;
> -	ret = register_shrinker(&bc->shrink, "%s/btree_cache", c->name);
> -	if (ret)
> +	shrink = shrinker_alloc(0, "%s/btree_cache", c->name);
> +	if (!shrink)
>   		goto err;
> +	bc->shrink = shrink;
> +	shrink->count_objects	= bch2_btree_cache_count;
> +	shrink->scan_objects	= bch2_btree_cache_scan;
> +	shrink->seeks		= 4;
> +	shrink->private_data	= c;
> +	shrinker_register(shrink);
>   
>   	return 0;
>   err:
> diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
> index 505e7c365ab7..ed387eb915c3 100644
> --- a/fs/bcachefs/btree_key_cache.c
> +++ b/fs/bcachefs/btree_key_cache.c
> @@ -838,8 +838,7 @@ void bch2_btree_key_cache_drop(struct btree_trans *trans,
>   static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
>   					   struct shrink_control *sc)
>   {
> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
> -					btree_key_cache.shrink);
> +	struct bch_fs *c = shrink->private_data;
>   	struct btree_key_cache *bc = &c->btree_key_cache;
>   	struct bucket_table *tbl;
>   	struct bkey_cached *ck, *t;
> @@ -936,8 +935,7 @@ static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
>   static unsigned long bch2_btree_key_cache_count(struct shrinker *shrink,
>   					    struct shrink_control *sc)
>   {
> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
> -					btree_key_cache.shrink);
> +	struct bch_fs *c = shrink->private_data;
>   	struct btree_key_cache *bc = &c->btree_key_cache;
>   	long nr = atomic_long_read(&bc->nr_keys) -
>   		atomic_long_read(&bc->nr_dirty);
> @@ -957,7 +955,7 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
>   	int cpu;
>   #endif
>   
> -	unregister_shrinker(&bc->shrink);
> +	shrinker_free(bc->shrink);
>   
>   	mutex_lock(&bc->lock);
>   
> @@ -1031,6 +1029,7 @@ void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
>   int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
>   {
>   	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
> +	struct shrinker *shrink;
>   
>   #ifdef __KERNEL__
>   	bc->pcpu_freed = alloc_percpu(struct btree_key_cache_freelist);
> @@ -1043,11 +1042,15 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
>   
>   	bc->table_init_done = true;
>   
> -	bc->shrink.seeks		= 0;
> -	bc->shrink.count_objects	= bch2_btree_key_cache_count;
> -	bc->shrink.scan_objects		= bch2_btree_key_cache_scan;
> -	if (register_shrinker(&bc->shrink, "%s/btree_key_cache", c->name))
> +	shrink = shrinker_alloc(0, "%s/btree_key_cache", c->name);
> +	if (!shrink)
>   		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> +	bc->shrink = shrink;
> +	shrink->seeks		= 0;
> +	shrink->count_objects	= bch2_btree_key_cache_count;
> +	shrink->scan_objects	= bch2_btree_key_cache_scan;
> +	shrink->private_data	= c;
> +	shrinker_register(shrink);
>   	return 0;
>   }
>   
> diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
> index 70398aaa095e..fac0abdaf167 100644
> --- a/fs/bcachefs/btree_types.h
> +++ b/fs/bcachefs/btree_types.h
> @@ -163,7 +163,7 @@ struct btree_cache {
>   	unsigned		used;
>   	unsigned		reserve;
>   	atomic_t		dirty;
> -	struct shrinker		shrink;
> +	struct shrinker		*shrink;
>   
>   	/*
>   	 * If we need to allocate memory for a new btree node and that
> @@ -321,7 +321,7 @@ struct btree_key_cache {
>   	bool			table_init_done;
>   	struct list_head	freed_pcpu;
>   	struct list_head	freed_nonpcpu;
> -	struct shrinker		shrink;
> +	struct shrinker		*shrink;
>   	unsigned		shrink_iter;
>   	struct btree_key_cache_freelist __percpu *pcpu_freed;
>   
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 48431700b83e..bdc8573631bd 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -1885,7 +1885,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
>   		sb->s_flags	|= SB_POSIXACL;
>   #endif
>   
> -	sb->s_shrink.seeks = 0;
> +	sb->s_shrink->seeks = 0;
>   
>   	vinode = bch2_vfs_inode_get(c, BCACHEFS_ROOT_SUBVOL_INUM);
>   	ret = PTR_ERR_OR_ZERO(vinode);
> diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
> index 41c6900c34c1..a9f480c26bb4 100644
> --- a/fs/bcachefs/sysfs.c
> +++ b/fs/bcachefs/sysfs.c
> @@ -522,7 +522,7 @@ STORE(bch2_fs)
>   
>   		sc.gfp_mask = GFP_KERNEL;
>   		sc.nr_to_scan = strtoul_or_return(buf);
> -		c->btree_cache.shrink.scan_objects(&c->btree_cache.shrink, &sc);
> +		c->btree_cache.shrink->scan_objects(c->btree_cache.shrink, &sc);
>   	}
>   
>   	if (attr == &sysfs_btree_wakeup)
