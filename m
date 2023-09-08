Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B536D79839D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjIHHzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbjIHHzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:55:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A51997
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:55:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc0d39b52cso14206055ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694159729; x=1694764529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giUUe/jnEGyFiEmywWHcEaYFSDUdG775ovtenAQnoSM=;
        b=D8DLSOEL+VfBhBDdhZ00kTjMu2+kTZ5Bg7EA7YvHiAoUm6ReXoh0JmNGX9gfTg4fW0
         UzHZWR7cWyURV6kN7cbu9RjoHQjdxVnmDImmbiqrqacKovPEqM3FYwTHa6quxCp+jA2z
         NyOwqFVpQfMCzng7FehfNtZln8aBxGy50xOe6cUXvz2+XMotON0RlWQmKUWsH1bwPIXy
         fnrvhzChtldvOzmfX9m5WN4gemcqj9L+qsgJqptGWt8Wt6POYxhtwP1tdztmURzof5wL
         IBZCwnjadtnukvMYYrWqFhGRuMPHo52917aAQ21waYZp1s4gHQ8PTT4+YyL7k6158atR
         AtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694159729; x=1694764529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giUUe/jnEGyFiEmywWHcEaYFSDUdG775ovtenAQnoSM=;
        b=pkXGBK1zq/EWFR8y+FJtKbT9oVfc6CIVGI9kbyO+k3SIIMBR/Jh47YWIO82/lYOw/y
         0tOFVgwyu2m0euKwqypMksJgf9X9U/O9oPbaLGzSmZUQUHqElEhFebYbb1e5ppnh3C2s
         ZkHB2de81jDbdocEFKoZWTdvOk73Jo7mRkAfQHc3iT3ck5EcgL4bbrlQ4RfHmYt6fSu+
         xLIAeAFI9LC4emuysY+kzOwro3dwQxN48vDV4vYvHASx9nU2c6h6nCHfBawbfQzOGZ/I
         xTjgH6XpSTH1MxvkBl/QVSa3ufXn3XvjM1caE2vGQRVGvozmGbo8eqHAydOpK18g4oCN
         UiIA==
X-Gm-Message-State: AOJu0YxUrgsXVKiMMlPhOspkD8TeXr0dFCIMYEQXviS+zuGo5/S7y0Y6
        iuApAYn4M4d/jVy/2lgM7OJ4cg==
X-Google-Smtp-Source: AGHT+IHC8wA/VzAMER8S/VGcxkWCjFOqx3Y1pqK7rOci8309HoiJlbcULqFpPT0Baw4zZygiJXHgpQ==
X-Received: by 2002:a17:903:2302:b0:1bc:2c58:ad97 with SMTP id d2-20020a170903230200b001bc2c58ad97mr1803370plh.22.1694159729351;
        Fri, 08 Sep 2023 00:55:29 -0700 (PDT)
Received: from [10.84.152.163] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id i9-20020a1709026ac900b001bde877a7casm942099plt.264.2023.09.08.00.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 00:55:28 -0700 (PDT)
Message-ID: <1d935bfc-50b0-54f3-22f0-d360f8a7c1ac@bytedance.com>
Date:   Fri, 8 Sep 2023 15:55:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 0/3] sock: Be aware of memcg pressure on
 alloc
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230901062141.51972-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping :)

