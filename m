Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C07B2819
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjI1WFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjI1WFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:05:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAD219D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:05:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405524e6768so114334285e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1695938706; x=1696543506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ArDC+M/Fj9/rymDfPmXsJ4SDmxJk6crmGXVQHrpZfh4=;
        b=KxgUIrtyjEy7/g8YMcZVf/n0F/JCfovtnretUayc4SYLldBYJCbnnCceGqxPW/Miqd
         3RNI63iJQc5VimmYYqwCDEsdKQxKVnN/6QANip7pWG00xbep1l+a5N2e9qFIjxFyyYSc
         5jsZeISsVmiRHZb7j0a1IHi+GgdGoo3eBeBhxOdiXXu9zRINyzx/RRHKanuIr+wLg/+8
         yB/SEiIKcU3AiDB4vnhkSYPcVm+ioXrXqAry3IYMrEv+SiZeZUi4q3YdXco6N5AUaWZu
         us0LIvUOAmRQTF7EqKvTCF917s0s1fFO7x6+tppraeDlko7B2F1vHskMxYOLsukkOY1J
         jUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695938706; x=1696543506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArDC+M/Fj9/rymDfPmXsJ4SDmxJk6crmGXVQHrpZfh4=;
        b=IdK2k/t53IhE8l1eol12XyIlKeiIcgd7pqIIBJYdCcIoeeUDQtEw7W9Z4z02nrReYW
         KDQKJBYNvuCGk8BRaQco+QxblEFpdStmFJgu+Ob7pSjxO6fEPmEOB7fLrr9uM1Qrvr6T
         zOrwIT6NfjjTFbppGu441sRPKXM1Garh92RQ5Du4lFUqXgqjqsWjhFsGx5qX4UBz6gG3
         LdVL6sfCkFKbrk+htxdy3XBk+GeQbfRPYjA6Kl80U9iDT4VicqJ6qEMLOPLlcodjoVMZ
         TruHV6iQqfpusKzAsJYIQi1BouMUnCIU8J0tNYTr13f3vhe91+jyfw9tu8HmGdL0CZjR
         vXwA==
X-Gm-Message-State: AOJu0YwUbocPuD00mSH5vzXA+RsUxcbll5JPUwK3Eg61IFt9k1Z9LmSB
        pKBj/9uQLKjiFMsmHOW5rudTHA==
X-Google-Smtp-Source: AGHT+IHU/EtVhwXCw30fq3cDxe4k2xBSQJzSV11vdm9krtEtk8XG/afGLewXVtCXSrWuuq7tQZnVaw==
X-Received: by 2002:a05:600c:ad3:b0:402:e68f:888c with SMTP id c19-20020a05600c0ad300b00402e68f888cmr2387507wmr.7.1695938705848;
        Thu, 28 Sep 2023 15:05:05 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c280500b0040535648639sm74825wmb.36.2023.09.28.15.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 15:05:05 -0700 (PDT)
Date:   Thu, 28 Sep 2023 23:05:04 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <20230928220504.gcft523kvt5jlfoi@airbuntu>
References: <20230829163740.uadhv2jfjuumqk3w@airbuntu>
 <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu>
 <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu>
 <CAKfTPtBFAXO=CgqSJ1+y=2ppb5t4oErCtvV336fS6J2nSjBCkQ@mail.gmail.com>
 <20230916192509.bportepj7dbgp6ro@airbuntu>
 <CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com>
 <20230924172301.7lqdcsnpqk7trtno@airbuntu>
 <ZRW86K0Y1ECd4NRG@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRW86K0Y1ECd4NRG@vingu-book>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/23 19:50, Vincent Guittot wrote:

> > 
> > Yep, absolutely. It seems we agree that CFS shouldn't go above 800 if it is
> > capped even if there's headroom, but the question you have on the way it is
> 
> At least I want to ensure that cpufreq has the right information to make a
> smart decision. In the example above, it's not needed to go above 800 for
> neither cfs nor irq.

Okay you want to do even bigger rework :-) I thought I might have pushed some
boundary with the rework I had in mind hehe.

> I'm not in favor of showing all details to cpufreq because it will have to
> follow the internal changes. In instead, I was thinking of something like:
> 
> /* Function name to be changed */
> unsigned_long effective_cpu_util(int cpu, unsigned int *min, unsigned int *max)
> 
> The function returns the actual utilization of the CPU and some minimum and
> maximum limits with the possibility to have the min and/or Actual values > Max
> because the min would be a hard minimum value whereas max only a soft maximum
> value.
> 
> Min would be the minimum perf to provide to the cpu : typically DL_bw + irq
> Actual would be the actual utilization of the cpu: cfs+rt+dl+irq (after scaling
>   everything in the normal range)
> Max would be the maximum needed performance for normal work: typically the
> minimum between uclamp and capacity
> 
> Then cpufreq can use these 3 values to compute a performance level and it 
> will know up to which perf level it should go and if it is worth it.
> Something likr:

Okay thanks! I think I have better clarity now. Let me try to rework the
patches.


Cheers

--
Qais Yousef
