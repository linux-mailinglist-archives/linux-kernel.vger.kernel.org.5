Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6477DD25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbjHPJU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243288AbjHPJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:20:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094731BF8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:20:45 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760dff4b701so74073139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692177644; x=1692782444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlNpMQycLKXmojtrojHNMUrVrub9kauxQ1pbCjOut9s=;
        b=VNXSeICdJxnay4PsGgOiLN++yIhFxxLuLHu0q+42622TWavZod6E8qedqi3F5lkaok
         QQl+Ba+d5ToSjggzLp5uhu9bF83vlsVOc8ZdfnRPrVtpgjycvhO3f9cwHa0XcX0bS475
         STe7wEwNsA2V8kRa640PlOtaRzUwHEfGl3Snvh1ppLDc8ZjqeTZVuF3niDaHbkpQMyC/
         DsWptFq3lwN34gJ/o5wNa9wjabdU+bFVC1od2A1AhpJLeZUbIztDXxE8mEXBZCHfgttu
         YuSqUBddCXNtau4INR3Ak0z1mSX+8RThGC0a9bli+uH8gafP5BHSWV79QolHwtqZj8zN
         6a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692177644; x=1692782444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlNpMQycLKXmojtrojHNMUrVrub9kauxQ1pbCjOut9s=;
        b=ki7vy1oP19ZFleGyS3I2I3FALU0dI9K7s4A7MBA/l2lwjnUenVjFWyM2/YpbyOemRE
         YKWTDXgeyVmbNw2WITuVEBF5eVEAk3rzjA+Ev3n0SrRSFsMoF/cKb6Lpfo405wkyqjwB
         Ml0cvtqtzaMZtquN4bLGOFiBTqKUjGASK94Db5M094proaKcTSherQZp3R/F3kFfOw1U
         pogMROvPYYgyxozKbqdIzP60Enl0vB+K5dMkFrUJfo5q2ii0AA92e8FjF/ygezQXbWWv
         1kpPcofNc62za+dInFY5BMcHNk+cKNTB2MD9dcbzz2nnq/jOY3CxkZD9IbuOsgvqIGBV
         XcSQ==
X-Gm-Message-State: AOJu0YyOm9tPbEpJ1Tq5qMkD9OXoCj4hO1DP4/aL2Sd4VFRQxoSmT/Z5
        ls3AYr5Q7Lp/papDVjR5oFLdIw==
X-Google-Smtp-Source: AGHT+IEgSkg0l4PkdpjEk3Z1pS47eJ+NP+gSmJGZ36H0C+AfOh96Ce1k2peW55SRVGXQZ+z1B6xQig==
X-Received: by 2002:a92:dc92:0:b0:345:bdc2:eb42 with SMTP id c18-20020a92dc92000000b00345bdc2eb42mr1672561iln.3.1692177644351;
        Wed, 16 Aug 2023 02:20:44 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b002694fee879csm12639094pjb.36.2023.08.16.02.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 02:20:43 -0700 (PDT)
Message-ID: <a0238a1b-8be8-85c7-5839-d0a9e36206b2@bytedance.com>
Date:   Wed, 16 Aug 2023 17:20:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] drm/ttm: introduce pool_shrink_rwsem
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org
References: <20230816083419.41088-1-zhengqi.arch@bytedance.com>
 <20230816083419.41088-5-zhengqi.arch@bytedance.com>
 <01213258-6e27-f304-b420-f3d915e54ed1@amd.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <01213258-6e27-f304-b420-f3d915e54ed1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 2023/8/16 17:14, Christian König wrote:
