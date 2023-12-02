Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB174801A1B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442011AbjLBClm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:41:41 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F359D4A;
        Fri,  1 Dec 2023 18:41:45 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
        by gateway (Coremail) with SMTP id _____8BxNuhomWplgFY+AA--.5105S3;
        Sat, 02 Dec 2023 10:41:44 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.120])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxndxkmWplMSRSAA--.50287S3;
        Sat, 02 Dec 2023 10:41:41 +0800 (CST)
Message-ID: <30b94fb1-7794-4dc4-8af3-65703b4fab81@loongson.cn>
Date:   Sat, 2 Dec 2023 10:41:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP,
 true)
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com, hongyan.xia2@arm.com, yizhou.tang@shopee.com
References: <20231201161652.1241695-1-vincent.guittot@linaro.org>
 <20231201161652.1241695-2-vincent.guittot@linaro.org>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20231201161652.1241695-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxndxkmWplMSRSAA--.50287S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF47WFyfuF48ur1UKF17Arc_yoWrtryDpr
        WqgrWIqwn3AFyUKr1xur1kXFWfWF1xGa17WF4vkwnYqrn0qFWayF1fKFs7J397ur1kAa42
        vF4jg34fGa1jyrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUd529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        kF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
        vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/12/2 00:16, Vincent Guittot 写道:
> sched_feat(UTIL_EST_FASTUP) has been added to easily disable the feature
> in order to check for possibly related regressions. After 3 years, it has
> never been used and no regression has been reported. Let remove it
> and make fast increase a permanent behavior.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>

For Chinese translation,


Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   Documentation/scheduler/schedutil.rst                    | 7 +++----
>   Documentation/translations/zh_CN/scheduler/schedutil.rst | 7 +++----
>   kernel/sched/fair.c                                      | 8 +++-----
>   kernel/sched/features.h                                  | 1 -
>   4 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/scheduler/schedutil.rst b/Documentation/scheduler/schedutil.rst
> index 32c7d69fc86c..803fba8fc714 100644
> --- a/Documentation/scheduler/schedutil.rst
> +++ b/Documentation/scheduler/schedutil.rst
> @@ -90,8 +90,8 @@ For more detail see:
>    - Documentation/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task utilization"
>   
>   
> -UTIL_EST / UTIL_EST_FASTUP
> -==========================
> +UTIL_EST
> +========
>   
>   Because periodic tasks have their averages decayed while they sleep, even
>   though when running their expected utilization will be the same, they suffer a
> @@ -99,8 +99,7 @@ though when running their expected utilization will be the same, they suffer a
>   
>   To alleviate this (a default enabled option) UTIL_EST drives an Infinite
>   Impulse Response (IIR) EWMA with the 'running' value on dequeue -- when it is
> -highest. A further default enabled option UTIL_EST_FASTUP modifies the IIR
> -filter to instantly increase and only decay on decrease.
> +highest. UTIL_EST filters to instantly increase and only decay on decrease.
>   
>   A further runqueue wide sum (of runnable tasks) is maintained of:
>   
> diff --git a/Documentation/translations/zh_CN/scheduler/schedutil.rst b/Documentation/translations/zh_CN/scheduler/schedutil.rst
> index d1ea68007520..7c8d87f21c42 100644
> --- a/Documentation/translations/zh_CN/scheduler/schedutil.rst
> +++ b/Documentation/translations/zh_CN/scheduler/schedutil.rst
> @@ -89,16 +89,15 @@ r_cpu被定义为当前CPU的最高性能水平与系统中任何其它CPU的最
>    - Documentation/translations/zh_CN/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task utilization"
>   
>   
> -UTIL_EST / UTIL_EST_FASTUP
> -==========================
> +UTIL_EST
> +========
>   
>   由于周期性任务的平均数在睡眠时会衰减，而在运行时其预期利用率会和睡眠前相同，
>   因此它们在再次运行后会面临（DVFS）的上涨。
>   
>   为了缓解这个问题，（一个默认使能的编译选项）UTIL_EST驱动一个无限脉冲响应
>   （Infinite Impulse Response，IIR）的EWMA，“运行”值在出队时是最高的。
> -另一个默认使能的编译选项UTIL_EST_FASTUP修改了IIR滤波器，使其允许立即增加，
> -仅在利用率下降时衰减。
> +UTIL_EST滤波使其在遇到更高值时立刻增加，而遇到低值时会缓慢衰减。
>   
>   进一步，运行队列的（可运行任务的）利用率之和由下式计算：
>   
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcea3d55d95d..e94d65da8d66 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4870,11 +4870,9 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>   	 * to smooth utilization decreases.
>   	 */
>   	ue.enqueued = task_util(p);
> -	if (sched_feat(UTIL_EST_FASTUP)) {
> -		if (ue.ewma < ue.enqueued) {
> -			ue.ewma = ue.enqueued;
> -			goto done;
> -		}
> +	if (ue.ewma < ue.enqueued) {
> +		ue.ewma = ue.enqueued;
> +		goto done;
>   	}
>   
>   	/*
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index a3ddf84de430..143f55df890b 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -83,7 +83,6 @@ SCHED_FEAT(WA_BIAS, true)
>    * UtilEstimation. Use estimated CPU utilization.
>    */
>   SCHED_FEAT(UTIL_EST, true)
> -SCHED_FEAT(UTIL_EST_FASTUP, true)
>   
>   SCHED_FEAT(LATENCY_WARN, false)
>   

