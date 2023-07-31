Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2B769685
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGaMjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjGaMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:39:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E9170D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:39:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bb7b8390e8so26372315ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690807156; x=1691411956;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5NgvZ9A29jKveNvgwtvgi3sdFeOXOueGUD09TUlxVA=;
        b=fnctZrGhAzwe97DicT5XCVwUO4Xd6tq/dYHAm6TPZLTxdk+/8dy9q4eiR0ZfUARhtk
         z+JyDdBRU5LhRcPyOBUJSgoFncv15bcX6jTkw+XK48unXj16idPYEVnFPl8YyVv0X1bM
         FEtZW7AnaL9+05V8HDGBJF8au+/vPqQYvAuOXIpxZBbxCI+3csMLoptZh4paFzXEABNZ
         L4SzBBgbDey9NPN+xSxlBHae745fXUEHJ1jnBrSKI2yGSrB9SA5/pGW1xJN5Nociy/ww
         2+TzvKqEmjKQw685vftI/MDh5CYzJ3TQFAxLbGuwPmq45N8Tdcvp4aww+dOooCGnkhvK
         /STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807156; x=1691411956;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5NgvZ9A29jKveNvgwtvgi3sdFeOXOueGUD09TUlxVA=;
        b=dP7+isE5cg379usltNo1W6m2/LzgQbml6cW0dZIGAn9kgznfB/uKbB04YOxOpASSNr
         3VDgREIOj1KPaT8WntU8M7/PBTnJz2tups5rSeS2vRMoaVcauNIc/2HFOD8GvmZGNND1
         I8ASYf/k6cxNF06wPLplhb9dWojg3yx+zlbqHpIXYph3ekUN4nk05lctn2HhAsJFlZKL
         3RdISvVOEjrvg4HxCtBeZesE7xpTkeCRUsJAkhyGZVqSSp/jdmkpsxUOhEQgnbGig034
         KfesXvwdKesjaIUyPcU5Gk4BRo6/c1ZlT2Ztrg7VB0Wyp6Yz+eu+C0J6xOkaUxolnTx9
         kpBg==
X-Gm-Message-State: ABy/qLYCBT/MPahJUvydv393gnjf4S83ImwsdZEdBpSDH4LP/sHq6bMH
        YV5SgMuroez/kC+V0ebqT2WLsw==
X-Google-Smtp-Source: APBJJlFVfGFHwn+cuilEGPeVmX2wQ3sz8gt7+UDhpECer+ohY8c5OWE/UOCFJ2jjsiLxm6zBbXQYVg==
X-Received: by 2002:a17:902:ea05:b0:1b9:f9a1:85f1 with SMTP id s5-20020a170902ea0500b001b9f9a185f1mr10946935plg.19.1690807156084;
        Mon, 31 Jul 2023 05:39:16 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001b89c313185sm8505332plx.205.2023.07.31.05.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:39:15 -0700 (PDT)
Message-ID: <20aab1af-c183-db94-90d7-5e5425e3fd80@bytedance.com>
Date:   Mon, 31 Jul 2023 20:39:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH 06/11] maple_tree: Introduce mas_replace_entry() to
 directly replace an entry
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-7-zhangpeng.00@bytedance.com>
 <20230726160843.hpl4razxiikqbuxy@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, avagin@gmail.com,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, michael.christie@oracle.com,
        surenb@google.com, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230726160843.hpl4razxiikqbuxy@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/27 00:08, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
>> If mas has located a specific entry, it may be need to replace this
>> entry, so introduce mas_replace_entry() to do this. mas_replace_entry()
>> will be more efficient than mas_store*() because it doesn't do many
>> unnecessary checks.
>>
>> This function should be inline, but more functions need to be moved to
>> the header file, so I didn't do it for the time being.
> 
> I am really nervous having no checks here.  I get that this could be
> used for duplicating the tree more efficiently, but having a function
> that just swaps a value in is very dangerous - especially since it is
> decoupled from the tree duplication code.
I've thought about this, and I feel like this is something the user
should be guaranteed. If the user is not sure whether to use it,
mas_store() can be used instead. And we should provide this interface
because it has better performance.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   include/linux/maple_tree.h |  1 +
>>   lib/maple_tree.c           | 25 +++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> index 229fe78e4c89..a05e9827d761 100644
>> --- a/include/linux/maple_tree.h
>> +++ b/include/linux/maple_tree.h
>> @@ -462,6 +462,7 @@ struct ma_wr_state {
>>   
>>   void *mas_walk(struct ma_state *mas);
>>   void *mas_store(struct ma_state *mas, void *entry);
>> +void mas_replace_entry(struct ma_state *mas, void *entry);
>>   void *mas_erase(struct ma_state *mas);
>>   int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
>>   void mas_store_prealloc(struct ma_state *mas, void *entry);
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index efac6761ae37..d58572666a00 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -5600,6 +5600,31 @@ void *mas_store(struct ma_state *mas, void *entry)
>>   }
>>   EXPORT_SYMBOL_GPL(mas_store);
>>   
>> +/**
>> + * mas_replace_entry() - Replace an entry that already exists in the maple tree
>> + * @mas: The maple state
>> + * @entry: The entry to store
>> + *
>> + * Please note that mas must already locate an existing entry, and the new entry
>> + * must not be NULL. If these two points cannot be guaranteed, please use
>> + * mas_store*() instead, otherwise it will cause an internal error in the maple
>> + * tree. This function does not need to allocate memory, so it must succeed.
>> + */
>> +void mas_replace_entry(struct ma_state *mas, void *entry)
>> +{
>> +	void __rcu **slots;
>> +
>> +#ifdef CONFIG_DEBUG_MAPLE_TREE
>> +	MAS_WARN_ON(mas, !mte_is_leaf(mas->node));
>> +	MAS_WARN_ON(mas, !entry);
>> +	MAS_WARN_ON(mas, mas->offset >= mt_slots[mte_node_type(mas->node)]);
>> +#endif
>> +
>> +	slots = ma_slots(mte_to_node(mas->node), mte_node_type(mas->node));
>> +	rcu_assign_pointer(slots[mas->offset], entry);
>> +}
>> +EXPORT_SYMBOL_GPL(mas_replace_entry);
>> +
>>   /**
>>    * mas_store_gfp() - Store a value into the tree.
>>    * @mas: The maple state
>> -- 
>> 2.20.1
>>
