Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987967A0462
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbjINMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjINMu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:50:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579A31FD8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:50:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fbd5cd0ceso723028b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694695832; x=1695300632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2iriErYbn79qa7ewAKhiijBn0H2Aoadhjiaypxhtro=;
        b=k/6qQ1RTyt+Epd0NDlDVKTFlXSXMlXU8dCYox0nvjQgHA4EIVM8syYj1oZgobCmPH/
         qWOaT40gP57vmHnyrLHM5fDeatxhasUe6x7bw6XM7nRNrzGVFhoQTunhzFCN2cyOnDY4
         i26mNLbybJBrwaf4j+3nWlIWb1ShgXYYBCIQZ1eh74Lp8Jj5eUkFC2EYKG8KKMnMxc9C
         jIuib9Sn5mpXMc0Aab7IX9izrGy0OUGem7fRUefLVyNDa87KBTK6ma3xReVlNXQtiiNg
         PYtkH7rl0MQ8e9ZJftdOypxji7Z76H+KnWrS7IcHnx5XzbGO+tfqpNz6ZsGQVhkd9q2V
         4LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694695832; x=1695300632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S2iriErYbn79qa7ewAKhiijBn0H2Aoadhjiaypxhtro=;
        b=wBN/Vq+aInx8DJ+XSUd7tD539x2Rqu0PhZisnlXw9vuQ6+m0F0OMpVYk8pn2IUbcp/
         Bc/2Tl4cdASEJQuMmjR5RO8h9dAnG/hsABAyk/5nPLAr0HKHQRfczVt02z0e2SvVS4LA
         PVQyUqcu6zwv1X/kt9uhU2Bhb60OHEHqzihCUnXOU4jxG7tMjaWs94ZFGQyZB03jENn+
         fDPxbgrfr/B/dYY1BwOYZ4YPHeiJkPUQjOcZM7FA1lA+w5NiCppvSscAO+OLTAWpMzDY
         fF9e/d9aVAPmqM4u48xwANfgLt9gbVeQROYs62KtJ/FTvbqA86pUZ23rKscaggHGzm9j
         kPLg==
X-Gm-Message-State: AOJu0YzbeAnSDNmyx+Wjb36sdOyuCzShcmHXoGJU6FjJjFAWb4zhjWLl
        H1LCOfdaGULJK5WEEvUB7b5BEg==
X-Google-Smtp-Source: AGHT+IGXKNqg9k2IBt7BhnX/pDOuKeUJatuzkUT9W8yp4wYF4dwEWXU7qLUn0mLCq1bZxdvyys4Xxw==
X-Received: by 2002:a05:6a00:21d5:b0:68a:5e5b:e450 with SMTP id t21-20020a056a0021d500b0068a5e5be450mr5676316pfj.26.1694695831781;
        Thu, 14 Sep 2023 05:50:31 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id e23-20020a62aa17000000b0068fba4800cfsm1280445pff.56.2023.09.14.05.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 05:50:31 -0700 (PDT)
Message-ID: <89295904-3afa-4c8f-ccdb-1d78d9ad3024@bytedance.com>
Date:   Thu, 14 Sep 2023 20:50:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [External] Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify
 OOM policies
To:     Bixuan Cui <cuibixuan@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
 <87h6p1uz3w.fsf@meer.lwn.net> <5343d12a-630c-4d54-91f1-7a7d08326840@vivo.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <5343d12a-630c-4d54-91f1-7a7d08326840@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/9/14 20:02, Bixuan Cui 写道:
> 
> 
> 在 2023/8/15 4:51, Jonathan Corbet 写道:
>>>   /**
>>>    * dump_tasks - dump current memory state of all system tasks
>>>    * @oc: pointer to struct oom_control
>>> @@ -484,8 +513,8 @@ static void dump_oom_summary(struct oom_control 
>>> *oc, struct task_struct *victim)
>>>   static void dump_header(struct oom_control *oc, struct task_struct *p)
>>>   {
>>> -    pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
>>> oom_score_adj=%hd\n",
>>> -        current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
>>> +    pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
>>> policy_name=%s, oom_score_adj=%hd\n",
>>> +        current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, 
>>> oc->policy_name,
>> ...and if the policy name is unterminated, this print will run off the
>> end of the structure.
>>
>> Am I missing something here?
> Perhaps it is inaccurate to use policy name in this way. For example, 
> some one use BPF_PROG(bpf_oom_evaluate_task, ...) but do not set the 
> policy name through bpf_set_policy_name. In this way, the result is 
> still policy name=default, which ultimately leads to error print in the 
> dump_header.
> I think a better way:
> 
> +static const char *const policy_select[] = {
> +    "OOM_DEFAULT";
> +    "BPF_ABORT",
> +    "BPF_NEXT",
> +    "BPF_SELECT",
> +};
> 
> struct oom_control {
> 
>       /* Used to print the constraint info. */
>       enum oom_constraint constraint;
> +
> +    /* Used to report the policy select. */
> +    int policy_select;
>   };
> 
> static int oom_evaluate_task(struct task_struct *task, void *arg)
> {
> ...
> 
> +    switch (bpf_oom_evaluate_task(task, oc)) {
> +    case BPF_EVAL_ABORT:
> +              oc->policy_select = BPF_EVAL_ABORT;
> +        goto abort; /* abort search process */
> +    case BPF_EVAL_NEXT:
> +              oc->policy_select = BPF_EVAL_NEXT;
> +        goto next; /* ignore the task */
> +    case BPF_EVAL_SELECT:
> +             oc->policy_select = BPF_EVAL_SELECT;
> +        goto select; /* select the task */
> +    default:
> +        break; /* No BPF policy */
> +    }
> 
>   static void dump_header(struct oom_control *oc, struct task_struct *p)
>   {
> -    pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
> oom_score_adj=%hd\n",
> -        current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
> +    pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
> policy_name=%s, oom_score_adj=%hd\n",
> +        current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, 
> policy_select[oc->policy_select],
>               current->signal->oom_score_adj);
> 
> 

The policy_name may be different from the previous OOM reporting, even 
though they are using the same policy.

> And all definitions of oc should be added
> struct oom_control oc = {
>       .select = NO_BPF_POLICY,
> }
> 
> Delete set_oom_policy_name, it makes no sense for users to set policy 
> names. :-)
> 

There can be multiple OOM policy in the system at the same time.

If we need to apply different OOM policies to different memcgs based on 
different scenarios, we can use this hook(set_oom_policy_name) to set 
name to identify which policy in invoked at that time.

Just some thoughts.

Thanks.

> Thanks
> Bixuan Cui
> 
> 
> 
> 
> 
