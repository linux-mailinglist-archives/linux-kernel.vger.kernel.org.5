Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED476D2B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjHBPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjHBPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:45:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563399B;
        Wed,  2 Aug 2023 08:45:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-56433b1b12dso2497314a12.1;
        Wed, 02 Aug 2023 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690991109; x=1691595909;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiYaQWCPiFv33eUKHe5JFxulExXwgyEegp8iSsFgI3U=;
        b=O7o8JQ35k2U6XbsP2NIAfgQvoQAOP73QN4mQ/OxXKxIgm7+PejmNKmNIOKCsxTp1ZG
         +VsJUNf9yBpJtConwMf5bmAF1dzWuoZGFlKrfLjRM5T/W+H0bZ0UU2l9V0vNl/13nJJY
         OyPltdHr46cQNLF6RX5HHyS2LXAJqs9hzzHc7HTomovfu0kTD874LUW5SDseJUvyH2a6
         ZNObt6c00bk7gDYIjX94Lvk9XFX9jjTdX9lli6n+Mr5/8FcB5GWA9YzQmpdKD9b+Nz4V
         yCDzbrQxP2Mog4o0MYakBc8th3g8X2m2yt4UCzl753xVqB3FJcaMlbgVn1bJJWEc7K/z
         TOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690991109; x=1691595909;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiYaQWCPiFv33eUKHe5JFxulExXwgyEegp8iSsFgI3U=;
        b=gHVEzgiaUb30Y2QqUEN6v/PY7rerc0v8DhwF5/1MBFhJgAInQFf6u/GVv579sO6Lqa
         wtq5rqKGfqC+W9f+hLVAufFn9FpOUXV6fHhxVsF6d23cbkM0Gd3Qng2049Qn6znyrdg3
         RRHaVnTowET5OSR4vzsG6kwD3Z3b6dktNkx4GrPG/Ft8r/0z3nMcLtHKF4pedD6z7qwy
         Ox7/BdK4r2PrsgymUB7hoof76IMwWPAPWt68QQ66dA9L13tlPHeR158P/ilHUrUafb1E
         cQgxTG94/FXOSC3lbB1m8IqP9kWR1zjCJhsHx3j3wMV9+iJLlZjazWm7sULgkeJ5Svf+
         Xi+Q==
X-Gm-Message-State: ABy/qLZY9S287dD3EDKOgCwxpB4RzafA66KEt2AcL1ouZFxRc3JhbJvn
        c7YjkwFORY9jDmaYMzOc5iI=
X-Google-Smtp-Source: APBJJlGU5Zlj1Fd6LQFGB8eDSOq6XWpB1qOhzSqiCFBj97NEmLc2w23uzqbr/BOwLRBpt5RBZ5HRcA==
X-Received: by 2002:a17:90a:66c8:b0:268:f38:b2a1 with SMTP id z8-20020a17090a66c800b002680f38b2a1mr13300934pjl.41.1690991108748;
        Wed, 02 Aug 2023 08:45:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a199d00b0025dc5749b4csm1369555pji.21.2023.08.02.08.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:45:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2568f0ca-af88-4001-79c4-571a9b6a8fb3@roeck-us.net>
Date:   Wed, 2 Aug 2023 08:45:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     paulmck@kernel.org, Roy Hopkins <rhopkins@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
 <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
 <4f18d78411a5477690640a168e0e5d9f28d1c015.camel@suse.de>
 <063a2eba-6b5e-40bc-afd4-7d26f12762e4@paulmck-laptop>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
In-Reply-To: <063a2eba-6b5e-40bc-afd4-7d26f12762e4@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 08:05, Paul E. McKenney wrote:
> On Wed, Aug 02, 2023 at 02:57:56PM +0100, Roy Hopkins wrote:
>> On Tue, 2023-08-01 at 12:11 -0700, Paul E. McKenney wrote:
>>> On Tue, Aug 01, 2023 at 10:32:45AM -0700, Guenter Roeck wrote:
>>>
>>>
>>> Please see below for my preferred fix.  Does this work for you guys?
>>>
>>> Back to figuring out why recent kernels occasionally to blow up all
>>> rcutorture guest OSes...
>>>
>>>                                                          Thanx, Paul
>>>
>>> ------------------------------------------------------------------------
>>>
>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>> index 7294be62727b..2d5b8385c357 100644
>>> --- a/kernel/rcu/tasks.h
>>> +++ b/kernel/rcu/tasks.h
>>> @@ -570,10 +570,12 @@ static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
>>>          if (unlikely(midboot)) {
>>>                  needgpcb = 0x2;
>>>          } else {
>>> +               mutex_unlock(&rtp->tasks_gp_mutex);
>>>                  set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
>>>                  rcuwait_wait_event(&rtp->cbs_wait,
>>>                                     (needgpcb = rcu_tasks_need_gpcb(rtp)),
>>>                                     TASK_IDLE);
>>> +               mutex_lock(&rtp->tasks_gp_mutex);
>>>          }
>>>   
>>>          if (needgpcb & 0x2) {
>>
>> Your preferred fix looks good to me.
>>
>> With the original code I can quite easily reproduce the problem on my
>> system every 10 reboots or so. With your fix in place the problem no
>> longer occurs.
> 
> Very good, thank you!  May I add your Tested-by?
> 

FWIW, I am still working on it. So far I get

[    8.191589]     KTAP version 1
[    8.191769]     # Subtest: kunit_executor_test
[    8.191972]     # module: kunit
[    8.192012]     1..8
[    8.197643]     ok 1 parse_filter_test
[    8.201851]     ok 2 filter_suites_test
[    8.206713]     ok 3 filter_suites_test_glob_test
[    8.211806]     ok 4 filter_suites_to_empty_test
[    8.214077] kunit executor: filter operation not found: speed>slow, module!=example
[    8.217933]     # parse_filter_attr_test: ASSERTION FAILED at lib/kunit/executor_test.c:126
[    8.217933]     Expected err == 0, but
[    8.217933]         err == -22 (0xffffffffffffffea)
[    8.217933]
[    8.217933] failed to parse filter '(efault)'
[    8.221266]     not ok 5 parse_filter_attr_test
[    8.224224] kunit executor: filter operation not found: speed>slow
[    8.225837]     # filter_attr_test: ASSERTION FAILED at lib/kunit/executor_test.c:165
[    8.225837]     Expected err == 0, but
[    8.225837]         err == -22 (0xffffffffffffffea)
[    8.228850]     not ok 6 filter_attr_test
[    8.230942] kunit executor: filter operation not found: module!=dummy
[    8.232167]     # filter_attr_empty_test: ASSERTION FAILED at lib/kunit/executor_test.c:190
[    8.232167]     Expected err == 0, but
[    8.232167]         err == -22 (0xffffffffffffffea)
[    8.235317]     not ok 7 filter_attr_empty_test
[    8.237065] kunit executor: filter operation not found: speed>slow
[    8.238796]     # filter_attr_skip_test: ASSERTION FAILED at lib/kunit/executor_test.c:209
[    8.238796]     Expected err == 0, but
[    8.238796]         err == -22 (0xffffffffffffffea)
[    8.241897]     not ok 8 filter_attr_skip_test
[    8.241947] # kunit_executor_test: pass:4 fail:4 skip:0 total:8
[    8.242144] # Totals: pass:4 fail:4 skip:0 total:8

and it looks like the console no longer works. Most likely this is some other problem
that was introduced while tests were broken. It will take me some time to track that down.

Guenter

