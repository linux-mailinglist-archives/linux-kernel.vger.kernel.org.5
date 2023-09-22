Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF37AAF30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjIVKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjIVKKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:10:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE4F7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:10:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-274df3878a2so1359137a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695377414; x=1695982214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2ufTk+SzQXAhmOt0ss0e42lnYpRlYTzhmX5B7/leRY=;
        b=FFJ4HrP3kPrgXxxsiKz6vEPbePxc89gPQznYNlgPstWun+Xe7k144ikeKa0v53JCyX
         DXhWWBlZF3RBytQ3qzdo1Qco9FG7M5bybQ594j6LWUJoYFR6tG1we9jMltkbliv57U3s
         WCnIDsn1SBcgCS7H9mgbTnazqr9uQCgft4b3Shr4mRyA5Bcp0iyEhYRUxA3LVXO/ezqE
         TQONTeB2T+syxInIddzgoIw0XUABv2L1xGxrX83CLjFCp25oDdykSWLT7pY7lcSV+HTa
         /nG0yARncmNNVXcSIpx5oqZxBVK1sc4jgaMGjyWag/+1H4YQJsbVTvZ+cRm7eE2meChl
         PSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695377414; x=1695982214;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2ufTk+SzQXAhmOt0ss0e42lnYpRlYTzhmX5B7/leRY=;
        b=gr4Iaf/L60hKQm2aVh07iEWY9JlscEOBifXFTFoeVN+OvikYIVcZrSUTVq/g3Jrx8P
         PLZrhFhI4tvy0D8LdQuO7TpIIMpo6m5G9Uw/uJfETGY2RhOLLRLubF4yxAAxEASPGfTx
         EDupwsRVt/KbaawHPXSMYUheR9HuM4DAgh9W+LLNwH1uppcL9Pj7xmwAs7sO2vQz6iO3
         BYhUaPsqLWaJVV5legmXbohcT+55PvH7pu9xc+/qEj2jd49V3xE3SyAReaRVupSt+31S
         Z+y0PHpEYqjxQLZbX+50jOv86uExFvf2+pumzXnr32KvBxWHrj8tD1Q2STEGC78tNTDK
         2Vfg==
X-Gm-Message-State: AOJu0Yy7HVZn0JwmEJB+oROffQVTUQ1hhWaZa8zukIditdT4txPI/e4W
        DDhoT8wSCq5X83E4dJ3zkwJFsBRbCh478F/XHk4=
X-Google-Smtp-Source: AGHT+IEvTnBwyn42Dtb8JwSLkt4T9yGIU/WtgulmCFaF4ocTFB5yZsK0JYM/GWXqXuL1KyVp/lyo+w==
X-Received: by 2002:a17:90b:390a:b0:268:3f2d:66e4 with SMTP id ob10-20020a17090b390a00b002683f2d66e4mr7502221pjb.37.1695377414528;
        Fri, 22 Sep 2023 03:10:14 -0700 (PDT)
Received: from [10.254.1.169] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a001600b0026b4d215627sm3186459pja.21.2023.09.22.03.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 03:10:14 -0700 (PDT)
Message-ID: <71ac08d3-9f36-e0de-870e-3e252abcb66a@bytedance.com>
Date:   Fri, 22 Sep 2023 18:10:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 2/2] sock: Fix improper heuristic on raising
 memory
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230920132545.56834-1-wuyun.abel@bytedance.com>
 <20230920132545.56834-2-wuyun.abel@bytedance.com>
 <20230921190156.s4oygohw4hud42tx@google.com>
 <82c0a442-c7d7-d0f1-54de-7a5e7e6a31d5@bytedance.com>
In-Reply-To: <82c0a442-c7d7-d0f1-54de-7a5e7e6a31d5@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 4:36 PM, Abel Wu wrote:
> On 9/22/23 3:01 AM, Shakeel Butt wrote:
>> On Wed, Sep 20, 2023 at 09:25:41PM +0800, Abel Wu wrote:
>>> Before sockets became aware of net-memcg's memory pressure since
>>> commit e1aab161e013 ("socket: initial cgroup code."), the memory
>>> usage would be granted to raise if below average even when under
>>> protocol's pressure. This provides fairness among the sockets of
>>> same protocol.
>>>
>>> That commit changes this because the heuristic will also be
>>> effective when only memcg is under pressure which makes no sense.
>>> Fix this by skipping this heuristic when under memcg pressure.
>>>
>>> Fixes: e1aab161e013 ("socket: initial cgroup code.")
>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>> ---
>>>   net/core/sock.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>> index 379eb8b65562..ef5cf6250f17 100644
>>> --- a/net/core/sock.c
>>> +++ b/net/core/sock.c
>>> @@ -3093,8 +3093,16 @@ int __sk_mem_raise_allocated(struct sock *sk, 
>>> int size, int amt, int kind)
>>>       if (sk_has_memory_pressure(sk)) {
>>>           u64 alloc;
>>> -        if (!sk_under_memory_pressure(sk))
>>> +        if (memcg && mem_cgroup_under_socket_pressure(memcg))
>>> +            goto suppress_allocation;
>>> +
>>> +        if (!sk_under_global_memory_pressure(sk))
>>>               return 1;
>>
>> I am onboard with replacing sk_under_memory_pressure() with
>> sk_under_global_memory_pressure(). However suppressing on memcg pressure
>> is a behavior change from status quo and need more thought and testing.
>>
>> I think there are three options for this hunk:
>>
>> 1. proposed patch
>> 2. Consider memcg pressure only for !in_softirq().
>> 3. Don't consider memcg pressure at all.
>>
>> All three options are behavior change from the status quo but with
>> different risk levels. (1) may reintroduce the regression fixed by
>> 720ca52bcef22 ("net-memcg: avoid stalls when under memory pressure").
> 
> Just for the record, it is same for the current upstream implementation
> if the socket reaches average usage. Taking option 2 will fix this too.
> 
>> (2) is more inlined with 720ca52bcef22. (3) has the risk to making memcg
>> limits ineffective.
>>
>> IMHO we should go with (2) as there is already a precedence in
>> 720ca52bcef22.
> 
> Yes, I agree. Actually applying option(2) would make this patch quite
> similar to the previous version[a], except the below part:
> 
>       /* Under limit. */
>       if (allocated <= sk_prot_mem_limits(sk, 0)) {
>           sk_leave_memory_pressure(sk);
> -        return 1;
> +        if (!under_memcg_pressure)
> +            return 1;
>       }

After a second thought, it is still vague to me about the position
the memcg pressure should be in socket memory allocation. It lacks
convincing design. I think the above hunk helps, but not much.

I wonder if we should take option (3) first. Thoughts?

Thanks,
	Abel

> 
> My original thought is to inherit the behavior of tcpmem pressure.
> There are also 3 levels of memcg pressure named low/medium/critical,
> but considering that the 'low' level is too much conservative for
> socket allocation, I made the following match:
> 
>      PROTOCOL    MEMCG        ACTION
>      -----------------------------------------------------
>      low        <medium        allow allocation
>      pressure    medium        be more conservative
>      high        critical    throttle
> 
> which also seems align with the design[b] of memcg pressure. Anyway
> I will take option (2) and post v2.
> 
> Thanks & Best,
>      Abel
> 
> [a] 
> https://lore.kernel.org/lkml/20230901062141.51972-4-wuyun.abel@bytedance.com/
> [b] 
> https://docs.kernel.org/admin-guide/cgroup-v1/memory.html#memory-pressure
