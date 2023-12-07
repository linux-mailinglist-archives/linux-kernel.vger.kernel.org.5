Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE8807F25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjLGDZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLGDZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:25:40 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3FE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 19:25:20 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-590711b416fso64504eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 19:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701919520; x=1702524320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7AHndxWz2DLeIzHjloCHoJF/ew41gSasKy9MKVjd14=;
        b=WB4yV9cswbi1Z048oEIzJ+ro3KMTYqmpkQPly8zsRTRwGz0ZiT/Ip/SQmeljr/kWwf
         zMjCs+X1MgBG8EPlh5zw03ySoEFpsQQwHlDrtTxQ8OoXE1y8Ke4Jg6DycpqSk84eG64k
         VdkRn+RmEkz5NIB2aACyZTc2hu+o7SL2kRSWqQMb5nl7vkrJHRRY0hC/v0u/EC/2NSEG
         nqHBzWaX904GQoIIcm2eEIfMJBdg1jajPe4FiJB4ZT/J+XuZVZ2bsSeLq6WssfbrWLHG
         wxsm3or7sDjE/rSqOZascSk6A4AkiueGcQa/zjyHdQ6qDwfRaQqLs/gaykVVUIi7tVYA
         rlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701919520; x=1702524320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7AHndxWz2DLeIzHjloCHoJF/ew41gSasKy9MKVjd14=;
        b=tbkDFHswMzT4OsIf/OV+Js+LDQ+QrdmhSgcj2/ZSw51KUelBTdOh7nN4uy5089RnYD
         32WTPO6VNahYAnZ3SkvrvcTw8Dz3YYh0kX/g+XlwZE2NcoxMo+j9MofupQ+pcZY8i3Qu
         FL6eSRM+1TSWJI2Pqfdqau6B8VdK4NWLf8UD6ZXjQSHcLq/sE4yLvY7l5v+hZgpg4hPu
         XwGvm+CLgXjFyR9k24zkSsL6CzP98SQc3bN6dCFEEbdfiVaRokA+RmoJT7IzuvH4DbNT
         iNn0KvvpXcpkBjq43Yp6C0++HNXoHmi95ruLZgaoC80XkuJ3hluo8hW4/lx6mltIzeRd
         vqHw==
X-Gm-Message-State: AOJu0Yy9DE6RZxJJv7r0POSm2QQRFJKGj4JiGjUx7vWgNwHxhJm9AN3N
        wZdg0kXp40jjZZuVvUZQzYWTkg==
X-Google-Smtp-Source: AGHT+IF9dASApVLNt143xv+CQnmNd4Vw0TKYepOrvkaRJ4bcMsv5nb6UbIXp0Xdwqd1HtU+w5ugw4Q==
X-Received: by 2002:a05:6358:5e11:b0:16d:fb29:d78 with SMTP id q17-20020a0563585e1100b0016dfb290d78mr2688671rwn.2.1701919519707;
        Wed, 06 Dec 2023 19:25:19 -0800 (PST)
Received: from [10.255.200.168] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id a2-20020a62d402000000b006ce95e37a40sm261930pfh.111.2023.12.06.19.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 19:25:19 -0800 (PST)
Message-ID: <77d628dc-ab8c-4d8c-bc63-7e4518ea92d7@bytedance.com>
Date:   Thu, 7 Dec 2023 11:25:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
Content-Language: en-US
To:     Chris Li <chriscli@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Nhat Pham <nphamcs@gmail.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=NXcY3_GuKbh0=Ceg9wj=7u4y0NgmfSVEG3-+deY0jiWQ@mail.gmail.com>
 <CAJD7tkbErWz7Rjn-JdY8LjSW=GzEyyrNeJ5P1ipChFSufmQmLQ@mail.gmail.com>
 <CAF8kJuMegmMD3+YZfvsW3h1y1z1-kH7SiyJHPVnrSc89OZASuA@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAF8kJuMegmMD3+YZfvsW3h1y1z1-kH7SiyJHPVnrSc89OZASuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 2023/12/7 08:43, Chris Li wrote:
> Hi Nhat and Yosry,
> 
> On Wed, Dec 6, 2023 at 12:42 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> On Wed, Dec 6, 2023 at 9:24 AM Nhat Pham <nphamcs@gmail.com> wrote:
>>>
>>> + Chris Li
>>>
>>> Chris, I vaguely remember from our last conversation that you have
>>> some concurrent efforts to use xarray here right?
> 
> Yes, I do have the zswap xarray for older versions of the kernel. The
> recent mm-unstable tree has  a lot of zswap related updates. Give me 2
> days to refresh and post it. The zswap invalid entry and the reference
> count change is causing a good portion of the code to be updated. That
> is the price to pay keeping out of tree patches. My fault is not
> getting to it sooner.
> 
>>
>> If I recall correctly, the xarray already reduces the lock contention
>> as lookups are lockless, but Chris knows more here. As you mentioned
> 
> Yes. To be exact, xarray can use spin lock (same as current RB tree)
> or take RCU read lock on the lookup path (depending on how you call
> the xarray API). Not completely lockless but the RCU read lock should
> have less lock contention than normal spinlock. +Matthew
> 

Great! Lockless lookup in zswap_load() should reduce spinlock contention.
And multiple trees (multiple xarrays) can further reduce the contention
on the concurrent zswap_store() side. So it's complementary IMHO.

>> in a different email, it would be nice to get some data so that we can
>> compare different solutions.
> 
> Yes, it is certainly welcome to see more data points. If I recall
> correctly, the zswap xarray array makes the lookup similar to the swap
> cache lookup. It has a noticeable difference in the long tail end.
> 

Right, I post some data from yesterday in another reply.
Will test again and update the data since Nhat's zswap shrinker fix patch
has been merged into mm-unstable today.

Thanks!
