Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CBD7FE78B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjK3DJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3DJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:09:44 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B321A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:09:49 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cba45eeaf6so108293b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701313789; x=1701918589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ML98wtqX8CZrJ1eNLbEm4KE+4Vgc1oCTvjI+9JGlhk=;
        b=JvYdnVXw9JfFrSOdeY5yTgKRaxVfW4KBxdBTdbv/Ne60uaHHiJAPcCN6dcyLyiYEIu
         A14JiDOCAlj+vo8a3CPCk7/bMy+8/u4Q6mCx+vHqexL4fPATCVZq+Gncy5AIXfUBiGka
         PK6JS8OQvq7IfhVHwbqH3z7gIGciGeqsdu4h7h1PBONSf8y3jc96t6UDz+37SgaEZYgT
         eeQecLo05MydbB9h2pRbHaBxiII9Mx+58Tb13zj4+hAvktjUJbcqyAYSIu7ZwXcGG321
         czR7th2nMSvx7PuY1gB7J9et8wIAD+2nVty3jmie2V06d8hDauIesTySbt4bO6AdWlKI
         rrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701313789; x=1701918589;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ML98wtqX8CZrJ1eNLbEm4KE+4Vgc1oCTvjI+9JGlhk=;
        b=C50xjrlbjOoaFMuipELb5HLWhhkIvAaIssE9h8EGQLb/r1MEN9kYkjFoWd3twQaYgP
         Jp5JQ8jK0uppRRZdvOXt4QtPlKsR+9fZhOVvSP0m9yNP46siL0d3ZFm5XOotWkfLy7xN
         XqMHspsNDe/YLfh8I/BtgJSot3Qboakbg5XYz+F0ZGBqedieUmpSF8wVmbPiuXmGzsXn
         giDo9e65fCUl2yVdzTyYuctgfkGZ+aITXTAIcEEngi43gCW6jp+QX3pQrc8LM7/VrBcj
         a3PsIdPYiaepF/kYDQB1rkFe3LVqdUwNo64wLTTUL7EUeFWXewxs20PPQufGsIghjQSI
         pOKw==
X-Gm-Message-State: AOJu0YxwtV4WtsIgcwt/0vkvvwjCS6xmOE/NseQo0j8HyM+6RCi5VZZ8
        4POfQds2rhk7YCqwSJAFIXqztQ==
X-Google-Smtp-Source: AGHT+IGbEKAI2ckRey6HuiOMmR5J9o5OVZLIRUhy/y0C4ca1yY3zVvh5twO90WagW+6P+48d3OvyZg==
X-Received: by 2002:a05:6a20:5497:b0:18c:2dad:8201 with SMTP id i23-20020a056a20549700b0018c2dad8201mr20301273pzk.4.1701313788892;
        Wed, 29 Nov 2023 19:09:48 -0800 (PST)
Received: from [10.84.152.29] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id z19-20020a17090abd9300b00283a0c3df63sm173978pjr.54.2023.11.29.19.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 19:09:47 -0800 (PST)
Message-ID: <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
Date:   Thu, 30 Nov 2023 11:09:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
References: <20231122232515.177833-3-kent.overstreet@linux.dev>
 <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
 <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
 <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
 <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car> <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <20231129231147.7msiocerq7phxnyu@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/30 07:11, Kent Overstreet wrote:
