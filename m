Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D317E77EF33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347698AbjHQCvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347699AbjHQCv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:51:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D739271E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:51:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68879c4cadeso1372544b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692240688; x=1692845488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TD6mNxeyw+U1f9pkCyXqwGO/txSI845aPMGT3hSQf0=;
        b=jizqnOxjdEbUD5086Ckpc7OSvC4Rk9TkWmZE7lpEUUGVhg+QcTTlPi9anyttQVFXd2
         +sDEHFe2C/NC2V6iRyU+EQZXreN8vAXEZ8Etz+T/FUws0cd6VUk0yIlS7A3lCYHPCA+Y
         YdIt/IHzdQcsfP4Nx8JLC8RqbG2m7srUR8jw9BZyK2VJXbKm/UjmNkKumZ4qQNaOuamg
         ZSiuR1IzvO6h3FpsnKHreFP3JcWyY+8ixLtKbz40IDLZRZq5tkqx6dnRcKqcYZrst10e
         v776ZLIytHkGoJRWQiXHvK/qkCVpdNwGWO60juMTlgV3tkqk4WuN1pBfA8t4vM9ZuNS8
         Zfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692240688; x=1692845488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1TD6mNxeyw+U1f9pkCyXqwGO/txSI845aPMGT3hSQf0=;
        b=ljllPp7XzZaib339L5v32FdyqASsEzlY/BrFSUUj8CNkLtR1DNJbqJfAjyCdsrwIL5
         katstIhbpjSsAN7u0Varj0da+zOiDX6n1iCU3049uO8zQH2/vladvGr80OVEvQv4x+oO
         qMC/OQEP1V1g3sIOZCNkSujaEih/eA9rbCdD8+Gg00nwPwNyLVLUYRo5n1sUNvADNxBx
         Zw43hrJaEQlVT9ISFnT6aufTdGhGz49R20bxAnASBq6b1XdSBWdVDQjpc7xRV0sZM/5d
         EugBjNw6DP8NC/gjOFPBAS7/csnVle+YkWFjziqLQ9QK3vyt+dkx0pAjc94Qv05SlZmB
         MBcQ==
X-Gm-Message-State: AOJu0YwE/RyklDWVYaDXtBSNDnJL35tDVO5TTCc4xe2KrkWJ0xi5NMgW
        lVQ4TmV4nwJKM+0DAEto5kGaoA==
X-Google-Smtp-Source: AGHT+IHfb0/3FQbkhCSWRAodHC02wS+x8X5xLd/zAGU4Lf/Hcv1saB6KyDx5K03DjGqOSi9A5G1DFQ==
X-Received: by 2002:a05:6a20:8f07:b0:13d:bd0e:33d9 with SMTP id b7-20020a056a208f0700b0013dbd0e33d9mr4945857pzk.47.1692240687678;
        Wed, 16 Aug 2023 19:51:27 -0700 (PDT)
Received: from [10.255.89.48] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id j15-20020aa78d0f000000b00687dde8ae5dsm11692252pfe.154.2023.08.16.19.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 19:51:27 -0700 (PDT)
Message-ID: <93627e45-dc67-fd31-ef43-a93f580b0d6e@bytedance.com>
Date:   Thu, 17 Aug 2023 10:51:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, muchun.song@linux.dev,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Michal Hocko <mhocko@suse.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
 <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/8/17 10:07, Alexei Starovoitov 写道:
> On Thu, Aug 10, 2023 at 1:13 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>   static int oom_evaluate_task(struct task_struct *task, void *arg)
>>   {
>>          struct oom_control *oc = arg;
>> @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>>          if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
>>                  goto next;
>>
>> +       /*
>> +        * If task is allocating a lot of memory and has been marked to be
>> +        * killed first if it triggers an oom, then select it.
>> +        */
>> +       if (oom_task_origin(task)) {
>> +               points = LONG_MAX;
>> +               goto select;
>> +       }
>> +
>> +       switch (bpf_oom_evaluate_task(task, oc)) {
>> +       case BPF_EVAL_ABORT:
>> +               goto abort; /* abort search process */
>> +       case BPF_EVAL_NEXT:
>> +               goto next; /* ignore the task */
>> +       case BPF_EVAL_SELECT:
>> +               goto select; /* select the task */
>> +       default:
>> +               break; /* No BPF policy */
>> +       }
>> +
> 
> I think forcing bpf prog to look at every task is going to be limiting
> long term.
> It's more flexible to invoke bpf prog from out_of_memory()
> and if it doesn't choose a task then fallback to select_bad_process().
> I believe that's what Roman was proposing.
> bpf can choose to iterate memcg or it might have some side knowledge
> that there are processes that can be set as oc->chosen right away,
> so it can skip the iteration.

IIUC, We may need some new bpf features if we want to iterating 
tasks/memcg in BPF, sush as:
bpf_for_each_task
bpf_for_each_memcg
bpf_for_each_task_in_memcg
...

It seems we have some work to do first in the BPF side.
Will these iterating features be useful in other BPF scenario except OOM 
Policy?

Thanks.
