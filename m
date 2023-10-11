Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE47C4C20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbjJKHkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbjJKHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:40:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0991
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:40:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565e395e7a6so3386606a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697010022; x=1697614822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pnqGnKI3R6wKiF3/G2J0E58yKUrzfwZftwQBcsaBg4=;
        b=KJ32MvMasmFSvzlfx7PIwnP2zUxaWjnkQO2GkG/WWV9IvMi8OaqeWE2PNBdJ80je4t
         5qe4aWYQBFJcEfAAFqs26L25emVwZLQDgGXTIUD1o5fXRXim7vSnFyH0AcjOHKFM79OM
         jwXpNnrvuo81xz3nbvIGyMzGV/TEO16w0lGw+4H4bSQ2UEtzOO2v0Ulrmj9tvTaKR7jN
         Zvor334pXu6QlZPvTvWoefLQsedTXmczcVjwNz1DBc2NnHEzBsCSMEAFBT3U1MOHzvjh
         8pX/PkY6HU6oW84aHcMvTVBc055wfoWJBnZLKQ4w/ibthXX3p3l3XIoYEfU+WYwJ1JQ7
         0vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697010022; x=1697614822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4pnqGnKI3R6wKiF3/G2J0E58yKUrzfwZftwQBcsaBg4=;
        b=UAbX9raYy+so93FA77Ty72t2qBRrZR+oe/pmLMrxLcMMK8o3+B5ZLxEz6BT+9P1YQN
         4hcepANhZwuS61Xh91ccdlRXTj8MEeJ2vEgy3eUH5zqnv9iygbmv0Qu27gUcAYu8iZDS
         u6bhtjuiCfKbWQ3sUp8spC5SJucvbSBRObv6SMMLIwN7nGW5OVizxfwBb0s+E5GlSpmW
         0VSRT55hpyD0iECSxsM9zr7FHSd17siNiR9flLnXuDHcLRzoQie6rzWJfzrwqLRQcfLh
         Ye6gHQlGdaZrSjKvYuJ2verw9M/rKGnmRFwmJdBEb4mQCjeUmb72UK2SmG7brZwGT/Av
         UNHg==
X-Gm-Message-State: AOJu0YzLSIAwhNAX6SGO5++4ErNwj7JyOl3ku4g73bBPMoW4hOjUZZPJ
        /SaJxtj9PMSjqOQK5OjychJrpBhQLiZFi2nfb7Y=
X-Google-Smtp-Source: AGHT+IEt6pc4aozDoEfiAYwvPPkMRaJ0qWY33t9qGYwKCPWOwMsrrkyWEQ9pdIwTyHNy7FOWTiakvA==
X-Received: by 2002:a05:6a20:6a28:b0:15e:5e8c:e45c with SMTP id p40-20020a056a206a2800b0015e5e8ce45cmr20109168pzk.30.1697010022705;
        Wed, 11 Oct 2023 00:40:22 -0700 (PDT)
Received: from [10.84.146.237] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902820600b001c99b3a1e45sm5962532pln.84.2023.10.11.00.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 00:40:22 -0700 (PDT)
Message-ID: <3342fd24-84f5-430f-8900-fd2d8ddae639@bytedance.com>
Date:   Wed, 11 Oct 2023 15:40:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
 <20231009201639.920512-3-sidhartha.kumar@oracle.com>
 <d6182b74-5879-4e5a-8605-abd55542215d@bytedance.com>
 <205f093a-8b43-5b3b-7e87-2dcbe434f519@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <205f093a-8b43-5b3b-7e87-2dcbe434f519@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/11 08:17, Sidhartha Kumar 写道:
> On 10/9/23 8:03 PM, Peng Zhang wrote:
>> Hi,
>>
>> 在 2023/10/10 04:16, Sidhartha Kumar 写道:
>>> Preallocate maple nodes before call to mas_wr_store_entry(). If a new
>>> node is not needed, go directly to mas_wr_store_entry(), otherwise
>>> allocate the needed nodes and set the MA_STATE_PREALLOC flag.
>>>
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>> ---
>>>   lib/maple_tree.c | 22 +++++++++++++++++++---
>>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>> index e239197a57fc..25ae66e585f4 100644
>>> --- a/lib/maple_tree.c
>>> +++ b/lib/maple_tree.c
>>> @@ -5478,17 +5478,33 @@ int mas_prealloc_calc(struct ma_wr_state *wr_mas)
>>>   int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
>>>   {
>>>       MA_WR_STATE(wr_mas, mas, entry);
>>> +    int request;
>>>       mas_wr_store_setup(&wr_mas);
>>> -    trace_ma_write(__func__, mas, 0, entry);
>>> -retry:
>>> +    wr_mas.content = mas_start(mas);
>>> +
>>> +    request = mas_prealloc_calc(&wr_mas);
>> mas_wr_store_entry() does something similar to mas_prealloc_calc().
>> Now, making it do it twice would incur additional overhead.
>> We encountered this issue while optimizing preallocation, but it
>> hasn't been resolved yet. Previously, this problem only occurred
>> when using mas_preallocate(). Now, this change would bring this
>> impact to all write operations on maple tree. What do you think
>> about it?
>>
> 
> After talking to Liam, I will have to implement the store type enum feature on the Maple Tree Work list so that mas_prealloc_calc() can start a partial walk and write that information to the enum. mas_wr_store_entry() can then read that enum to continue the walk that was already started rather than having to redo the whole walk. This could also be used in mas_preallocate(). Do you have any suggestions for the implementation of this enum?
There is another scenario where this enum can be useful,
as seen in the implementation of mas_replace_entry() in [1].
It is a faster alternative to mas_store(), but it is not safe.
If we can determine through the enum while writing the maple
tree that a faster write operation can be performed, it would
be beneficial. Some performance improvements can also be
observed in [1].

[1] https://lore.kernel.org/lkml/49f0181a-55a4-41aa-8596-877560c8b802@bytedance.com/
> 
> Thanks,
> Sid
> 
>> Thanks,
>> Peng
>>> +    if (!request)
>>> +        goto store_entry;
>>> +
>>> +    mas_node_count_gfp(mas, request, gfp);
>>> +    if (unlikely(mas_is_err(mas))) {
>>> +        mas_set_alloc_req(mas, 0);
>>> +        mas_destroy(mas);
>>> +        mas_reset(mas);
>>> +        return xa_err(mas->node);
>>> +    }
>>> +    mas->mas_flags |= MA_STATE_PREALLOC;
>>> +
>>> +store_entry:
>>>       mas_wr_store_entry(&wr_mas);
>>>       if (unlikely(mas_nomem(mas, gfp)))
>>> -        goto retry;
>>> +        goto store_entry;
>>>       if (unlikely(mas_is_err(mas)))
>>>           return xa_err(mas->node);
>>> +    trace_ma_write(__func__, mas, 0, entry);
>>>       return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(mas_store_gfp);
>>
> 
> 
