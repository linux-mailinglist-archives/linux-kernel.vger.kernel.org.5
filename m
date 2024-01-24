Return-Path: <linux-kernel+bounces-36308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68C839F29
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49B11F27F80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A944402;
	Wed, 24 Jan 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHxZJiia"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE6539E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063543; cv=none; b=Jh5P9wx6cL712hrhvBWFQnJAJpODcppvg4VB6WdwDfHtHrhJyxcf+SjYQeEXvtkgaaBlCSfE7BOFMXw7B0CHWMK115JQ1C6Ng5CvnpxNNZvxtB+GLGlPFgwCrU/2YY3M+BYaPBHsABMlNCotk9vWtaKX63gJrNsnlG30h7ZHbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063543; c=relaxed/simple;
	bh=bxzoS3Xw9zXaKiUFcIyp64tU2HqQkMiTb3VZvWOfIPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYnitq0hHO4PtDda9NqS0Pq4odYTODeBSLpNy9PjaSImtg4+TCQVTs8IJ+0bR8gH+DF15xpPPeTQ/rJfvxSp2vyhWvhDCrZNCxON8fs/TSLv2JdEt8JvsE4LJumSyHousHF2AsNwDWzZy6oYke/T622H4ZSVqSaMkFpl95qniOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHxZJiia; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so5901322a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706063539; x=1706668339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnVoSlzVyBZk4JMcAYipXd6Q49vTRSUe1JnvzwuqSmc=;
        b=nHxZJiiaUXDvf7F3hk6sUatYtQWa7ze5WI0dvgFXRiRIOHV1q1Fy0LPYe/trpY+hHH
         poFUtyz7jjwijIom65Mqg4wl78Eh8CEp/oo4Zdzoofnd3sy9fKgHR1QOl+/7f0siqv4O
         LNjG9Q5DmHBwLUBXM4bCfUnV140KoAbvn/evAsMWuqdFsOBsMmpjtJ9qYCoVfhlJ6iIi
         qsYHSuf8yCjDLGgFqvjQ4qunS+LR3f6DPDqNPUbUaKopGSpRwHPfvKrEG98Ry+NexD4F
         hdn6gbmTGnq8tkGUCQ5Kj3QxyJpni7lG71NJ1n0TgjMRNlt4f2lccXBzYrbMcHvPFhWP
         3txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706063539; x=1706668339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnVoSlzVyBZk4JMcAYipXd6Q49vTRSUe1JnvzwuqSmc=;
        b=mjPbhX3T8QsTj95tm16b3253YL+CFvMTiqZFSIJYrLNJqs6XGfM3VwjWIIadvJs5YV
         8Q/aw0D3DCE6xHEDqaD93KQItxEJCNkGhvr4dAbr22zJMj5QGWjxVgJq/rygrvpo5Wly
         SV8hgZZEH6bAqUwi3KFpZfAr699BRlvs4pFghhKVYghaehGtdAPRWaII/hdaeqowx/Te
         zWXWCgxQmL9w3I7PwIOtD+oNkI6PAtQLXBIxxBKlDb938MHuBl0DhlZqVkZvW5pj0v0A
         9mceZnAdGt7W/2YByfhtnbzv63dekjIpdz7Jis5TdnxgXoEG/yO+SgmuQh6eWH5dxhnm
         7PbA==
X-Gm-Message-State: AOJu0YwC1VYS5FPBjzShZhF1/cZ0BGdxRuFIfNNpOiQVeW0jJ5G+jyo0
	z8e0XPWTMSs7Dk9z5RkwmEacBvApd4XVLwJNjpFq1Hhp3k8KxFqzNCO1HZprN2Ea1pDuMonBcRj
	FOYA1HyPAlogiTd4Qmc6X+58lXsc=
X-Google-Smtp-Source: AGHT+IHo6CS+jbtA2ne1a4KLINGdbMKEHpeABsY5CmcO2/68OaA0Y7gTllewNJjgQ/rLEmhpLMll6VWQIz0rPAGvL4Q=
X-Received: by 2002:a05:6402:13ce:b0:55c:908f:fb9 with SMTP id
 a14-20020a05640213ce00b0055c908f0fb9mr1104089edx.16.1706063539124; Tue, 23
 Jan 2024 18:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111115745.62813-2-zegao@tencent.com> <Za-0HCP7WG3PIe7h@linux.ibm.com>
