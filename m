Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B3797800
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbjIGQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245081AbjIGQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:38:38 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D21FD2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:35:44 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-64c5f5d6f04so6273126d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694104490; x=1694709290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFJeWKSBFQ9s+pM6/GAF1JD2E7z5XbK3jeVcGgIky0s=;
        b=ihL0hMvw1Yu8xbNiULc7c7jJUC2RlVaORDCO3lxrlznZnZcQtj6yp2XAzNsSWJgw6C
         i2nInmj2urN6uFs4wpA42QnCwEdjR1sH9KCsj6W2oM/rOOX3mIUbuDL1Rn7zVM6TIiIT
         Q8TrWhfykdbg5I4IaUYg6qHLyx4xu44ZtXD6yRlb3PavUkJasCfwXgNaTLezuSm+LjDp
         lOYvjNnUrDDS59C5klKu9bq23Az628iTDA1v9kG/6qEgU9pDf2dYccLmZA7I+nEoALdp
         luH4aqwb/PfdCbH5Rdwp1NySWIjqM/0Y3l3n3dM+c93tPXL9xa6J7kqcrezzABB17Nkc
         hOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104490; x=1694709290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zFJeWKSBFQ9s+pM6/GAF1JD2E7z5XbK3jeVcGgIky0s=;
        b=LLj2qVDuHQBmhqx+Vmq0jjhzp7Anzz6IwGVUqf5j8r0JsSCMwHb9SAOHF/AylsT1iB
         WWO0frERk48u7qbhngmT8H0iIrzzptt++BHAeYCo5WPl/jFoL/ihWrIf8ZZnfPZG715C
         o3ydu9em45lO85fJpCR6pzOV71JhckHTKXXc0re0MA2R1aI3kx11pWfllCWE1vH6ZJ4m
         ruqwwbMU+tz7tPmUBc9+W9cUavIF3NFT9NJ2ykLr0XYUBrgDWhR6LmFQ9N86ZqdSROYc
         a7crCOl5yny9T0pmUai5LdYEUNdWI4iZ1A7dLUFXuE7z2JW5slm0AT0D2v6OImJsN4VC
         NtQg==
X-Gm-Message-State: AOJu0YyAYuFLlPmAwN2PkLzf1xRld2M2ttZubkg+c/6cl+Bydw6Hw8EO
        dz2mi9RKnXKVp/bR5a1ImfOtO1t2T1lvwalFVWc=
X-Google-Smtp-Source: AGHT+IG+rSvacO9rHqr6N1+W3lw5GRcqJOtCUKh0uMMSa4vqE7HuDQQ6tp0Ol/iFld40s6YJ50eLuw==
X-Received: by 2002:a17:90b:212:b0:271:ae19:c608 with SMTP id fy18-20020a17090b021200b00271ae19c608mr17569510pjb.41.1694088146743;
        Thu, 07 Sep 2023 05:02:26 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ik21-20020a170902ab1500b001b9f032bb3dsm12934327plb.3.2023.09.07.05.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 05:02:26 -0700 (PDT)
