Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0647C7AACC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjIVIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:36:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BB899
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:36:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so1491252b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695371775; x=1695976575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RICN8tort+CWLhQVSIa56+kaySuy9xkNGnfuP8kUQqc=;
        b=ai9yrCLfMgYecX1TwSjw1MSxfZ+DTTw9hIpklIUEzd9HwAEZwDRRhdonxBnuj9mCSf
         6yYHNUFLOOmvwL2gtoRTzlRQyAFkdEw7Qs//kym4jZC+oNCt4GqF9SZD+weCsbpay59I
         JNUnWpn72CeAZksLhCaRHiroAJi2Ej2HcGBY7zT/uE+ewxi2aPvbO4OXwXR7BA/ngyF4
         EbyJwZhsP3SZo16GTeCWYLfFivM9snZ1654VapK7vL95EXIJNWnA5bpL91XcG+z5hAPN
         K/ZGfp2YKsDcza//zlI0yKhvR039lVl7eZwGyEtKRDG3ESKIY5W22Io/t5ijpXqOtIFv
         GaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695371775; x=1695976575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RICN8tort+CWLhQVSIa56+kaySuy9xkNGnfuP8kUQqc=;
        b=XUV3bKy4+t3qgCF/WJMjecFu1MVug0lXp9TAPNxJLYMMMiZQp62CBU/MOhpV3Hetpx
         zxm20MORPx3/BBace//Wf26Q3xPiSR5ihfbJixBrFvSvwel9HOW1B0O6ufMY8bQ13u1g
         3IpTzd7lR3bSaIZ4dVmH/7JosSzgjbJYVJTIfTs7sFRMbbXcXquIaMmpjfVEuTx1GACX
         oDpCqglLHRyT/EV4Wf3tt0YRJNDq2UB7r39nW0A1xMipbgPwQvpPT9rY1uF1/VdQZseM
         Hgl0CC8/MrvVeRKiJ/xTKb62MGAKGO1IcR7zJkCl6lzClxSbmsaz6AKmUYURafYS//Op
         fEiQ==
X-Gm-Message-State: AOJu0YziQlOEnGzfITLH5Iquz3bhpCVBIMMrLF2vNNqZg4iAq4aTZaZm
        Nxn1VIe3jgB07DCQQ0BBNZGICs5/qVDZHvO9sqU=
X-Google-Smtp-Source: AGHT+IHQicYWUr71AoSVKdMJTN6JBrukXsgFBu6GSXWiWDNZ+lmpI706oyztJpAziLn93L03VpRJ3g==
X-Received: by 2002:a05:6a20:9187:b0:15a:2d98:bc81 with SMTP id v7-20020a056a20918700b0015a2d98bc81mr8767748pzd.53.1695371775244;
        Fri, 22 Sep 2023 01:36:15 -0700 (PDT)
Received: from [10.254.1.169] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902708100b001bb0eebd90asm2860013plk.245.2023.09.22.01.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 01:36:14 -0700 (PDT)
Message-ID: <82c0a442-c7d7-d0f1-54de-7a5e7e6a31d5@bytedance.com>
Date:   Fri, 22 Sep 2023 16:36:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Re: [PATCH net-next 2/2] sock: Fix improper heuristic on raising
 memory
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
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230921190156.s4oygohw4hud42tx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 3:01 AM, Shakeel Butt wrote:
> On Wed, Sep 20, 2023 at 09:25:41PM +0800, Abel Wu wrote:
>> Before sockets became aware of net-memcg's memory pressure since
>> commit e1aab161e013 ("socket: initial cgroup code."), the memory
>> usage would be granted to raise if below average even when under
>> protocol's pressure. This provides fairness among the sockets of
>> same protocol.
>>
>> That commit changes this because the heuristic will also be
>> effective when only memcg is under pressure which makes no sense.
>> Fix this by skipping this heuristic when under memcg pressure.
>>
>> Fixes: e1aab161e013 ("socket: initial cgroup code.")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   net/core/sock.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 379eb8b65562..ef5cf6250f17 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3093,8 +3093,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>>   	if (sk_has_memory_pressure(sk)) {
>>   		u64 alloc;
>>   
>> -		if (!sk_under_memory_pressure(sk))
>> +		if (memcg && mem_cgroup_under_socket_pressure(memcg))
>> +			goto suppress_allocation;
>> +
>> +		if (!sk_under_global_memory_pressure(sk))
>>   			return 1;
> 
> I am onboard with replacing sk_under_memory_pressure() with
> sk_under_global_memory_pressure(). However suppressing on memcg pressure
> is a behavior change from status quo and need more thought and testing.
> 
> I think there are three options for this hunk:
> 
> 1. proposed patch
> 2. Consider memcg pressure only for !in_softirq().
> 3. Don't consider memcg pressure at all.
> 
> All three options are behavior change from the status quo but with
> different risk levels. (1) may reintroduce the regression fixed by
> 720ca52bcef22 ("net-memcg: avoid stalls when under memory pressure").

Just for the record, it is same for the current upstream implementation
if the socket reaches average usage. Taking option 2 will fix this too.

> (2) is more inlined with 720ca52bcef22. (3) has the risk to making memcg
> limits ineffective.
> 
> IMHO we should go with (2) as there is already a precedence in
> 720ca52bcef22.

Yes, I agree. Actually applying option(2) would make this patch quite
similar to the previous version[a], except the below part:

  	/* Under limit. */
  	if (allocated <= sk_prot_mem_limits(sk, 0)) {
  		sk_leave_memory_pressure(sk);
-		return 1;
+		if (!under_memcg_pressure)
+			return 1;
  	}

My original thought is to inherit the behavior of tcpmem pressure.
There are also 3 levels of memcg pressure named low/medium/critical,
but considering that the 'low' level is too much conservative for
socket allocation, I made the following match:

	PROTOCOL	MEMCG		ACTION
	-----------------------------------------------------
	low		<medium		allow allocation
	pressure	medium		be more conservative
	high		critical	throttle

which also seems align with the design[b] of memcg pressure. Anyway
I will take option (2) and post v2.

Thanks & Best,
	Abel

[a] 
https://lore.kernel.org/lkml/20230901062141.51972-4-wuyun.abel@bytedance.com/
[b] 
https://docs.kernel.org/admin-guide/cgroup-v1/memory.html#memory-pressure
