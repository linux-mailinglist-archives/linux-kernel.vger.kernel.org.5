Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438BB7FF2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346096AbjK3O4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjK3O4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:56:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC15D46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:56:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28613d87c4cso997530a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701356167; x=1701960967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5jnslBvWjxL849QqKtDKP6TkAe33VNDOFl/nnQyVf2o=;
        b=RHlONaNT93l6uuTFUj+hnOa466Y+v+6MdiiJ49JmfwpaHdFcJn7j1El4jnTOBzISzs
         rkBpYQh77RQz6rrSJWr6Sdq3iRDwiBA6NiLss9ENfo0iVcbtHpt9bEyyw9TnpRUrnk19
         YMHPQYKQ4P/zLcGcOfgGMIr2wKCMJPY/OCs2Xc5QGgkLZPcmHR0B0znUU5tfm/RCHwOf
         aiCMzpZuzHvAN4N7dOUCNbydr+S2PVrtMJkPJVreyfwVp6jv4l86pl24jOylnsMKtPZz
         W8FKigPSfUoWkFpQUC4W/L35J3PTkf6z+2qd3MaLEhohbRiaM3n8Zx0Nvg047UjISwfT
         10/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356167; x=1701960967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jnslBvWjxL849QqKtDKP6TkAe33VNDOFl/nnQyVf2o=;
        b=Wmb6qny9q7jkWHl9VX19T4zU28qFhZ5XSG+Wh6n/tXh9ydYGR0J1tnFLOqh4VhnvMt
         lxTd3YBMWpwsckfR6jWctXC85AGpp1L29XQE1BlT55wkp13REbEttKNaOU77c+oteSoz
         fBvJSKIVbUocJwNEoJNVVsMS+2D+jwxeKeOvNuXd8lP2EvxjP87d7ty6ODocBqvFYrq4
         Rpxi5LZPnMMGnmZfPKnsHtP1jsrux6mwfy2Z49h+rsp+Gv0RzqP9G4kakIXwMTJhC2RT
         W0qDjJa6Gjgyi7UV/YtBRlsi7trfqlz6qZN9Ks+478sBFAkZi4jB9O4BTQm72Cf0hlUx
         467w==
X-Gm-Message-State: AOJu0YxdVNM5dhr+6jyrd5NT3zDgSuen4/5KUsBw/a9Q1+8Iff9Ay1eN
        PUrCWwko4uSOYt2c/2Y6CeQs3tYT74OWL/IovdSQvg==
X-Google-Smtp-Source: AGHT+IETknovbQYtURTxySOTRgstT+/ks+IwT+pDmsfJ9l+GWBq2hd5ZLsBHJJvigzUFbVsU0Y6qwELfNdriGmuNRr8=
X-Received: by 2002:a17:90b:1c8b:b0:27c:f309:f381 with SMTP id
 oo11-20020a17090b1c8b00b0027cf309f381mr22425588pjb.6.1701356167145; Thu, 30
 Nov 2023 06:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20231127143238.1216582-1-vincent.guittot@linaro.org> <f20c8c30-1379-4706-b980-73d2f7e5912a@arm.com>
In-Reply-To: <f20c8c30-1379-4706-b980-73d2f7e5912a@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Nov 2023 15:55:55 +0100
Message-ID: <CAKfTPtAhnH8eREUEKo_5hJszxjNhug2HjJwKzqZ99SpvsmVRfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Simplify Util_est
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     hongyan.xia2@arm.com, mingo@redhat.com, alexs@kernel.org,
        linux-kernel@vger.kernel.org, vschneid@redhat.com,
        bristot@redhat.com, bsegall@google.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, peterz@infradead.org,
        juri.lelli@redhat.com, mgorman@suse.de, corbet@lwn.net,
        siyanteng@loongson.cn, qyousef@layalina.io,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 at 13:52, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> On 11/27/23 14:32, Vincent Guittot wrote:
> > Following comment in [1], I prepared a patch to remove UTIL_EST_FASTUP.
> > This enables us to simplify util_est behavior as proposed in patch 2.
> >
> > [1] https://lore.kernel.org/lkml/CAKfTPtCAZWp7tRgTpwJmyEAkyN65acmYrfu9naEUpBZVWNTcQA@mail.gmail.com/
> >
> > Vincent Guittot (2):
> >    sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
> >    sched/fair: Simplify util_est
> >
> >   Documentation/scheduler/schedutil.rst |  7 +--
> >   include/linux/sched.h                 | 35 ++----------
> >   kernel/sched/debug.c                  |  7 +--
> >   kernel/sched/fair.c                   | 81 ++++++++++-----------------
> >   kernel/sched/features.h               |  1 -
> >   kernel/sched/pelt.h                   |  4 +-
> >   6 files changed, 43 insertions(+), 92 deletions(-)
> >
>
> I recovered my pixel6 and applied these changes.
> No power regression in Jankbench. No performance regression in GB5.
> Better score in Chrome running Speedometer +3..5%.

Thanks for testing

>
> The code looks much more clean, without the 'struct util_est'
> (we will have to adjust our trace events to that change but it's worth).

Same for me

>
> Also, I was a bit surprised that the UTIL_EST_FASTUP wasn't helping
> that much comparing to that new 'runnable' signal for the
> underestimation corner case...
>
> Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks
