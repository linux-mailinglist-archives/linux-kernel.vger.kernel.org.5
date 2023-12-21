Return-Path: <linux-kernel+bounces-8991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58B81BEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33333284621
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4E6651B2;
	Thu, 21 Dec 2023 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAdBEyyb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD61745EF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d41a32effso10175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703185941; x=1703790741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e90K4qZIf9yF3Qb2DxTqaVYaALzE9Tmgc/m/F56fP/Q=;
        b=HAdBEyybTFQxqBS3YjRoFdJQr9+qSTa4ylLimwgpgmXDtxW/h5aHppmcKFj+p0w2wi
         OX9lPoyHrfF7eG8bKwT5rWpW9CrbBsVJVDpjsGY7lJuBXagNlJB/PP0gYCqvC4GWMZ2E
         OXi0BXWV3E0ACzPm0p0siheBSA7vvPNhivhZxrXpUvWpE4JEBsm7zSbfCykdSL3n5wc+
         k0kK+81hP5s5Jh+zKYkAp7rjctCo9XAEDPNKHHjtGQAxfmGQpOoZ3HeFllA1oXqRbryK
         RzYeDPqu0ILwNjUlyY8yHI72wOMiz+Qs+VL79Sv8mgjAYDtNYATOR/cvXxAqfwys25e/
         DOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185941; x=1703790741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e90K4qZIf9yF3Qb2DxTqaVYaALzE9Tmgc/m/F56fP/Q=;
        b=W/wGI7+gRyAtxwo0BtK4frSvnEr4corCqhM+nW6efEBRvK6vdAM8qJKbj4vcWSvkv1
         FzJWrkawN4xzcl4XVdSv2VxYWkuoC74GxgSF8bSYgT+zNprWcXXlvF6XmDbA6Vx8iGxu
         gqTWhyidDDHO8ZfR757jOWVQff89kyEry8SuHtoQAM4g/3taxf7q+A2S6a6kjrAtiRPx
         l7zKCWzTNu/Ip2m8TgYyQCtWo/PhoULsUoTqZOIZbRPxkAcrpcjr3W03aGT1uuNQq4XF
         eHpGc8iwdtnAavvSdxzRKXM3dm4kn4mTbPkdweNzOW8saIpR2I2dM5HJsl66bUTo4WTt
         c7xg==
X-Gm-Message-State: AOJu0YykYybNv4JqljyGmXhOHV+C38Mju0bVvq1vDELZLPY9sjb3ifgf
	YAOa8mtLoQ6lz/gJuRCrYR/euYdz5WtuyO1WsYOZNlC5MXk=
X-Google-Smtp-Source: AGHT+IGPhqtiRwM3IZcQ+8DL7bHyWNW6ZXnrocUO/H4DxdqQIyYMN6oWI0COCWhIcdVy6rqFtAPqrz9Q0bm4jQZ2hVw=
X-Received: by 2002:a05:600c:3b1b:b0:40d:3f65:7e8b with SMTP id
 m27-20020a05600c3b1b00b0040d3f657e8bmr5014wms.1.1703185941456; Thu, 21 Dec
 2023 11:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-12-jstultz@google.com>
 <eee0c11e-a690-4a73-be74-3c7e7ebba8f9@arm.com>
In-Reply-To: <eee0c11e-a690-4a73-be74-3c7e7ebba8f9@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Dec 2023 11:12:09 -0800
Message-ID: <CANDhNCqWTpu4xY+Dopp3e0MHR4tQUhM0LHgwgokwSGagDqrkaQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/23] sched: Add a initial sketch of the
 find_proxy_task() function
To: Metin Kaya <metin.kaya@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 4:55=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> >
> Super-nit: s/Add a/Add an/ in commit header.

Thanks for catching that!

> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > +static inline bool task_is_blocked(struct task_struct *p)
> > +{
> > +     if (!sched_proxy_exec())
> > +             return false;
> > +
> > +     return !!p->blocked_on && p->blocked_on_state !=3D BO_RUNNABLE;
> > +}
> > +#else /* !SCHED_PROXY_EXEC */
> > +static inline bool task_is_blocked(struct task_struct *p)
> > +{
> > +     return false;
> > +}
> > +#endif /* SCHED_PROXY_EXEC */
> > +
>
> We can drop #else part, IMHO. Because sched_proxy_exec() already returns
> false in !CONFIG_SCHED_PROXY_EXEC case.

Oh, good point. That is a nice simplification.

thanks
-john

