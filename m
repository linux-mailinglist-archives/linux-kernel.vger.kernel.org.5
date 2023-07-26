Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D19763082
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGZIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjGZIvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:51:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54916597
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:44:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so252745b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690361075; x=1690965875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaHVQJdsQFWkcZBsx/T38G+Lqdb6Whv+CYMlwTb7aHo=;
        b=W+EanSUlLb0IGwq3cqcllspMnd3tUPyj31OymLbNzWRw2Mib/39CPdtiQOifF0ZSc5
         5O6JPEAAkD+WNzZeYqwGtNprVuBi9/h5937q4EAzrX1aZUYbKYA0NjoqJpKJrQuRRdzY
         5tGTvyajdtHNdEk3h7retqoeRnvxvm+AJMyCmw8p1+tTmyD5odyJZ+PYWpF0tFDTLDrC
         D6QOv7OQxqA/isASWaSoMHqL711oBKs93+5SvEWbCnweovlFRX5fNI7Ug2RKJyM16PCl
         vpMqwLrx0LW3PypNKK5hzgqJuHdHBi8ZDc+oPWmdc5b9HcGFOPKuW/YtHz88IfXSvHTS
         t3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690361075; x=1690965875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaHVQJdsQFWkcZBsx/T38G+Lqdb6Whv+CYMlwTb7aHo=;
        b=lsumIoVu3tUVvKyKX0GVh1novmKZKx+AtNyfUb1nl+ZTCvMIb0iYbt1/21OyMVZ397
         o6UmhLWs2J5wt0H6wIRLJ5x5Nucn98iYjQ6dhP5b2A8i5/jySuEgHglVN/S6vIlsRPR6
         1+UjTSA4iFP578lPhNWTtMNbSVLMmw8hDUG2DKt7NSJQcOw5EmXByw5NkDNv9FHaMPOZ
         nVXWHHUiEK95e4DFfuQtzrCkOyPbNJJ7jSFH7T1celrhGt/6KH1q/hWCtLfHWj8gnYzz
         SPs9J4HHZQN1oxXQaiHy5YKKzhzLcAk0dlHmL1adofOyIii5ThfSoBQKXNLX90bYzRoa
         kjPA==
X-Gm-Message-State: ABy/qLa3Fn/5iOFLMRSNom73S6sLVgGTUEfH/Q2Zg9b2aWgLas9j/DE6
        zl1txP/z8fAKtftU2mLRfDiJzA==
X-Google-Smtp-Source: APBJJlFvYnSn4ZZ+O3SIpkv4jtIYxlgXOxE89PbGNUcmqXLAozlbdFXGBYOXeawoBUpQByVxpmrpXg==
X-Received: by 2002:a05:6a20:9188:b0:12c:f124:5b72 with SMTP id v8-20020a056a20918800b0012cf1245b72mr1224570pzd.43.1690361075154;
        Wed, 26 Jul 2023 01:44:35 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11bb:1457:9302:1528:c8f4? ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b006828ee9fdaesm10879530pfo.127.2023.07.26.01.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:44:34 -0700 (PDT)
Message-ID: <29de901f-ae4c-a900-a553-17ec4f096f0e@bytedance.com>
Date:   Wed, 26 Jul 2023 16:44:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators
 of sockmem pressure
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <ZLsg1wklldKkVI2Z@P9FQF9L96D.corp.robot.car>
 <58e75f44-16e3-a40a-4c8a-0f61bbf393f9@bytedance.com>
 <ZMCLTQgVT68jwbVh@P9FQF9L96D>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZMCLTQgVT68jwbVh@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 10:56 AM, Roman Gushchin wrote:
> On Mon, Jul 24, 2023 at 11:47:02AM +0800, Abel Wu wrote:
>> Hi Roman, thanks for taking time to have a look!
>>>
>>>> When in legacy mode aka. cgroupv1, the socket memory is charged
>>>> into a separate counter memcg->tcpmem rather than ->memory, so
>>>> the reclaim pressure of the memcg has nothing to do with socket's
>>>> pressure at all.
>>>
>>> But we still might set memcg->socket_pressure and propagate the pressure,
>>> right?
>>
>> Yes, but the pressure comes from memcg->socket_pressure does not mean
>> pressure in socket memory in cgroupv1, which might lead to premature
>> reclamation or throttling on socket memory allocation. As the following
>> example shows:
>>
>> 			->memory	->tcpmem
>> 	limit		10G		10G
>> 	usage		9G		4G
>> 	pressure	true		false
> 
> Yes, now it makes sense to me. Thank you for the explanation.

Cheers!

> 
> Then I'd organize the patchset in the following way:
> 1) cgroup v1-only fix to not throttle tcpmem based on the vmpressure
> 2) a formal code refactoring

OK, I will take a try to re-organize in next version.

>>>
>>> Overall I think it's a good idea to clean these things up and thank you
>>> for working on this. But I wonder if we can make the next step and leave only
>>> one mechanism for both cgroup v1 and v2 instead of having this weird setup
>>> where memcg->socket_pressure is set differently from different paths on cgroup
>>> v1 and v2.
>>
>> There is some difficulty in unifying the mechanism for both cgroup
>> designs. Throttling socket memory allocation when memcg is under
>> pressure only makes sense when socket memory and other usages are
>> sharing the same limit, which is not true for cgroupv1. Thoughts?
> 
> I see... Generally speaking cgroup v1 is considered frozen, so we can leave it
> as it is, except when it creates an unnecessary complexity in the code.

Are you suggesting that the 2nd patch can be ignored and keep
->tcpmem_pressure as it is? Or keep the 2nd patch and add some
explanation around as you suggested in last reply?

> 
> I'm curious, was your work driven by some real-world problem or a desire to clean
> up the code? Both are valid reasons of course.

We (a cloud service provider) are migrating users to cgroupv2,
but encountered some problems among which the socket memory
really puts us in a difficult situation. There is no specific
threshold for socket memory in cgroupv2 and relies largely on
workloads doing traffic control themselves.

Say one workload behaves fine in cgroupv1 with 10G of ->memory
and 1G of ->tcpmem, but will suck (or even be OOMed) in cgroupv2
with 11G of ->memory due to burst memory usage on socket.

It's rational for the workloads to build some traffic control
to better utilize the resources they bought, but from kernel's
point of view it's also reasonable to suppress the allocation
of socket memory once there is a shortage of free memory, given
that performance degradation is better than failure.

Currently the mechanism of net-memcg's pressure doesn't work as
we expected, please check the discussion in [1]. Besides this,
we are also working on mitigating the priority inversion issue
introduced by the net protocols' global shared thresholds [2],
which has something to do with the net-memcg's pressure. This
patchset and maybe some other are byproducts of the above work.

[1] 
https://lore.kernel.org/netdev/20230602081135.75424-1-wuyun.abel@bytedance.com/
[2] 
https://lore.kernel.org/netdev/20230609082712.34889-1-wuyun.abel@bytedance.com/

Thanks!
	Abel
