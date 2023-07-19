Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31E2758B10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGSB4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:56:44 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C3F9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:56:40 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76595a7b111so507594185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689731800; x=1692323800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7jJDX3yxvDMQd6iEE6RHLp8fmG3wEfDy9I1U6CxUio=;
        b=vU0Y3UXNsdXh9331z6PJ5FubCCIxosM4AbsDKt83Jrx0hukxLxRqRlg3adbvZOe8MQ
         hg9CLm12fD2AewENYTdr5R9SF928i5vAT4hDdukprSqpRg1FZctFfjN+GoSkGbz85ny7
         JjqjIFEFb8SCdBRT/4F/+PqkpalMcafFL4VwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689731800; x=1692323800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7jJDX3yxvDMQd6iEE6RHLp8fmG3wEfDy9I1U6CxUio=;
        b=ajBqCUpfDQOww64XFu360bkj8TO4qpvz4XShFGzmN1SFaDXj2K1CA0advb6jLs50tk
         bRTApf4eHtATal3xxUmdgzddGDXG56uFxpuDMhD0WL/8u30BItQ8X++G/Kt7Kw4BdgJ7
         7jvtCh/hxuRGtpr1haSPlK2DM3++QogkY8wXy6w8HJpJm5pr/Q8hMxXGFt2vp1sEwsiz
         uog7y+xv9prFKet+f6cz+p3eP+7ATCVZX/E4d4VDwDtrbyFE6Nj8Tv/vRsIdxWA2eLld
         RvEAaNFHXUYhV1pATxkj6q1UgcwNwkdJuCTRGyZneu2vsHzLgTlbSsggQRs50jQd2mPt
         57dg==
X-Gm-Message-State: ABy/qLYqbQRFN0YXtF8uspxujLWmEz1akCwDK9V8XyP1owBZByKKx+Sf
        DsNQmpgc+7bv9MbJafgYB2lUBPhr4tz5HdIVswI=
X-Google-Smtp-Source: APBJJlHoFi7mAYLuHSzLtQQSIc/av6vC8gV658kDKvuZmgAYr01UC6fhdNHQomOyEyNNl/cC3mjs/g==
X-Received: by 2002:a0c:f885:0:b0:635:e2c1:99f3 with SMTP id u5-20020a0cf885000000b00635e2c199f3mr3431099qvn.32.1689731799880;
        Tue, 18 Jul 2023 18:56:39 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id p3-20020a0c9a03000000b006263a9e7c63sm1118690qvd.104.2023.07.18.18.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 18:56:39 -0700 (PDT)
Message-ID: <998db46d-9c76-a3c5-e7c5-b7adf1770352@joelfernandes.org>
Date:   Tue, 18 Jul 2023 21:56:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH rcu 2/6] rcu: Clarify rcu_is_watching() kernel-doc comment
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-2-paulmck@kernel.org>
 <a11d5ce7-5ee3-fbf7-9adb-4cfc805c6bb7@joelfernandes.org>
 <2e404769-67af-4240-b572-bd0808503486@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <2e404769-67af-4240-b572-bd0808503486@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 7/18/23 14:12, Paul E. McKenney wrote:
> On Tue, Jul 18, 2023 at 08:52:30AM -0400, Joel Fernandes wrote:
>> Hi Paul,
>>
>> On 7/17/23 14:03, Paul E. McKenney wrote:
>>> Make it clear that this function always returns either true or false
>>> without other planned failure modes.
>>>
>>> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>    kernel/rcu/tree.c | 12 ++++++++----
>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 1449cb69a0e0..fae9b4e29c93 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -679,10 +679,14 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
>>>    /**
>>>     * rcu_is_watching - see if RCU thinks that the current CPU is not idle
>>
>> Would it be better to modify the 'not idle' to 'not idle from an RCU
>> viewpoint'? This matches the comments in ct_nmi_enter() as well.
> 
> We have the "if RCU thinks that" earlier.
> 
> But maybe something like this?
> 
>   * rcu_is_watching - RCU read-side critical sections permitted on current CPU?
> 

Yes, that's better.

>>>     *
>>> - * Return true if RCU is watching the running CPU, which means that this
>>> - * CPU can safely enter RCU read-side critical sections.  In other words,
>>> - * if the current CPU is not in its idle loop or is in an interrupt or
>>> - * NMI handler, return true.
>>> + * Return @true if RCU is watching the running CPU and @false otherwise.
>>> + * An @true return means that this CPU can safely enter RCU read-side
>>> + * critical sections.
>>> + *
>>> + * More specifically, if the current CPU is not deep within its idle
>>> + * loop, return @true.  Note that rcu_is_watching() will return @true if
>>> + * invoked from an interrupt or NMI handler, even if that interrupt or
>>> + * NMI interrupted the CPU while it was deep within its idle loop.
>>
>> But it is more than the idle loop, for ex. NOHZ_FULL CPUs with single task
>> running could be idle from RCU's viewpoint? Could that be clarified more?
> 
> Perhaps something like this?
> 
>   * Although calls to rcu_is_watching() from most parts of the kernel
>   * will return @true, there are important exceptions.  For example, if the
>   * current CPU is deep within its idle loop, in kernel entry/exit code,
>   * or offline, rcu_is_watching() will return @false.
> 
> (Where nohz_full CPUs are covered by kernel entry/exit code.)

To me, "kernel exit" does not immediately make the nohz_full CPU case 
obvious. But yes, your suggestion is an improvement so we can go with 
that. :)

Also because we agree on the changes, for next revision:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

  - Joel

