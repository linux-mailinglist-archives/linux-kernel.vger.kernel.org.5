Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678667D0B26
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376584AbjJTJJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJTJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:09:46 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA491D53
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:09:44 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c4c40ca4f4so80699a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697792984; x=1698397784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5msWNWL41AIdgrJ//XUVP0/4F9YXxRYn1uRPK4TdbMs=;
        b=NccY/sQRqpgxA8pku1nHVmdbBoHZY67rnu13XaFLj5QR6hF//XBBFThIjp2d3by6mV
         a7n5xjRcC9mm6ltPmOzBFW8Qb/x07SHtf8NbmMw23tRMIPFM97NO2D2hbofgBrdTwAgQ
         cvPCI+uf0bhvxGvdUCzx2MghOYtf7sPuBYU7jODtfDxuYc6cTVVc28NxaX9Vay3Qjj0w
         1G7BjdyXvm58IenAnkFWet9fJ6mNVpMwVX3G/TJ6oTRhVknNZmq43zw+dIQ9Rwf4Mtn3
         aITJ8B6aPT+YSFydlFJlEescIYsUjHCbO2mwn6TFXoOZZx6EhaHCzHOs8DO7HVAUN3iS
         JoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697792984; x=1698397784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5msWNWL41AIdgrJ//XUVP0/4F9YXxRYn1uRPK4TdbMs=;
        b=WpbiBuZc21I7J5kdEmHqpPJ+NuHFZCbAUK0s5FZ+rpviRmnb4TRM034Wtc8AA2yHNX
         0TmgtFaoMtsd7li0w/rROfe3EC5yWhe/noCXGG/V7RuTUAvC332jf/vMBOxX9wHlKAUD
         2qsqMfpdsINc1cuQP/81onfhJRAuBW7v7rvClNMYUVrklzYVUYJM3LzxFhxRmi4qP6kN
         dzORzVkLq6Cxy5MopK1ydll1CqC93d51SQV7Q4qPPO8I3o5M+ZwFY55JJYm1N3tpt/gG
         lHNVlhcLL62vmvscmSGIdggVbbL9ExNPwTpD0UVBkAWPdxs5Z7hJnykjtxPUu3ch95+/
         tRBQ==
X-Gm-Message-State: AOJu0YxxMKtjYS32wibHC6/H9C4sFD/oTu+rvx5W1GQ4T996SHCEmI+T
        W+VzJ13sPIrAtP1lLOGpbVWXmg==
X-Google-Smtp-Source: AGHT+IF4AQhDhYUlzaMbJGUacsS6ox02vIAL5HbASfgVGw8VO/kFVQuPTh3gV7M+2iisLpcZh5fITg==
X-Received: by 2002:a05:6358:5922:b0:168:a35c:f07b with SMTP id g34-20020a056358592200b00168a35cf07bmr1242576rwf.0.1697792983981;
        Fri, 20 Oct 2023 02:09:43 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b00690daae925bsm1074439pfl.51.2023.10.20.02.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 02:09:43 -0700 (PDT)
Message-ID: <790a89e6-93ee-dd43-a785-495ab52a2dde@bytedance.com>
Date:   Fri, 20 Oct 2023 17:09:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/2] mm: page_alloc: skip memoryless nodes entirely
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        mgorman@techsingularity.net, aneesh.kumar@linux.ibm.com,
        ying.huang@intel.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
 <157013e978468241de4a4c05d5337a44638ecb0e.1697711415.git.zhengqi.arch@bytedance.com>
 <ZTI6zM0MUlfglkD+@gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZTI6zM0MUlfglkD+@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/20 16:31, Ingo Molnar wrote:
> 
> * Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> In find_next_best_node(), We skipped the memoryless nodes
> 
> s/We
>   /we
> 
> s/the memoryless nodes
>   /memoryless nodes
> 
>> when building the zonelists of other normal nodes (N_NORMAL),
>> but did not skip the memoryless node itself when building
>> the zonelist. This will cause it to be traversed at runtime.
>>
>> For example, say we have node0 and node1, node0 is memoryless
>> node, then the fallback order of node0 and node1 as follows:
>>
>> [    0.153005] Fallback order for Node 0: 0 1
>> [    0.153564] Fallback order for Node 1: 1
>>
>> After this patch, we skip memoryless node0 entirely, then
>> the fallback order of node0 and node1 as follows:
> 
> s/fallback
>   /fall back
> 
>>
>> [    0.155236] Fallback order for Node 0: 1
>> [    0.155806] Fallback order for Node 1: 1
>>
>> So it becomes completely invisible, which will reduce runtime
>> overhead.
>>
>> And in this way, we will not try to allocate pages from memoryless
>> node0, then the panic mentioned in [1] will also be fixed. Even though
>> this problem has been solved by dropping the NODE_MIN_SIZE constrain
>> in x86 [2], it would be better to fix it in core MM as well.
> 
> s/in core MM
>   /in the core MM
> 
>> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
>> [2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
>> +	/*
>> +	 * Use the local node if we haven't already. But for memoryless local
>> +	 * node, we should skip it and fallback to other nodes.
> 
> s/fallback
>   /fall back
> 
> s/already. But
>   /already, but

Will fix the typos above.

> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks.

> 
> Thanks,
> 
> 	Ingo
