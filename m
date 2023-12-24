Return-Path: <linux-kernel+bounces-10691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F181D8D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D3A1F2184A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCAA23A8;
	Sun, 24 Dec 2023 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQCa7gAl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FF20FA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f33cf014cso26167926d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703417942; x=1704022742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrP1BOh8R9a54b7OYq/9y4AFoHBEUH9+IlCKTqH8hjA=;
        b=DQCa7gAl09ZPdBdfRoWzJVNF+BJRq1N0/Eta87hjnrxrbPgeOsWoW48Df3zJwuGqtE
         MxaZWZD0lxlK9hHWBsIL8LYGcidYIJo5WkKim1Z37ySpcaOMpNnCRBafCTUPiafBMg8X
         FsrpIS8oztiTyE5LzgSKIOG/p8KKeCl9MlzWy6N0zi7U2a6X6dYvWvhFqNhOTtUN/WS7
         kCVoZ6osZ3K4VPD0Q9W3L2qAoiZrgLEpZjKeqDQUxQsZjkOJyC43Wp52yl9zbla1LfY7
         UGCtMV0h8h+kCMM5Reqix2ZGbtsjjNK8oSDrmGhjOOsT7lol0K4iTMdU/OHbhge+l1er
         FKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703417942; x=1704022742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrP1BOh8R9a54b7OYq/9y4AFoHBEUH9+IlCKTqH8hjA=;
        b=u8ACw1yBYzBe0wJxK86kdWeXVz8CKNiEsPmyOq9ncwwU+K4AWRmcwxPKNh64xxczGb
         4AYdJ2MVoTO3nvUcL+6sX8ar2Iq4LvMUy1CNY+6JyuCvcuGjXkKq2A2c5Ly5YcnLUiiM
         Q3kL79oXgQpPy5BApk2Q4T+FIbMZp4UiHnevBcQg5ncGfZ+2lU0SpNrFWSCR/BXQ7Tsf
         qoAEhWt1aO3TOPRLbhdk/1rKroNnJSZv5/+aIIED/rAPkSQJCgm5EDwjmlJjWxHCdpcj
         qRxd+vcdy0aNTiYqeXuEls3moYtEaHwSybPGOTrRkhQHpHOZWjbEyKeHtlXfy5WMJnAM
         cS0Q==
X-Gm-Message-State: AOJu0YxN5g/0ueTrSbEwbV6DBeK1oMymzGbiW+uSEju+WZeDOXeS/M6w
	Kl1uBmyTum0ueqtDwcKlgueTQ57ERS2fA0NWGVs=
X-Google-Smtp-Source: AGHT+IGNm3S5cTeFhbTKiXdmSFgxFcUSRLyB6W+G6WqqVmizeayIFFhYuG7CKTdEPKPpsJrGv4RJMKlbbLV2Ah0Lc+U=
X-Received: by 2002:a05:6214:62a:b0:67a:a714:d963 with SMTP id
 a10-20020a056214062a00b0067aa714d963mr6533435qvx.55.1703417942085; Sun, 24
 Dec 2023 03:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbDXWNbxeQEOhGW5m6bd3cLW_jnE2q6XgSpRBHzxt1GOeg@mail.gmail.com>
 <20231223053634.942784-1-wudaemon@163.com>
In-Reply-To: <20231223053634.942784-1-wudaemon@163.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 24 Dec 2023 19:38:25 +0800
Message-ID: <CALOAHbBdisp6opG5b0kt8skh9g5OKwXANTV2_0SLS54AMK-b1Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/rt: Fix rt task's sched latency statistics error
 in sched_stat_wait trace_point
To: Junwen Wu <wudaemon@163.com>
Cc: bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com, 
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 1:38=E2=80=AFPM Junwen Wu <wudaemon@163.com> wrote:
>
> >It seems DL has the same issue. Pls. also fix it in update_stats_dequeue=
_dl().
> >And add the Fixes tag in the commit log:
> >Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
> >Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched cl=
ass")
>
> ok, the PATCH v3 below is ok?
>
> Subject: [PATCH v3] sched/stats: Fix rt/dl task's sched latency statistic=
s
>  error in sched_stat_wait trace_point
>
> When enable sched_stat_wait trace_point, some rt tasks sched latency so l=
ong, like this,
> sched_stat_wait: comm=3Drcu_preempt pid=3D14 delay=3D4936139545261 [ns]
> Rt task has low latency, it must have a bug. When rt task balance off sou=
rce cpu,
> dequeue operation not update the sched_statistics, so follow update_stats=
_wait_end_fair
> update method, so do dl tasks.
>
> Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
> Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched cla=
ss")
> Signed-off-by: Junwen Wu <wudaemon@163.com>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/sched/deadline.c | 8 +++++++-
>  kernel/sched/rt.c       | 7 +++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b28114478b82..29223163ee22 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1558,10 +1558,16 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, stru=
ct sched_dl_entity *dl_se,
>                         int flags)
>  {
>         struct task_struct *p =3D dl_task_of(dl_se);
> +       struct rq *rq =3D rq_of_dl_rq(dl_rq);
>
>         if (!schedstat_enabled())
>                 return;
> -
> +       /*
> +        * Mark the end of the wait period
> +        * if dequeueing a waiting task.
> +        */
> +       if (p && (p !=3D rq->curr))
> +                update_stats_wait_end_dl(dl_rq, dl_se);
>         if ((flags & DEQUEUE_SLEEP)) {
>                 unsigned int state;
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..6a2600213991 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1360,12 +1360,19 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, stru=
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
> +        /*
> +         * Mark the end of the wait period
> +         * if dequeueing a waiting task.
> +         */
> +       if (p && (p !=3D rq->curr))
> +               update_stats_wait_end_rt(rt_rq, rt_se);
>
>         if ((flags & DEQUEUE_SLEEP) && p) {
>                 unsigned int state;
>
> --
> Best regards
>


--=20
Regards
Yafang

