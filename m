Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975A379FF33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjINI5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbjINI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:57:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3455DA8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:56:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c3887039d4so5728345ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694681797; x=1695286597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcqjCe35kCT37IvNyJVQ3Yum99fL9VstuFpuuDE2o+Y=;
        b=I7MXouLpaOqsDr9dJu2IpO96uycTCH4+zd3+feu7WHd+oe+o1z0mlNFBSaIsN5tlBS
         1q4bB1xqVZNrhNf8+TU5VnV4blNVfu6FjDzNxU/iRNwFRu2PzqL6ph0+YGzHgYrwdCfi
         FqM+Vxuxf+/zTX3iH3/VCK6jq0KRau6s4JZLpmufDSxraovLxjKh/pPxwrkcEDixmIht
         WVWE7QUbVyv2qpEGH9VYx31Os5gkSF2UhVPQ2aWInbbzHPdrRu6OXKsWr0o1XrtYHMYV
         P5xV/OZW3wjw01S1NLCEhrxVm/J1KWW1zsKGfG5hjNHM7cowHg2o1QrndGhv1cmspMeF
         BklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681797; x=1695286597;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xcqjCe35kCT37IvNyJVQ3Yum99fL9VstuFpuuDE2o+Y=;
        b=p0jEvVWpPuBMG2vkjvZjjPyk46xBKr4NdJnaeQHVx+9Jj1VvpwyYb1htz5x6Jlnth8
         BGlnPYA2FWmeJ+V9nltfhh7PV4EV2ICmArs+hpBBJUdu1GDEI9dWrjDMoqVn2Tgfh+mf
         Dbu+JbUq+y3X8q1CNO6oal6/mLsF9xvyOuL/sjBdAVYCuKcgSrm4zgVPUzntThK5ReGs
         FdzojVP6qhjBjNxqYXsYw3V6PZw2W7Je0kjL6OMOCFKCESVWD5XRgBPnkcL34vp2LmXo
         ADPNgPD3yKnjTzOWrwYlSL6Y6UuwY9t/2s3vcMIWEecim1V2fPUriy+hOy5MSlNqzrRu
         vP0w==
X-Gm-Message-State: AOJu0YwK+FOd/vDdhoNh4fWm1XGNw9MsjhTd5s2+QrPvtF2txxfWJFG0
        IQaLMqB63CMio4a7SlaRs2u0ZQ==
X-Google-Smtp-Source: AGHT+IEDNXjBzN/x1NSN9Cc8SdXhQfUvXQSJ3pnpVtknIwGpCtmtBtF7+9bZVQ1PUr6BjruEUp5lEw==
X-Received: by 2002:a17:903:32d1:b0:1bc:2c58:ad97 with SMTP id i17-20020a17090332d100b001bc2c58ad97mr5923141plr.22.1694681797657;
        Thu, 14 Sep 2023 01:56:37 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902da9100b001b8af7f632asm1038306plx.176.2023.09.14.01.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:56:36 -0700 (PDT)
Message-ID: <1f9cae15-979c-c049-78a9-f89d5cd1b53e@bytedance.com>
Date:   Thu, 14 Sep 2023 16:56:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v2 5/6] bpf: teach the verifier to enforce
 css_iter and process_iter in RCU CS
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-6-zhouchuyi@bytedance.com>
 <4c15c9fc-7c9f-9695-5c67-d3f214d04bd9@bytedance.com>
