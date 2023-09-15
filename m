Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB467A2ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbjIOW6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbjIOW63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:58:29 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E0101
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:58:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ab244f2c89so1745089b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694818703; x=1695423503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WHC5fOtD0kGcTh6VRyI5qWBD4SEzsqeup1TPivNbvs=;
        b=OdjkJiyFMrXalMwrXFau6hKQVB52qNz8EVi7lqutJseRpsRVgx718mLPbjfFbtNWO8
         oJowf/xE2+a4Zu148KBUGpT6wvPY98UgCSWWguqq1A8f2q6IKmfG7YKNWjrGeHqWyDB1
         WDovKENnv+5nkUxFYuN83PLo5dYrUI3aHWxmllrDzfBsKkryVukMpi7IHTAE4MFtdz9O
         Tm6/uoPYld4V1aAc2/VFLe6ko+jrj8BrrpN2V8HyB/vsJJ3ya5Lluf3DZZDW9tqq1kKp
         g8JnvCaf7jPPz27uklAq8U87Oa1EEYM7sRma4Olak5LRJBmBCKANh8huPqfYXrLTzd0W
         5C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694818703; x=1695423503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WHC5fOtD0kGcTh6VRyI5qWBD4SEzsqeup1TPivNbvs=;
        b=lW9f5cmWO8MG0Vc+tPJ7H0sArRPUHKKSjM9h5PcKFUBAh4w4pAKSYMt2GvEi8KLE1h
         ypX6POYeVQxIr6tCsqYdSRa48+SVSmLzOgsIdt/lDzKueR9g79857m8uBaEYLgCQ/Pg+
         MRnlm8kn5nHWgSKjjUdhGhkG2C5qTsrK+kSA6SYSPaU0/AFW6HUQH6g17oVXkByeEURU
         5Y/EEwCFNi+N6Z457o+RJz0W8AK79TWb23qDbXIaCUIWkFI5yfzUmx0zielV7jeiQ8wO
         NJZ2xMlGivrdRP60jaoF7v3Llw0jYPVkEaUMjZiKrfxHS/aJIymD8E/6a+S/96VBZdLG
         +qSQ==
X-Gm-Message-State: AOJu0YzKJMyJJ7A0WXE6W9ccRwfHdIHk58dSJ0sqopOWDBlioCIF/fyY
        0Z6Mqd6Yp7KxvolFIBWiMShg3Q==
X-Google-Smtp-Source: AGHT+IEuqrYQMqef82/PipZbhtXVCMFgEyXx7i3f2X9kjkSxUC9q1/Eud8UjS7MXweE4dh5yn2uVXg==
X-Received: by 2002:a05:6808:aa8:b0:3a7:4f89:5b6d with SMTP id r8-20020a0568080aa800b003a74f895b6dmr2995025oij.58.1694818702982;
        Fri, 15 Sep 2023 15:58:22 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c2:58f9:c053:39fb:8dc4:3de5? ([2804:7f1:e2c2:58f9:c053:39fb:8dc4:3de5])
        by smtp.gmail.com with ESMTPSA id c21-20020aca1c15000000b003a9a28f6ec7sm1994473oic.52.2023.09.15.15.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 15:58:22 -0700 (PDT)
Message-ID: <4deec0bc-1eee-4853-8683-767a278f9e0a@mojatatu.com>
Date:   Fri, 15 Sep 2023 19:58:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to
 drop
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Pedro Tammela <pctammela@mojatatu.com>,
        Ma Ke <make_ruc2021@163.com>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230915104156.3406380-1-make_ruc2021@163.com>
 <CANn89iJyktWcztc76Pw16MP-k-DfSjstW+WFgRxwUat7p25CGw@mail.gmail.com>
 <16461255-c2c0-2ffd-f031-5b7a1f67bf7e@mojatatu.com>
 <CANn89i++j0-QJ1WE=RO4_ucN9k-DgqK52jLSTcz_s_DmFiAnFw@mail.gmail.com>
 <CAM0EoMmzCBewv4hfWQrNb+gaO_+aR7jnMbsQScN+FEchTdWXmw@mail.gmail.com>
Content-Language: en-US
From:   Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM0EoMmzCBewv4hfWQrNb+gaO_+aR7jnMbsQScN+FEchTdWXmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2023 19:55, Jamal Hadi Salim wrote:
> On Fri, Sep 15, 2023 at 11:06 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Fri, Sep 15, 2023 at 5:03 PM Pedro Tammela <pctammela@mojatatu.com> wrote:
>>>
>>> On 15/09/2023 09:55, Eric Dumazet wrote:
>>>> On Fri, Sep 15, 2023 at 12:42 PM Ma Ke <make_ruc2021@163.com> wrote:
>>>>>
>>>>> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
>>>>> assume res.class contains a valid pointer.
>>>>>
>>>>> Signed-off-by: Ma Ke <make_ruc2021@163.com>
>>>>> ---
>>>>>    net/sched/sch_drr.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
>>>>> index 19901e77cd3b..2b854cb6edf9 100644
>>>>> --- a/net/sched/sch_drr.c
>>>>> +++ b/net/sched/sch_drr.c
>>>>> @@ -309,6 +309,8 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
>>>>>           *qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>>>>>           fl = rcu_dereference_bh(q->filter_list);
>>>>>           result = tcf_classify(skb, NULL, fl, &res, false);
>>>>> +       if (result == TC_ACT_SHOT)
>>>>> +               return NULL;
>>>>>           if (result >= 0) {
>>>>>    #ifdef CONFIG_NET_CLS_ACT
>>>>>                   switch (result) {
>>>>> --
>>>>> 2.37.2
>>>>>
>>>>
>>>>    I do not see a bug, TC_ACT_SHOT is handled in the switch (result) just fine
>>>> at line 320 ?
>>>
>>> Following the code path (with CONFIG_NET_CLS_ACT=n in mind), it looks
>>> like there are a couple of places which return TC_ACT_SHOT before
>>> calling any classifiers, which then would cause some qdiscs to look into
>>> a uninitialized 'struct tcf_result res'.
>>> I could be misreading it... But if it's the problem the author is trying
>>> to fix, the obvious way to do it would be:
>>>          struct tcf_result res = {};
>>
>> CONFIG_NET_CLS_ACT=n, how come TC_ACT_SHOT could be used ?
>>
>> Can we get rid of CONFIG_NET_CLS_ACT, this seems obfuscation to me at
>> this point.
> 
> The problem is the verdict vs return code are intermixed - not saying
> this was fixing anything useful.
> We discussed this in the past after/during commit
> caa4b35b4317d5147b3ab0fbdc9c075c7d2e9c12
> Victor worked on a patch to resolve that. Victor, maybe revive that
> patch and post as RFC?

Okk, will review, rebase on top of net-next and post.

cheers,
Victor
