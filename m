Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5507661CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjG1Ceu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjG1Ces (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:34:48 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7499E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:34:46 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7654e1d83e8so131532585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690511686; x=1691116486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV2OpDFH9mfKiN5o/E3y0+fHFzEHfVifc7bcrvvmdpQ=;
        b=UCo6nPeWk10retrRAhiA6H/0n5V5NFnkQ751kF/vzVAogJRK/dpbvJ2g4b9H6IZCI2
         xro41pT6S1Whnx9E6Tej+DWrF9WguAIzzvVzwgrkryXtS0Dq4KDolRKNu8lQIn69uuYs
         WGDGNgzZRXaHPeESlqnZ1CfsZAXGtU8d/KrPmfXxE/nQHNkpH6tDCy5+ZWuuXrKJIZPW
         D1NZsW9BQN8miX6Rx9ZF3NAsi5bLvkme3Osc3Sijq6nUtED5JgLXQJtsA/5jkJYxIlLx
         9gJj07IG8b17oBr8Ojk3Ph2KRe2WzlKrkshjVsZiBd5EIvesEJr8cfeMLkxZWBUN/lNH
         /B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690511686; x=1691116486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iV2OpDFH9mfKiN5o/E3y0+fHFzEHfVifc7bcrvvmdpQ=;
        b=P3naQfvtZvwP99UTA7uymWuneeYBP8p79PeimFjcihNbWtlvorkprvgMNt+SolKZzO
         TGyJYDC4LGzM1A72vLZvYYZjPSuaMhhdFZHuwgSkQow5f6FS5CWMy2tUBq4/WQaUZVml
         UtbknInkp9jsJI5cW0XwXBGG9Pc4EFr3Cz9P2kiNIi32hUZgb38FUV0QGAY+EgWor86Q
         YIIu9PuezOGeZA1q1jUDjQD4QN3SMaGXvTpbtGOLzKZHVWfl/WwehSp4pmMkdZMni2P9
         gNmfqEDU4zL/uhS36Z+uRk4Yr9FM9qX3qevZ8WgGEE3TVaTkQfksqLejvSSCC9cR0n+Y
         OXpQ==
X-Gm-Message-State: ABy/qLYdw5BjjTYZGBe11/EtCo3rx3/WcDux0v7JY9L3T/r09Y3hiJnj
        5Kn9enkF3fRna+2yhlw0UpjYzQ==
X-Google-Smtp-Source: APBJJlG4B7eb1CM0q5XNynOuTLstLOf606ewnMNnGA0lykt65q4xWGc03YqffuMWfSsD75HOGencBw==
X-Received: by 2002:a05:620a:2951:b0:768:efd:2685 with SMTP id n17-20020a05620a295100b007680efd2685mr1553377qkp.33.1690511686024;
        Thu, 27 Jul 2023 19:34:46 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a19c900b00267f7405a3csm1876445pjj.32.2023.07.27.19.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 19:34:45 -0700 (PDT)
Message-ID: <4555470c-ea4f-244b-ed40-9403df3f5e4f@bytedance.com>
Date:   Fri, 28 Jul 2023 10:34:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [External] Re: [RFC PATCH 0/5] mm: Select victim memcg using
 BPF_OOM_POLICY
To:     Alan Maguire <alan.maguire@oracle.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <7dbaabf9-c7c6-478b-0d07-b4ce0d7c116c@oracle.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <7dbaabf9-c7c6-478b-0d07-b4ce0d7c116c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/7/27 19:43, Alan Maguire 写道:
> On 27/07/2023 08:36, Chuyi Zhou wrote:
>> This patchset tries to add a new bpf prog type and use it to select
>> a victim memcg when global OOM is invoked. The mainly motivation is
>> the need to customizable OOM victim selection functionality so that
>> we can protect more important app from OOM killer.
>>
> 
> It's a nice use case, but at a high level, the approach pursued here
> is, as I understand it, discouraged for new BPF program development.
> Specifically, adding a new BPF program type with semantics like this
> is not preferred. Instead, can you look at using something like
> 
> - using "fmod_ret" instead of a new program type
> - use BPF kfuncs instead of helpers.
> - add selftests in tools/testing/selftests/bpf not samples.
> 
> There's some examples of how solutions have evolved from the traditional
> approach (adding a new program type, helpers etc) to using kfuncs etc on
> this list - for example HID-BPF and the BPF scheduler series - which
> should help orient you. There are presentations from Linux Plumbers 2022
> that walk through some of this too.
> 
> Judging by the sample program example, all you should need here is a way
> to override the return value of bpf_oom_set_policy() - a noinline
> function that by default returns a no-op. It can then be overridden by
> an "fmod_ret" BPF program.
> 
Indeed, I'll try to use kfuncs & fmod_ret.

Thanks for your advice.
--
Chuyi Zhou
> One thing you lose is cgroup specificity at BPF attach time, but you can
> always add predicates based on the cgroup to your BPF program if needed.
> 
> Alan
> 
>> Chuyi Zhou (5):
>>    bpf: Introduce BPF_PROG_TYPE_OOM_POLICY
>>    mm: Select victim memcg using bpf prog
>>    libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
>>    bpf: Add a new bpf helper to get cgroup ino
>>    bpf: Sample BPF program to set oom policy
>>
>>   include/linux/bpf_oom.h        |  22 ++++
>>   include/linux/bpf_types.h      |   2 +
>>   include/linux/memcontrol.h     |   6 ++
>>   include/uapi/linux/bpf.h       |  21 ++++
>>   kernel/bpf/core.c              |   1 +
>>   kernel/bpf/helpers.c           |  17 +++
>>   kernel/bpf/syscall.c           |  10 ++
>>   mm/memcontrol.c                |  50 +++++++++
>>   mm/oom_kill.c                  | 185 +++++++++++++++++++++++++++++++++
>>   samples/bpf/Makefile           |   3 +
>>   samples/bpf/oom_kern.c         |  42 ++++++++
>>   samples/bpf/oom_user.c         | 128 +++++++++++++++++++++++
>>   tools/bpf/bpftool/common.c     |   1 +
>>   tools/include/uapi/linux/bpf.h |  21 ++++
>>   tools/lib/bpf/libbpf.c         |   3 +
>>   tools/lib/bpf/libbpf_probes.c  |   2 +
>>   16 files changed, 514 insertions(+)
>>   create mode 100644 include/linux/bpf_oom.h
>>   create mode 100644 samples/bpf/oom_kern.c
>>   create mode 100644 samples/bpf/oom_user.c
>>
