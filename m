Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30957F132D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjKTMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjKTMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:25:17 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CF5D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:24:49 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so4446507b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700483088; x=1701087888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=prRaf28GlfVG5K8J+PPUwF0MLbf5QBVz3NQIYNhjkEM=;
        b=jsE/HgxrbC6cgTCerZrj1m4bFswBlOXRIFVf39y2Nb0LI7RRBqzadHssWfZip1fILm
         g6SfjwMOJZ05oZuk1Z3+IRFI9TDqlQJBYYs/SUOlzqCH8pejfTZ0f3VcYp+pjWKfTg1f
         zBPPPF+TGSgo0V49y1aybbTu1nVPrbpn6gzxKHzl4h1POgzZR0DcEjUf3fA//LeH0qsJ
         Le1K6q0dG3zgZsEHKjdv7bVeRRM2Zlw1qS3rGCm7d3qviXmWott/QHqfRBiG6q/LCRuE
         4YQUtiz/LJLIr04r1Et1IYnfJfDM2+PnWxI2iama8vVsSqfWNtmkK5u9kvtXg6bMhrZP
         oNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483088; x=1701087888;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prRaf28GlfVG5K8J+PPUwF0MLbf5QBVz3NQIYNhjkEM=;
        b=OyDCw7CpNOeyUcHKwl40To1p1oX7ryKY3hDwUPuRkjwK3wOgTzSnOPZ+Ad70uJ6YHa
         bNPmtN1ZiV/qMobUFQRQI8FploFS+l+/EmgkkjmdlGzDYaCThj7xOlp+8YDRqq23t5mc
         B3v/fT/CtJQjshgPYblm3M/5EkoMLrMVz6SfA0WOrY5+0d2ADGtbbYLglRYD6sBqzKAW
         tNeaEFW9LH4P4MMa0TuP69dV9dT0sIzs/Xaa9XuF5zLUpDzZBzm9S+7j10YLVRwFTYGq
         hYD8qkQ/xxw++ZguHJ8RFR8chsAnYVV3Ne8oCg2KXVKntpk9L7shtuG6ffXFmg07XQsy
         T5Fw==
X-Gm-Message-State: AOJu0YxmSanSmwONb1oL+6YY3lButHZZnoexVcFLbX4yv62hfolxAhNT
        2h8tZt6j6sRHT9j9w/yWwYIwJA==
X-Google-Smtp-Source: AGHT+IGPB4qUPiXwKvOL10y3nGgZj2KLn0BAXxGYSvnGv0lSTy22YZMzXF0DemxTik25sQmAN/+BVA==
X-Received: by 2002:a05:6a00:4309:b0:6cb:8430:de32 with SMTP id cb9-20020a056a00430900b006cb8430de32mr6183119pfb.14.1700483088628;
        Mon, 20 Nov 2023 04:24:48 -0800 (PST)
Received: from [192.168.3.101] ([104.28.240.134])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a00180400b006cb797722e6sm2729279pfa.109.2023.11.20.04.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 04:24:48 -0800 (PST)
Message-ID: <f0007398-cd35-4e9e-8ee5-7541de92821f@bytedance.com>
Date:   Mon, 20 Nov 2023 20:24:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] lib: objpool: fix head overrun on RK3588 SBC
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mattwu@163.com
References: <20231114115148.298821-1-wuqiang.matt@bytedance.com>
 <20231120141824.86bda7ae184baf331e3175d9@kernel.org>
Content-Language: en-US
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <20231120141824.86bda7ae184baf331e3175d9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/20 13:18, Masami Hiramatsu (Google) wrote:
> On Tue, 14 Nov 2023 19:51:48 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> 
>> objpool overrun stress with test_objpool on OrangePi5+ SBC triggered the
>> following kernel warnings:
>>
>>      WARNING: CPU: 6 PID: 3115 at lib/objpool.c:168 objpool_push+0xc0/0x100
>>
>> This message is from objpool.c:168:
>>
>>      WARN_ON_ONCE(tail - head > pool->nr_objs);
>>
>> The overrun test case is to validate the case that pre-allocated objects
>> are insufficient: 8 objects are pre-allocated for each node and consumer
>> thread per node tries to grab 16 objects in a row. The testing system is
>> OrangePI 5+, with RK3588, a big.LITTLE SOC with 4x A76 and 4x A55. When
>> disabling either all 4 big or 4 little cores, the overrun tests run well,
>> and once with big and little cores mixed together, the overrun test would
>> always cause an overrun loop. It's likely the memory timing differences
>> of big and little cores cause this trouble. Here are the debugging data
>> of objpool_try_get_slot after try_cmpxchg_release:
>>
>>      objpool_pop: cpu: 4/0 0:0 head: 278/279 tail:278 last:276/278
>>
>> The local copies of 'head' and 'last' were 278 and 276, and reloading of
>> 'slot->head' and 'slot->last' got 279 and 278. After try_cmpxchg_release
>> 'slot->head' became 'head + 1', which is correct. But what's wrong here
>> is the stale value of 'last', and that stale value of 'last' finally led
>> the overrun of 'head'.
> 
> Ah, good catch! So even if the ring size is enough, the head/tail update
> value is not updated locally, it can cause the overrun!

