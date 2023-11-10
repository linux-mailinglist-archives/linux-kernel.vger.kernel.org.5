Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6687E7837
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345858AbjKJDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbjKJDpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:45:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1634681
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:45:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so21645a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 19:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699587926; x=1700192726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S05t1zS4yIAqS8g5DFJbjJPTBmhauuOi1XjTZGWism0=;
        b=0Lao2icsRFOO1NfZtCtFZa/Yhov3ydEsw2iCfGBWR3jannQAfqfIMMffAi5sbYSiTs
         QFxZZKL6yTPyvo9lzM4j3UJJnBJoZj3UcQD03wdx7PNn4lHprvhQ584X97JPMrABPHve
         c1bsdEGifdN+bzoHSn1LpYx9VWYGiZPP/pxkECMXK+5N4G7FSFh+fwDLG58nKvmfECei
         522UQC1cjHAZC/xQWm0j7RaTLabEiQzcrR3A8WlSZRDDjLqTwCn+I1DhCZZrysW/qmUS
         ZluWTzq//BfD4z+EsJr6GtUMR1TM/A/TZSjQNf9HIZ8zykE8Qvhhdxx8kGefAf/C3bD2
         3TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699587926; x=1700192726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S05t1zS4yIAqS8g5DFJbjJPTBmhauuOi1XjTZGWism0=;
        b=m5UHx8PmILEZhdhelp+FqE3ZAvQhbSoo4xcU/4lJudezrlf/XxhkYMp7lIjQV6Or9A
         FrlXKbqSubiYGISrOc/B7gBLWt08iemMqZCsnmet3Hip0jXzjMQrc4PdHAliDN+qKFA8
         udhT4Ol/vTSCAIpO9fnOjKwKmwLJ748hQhmaV8R+CaoLUFVR14TmNkcmLqBtEeJrP/KA
         FMyUtZhyS471ANsl4lgbrvrKuy23CVE8D9LyF+HI4c6qzaMdiONJKhlcfA+Rh0YjdGB2
         hKhjfg0RDT1HHvViSr1HViIyEWpqJlPV6XdW2TxhhfPB0f3xNtyGzK9DKvdoM5Q7fp2b
         7KXw==
X-Gm-Message-State: AOJu0YygLixvVSRqYiSQWXkXkF0lxX0AKg/G1f6eMkt5I5Q28UISEEnC
        pHKfHwg3hBgugF8M6nL23Tf7q8Wy2mxHd/fVynfb
X-Google-Smtp-Source: AGHT+IEa9gC1jQ97bqH6SNzJ8SkB2FCCKZtPo7WX0U6+4vnFf2P88w1mFCq4uy23eGEetvN1bJ18AignXU9hEBc5oag=
X-Received: by 2002:a05:6402:1484:b0:544:466b:3b20 with SMTP id
 e4-20020a056402148400b00544466b3b20mr277508edv.5.1699587926257; Thu, 09 Nov
 2023 19:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <20231106193524.866104-19-jstultz@google.com>
 <CAB8ipk8faF30V8_maGiB62adBg6PLfynGg3p6PBoGJO_rzS7_Q@mail.gmail.com>
 <CANDhNCoqx-5PUB63Px8OuZnSrYsFzzMBFRrRZ7b72CbPOe9W9g@mail.gmail.com> <CAB8ipk9Mye4t=wuSwF-xqJJ36BUxfW2wqb1k_6BCVrKqc4hTFg@mail.gmail.com>
In-Reply-To: <CAB8ipk9Mye4t=wuSwF-xqJJ36BUxfW2wqb1k_6BCVrKqc4hTFg@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 9 Nov 2023 19:45:14 -0800
Message-ID: <CANDhNCojnZTvTKdpgRg8Xsfz32qDigJjoeHxiFZmLquX2_tRQQ@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] sched: Handle blocked-waiter migration (and
 return migration)
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 10:38=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.com>=
 wrote:
> On Thu, Nov 9, 2023 at 2:08=E2=80=AFPM John Stultz <jstultz@google.com> w=
rote:
> > I'm currently trying to see if I can extend the blocked_on_waking flag
> > to keep more state (BLOCKED, WAKING, RUNNABLE) so that we can move the
> > return migration back to the the try_to_wake_up() call path, while
> > avoiding the task from becoming suddenly runnable on wakeup while on
> > the wrong runqueue.  This would avoid the lock juggling as we'd
> > already have the pi_lock. Though I'm a little hesitant as doing the
> > deactivate()/select_task_rq()/activate() steps from ttwu might muddle
> > up the careful logic around the on_rq/ttwu_runnable checks (definitely
> > had issues in that area with earlier versions of the patch).
>
> I also think it is better to put the return migration back to the
> try_to_wake_up() call path.
> When mutex_unlock, could we deactivate the block task before adding it
> to wake_q?

That's an interesting idea. Let me give that a shot and see if it
works out better.

> In this case, it can follow the try_to_wake_up patch. But at this
> time, the trace_sched_blocked_reason
> may be no need?
>
> >
> > > In addition, I also thought that since the block task is no longer
> > > dequeued, this will definitely cause the load on the CPU to increase.
> > > Perhaps we need to evaluate the impact of this on power consumption.
> > >
> >
> > Yeah. I've got that still as a todo in the cover letter:
> > * CFS load balancing. Blocked tasks may carry forward load (PELT)
> >   to the lock owner's CPU, so CPU may look like it is overloaded.
> >
> > If you have any thoughts there for a preferred approach, I'd be happy t=
o hear.
>
> Okay, I'm still studying these patches carefully, and I will to test
> these patches later. When I find other problems, I will be happy to
> share.

Very much appreciated! Thank you again for the feedback and thoughts!
-john
