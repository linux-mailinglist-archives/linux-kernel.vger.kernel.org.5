Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ECF793CD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbjIFMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIFMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:38:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E021992
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:37:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-570a432468bso659201a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694003878; x=1694608678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0bKcsUZrDLfGK82pb7CdvyyKC8wqtZ9yLfdwnJHBSQ=;
        b=g425VIT627FohsNj8JM83LVELJktmAD9on4EdLGJNQAkiW26X64XaQT6Z8PnTAB/kz
         m21QV+r6gojdGfCirqVssDhWK5TNPluYEjSTWeL3MA23pKomJuy1RYx99xGo1CU/28Ue
         dpZe3iv4UHOFi77BZxariktLWOvZTx5vfo6hGUOB3tflEZU3/iDGFjUMCtmxnuQoMZFu
         N0bH380jJS7Qhv6eQIzJBYGR73oI1ib5QsCECemx0Ns4Ue/dCo3eu64kvEYjWpWnrAJt
         71QMzE0h1HJ2dpyfK7XaZAOE7M9GH0eRABfjvWpiED2APvSTCim/MOpWwzXQ95rZkIvx
         f0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003878; x=1694608678;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J0bKcsUZrDLfGK82pb7CdvyyKC8wqtZ9yLfdwnJHBSQ=;
        b=OEq4YEw1SEYi62RGsDmC5s4gVAdiZ1feb4QRiwrWbFogSLgUUOe3if9qqmKXtEIWLR
         pFeCgLfJoHiFNRZhHk+ZsQDKGzfndnYcyfabGXD+1lL2vnm3fFZDpkl+Smdu0+xcq5MV
         VCpNgGb+we+8Utn9xxsmC8td0k/VDG06LzLXBXaFqDaInhoiUYD7xlpKu2jKpBf856B9
         Y3yImOgt5kMzWkDTXwd3vEn/nnc2Q+FFn/GHe/Qp2vIf9ML0t638Zktl4c87u2hF+V+E
         S/OevnAorwbkFnaTvX8aOsbcKeTGqcHx3RpEZmXhBU6edu8rxmYdsisHLeI0+fYH+guB
         kcwQ==
X-Gm-Message-State: AOJu0YzB3cOgV4Jg+0iPVW6kIaqDv6mMGoKHYPKWabkS/PWYkKwer87E
        N0bFn+TCQaBL87HxD5z2nTcfZQ==
X-Google-Smtp-Source: AGHT+IGhX8cSPoKUgMI/duSqg60zplBgTNG7dvqSfAfLagdbivIrDQm13gTTkN0SrQzIMcdMyWvosA==
X-Received: by 2002:a17:90b:4a83:b0:26b:4e40:7be6 with SMTP id lp3-20020a17090b4a8300b0026b4e407be6mr20992741pjb.20.1694003877481;
        Wed, 06 Sep 2023 05:37:57 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001b531e8a000sm10994282plb.157.2023.09.06.05.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:37:57 -0700 (PDT)
Message-ID: <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com>
Date:   Wed, 6 Sep 2023 20:37:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
 iterator kfuncs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-3-zhouchuyi@bytedance.com>
 <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
In-Reply-To: <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alexei.

在 2023/9/6 04:09, Alexei Starovoitov 写道:
> On Sun, Aug 27, 2023 at 12:21 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_process in open-coded iterator
>> style. BPF programs can use these kfuncs or through bpf_for_each macro to
>> iterate all processes in the system.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/uapi/linux/bpf.h       |  4 ++++
>>   kernel/bpf/helpers.c           |  3 +++
>>   kernel/bpf/task_iter.c         | 31 +++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  4 ++++
>>   tools/lib/bpf/bpf_helpers.h    |  5 +++++
>>   5 files changed, 47 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 2a6e9b99564b..cfbd527e3733 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
>>          __u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>
>> +struct bpf_iter_process {
>> +       __u64 __opaque[1];
>> +} __attribute__((aligned(8)));
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index cf113ad24837..81a2005edc26 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
>> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index b1bdba40b684..a6717a76c1e0 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>>          kfree(kit->css_it);
>>   }
>>
>> +struct bpf_iter_process_kern {
>> +       struct task_struct *tsk;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
>> +{
>> +       struct bpf_iter_process_kern *kit = (void *)it;
>> +
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) != sizeof(struct bpf_iter_process));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=
>> +                                       __alignof__(struct bpf_iter_process));
>> +
>> +       rcu_read_lock();
>> +       kit->tsk = &init_task;
>> +       return 0;
>> +}
>> +
>> +__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it)
>> +{
>> +       struct bpf_iter_process_kern *kit = (void *)it;
>> +
>> +       kit->tsk = next_task(kit->tsk);
>> +
>> +       return kit->tsk == &init_task ? NULL : kit->tsk;
>> +}
>> +
>> +__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
>> +{
>> +       rcu_read_unlock();
>> +}
> 
> This iter can be used in all ctx-s which is nice, but let's
> make the verifier enforce rcu_read_lock/unlock done by bpf prog
> instead of doing in the ctor/dtor of iter, since
> in sleepable progs the verifier won't recognize that body is RCU CS.
> We'd need to teach the verifier to allow bpf_iter_process_new()
> inside in_rcu_cs() and make sure there is no rcu_read_unlock
> while BPF_ITER_STATE_ACTIVE.
> bpf_iter_process_destroy() would become a nop.

Thanks for your review!

I think bpf_iter_process_{new, next, destroy} should be protected by 
bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable or 
not, right? I'm not very familiar with the BPF verifier, but I believe 
there is still a risk in directly calling these kfuns even if 
in_rcu_cs() is true.

Maby what we actually need here is to enforce BPF verifier to check 
env->cur_state->active_rcu_lock is true when we want to call these kfuncs.

Thanks.


