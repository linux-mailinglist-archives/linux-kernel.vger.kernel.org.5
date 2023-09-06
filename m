Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91668793CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjIFMhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjIFMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:37:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0391723
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:37:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf7423ef3eso21927305ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694003824; x=1694608624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZoUjaIcUo1mllggo8PIlPzobJP22nNfvBp/20MZSjI=;
        b=Cw/91PW1lwj/vNshPfbXOLa/EIkKzjlXJW+WsGCv52xnoV041/BUgB8n7wlz/3jMOc
         JIR8qbzA2Gni1cmgnNd2xuDSaC1gE/xrxEKVjS5mXHcfSr1dtFfGLoWS70FwY6dZGnIJ
         amCgx6holaF+96JOrX16IwOqljC5xOaz7dkMWzOyY47bxUyOm8VBLTc0AS4YIw2u7cgM
         3No4kJtttbWT98q2a/sx+mGwG6oFstTzs/AvLuraozwetd0lcdTZu1zbVf30eVZPHTPX
         DwYdhfT0zAD8FCUn0VKG4Ji5Ny+etIFjkrS8zvF3Blp7jDDAljxHGMx9gyMRyD0o1wYi
         4DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003824; x=1694608624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GZoUjaIcUo1mllggo8PIlPzobJP22nNfvBp/20MZSjI=;
        b=TxdTm4+ADZ+J30o/xhEX+1vptwTn6rWiPmiosk0rkKiJ463zaPA8iyzDouihBxoRv4
         2oDHnlALbSttsiqQxFwY9fBU9vNWHIuubxtFFNqlaqOh39z0dA/6njL1BhLL965DRNEZ
         LwKYtWTCGoRsCSgdWOFroADWQBryeG1XvFeQCAGTQ0YHY/oLIncZJo/MJMBySVC9Sa4c
         1iQ2aIph2NEbzt+Jddh9mLnLOjS/NWxTEyVVy0RkWv6dOw772W0hqwPNO5R4XXu9/FhN
         lyuOqE6oH6g7RkfDg0KD5Rv/Stdo+nHrOGUhQ4h1FDRR6SQRvDnhyoTXqOByt8+dtgZR
         ztAQ==
X-Gm-Message-State: AOJu0Yz/cVOyAFLpOo3x3g12HsmWuZ7RRFvlRIIoWl1PCzuCVhMC+lM6
        u2fAzRVqRtk4/QcmwrNXAiCkjw==
X-Google-Smtp-Source: AGHT+IEmhhT/rCH4yP0vhUdx8s06CFggy495YiJSJ8R1aF9No28AqQyo+0KokwU5GVyE/2rzpwdxxg==
X-Received: by 2002:a17:902:820d:b0:1bd:b8c8:98f8 with SMTP id x13-20020a170902820d00b001bdb8c898f8mr13558458pln.4.1694003824036;
        Wed, 06 Sep 2023 05:37:04 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001bba3a4888bsm11019687plq.102.2023.09.06.05.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:37:03 -0700 (PDT)
Message-ID: <c4791970-720e-7c1c-0e81-915dbcb23139@bytedance.com>
Date:   Wed, 6 Sep 2023 20:36:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Introduce css_task open-coded
 iterator kfuncs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-2-zhouchuyi@bytedance.com>
 <CAADnVQJpZRoOtC0JF7uub+vPY5JZusWmPyjOJQD=eTxUFWOr_A@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQJpZRoOtC0JF7uub+vPY5JZusWmPyjOJQD=eTxUFWOr_A@mail.gmail.com>
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

Hello,

在 2023/9/6 03:02, Alexei Starovoitov 写道:
> On Sun, Aug 27, 2023 at 12:21 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This Patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_css_task in open-coded
>> iterator style. These kfuncs actually wrapps
>> css_task_iter_{start,next,end}. BPF programs can use these kfuncs through
>> bpf_for_each macro for iteration of all tasks under a css.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/uapi/linux/bpf.h       |  4 ++++
>>   kernel/bpf/helpers.c           |  3 +++
>>   kernel/bpf/task_iter.c         | 39 ++++++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  4 ++++
>>   tools/lib/bpf/bpf_helpers.h    |  7 ++++++
>>   5 files changed, 57 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 60a9d59beeab..2a6e9b99564b 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7195,4 +7195,8 @@ struct bpf_iter_num {
>>          __u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>
>> +struct bpf_iter_css_task {
>> +       __u64 __opaque[1];
>> +} __attribute__((aligned(8)));
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 9e80efa59a5d..cf113ad24837 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2455,6 +2455,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>>   BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index c4ab9d6cdbe9..b1bdba40b684 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -823,6 +823,45 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>>          .arg5_type      = ARG_ANYTHING,
>>   };
>>
>> +struct bpf_iter_css_task_kern {
>> +       struct css_task_iter *css_it;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>> +               struct cgroup_subsys_state *css, unsigned int flags)
>> +{
>> +       struct bpf_iter_css_task_kern *kit = (void *)it;
>> +
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != sizeof(struct bpf_iter_css_task));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
>> +                                       __alignof__(struct bpf_iter_css_task));
>> +
>> +       kit->css_it = kzalloc(sizeof(struct css_task_iter), GFP_KERNEL);
>> +       if (!kit->css_it)
>> +               return -ENOMEM;
>> +       css_task_iter_start(css, flags, kit->css_it);
> 
> Some of the flags are internal. Like CSS_TASK_ITER_SKIPPED.
> The kfunc should probably only allow CSS_TASK_ITER_PROCS |
> CSS_TASK_ITER_THREADED,
> and not CSS_TASK_ITER_THREADED alone.
> 
> Since they're #define-s it's not easy for bpf prog to use them.
> I think would be good to have a pre-patch that converts them to enum,
> so that bpf prog can take them from vmlinux.h.
> 
> 
> But the main issue of the patch that it adds this iter to common kfuncs.
> That's not safe, since css_task_iter_*() does spin_unlock_irq() which
> might screw up irq flags depending on the context where bpf prog is running.
> Can css_task_iter internals switch to irqsave/irqrestore?

Yes, I think so. Switching to irqsave/irqrestore is no harm.

> css_set_lock is also global, so the bpf side has to be careful in
> where it allows to use this iter.
> bpf_lsm hooks are safe, most of bpf iter-s are safe too.
> Future bpf-oom hooks are probably safe as well.
> We probably need an allowlist here.

What should we do if we want to make a allowlist?
Do you mean we need to check prog_type or attach_type when we call these 
kfuncs in BPF verifier? If so, we should add a new attach_type or 
prog_type for bpf-oom in the feature so we can know the current BPF 
program is hooking for OOM Policy.
