Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57274810C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjLMIT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjLMITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:19:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886058E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:19:09 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1992712a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702455549; x=1703060349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFigjVu5W6ScDqNFv0bLuZxvlmLPor2lw0m8dW0Y2WM=;
        b=hTgBXA1N1Ih0sfBsTiRV7V96+fiUX1jOej4IRYzKF1uZeX1RHY+B5AOFZqMfRRAU2V
         9BOS9YIVm+ACwO/lof2o3rQsuMei9EyiuxP9sEyT4SJVXrMyTjuzXgQIsWPlI45R2MS8
         /dB1fvrqFt3mP0FY5i5CrdXzdDxvYjaygjGjHjow3PFz8lmlgtVi3CLtR8UJcgtpL2B4
         R1LHT3l7hKyynise8U/9YeZjZTNtz6ZtNOehEXLkBRPX3rxCoRRK0f9yyT+qN38W5FSe
         Xz5GdlruGFTretO6TvzmN0QFup0pRHDEQB2JMWoXFTMZZ3ZV43vbHz+fXZZhPwRCkQtC
         BvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702455549; x=1703060349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFigjVu5W6ScDqNFv0bLuZxvlmLPor2lw0m8dW0Y2WM=;
        b=ooPj+pjA66fVsB2iEZ0pgCJc6N2lt9M0Wv8x3OM5l21rTiPbQB5jsvccWUTQOjmq9/
         yjB1U5WGcDoYXug2+ry248VEe64VSjfm9Ec8xEqrIHCGooh+tvcUqbfUm6xXcLob5SIz
         KetNetDOXGQHOfZsvwblTtzjjrrlI8a1WnGYe+7xDEe3uk56qovVLwQ4IOZ05eH4xP9r
         dKnjlzWkD+ItfbN+w9Mv1b5glM79YjOdT+OqAo0VKaDZefC6ox7BBrYPdjzIRnFQkqoI
         7X1L93VWwoA+Lwy/1kE6y773y+iRzFqZpwJ3qbgjY7lTTiuFkxl2W/0NH4tn5xeeOZ4M
         DBzg==
X-Gm-Message-State: AOJu0Yx2KvDz9s0QFe/joCA54gAfEVI2TGHoaE4nRAXrLDKGl1Hldciv
        TSTt11Tqtb1+XvmQzkOF7wAgwg==
X-Google-Smtp-Source: AGHT+IGMV/4iK1ZdQCWZyK3kBq9AbUUFXrAUfEd9cWuTAAR+sEy4X01fzpsy8Nkq+nTgSPYEFD2tiQ==
X-Received: by 2002:a05:6a20:4f91:b0:18f:d275:9f33 with SMTP id gh17-20020a056a204f9100b0018fd2759f33mr7514739pzb.119.1702455549028;
        Wed, 13 Dec 2023 00:19:09 -0800 (PST)
Received: from [10.84.154.56] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id r22-20020aa78456000000b006ce7c28be72sm2431727pfn.118.2023.12.13.00.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 00:19:08 -0800 (PST)
Message-ID: <d0dc8c52-e2ab-4d49-b9fc-23e15ab101a0@bytedance.com>
Date:   Wed, 13 Dec 2023 16:18:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: merge same code in enqueue_task_fair
Content-Language: en-US
To:     WangJinchao <wangjinchao@xfusion.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     stone.xulei@xfusion.com
References: <202312131510+0800-wangjinchao@xfusion.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <202312131510+0800-wangjinchao@xfusion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinchao,

On 12/13/23 3:12 PM, WangJinchao Wrote:
> The code below is duplicated in two for loops and need to be
>     consolidated

It doesn't need to, but it can actually bring some benefit from
the point of view of text size, especially in warehouse-scale
computers where icache is extremely contended.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-56 (-56)
Function                                     old     new   delta
enqueue_task_fair                            936     880     -56
Total: Before=64899, After=64843, chg -0.09%

> 
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
> ---
>   kernel/sched/fair.c | 31 ++++++++-----------------------
>   1 file changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..e1373bfd4f2e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6681,30 +6681,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>   
>   	for_each_sched_entity(se) {
> -		if (se->on_rq)
> -			break;
>   		cfs_rq = cfs_rq_of(se);
> -		enqueue_entity(cfs_rq, se, flags);
> -
> -		cfs_rq->h_nr_running++;
> -		cfs_rq->idle_h_nr_running += idle_h_nr_running;
> -
> -		if (cfs_rq_is_idle(cfs_rq))
> -			idle_h_nr_running = 1;
> -
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			goto enqueue_throttle;
> -
> -		flags = ENQUEUE_WAKEUP;
> -	}
> -
> -	for_each_sched_entity(se) {
> -		cfs_rq = cfs_rq_of(se);
> -
> -		update_load_avg(cfs_rq, se, UPDATE_TG);
> -		se_update_runnable(se);
> -		update_cfs_group(se);
> +		if (se->on_rq) {
> +			update_load_avg(cfs_rq, se, UPDATE_TG);
> +			se_update_runnable(se);
> +			update_cfs_group(se);
> +		} else {
> +			enqueue_entity(cfs_rq, se, flags);
> +			flags = ENQUEUE_WAKEUP;
> +		}
>   
>   		cfs_rq->h_nr_running++;
>   		cfs_rq->idle_h_nr_running += idle_h_nr_running;

I have no strong opinon about this 'cleanup', but the same pattern
can also be found in dequeue_task_fair() and I think it would be
better get them synchronized.

Thanks,
	Abel
