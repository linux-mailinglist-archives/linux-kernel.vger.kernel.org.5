Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9432B7D0999
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376423AbjJTHg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJTHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:36:55 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DC93
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:36:31 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c6591642f2so122757a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697787390; x=1698392190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCNi48seP9TxdPwmbtccian/XwAwjZ/WgugH0G6tpfw=;
        b=Z766HoxbZlvjcQPaAl5vuXGKN6cDHrHjtvfS82d2gChFYHrPa3lXylNlPuvaL6XTD7
         yq8ZwTMiXMkGMQofbM5WlNqlMGEhxlOFAqC2M+Aw6p8godYegNn9KYIZHx1MNrgaV5i2
         d2l+BDwqpAhae20shig7QyZ/hrPt1UFLaPLTxH4NAz/ZnVHjTci4z1IPCeH+zsAtHpF1
         NLTTUaqVWynch4J5I5GJu8R5w1Q9sT9BMRJcx/fzwftsjdUX1UWrNG+oC488TDAGCOxq
         cA6/Snp3y3DF76rNM/gpjiZUbLugYQSfyzeyWcCUXulyX1qIiMfnmn/VS3rjYZ9rMC1y
         cxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697787390; x=1698392190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCNi48seP9TxdPwmbtccian/XwAwjZ/WgugH0G6tpfw=;
        b=EZNNxPbCBgCU+j/3Ea2J0VkukPiV78uWQGodSMubcQes70y9Wuc5yOlUYclpdS35eS
         kRS1B+acJMQN2qt9NlGgccMJQE3zg5TLF65EerjeOnA8sjM5/aEyrpFDlF+B2qTYDyE5
         c9ojvCRywcvKf3s8IRboWmY6c4xsfzkNqI6X4va5HOP1NBPBAYRfiwyJrNg2m7PKSO1d
         TJtBKte0g/5MaUKJ0Nb10AtU4PusSo0GDKBq5aFyt01We3xjCFkyV5AKq4bJrM/eBsLN
         A+tqwIT9lNVBVwYOjSLPI/4CgRbiJF/ZpCacLmxqP8OL7fsu41kMgFrqBvtIXc2odync
         fJeg==
X-Gm-Message-State: AOJu0Yw9wKotfg/S6jxeUkT8U26S5NJR5qEK7pM5/4abilE6UEvLXFRg
        e1956kQvWP8+qjgfRYY0yQQN9w==
X-Google-Smtp-Source: AGHT+IEExtAcncpE853r0NUUBr+n8rNCzGqX9LGHQB21UvbaftQszULEGnMqBXLMrtQpZsXXiAAEUQ==
X-Received: by 2002:a05:6808:3197:b0:3b2:ec66:d863 with SMTP id cd23-20020a056808319700b003b2ec66d863mr1078555oib.3.1697787390443;
        Fri, 20 Oct 2023 00:36:30 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79849000000b00682868714fdsm938225pfq.95.2023.10.20.00.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:36:29 -0700 (PDT)
Message-ID: <4bfa007c-a20f-9e68-4a9f-935dacf43222@bytedance.com>
Date:   Fri, 20 Oct 2023 15:35:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <87bkctg4f4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ying,

On 2023/10/20 15:05, Huang, Ying wrote:
> Qi Zheng <zhengqi.arch@bytedance.com> writes:
> 
>> In offline_pages(), if a node becomes memoryless, we
>> will clear its N_MEMORY state by calling node_states_clear_node().
>> But we do this after rebuilding the zonelists by calling
>> build_all_zonelists(), which will cause this memoryless node to
>> still be in the fallback list of other nodes.
> 
> For fallback list, do you mean pgdat->node_zonelists[]?  If so, in
> 
> build_all_zonelists
>    __build_all_zonelists
>      build_zonelists
>        build_zonelists_in_node_order
>          build_zonerefs_node
> 
> populated_zone() will be checked before adding zone into zonelist.
> 
> So, IIUC, we will not try to allocate from the memory less node.

Normally yes, but if it is the weird topology mentioned in [1], it's
possible to allocate memory from it, it is a memoryless node, but it
also has memory.

In addition to the above case, I think it's reasonable to remove
memory less node from node_order[] in advance. In this way it will
not to be traversed in build_zonelists_in_node_order().

[1]. 
https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/

Thanks,
Qi


> 
> --
> Best Regards,
> Huang, Ying
> 
> 
>> This will incur
>> some runtime overhead.
>>
>> To drop memoryless node from fallback lists in this case, just
>> call node_states_clear_node() before calling build_all_zonelists().
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> [snip]
> 
> --
> Best Regards,
> Huang, Ying
