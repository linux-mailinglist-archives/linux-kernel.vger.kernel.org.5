Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033A87C68FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjJLJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjJLJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:05:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7996998
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:05:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c88b46710bso5739675ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697101523; x=1697706323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df1L8AVtk7cVa1LInG0Wd7vD5C0a5CnuVGre6lzybwE=;
        b=J1Ga4lDATNNv6dBy3EUDtUWdU7tEytHeDglZI+ctodzajVjL9aaMKlXI1fU1tOLSlH
         lI6gfuHjfP66FVPDTCQMLwq1wcwYYqCmoPuTZohiR1MZSn9m7wHw/096deiDNdcxlZiM
         emkz5sVgtGuoSAU10+1deQeJJvOaC4kM2eeZdXstki7qcpUzEQbQmnTec1vhRgR0+WgK
         4y0S9pAxzLQW4nkkn1g/Q9+MJZBbOPXrVmOdR4cCqQ4rcjLlU0mr/E6O+KfoIc85f36Q
         0N4mthpa7nqOeZeInMthYASFQrPB6qoUv9gyPkLTxYlrhaAgwpNbc/RUeLw5XYBRfLrU
         r19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101523; x=1697706323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=df1L8AVtk7cVa1LInG0Wd7vD5C0a5CnuVGre6lzybwE=;
        b=o1mlZTm0xWhG60qiBNiV2KMs1B+Tiay41/ED/kZMmq8pPIbalZq2YriYNKMWDsD+Qm
         4pHaumU/26uIhzuJBN7qDgyBTC0vCAf41xDcn2v+6q5XK1kgGr8mHf2PA5/NlMzEs331
         hY7UPDXXJsLW+gILWkX/CMeIXVhnpZk1geRChdxC06NYjOQTewnNAwKxZlyWNfo3jNdR
         5pOM9gPg7umx1wh1xeCstCuxS49oTjfdiWo4NGJM0/NKKFp3rIFSDDgxk5nXG5ydjEV6
         Ur/Upm2wV9x4Arv6ztJk+i13EZAHR43uYqlPAzSVpXgsWLszYKow79csd2T2vv7LVrB5
         DRoA==
X-Gm-Message-State: AOJu0YzzPh3IxBJ+gn4NQPb19sTXeG6vSJZHKXnvE07tGMfAiI3khZzF
        RMLRx3drUx/bHFOR2ZcVVQXKgQ==
X-Google-Smtp-Source: AGHT+IGfvT/Bkph7rigr9Uoo298pFe3YYgaFEZie1U+vReFDsIdNTPijiVfvd+YeNWH5tVPzqGyVZQ==
X-Received: by 2002:a17:903:32cf:b0:1c5:8401:356c with SMTP id i15-20020a17090332cf00b001c58401356cmr25839533plr.62.1697101522816;
        Thu, 12 Oct 2023 02:05:22 -0700 (PDT)
Received: from [10.84.141.140] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001c7443d0890sm1410977plb.102.2023.10.12.02.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 02:05:22 -0700 (PDT)
Message-ID: <a3aae63d-b4bb-ace2-ff35-51961364cd1c@bytedance.com>
Date:   Thu, 12 Oct 2023 17:04:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [External] Re: [PATCH] sched/core: Fix wrong warning check in
 rq_clock_start_loop_update()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Igor Raits <igor.raits@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230913082424.73252-1-jiahao.os@bytedance.com>
 <20230928114159.GJ9829@noisy.programming.kicks-ass.net>
 <979f948c-7611-b137-a06a-ca09ff63f919@bytedance.com>
 <20231010135340.GK377@noisy.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20231010135340.GK377@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/10 Peter Zijlstra wrote:
> On Sat, Oct 07, 2023 at 04:44:46PM +0800, Hao Jia wrote:
> 
>>> That is, would not something like the below make more sense?
>>
>> If we understand correctly, this may not work.
>>
>> After applying this patch, the following situation will trigger the
>> rq->clock_update_flags < RQCF_ACT_SKIP warning.
>>
>> If rq_clock_skip_update() is called before __schedule(), so RQCF_REQ_SKIP of
>> rq->clock_update_flags is set.
>>
>>
>>
>>
>> __schedule() {
>> 	rq_lock(rq, &rf); [rq->clock_update_flags is RQCF_REQ_SKIP]
>> 	rq->clock_update_flags <<= 1;
>> 	update_rq_clock(rq); [rq->clock_update_flags is RQCF_ACT_SKIP]
>> + 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
>> 	* At this time, rq->clock_update_flags = 0; *
> 
> Fixed easily enough, just change to:
> 
> 	rq->clock_updated_flags = RQCF_UPDATED;
> 


Thanks for your suggestions and help, I revised the commit message and 
sent patch v2.

https://lore.kernel.org/all/20231012090003.11450-1-jiahao.os@bytedance.com/

Please review again.

Thanks,
Hao

>>
>>           pick_next_task_fair
>>           set_next_entity
>>           update_load_avg
>>           	assert_clock_updated() <---
>> }
> 
