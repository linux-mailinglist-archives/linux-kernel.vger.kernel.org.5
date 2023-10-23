Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91AD7D28F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjJWDRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJWDRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:17:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B175188
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:17:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ca85ff26afso4889765ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698031031; x=1698635831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jfYZQdraBUPgyo62HJV8eAR1Elgs5AqdiMTxOIu60E=;
        b=g5z3g9umsc1oQq3dxhbUp7aNgpZghghCmsNx4fb9T4gIDPpwEpYsP5wGgFfR1oUfry
         YmSp5pM4hp8O0816CG/AgfEzTfwo1BU58aqdnyWYUNQA3acwC787UZH/gVilmZU9M5R8
         QW5bDjmllllPzOvq4fH1WAluCBu2yV/Y2KhmtAceHgx/CnCEJLhzyC6MoAGGE2LVw3gh
         M21xrdE37noBQh/yqDvGtu1s1g7TYzMmMgzQQpk50kGDKMzUtnlJyX395TB1LgaUAdn7
         1/w8Amsw985x7XXu5d80aVFqTAUb2aBWgpdfHCL0kGsm48WrdT5gksyrNoimubXvwI3m
         uxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698031031; x=1698635831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jfYZQdraBUPgyo62HJV8eAR1Elgs5AqdiMTxOIu60E=;
        b=RwZX2X5VvZRTjg+GbSGJXRbDxWi0Zx4ucUnA46pHWDmOIFxCOzi7PPmDHla9S3WQS+
         gv0xGQDzwgg5Qysi8I31dZhmtAV0sZPqLyKHvzY/OA4wd6vmdcmY66yAA23rl1RoZw2q
         gvZutgaaqoL/fVph/rPlnLk74ixrOJZgTWaCXVV+TiQjuW6L6AmN/SObzC9iepsw41lo
         f1D7VZLh2EKEKiY3ebfR0/7sVXTY301OBiZ8Py9tRfmZ//tjP2FITkeF40H7DeePv5aj
         cfTotqQj6zUZNr8T8XMB769hyVpiwUb/+LH0z6h3EklCcG7yFLMjXvrN9XZ7iBVzdSib
         A4RA==
X-Gm-Message-State: AOJu0YzAhfya9jFdjiq0VJKAm+D3LDy+ThqgKySUJQrSFRVZDf893X+Z
        GRhbQRnwoQiancRR03zFvk+k0g==
X-Google-Smtp-Source: AGHT+IH/mgMEwYSxgpZp6jb+L8mhvJKueaM7zuii8EL8pyFtLjLPOuo1RLSEY0c/UBQfygLCxB3xwA==
X-Received: by 2002:a17:903:6c7:b0:1ca:85b4:b962 with SMTP id kj7-20020a17090306c700b001ca85b4b962mr7831135plb.4.1698031031255;
        Sun, 22 Oct 2023 20:17:11 -0700 (PDT)
Received: from [10.4.238.83] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902989100b001b8a00d4f7asm5013778plp.9.2023.10.22.20.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 20:17:10 -0700 (PDT)
Message-ID: <d97ba697-16d9-4e62-86bd-31207b621b11@bytedance.com>
Date:   Mon, 23 Oct 2023 11:17:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
Content-Language: en-US
To:     akpm@linux-foundation.org, "Huang, Ying" <ying.huang@intel.com>
Cc:     rppt@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com,
        willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
 <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
 <87bkctg4f4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4bfa007c-a20f-9e68-4a9f-935dacf43222@bytedance.com>
 <8734y2f868.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <b6319738-0d71-4083-a5db-845430b8a5d8@bytedance.com>
 <87pm16doe5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <87pm16doe5.fsf@yhuang6-desk2.ccr.corp.intel.com>
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



On 2023/10/23 11:10, Huang, Ying wrote:
> Qi Zheng <zhengqi.arch@bytedance.com> writes:
> 
>> Hi Ying,
>>
>> On 2023/10/23 09:18, Huang, Ying wrote:
>>> Qi Zheng <zhengqi.arch@bytedance.com> writes:
>>>
>>>> Hi Ying,
>>>>
>>>> On 2023/10/20 15:05, Huang, Ying wrote:
>>>>> Qi Zheng <zhengqi.arch@bytedance.com> writes:
>>>>>
>>>>>> In offline_pages(), if a node becomes memoryless, we
>>>>>> will clear its N_MEMORY state by calling node_states_clear_node().
>>>>>> But we do this after rebuilding the zonelists by calling
>>>>>> build_all_zonelists(), which will cause this memoryless node to
>>>>>> still be in the fallback list of other nodes.
>>>>> For fallback list, do you mean pgdat->node_zonelists[]?  If so, in
>>>>> build_all_zonelists
>>>>>      __build_all_zonelists
>>>>>        build_zonelists
>>>>>          build_zonelists_in_node_order
>>>>>            build_zonerefs_node
>>>>> populated_zone() will be checked before adding zone into zonelist.
>>>>> So, IIUC, we will not try to allocate from the memory less node.
>>>>
>>>> Normally yes, but if it is the weird topology mentioned in [1], it's
>>>> possible to allocate memory from it, it is a memoryless node, but it
>>>> also has memory.
>>>>
>>>> In addition to the above case, I think it's reasonable to remove
>>>> memory less node from node_order[] in advance. In this way it will
>>>> not to be traversed in build_zonelists_in_node_order().
>>>>
>>>> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
>>> Got it!  Thank you for information.  I think that it may be good to
>>> include this in the patch description to avoid potential confusing in
>>> the future.
>>
>> OK, maybe the commit message can be changed to the following:
>>
>> ```
>> In offline_pages(), if a node becomes memoryless, we
>> will clear its N_MEMORY state by calling node_states_clear_node().
>> But we do this after rebuilding the zonelists by calling
>> build_all_zonelists(), which will cause this memoryless node to
>> still be in the fallback nodes (node_order[]) of other nodes.
>>
>> To drop memoryless nodes from fallback nodes in this case, just
>> call node_states_clear_node() before calling build_all_zonelists().
>>
>> In this way, we will not try to allocate pages from memoryless
>> node0, then the panic mentioned in [1] will also be fixed. Even though
>> this problem has been solved by dropping the NODE_MIN_SIZE constrain
>> in x86 [2], it would be better to fix it in the core MM as well.
>>
>> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
>> [2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/
>>
>> ```

Hi Andrew, can you help modify the commit message to this? :)

Thanks,
Qi

> 
> This is helpful.  Thanks!
> 
> --
> Best Regards,
> Huang, Ying
> 
>> Thanks,
>> Qi
>>
>>> --
>>> Best Regards,
>>> Huang, Ying
>>>
>>>> Thanks,
>>>> Qi
>>>>
>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Huang, Ying
>>>>>
>>>>>> This will incur
>>>>>> some runtime overhead.
>>>>>>
>>>>>> To drop memoryless node from fallback lists in this case, just
>>>>>> call node_states_clear_node() before calling build_all_zonelists().
>>>>>>
>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>>> [snip]
>>>>> --
>>>>> Best Regards,
>>>>> Huang, Ying
