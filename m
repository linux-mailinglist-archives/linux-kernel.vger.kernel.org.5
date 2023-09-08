Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2097E7980F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 05:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjIHD2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 23:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjIHD2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 23:28:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABFB1BDA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 20:28:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1409957b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 20:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694143721; x=1694748521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyga/bR7KnO0AZcMSgesUn85OC4rXik7va8Pa71Uoy8=;
        b=RDb3prWCyEm3INnTubf050KKcChO0XR3oaywa1MTuAnZfLDqjz+CVHu72S+vX90mKt
         E2roMImkAokGSAKnjx0oukaDpWGXk2keiYlIZOqM03W0Cb0EBUZ7p+Ru4ieWKDTxxMOJ
         Q54oFWVTzEyFbr9z3yx6hgoGiyC4AMhqkNDmBIGtM89Y67StAfExDxwQcNQpIFqUqbD1
         YwUQ6gLQdxsApGfF88FwFNR+twkRZ5necGLlBioWSWUUF6FQsWfDtA4OMeoZLoO6wBv4
         z4wa9hFpNq+7Dflkp9elfUWKQwxTacx7eble03h9ezKtt2/F/noxkYDPx53I7GHRE1mk
         ECtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694143721; x=1694748521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xyga/bR7KnO0AZcMSgesUn85OC4rXik7va8Pa71Uoy8=;
        b=wVG+2ADCA+bTuisiZiDIWXOB6qCpgqXgZqAKfmNAbNtg5RwB7tT3ugGuFbqXHmSzfF
         OlFwxs81mJ5DT031yw4+Iv7oXCfhiOp0/W1sI1lG7iEbmknIv3djN7QELqi9NeGXbj+V
         gWesyYh1HHPDXg4Nsu1HM0Vo97MS4AuMKbte4GX9eB87WiJsJfxhak0IYY3So04yCm2x
         1p/xo9yZu51NQMCWJBdfqLumtCBNWmVYpqkQC/aIaz8zSzNEtR8gzY2DlECVNMzmM4kW
         wcyB86BCwDg1Cn79BHqopPMTWx/ECwXlpNPrVdrKzYObgfNY66y2wOfL09zeOK3UVqta
         UtWg==
X-Gm-Message-State: AOJu0Yw/2NBMWONUutuGP7vWM711tJEG5N3dya/ZZ7E6Zle3YuOJFFqs
        IA5rqI3c3SBsOQ20bhMe6yDThw==
X-Google-Smtp-Source: AGHT+IG3Fnhkv/ckb8v3efpkXk9m5bSeAiGH/2YqrB6IQjg0wzVL6kqNDRi12CQ/J7lIdOJcXpjfyA==
X-Received: by 2002:a05:6a20:158d:b0:14c:e8d4:fb3e with SMTP id h13-20020a056a20158d00b0014ce8d4fb3emr1828439pzj.43.1694143720902;
        Thu, 07 Sep 2023 20:28:40 -0700 (PDT)
Received: from [10.84.158.67] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001bf095dfb79sm453948plb.235.2023.09.07.20.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 20:28:40 -0700 (PDT)
Message-ID: <dd8e6bfb-9d84-6a5d-94cb-4833f5d1943b@bytedance.com>
Date:   Fri, 8 Sep 2023 11:28:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [External] Re: Fwd: WARNING: CPU: 13 PID: 3837105 at
 kernel/sched/sched.h:1561 __cfsb_csd_unthrottle+0x149/0x160
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Igor Raits <igor.raits@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
References: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
 <xm26cyz4ibnb.fsf@google.com>
 <55e2861e-9722-08f8-2c49-966035ff4218@bytedance.com>
 <20230904222351.GC2568@noisy.programming.kicks-ass.net>
 <3544d5e3-3070-9ddc-fa6c-a05ed35dfd14@bytedance.com>
 <171e6a9435a33885a73b48762f86954e447c26c2.camel@linux.intel.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <171e6a9435a33885a73b48762f86954e447c26c2.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/8 Tim Chen wrote:
> On Thu, 2023-09-07 at 16:59 +0800, Hao Jia wrote:
>>
>> On 2023/9/5 Peter Zijlstra wrote:
>>> On Thu, Aug 31, 2023 at 04:48:29PM +0800, Hao Jia wrote:
>>>
>>>> If I understand correctly, rq->clock_update_flags may be set to
>>>> RQCF_ACT_SKIP after __schedule() holds the rq lock, and sometimes the rq
>>>> lock may be released briefly in __schedule(), such as newidle_balance(). At
>>>> this time Other CPUs hold this rq lock, and then calling
>>>> rq_clock_start_loop_update() may trigger this warning.
>>>>
>>>> This warning check might be wrong. We need to add assert_clock_updated() to
>>>> check that the rq clock has been updated before calling
>>>> rq_clock_start_loop_update().
>>>>
>>>> Maybe some things can be like this?
>>>
>>> Urgh, aside from it being white space mangled, I think this is entirely
>>> going in the wrong direction.
>>>
>>> Leaking ACT_SKIP is dodgy as heck.. it's entirely too late to think
>>> clearly though, I'll have to try again tomorrow.
> 
> I am trying to understand why this is an ACT_SKIP leak.
> Before call to __cfsb_csd_unthrottle(), is it possible someone
> else lock the runqueue, set ACT_SKIP and release rq_lock?
> And then that someone never update the rq_clock?
> 

Yes, we want to set rq->clock_update_flags to RQCF_ACT_SKIP to avoid 
updating the rq clock multiple times in __cfsb_csd_unthrottle().

But now we find ACT_SKIP leak, so we cannot unconditionally set 
rq->clock_update_flags to RQCF_ACT_SKIP in rq_clock_start_loop_update().


>>
>> Hi Peter,
>>
>> Do you think this fix method is correct? Or should we go back to the
>> beginning and move update_rq_clock() from unthrottle_cfs_rq()?
>>
> If anyone who locked the runqueue set ACT_SKIP also will update rq_clock,
> I think your change is okay.  Otherwise rq_clock could be missing update.
> 
> Thanks.
> 
> Tim
