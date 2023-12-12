Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C680E2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbjLLDRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:17:51 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FEABA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:17:57 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d9f4eed60eso2796871a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702351077; x=1702955877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JL3+Z5lKtZ4OIn5vvPei8/Cdnr/eDA3//dMLcXoYY60=;
        b=CDsPYreVvAdFiVDQMmA5Ia0B6NclF8GSVR7rpt90Pel5AJdXAdO6PE67YE78le5pqV
         UTr83vS6Pg9aREZVVX5woOFm10Hoas8KfcUplGxdgfuwOJPy7UmQzfNLekZmvHq6Nwob
         cQyHuxvM0CdjLvuk3f3v831dqIpj53K2ZV+fR07kUNZ2NRrpOnAnmtTA07ysoXts483z
         ypMN9gSqA3G5TP8mPS4hSvz+piQwEKCffEVGuO+TfdcO9gKc4R48I8ZtbZVuAqDbeaM6
         YXb2ZSwOEvX0N0YijQwGuxdQMHUOX5KAX8L3vUmfD57Gec0COq70I/1EQaVtBGUL0HUb
         nm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702351077; x=1702955877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL3+Z5lKtZ4OIn5vvPei8/Cdnr/eDA3//dMLcXoYY60=;
        b=VX0YYOcPvq9/ZzQAlENGsTXwMKYppPQpyi+EXKAWZv9Czg/AaxXCPS0JPS5sjvLcWr
         MlMCkGNEsawzImkG8ywHqy6L1eVydjA7B+TW3hXoPgoE9fqNObMK+246Q76dSuj4TUG8
         BhA9/Ee1i+LZ6rKg81e8oeUVBmXO0K1yq2Tc0HdtHr0VPU2EHO+qYOPmMQlW24jts+gm
         cbdfv4etbXxcdgk5mlA8RlrrmHsCPcP2Lt4Yc7Natdo+afUWd1DwbKC4Rz7GofKUW5Tc
         t+eSDzoLSR82Fa+2Podm2J4xKhZ87LGxZxCbNcC74gpQ1rrl/v7QTfC+shCAuqV17xU4
         2XQw==
X-Gm-Message-State: AOJu0YwMEI48MJIPkNZM7nx45uh1BZ0p/fQ1IsEDAoQKvAToy/EqG1XE
        fsZGmXX1hbowSJwop5TsUgbDkg==
X-Google-Smtp-Source: AGHT+IF+8v/npOIPi86EmPXIsj03aoQit7ZWOhMpz2xZhZy1bNlELMPEwufjy4RQpUq0WAuiMfSoqQ==
X-Received: by 2002:a05:6808:648e:b0:3ba:10b1:7a24 with SMTP id fh14-20020a056808648e00b003ba10b17a24mr2106907oib.105.1702351076741;
        Mon, 11 Dec 2023 19:17:56 -0800 (PST)
Received: from [10.84.154.56] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jc1-20020a17090325c100b001cc2dc61c99sm7433593plb.22.2023.12.11.19.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 19:17:56 -0800 (PST)
Message-ID: <7c4fe326-09a2-4e9c-a06b-553ffebf72ff@bytedance.com>
Date:   Tue, 12 Dec 2023 11:17:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] sched/eevdf: Avoid NULL in pick_eevdf
Content-Language: en-US
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
References: <20231120073821.1304-1-xuewen.yan@unisoc.com>
 <7c223b0c-d39a-4d53-8f00-7fbec6b49b6e@bytedance.com>
 <CAB8ipk9WBNE8Yk9T9SXovnpyUtGu=ps8_i=3hbb4PS9PXovR+w@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAB8ipk9WBNE8Yk9T9SXovnpyUtGu=ps8_i=3hbb4PS9PXovR+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 10:51 AM, Xuewen Yan Wrote:
> Hi Abel
> 
> On Mon, Nov 20, 2023 at 4:49 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Hi Xuewen, the pick part has been re-worked, would you please re-test
>> with the newest branch?
>>
>> Thanks,
>>          Abel
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=sched%2Fcore
> 
> These patches would be merged into 6.6? If not, the pr_err also has a deadlock.
> And should be changed to printk_deferred.

Yes, they will be merged in Linus's tree.

> 
> 
> 954 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>    955 {
>    956         struct sched_entity *se = __pick_eevdf(cfs_rq);
>    957
>    958         if (!se) {
>    959                 struct sched_entity *left = __pick_first_entity(cfs_rq);
>    960                 if (left) {
>    961                         pr_err("EEVDF scheduling fail, picking
> leftmost\n"); <<<<
>    962                         return left;
>    963                 }
>    964         }
>    965
>    966         return se;
>    967 }
> 
> 
>>
>> On 11/20/23 3:38 PM, Xuewen Yan Wrote:
>>> Now in pick_eevdf function, add the pick_first_entity to prevent
>>> picking null when using eevdf, however, the leftmost may be null.
>>> As a result, it would cause oops because the se is NULL.
>>>
>>> Fix this by compare the curr and left, if the left is null, set
>>> the se be curr.
>>>
>>> Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>>> ---
>>>    kernel/sched/fair.c | 18 +++++++++++++++++-
>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index d7a3c63a2171..10916f6778ac 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -951,12 +951,28 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
>>>        return NULL;
>>>    }
>>>
>>> +/* Just simply choose the se with the smallest vruntime */
>>> +static struct sched_entity *__pick_cfs(struct cfs_rq *cfs_rq)
>>> +{
>>> +     struct sched_entity *curr = cfs_rq->curr;
>>> +     struct sched_entity *left = __pick_first_entity(cfs_rq);
>>> +
>>> +     /*
>>> +      * If curr is set we have to see if its left of the leftmost entity
>>> +      * still in the tree, provided there was anything in the tree at all.
>>> +      */
>>> +     if (!left || (curr && entity_before(curr, left)))
>>> +             left = curr;
>>> +
>>> +     return left;
>>> +}
>>> +
>>>    static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>>>    {
>>>        struct sched_entity *se = __pick_eevdf(cfs_rq);
>>>
>>>        if (!se) {
>>> -             struct sched_entity *left = __pick_first_entity(cfs_rq);
>>> +             struct sched_entity *left = __pick_cfs(cfs_rq);
>>>                if (left) {
>>>                        pr_err("EEVDF scheduling fail, picking leftmost\n");
>>>                        return left;
