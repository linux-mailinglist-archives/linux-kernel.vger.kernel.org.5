Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A307D1275
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377675AbjJTPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377620AbjJTPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:19:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29645D55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:19:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b852632be4so29793a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697815165; x=1698419965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXhmtsd7v35VsKDTvdSZ2foO72l9HxK/7NMvbj357Oc=;
        b=QEltRJ17lV9C8l8ZncfVwjXjdgfQIWCXoLLpXZfXy2mCRDe8LJjbc0yDWG14/9xwPf
         g/9CIXVd0tzFiHyWUJZKCwa8FbXgy4nckO0Fg09Lfuf6OGK2QCSA7gOdHZiyOgDHEeHx
         aANid33mJ/4vQyoxA7IrskLpOsN8MKshHgkRWWrd5tilG6ZAuVAjkM8pVu7h2sCuscdO
         f16UnCPThQoWcQf8gtYsTq8Z0LOZMik2kiueUZICOzmVOoJXzWWCPpBivEk70YSsS2hn
         lu7JOjTc4RdYvzoX7wpBlu9B7nkXgcQJWlQ6o0MCi96Fl8sNtMWgXwOOWCyRICyIERId
         MaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815165; x=1698419965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXhmtsd7v35VsKDTvdSZ2foO72l9HxK/7NMvbj357Oc=;
        b=kk6UnjgyTDNLuO4qn73WiABJ0BIy1VWQRGEzCf35YDGGQygkyjH85DcohZnstAiyh1
         kk+yK0thfuUTpfpWAj3lX9er37EMUqTtZ1fVF3DYqssBdNEUslwMoHROXQE+fK8Ly3Sd
         9Jl4lLYUq0fs3XalVp3sfiVipUSf+uM1h37GB4RgMTwBJq8lrhi7wkZF2H9Hqo00NzIQ
         7giY4GEMKouay1bMnKMAwTlWUVcwdxV46YwTfVepIH8EUtPtX1rIpVcViv4GH5IlufMe
         x7bD9a5i/F18F7llRpQ7lSKf2D5NITbjkfGK7h6zYSOZtYkrljs+irC3zo5Y61HvokxS
         CUiQ==
X-Gm-Message-State: AOJu0YwhxJWk3Nf2El824sG9OMRGUdIo4KJmDe4wnQ2VAYiVm2uQ+XM3
        peb3Gq4BeajqisYg7PnO1X8IOA==
X-Google-Smtp-Source: AGHT+IE6s6NkBDf7TGkQ+jf9gxmZjQduI9EXHQyK2mEMbBuoJLYncEiyFKNJSrCv2CwYF2o28pDQRA==
X-Received: by 2002:a05:6a21:7881:b0:16e:26fd:7c02 with SMTP id bf1-20020a056a21788100b0016e26fd7c02mr2448569pzc.2.1697815165551;
        Fri, 20 Oct 2023 08:19:25 -0700 (PDT)
Received: from [10.4.4.198] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a031900b0026b3a86b0d5sm1732974pje.33.2023.10.20.08.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:19:24 -0700 (PDT)
Message-ID: <58a42dfb-38f8-4935-ac4d-4ec34c3c9504@bytedance.com>
Date:   Fri, 20 Oct 2023 23:19:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: slab-use-after-free Read in radix_tree_lookup in&after
 Linux Kernel 6.4-rc6
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Zhang Zhiyu <zhiyuzhang999@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, secalert@redhat.com
References: <CALf2hKtDJGqmsiSykbX8EEfbthwt6a4Bs98m60dUkS7URW-C8g@mail.gmail.com>
 <CALf2hKucyJjmgE8Ry50RvytMtWz8gVXGXwoECvoVYph7xkEDEQ@mail.gmail.com>
 <ZTI5tzh_tgCBnr35@alley> <ZTJz4/hddcv1J6pJ@casper.infradead.org>
 <ad7f2b88-d483-47d9-9f62-12b55805e1a3@bytedance.com>
 <ZTKVfoQZplpB8rki@casper.infradead.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZTKVfoQZplpB8rki@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 2023/10/20 22:58, Matthew Wilcox wrote:
