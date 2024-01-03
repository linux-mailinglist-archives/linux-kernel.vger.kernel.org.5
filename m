Return-Path: <linux-kernel+bounces-15128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C95682277E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108BE1C2195B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B41E4A31;
	Wed,  3 Jan 2024 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqSt2mQ5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289214A27
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55539cac143so6651865a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 19:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704251705; x=1704856505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yCW+5O20qYq82QEvwJZHzQUCJBD1lIKf/JM2prlUkY=;
        b=PqSt2mQ5FwlhVWdIbFKu9dKo3qU7teiKkU0lRiRlJz99RlVttRCKByqWHLKpyB8cLM
         hMlLSTsvdELrwTJGTGnMS/Vs8HiJdleo/v1NETRMdTDJ4RIct/VDS0vuuC1pq8Ly7UQx
         NAWnw5IWVOP9kvJ+R4PCwXJrBoYNubhZ7TgZYUk2VuP13Xp4plucCPsZIs2UEQOTuy9r
         0Xj6kQ+x6OUfCZ98km56i+Q9T6dw4YhXVFXMIS6fBe1pTVYFLD4/6f7uoOfI1dyf+Qtm
         ncC5enLVQRPXU5CJYRB3N6RlWm3fEd6gvNDD2NuRoE4P1ho+g+7qZwy3AJ0WcjRw7jyt
         hIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704251705; x=1704856505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yCW+5O20qYq82QEvwJZHzQUCJBD1lIKf/JM2prlUkY=;
        b=jlvd0o3wTnZKnIHp+LLemwj4nrHCfApSFyxoH0YvRQs4irUKEjN0xtFtI1GH+++34/
         JlGsuvKModI2KH40N2V/cXsF17d6QR72a1oBO/dtMfco6oL5XyMbcJVZY0lsMcXbdWO1
         R3A/GCQblaO+U5xKPZmx39yhiIpyITi/QeDszebDLyfKEYgHiJsWPEQ7j9uFSSQVTgpn
         s1py3lK03YGpcb/dOzVGv+SO6u/wtDOGnaV/nxZNo16ikFoSFZoqtXQISkRCV80xUkrO
         QWS8irA1Y+CeJsvEwt/i1Hl6MlIEecrOZUyAOQZdaI85Ruh4JkT0q2Hz8TejRlKZWfBL
         Y5xg==
X-Gm-Message-State: AOJu0Yy0QztS7MGsorZ6Y+ctPSXXzoh+EozCPABJVMymvZ0CmTJoI+73
	6N3gom6LHUDLWpnbuuSWCEeZIhrYLRI3sgkfyJ0=
X-Google-Smtp-Source: AGHT+IFbUZCHNjuNqZKsm7D3GhTqH+amvdbA9Hr7oyK3NDCLYNY8gDlP35k+OL216aHKCZEQLmmzUeDabcmEiLq1XQE=
X-Received: by 2002:a05:6402:1347:b0:555:936e:feb6 with SMTP id
 y7-20020a056402134700b00555936efeb6mr4426542edw.22.1704251705088; Tue, 02 Jan
 2024 19:15:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102073351.1527503-1-alexs@kernel.org> <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-Am=R=gRFqSdGjXaMqq7Yetpp-4=bLtnP-87GepN4zff5Tg@mail.gmail.com> <xhsmhjzork8x5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhjzork8x5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Alex Shi <seakeel@gmail.com>
Date: Wed, 3 Jan 2024 11:14:29 +0800
Message-ID: <CAJy-AmkG+6jZCGFBnqA_33NtBBq_hjemqkPCbZX2Jty0KWQE+w@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: correct the task blocking state
To: Valentin Schneider <vschneid@redhat.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, curuwang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 12:16=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> On 02/01/24 21:00, Alex Shi wrote:
> > On Tue, Jan 2, 2024 at 6:19=E2=80=AFPM Valentin Schneider <vschneid@red=
hat.com> wrote:
> >>
> >> On 02/01/24 15:33, alexs@kernel.org wrote:
> >> > From: Alex Shi <alexs@kernel.org>
> >> >
> >> > commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_IDL=
E")
> >> > stopped the idle kthreads contribution to loadavg. Also task idle sh=
ould
> >> > separated from blocked state too, otherwise we will get incorrect ta=
sk
> >> > blocking state from event tracing sched:sched_stat_blocked.
> >> >
> >>
> >> Why is that incorrect? AFAICT we have mapped the (schedstat) 'blocked'
> >> meaning to TASK_UNINTERRUPTIBLE. TASK_IDLE tasks don't contribute to
> >> loadavg yes, but they are still in an UNINTERRUPTIBLE wait.
> >
> >
> > Hi Valentin,
> > Thanks a lot for the reply.
> >
> > I agree with you the current usage, but if so, we account for the idle =
task into
> > blocked state. And it's better to distinguish between idle and block.
> >
>
> Why is that an issue? If those tasks didn't have to be
> TASK_UNINTERRUPTIBLE (via TASK_IDLE), we'd make them TASK_INTERRUPTIBLE a=
nd
> they'd also inflate the 'sleeping' schedstat (rather than the 'blocked').
>
> What problem are you facing with those tasks being flagged as blocked dur=
ing
> their wait?
>

Uh, Tencent cloud has some latency sensitive services, a blocked state
means the service has
 some trouble, but with IDLE state involved, it's failed on this judgement.
and 2nd, if a service has abnormal, we want to check if it's hanging
on io or sth else, but the top
3 D tasks are often queuework in our system, and even a task in
blocked state we have no
quick way to figure out if it's IDLE or BLOCKED.  2 different states
will help us a lot.

Thanks!