> Am 16.08.23 um 10:34 schrieb Qi Zheng:
>> Currently, the synchronize_shrinkers() is only used by TTM pool. It only
>> requires that no shrinkers run in parallel.
>>
>> After we use RCU+refcount method to implement the lockless slab shrink,
>> we can not use shrinker_rwsem or synchronize_rcu() to guarantee that all
>> shrinker invocations have seen an update before freeing memory.
>>
>> So we introduce a new pool_shrink_rwsem to implement a private
>> synchronize_shrinkers(), so as to achieve the same purpose.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_pool.c | 15 +++++++++++++++
>>   include/linux/shrinker.h       |  1 -
>>   mm/shrinker.c                  | 15 ---------------
>>   3 files changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c 
>> b/drivers/gpu/drm/ttm/ttm_pool.c
>> index cddb9151d20f..713b1c0a70e1 100644
>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>> @@ -74,6 +74,7 @@ static struct ttm_pool_type 
>> global_dma32_uncached[MAX_ORDER + 1];
>>   static spinlock_t shrinker_lock;
>>   static struct list_head shrinker_list;
>>   static struct shrinker mm_shrinker;
>> +static DECLARE_RWSEM(pool_shrink_rwsem);
>>   /* Allocate pages of size 1 << order with the given gfp_flags */
>>   static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t 
>> gfp_flags,
>> @@ -317,6 +318,7 @@ static unsigned int ttm_pool_shrink(void)
>>       unsigned int num_pages;
>>       struct page *p;
>> +    down_read(&pool_shrink_rwsem);
>>       spin_lock(&shrinker_lock);
>>       pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
>>       list_move_tail(&pt->shrinker_list, &shrinker_list);
>> @@ -329,6 +331,7 @@ static unsigned int ttm_pool_shrink(void)
>>       } else {
>>           num_pages = 0;
>>       }
>> +    up_read(&pool_shrink_rwsem);
>>       return num_pages;
>>   }
>> @@ -572,6 +575,18 @@ void ttm_pool_init(struct ttm_pool *pool, struct 
>> device *dev,
>>   }
>>   EXPORT_SYMBOL(ttm_pool_init);
>> +/**
>> + * synchronize_shrinkers - Wait for all running shrinkers to complete.
>> + *
>> + * This is useful to guarantee that all shrinker invocations have 
>> seen an
>> + * update, before freeing memory, similar to rcu.
>> + */
>> +static void synchronize_shrinkers(void)
> 
> Please rename that function to ttm_pool_synchronize_shrinkers().

OK, will do.

> 
> With that done feel free to add Reviewed-by: Christian König 
> <christian.koenig@amd.com>
> 

Thanks,
Qi

> Regards,
> Christian.
> 
>> +{
>> +    down_write(&pool_shrink_rwsem);
>> +    up_write(&pool_shrink_rwsem);
>> +}
>> +
>>   /**
>>    * ttm_pool_fini - Cleanup a pool
>>    *
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 8dc15aa37410..6b5843c3b827 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -103,7 +103,6 @@ extern int __printf(2, 3) register_shrinker(struct 
>> shrinker *shrinker,
>>                           const char *fmt, ...);
>>   extern void unregister_shrinker(struct shrinker *shrinker);
>>   extern void free_prealloced_shrinker(struct shrinker *shrinker);
>> -extern void synchronize_shrinkers(void);
>>   #ifdef CONFIG_SHRINKER_DEBUG
>>   extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker 
>> *shrinker,
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index 043c87ccfab4..a16cd448b924 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -692,18 +692,3 @@ void unregister_shrinker(struct shrinker *shrinker)
>>       shrinker->nr_deferred = NULL;
>>   }
>>   EXPORT_SYMBOL(unregister_shrinker);
>> -
>> -/**
>> - * synchronize_shrinkers - Wait for all running shrinkers to complete.
>> - *
>> - * This is equivalent to calling unregister_shrink() and 
>> register_shrinker(),
>> - * but atomically and with less overhead. This is useful to guarantee 
>> that all
>> - * shrinker invocations have seen an update, before freeing memory, 
>> similar to
>> - * rcu.
>> - */
>> -void synchronize_shrinkers(void)
>> -{
>> -    down_write(&shrinker_rwsem);
>> -    up_write(&shrinker_rwsem);
>> -}
>> -EXPORT_SYMBOL(synchronize_shrinkers);
> 
