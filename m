Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B7778799
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjHKGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjHKGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:44:17 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA84730C1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:43:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a1ebb85f99so1516903b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691736230; x=1692341030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sS6hXtPzspj38wj+jvCfyxb7WndD63T0Lklxv5oEJTE=;
        b=iswW/HCUbE390vgogFafFLk47mo5k8aefcf4g9x96VfpZXQAP9JtoDW5X+hVXahOFr
         7TA9T/pDaxNdUChwTb3etP3SvGSNpeXaSQ6cZAyz0dlQdC3a0LtnjhN5xvltU2OZ4xBv
         4hwdu6adm7XXhnFWlqQhk0MuaNU302bUmf2Va7HDuGCJJ33MKWKMh/mdL+IqV5kRJrn1
         VVJLEtS282f+FAVmOf9cBk9isa/Pmr2cCsh9KW7rqtOVK3k7CILPIBaQJXvqPWYF0G32
         OEBG/NCLQ7EGrwEKgiKmJDPfdfTIFl7/NOzpYW+R12X+WUjjVA0TooN4YkoGYU6q5amd
         +Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691736230; x=1692341030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sS6hXtPzspj38wj+jvCfyxb7WndD63T0Lklxv5oEJTE=;
        b=AnGlBo01e1yDzg9hTGEu7oV7R8qYnmTyEJuosUs7p2M+/Uc82fardzIsxYXpQFFe/e
         wyvgpoixz29hT8ru9/Ff42gRDhkFRrItXd4M3j13W1HJ1mhu4sAXO+4LkfW+i/PQSaXY
         7IHtaUfUNwr1wgBhPoCb7cZIgiferDpsHHb4q/+E28PsXf7Pq0ryLI/pk5R1afqfwoXS
         K1dEMyeNMoKAc7UsQX8hKfqa2+JsRGX4JtRuwvvNK0oBm42lL3ODxzDJnfwWw1wyFnj0
         yWFXt45xs5mqPg8ZSIqzdkNzt9XIB3uUorKUTgetdSAwxtwv4tVy6Ts8FsgpUxSR/EPO
         cXtQ==
X-Gm-Message-State: AOJu0Ywc9ePmnC7eTqVFoSscS9WQA/0WOW0Kl+Ic2zQfkos+ozITDVZq
        oH2uALZbllmGf51GL2pAoups2w==
X-Google-Smtp-Source: AGHT+IFsEQPHD1cKqyx1ot/n6/a/bo/AGZr5xa53D0fzWF8qAuHC0uQkrGbsDtbeGZWv/HC+ILAwFA==
X-Received: by 2002:a05:6358:784:b0:134:f070:d6b8 with SMTP id n4-20020a056358078400b00134f070d6b8mr1550112rwj.4.1691736230167;
        Thu, 10 Aug 2023 23:43:50 -0700 (PDT)
Received: from [10.4.35.223] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id r30-20020a63441e000000b0056001f43726sm2581250pga.92.2023.08.10.23.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 23:43:49 -0700 (PDT)
Message-ID: <bfd5f38f-9712-39e0-6880-bc494b95b107@bytedance.com>
Date:   Fri, 11 Aug 2023 14:43:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] psi: update psi irqtime when the irq delta is nozero
Content-Language: en-US
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20230810131514.910401-1-lujialin4@huawei.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230810131514.910401-1-lujialin4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/10 21:15, Lu Jialin wrote:
> If update psi irqtime whether the irq delta is zero or not, the performance
> will be degradation when update_rq_clock_task works frequently.
> Therefore, just update psi irqtime whether the irq delta is nozero.
> performace test of times(libmicro):
> 1) without psi_account_irqtime in update_rq_clock_task
> [root@arm64_perf]# ./times  -E -C 200 -L -S -W -N "times" -I 200
> Running: times# ./../bin-arm64/times -E -C 200 -L -S -W -N times -I 200
>              prc thr   usecs/call      samples   errors cnt/samp
> times          1   1      0.45210          188        0      500
> 
> 2) psi_account_irqtime in update_rq_clock_task
> [root@arm64_perf]# ./times  -E -C 200 -L -S -W -N "times" -I 200
> Running: times# ./../bin-arm64/times -E -C 200 -L -S -W -N times -I 200
>              prc thr   usecs/call      samples   errors cnt/samp
> times          1   1      0.49408          196        0      500
> 
> 3) psi_account_irqtime in update_rq_clock_task when irq delta is nozero
> [root@arm64_perf]# ./times  -E -C 200 -L -S -W -N "times" -I 200
> Running: times# ./../bin-arm64/times -E -C 200 -L -S -W -N times -I 200
>              prc thr   usecs/call      samples   errors cnt/samp
> times          1   1      0.45158          195        0      500
> 
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> ---
>  kernel/sched/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c52c2eba7c73..69c4f229d6d1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -722,7 +722,8 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>  
>  	rq->prev_irq_time += irq_delta;
>  	delta -= irq_delta;
> -	psi_account_irqtime(rq->curr, irq_delta);
> +	if (irq_delta)
> +		psi_account_irqtime(rq->curr, irq_delta);
>  	delayacct_irq(rq->curr, irq_delta);
>  #endif
>  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING

LGTM, thanks.

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
