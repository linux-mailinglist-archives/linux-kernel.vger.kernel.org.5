Return-Path: <linux-kernel+bounces-25231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961182CABF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D599C282A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4715C9;
	Sat, 13 Jan 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo2He0Sl"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837EF539E;
	Sat, 13 Jan 2024 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf2306c1b4so2329278a12.1;
        Sat, 13 Jan 2024 01:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705137597; x=1705742397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6sfqb+fzZIGw3om64N3dJXyfe4oJMfslxh9iArfXFow=;
        b=Xo2He0SlX2dq9PArla/YxqONxUFsRfuJcbZfYz/9Vhc0Tq/bsSEAm0y53nT3kfnEq4
         NdtEUqJPryuOu3jDg7G0Qc9XfN2oMf63tUrTGZDV3xa4Fx2N0lndaR4RxPG8M17HXgOW
         ff/WddLcC62hfqN5Gfvlnndw44vL4RYWAbnj85BQT3PZSCsgMePJw8ShBNmw6SBQUyvO
         8Q8W61ZGZpcRe7UVA12Cn1a3IROyoEzIGeJeLkhTLL4rXAADIvMw81Hq4x3SzzsUSn5N
         pKmGc8s5h/pjbIYGxsaeCAqWPyLGC9Q+oqcUWDIv7Vu2gKf5aLzyESKS2KfwMrtrR0Rx
         zaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705137597; x=1705742397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sfqb+fzZIGw3om64N3dJXyfe4oJMfslxh9iArfXFow=;
        b=bIW6XzcH3/dPD2xSKiFrAquyi/MktFa2TI4hHyPMKcWG6AxD4iskDX3u+U8IUOb0A4
         utwne9QJnCQ4Qjknrq0PxWVC4Pw/RUPxIfdT7tCWVuA/kMRTyZ7grdiRpbqOVoIXcWSV
         /cciMgJ6+6IdydpE3fhCe7+2sxRN37k5hAgYDvj5mXGvx0BB5IcDj6maUUNECmGgcCXr
         D1i0hPQvRSy9P7vOmhte1XDrRcGZOm67scKZiC5rQgR8WiTa+VJcbPBF8QWKMWeRdCnD
         Rin6TmAD2jwDhj8gK6mkxzIwjHMKcxZk11r9esJukcGwUJJ8MmiS4FQYxbICsF8JYJGK
         wrwQ==
X-Gm-Message-State: AOJu0Yz9bqOpYNjKaW0A2BdF0g9Jyof3Mo7RRmqthBKbkxoJiRbPxLbv
	nT9FQ7Spxya7AAotysGUARVyv1PiM5bm9+qL6M0=
X-Google-Smtp-Source: AGHT+IEaFDSkR1r08ImLaaFnxKqj5iDc7NPeaL2eaaGyC7i9ou78NE2z70aqDpsq2/yZzoHa3OHNeZU82zkcohUF+RA=
X-Received: by 2002:a17:903:48b:b0:1d2:eb05:9d05 with SMTP id
 jj11-20020a170903048b00b001d2eb059d05mr2257946plb.90.1705137596847; Sat, 13
 Jan 2024 01:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104162510.72773-1-urezki@gmail.com> <20240104162510.72773-5-urezki@gmail.com>
In-Reply-To: <20240104162510.72773-5-urezki@gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Sat, 13 Jan 2024 17:19:45 +0800
Message-ID: <CALm+0cUM=5bg0eKQ4D-mm7ZaAnQbf+2NjetUYnqHOLq5uR0w5g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] rcu: Support direct wake-up of synchronize_rcu() users
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Hillf Danton <hdanton@sina.com>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> This patch introduces a small enhancement which allows to do a
> direct wake-up of synchronize_rcu() callers. It occurs after a
> completion of grace period, thus by the gp-kthread.
>
> Number of clients is limited by the hard-coded maximum allowed
> threshold. The remaining part, if still exists is deferred to
> a main worker.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 31 +++++++++++++++++++++++++++++--
>  kernel/rcu/tree.h |  6 ++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 88a47a6a658e..96fe9cc122ca 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1642,7 +1642,8 @@ static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
>   */
>  static void rcu_sr_normal_gp_cleanup(void)
>  {
> -       struct llist_node *wait_tail;
> +       struct llist_node *wait_tail, *next, *rcu;
> +       int done = 0;
>
>         wait_tail = rcu_state.srs_wait_tail;
>         if (wait_tail == NULL)
> @@ -1650,12 +1651,38 @@ static void rcu_sr_normal_gp_cleanup(void)
>
>         rcu_state.srs_wait_tail = NULL;
>         ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
> +       WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> +
> +       /*
> +        * Process (a) and (d) cases. See an illustration. Apart of
> +        * that it handles the scenario when all clients are done,
> +        * wait-head is released if last. The worker is not kicked.
> +        */
> +       llist_for_each_safe(rcu, next, wait_tail->next) {
> +               if (rcu_sr_is_wait_head(rcu)) {
> +                       if (!rcu->next) {
> +                               rcu_sr_put_wait_head(rcu);
> +                               wait_tail->next = NULL;
> +                       } else {
> +                               wait_tail->next = rcu;
> +                       }
> +
> +                       break;
> +               }
> +
> +               rcu_sr_normal_complete(rcu);
> +               // It can be last, update a next on this step.
> +               wait_tail->next = next;
> +
> +               if (++done == SR_MAX_USERS_WAKE_FROM_GP)
> +                       break;
> +       }
>
>         // concurrent sr_normal_gp_cleanup work might observe this update.
>         smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>         ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>
> -       if (wait_tail)
> +       if (wait_tail->next)
>                 queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
>

I'm testing these patches :) , one question is as follows:
Can we use (WQ_MEM_RECLAIM | WQ_HIGHPR)type of workqueue to perform
wake-up actions? avoid kworker creation failure under memory pressure, causing
the wake-up action to be delayed.

Thanks
Zqiang



>  }
>
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 4c35d7d37647..5d8b71a1caec 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -316,6 +316,12 @@ do {                                                                       \
>         __set_current_state(TASK_RUNNING);                              \
>  } while (0)
>
> +/*
> + * A max threshold for synchronize_rcu() users which are
> + * awaken directly by the rcu_gp_kthread(). Left part is
> + * deferred to the main worker.
> + */
> +#define SR_MAX_USERS_WAKE_FROM_GP 5
>  #define SR_NORMAL_GP_WAIT_HEAD_MAX 5
>
>  struct sr_wait_node {
> --
> 2.39.2
>
>