In-Reply-To: <Za-0HCP7WG3PIe7h@linux.ibm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 24 Jan 2024 10:32:08 +0800
Message-ID: <CAD8CoPAJh9ggK8ODYFiUaF2WXPG4d5ERDUdpL532N5kc=-xuSw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/eevdf: Use tunable knob sysctl_sched_base_slice
 as explicit time quanta
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:42=E2=80=AFPM Vishal Chourasia <vishalc@linux.ibm=
com> wrote:
>
> On Thu, Jan 11, 2024 at 06:57:46AM -0500, Ze Gao wrote:
> > AFAIS, We've overlooked what role of the concept of time quanta plays
> > in EEVDF. According to Theorem 1 in [1], we have
> >
> >       -r_max < log_k(t) < max(r_max, q)
> >
> > cleary we don't want either r_max (the maximum user request) or q (time
> > quanta) to be too much big.
> >
> > To trade for throughput, in [2] it chooses to do tick preemtion at
> > per request boundary (i.e., once a cetain request is fulfilled), which
> > means we literally have no concept of time quanta defined anymore.
> > Obviously this is no problem if we make
> >
> >       q =3D r_i =3D sysctl_sched_base_slice
> >
> > just as exactly what we have for now, which actually creates a implict
> > quanta for us and works well.
> >
> > However, with custom slice being possible, the lag bound is subject
> > only to the distribution of users requested slices given the fact no
> > time quantum is available now and we would pay the cost of losing
> > many scheduling opportunities to maintain fairness and responsiveness
> > due to [2]. What's worse, we may suffer unexpected unfairness and
> > lantecy.
> >
> > For example, take two cpu bound processes with the same weight and bind
> > them to the same cpu, and let process A request for 100ms whereas B
> > request for 0.1ms each time (with HZ=3D1000, sysctl_sched_base_slice=3D=
3ms,
> > nr_cpu=3D42).  And we can clearly see that playing with custom slice ca=
n
> > actually incur unfair cpu bandwidth allocation (10706 whose request
> > length is 0.1ms gets more cpu time as well as better latency compared t=
o
> > 10705. Note you might see the other way around in different machines bu=
t
> > the allocation inaccuracy retains, and even top can show you the
> > noticeble difference in terms of cpu util by per second reporting), whi=
ch
> > is obviously not what we want because that would mess up the nice syste=
m
> > and fairness would not hold.
>
> Hi, How are you setting custom request values for process A and B?

I cherry-picked peter's commit[1], and adds a SCHED_QUANTA feature control
for testing w/o my patch.  You can check out [2] to see how it works.

And the userspace part looks like this to set/get slice per process:

#include <stdio.h>
#include <stdlib.h>
#include <sched.h>            /* Definition of SCHED_* constants */
#include <sys/syscall.h>      /* Definition of SYS_* constants */
#include <unistd.h>
#include <linux/sched/types.h>
/*
int syscall(SYS_sched_setattr, pid_t pid, struct sched_attr *attr,
                unsigned int flags);
int syscall(SYS_sched_getattr, pid_t pid, struct sched_attr *attr,
                unsigned int size, unsigned int flags);
*/

int main(int argc, char *argv[])
{
        int pid, slice =3D 0;
        int ecode =3D 0;;
        struct sched_attr attr =3D {0};
        if (argc < 2) {
                printf("please specify pid [slice]\n");
                ecode =3D -1;
                goto out;
        }
        pid =3D atoi(argv[1]);
        if (!pid || pid =3D=3D 1) {
                printf("pid %d is not valid\n", pid);
                ecode =3D -1;
                goto out;
        }

        if (argc >=3D 3)
                slice =3D atoi(argv[2]);

        if (slice) {
                if (slice < 100 || slice > 100000) {
                        printf("slice %d[us] is not valid\n", slice);
                        ecode =3D -1;
                        goto out;
                }
                attr.sched_runtime =3D slice * 1000;
                ecode =3D syscall(SYS_sched_setattr, pid, &attr, 0);
                if (ecode) {
                        printf("change pid %d failed\n", pid);
                } else {
                        printf("change pid %d succeed\n", pid);
                }
        }

        ecode =3D syscall(SYS_sched_getattr, pid, &attr, sizeof(struct
sched_attr), 0);
        if (!ecode) {
                printf("pid: %d slice: %d\n", pid, attr.sched_runtime/1000)=
;
        } else {
                printf("pid: %d getattr failed\n", pid);
        }
out:
        return ecode;
}

