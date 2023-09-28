Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51F7B276F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjI1V1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjI1V1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:27:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D51A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:27:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9936b3d0286so1777577166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695936421; x=1696541221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ibrU/CIB9KZaywH++AuRUlb3Elao9uoi1QbD8hFrgo=;
        b=dJ+jIBzplxgxz/S+8kVgWH8hfQXz7MpIEqLXKHMHwz0QpKJKhovIvdzpRzB02+xlk/
         wXqQHMRUZu2m1RyGapy4v1ZSXWrQIrKAMFpQmAWQTUZ/JboQ3HT5KrCONNavdKqS40BV
         EaeipcWCQA6ezA4cUaxCpvKei6VpQg+intHLWSSSIw35OoKEQsNqZZLpRAXfE1WLyTQv
         PjmQf7g4oQuzrhc056eru5N1q8XD7j1oAeH7brGkZ8S+KS9XNrDyYzRDZPENJ/w3f0FV
         Ek+VkNxkyzPxZYbvSDDAmkbBSMLLun5lGl/AAHGWQbmd0xmpUKUYTLoSu/Z+CMOghclm
         8wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695936421; x=1696541221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ibrU/CIB9KZaywH++AuRUlb3Elao9uoi1QbD8hFrgo=;
        b=pha54CdH+hhOtoD97FMWdimOybUILzHyDsAmLpSOtAMFKwNx4EAm9uZRZqY1mF3hHz
         V0ID9mXK65wUimzAx/hhCEb1NvgVZojJY4trWoSo6X1OEb34NfSun1sbCnDB5hPFKzwz
         yeoQvhf7hNbmSkx+Pvyf3hEDlNqty/U1WwFb4kANLjfCXaFEMrx5eBE3+ourxCPQqQQb
         rYJ+p2TUxZ96tp8PfjQiiMGMApU35LdrZwwVs4mp3vRW0/eN/TLYyV1x2a7oyWqtTfTd
         /0jNxQe92UnAHJr0yBM2pLoqttDo5FxqNgj742eCYq/HiUwvfMQApV0W9Y9smtUfKWW6
         bt1Q==
X-Gm-Message-State: AOJu0YwE76dbT9F/aRf6JcO0Mphtye+1HNIRgvLCQhwor0L5ZDGuriTy
        AEkqhhuMhBxcsieppEdS1p4=
X-Google-Smtp-Source: AGHT+IFacHbmQLx545SrJ0nhC6ojjymTmk4vpzS+RzP/NczZ9yC+pNarP8oTK2dBC1VDVyuD4FIvDQ==
X-Received: by 2002:a17:906:25d:b0:9a5:da6c:6539 with SMTP id 29-20020a170906025d00b009a5da6c6539mr2653698ejl.75.1695936421318;
        Thu, 28 Sep 2023 14:27:01 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906228600b009adc743340fsm11342701eja.197.2023.09.28.14.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:27:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 23:26:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: update psi irqtime when the irq delta is nozero
Message-ID: <ZRXvoq6uNk4+cs7Q@gmail.com>
References: <20230810131514.910401-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810131514.910401-1-lujialin4@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Lu Jialin <lujialin4@huawei.com> wrote:

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

Erm, if irq_delta is zero, then a whole bunch of code around the place you
modified becomes NOP as well, right?

Thanks,

	Ingo
