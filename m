Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C477D28B8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjJWCxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJWCxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:53:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB76119
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:53:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d8a1aed37so946524a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698029597; x=1698634397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxlrpfT+18WYqvl8iBNwHnQjJ9RP07edFblWvZMOgNU=;
        b=My7sPeKG9VK4TyD28ZSjcROpMdKRJKy/s1oJqWWfV1g3nsje76Tuc/zdhjuBY+OqGW
         AU9bQJen6xFf1tQ+873nDEfwKgcOsd+V+pSzWQvGbYxC2wAxln9mgoIgkeibBlXt7LGW
         P1+wPhFCwxpizeH+MEH3aHa4TKV1+a+JsOlmO22BFrF+Ec3Nf6g1Q2JyExLvLXWCEnDD
         glBG6IIt3ZUmaf+BDWvsSsv50XCztK+R0GIj4avbLwS8D4Ux4/FXxKdHbXdryPhijOx9
         I4ZXUBNgjmI9h7FouBiEuG6cQ4xNMvAgpHspqKfsD1yu67bdUmFCAMmKjmEU8z6vL5NL
         2xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698029597; x=1698634397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxlrpfT+18WYqvl8iBNwHnQjJ9RP07edFblWvZMOgNU=;
        b=v3W1IJWFCKDUCaaSGJawzQrd/CleoWPbAHEsmyb4v73/GrfL5Un+Dm85fgmYLvzpXv
         wbza3NTXEZcAIkQeIFwsN8U5OSVe5Ies7G3kUreNiWiEtacI1H3s82vwqgCWtTuOFcBF
         HKMYUJRZylVkUYjZL4svvDT/T6x1cASH3O0CJGL7R8p4Byo77SV5DV8jKhTRsnTd6Mth
         Qt/JqEC7Vd5UptEqiUcjNxR4bUJHETvy/LtOHLm7KDVQ15WGlItr2I4N17m5wNOYsp9/
         x53WqUo06vel7+Ic8vIAZa8di3otKscTk32sT6Lb0WwLCidsJCBh8pwm5E1sW0IcwUau
         tM3Q==
X-Gm-Message-State: AOJu0YxQLzVCC7N9oweTwSqDQ1DqFLJ+UYxzBVeDmw80Ak8K/KpOu+zW
        eRKjspl/gAinKYTxqhdKQTyDUA==
X-Google-Smtp-Source: AGHT+IHWcz3LizzawCs7mBkpZJv+RjoDj04rWXMMSSoX22lUYmglkwmMnyN8sUPfBaXb33R45Lk1OQ==
X-Received: by 2002:a05:6a21:1a2:b0:171:947f:465b with SMTP id le34-20020a056a2101a200b00171947f465bmr12208058pzb.4.1698029596701;
        Sun, 22 Oct 2023 19:53:16 -0700 (PDT)
Received: from [10.4.238.83] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id a7-20020aa794a7000000b006be484e5b9bsm5116413pfl.58.2023.10.22.19.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 19:53:16 -0700 (PDT)
Message-ID: <b6319738-0d71-4083-a5db-845430b8a5d8@bytedance.com>
Date:   Mon, 23 Oct 2023 10:53:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
 <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
 <87bkctg4f4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4bfa007c-a20f-9e68-4a9f-935dacf43222@bytedance.com>
 <8734y2f868.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <8734y2f868.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Hi Ying,

On 2023/10/23 09:18, Huang, Ying wrote:
> Qi Zheng <zhengqi.arch@bytedance.com> writes:
> 
>> Hi Ying,
>>
>> On 2023/10/20 15:05, Huang, Ying wrote:
>>> Qi Zheng <zhengqi.arch@bytedance.com> writes:
>>>
>>>> In offline_pages(), if a node becomes memoryless, we
>>>> will clear its N_MEMORY state by calling node_states_clear_node().
>>>> But we do this after rebuilding the zonelists by calling
>>>> build_all_zonelists(), which will cause this memoryless node to
>>>> still be in the fallback list of other nodes.
>>> For fallback list, do you mean pgdat->node_zonelists[]?  If so, in
>>> build_all_zonelists
>>>     __build_all_zonelists
>>>       build_zonelists
>>>         build_zonelists_in_node_order
>>>           build_zonerefs_node
>>> populated_zone() will be checked before adding zone into zonelist.
>>> So, IIUC, we will not try to allocate from the memory less node.
>>
>> Normally yes, but if it is the weird topology mentioned in [1], it's
>> possible to allocate memory from it, it is a memoryless node, but it
>> also has memory.
>>
>> In addition to the above case, I think it's reasonable to remove
>> memory less node from node_order[] in advance. In this way it will
>> not to be traversed in build_zonelists_in_node_order().
>>
>> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> 
> Got it!  Thank you for information.  I think that it may be good to
> include this in the patch description to avoid potential confusing in
> the future.

OK, maybe the commit message can be changed to the following:

```
In offline_pages(), if a node becomes memoryless, we
will clear its N_MEMORY state by calling node_states_clear_node().
But we do this after rebuilding the zonelists by calling
build_all_zonelists(), which will cause this memoryless node to
still be in the fallback nodes (node_order[]) of other nodes.

To drop memoryless nodes from fallback nodes in this case, just
call node_states_clear_node() before calling build_all_zonelists().

In this way, we will not try to allocate pages from memoryless
node0, then the panic mentioned in [1] will also be fixed. Even though
this problem has been solved by dropping the NODE_MIN_SIZE constrain
in x86 [2], it would be better to fix it in the core MM as well.

[1]. 
https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
[2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/

```

Thanks,
Qi

> 
> --
> Best Regards,
> Huang, Ying
> 
>> Thanks,
>> Qi
>>
>>
>>> --
>>> Best Regards,
>>> Huang, Ying
>>>
>>>> This will incur
>>>> some runtime overhead.
>>>>
>>>> To drop memoryless node from fallback lists in this case, just
>>>> call node_states_clear_node() before calling build_all_zonelists().
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> [snip]
>>> --
>>> Best Regards,
>>> Huang, Ying