> On Wed, Nov 29, 2023 at 10:14:54AM +0100, Michal Hocko wrote:
>> On Tue 28-11-23 16:34:35, Roman Gushchin wrote:
>>> On Tue, Nov 28, 2023 at 02:23:36PM +0800, Qi Zheng wrote:
>> [...]
>>>> Now I think adding this method might not be a good idea. If we allow
>>>> shrinkers to report thier own private information, OOM logs may become
>>>> cluttered. Most people only care about some general information when
>>>> troubleshooting OOM problem, but not the private information of a
>>>> shrinker.
>>>
>>> I agree with that.
>>>
>>> It seems that the feature is mostly useful for kernel developers and it's easily
>>> achievable by attaching a bpf program to the oom handler. If it requires a bit
>>> of work on the bpf side, we can do that instead, but probably not. And this
>>> solution can potentially provide way more information in a more flexible way.
>>>
>>> So I'm not convinced it's a good idea to make the generic oom handling code
>>> more complicated and fragile for everybody, as well as making oom reports differ
>>> more between kernel versions and configurations.
>>
>> Completely agreed! From my many years of experience of oom reports
>> analysing from production systems I would conclude the following categories
>> 	- clear runaways (and/or memory leaks)
>> 		- userspace consumers - either shmem or anonymous memory
>> 		  predominantly consumes the memory, swap is either depleted
>> 		  or not configured.
>> 		  OOM report is usually useful to pinpoint those as we
>> 		  have required counters available
>> 		- kernel memory consumers - if we are lucky they are
>> 		  using slab allocator and unreclaimable slab is a huge
>> 		  part of the memory consumption. If this is a page
>> 		  allocator user the oom repport only helps to deduce
>> 		  the fact by looking at how much user + slab + page
>> 		  table etc. form. But identifying the root cause is
>> 		  close to impossible without something like page_owner
>> 		  or a crash dump.
>> 	- misbehaving memory reclaim
>> 		- minority of issues and the oom report is usually
>> 		  insufficient to drill down to the root cause. If the
>> 		  problem is reproducible then collecting vmstat data
>> 		  can give a much better clue.
>> 		- high number of slab reclaimable objects or free swap
>> 		  are good indicators. Shrinkers data could be
>> 		  potentially helpful in the slab case but I really have
>> 		  hard time to remember any such situation.
>> On non-production systems the situation is quite different. I can see
>> how it could be very beneficial to add a very specific debugging data
>> for subsystem/shrinker which is developed and could cause the OOM. For
>> that purpose the proposed scheme is rather inflexible AFAICS.
> 
> Considering that you're an MM guy, and that shrinkers are pretty much
> universally used by _filesystem_ people - I'm not sure your experience
> is the most relevant here?
> 
> The general attitude I've been seeing in this thread has been one of
> dismissiveness towards filesystem people. Roman too; back when he was

Oh, please don't say that, it seems like you are the only one causing
the fight. We deeply respect the opinions of file system developers, so
I invited Dave to this thread from the beginning. And you didn’t CC
linux-fsdevel@vger.kernel.org yourself.

> working on his shrinker debug feature I reached out to him, explained
> that I was working on my own, and asked about collaborating - got
> crickets in response...
> 
> Hmm..
> 
> Besides that, I haven't seen anything what-so-ever out of you guys to
> make our lives easier, regarding OOM debugging, nor do you guys even
> seem interested in the needs and perspectives of the filesytem people.
> Roman, your feature didn't help one bit for OOM debuging - didn't even
> come with documentation or hints as to what it's for.
> 
> BPF? Please.

(Disclaimer, no intention to start a fight, here are some objective
views.)

Why not? In addition to printk, there are many good debugging tools
worth trying, such as BPF related tools, drgn, etc.

For non-bcachefs developers, who knows what those statistics mean?

You can use BPF or drgn to traverse in advance to get the address of the
bcachefs shrinker structure, and then during OOM, find the bcachefs
private structure through the shrinker->private_data member, and then
dump the bcachefs private data. Is there any problem with this?

Thanks,
Qi

> 
> Anyways.
> 
> Regarding log spam: that's something this patchset already starts to
> address. I don't think we needed to be dumping every single slab in the
> system, for ~2 pages worth of logs; hence this patchset changes that to
> just print the top 10.
> 
> The same approach is taken with shrinkers: more targeted, less spammy
> output.
> 
> So now that that concern has been addressed, perhaps some actual meat:
> 
> For one, the patchset adds tracking for when a shrinker was last asked
> to free something, vs. when it was actually freed. So right there, we
> can finally see at a glance when a shrinker has gotten stuck and which
> one.
> 
> Next up, why has a shrinker gotten stuck?
> 
> That's why the .to_text() callback is needed: _shrinkers have internal
> state_, and the reasons objects may not be getting freed are specific to
> a given shrinker implementation. In bcachefs we added counters for each
> individual reason an object may be skipped by the shrinker (io in
> flight? that debugged a runaway prefetch issue. too many dirty? that
> points to journal reclaim).
> 
> I'm working on a .to_text() function for the struct super_block
> shrinker, will post that one soon...
