Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C887F7D7169
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjJYQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjJYQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:04:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C4B8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:04:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so2261672a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698249848; x=1698854648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1eGIrnB5NNbCt49cwRqEjgvuTl26I/bfmY2QtsbEYAI=;
        b=tc0oxg99caaUiNevut1cUPLgZRzqifCuqP1kOZW+7LvejD98z9fIdWj2l/AEu+y2U5
         GDF42qc7tOX15y6iXqeoM5u6N36Rf3uCCp5FCr4CRN/rdGL/ON97511e6tyJThx6TCrS
         JUFScF0wiMJpyddq+bzE7wwtXvf+HuLZnCl8Yq9CCXX6eKJ8Vz0J/SjxHlP7MwR5/jMT
         P+nzEaR823vyHuvAYCdKVmpoHK7ADf/85tZDXFPz2EBsdZlVIMyDdH/LeNkatLqlQpxd
         Xp7SGfEX0eOUxHfV4MhHfF+faYgl1xDtXc4r1H8wnCyQiv3NNGeirYoq6woBmOIfw+Mu
         8I3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698249848; x=1698854648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eGIrnB5NNbCt49cwRqEjgvuTl26I/bfmY2QtsbEYAI=;
        b=gTjyhYGJue/BHcpzvf80V+QDC7OJDkMbhU3+iPlRM389dZR3XY8QuPyqiaTjTG989Q
         CA9MjBRpHedsyquWbCQS1XY8Ma43S5jrwVgtSl6wH6auSq2WB/y7d6xah2BfOxMl8uR1
         x6Xiro1EBmnL/tGbfMFyTToe0j5cDxBh3KEwHB4e7AB8WUm53ejOrNzNzj1KaLlD/lC/
         M2CL/qLxZOKJXVdv/rl0ES0XUXKLg6g33yPerTxrdFpRmD6SKM5Rwn1PnUG5sbQmrNY/
         /c71B3u5igh14nH9kLi89rVREaHEJMkBXqKJUOnsZ0/tXjQq6DsQEouMSbgyy6BZ3TzG
         rbJg==
X-Gm-Message-State: AOJu0YzUGQQ1PWwniB1Ekt2UeMsPEyVmuQUlM5rmMZM07QjVtsueVK34
        807a9+STsRyslV0zmBriJ7fIitRSOyM6KjPIMLd8HQ==
X-Google-Smtp-Source: AGHT+IEo47P/R0SNVzTvRsn6LG52nueI2fINaZrLmO2HPTbJ3Q+dL4uUqhIPhI8smT5SyIsUzL3Lp5eBJJKFfLgVL5E=
X-Received: by 2002:a17:907:7f2a:b0:9ad:e62c:4517 with SMTP id
 qf42-20020a1709077f2a00b009ade62c4517mr80194ejc.34.1698249847977; Wed, 25 Oct
 2023 09:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
 <ZTeoGiMQZ-OoYJBG@kernkonzept.com> <20231025073634.4et5epfog25o2pxf@vireshk-i7>
 <ZTkHVVq61lrpRUOv@gerhold.net> <20231025152000.vt42gvti2e4rewwc@vireshk-i7>
In-Reply-To: <20231025152000.vt42gvti2e4rewwc@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Oct 2023 18:03:30 +0200
Message-ID: <CAPDyKFrEdHGVeKo0oh0f2uJjtASbg4eye2UbEaE8s3sy+2tWDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] OPP: Call dev_pm_opp_set_opp() for required OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 17:20, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-10-23, 14:17, Stephan Gerhold wrote:
> > Thanks, this seems to work fine.
>
> Thanks a lot.
>
> > I found another small problem: In my OPP setup for MSM8916, some of the
> > required-opps point to an OPP with "opp-level = <0>" (see [1], the
> > <&rpmpd_opp_none> in the cpu-opp-table). This is because the vote for
> > the "CX" domain is for the CPU PLL clock source, which is only used for
> > the higher CPU frequencies (>= 998.4 MHz). With the previous code you
> > made it possible for me to vote for opp-level = <0> in commit
> > a5663c9b1e31 ("opp: Allow opp-level to be set to 0", discussion in [2]).
> > I think now it's broken because the _set_opp_level() added by Uffe
> > checks for if (!opp->level) as a sign that there is no opp-level defined
> > at all.

I don't think my patch broke it, I just followed the similar semantics
of how we treated the OPPs for the required opps.

As far as I understood it, the only way we could request the
performance-level to be zero, was if the consumer driver would call
dev_pm_opp_set_opp(dev, NULL);

So, unless I am overlooking something, things can have been screwed up
earlier too?

>
> Yes, we broke that. I think a simple fix is to initialize the level
> with an impossible value, like -1 and then 0 becomes valid.

Yep, make sense, let's fix it!

Are you sending a patch?

[...]

Kind regards
Uffe
