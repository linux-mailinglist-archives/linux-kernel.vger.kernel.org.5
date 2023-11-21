Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF847F24BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjKUD4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUD4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:56:06 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF59E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:56:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-280351c32afso4120200a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700538962; x=1701143762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UPkr6nw1hCX7BQuQqXYMaPI/OcaSnPTBXctNF8l1TJE=;
        b=Fa2T11uowPffZdohbql4ZZKudbpFv6AISqa7HUEBEThpUBb931ZrqHogLRzqDzTMgM
         UDo4q1KdIrTQvl22woRZVeDoR4JXiOdMln7+uoeCIe0LdC/z4uOhEG2bjtId75MsmLny
         BVFTfh3fLEcCsPCXA0xC1f0PC6ZaDA/vMqOmWY2T1DAzVr6PJCSrkdrP3Poy9hdQ6GPX
         5WSHEfMRZcKrtwU55KX4OdYqDp9rCOfCikYcOJagYpBpLARRQEC/Zt2IN6ejF4eDk5Qm
         Oblz+YKj7cAO3ehlsuUGBaK0VewEWjDxXAGe6qJs6/sgmbepwAW2YKwFcaYzpj6dvvhc
         QuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700538962; x=1701143762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPkr6nw1hCX7BQuQqXYMaPI/OcaSnPTBXctNF8l1TJE=;
        b=P81CdusJgvX0cra9oen7EnEKBxEyzYasuEr4hat0Ct+6Aznn6gx90Pa+q3yhghgz6e
         AjyjmXN/3Q6KlaaPOMuUEqVYYNMe0tBe30D42gthqY0bWCkoRhscEUZX2LX8kBxA3N0K
         6BZfKFKwkTOi0xbTu7LrJ6n54RQwLcF3xeXtmx9WIUdKzHngQoDdCP+RCv/qMIH6dMqL
         faRrAnmcwgBRs53ztrR+p+F40AMwPuWL8XS3pXRnjzxYOcufJLkQEX4W2iBylfE/PSx6
         6hkcLY//B2DIS7nusi2sn968qbLmVzYk7QA+0/ZffCcTCdol/CrO/DfGj+sm7dDeVv1v
         IPKg==
X-Gm-Message-State: AOJu0YyLJntjISMI1iNDat6gGx3GITSq3rT/dIcodT/Us170BQxKyrwJ
        LjBQaiJ3iq20Kylx5+tB9gHhpQ7eKf2RyowqwJFzkcl/P85oQA==
X-Google-Smtp-Source: AGHT+IGL9Y9wMGRSCR8hMUyYbq83CECbJMPBn3wXHz2lxBdOdjBZZozf+SIRtyKqaLFzX28Gn+Sb2EQASFwl+93xtlw=
X-Received: by 2002:a17:90a:f181:b0:280:125:e52e with SMTP id
 bv1-20020a17090af18100b002800125e52emr9696878pjb.35.1700538961855; Mon, 20
 Nov 2023 19:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20231107215742.363031-1-ankur.a.arora@oracle.com> <20231107215742.363031-49-ankur.a.arora@oracle.com>
In-Reply-To: <20231107215742.363031-49-ankur.a.arora@oracle.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 21 Nov 2023 11:55:50 +0800
Message-ID: <CALm+0cW2pExdO7H8iRR1bu2NhPAOQ-xegBXfVv5NWnBraX8xXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> cond_resched() is used to provide urgent quiescent states for
> read-side critical sections on PREEMPT_RCU=n configurations.
> This was necessary because lacking preempt_count, there was no
> way for the tick handler to know if we were executing in RCU
> read-side critical section or not.
>
> An always-on CONFIG_PREEMPT_COUNT, however, allows the tick to
> reliably report quiescent states.
>
> Accordingly, evaluate preempt_count() based quiescence in
> rcu_flavor_sched_clock_irq().
>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/rcu/tree_plugin.h |  3 ++-
>  kernel/sched/core.c      | 15 +--------------
>  2 files changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index f87191e008ff..618f055f8028 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -963,7 +963,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>   */
>  static void rcu_flavor_sched_clock_irq(int user)
>  {
> -       if (user || rcu_is_cpu_rrupt_from_idle()) {
> +       if (user || rcu_is_cpu_rrupt_from_idle() ||
> +           !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {


should ensure CONFIG_PREEMPT_COUNT=y
((IS_ENABLED(CONFIG_PREEMPT_COUNT) && !(preempt_count() &
(PREEMPT_MASK | SOFTIRQ_MASK)))

Thanks
Zqiang


>
>                 /*
>                  * Get here if this CPU took its interrupt from user
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bf5df2b866df..15db5fb7acc7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8588,20 +8588,7 @@ int __sched _cond_resched(void)
>                 preempt_schedule_common();
>                 return 1;
>         }
> -       /*
> -        * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
> -        * whether the current CPU is in an RCU read-side critical section,
> -        * so the tick can report quiescent states even for CPUs looping
> -        * in kernel context.  In contrast, in non-preemptible kernels,
> -        * RCU readers leave no in-memory hints, which means that CPU-bound
> -        * processes executing in kernel context might never report an
> -        * RCU quiescent state.  Therefore, the following code causes
> -        * cond_resched() to report a quiescent state, but only when RCU
> -        * is in urgent need of one.
> -        */
> -#ifndef CONFIG_PREEMPT_RCU
> -       rcu_all_qs();
> -#endif
> +
>         return 0;
>  }
>  EXPORT_SYMBOL(_cond_resched);
> --
> 2.31.1
>
