Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB9878E8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbjHaIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbjHaIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:45:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A4CED
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:45:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68bed2c786eso451268b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693471533; x=1694076333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNxZe7wq6zfCLgqQzHCfOQafdDDt4naDzhWZ4W2JCy0=;
        b=V+mYZRQio5HPSbcI31mPQVxC7r29mwPfHr6mnsTIwjpRWGyIR2a1GY7UFbbb61uqZx
         Qo/pI0evzkdZjd/gG7lcZ3p8ERqn1xmmozT4E8h+RCuuDPj6179u1WFQPzMS4p8W2ULf
         HXEJGuR+T1YS96wHqsZlkDC1Y+r0RBRl75mcJRymNXlcKPbEifIVZJwtHWD3wbB3M3j6
         ZEV8qa3ZGc6lA7HOd5k+/v8xDq6i2G4wEi5/T4gmVa+wSmolUZrPUEiJBuT69EkFWxlB
         aPMeLh5BlNbpcwCm1C8HTXJSZgLn5kA1VLgLKzYjcwC9HFdHJb8O812gomEkI0co4GtD
         cxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693471533; x=1694076333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNxZe7wq6zfCLgqQzHCfOQafdDDt4naDzhWZ4W2JCy0=;
        b=O+4D/z+4bhkbMV9otnXbuLfNsEPv8279NsmISoRH3c8d+56BaKtNlpaTmu5cTHx3uK
         elkc9WxQlpCBr7fPGHL9L61mkBIoD2D1NappOgZAnRzXTZKy6wj/qxrd3214jZT0kI1A
         91VjnawTFr9Lh/zTVEGIWTlMV0TePPndcyBclCi2tkBTnKUf0XYau7J11voUTPC//cTf
         iYE/pLLrzbi5DNnXLxSzdJhq1a1TbrwxCcerjNJPls8Ey7C4AN3Ady3srGP/rabwq5LK
         +1eeb0jh9rAcIw2dlo4A+1F8sjBVVAC0IJhDyeXC6ODAVKGRv/t5R/LROJo1byiywJj7
         katQ==
X-Gm-Message-State: AOJu0Ywcalhg04FYKzzELh3dFEs4nVOFiLq8hLi8Y0s3Dn6mzen5cQn3
        oBYW93wnFLDfsAazzBQ0NxurJR+J6TNp+CCoFi4=
X-Google-Smtp-Source: AGHT+IHmDx6e4zcXFyVDOOb6K6jjaG05hYVckI6PjHTSQt3YBiSkSKUf78rOgWt26G+FeWf5a+kTUg==
X-Received: by 2002:a05:6a00:148f:b0:68b:dd1d:4932 with SMTP id v15-20020a056a00148f00b0068bdd1d4932mr5037278pfu.33.1693471533186;
        Thu, 31 Aug 2023 01:45:33 -0700 (PDT)
Received: from [10.254.254.90] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id k30-20020a637b5e000000b0056b920051b3sm930402pgn.7.2023.08.31.01.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:45:32 -0700 (PDT)
Message-ID: <6f663185-2ef1-5075-99c9-e16050329d74@bytedance.com>
Date:   Thu, 31 Aug 2023 16:45:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <87v8cv22jh.fsf@mail.lhotse>
 <CAMuHMdXMpr0spdprjwsV56nJE3vHGTFaodcnVXUa=GMYaB5yKw@mail.gmail.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <CAMuHMdXMpr0spdprjwsV56nJE3vHGTFaodcnVXUa=GMYaB5yKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/31 16:25, Geert Uytterhoeven 写道:
> Hi Michael,
> 
> On Thu, Aug 31, 2023 at 7:39 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>> On Fri, 18 Aug 2023, Liam R. Howlett wrote:
>>>> The current implementation of append may cause duplicate data and/or
>>>> incorrect ranges to be returned to a reader during an update.  Although
>>>> this has not been reported or seen, disable the append write operation
>>>> while the tree is in rcu mode out of an abundance of caution.
>>>>
>>>> During the analysis of the mas_next_slot() the following was
>>>> artificially created by separating the writer and reader code:
>>>>
>>>> Writer:                                 reader:
>>>> mas_wr_append
>>>>     set end pivot
>>>>     updates end metata
>>>>     Detects write to last slot
>>>>     last slot write is to start of slot
>>>>     store current contents in slot
>>>>     overwrite old end pivot
>>>>                                         mas_next_slot():
>>>>                                                 read end metadata
>>>>                                                 read old end pivot
>>>>                                                 return with incorrect range
>>>>     store new value
>>>>
>>>> Alternatively:
>>>>
>>>> Writer:                                 reader:
>>>> mas_wr_append
>>>>     set end pivot
>>>>     updates end metata
>>>>     Detects write to last slot
>>>>     last lost write to end of slot
>>>>     store value
>>>>                                         mas_next_slot():
>>>>                                                 read end metadata
>>>>                                                 read old end pivot
>>>>                                                 read new end pivot
>>>>                                                 return with incorrect range
>>>>     set old end pivot
>>>>
>>>> There may be other accesses that are not safe since we are now updating
>>>> both metadata and pointers, so disabling append if there could be rcu
>>>> readers is the safest action.
>>>>
>>>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>>
>>> Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
>>> ("maple_tree: disable mas_wr_append() when other readers are
>>> possible") in v6.5, and is being backported to stable.
>>>
>>> On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
>>> following warning:
>>>
>>>        clocksource: timer@e803b000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 28958491609 ns
>>>        sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 32537631224ns
>>>        /soc/timer@e803b000: used for clocksource
>>>        /soc/timer@e803c000: used for clock events
>>>       +------------[ cut here ]------------
>>>       +WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480
>>>       +Interrupts were enabled early
>> ...
>>>
>>> I do not see this issue on any other platform
>>> (arm/arm64/risc-v/mips/sh/m68k), several of them use the same
>>> RCU configuration.
>>
>> There's something similar on pmac32 / mac99.
>>
>>> Do you have a clue?
>>
>> It seems something in the maple tree code is setting TIF_NEED_RESCHED,
>> and that causes a subsequent call to cond_resched() to call schedule()
>> and enable interrupts.
>>
>> On pmac32 enabling CONFIG_DEBUG_ATOMIC_SLEEP fixes/hides the problem.
>> But I don't see why.
> 
> Enabling CONFIG_DEBUG_ATOMIC_SLEEP on RZ/A1 and RZ/A2 does
> fix the problem.
> But there must be more to it, as some of my test configs had it enabled,
> and others hadn't, while only RZ/A showed the issue.
> I tried disabling it on R-Car M2-W (arm32) and R-Car H3 (arm64), and
> that did not cause the problem to happen...

I guess this patch triggers a potential problem with the maple tree.
I don't have the environment to trigger the problem. Can you apply the
following patch to see if the problem still exists? This can help locate
the root cause. At least narrow down the scope of the code that has bug.

Thanks.

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f723024e1426..1b4b6f6e3095 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4351,9 +4351,6 @@ static inline void mas_wr_modify(struct 
ma_wr_state *wr_mas)
  	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
  		return;

-	if (mas_wr_node_store(wr_mas, new_end))
-		return;
-
  	if (mas_is_err(mas))
  		return;


> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
