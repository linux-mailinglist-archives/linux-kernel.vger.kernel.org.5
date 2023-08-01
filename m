Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75DF76BB4C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjHARcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjHARcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:32:50 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10934E71;
        Tue,  1 Aug 2023 10:32:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3493862cfb1so1917555ab.1;
        Tue, 01 Aug 2023 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690911169; x=1691515969;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxfffmnKLjMpRaF+oj2k9XWjuJzG7Mpl/8fOeP1Tlj8=;
        b=VcIp2nJOsFoMuplIw3t8qwptOiLdWXL8dwUmccUOs6t93Cc9xR9xVrWBEDBf7tzu0H
         uMXkDf38gFnQafLeR6fnO1wPdRHl5iaFTwuMX+LzJ646zOl1X7m4UuG+2amE2UqSqH7l
         Pz3zqm2tMdLhixWFTWqYqJBYiM0Rp5twyLOQGZfL1yEB7ZQ56l+PLOEzKsZeqrjbZ9uI
         yYkhyzfjZKUVKFRcfoMiQjHuWcnWn9JQi07F7ywdV02+cBq/mCzX6jAU/EEd11gV/o9h
         6RVkuiWqTuQJdrCYyAkC9qb8HWR3oXCEiGAuvcdT/gilw3zvbh1e+rZOiXiDzM0Pn0Ts
         jhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911169; x=1691515969;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxfffmnKLjMpRaF+oj2k9XWjuJzG7Mpl/8fOeP1Tlj8=;
        b=JpitpFvg5TyZOCkQlExTr5uRRij3XYhxKgAQCV/IW5M3GEZtMRJ1uVd5JDmVe7X95/
         Q6Yl5t/DfPaKJFrXSFel78cQ4H/vfY8QuKs+PXPwoV+MFu7PLr19EcJFHSY6Gd/p1vhP
         zUlORiGC9bqL4pVQbk7On9lng3rVyKm23O/rY2bDK7G8pCGeum4qWURh9ITZYmVXwzxu
         kgGhJfpT5j20szTaMfgYseOgyH0/yAhMPpFFuYMteW/2WRmsXDUU8QqTggRiHmxjkVNO
         yGm55mHc0HA+fuDiteK1HRkI08FVV5ugjMzGDXXdV9NGTkDIflW5kJXos6NrKH4VmGb8
         vkJw==
X-Gm-Message-State: ABy/qLYxIB/+r7bCZ8ca+lIeFimMnv0qGA8Ou8Ufo8j63HN8t+WAOeMf
        rby1aivuYof899iGWRhSJ+Q=
X-Google-Smtp-Source: APBJJlEfYNHAmcDXBD2bJbxgOiEovrQqUA0zD0/q6PfUdnUPPnfhj2y4B95WeuHZ1i438RcxyPsVUQ==
X-Received: by 2002:a05:6e02:1a0d:b0:342:512a:ccec with SMTP id s13-20020a056e021a0d00b00342512accecmr13376561ild.31.1690911169208;
        Tue, 01 Aug 2023 10:32:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n11-20020a92d9cb000000b00345d2845c42sm3991233ilq.57.2023.08.01.10.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 10:32:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
Date:   Tue, 1 Aug 2023 10:32:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Roy Hopkins <rhopkins@suse.de>,
        Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
 <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
 <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net>
 <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
In-Reply-To: <20230731211517.GA51835@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 14:15, Peter Zijlstra wrote:
> On Mon, Jul 31, 2023 at 09:34:29AM -0700, Guenter Roeck wrote:
>>> Ha!, I was poking around the same thing. My hack below seems to (so far,
>>> <20 boots) help things.
>>>
>>
>> So, dumb question:
>> How comes this bisects to "sched/fair: Remove sched_feat(START_DEBIT)" ?
> 
> That commit changes the timings of things; dumb luck otherwise.

Kind of scary. So I only experienced the problem because the START_DEBIT patch
happened to be queued roughly at the same time, and it might otherwise have
found its way unnoticed into the upstream kernel. That makes me wonder if this
or other similar patches may uncover similar problems elsewhere in the kernel
(i.e., either hide new or existing race conditions or expose existing ones).

This in turn makes me wonder if it would be possible to define a test which
would uncover such problems without the START_DEBIT patch. Any idea ?

Guenter