> On Fri, Oct 20, 2023 at 09:51:18PM +0800, Qi Zheng wrote:
>> Hi all,
>>
>> On 2023/10/20 20:34, Matthew Wilcox wrote:
>>> On Fri, Oct 20, 2023 at 10:26:31AM +0200, Petr Mladek wrote:
>>>> Adding Matthew into Cc in the hope that he is still familiar with the
>>>> code. Also adding Andrew who accepts patches.
>>>
>>> oh joy.  i love dealing with cves.
>>>
>>>>>> I agree, this issue looks to be in kernel-core radix tree code in ./lib/radix-tree.c in two of any places.
>>>
>>> the radix tree code is the victim here.  maybe also the perpetrator, but
>>> it's rather hard to say.
>>>
>>> shrink_slab_memcg()
>>> 	down_read_trylock(&shrinker_rwsem)
>>> 	shrinker = idr_find(&shrinker_idr, i);
>>>
>>> i assume is the path to this bug.  the reporter didn't run the
>>> stacktrace through scripts/decode_stacktrace.sh so it's less useful than
>>> we might want.
>>>
>>> prealloc_memcg_shrinker() calls idr_alloc and idr_remove under
>>> shrinker_rwsem in write mode, so that should be fine.
>>>
>>> unregister_memcg_shrinker() calls idr_remove after asserting &shrinker_rwsem
>>> is held (although not asserting that it's held for write ... hmm ... but
>>> both callers appear to hold it for write anyway)
>>>
>>> so i don't see why we'd get a UAF here.
>>>
>>> anyway, adding Qi Zheng to the cc since they're responsible for the
>>> shrinker code.
>>
>> Thanks for CC'ing me, I'd be happy to troubleshoot any issues that may
>> be shrinker related.
>>
>> Between v6.4-rc1 and v6.4 versions, we briefly implemented lockless slab
>> shrink using the SRCU method. In these versions, we call idr_alloc and
>> idr_remove under shrinker_mutex, and idr_find under srcu_read_lock.
>>
>> These are all legitimate uses of the IDR APIs and the shrinker_idr
>> will never be destroyed, so at a quick glance I didn't see why it would
>> cause UAF here.
> 
> I'm not an expert on how all the RCU flavours interact, but I don't
> think that's safe.  The IDR (radix tree) will RCU-free nodes, but I
> don't think holding the srcu_read_lock is enough to prevent the nodes
> being freed.  

Oh, Indeed, I just saw the Documeentation/RCU/checklist.rst:

```
	If the updater uses call_rcu() or synchronize_rcu(), then
	the corresponding readers may use:  (1) rcu_read_lock() and
	rcu_read_unlock(), (2) any pair of primitives that disables
	and re-enables softirq, for example, rcu_read_lock_bh() and
	rcu_read_unlock_bh(), or (3) any pair of primitives that disables
	and re-enables preemption, for example, rcu_read_lock_sched() and
	rcu_read_unlock_sched().  If the updater uses synchronize_srcu()
	or call_srcu(), then the corresponding readers must use
	srcu_read_lock() and srcu_read_unlock(), and with the same
	srcu_struct.
```

> I think you'd need to take the rcu_read_lock() around
> the call to idr_find().
For latest RCU+refcount method, we call idr_find() under
rcu_read_lock(), so it's safe.

Thanks,
Qi

> 
>> Anyway I will keep working on this issue, and it would be nice if
>> there was a way to reproduce it.
> 
> So I think the CVE is inappropriately issued.  The SRCU code was added in
> v6.4-rc1 and removed before v6.4.  I don't think CVEs are appropriate for
> bugs which only existed in development kernels.  How do we revoke CVEs?
