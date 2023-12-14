Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01494812FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572911AbjLNMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572954AbjLNMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:11:07 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9310123
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:11:11 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d05199f34dso45871845ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702555871; x=1703160671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NR2YoO8t7v6bAvzxwQFbuBne8KZ84j3jDvGUNCqmPVA=;
        b=CAis/n42W1TI56a5lSPLSZpRyPsdxh5Q+yJ1Tx3i+hPvt9rcwzadRe2ZGW+OuSh/Oa
         3yyeeqN6U87+6UnaquPtJmbkLoN1yjs8POA3VZFevQjnjMLMTGJwym33YhR2TwS44iR2
         jP4GwfFcxqRVuqhoa5Hecxz2z+3Rw200NPye1wq/Id59sXsTRtWa1V9X+PfRW6V9I2Wc
         RuBnID1UWrMd1SaAq6ZdiPx4tAmYS2TCHcIToPFF3MZTpXSWAs+1aSp/uVe7+jvVlzGC
         F058e7WiqtCGga6avdurqlICUU/qmgJ53uRGDvbsJOrJWUYacvVJtgfZZ4e4uANO0D20
         N6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555871; x=1703160671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NR2YoO8t7v6bAvzxwQFbuBne8KZ84j3jDvGUNCqmPVA=;
        b=iunpW9I4hsJPZRd5LpW8mF187wFsJUH7fzmBkKlTrawpVfjIaIL8gxFMXJibMs4F/2
         oFKFPhbIsfF5JNqnURrfW3LqVOJaO10dCZuMQ9mxzFRtRLlyooeZkCeMvmVcrHNExqFP
         Prso7s3k5BpHMFAt6JDUdsnFGMrzveUNp5I3J+hAV97mYspR+HGs/glmcxEe6SKXmXUf
         dbiEMgQKU/DIrvuk1y8KmJhU41E0Q/jPxN9QYOwkA33M9ACQXd34YKY79zhgWzSweAw5
         iNBHfnQxTApWFjsFz95ljYghAEZH3L5Z612RNaws/EflSvGN0r4cTyV1MhtWGauiactP
         ZG7Q==
X-Gm-Message-State: AOJu0YxEw027fnNW5UxVJB5pxr9Nag/RAk0Kn0ooLTLyRhzBHXmf3lPj
        04f4/f/C6so9dRmMnnSLKjwVzw==
X-Google-Smtp-Source: AGHT+IH/bFmJfWefReouQO6rYx8QLUQVB7AoX2dD/fYiKp615x57HEwzBAscSv9Wq/5LGVX4BL8xGw==
X-Received: by 2002:a17:902:fc46:b0:1d0:897e:95e5 with SMTP id me6-20020a170902fc4600b001d0897e95e5mr7044851plb.35.1702555871404;
        Thu, 14 Dec 2023 04:11:11 -0800 (PST)
Received: from [10.254.92.96] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id v5-20020a1709029a0500b001d0d312bc2asm3051978plp.193.2023.12.14.04.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:11:10 -0800 (PST)
Message-ID: <6c89812d-a7ef-42df-9ca7-22092937f13c@bytedance.com>
Date:   Thu, 14 Dec 2023 20:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] sched/fair: merge same code in enqueue_task_fair
Content-Language: en-US
To:     Wang Jinchao <wangjinchao@xfusion.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
References: <202312101719+0800-wangjinchao@xfusion.com>
 <CAKfTPtCMOPVhjpLW3Y3fb4=rfYnAKzYeDmdMCRHjPzZdXYjVxg@mail.gmail.com>
 <ZXlXXaGUsiH14pUb@fedora>
 <CAKfTPtDCSQg_Nwh5osRVL0TEzvNZjrUmg_KsVmJySjV_XnOHzw@mail.gmail.com>
 <ZXrPTbXEyBlT+RgP@fedora>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZXrPTbXEyBlT+RgP@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/23 5:47 PM, Wang Jinchao Wrote:
> On Wed, Dec 13, 2023 at 09:23:46AM +0100, Vincent Guittot wrote:
>> On Wed, 13 Dec 2023 at 08:04, Wang Jinchao <wangjinchao@xfusion.com> wrote:
>>>
>>> On Mon, Dec 11, 2023 at 04:23:52PM +0100, Vincent Guittot wrote:
>>>> On Sun, 10 Dec 2023 at 10:22, WangJinchao <wangjinchao@xfusion.com> wrote:
>>>>>
>>>>> 1. The code below is duplicated in two for loops and need to be
>>>>>     consolidated
>>>>> 2. Fix the bug where a se's on_rq is true but its parent is not
>>>>
>>>> Could you clarify which bug you want to fix ?
>>> Taking into account the additional information provided by Tim,
>>> this is not a bug. Therefore, this patch is merely a logical
>>> simplification.
>>
>> If there is no bug why changing it ?
> For two reasons:
> 1. (from Abel Wu)
> It doesn't need to, but it can actually bring some benefit from
> the point of view of text size, especially in warehouse-scale
> computers where icache is extremely contended.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-56 (-56)
> Function                                     old     new   delta
> enqueue_task_fair                            936     880     -56
> Total: Before=64899, After=64843, chg -0.09%

But TBH this benefit is kind of weak to argue about, given that you
don't have any data supporting it.

> 
> 2. For better code comprehension
> I became curious when I reached this part, wondering why there is a lot of
> repetition inside these two for-loops. Then I thought about 'do not repeat yourself,'
> and I feel that merging them would lead to a clearer understanding. Of course,
> it might be because I am just starting to read scheduler-related code and am not
> yet familiar with the entire logic.
>>
>> The duplication is done in order to have the same pattern in :
>> enqueue_task_fair
>> dequeue_task_fair
>> throttle_cfs_rq
>> unthrottle_cfs_rq
> Due to the two points mentioned above, do we need to adjust all four functions?
>>
>> so there is no need to change it
> I plan to get familiar with the scheduler-related code first and then consider this.
> 
> Thanks
>>
