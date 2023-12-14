Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEFD8131D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573047AbjLNNl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjLNNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:41:21 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F9125
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:41:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0bcc0c313so44004525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702561264; x=1703166064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKUzf/bq7okvr9gibq4dngEFELPnNApNctO8aNYKtb0=;
        b=lsA97wLI6CP+CiKpeB18H46/QfMznASfa0Sc79QTJbGRUAuafEoDi+77aZ9YWNxNmA
         /rM4P3Ha5udg/UuvEi/7EZkFWNq+aR4s0cEUXj4lKM8mOXDoBwkLCN30HcTpcnxOwQ+q
         Ff7b2mLzgcz3mKYizOp0Yr4M2KuNJtOuAgD3ocatHp4+3Xn+HrPwaRHp8U3H/NOPeqAj
         zQ165WUwqaNFhzmcs/SP/yz3uA3rjIuOyS5stIOx7qyJIHLjMGTaVZWkKoLYhg17Z3An
         G+MEmta2ReWKnrJyvhWP8TmgT8TAHGlN9Aq/aYajOU2YDAxpyT12sdhTDuYFDtcLb0lV
         +L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561264; x=1703166064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKUzf/bq7okvr9gibq4dngEFELPnNApNctO8aNYKtb0=;
        b=T3fx2b5d2Ca3o9sRYkQJFQ+nms/ndRCU1gNkz6n/IsNEVdN21U9xwrENVp9HSyXEoS
         j093OgHY7ru+AS3k7JYH443h27xQWljoq2zsk89FGlLoK21gDt8RXtaV9bJna8By95P9
         RHtwsOuc6OAPa+qqHLDjdAkm5YuzcJ3bPMd1UD1AMHCi3yf7SMFbNMvRa3UmZIVeTuZ7
         xx8NZgiM/sghDP8nwR8DHSFTEx2rmDMV8o8bvrMllL81k1G3yeCRpKCC2kW0PLZlKr5p
         NoyOofOU2fBCz4cwb+SESsL3cbyyz379X3guyPG6LGE7SA75fnH/fvPJ7NMRPKsTtPcl
         3ang==
X-Gm-Message-State: AOJu0YwDolI9biL/xxcnLhL32Azzp8SQ/6i/0NTHUaRs7nGjzQb09SWK
        BhqDhIbcwD+jcfND3R6oB1P8bw==
X-Google-Smtp-Source: AGHT+IHAckoz6l3PYYeLTbtiyhcmzbqjulWXwqxhg3YsJjHMCT+Twc88rdZ7rK2MgkzcweFGWygOKw==
X-Received: by 2002:a17:902:db06:b0:1d0:8383:7433 with SMTP id m6-20020a170902db0600b001d083837433mr5054661plx.36.1702561264001;
        Thu, 14 Dec 2023 05:41:04 -0800 (PST)
Received: from [10.254.92.96] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b001cf570b10dasm1222765plo.65.2023.12.14.05.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:41:03 -0800 (PST)
Message-ID: <863ba31e-8df3-4168-acfc-503bfe1a0aac@bytedance.com>
Date:   Thu, 14 Dec 2023 21:40:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: Re: [PATCH] sched/fair: remove next_buddy_marked
Content-Language: en-US
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
References: <202312141319+0800-wangjinchao@xfusion.com>
 <CAKfTPtCrBvyxJzeRDARFjbU8P5BYW27So7gYE4FPWBDC0=HL3Q@mail.gmail.com>
 <83099016-f609-4ac0-94ab-909ac9c96582@bytedance.com>
 <ZXr82WOsSCIxkuPa@fedora>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZXr82WOsSCIxkuPa@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/23 9:02 PM, Wang Jinchao Wrote:
> On Thu, Dec 14, 2023 at 08:21:53PM +0800, Abel Wu wrote:
>> On 12/14/23 4:18 PM, Vincent Guittot Wrote:
>>> On Thu, 14 Dec 2023 at 06:20, Wang Jinchao <wangjinchao@xfusion.com> wrote:
>>>>
>>>> Remove unused `next_buddy_marked` in `check_preempt_wakeup_fair`
>>>>
>>>
>>> Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")
>>
>> After this commit @pse preempts curr without being the NEXT_BUDDY, but
>> IMHO it should be, so how about this?
>>
>> @@ -8259,8 +8259,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>          /*
>>           * XXX pick_eevdf(cfs_rq) != se ?
>>           */
>> -       if (pick_eevdf(cfs_rq) == pse)
>> +       if (pick_eevdf(cfs_rq) == pse) {
>> +               if (!next_buddy_marked)
>> +                       set_next_buddy(pse);
>>                  goto preempt;
>> +       }
>>
>>          return;
>>
>> which will align with before.
> Seizing this opportunity to inquire about a question:
> What does "buddy" mean in the context of the scheduler?

struct sched_entity

> 
> Is the effect the same between
>      preempting after pick_evfd(cfs_rq) == pse
> and
>      preempting after set_next_buddy(pse) followed by pick_evfd(cfs_rq) == pse?
> Would both scenarios result in pse becoming the next scheduled se?"

Probably, since pse is the one preempts curr, pick_next_entity() could
return pse directly without walking the rbtree. So the difference is in
performance.
