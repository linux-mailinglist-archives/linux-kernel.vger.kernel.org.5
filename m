Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794B7C8108
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjJMI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjJMI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:56:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF11B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:56:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-323168869daso1769629f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697187370; x=1697792170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsJhIfLsRHiX///0/Oi95cVwlqVzdrWiGNekq6xdLM4=;
        b=BYG5qh2eo4/zFD42uLqrvuOdI60clKmsBhB4WBRIaqJiLXC/r6pLzta0eBLNtulfl7
         hop0gta9A7Xnq2hI9NxWq2fYN3qcPu5jUW2YpmYc74Ok9rO338RmGmgNP8gWwjuT7m18
         QyUJAPtY0toRxvdtEnc27noXGMX0/jazvRHv5PF8TsrQRiHpTOtFmxKUza2JB28+za9W
         RRGpa+iJ99f0K0nm/bku1lz52eY6q1Qw9OoVj/gmv6+rZTtVOVUsnZtKW/BHICTIPhZB
         ZWrVfQ+Z8hJpMHMnmpBzq6tl4TxS3XtKSIaDDMNNu/kUnNYG32LLE+WoiFetJGaucJOp
         MJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697187370; x=1697792170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsJhIfLsRHiX///0/Oi95cVwlqVzdrWiGNekq6xdLM4=;
        b=Vo4S+nnc6wNvS/SqAxge8qMHg7gus4JOBRQ63Rv34vof5Q2nzuRA8Iptflq9KKW+RV
         XHPP+tsFlBDhpiyrM/MNG4zBv9LTagMGiI2hAIcDWIGQFeXkjw/PNpnL6OKdywyT4mmy
         BfCQMRHdTwwGesbVNwJWyIbDUMnOLBchhBJzKrJr/apOfikClW57jY2UMUTmIalrmJiY
         UHym9nEXiuWwF9GAxd9Inpofj5Uz1pTNH/LXACdWobzH6u1qy0mXAzdHgdCdkVeBZpIx
         cyxIYBQyeoh4NVq9v3hnKrM68k06izaxV7cK7GSrrGLyiZdILKq7CtxxWaYDzwIZL43z
         s5xQ==
X-Gm-Message-State: AOJu0YwL7XzN9o/6I8URPBDdIkCiiEUH8lpt/7J8I2Tn26UADfQtvx2v
        PPzc38KXPFl+mLtYA2GFUuzCNsgIwWufbnkqvOS1UA==
X-Google-Smtp-Source: AGHT+IFQSN80GM1lzdIOwHcS7K2zJXJxnmkZSpKsMAwnHJyUEeL23io86C4Ojqp4lqoCazHUe7nxeCXeoaPBOqeSJsM=
X-Received: by 2002:a5d:4b05:0:b0:32d:8db5:59ff with SMTP id
 v5-20020a5d4b05000000b0032d8db559ffmr3673791wrq.5.1697187369658; Fri, 13 Oct
 2023 01:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231011065446.53034-1-cuiyunhui@bytedance.com>
 <87sf6gcyb3.fsf@email.froward.int.ebiederm.org> <CAEEQ3wm8oE1dXo7AuU3gY90oF_G21OqNZwnkqhhd1-_j4wWbYQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wm8oE1dXo7AuU3gY90oF_G21OqNZwnkqhhd1-_j4wWbYQ@mail.gmail.com>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Fri, 13 Oct 2023 16:55:58 +0800
Message-ID: <CAEEQ3wk-faMz3pRtc-n_zSTo3B=GjHeDH4PMN0EJT6=HPVGZ=A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] pid_ns: support pidns switching between sibling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        brauner@kernel.org, jeffxu@google.com, frederic@kernel.org,
        mcgrof@kernel.org, cyphar@cyphar.com, rongtao@cestc.cn,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Oct 13, 2023 at 10:44=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
>
> Hi Eric,
>
> On Thu, Oct 12, 2023 at 11:31=E2=80=AFAM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
> >
> > Yunhui Cui <cuiyunhui@bytedance.com> writes:
> >
> > > In the scenario of container acceleration,
> >
> > What is container acceleration?
> >
> > Are you perhaps performing what is essentially checkpoint/restart
> > from one set of processes to a new set of processes so you can
> > get a container starting faster?
> Yeah, you are right .
>
> >
> > > when a target pstree is cloned from a temp pstree, we hope that the
> > > cloned process is inherently in the target's pid namespace.
> >
> > I am having a hard time figuring out what you are saying here.
>
> I think I need to describe in detail our needs and problems we face.
> What we need to do is fork a container into a new container, which
> means that all
> processes of the original container need to be forked out and added to
> the new container.
> Then the forked process needs to be added to the namespace and cgroup
> of the new container.
>
> What we are talking about here is the pid namespace.
>
> for example:
> Assume that there are three processes A, B, and C in the original contain=
er.
> What we need to do is A fork A_new, B fork B_new, C fork C_new.
>
> However, in the existing pidns implementation, the parent process
> first joins pidns, and then
> the forked child process will get the new pidns (the pid of the child
> process is what we expected),
> and the parent process's own pidns has not actually changed (at least
> pid is still existing).
>
> To make A_new, B_new, and C_new inherently in the pidns of the new contai=
ner,
> A, B, and C must first switch to the pidns of the new container, right?
> From my understanding there is no better way to implement it.
>
> But the existing implementation (the part to be changed in this patch)
> is blocking our progress.
>
> >
> > > Examples of what we expected:
> > >
> > > /* switch to target ns first. */
> > > setns(target_ns, CLONE_NEWPID);
> >   ^-------- Is this the line that fails for you?

Yes, it failed here.

Thanks,
Yunhui