In-Reply-To: <4c15c9fc-7c9f-9695-5c67-d3f214d04bd9@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/13 21:53, Chuyi Zhou 写道:
> Hello.
> 
> 在 2023/9/12 15:01, Chuyi Zhou 写道:
>> css_iter and process_iter should be used in rcu section. Specifically, in
>> sleepable progs explicit bpf_rcu_read_lock() is needed before use these
>> iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
>> use them directly.
>>
>> This patch checks whether we are in rcu cs before we want to invoke
>> bpf_iter_process_new and bpf_iter_css_{pre, post}_new in
>> mark_stack_slots_iter(). If the rcu protection is guaranteed, we would
>> let st->type = PTR_TO_STACK | MEM_RCU. is_iter_reg_valid_init() will
>> reject if reg->type is UNTRUSTED.
> 
> I use the following BPF Prog to test this patch:
> 
> SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> int iter_task_for_each_sleep(void *ctx)
> {
>      struct task_struct *task;
>      struct task_struct *cur_task = bpf_get_current_task_btf();
> 
>      if (cur_task->pid != target_pid)
>          return 0;
>      bpf_rcu_read_lock();
>      bpf_for_each(process, task) {
>          bpf_rcu_read_unlock();
>          if (task->pid == target_pid)
>              process_cnt += 1;
>          bpf_rcu_read_lock();
>      }
>      bpf_rcu_read_unlock();
>      return 0;
> }
> 
> Unfortunately, we can pass the verifier.
> 
> Then I add some printk-messages before setting/clearing state to help 
> debug:
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d151e6b43a5f..35f3fa9471a9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1200,7 +1200,7 @@ static int mark_stack_slots_iter(struct 
> bpf_verifier_env *env,
>                  __mark_reg_known_zero(st);
>                  st->type = PTR_TO_STACK; /* we don't have dedicated reg 
> type */
>                  if (is_iter_need_rcu(meta)) {
> +                       printk("mark reg_addr : %px", st);
>                          if (in_rcu_cs(env))
>                                  st->type |= MEM_RCU;
>                          else
> @@ -11472,8 +11472,8 @@ static int check_kfunc_call(struct 
> bpf_verifier_env *env, struct bpf_insn *insn,
>                          return -EINVAL;
>                  } else if (rcu_unlock) {
>                          bpf_for_each_reg_in_vstate(env->cur_state, 
> state, reg, ({
> +                               printk("clear reg_addr : %px MEM_RCU : 
> %d PTR_UNTRUSTED : %d\n ", reg, reg->type & MEM_RCU, reg->type & 
> PTR_UNTRUSTED);
>                                  if (reg->type & MEM_RCU) {
> -                                       printk("clear reg addr : %lld", 
> reg);
>                                          reg->type &= ~(MEM_RCU | 
> PTR_MAYBE_NULL);
>                                          reg->type |= PTR_UNTRUSTED;
>                                  }
> 
> 
> The demsg log:
> 
> [  393.705324] mark reg_addr : ffff88814e40e200
> 
> [  393.706883] clear reg_addr : ffff88814d5f8000 MEM_RCU : 0 
> PTR_UNTRUSTED : 0
> 
> [  393.707353] clear reg_addr : ffff88814d5f8078 MEM_RCU : 0 
> PTR_UNTRUSTED : 0
> 
> [  393.708099] clear reg_addr : ffff88814d5f80f0 MEM_RCU : 0 
> PTR_UNTRUSTED : 0
> ....
> ....
> 
> I didn't see ffff88814e40e200 is cleared as expected because 
> bpf_for_each_reg_in_vstate didn't find it.
> 
> It seems when we are doing bpf_read_unlock() in the middle of iteration 
> and want to clearing state through bpf_for_each_reg_in_vstate, we can 
> not find the previous reg which we marked MEM_RCU/PTR_UNTRUSTED in 
> mark_stack_slots_iter().
> 

bpf_get_spilled_reg will skip slots if they are not STACK_SPILL, but in 
mark_stack_slots_iter() we has marked the slots *STACK_ITER*

With the following change, everything seems work OK.

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a3236651ec64..83c5ecccadb4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -387,7 +387,7 @@ struct bpf_verifier_state {

  #define bpf_get_spilled_reg(slot, frame)                               \
         (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             \
-         (frame->stack[slot].slot_type[0] == STACK_SPILL))             \
+         (frame->stack[slot].slot_type[0] == STACK_SPILL || 
frame->stack[slot].slot_type[0] == STACK_ITER))            \
          ? &frame->stack[slot].spilled_ptr : NULL)

I am not sure whether this would harm some logic implicitly when using 
bpf_get_spilled_reg/bpf_for_each_spilled_reg in other place. If so, 
maybe we should add a extra parameter to control the picking behaviour.

#define bpf_get_spilled_reg(slot, frame, stack_type)
			\
	(((slot < frame->allocated_stack / BPF_REG_SIZE) &&		\
	  (frame->stack[slot].slot_type[0] == stack_type))		\
	 ? &frame->stack[slot].spilled_ptr : NULL)

Thanks.
