Return-Path: <linux-kernel+bounces-77762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF38609ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC8C1C21523
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE0F1119E;
	Fri, 23 Feb 2024 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNQtrx0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610AB101CA;
	Fri, 23 Feb 2024 04:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663064; cv=none; b=q1EyXKT6iXi25+ZQaDBbPjAR24bIoHUmqdL0lcIG9YbuTdAI4ZUNePHcpL7OEsy37ceos7FPJgqQVK0aDJEymISGSNs6AdHUgf9clkl8mR3ZzsY05t87dGwOretZYe2BzLkTeXCmDH8bnlI//4aplhcXFPHpdm1M+W/jEFjqQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663064; c=relaxed/simple;
	bh=vGHd2erKkEsxtaljBihtqIv1q90PFdzRDclLbkHfQyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zh+eWb+uR7v3no70QxVI2QzLmr+MLxB7xaXcOxtX5KLW3Rb8XV+s7Umj31xa0mUQSywLyYoMZm2ZZFpa6NS75HJV1+posycJyWjKWwvLTeJve26ygi1r0eFriOMsoADNRbQe3mYQP8d+evnwKZAsMi8fyR4WmVBS505JlGahhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNQtrx0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0177C433A6;
	Fri, 23 Feb 2024 04:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708663063;
	bh=vGHd2erKkEsxtaljBihtqIv1q90PFdzRDclLbkHfQyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sNQtrx0d9jq72lzaWMMmlaBrc9yQo796oPNIgSXmWVfxOIwheizFaBFamHc64eRyb
	 DTMDF2DNuIxwiajLY0zeXJ7B4+V3V6JGTiS/3Ov3FL1AGW0mcgli6xTO0y03W/yYEv
	 /Vw4j/Bv8nlSftXSLon/YUXAeMLQ0fTfeDTHhxhi0TiA9odOXHqs9Qdz7+UB9hbnf1
	 otT4Xi5ze88A71ucSJ7tKLMvxIgZlWEoVpMSvHl7MST3Kb8oo49y2Awg/p5SnXmmKM
	 HF5J9BvwNuijt7cXkxTfP+ByIPuop/TyiWCw4GGsj2bW6VH5ddETbTw4jmHjNR7BD2
	 zaUeU3yUOUFNA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f1bf03722so47189666b.1;
        Thu, 22 Feb 2024 20:37:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqYFJJ0iTsTrLFfTkHuY0SEqAsiQC7icuk4jNV/9Jhf2IKQwuANiBYBqYT0G0vVa019JxMbWs3nn64QM6avAZbs0NKJ+5c9TNfvKR+UfagQ53zH4dX9TnQ4cuwjrz5qT62KlFl
X-Gm-Message-State: AOJu0YzJlWDWNe07gsDOPwFBY6Bqe+eAlhnmGngpSSQpFDCr6PVkR+15
	wDt+0AM6Z5bqBdRKcTG8jsshran63Pz5CTFUG5OfuhtlNLsi3S/nq3NsRcURRHfAtzLzP+RYARe
	7UA+YgMNKh0JlEDfBI1YEa9STTt8=
X-Google-Smtp-Source: AGHT+IHJZOLENCMZzvT8POBu9pvVV1814nARmErOW5GGtKi2+FywA7bHWo4xkahPRJKNj9GNdx1je66iM1wbsr0qEIg=
X-Received: by 2002:a17:906:164a:b0:a3f:9c9b:2037 with SMTP id
 n10-20020a170906164a00b00a3f9c9b2037mr432039ejd.67.1708663062206; Thu, 22 Feb
 2024 20:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220171457.703-1-kprateek.nayak@amd.com> <20240220171457.703-12-kprateek.nayak@amd.com>
In-Reply-To: <20240220171457.703-12-kprateek.nayak@amd.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 23 Feb 2024 12:37:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRFwLw7v8Ks=_Tu-SmYjC-1D7_L0beGNjkJ-180f5ULuw@mail.gmail.com>
Message-ID: <CAJF2gTRFwLw7v8Ks=_Tu-SmYjC-1D7_L0beGNjkJ-180f5ULuw@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] csky/thread_info: Introduce TIF_NOTIFY_IPI flag
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-csky@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:20=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
com> wrote:
>
> Add support for TIF_NOTIFY_IPI on C-SKY. With TIF_NOTIFY_IPI, a sender
> sending an IPI to an idle CPU in TIF_POLLING mode will set the
> TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
> CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
> avoids spurious calls to schedule_idle() in cases where an IPI does not
> necessarily wake up a task on the idle CPU.
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: linux-csky@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  arch/csky/include/asm/thread_info.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/=
thread_info.h
> index b5ed788f0c68..9bc7a037c476 100644
> --- a/arch/csky/include/asm/thread_info.h
> +++ b/arch/csky/include/asm/thread_info.h
> @@ -61,6 +61,7 @@ static inline struct thread_info *current_thread_info(v=
oid)
>  #define TIF_SYSCALL_TRACEPOINT 5       /* syscall tracepoint instrumenta=
tion */
>  #define TIF_SYSCALL_AUDIT      6       /* syscall auditing */
>  #define TIF_NOTIFY_SIGNAL      7       /* signal notifications exist */
> +#define TIF_NOTIFY_IPI         8       /* Pending IPI on TIF_POLLLING id=
le CPU */
>  #define TIF_POLLING_NRFLAG     16      /* poll_idle() is TIF_NEED_RESCHE=
D */
>  #define TIF_MEMDIE             18      /* is terminating due to OOM kill=
er */
>  #define TIF_RESTORE_SIGMASK    20      /* restore signal mask in do_sign=
al() */
> @@ -73,6 +74,7 @@ static inline struct thread_info *current_thread_info(v=
oid)
>  #define _TIF_SYSCALL_TRACEPOINT        (1 << TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_SYSCALL_AUDIT     (1 << TIF_SYSCALL_AUDIT)
>  #define _TIF_NOTIFY_SIGNAL     (1 << TIF_NOTIFY_SIGNAL)
> +#define _TIF_NOTIFY_IPI                (1 << TIF_NOTIFY_IPI)
>  #define _TIF_UPROBE            (1 << TIF_UPROBE)
>  #define _TIF_POLLING_NRFLAG    (1 << TIF_POLLING_NRFLAG)
>  #define _TIF_MEMDIE            (1 << TIF_MEMDIE)
> --
> 2.34.1
>
LGTM

Acked-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

