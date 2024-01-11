Return-Path: <linux-kernel+bounces-23523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F182ADF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934452837E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E9156C1;
	Thu, 11 Jan 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI6zd3Jk"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63A154AC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-680a13af19bso33567866d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704973987; x=1705578787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqvos4WQY2drz+EfAUjc2DgvS79oVJ3ure5sp0jGew8=;
        b=kI6zd3JkC/C94zgbV3PzGzvEQ+W62IEqiX67aOGir4aRwiQAI50qwg3iVq3kUU5IY3
         v9LqscU1MRjyJsDHDuOVrBbVb+LMD68Gsr8WeDOPBZbQmCGcpnRepz/vN4KcEnrk3tOM
         H1RooOr6vU18ialOWDr+iT2od6AVvbFDg1udRHC2ztSIRhnsz64Z2hFf4f6nNy+vVmw0
         e6VlKkSNeYimVT6hTIfQPnmVdC9cCzm4hh4YnqvaAIrMI78KpSXMAfhEkJXQnbCp8UHp
         GogCUDM+xgOO+aZU9CX0fLIgiwbe4C6eY3tom+FhV33pXdquT29KsMtXmiJv4Fx39+xt
         xIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704973987; x=1705578787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqvos4WQY2drz+EfAUjc2DgvS79oVJ3ure5sp0jGew8=;
        b=bNApAE2o5EAyE8KrFIT4C9Cr+cPAz64DhsCK6O3zYHn8mn38sMAU/maQKRC80WLWx0
         exTFI5gsuscsRBFzcnVP1ZVDup1mvrHy0E/q01vsGcPkNHw4Wcd33InW7Zr22gr/y7hK
         gSQZnYF+F2iMO7E6SIz2+uq1k6yXNCNCUBx3NPW6bDPPpfjZ4dMA+PSUDyrWTVuNIbIM
         Po/JCsTg48BFijwxrt3t5By7gynvaFK7zuwD4b8JHOHP7O3T01QSyb8sI00RELsb4YoS
         fNjZdfl/VCFWG1Usi109/c63ljPWXhOcth3J91RHxKrH6hH7j1YtoTwK7NFtqT00Wg7m
         zaTg==
X-Gm-Message-State: AOJu0YwSfiEFvgmkeaFICdKSYlewVVx5UTaYTyF3zRn1nrqNCQY8sTxi
	JJ+gJ3dAu2aHqtg3OcdrmatPbIx0zFOs6zCwsCM=
X-Google-Smtp-Source: AGHT+IFMV/rvQ+mHVJob22Vd0f6PshVQ47iVt6oFXnNlCjEOoDwvEfQQmZHnfWOAOEqmUdBuyIxKyAdzPJITO0Dw9nQ=
X-Received: by 2002:a05:6214:29c3:b0:67c:1818:7966 with SMTP id
 gh3-20020a05621429c300b0067c18187966mr1135655qvb.46.1704973987051; Thu, 11
 Jan 2024 03:53:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110133038.46903-1-wudaemon@163.com>
In-Reply-To: <20240110133038.46903-1-wudaemon@163.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 11 Jan 2024 19:52:30 +0800
Message-ID: <CALOAHbAtXQsqi5ny58NRG9wOmZpOVkCi7yyy-ZtZdTnHZcPz5g@mail.gmail.com>
Subject: Re: [PATCH v4] sched/stats: Fix rt/dl task's sched latency statistics
 error in sched_stat_wait trace_point
To: Junwen Wu <wudaemon@163.com>
Cc: bristot@redhat.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 9:32=E2=80=AFPM Junwen Wu <wudaemon@163.com> wrote:
>
> The sched_stat_wait tracepoint is showing unreasonably long
> latencies for real-time tasks. For example:
>
> sched_stat_wait: comm=3Drcu_preempt pid=3D14 delay=3D4936139545261 [ns]
>
> This error happens when the rt task balances off the source CPU because
> the dequeue operation is not updating the sched_statistics. So, follow
> update_stats_wait_end_fair() and update the stats. Do the same for
> SCHED_DEADLINE.
>
> Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
> Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched cla=
ss")
> Signed-off-by: Junwen Wu <wudaemon@163.com>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

BTW, feel free to include the 'acked-by' in a newer version if your
modifications are only minor.

> ---
>  kernel/sched/deadline.c | 5 ++++-
>  kernel/sched/rt.c       | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b28114478b82..4a9aad291fb9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1558,10 +1558,13 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, stru=
ct sched_dl_entity *dl_se,
>                         int flags)
>  {
>         struct task_struct *p =3D dl_task_of(dl_se);
> +       struct rq *rq =3D rq_of_dl_rq(dl_rq);
>
>         if (!schedstat_enabled())
>                 return;
> -
> +       /*  Mark the end of the wait period if dequeueing a waiting task.=
*/
> +       if (p && (p !=3D rq->curr))
> +                update_stats_wait_end_dl(dl_rq, dl_se);
>         if ((flags & DEQUEUE_SLEEP)) {
>                 unsigned int state;
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..5cb3a54d6b13 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1360,12 +1360,16 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, stru=
ct sched_rt_entity *rt_se,
>                         int flags)
>  {
>         struct task_struct *p =3D NULL;
> +       struct rq *rq =3D rq_of_rt_se(rt_se);
>
>         if (!schedstat_enabled())
>                 return;
>
>         if (rt_entity_is_task(rt_se))
>                 p =3D rt_task_of(rt_se);
> +       /* Mark the end of the wait period if dequeueing a waiting task. =
*/
> +       if (p && (p !=3D rq->curr))
> +               update_stats_wait_end_rt(rt_rq, rt_se);
>
>         if ((flags & DEQUEUE_SLEEP) && p) {
>                 unsigned int state;
> --
> 2.34.1
>


--=20
Regards
Yafang

