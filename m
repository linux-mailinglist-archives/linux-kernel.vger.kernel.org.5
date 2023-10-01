Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1E7B4643
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjJAIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJAIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:31:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00053AB
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 01:31:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso1479345b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 01:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696149066; x=1696753866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRYOFlpIFvDheCMqM1F61HOPLWc4MxoX9fuSk147b1w=;
        b=h24SwWtPCXU+BlgSV7yXp0H1D9QNJFB2PjS6PLITbpCigQND5PtzmbtKWLVxjNd/bc
         jhLKH72TAzT2B6yTsLkqTPd/M/FAo+uR++3TM11oXXsopQEcqLSJOGKi2+BvlXG2zofs
         5D3au45k6OG5us4210pW5oKf3Fbvz4Inov94tQDGoIEcjuCASPKhbmuBncEH7TffGCCN
         a3LF7KCDTVIB0qpiWTk00XNIHwhzfIC/iJR0gKbYpCax6HEgpGFnITtAJZ6Slc6Ppb9h
         1h5HwxwFO98EHtu5bTaMkb4nqStKtaduMWM0dGD9o+21wpe7x+OC+9aoDxsvC9vy1KYh
         IMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696149066; x=1696753866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tRYOFlpIFvDheCMqM1F61HOPLWc4MxoX9fuSk147b1w=;
        b=nVx97zgPGZs1RFY8iysgULobCOw90SIAycgjPI/R/2z6KOVbbC0HyqYDQaJBRCuaxj
         ni2d0juS8n3QtJQwbw5Dq6kKQjbMnVSgvJsuLXetNiFfsVcxnShkDhK9WIcOqe9EVnHe
         dKmIzotBolecmvc2Nze3CanuxMWxzQcwkXQ+299ULprYX8lIug2t4M9fFQQV7CMXANRV
         Ngi3ZSrpFs6UisWheQR5bzB7yWQOi3BpLXayhCfhCVHL/fFx25738nmQ4T0KLrgwpxhM
         WqUmdGUeW4ZfoX/WmXcbHpjbmRbyTbzN5iNEPj6dPcoN4xIBZa9uP2iZrwBKNsy350Ih
         PKYQ==
X-Gm-Message-State: AOJu0YwKKUhDSRUSQLF5Bde6BQYkyrjt5bvGPtYY9x2ndzxaXMji5F+D
        Orzz5Jf4rzL+UoALb19yWjQUKw==
X-Google-Smtp-Source: AGHT+IGeHS2rf1cO91cshQ0mxSEYJir7Ene5RfowGCSuv94piHjyALbSWx9RvBpMHhWBZ87ERKzJZg==
X-Received: by 2002:a05:6a00:8c4:b0:68f:d44c:22f8 with SMTP id s4-20020a056a0008c400b0068fd44c22f8mr14101964pfu.1.1696149066319;
        Sun, 01 Oct 2023 01:31:06 -0700 (PDT)
Received: from ?IPV6:2409:8a28:5060:6c21:2872:efd0:e8fb:f8d8? ([2409:8a28:5060:6c21:2872:efd0:e8fb:f8d8])
        by smtp.gmail.com with ESMTPSA id a20-20020a62bd14000000b006930db1e6cfsm9138406pff.62.2023.10.01.01.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 01:31:05 -0700 (PDT)
Message-ID: <4e496d8c-437b-0aa8-5f23-9dbf29754d37@bytedance.com>
Date:   Sun, 1 Oct 2023 16:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v3 6/7] bpf: Let bpf_iter_task_new accept null
 task ptr
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-7-zhouchuyi@bytedance.com>
 <CAEf4BzZKR7OXtpxak2ye5hsF3w9k8VLQb2u-dwGQQgqVG1sx+w@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzZKR7OXtpxak2ye5hsF3w9k8VLQb2u-dwGQQgqVG1sx+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/9/28 07:37, Andrii Nakryiko 写道:
