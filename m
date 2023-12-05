Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AC805B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjLEQ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLEQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:26:51 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3B129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:26:57 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c6734e0c22so1408075a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701793617; x=1702398417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34kFxB5ltdfNOxlfUUv3hWcvgk2fNs0S+1+PnEKCpqE=;
        b=WPOJMDnvdHgZZNVPSgFVQJ+bouag6NeLXUjAu9zTAf0xd6RJmVNdLW3Ro5xydKiwIH
         aDznR2HgjIUIPGsZ9h7r/oXb6B9O1OJX/ARLAcWkkzqY2wgPC7pzBo5oNo9SzuyBEK3H
         Lx7KhpVBVM/Jbdsj2jmgKIDrMPSdJkWrvO15rpp0+JIucRnxi9u3kG/o1QrA+zf5p+nM
         n92U2TKKbT07VBNkkGNxJRsCAK+/2De8yQIgyPfurNalVDz9XIOj/zEW3Jq+DZl3chOc
         ZtNYSoeC8BJSkiFKS6DTo8JlglEaZK+fO/2nIT/fDAbvr5S+e2QWk6yn+klx60QN0bkY
         WIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793617; x=1702398417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34kFxB5ltdfNOxlfUUv3hWcvgk2fNs0S+1+PnEKCpqE=;
        b=KDeBSWsdfH59ahHNpuwXykqQb+JIX33+WvkNfuTGSB2as9DOMsbBZpN3LRnLVHwXnz
         ICFSl8PhQpW07JijowqepSsPiy12Gov+dkCG4ra4pL/Z7s7hEGLJPAzVgUaeoJxu0U7q
         JlIwTzBc5Gix2lIxXXqvOe1nUbavFZf1OcmI30zPHbKg+Q+Rs/h162DzC8D7GvyYN1kW
         XjDqBp0F5Gvfb3uJb4nZnZbGIIcz63xECxQlLHZf1UpOZH3pa9RDWYz10t8wxP4f4jya
         K6DDo+2WqwRzNLmx5r3VhdbC4NUqvJtAJhPdYA1VY8Qta+sJu3Jw9g+WewhxqlfccMEJ
         BGaA==
X-Gm-Message-State: AOJu0Yx3pcW+uenFRWtkE+IMFkQaf3AswWylkEd4/3ygQMBzQSKrrWzx
        kFSd9oFD2thKcQJCkcoA3YNQTlJaYwIR31sx9NOFWg==
X-Google-Smtp-Source: AGHT+IHTAmZE4HP/HRuQHQS9mKi6QAMT9xkmtqORLFm7+av5SsfsdxTdhRIZsgOPgnrqiwE2BXR2LqA1dVgiTK9Z/dU=
X-Received: by 2002:a17:90a:d817:b0:286:58c4:6e49 with SMTP id
 a23-20020a17090ad81700b0028658c46e49mr1218497pjv.42.1701793617136; Tue, 05
 Dec 2023 08:26:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1696345700.git.Hongyan.Xia2@arm.com> <20231203002544.d4zx3oyvjugohh22@airbuntu>
 <7f1f7dd0-e3b5-4e16-a44e-c08fca567f97@arm.com> <CAKfTPtBZ+7STLsRH7h+WeitcH1i4623J4xb0XQKTzsp=XNV_-w@mail.gmail.com>
 <cf221099-31f4-4de1-9418-a354f002e26e@arm.com>
In-Reply-To: <cf221099-31f4-4de1-9418-a354f002e26e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 5 Dec 2023 17:26:46 +0100
Message-ID: <CAKfTPtD10c4Uif6EATJ2SiAPdnEzXkC78nZE=q23dLM7fszvEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] sched: uclamp sum aggregation
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 at 16:19, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> On 04/12/2023 16:12, Vincent Guittot wrote:
> > On Mon, 4 Dec 2023 at 02:48, Hongyan Xia <hongyan.xia2@arm.com> wrote:
> >>
> >> [...]
> >>
> >> Other shortcomings are not that critical, but the fact that uclamp_min's
> >> effectiveness is divided by N under max aggregation I think is not
> >> acceptable.
> >
> > Change EAS task placement policy in this case to take into account
> > actual utilization and uclamp_min/max
>
> Thank you. I agree. I want to emphasize this specifically because this
> is exactly what I'm trying to do. The whole series can be rephrased in a
> different way:
>
> - The PELT signal is distorted when uclamp is active.

Sorry but no it's not

> - Let's consider the [PELT, uclamp_min, uclamp_max] tuple.

That's what we are already doing with effective_cpu_util. We might
want to improve how we use them in EAS but that's another story than
your proposal

> - Always carrying all three variables is too much, but [PELT,
> clamped(PELT)] is an approximation that works really well.

As said before. It's a no go for this mix

>
> Of course, I'll explore if there's a way to make things less messy. I
> just realized why I didn't do things util_est way but instead directly
> clamping on PELT, it's because util_est boosts util_avg and can't work
> for uclamp_max. I'll keep exploring options.
>
> >> [...]
