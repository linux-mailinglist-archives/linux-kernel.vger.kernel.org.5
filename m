Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9A7CCDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjJQUSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjJQUSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:18:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8492
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:16:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so78295181fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697573805; x=1698178605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaIGvl80+qhskhe19qFhB+sVqFBOVOXWQVk0zgRYuzI=;
        b=V5gX+/g13dXajaumRLiPcZi6cj0YoMKDT7GuFMMH+VBaAIJ/JOa5rDb1QpVTsMbG8l
         ysvnoNfARAZuZlhxu5NrM9fhi51smXXxctFuXxRJTzPHeLpPonhJiITxwxWCKNT9lGks
         ROOmzeDzj3QjLhUqVRwoiTd/qNiBX2E9yoGyknYH/JhV78Mg4Hxbmyg8Td99u/MBVlf4
         yaROP4tANPeT00K60czAUFt+PR+X0ByTha8UZrTePC7B1hXiubGfyqR4guILZs+k7HO3
         5sbuUGIWBaZteM+pkpfvMuTaRu9njFro5YW+1l2bW3RbrHWjzccofSOATdqw8hXxB8g0
         Qzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573805; x=1698178605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaIGvl80+qhskhe19qFhB+sVqFBOVOXWQVk0zgRYuzI=;
        b=b+i8QZl/u9hyxEfQfrK+pLfEx/AH2gma6Ivi0M4Ry+pu1P459fF8ODiOa+trepRsgo
         dk4xHxmcsrKS4Wl7GpdxUKsvvkDvoYnyFCd0h4nSC3duofJEmdUPmuHjLZjENGtdiND2
         hiV06eZArlVKyEY1ya1mYBCNsZRZ6R3DfjKJ0WFl7EwVxO1nYPlu8aGMFSWRLeE+Y1dl
         jP6Ujsx3ko3GWOa9s+eBKDhuH8eywscAyDl+4mAyZaLpxbykz91nWaLY/CEgSdiktSdF
         EaQdGPS4FoeiXpSiy77C30REpp4G4DyZGaTgfAg737L5UJEPiCdWKa3P9MKZfFmDKEel
         IKwg==
X-Gm-Message-State: AOJu0YzaL6pNy2Y46TQynSBqLfBZMvT53/LqCA4y9GINA3WDhF10ds3s
        m4ALWGKUTLghUs5ZNP1A3wtQ32r45aY=
X-Google-Smtp-Source: AGHT+IF+tIVpnxYSv/Z5xKnVbwpA8MlFCky7CEiJkf8ds2k5rh23arXnpqaV8Iqq+I9XIU5EhpF/cw==
X-Received: by 2002:a2e:3e05:0:b0:2c5:50d:3fc3 with SMTP id l5-20020a2e3e05000000b002c5050d3fc3mr2236498lja.7.1697573805314;
        Tue, 17 Oct 2023 13:16:45 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c348e00b00405391f485fsm2688524wmq.41.2023.10.17.13.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 13:16:44 -0700 (PDT)
Message-ID: <23773e70-c7db-4d8d-90b9-0b0b53ec2e89@gmail.com>
Date:   Tue, 17 Oct 2023 21:16:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 reweight_entity
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de,
        syzbot <syzbot+3908cdfd655fd839c82f@syzkaller.appspotmail.com>
References: <0000000000004b632f0607d07fb0@google.com>
 <CAJwJo6ZGXO07=QvW4fgQfbsDzQPs9xj5sAQ1zp=mAyPMNbHYww@mail.gmail.com>
 <20231017190710.GF1599@noisy.programming.kicks-ass.net>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20231017190710.GF1599@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 20:07, Peter Zijlstra wrote:
> On Tue, Oct 17, 2023 at 07:58:56PM +0100, Dmitry Safonov wrote:
>> FWIW,
>> Managed to locally reproduce it twice on 58720809f527 (tag: v6.6-rc6)
>> Linux 6.6-rc6 + TCP-AO patches on the top.
>> (but can't reproduce reliably at will)
>>
>> [dima@Mindolluin linux-tcp-ao]$ ./scripts/faddr2line vmlinux
>> reweight_entity+0x3b0/0x490
>> reweight_entity+0x3b0/0x490:
> 
> Could you please try:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/urgent&id=a3b75dce9d9ae4510ea75b655567f50622f48706

I've run a hundred times the test that previously hit it twice, no
reproductions.

> ---
> Subject: sched/eevdf: Fix heap corruption more
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Oct 17 16:59:47 CEST 2023
> 
> Because someone is a flaming idiot... :/
> 
> Fixes: 8dafa9d0eb1a ("sched/eevdf: Fix min_deadline heap integrity")
> Reported-by: 0599jiangyc@gmail.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218020
> ---
>  kernel/sched/fair.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3699,7 +3699,8 @@ static void reweight_entity(struct cfs_r
>  		 */
>  		deadline = div_s64(deadline * old_weight, weight);
>  		se->deadline = se->vruntime + deadline;
> -		min_deadline_cb_propagate(&se->run_node, NULL);
> +		if (se != cfs_rq->curr)
> +			min_deadline_cb_propagate(&se->run_node, NULL);
>  	}
>  
>  #ifdef CONFIG_SMP

Thanks,
         Dmitry

