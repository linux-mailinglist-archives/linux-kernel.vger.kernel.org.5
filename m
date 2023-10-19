Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E787CF266
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbjJSIWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjJSIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:22:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C5A11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:21:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9ba72f6a1so16325575ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697703712; x=1698308512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzWkTfJOR6mlT/tI7WZYHyubNo6hZu3yDARes/L4kiw=;
        b=HYqDKoM2mP5sxb39zZEIDCQLxqTxoqogZqNliYz+2mQYbg/3T4jUBIyyB3KDRNbUCf
         i0HICOkEfgaFo4E7GfzWC3pafHEEgEgZwf3suY5NJYstS7xL7H0QTdgFrf5mY2s1VkUL
         /X357aRJ5nLaZXZXE7bXxVzkwRLvy+dDiVBsPXuwDUuxBRwJO6X4ZFD+fQDqTwaEagU2
         zvl4U4idnpo/tfz8p3dELkM64Xyx9rhWJJFYWZIVAS3mhOOd2W57XEw8MYDYVud4ubJ5
         hnJqg3mm6q/v+4P8Ymv7TkUNKVYRdSmHToBr6wulp53wJiftDuMlz40Sk5MP0c1Ihriz
         XysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697703712; x=1698308512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzWkTfJOR6mlT/tI7WZYHyubNo6hZu3yDARes/L4kiw=;
        b=g96Fv1oJaoMwdeNohuY+ZbnAqg2cuyKPwEuUvx9F4Rp/v4CjgP/jRgmzMG0EmT/avH
         gnsxQ4XD4JF+DC3HxzAWwfNl79n8IxucK4fhrlLrkna0tVRQ4LpVoq/Dat/vl9e//P5K
         Sz0sRvZBODYjyuC/IL4XHqGwoIF8VHR6mFS4C7DHLFVV/+zK5tMkCCO5sBv0jSjaomzl
         hdriuVzeaDchGkNFT80IzHSmYpS+cUItKQmIPymX5fRzhX1+0tk1OWc8i1AvZbJdzf9R
         ne+zMMI4bQLJZ0dZZ8eHQhwsrR+uVhP1qWVNpxXMZhy6SsapD79mxI6AcQArANKxVl+w
         t3cQ==
X-Gm-Message-State: AOJu0Ywp4WZrLwqZIpuebLhSn7BrbvOAzBLqCi4WqvosLWNpn9NZSsPH
        F87wxtilNPyKscikqTmf5LnGyPS5l860ovxKlT0=
X-Google-Smtp-Source: AGHT+IFT1ytJFHX459IjWo92YzEa15urreygDmo5AXzXIax+NPRaECoXEqMaMKWSFBvbAOF0ITdkfw==
X-Received: by 2002:a17:903:288f:b0:1b8:9fc4:2733 with SMTP id ku15-20020a170903288f00b001b89fc42733mr1604217plb.3.1697703712010;
        Thu, 19 Oct 2023 01:21:52 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027d8900b001bbc8d65de0sm1293994plm.67.2023.10.19.01.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 01:21:51 -0700 (PDT)
Message-ID: <76c6f4af-959c-1d6f-7df8-a2c1f9cd3adc@bytedance.com>
Date:   Thu, 19 Oct 2023 16:21:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] mm: page_alloc: skip memoryless nodes entirely
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, vbabka@suse.cz,
        mhocko@suse.com, willy@infradead.org, mgorman@techsingularity.net,
        mingo@kernel.org, aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1697687357.git.zhengqi.arch@bytedance.com>
 <7928768f2658cd563978f5e5bf8109be1d559320.1697687357.git.zhengqi.arch@bytedance.com>
 <cd210991-5038-4ad3-ac03-abb6761c67bd@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <cd210991-5038-4ad3-ac03-abb6761c67bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2023/10/19 16:07, David Hildenbrand wrote:
> On 19.10.23 09:36, Qi Zheng wrote:
>> In find_next_best_node(), We skipped the memoryless nodes
>> when building the zonelists of other normal nodes (N_NORMAL),
>> but did not skip the memoryless node itself when building
>> the zonelist. This will cause it to be traversed at runtime.
>>
>> For example, say we have node0 and node1, node0 is memoryless
>> node, then the fallback order of node0 and node1 as follows:
>>
>> [    0.153005] Fallback order for Node 0: 0 1
>> [    0.153564] Fallback order for Node 1: 1
>>
>> After this patch, we skip memoryless node0 entirely, then
>> the fallback order of node0 and node1 as follows:
>>
>> [    0.155236] Fallback order for Node 0: 1
>> [    0.155806] Fallback order for Node 1: 1
>>
>> So it becomes completely invisible, which will reduce runtime
>> overhead.
>>
>> And in this way, we will not try to allocate pages from memoryless
>> node0, then the panic mentioned in [1] will also be fixed. Even though
>> this problem has been solved by dropping the NODE_MIN_SIZE constrain
>> in x86 [2], it would be better to fix it in core MM as well.
>>
>> [1]. 
>> https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
>> [2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/page_alloc.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index ee392a324802..e978272699d3 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5052,8 +5052,11 @@ int find_next_best_node(int node, nodemask_t 
>> *used_node_mask)
>>       int min_val = INT_MAX;
>>       int best_node = NUMA_NO_NODE;
>> -    /* Use the local node if we haven't already */
>> -    if (!node_isset(node, *used_node_mask)) {
>> +    /*
>> +     * Use the local node if we haven't already. But for memoryless 
>> local
>> +     * node, we should skip it and fallback to other nodes.
>> +     */
>> +    if (!node_isset(node, *used_node_mask) && node_state(node, 
>> N_MEMORY)) {
>>           node_set(node, *used_node_mask);
>>           return node;
>>       }
> 
> Makes sense to me; I suspect that online_pages() will just to the right 
> thing and call build_all_zonelists() to fix it up.

Yes, the find_next_best_node() will be called by build_all_zonelists().

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.

> 