> On Mon, Sep 25, 2023 at 3:56 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> When using task_iter to iterate all threads of a specific task, we enforce
>> that the user must pass a valid task pointer to ensure safety. However,
>> when iterating all threads/process in the system, BPF verifier still
>> require a valid ptr instead of "nullable" pointer, even though it's
>> pointless, which is a kind of surprising from usability standpoint. It
>> would be nice if we could let that kfunc accept a explicit null pointer
>> when we are using BPF_TASK_ITER_ALL/BPF_TASK_ITER_PROC and a valid pointer
>> when using BPF_TASK_ITER_THREAD.
>>
>> Given a trival kfunc:
>>          __bpf_kfunc void FN(struct TYPE_A *obj)
>>
>> BPF Prog would reject a nullptr for obj. The error info is:
>> "arg#x pointer type xx xx must point to scalar, or struct with scalar"
>> reported by get_kfunc_ptr_arg_type(). The reg->type is SCALAR_VALUE and
>> the btf type of ref_t is not scalar or scalar_struct which leads to the
>> rejection of get_kfunc_ptr_arg_type.
>>
>> This patch reuse the __opt annotation which was used to indicate that
>> the buffer associated with an __sz or __szk argument may be null:
>>          __bpf_kfunc void FN(struct TYPE_A *obj__opt)
>> Here __opt indicates obj can be optional, user can pass a explicit nullptr
>> or a normal TYPE_A pointer. In get_kfunc_ptr_arg_type(), we will detect
>> whether the current arg is optional and register is null, If so, return
>> a new kfunc_ptr_arg_type KF_ARG_PTR_TO_NULL and skip to the next arg in
>> check_kfunc_args().
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/bpf/task_iter.c |  7 +++++--
>>   kernel/bpf/verifier.c  | 13 ++++++++++++-
>>   2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 9bcd3f9922b1..7ac007f161cc 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -867,7 +867,7 @@ struct bpf_iter_task_kern {
>>          unsigned int type;
>>   } __attribute__((aligned(8)));
>>
>> -__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task, unsigned int type)
>> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task__opt, unsigned int type)
>>   {
>>          struct bpf_iter_task_kern *kit = (void *)it;
>>          BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) != sizeof(struct bpf_iter_task));
>> @@ -877,14 +877,17 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *
>>          switch (type) {
>>          case BPF_TASK_ITER_ALL:
>>          case BPF_TASK_ITER_PROC:
>> +               break;
>>          case BPF_TASK_ITER_THREAD:
>> +               if (!task__opt)
>> +                       return -EINVAL;
>>                  break;
>>          default:
>>                  return -EINVAL;
>>          }
>>
>>          if (type == BPF_TASK_ITER_THREAD)
>> -               kit->task = task;
>> +               kit->task = task__opt;
>>          else
>>                  kit->task = &init_task;
>>          kit->pos = kit->task;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a065e18a0b3a..a79204c75a90 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10331,6 +10331,7 @@ enum kfunc_ptr_arg_type {
>>          KF_ARG_PTR_TO_CALLBACK,
>>          KF_ARG_PTR_TO_RB_ROOT,
>>          KF_ARG_PTR_TO_RB_NODE,
>> +       KF_ARG_PTR_TO_NULL,
>>   };
>>
>>   enum special_kfunc_type {
>> @@ -10425,6 +10426,12 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
>>          return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_unlock];
>>   }
>>
>> +static inline bool is_kfunc_arg_optional_null(struct bpf_reg_state *reg,
>> +                               const struct btf *btf, const struct btf_param *arg)
>> +{
>> +       return register_is_null(reg) && is_kfunc_arg_optional(btf, arg);
>> +}
>> +
>>   static enum kfunc_ptr_arg_type
>>   get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>>                         struct bpf_kfunc_call_arg_meta *meta,
>> @@ -10497,6 +10504,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>>           */
>>          if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
>>              (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
>> +                       if (is_kfunc_arg_optional_null(reg, meta->btf, &args[argno]))
>> +                               return KF_ARG_PTR_TO_NULL;
> 
> This nested check seems misplaced. Maybe we shouldn't reuse __opt
> suffix which already has a different meaning (coupled with __sz). Why
> not add "__nullable" convention and just check it separately?
> 

IIUC, do you mean:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dbba2b806017..05d197365fcb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10458,6 +10458,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
         if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
                 return KF_ARG_PTR_TO_CALLBACK;

+       if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && 
register_is_null(reg))
+               return KF_ARG_PTR_TO_NULL;

         if (argno + 1 < nargs &&
             (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], 
&regs[regno + 1]) ||


OK, I would change in next version.

Thanks.