Note: here I use microseconds as my time units for convenience.

And the tests run like this:


#!/bin/bash

test() {

        echo -e "-----------------------------------------\n"
        pkill stress-ng

        sleep 1

        taskset -c 1 stress-ng -c 1  &
        ./set_slice $! 100
        taskset -c 1 stress-ng -c 1  &
        ./set_slice $! 100000

        perf sched record -- sleep 10
        perf sched latency -p -C 1
        echo -e "-----------------------------------------\n"

}

echo NO_SCHED_QUANTA > /sys/kernel/debug/sched/features
test
sleep 2
echo SCHED_QUANTA > /sys/kernel/debug/sched/features
test


[1]: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commi=
t/kernel/sched?h=3Dsched/eevdf&id=3D98866150f92f268a2f08eb1d884de9677eb4ec8=
f
[2]: https://github.com/zegao96/linux/tree/sched-eevdf


Regards,
        -- Ze

> >
> >                       stress-ng-cpu:10705     stress-ng-cpu:10706
> > ---------------------------------------------------------------------
> > Slices(ms)            100                     0.1
> > Runtime(ms)           4934.206                5025.048
> > Switches              58                      67
> > Average delay(ms)     87.074                  73.863
> > Maximum delay(ms)     101.998                 101.010
> >
> > In contrast, using sysctl_sched_base_slice as the size of a 'quantum'
> > in this patch gives us a better control of the allocation accuracy and
> > the avg latency:
> >
> >                       stress-ng-cpu:10584     stress-ng-cpu:10583
> > ---------------------------------------------------------------------
> > Slices(ms)            100                     0.1
> > Runtime(ms)           4980.309                4981.356
> > Switches              1253                    1254
> > Average delay(ms)     3.990                   3.990
> > Maximum delay(ms)     5.001                   4.014
> >
> > Furthmore, with sysctl_sched_base_slice =3D 10ms, we might benefit from
> > less switches at the cost of worse delay:
> >
> >                       stress-ng-cpu:11208     stress-ng-cpu:11207
> > ---------------------------------------------------------------------
> > Slices(ms)            100                     0.1
> > Runtime(ms)           4983.722                4977.035
> > Switches              456                     456
> > Average delay(ms)     10.963                  10.939
> > Maximum delay(ms)     19.002                  21.001
> >
> > By being able to tune sysctl_sched_base_slice knob, we can achieve
> > the goal to strike a good balance between throughput and latency by
> > adjusting the frequency of context switches, and the conclusions are
> > much close to what's covered in [1] with the explicit definition of
> > a time quantum. And it aslo gives more freedom to choose the eligible
> > request length range(either through nice value or raw value)
> > without worrying about overscheduling or underscheduling too much.
> >
> > Note this change should introduce no obvious regression because all
> > processes have the same request length as sysctl_sched_base_slice as
> > in the status quo. And the result of benchmarks proves this as well.
> >
> > schbench -m2 -F128 -n10       -r90    w/patch tip/6.7-rc7
> > Wakeup  (usec): 99.0th:               3028    95
> > Request (usec): 99.0th:               14992   21984
> > RPS    (count): 50.0th:               5864    5848
> >
> > hackbench -s 512 -l 200 -f 25 -P      w/patch  tip/6.7-rc7
> > -g 10                                         0.212   0.223
> > -g 20                                 0.415   0.432
> > -g 30                                 0.625   0.639
> > -g 40                                 0.852   0.858
> >
> > [1]: https://dl.acm.org/doi/10.5555/890606
> > [2]: https://lore.kernel.org/all/20230420150537.GC4253@hirez.programmin=
g.kicks-ass.net/T/#u
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
>