It's really confusing at the first glance of such an issue. I was assuming
the order between 'last' and 'head' should be implicitly maintained, but
after more digging, then found that wasn't true actually, the order should
be explicitly guaranteed by pop().

I also verified with Amlogic A311D which has 6 cores (4x A73 and 4x A53),
and got same results. I think I just need re-discover the differences of
HMP (heterogeneous multiprocessing) for big.LITTLE or P/E cores cpus.

>>
>> Memory updating of 'last' and 'head' are performed in push() and pop()
>> independently, which could be the culprit leading this out of order
>> visibility of 'last' and 'head'. So for objpool_try_get_slot(), it's
>> not enough only checking the condition of 'head != slot', the implicit
>> condition 'last - head <= nr_objs' must also be explicitly asserted to
>> guarantee 'last' is always behind 'head' before the object retrieving.
> 
> Indeed. Thanks for the investigation!
> 
>>
>> This patch will check and try reloading of 'head' and 'last' to ensure
>> 'last' is behind 'head' at the time of object retrieving. Performance
>> testings show the average impact is about 0.1% for X86_64 and 1.12% for
>> ARM64. Here are the results:
>>
>>      OS: Debian 10 X86_64, Linux 6.6rc
>>      HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
>>                        1T         2T         4T         8T        16T
>>      native:     49543304   99277826  199017659  399070324  795185848
>>      objpool:    29909085   59865637  119692073  239750369  478005250
>>      objpool+:   29879313   59230743  119609856  239067773  478509029
>>                       32T        48T        64T        96T       128T
>>      native:   1596927073 2390099988 2929397330 3183875848 3257546602
>>      objpool:   957553042 1435814086 1680872925 2043126796 2165424198
>>      objpool+:  956476281 1434491297 1666055740 2041556569 2157415622
>>
>>      OS: Debian 11 AARCH64, Linux 6.6rc
>>      HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s
>>                        1T         2T         4T         8T        16T
>>      native:     30890508   60399915  123111980  242257008  494002946
>>      objpool:    14742531   28883047   57739948  115886644  232455421
>>      objpool+:   14107220   29032998   57286084  113730493  232232850
>>                       24T        32T        48T        64T        96T
>>      native:    746406039 1000174750 1493236240 1998318364 2942911180
>>      objpool:   349164852  467284332  702296756  934459713 1387898285
>>      objpool+:  348388180  462750976  696606096  927865887 1368402195
>>
> 
> OK, looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> And let me pick it.
> 
>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> 
> BTW, this is a real bugfix, so it should have Fixes tag :)
> 
> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
> 

Oh, right! Thanks for your kind reminder. I'll keep that in mind.

> Thank you!

Best regards.

> 
>> ---
>>   lib/objpool.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/lib/objpool.c b/lib/objpool.c
>> index ce0087f64400..cfdc02420884 100644
>> --- a/lib/objpool.c
>> +++ b/lib/objpool.c
>> @@ -201,6 +201,23 @@ static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
>>   	while (head != READ_ONCE(slot->last)) {
>>   		void *obj;
>>   
>> +		/*
>> +		 * data visibility of 'last' and 'head' could be out of
>> +		 * order since memory updating of 'last' and 'head' are
>> +		 * performed in push() and pop() independently
>> +		 *
>> +		 * before any retrieving attempts, pop() must guarantee
>> +		 * 'last' is behind 'head', that is to say, there must
>> +		 * be available objects in slot, which could be ensured
>> +		 * by condition 'last != head && last - head <= nr_objs'
>> +		 * that is equivalent to 'last - head - 1 < nr_objs' as
>> +		 * 'last' and 'head' are both unsigned int32
>> +		 */
>> +		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
>> +			head = READ_ONCE(slot->head);
>> +			continue;
>> +		}
>> +
>>   		/* obj must be retrieved before moving forward head */
>>   		obj = READ_ONCE(slot->entries[head & slot->mask]);
>>   
>> -- 
>> 2.40.1
>>
> 
> 