On 9/1/23 2:21 PM, Abel Wu wrote:
> As a cloud service provider, we encountered a problem in our production
> environment during the transition from cgroup v1 to v2 (partly due to the
> heavy taxes of accounting socket memory in v1). Say one workload behaves
> fine in cgroupv1 with memcg limit configured to 10GB memory and another
> 1GB tcpmem, but will suck (or even be OOM-killed) in v2 with 11GB memory
> due to burst memory usage on socket, since there is no specific limit for
> socket memory in cgroupv2 and relies largely on workloads doing traffic
> control themselves.
> 
> It's rational for the workloads to build some traffic control to better
> utilize the resources they bought, but from kernel's point of view it's
> also reasonable to suppress the allocation of socket memory once there is
> a shortage of free memory, given that performance degradation is usually
> better than failure.
> 
> This patchset aims to be more conservative on alloc for pressure-aware
> sockets under global and/or memcg pressure, to avoid further memstall or
> possibly OOM in such case. The patchset includes:
> 
>    1/3: simple code cleanup, no functional change intended.
>    2/3: record memcg pressure level to enable fine-grained control.
>    3/3: throttle alloc for pressure-aware sockets under pressure.
> 
> The whole patchset focuses on the pressure-aware protocols, and should
> have no/little impact on pressure-unaware protocols like UDP etc.
> 
> Tested on Intel Xeon(R) Platinum 8260, a dual socket machine containing 2
> NUMA nodes each of which has 24C/48T. All the benchmarks are done inside a
> separate memcg in a clean host.
> 
>    baseline:	net-next c639a708a0b8
>    compare:	baseline + patchset
> 
> case            	load    	baseline(std%)	compare%( std%)
> tbench-loopback        	thread-24	 1.00 (  0.50)	 -0.98 (  0.87)
> tbench-loopback        	thread-48	 1.00 (  0.76)	 -0.29 (  0.92)
> tbench-loopback        	thread-72	 1.00 (  0.75)	 +1.51 (  0.14)
> tbench-loopback        	thread-96	 1.00 (  4.11)	 +1.29 (  3.73)
> tbench-loopback        	thread-192	 1.00 (  3.52)	 +1.44 (  3.30)
> TCP_RR          	thread-24	 1.00 (  1.87)	 -0.87 (  2.40)
> TCP_RR          	thread-48	 1.00 (  0.92)	 -0.22 (  1.61)
> TCP_RR          	thread-72	 1.00 (  2.35)	 +2.42 (  2.27)
> TCP_RR          	thread-96	 1.00 (  2.66)	 -1.37 (  3.02)
> TCP_RR          	thread-192	 1.00 ( 13.25)	 +0.29 ( 11.80)
> TCP_STREAM      	thread-24	 1.00 (  1.26)	 -0.75 (  0.87)
> TCP_STREAM      	thread-48	 1.00 (  0.29)	 -1.55 (  0.14)
> TCP_STREAM      	thread-72	 1.00 (  0.05)	 -1.59 (  0.05)
> TCP_STREAM      	thread-96	 1.00 (  0.19)	 -0.06 (  0.29)
> TCP_STREAM      	thread-192	 1.00 (  0.23)	 -0.01 (  0.28)
> UDP_RR          	thread-24	 1.00 (  2.27)	 +0.33 (  2.82)
> UDP_RR          	thread-48	 1.00 (  1.25)	 -0.30 (  1.21)
> UDP_RR          	thread-72	 1.00 (  2.54)	 +2.99 (  2.34)
> UDP_RR          	thread-96	 1.00 (  4.76)	 +2.49 (  2.19)
> UDP_RR          	thread-192	 1.00 ( 14.43)	 -0.02 ( 12.98)
> UDP_STREAM      	thread-24	 1.00 (107.41)	 -0.48 (106.93)
> UDP_STREAM      	thread-48	 1.00 (100.85)	 +1.38 (100.59)
> UDP_STREAM      	thread-72	 1.00 (103.43)	 +1.40 (103.48)
> UDP_STREAM      	thread-96	 1.00 ( 99.91)	 -0.25 (100.06)
> UDP_STREAM      	thread-192	 1.00 (109.83)	 -3.67 (104.12)
> 
> As patch 3 moves forward traversal of cgroup hierarchy for pressure-aware
> protocols, which could turn a conditional overhead into constant, tests
> running inside 5-level-depth cgroups are also performed.
> 
> case            	load    	baseline(std%)	compare%( std%)
> tbench-loopback        	thread-24	 1.00 (  0.59)	 +0.68 (  0.09)
> tbench-loopback        	thread-48	 1.00 (  0.16)	 +0.01 (  0.26)
> tbench-loopback        	thread-72	 1.00 (  0.34)	 -0.67 (  0.48)
> tbench-loopback        	thread-96	 1.00 (  4.40)	 -3.27 (  4.84)
> tbench-loopback        	thread-192	 1.00 (  0.49)	 -1.07 (  1.18)
> TCP_RR          	thread-24	 1.00 (  2.40)	 -0.34 (  2.49)
> TCP_RR          	thread-48	 1.00 (  1.62)	 -0.48 (  1.35)
> TCP_RR          	thread-72	 1.00 (  1.26)	 +0.46 (  0.95)
> TCP_RR          	thread-96	 1.00 (  2.98)	 +0.13 (  2.64)
> TCP_RR          	thread-192	 1.00 ( 13.75)	 -0.20 ( 15.42)
> TCP_STREAM      	thread-24	 1.00 (  0.21)	 +0.68 (  1.02)
> TCP_STREAM      	thread-48	 1.00 (  0.20)	 -1.41 (  0.01)
> TCP_STREAM      	thread-72	 1.00 (  0.09)	 -1.23 (  0.19)
> TCP_STREAM      	thread-96	 1.00 (  0.01)	 +0.01 (  0.01)
> TCP_STREAM      	thread-192	 1.00 (  0.20)	 -0.02 (  0.25)
> UDP_RR          	thread-24	 1.00 (  2.20)	 +0.84 ( 17.45)
> UDP_RR          	thread-48	 1.00 (  1.34)	 -0.73 (  1.12)
> UDP_RR          	thread-72	 1.00 (  2.32)	 +0.49 (  2.11)
> UDP_RR          	thread-96	 1.00 (  2.36)	 +0.53 (  2.42)
> UDP_RR          	thread-192	 1.00 ( 16.34)	 -0.67 ( 14.06)
> UDP_STREAM      	thread-24	 1.00 (106.55)	 -0.70 (107.13)
> UDP_STREAM      	thread-48	 1.00 (105.11)	 +1.60 (103.48)
> UDP_STREAM      	thread-72	 1.00 (100.60)	 +1.98 (101.13)
> UDP_STREAM      	thread-96	 1.00 ( 99.91)	 +2.59 (101.04)
> UDP_STREAM      	thread-192	 1.00 (135.39)	 -2.51 (108.00)
> 
> As expected, no obvious performance gain or loss observed. As for the
> issue we encountered, this patchset provides better worst-case behavior
> that such OOM cases are reduced at some extent. While further fine-
> grained traffic control is what the workloads need to think about.
> 
> Comments are welcomed! Thanks!
> 
> Abel Wu (3):
>    sock: Code cleanup on __sk_mem_raise_allocated()
>    net-memcg: Record pressure level when under pressure
>    sock: Throttle pressure-aware sockets under pressure
> 
>   include/linux/memcontrol.h | 39 +++++++++++++++++++++++++----
>   include/net/sock.h         |  2 +-
>   include/net/tcp.h          |  2 +-
>   mm/vmpressure.c            |  9 ++++++-
>   net/core/sock.c            | 51 +++++++++++++++++++++++++++++---------
>   5 files changed, 83 insertions(+), 20 deletions(-)
> 
