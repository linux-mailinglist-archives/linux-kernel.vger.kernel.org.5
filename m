Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85C7B6966
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjJCMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJCMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:49:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB09A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:49:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so622223b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696337356; x=1696942156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SN3E964ODCJjpz85I+WSpRkPsUEBZcxQzYCTWvMspok=;
        b=FSR/D/BGssyVjkBE3jLTpQOdL2tRItJq+u4rAEFew31UK4bf0BrQBKM6WqxGR1GRii
         H82vTH2wciOLlkDT+IoUnIfkV15RZb96WZM0IzOjgLjwaaojyoJQtdOEPVPeCib7Cw4K
         Gl3IZn74Gs7M6vJ/2VOdXdztWfnTjdPdf7Zz6pV4nEUQ7E0k/HjYUnC7erwf7Le/LArJ
         yhGwl1WY9lzMo76UHHLEUYDfAKbtK6MrqegPQXMi9M22tqHJ03TKjtxs2Tty6UBCewHq
         faL6HxefbQfOdo5pqVxEFXZsD4iIAup04vkVaS0Xo5VLjnCVxhvOP8Fj/abRu9+xgU2N
         akxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337356; x=1696942156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN3E964ODCJjpz85I+WSpRkPsUEBZcxQzYCTWvMspok=;
        b=YZyfJb+Fqs+CGw5992vH+HigP7WbOFOxikgewZM7y8XQ55q7K5CQnW9dOf4djeeZSp
         S+1Dq2apUdDvNnmAy/nmPgzNsyRe3knhNRbynL2ldzTwYXoWzpjZtC3C40BdqWwb7wdA
         Md51uev0EZ3y6P+QqQG/yR/cndWDIKK0ilI66OzeNyQMW/vnPEWsQqRcy7A9/+ePhiDc
         aANHTS6FSlKLXzGHAOcJr//GyERk0sYnOOFib6diLipijDEgtIKtHWVgFYbC9zGFDgND
         Unfr12zPEY4vzSlthc39bhzt9ibFSaVpf7E1lrj4GZPkblO0M9nJMh9Nqo3lRqI/nMRt
         iWKQ==
X-Gm-Message-State: AOJu0YyGg58UP8QgsLnYiN9qgix4CIEt+4fwtknUJodAudJeEc0cT53z
        ZS6tOSpnbJ+RPKE41zHdlxEsQA==
X-Google-Smtp-Source: AGHT+IGmzT37smXXRQ4PsSss9CA8pDZ6W57Ijm1sqNx8jWDBtXv6OD9Mq/KH3oO/wvqAbx4zHux8dg==
X-Received: by 2002:a05:6a00:1254:b0:691:2d4:238e with SMTP id u20-20020a056a00125400b0069102d4238emr12585943pfi.6.1696337356110;
        Tue, 03 Oct 2023 05:49:16 -0700 (PDT)
Received: from [10.254.175.124] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id q17-20020a62e111000000b0068ff6d21563sm1311489pfh.148.2023.10.03.05.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 05:49:15 -0700 (PDT)
Message-ID: <7551924f-a9b6-4bb8-bfe9-e3efcf0da438@bytedance.com>
Date:   Tue, 3 Oct 2023 20:49:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net-next 2/2] sock: Fix improper heuristic on raising
 memory
Content-Language: en-US
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
 <71ac08d3-9f36-e0de-870e-3e252abcb66a@bytedance.com>
 <20230924072816.6ywgoe7ab2max672@google.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230924072816.6ywgoe7ab2max672@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/23 3:28 PM, Shakeel Butt wrote:
> On Fri, Sep 22, 2023 at 06:10:06PM +0800, Abel Wu wrote:
> [...]
>>
>> After a second thought, it is still vague to me about the position
>> the memcg pressure should be in socket memory allocation. It lacks
>> convincing design. I think the above hunk helps, but not much.
>>
>> I wonder if we should take option (3) first. Thoughts?
>>
> 
> Let's take a step further. Let's decouple the memcg accounting and
> global skmem accounting. __sk_mem_raise_allocated is already very hard
> to reason. There are couple of heuristics in it which may or may not
> apply to both accounting infrastructures.
> 
> Let's explicitly document what heurisitics allows to forcefully succeed
> the allocations i.e. irrespective of pressure or over limit for both
> accounting infras. I think decoupling them would make the flow of the
> code very clear.

I can't agree more.

> 
> There are three heuristics:

I found all of them were first introduced in linux-2.4.0-test7pre1 for
TCP only, and then migrated to socket core in linux-2.6.8-rc1 without
functional change.

> 
> 1. minimum buffer size even under pressure.

This is required by RFC 7323 (TCP Extensions for High Performance) to
make features like Window Scale option work as expected, and should be
succeeded under global pressure by tcp_{r,w}mem's definition. And IMHO
for same reason, it should also be succeeded under memcg pressure, or
else workloads might suffer performance drop due to bottleneck on
network.

The allocation must not be succeeded either exceed global or memcg's
hard limit, or else a DoS attack can be taken place by spawning lots
of sockets that are under minimum buffer size.

> 
> 2. allow allocation for a socket whose usage is below average of the
> system.

Since 'average' is within the scope of global accounting, this one
only makes sense under global memory pressure. Actually this exists
before cgroup was born, hence doesn't take memcg into consideration.

While OTOH the intention of throttling under memcg pressure is to
relief the memcg from heavy reclaim pressure, this heuristic does no
help. And there also seems to be no reason to succeed the allocation
when global or memcg's hard limit is exceeded.

> 
> 3. socket is over its sndbuf.

TBH I don't get its point..

> 
> Let's discuss which heuristic applies to which accounting infra and
> under which state (under pressure or over limit).

I will follow your suggestion to post a patch to explicitly document
the behaviors once things are cleared.

Thanks,
	Abel
