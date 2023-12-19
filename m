Return-Path: <linux-kernel+bounces-5174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A082D81878F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351BC283766
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7235A18036;
	Tue, 19 Dec 2023 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUO8LfK5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD917758
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b9e6262fccso3113515b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702989345; x=1703594145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f362dzufuv9w4KdiRrBjnKIuy0T47SJxgT5f5p9LZdI=;
        b=WUO8LfK5TIKkB3SRu4V+cz9zehfIaDq5LW7d5xaCPxpB0qp8PSDOFqmtynA2RVCfMM
         h8xUhx7sptrOUPTduNHhG1ncadTp/dV6VEc56UiMuyWYlUIOrec8JtzXxFl7EowIP6Le
         qsqsL+tNANmq+Ffk0EItKq6v20KEmFJ8sh7flUPXuWnZP39zdUEpApMquqnJ969PsGVS
         oIgyJr7l5F67QqBWiY6zU+vk1XcMysEfZ4ZhANsbteqhma+E86RjEasl8VOO6rSeqqzW
         /APwtuo7LKhNDRRjqnjGDIlmoyV4nh4g+aBZc+98Ql2pLBg5Xyr43+IqOh4PkI7da4Yp
         R+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989345; x=1703594145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f362dzufuv9w4KdiRrBjnKIuy0T47SJxgT5f5p9LZdI=;
        b=wvZxxjWv8CTQMYBVbi/CPOZXqLJCxDB1x8tcCS5RE3ZiRKyG1P3RJQOJKf5uuW3kZF
         ZRdD3qjv3tPu4Hlnsx2fgUqJ4eLb7lTVQQN9IWEwkNAST3Sd67OyijFiYJpdkGfWFtvU
         h1d9um6vUTon6KooZeqwDdvSlqzFOX+71071K1ywGMaKdL3RcoJHiip0dEgB9r6AQSY1
         fbmDvaLXIsF16Q1QnP4QojAX/E86cbuQgSYbTtKkmkUicQ9Yil64w6iZ98ItSsUoJiB+
         tDoOEWpDxwzwdlQVZQ15tLzQnzq7td1ZgBSY9CuO/cLrQwXZEPQ0RQ1qcsDmxaaLOL4C
         yANQ==
X-Gm-Message-State: AOJu0YylsbgWZT1nLjJTi5jMZJdZ2g4OJPcH/fikY7C19ciCNW7QnKKB
	D544EmRp6hHetrAUbTY2+DvnYHnUgkWzy/ErRzM=
X-Google-Smtp-Source: AGHT+IHk/lUP+ncWd8/Ej0C3N9JnfFa/YuEwNqIWq88hkZ77gPHxM6NHvPaUzESdNmoXBxNV3jfy8BtK6f8oY3QhSxE=
X-Received: by 2002:a05:6808:1312:b0:3b8:b2c0:e30e with SMTP id
 y18-20020a056808131200b003b8b2c0e30emr22585262oiv.40.1702989345660; Tue, 19
 Dec 2023 04:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218150322.788382-1-wudaemon@163.com>
In-Reply-To: <20231218150322.788382-1-wudaemon@163.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 19 Dec 2023 20:35:09 +0800
Message-ID: <CALOAHbDY0dkohOudFL4UAK2XBn0FKe7uKLmbWUzmDeEdTq8M9w@mail.gmail.com>
Subject: Re: [PATCH v1] sched/rt: Fix rt task's sched latency statistics in
 sched_stat_wait trace_point
To: Junwen Wu <wudaemon@163.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 11:05=E2=80=AFPM Junwen Wu <wudaemon@163.com> wrote=
:
>
> When enable sched_stat_wait trace_point, some rt tasks sched latency
> so long, like this:
> sched_stat_wait: comm=3Drcu_preempt pid=3D14 delay=3D4936139545261 [ns]
> Rt task has low latency, it must have a bug. I found the reason is
> When rt task balance off source cpu, dequeue operation not update
> the sched_statistics, so follow update_stats_wait_end_fair
> update method.

Thanks for your report!

>
> Signed-off-by: Junwen Wu <wudaemon@163.com>
> ---
>  kernel/sched/rt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..c75215947c20 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1360,12 +1360,15 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, stru=
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
> +       if (p !=3D rq->curr)

This seems wrong, the rt_se might not be a task.

I think we'd better use if (!on_rt_rq(rt_se))

> +               update_stats_wait_end_rt(rt_rq, rt_se);
>
>         if ((flags & DEQUEUE_SLEEP) && p) {
>                 unsigned int state;
> --
> 2.34.1
>


--
Regards
Yafang

