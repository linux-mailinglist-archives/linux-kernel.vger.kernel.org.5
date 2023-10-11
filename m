Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D17C4818
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjJKDEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbjJKDEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:04:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEBD94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:04:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c61bde0b4bso54618675ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696993450; x=1697598250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmOoxk1/4ULEWBIvY+2e6ZipmyTDyhJB3Su15S4VKgs=;
        b=Ypa8qBFYccImZP3P279f74e5Q36u8hBGBU4D5PjUPS9JVwzoP1neVwUf8rz9FxqmQ2
         /QPYIdGmrAaLFGA5OLKi1Ml33BJ47SyhPDdYj1G/oAxP/0Y14SKs0rJVoQoujJBvNoRI
         AGeysw5k45T1NgNZChgh3RCZtCW80XNykkAKCfCiiuemrc2YOIt9TAPpJqNVZ4CoAiTW
         Nfz2oHIp7GSttg7/U0MgFsLRUalfciLc/WGZI2YiM9RboIXbOwIYvyuTTUB6z8pEApVC
         oE78BvogxMx0vXpYtUejwwLGPgC7bfMJ/OY+YcO19OFwXVIsJ3hDSVqbiDnUSiZW66kC
         9NwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696993450; x=1697598250;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmOoxk1/4ULEWBIvY+2e6ZipmyTDyhJB3Su15S4VKgs=;
        b=lE8yn3K5oOheKz0n25l/pmmQ1rMTlTYpJrtyUUCvNzAbPxpxzcUue+lABwLo4c8s2r
         kyc6wruynKFXJDxgckLl/v8OgE68GAfdO6Y/Kw1Urk9Y9wcxib0Jd2J0QU9CUyrGowr+
         OD5KvPHumKjfQar+d0Ypw+v8L3MJjTIEHT1trjB+4VuPl+wQW3QX4lZEzxLVHMlgohR7
         uzbQ/rAzBA63tFNbvT/9i1wh+UD+JrDWwbbVLPOnw58+sV9CzvhSYwBS87khToHQNnbd
         F0vk1NnLnqjmUdesBEJN3rRj2iFDJmYA370skGeY2LDL+OY9fqtWBIXwpEfSTA9TT+xw
         2NXw==
X-Gm-Message-State: AOJu0YzejYnFJIh+vNN3Xgzg5zXmjpNYeL1S3CcQmEK9C89S5WNXbJ/z
        7l16HYFZvpIi4F75b8C/ee9aMw==
X-Google-Smtp-Source: AGHT+IFeo3XT9BsMlJkF0rjOb7ZLje1UhfK77ixmrw1d3/fcMJMncpt3wFt7Q2BhoNZeP6nD88dXMQ==
X-Received: by 2002:a17:902:ecce:b0:1c6:2acc:62d5 with SMTP id a14-20020a170902ecce00b001c62acc62d5mr24305694plh.22.1696993449955;
        Tue, 10 Oct 2023 20:04:09 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm12587260plg.62.2023.10.10.20.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 20:04:09 -0700 (PDT)
Message-ID: <83352a11-cb54-477d-b19a-5f9e0d00b54d@bytedance.com>
Date:   Wed, 11 Oct 2023 11:04:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230920132545.56834-1-wuyun.abel@bytedance.com>
 <20230920132545.56834-2-wuyun.abel@bytedance.com>
 <20230921190156.s4oygohw4hud42tx@google.com>
 <82c0a442-c7d7-d0f1-54de-7a5e7e6a31d5@bytedance.com>
 <71ac08d3-9f36-e0de-870e-3e252abcb66a@bytedance.com>
 <20230924072816.6ywgoe7ab2max672@google.com>
 <7551924f-a9b6-4bb8-bfe9-e3efcf0da438@bytedance.com>
In-Reply-To: <7551924f-a9b6-4bb8-bfe9-e3efcf0da438@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping :)

在 10/3/23 8:49 PM, Abel Wu Wrote:
> On 9/24/23 3:28 PM, Shakeel Butt wrote:
>> On Fri, Sep 22, 2023 at 06:10:06PM +0800, Abel Wu wrote:
>> [...]
>>>
>>> After a second thought, it is still vague to me about the position
>>> the memcg pressure should be in socket memory allocation. It lacks
>>> convincing design. I think the above hunk helps, but not much.
>>>
>>> I wonder if we should take option (3) first. Thoughts?
>>>
>>
>> Let's take a step further. Let's decouple the memcg accounting and
>> global skmem accounting. __sk_mem_raise_allocated is already very hard
>> to reason. There are couple of heuristics in it which may or may not
>> apply to both accounting infrastructures.
>>
>> Let's explicitly document what heurisitics allows to forcefully succeed
>> the allocations i.e. irrespective of pressure or over limit for both
>> accounting infras. I think decoupling them would make the flow of the
>> code very clear.
> 
> I can't agree more.
> 
>>
>> There are three heuristics:
> 
> I found all of them were first introduced in linux-2.4.0-test7pre1 for
> TCP only, and then migrated to socket core in linux-2.6.8-rc1 without
> functional change.
> 
>>
>> 1. minimum buffer size even under pressure.
> 
> This is required by RFC 7323 (TCP Extensions for High Performance) to
> make features like Window Scale option work as expected, and should be
> succeeded under global pressure by tcp_{r,w}mem's definition. And IMHO
> for same reason, it should also be succeeded under memcg pressure, or
> else workloads might suffer performance drop due to bottleneck on
> network.
> 
> The allocation must not be succeeded either exceed global or memcg's
> hard limit, or else a DoS attack can be taken place by spawning lots
> of sockets that are under minimum buffer size.
> 
>>
>> 2. allow allocation for a socket whose usage is below average of the
>> system.
> 
> Since 'average' is within the scope of global accounting, this one
> only makes sense under global memory pressure. Actually this exists
> before cgroup was born, hence doesn't take memcg into consideration.
> 
> While OTOH the intention of throttling under memcg pressure is to
> relief the memcg from heavy reclaim pressure, this heuristic does no
> help. And there also seems to be no reason to succeed the allocation
> when global or memcg's hard limit is exceeded.
> 
>>
>> 3. socket is over its sndbuf.
> 
> TBH I don't get its point..
> 
>>
>> Let's discuss which heuristic applies to which accounting infra and
>> under which state (under pressure or over limit).
> 
> I will follow your suggestion to post a patch to explicitly document
> the behaviors once things are cleared.
> 
> Thanks,
>      Abel