Message-ID: <c24a5de1-33c6-0469-9902-27292660654e@bytedance.com>
Date:   Thu, 7 Sep 2023 20:02:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
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
 <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com>
 <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
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
在 2023/9/7 01:17, Alexei Starovoitov 写道:
[...cut...]
>>> This iter can be used in all ctx-s which is nice, but let's
>>> make the verifier enforce rcu_read_lock/unlock done by bpf prog
>>> instead of doing in the ctor/dtor of iter, since
>>> in sleepable progs the verifier won't recognize that body is RCU CS.
>>> We'd need to teach the verifier to allow bpf_iter_process_new()
>>> inside in_rcu_cs() and make sure there is no rcu_read_unlock
>>> while BPF_ITER_STATE_ACTIVE.
>>> bpf_iter_process_destroy() would become a nop.
>>
>> Thanks for your review!
>>
>> I think bpf_iter_process_{new, next, destroy} should be protected by
>> bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable or
>> not, right?
> 
> Correct. By explicit bpf_rcu_read_lock() in case of sleepable progs
> or just by using them in normal bpf progs that have implicit rcu_read_lock()
> done before calling into them.
Thanks for your explanation, I missed the latter.
> 
>> I'm not very familiar with the BPF verifier, but I believe
>> there is still a risk in directly calling these kfuns even if
>> in_rcu_cs() is true.
>>
>> Maby what we actually need here is to enforce BPF verifier to check
>> env->cur_state->active_rcu_lock is true when we want to call these kfuncs.
> 
> active_rcu_lock means explicit bpf_rcu_read_lock.
> Currently we do allow bpf_rcu_read_lock in non-sleepable, but it's pointless.
> 
> Technically we can extend the check:
>                  if (in_rbtree_lock_required_cb(env) && (rcu_lock ||
> rcu_unlock)) {
>                          verbose(env, "Calling
> bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
>                          return -EACCES;
>                  }
> to discourage their use in all non-sleepable, but it will break some progs.
> 
> I think it's ok to check in_rcu_cs() to allow bpf_iter_process_*().
> If bpf prog adds explicit and unnecessary bpf_rcu_read_lock() around
> the iter ops it won't do any harm.
> Just need to make sure that rcu unlock logic:
>                  } else if (rcu_unlock) {
>                          bpf_for_each_reg_in_vstate(env->cur_state,
> state, reg, ({
>                                  if (reg->type & MEM_RCU) {
>                                          reg->type &= ~(MEM_RCU |
> PTR_MAYBE_NULL);
>                                          reg->type |= PTR_UNTRUSTED;
>                                  }
>                          }));
> clears iter state that depends on rcu.
> 
> I thought about changing mark_stack_slots_iter() to do
> st->type = PTR_TO_STACK | MEM_RCU;
> so that the above clearing logic kicks in,
> but it might be better to have something iter specific.
> is_iter_reg_valid_init() should probably be changed to
> make sure reg->type is not UNTRUSTED.
> 
Maybe it's something looks like the following?

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..9185c4a40a21 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1172,7 +1172,15 @@ static bool is_dynptr_type_expected(struct 
bpf_verifier_env *env, struct bpf_reg

  static void __mark_reg_known_zero(struct bpf_reg_state *reg);

+static bool in_rcu_cs(struct bpf_verifier_env *env);
+
+/* check whether we are using bpf_iter_process_*() or bpf_iter_css_*() */
+static bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta)
+{
+
+}
  static int mark_stack_slots_iter(struct bpf_verifier_env *env,
+                                struct bpf_kfunc_call_arg_meta *meta,
                                  struct bpf_reg_state *reg, int insn_idx,
                                  struct btf *btf, u32 btf_id, int nr_slots)
  {
@@ -1193,6 +1201,12 @@ static int mark_stack_slots_iter(struct 
bpf_verifier_env *env,

                 __mark_reg_known_zero(st);
                 st->type = PTR_TO_STACK; /* we don't have dedicated reg 
type */
+               if (is_iter_need_rcu(meta)) {
+                       if (in_rcu_cs(env))
+                               st->type |= MEM_RCU;
+                       else
+                               st->type |= PTR_UNTRUSTED;
+               }
                 st->live |= REG_LIVE_WRITTEN;
                 st->ref_obj_id = i == 0 ? id : 0;
                 st->iter.btf = btf;
@@ -1281,6 +1295,8 @@ static bool is_iter_reg_valid_init(struct 
bpf_verifier_env *env, struct bpf_reg_
                 struct bpf_stack_state *slot = &state->stack[spi - i];
                 struct bpf_reg_state *st = &slot->spilled_ptr;

+               if (st->type & PTR_UNTRUSTED)
+                       return false;
                 /* only main (first) slot has ref_obj_id set */
                 if (i == 0 && !st->ref_obj_id)
                         return false;

> Andrii,
> do you have better suggestions?
