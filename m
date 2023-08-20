Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D64781F09
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjHTRgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjHTRgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 13:36:33 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F631199;
        Sun, 20 Aug 2023 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692552708;
        bh=zxFXhwDqIpdERvzCzYZLMU4dKm/60bg0p1VB86108kw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZwpW0dFsKbmdzT+IPWF04YdDLKajYJg9G+VmNvAov17sfxFpP+XLhdgSGXpruZXol
         JP1DF+GiJiRjlOGrXSaFLyDLOdqB6lXwgLe9m706sdW3e6CCeLcipVzYvdjqOASfWM
         2F1HtLXcATrDqjAfgKcXuqmip3Xb1VuL5wY5hnTA=
Received: from [IPV6:240e:331:c54:6700:63d6:d559:9412:6535] ([240e:331:c54:6700:63d6:d559:9412:6535])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 5CF11E86; Mon, 21 Aug 2023 01:23:15 +0800
X-QQ-mid: xmsmtpt1692552195tepjhx5no
Message-ID: <tencent_C80D3EE7563151B306E94C2AA7BF3023F80A@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieiZvg7Y8RvyLZC1x+cVc4V+CgM4zVX23AWMRR5lb9+/P0RYXRbp
         RyQRLt+9D1lpO3Af3SEOIwCTK2pvfOVi4SQ8bSXRLCZj1LDz97VUqHJykrSDL5NO1U3Zo8IBUgGA
         5O133J1Rp8MVdGA87AfdPn/bxc+dJ/b3yCoL3S85P6O+K3Fw+0L8+oN0cDxcwA+n6fn0HK3oNraJ
         Kf7cY83+AXD5hm3d9gB88h1AtLyM/5ACK6J4XUoqyhOr0d/DsM7DSMvScWb/92HXi7SCivc1kuui
         cBlhtzTIlj7qgzYVU25Z316S6h/qB6mlB6pXAkB9SdxQFIZ9sEI8R4kOMN3G8hHQys9TbqZvnodB
         MeJsbnHyZbJJ3L/x9gj7XJExlfe6dxVAvqSrudFO8nXDnIRgujJnl6MeBc+FNJPK16rtOY64PZws
         kqqwL3YrpcHkVgS4fnlWkkvHQiZgJSUgTW4Ka3uVFBVNtI3f/B46bvo8YAFQl/csgxoxSOEkcM3o
         de1/ZnZcPH3gjPqVo/rOmsD+dCBc2W5HHIk5mZGsxJBSMJ5SaCxpE+e87Ex6589pZXq2ydmv4NWf
         C0L44J/geF9q9YM+xSep5vF8DjyjLL6aVI9HbYa0JDPcFaYMG6bseKpG6JDmYJavwu9NhGoAlWR3
         4tFPyzuTdKPiaL0wriH/e0WgMEgBxvH7Yg1b336LxkGhI0WTB4Gq3T3mz1kdo2U84nPU7nEP2lcr
         ugQ8OnqDCiT5Reg+MlO7HUKewsgPglzgZqr/KKKZyYCRiqmBZnLSpT+RH0HScNSgPFHCCOWntXHE
         EagbgIQaYjz15chgxhgpOKpV8wSM4tNGEfkNZ+JSBeheait0u7Lxzktv1xwEOnBqsd2LsPOGMmdA
         zxoCgpU9YIV8uebw5CclWHMOr1Bak121FVfklIvd8chUaBdtFUFvCd+lSI2N70JCxG4g2bpXep+B
         +AAWbdpf+i9JuafBD6XSSgA8JtzUbGxQtTO1bCjD5SZqkxPzRu383FwAwoAH2l6YjlkdXL03w=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <50df2dd1-833c-0fcc-9689-4ff5db961062@foxmail.com>
Date:   Mon, 21 Aug 2023 01:23:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tick/rcu: fix false positive "softirq work is pending"
 messages on RT
Content-Language: en-US
To:     paul.gortmaker@windriver.com, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/8/19 04:07, paul.gortmaker@windriver.com wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> In commit 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
> the new function report_idle_softirq() was created by breaking code out
> of the existing can_stop_idle_tick() for kernels v5.18 and newer.
>
> In doing so, the code essentially went from a one conditional:
>
> 	if (a && b && c)
> 		warn();
>
> to a three conditional:
>
> 	if (!a)
> 		return;
> 	if (!b)
> 		return;
> 	if (!c)
> 		return;
> 	warn();
>
> However, it seems one of the conditionals didn't get a "!" removed.
> Compare the instance of local_bh_blocked() in the old code:
>
> -               if (ratelimit < 10 && !local_bh_blocked() &&
> -                   (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
> -                       pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
> -                               (unsigned int) local_softirq_pending());
> -                       ratelimit++;
> -               }
>
> ...to the usage in the new (5.18+) code:
>
> +       /* On RT, softirqs handling may be waiting on some lock */
> +       if (!local_bh_blocked())
> +               return false;
>
> It seems apparent that the "!" should be removed from the new code.
>
> This issue lay dormant until another fixup for the same commit was added
> in commit a7e282c77785 ("tick/rcu: Fix bogus ratelimit condition").
> This commit realized the ratelimit was essentially set to zero instead
> of ten, and hence *no* softirq pending messages would ever be issued.
>
> Once this commit was backported via linux-stable, both the v6.1 and v6.4
> preempt-rt kernels started printing out 10 instances of this at boot:
>
>    NOHZ tick-stop error: local softirq work is pending, handler #80!!!
>
> Just to double check my understanding of things, I confirmed that the
> v5.18-rt did print the pending-80 messages with a cherry pick of the
> ratelimit fix, and then confirmed no pending softirq messages were
> printed with a revert of mainline's 034569 on a v5.18-rt baseline.
>
> Finally I confirmed it fixed the issue on v6.1-rt and v6.4-rt, and
> also didn't break anything on a defconfig of mainline master of today.
>
> Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
> Cc: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 2b865cb77feb..b52e1861b913 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1050,7 +1050,7 @@ static bool report_idle_softirq(void)
>   		return false;
>   
>   	/* On RT, softirqs handling may be waiting on some lock */
> -	if (!local_bh_blocked())
> +	if (local_bh_blocked())
>   		return false;
>   
>   	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",


Good catch!

Reviewed-by: Wen Yang <wenyang.linux@foxmail.com>

--
Thanks,
Wen

