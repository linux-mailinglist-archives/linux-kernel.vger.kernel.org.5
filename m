Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672227B84BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbjJDQRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjJDQRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:17:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B389B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:17:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-278f0f565e2so1666898a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696436221; x=1697041021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l56tjqksVWp6wv2PmyLDMNPHdSGvwNmWmknUMmlQiXs=;
        b=4UqYEP3+iaNiHYrnkWxFJlEmp3/7YgEJMVi+uex6DVd5tD6tpgeb7T80jqogjDcFTh
         9BPDQ63pIQ2v/6x7U7ANIWy+xMb7pzc8GSIMNxB/cXJz6FvwmAhy3F5/n4JzoSl7jDnK
         Fou3YBTh0Wy5mr7zeLgn8gwYSdc3D/ZjeeYTJXoct3xB6XwLQbJxRWiNlcoOpw+jpJfH
         6hx03wJ+xo6UpNnkyD5g6YCHD3DPR4BE7E4l2p4nwmYcxsikbHdDrTJS5e4QjNGtrtzF
         gPTlURkSwodBrKfhMCMX7c9XVq4ajYR8ro5VS/PU+P9SSGSR59DQw8+4pPv0oy0ME1SX
         9g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436221; x=1697041021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l56tjqksVWp6wv2PmyLDMNPHdSGvwNmWmknUMmlQiXs=;
        b=s6X+Nor0/p3522EZvZSOwgliDaePXE91fbr//IZsQwXxPorECGm5h2+l/L5wylnKKS
         CdzxBT/ZOlUg9pkyxhJhto4MNa6x//QTHylhVYkjBvDdiHo221bWl0WSjZmC2dYzTKzp
         dDu3h2YCqcHyOSAXwrMcUlJEJC6Y3a8spC7ZAgJ59A2I4bJJgIL72vU2wDTF5OWjj2EY
         DjxJ4RNLTEsrNOsI8FLn0eNr0L3d2QNJlo+Vs53YwYw7r7W+aifFP26OyuyhidXoOKOm
         33mVNXRKZJOB0FhMtXxnTrNqXwPFdKAfza4/Oog1TGmkAvD8Kyf1KlXu+hBw25GWoheR
         2NBQ==
X-Gm-Message-State: AOJu0Yz0bmZWUfu1B0IWHZAZ1U16acNDBA2KiFKofVm48JDxjtri1VdH
        ZrFYFf4DSvfxKNrpHqVUPM6fzW66CT5BjTWn5fa03w==
X-Google-Smtp-Source: AGHT+IEwGlZz8RYNoPzpL93uJpWD2NnHtQ9VCh2yefPkGMWhot686Gc4NY94WGG1Az3RlhWC3haErjmYaDtp3KasRZE=
X-Received: by 2002:a17:90b:3843:b0:273:e42b:34c1 with SMTP id
 nl3-20020a17090b384300b00273e42b34c1mr2382003pjb.42.1696436221456; Wed, 04
 Oct 2023 09:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABCjUKBXPLNaBjELHqz=Oke_JsxXLQauTWrsNmTp3KToW3-9MQ@mail.gmail.com>
 <CABCjUKCRXeT2eExm6+y7cZCX4yEbj5MbjFnCHv4xvRPL5ce13g@mail.gmail.com> <CAJWu+opvq3dTk4dQmmR+7fs2KcrMELvt0iJcDeRQ9o9cnAVHWA@mail.gmail.com>
In-Reply-To: <CAJWu+opvq3dTk4dQmmR+7fs2KcrMELvt0iJcDeRQ9o9cnAVHWA@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 4 Oct 2023 12:16:50 -0400
Message-ID: <CAJWu+or4yNoX3Dd=hCKbgM=JbVjzjV4M3o8Y6ihhJ_JLThEbFg@mail.gmail.com>
Subject: Re: NOHZ interaction between IPI-less kick_ilb() and nohz_csd_func().
To:     Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 12:09=E2=80=AFPM Joel Fernandes <joelaf@google.com> =
wrote:
>
> +Frederic Weisbecker
>
> On Wed, Sep 13, 2023 at 10:32=E2=80=AFAM Suleiman Souhlal <suleiman@googl=
e.com> wrote:
> >
> > (I forgot to also add Vincent...)
> >
> > On Wed, Sep 13, 2023 at 9:49=E2=80=AFPM Suleiman Souhlal <suleiman@goog=
le.com> wrote:
> > >
> > > Hello,
> > >
> > > I noticed that on x86 machines that have MWAIT, with NOHZ, when the
> > > kernel decides to kick the idle load balance on another CPU in
> > > kick_ilb(), there's an optimization that makes it avoid using an IPI
> > > and instead exploit the fact that the remote CPU is MWAITing on the
> > > thread_info flags, by just setting TIF_NEED_RESCHED, in
> > > call_function_single_prep_ipi().
> > > However, on the remote CPU, in nohz_csd_func(), we end up not raising
> > > the sched softirq due to NEED_RESCHED being set, so the ILB doesn't
> > > end up getting done.
> > >
> > > Is this intended?

Just thinking out loud I was wondering how nohz-ILB really matters if
based on what Suleiman is saying - it is not even triggering on x86
due to the mwait optimization. And if it does matter, how much
improvement will fixing this bug give. I think at least on ARM, I
remember it matters.

I am meanwhile looking at it more closely...

thanks,

 - Joel
