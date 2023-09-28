Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2707B10F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjI1CwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1CwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:52:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478694
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:51:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690bd59322dso9658221b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695869510; x=1696474310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxowYtqCHs25qaqAMSozKR4qYyXzSppOa5N6Ri1v7lw=;
        b=V/AUFgeVnMxiWuev+g71ntnlhTFnh3fmdxhsURsp9MlliZH9b+mw5RlLrtNLwON2iv
         66gIgOdN0dz8tROhDCmgTHnr2ZTfa5oeQehHAx04SgDDsw8DnYB4xTTxaWT3uToHS36H
         heApkcxDQeoLP1wXRjvKIF6hr9/x4PB4rT6AgP5f/vULA0ezpkXBmN4bzYVATSj5gyU9
         3PX6rLhjLOFxu4g46ee3lCky+XqCB6gSOK4Tw3por5lwc18cEHIcGCKbRwr7BgUjvmcW
         BNS4WsrEeyidcvA05+mAKFw8/gt5M0UsFx8pj045r28z06LBLiihxwT5K+lYdB4m5IiG
         6seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695869510; x=1696474310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZxowYtqCHs25qaqAMSozKR4qYyXzSppOa5N6Ri1v7lw=;
        b=Nu2wxMlufrLAhhtx06aUvgAC3sB3sgL4Lu9ZxXyReBYgjNnZhVqbTQpJ4f7o623vyY
         /ZX3bSIJJT1pa/6lslg06bKUfabIPq3bJpEEnX+88e11xTuxDktyKCUj+dIEb2bIsyRw
         iEOxnfdmI+1lfIaNTgwhPcG/zr2Tc05TmPPixqqy7g+FA96ApYSctaz4a+cVr7IW7MA+
         ut0gRfOAFT5roATgMpMZIlCICRJeXTM+0zk3seE3tIV9KCvqRD1wt6ln4IRLY2z54UtA
         Flp5ixZgOgx0GrxScb2nP/A0HQXcSX5fCSOu91WbgFMCM+0cxGRYT2kUAYenVkSttnvE
         Bupg==
X-Gm-Message-State: AOJu0YzcYHG6jMZV+wxQ4KH60yKFNqeUucAZkjzAoJA5dNGDYcTDP7fY
        xAlkI9qrMrGIykzoECShrM8CdLPV5W9l/GnUIew=
X-Google-Smtp-Source: AGHT+IGV6hbjpD+iwlxnv3egrK1x6PxftppEsP97nF7d/SVaEZe4d9dHDpT0zGQ0GKrkPxmq43gp3A==
X-Received: by 2002:a05:6a20:3d0f:b0:135:110c:c6e1 with SMTP id y15-20020a056a203d0f00b00135110cc6e1mr9636pzi.7.1695869509996;
        Wed, 27 Sep 2023 19:51:49 -0700 (PDT)
Received: from [10.255.173.165] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a191c00b0026801e06ac1sm13818445pjg.30.2023.09.27.19.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 19:51:49 -0700 (PDT)
Message-ID: <27b57638-48db-7082-2b53-93d84e423350@bytedance.com>
Date:   Thu, 28 Sep 2023 10:51:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Introduce css open-coded iterator
 kfuncs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-5-zhouchuyi@bytedance.com>
 <CAEf4BzbYgf1t8tfQJ4xwfDH-o_3n+PRMBgC4AZRLbXGM=QJtzQ@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzbYgf1t8tfQJ4xwfDH-o_3n+PRMBgC4AZRLbXGM=QJtzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/9/28 07:24, Andrii Nakryiko 写道:
> On Mon, Sep 25, 2023 at 3:56 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_css in open-coded iterator
>> style. These kfuncs actually wrapps css_next_descendant_{pre, post}.
>> css_iter can be used to:
>>
>> 1) iterating a sepcific cgroup tree with pre/post/up order
>>
>> 2) iterating cgroup_subsystem in BPF Prog, like
>> for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.
>>
>> The API design is consistent with cgroup_iter. bpf_iter_css_new accepts
>> parameters defining iteration order and starting css. Here we also reuse
>> BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
>> BPF_CGROUP_ITER_ANCESTORS_UP enums.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/bpf/cgroup_iter.c                      | 57 +++++++++++++++++++
>>   kernel/bpf/helpers.c                          |  3 +
>>   .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
>>   3 files changed, 66 insertions(+)
>>
>> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
>> index 810378f04fbc..ebc3d9471f52 100644
>> --- a/kernel/bpf/cgroup_iter.c
>> +++ b/kernel/bpf/cgroup_iter.c
>> @@ -294,3 +294,60 @@ static int __init bpf_cgroup_iter_init(void)
>>   }
>>
>>   late_initcall(bpf_cgroup_iter_init);
>> +
>> +struct bpf_iter_css {
>> +       __u64 __opaque[2];
>> +       __u32 __opaque_int[1];
>> +} __attribute__((aligned(8)));
>> +
> 
> same as before, __opaque[3] only
> 
> 
>> +struct bpf_iter_css_kern {
>> +       struct cgroup_subsys_state *start;
>> +       struct cgroup_subsys_state *pos;
>> +       int order;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
>> +               struct cgroup_subsys_state *start, enum bpf_cgroup_iter_order order)
> 
> Similarly, I wonder if we should go for a more generic "flags" argument?
> 
>> +{
>> +       struct bpf_iter_css_kern *kit = (void *)it;
> 
> empty line
> 
>> +       kit->start = NULL;
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
> 
> please move this up before kit->start assignment, and separate by empty lines
> 
>> +       switch (order) {
>> +       case BPF_CGROUP_ITER_DESCENDANTS_PRE:
>> +       case BPF_CGROUP_ITER_DESCENDANTS_POST:
>> +       case BPF_CGROUP_ITER_ANCESTORS_UP:
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       kit->start = start;
>> +       kit->pos = NULL;
>> +       kit->order = order;
>> +       return 0;
>> +}
>> +
>> +__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
>> +{
>> +       struct bpf_iter_css_kern *kit = (void *)it;
> 
> empty line
> 
>> +       if (!kit->start)
>> +               return NULL;
>> +
>> +       switch (kit->order) {
>> +       case BPF_CGROUP_ITER_DESCENDANTS_PRE:
>> +               kit->pos = css_next_descendant_pre(kit->pos, kit->start);
>> +               break;
>> +       case BPF_CGROUP_ITER_DESCENDANTS_POST:
>> +               kit->pos = css_next_descendant_post(kit->pos, kit->start);
>> +               break;
>> +       default:
> 
> we know it's BPF_CGROUP_ITER_ANCESTORS_UP, so why not have that here explicitly?
> 
>> +               kit->pos = kit->pos ? kit->pos->parent : kit->start;
>> +       }
>> +
>> +       return kit->pos;
> 
> wouldn't this implementation never return the "start" css? is that intentional?
> 

Thanks for the review.

This implementation actually would return the "start" css.

1. BPF_CGROUP_ITER_DESCENDANTS_PRE:
1.1 when we first call next(), css_next_descendant_pre(NULL, kit->start) 
will return kit->start.
1.2 second call next(), css_next_descendant_pre(kit->start, kit->start) 
would return a first valid child under kit->start with pre-order
1.3 third call next, css_next_descendant_pre(last_valid_child, 
kit->start) would return the next valid child
...
util css_next_descendant_pre return a NULL pointer, which means we have 
visited all valid child including "start" css itself.

The above logic is equal to macro 'css_for_each_descendant_pre' in kernel.

Same, BPF_CGROUP_ITER_DESCENDANTS_POST is equal to macro 
'css_for_each_descendant_post' which would return 'start' css when we 
have visited all valid child.

2. BPF_CGROUP_ITER_ANCESTORS_UP
2.1 when we fisrt call next(), kit->pos is NULL, and we would return 
kit->start.


The selftest in patch7 whould check:
1. when we use BPF_CGROUP_ITER_DESCENDANTS_PRE to iterate a cgroup tree, 
the first cgroup we visted should be root('start') cgroup.
2. when we use BPF_CGROUP_ITER_DESCENDANTS_POST to iterate a cgroup 
tree, the last cgroup we visited should be root('start') cgroup.


Am I miss something important?


Thanks.



