Return-Path: <linux-kernel+bounces-98443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EA877A39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A1F1C20EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644521C3D;
	Mon, 11 Mar 2024 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdgcnmM0"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8917D2;
	Mon, 11 Mar 2024 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710129459; cv=none; b=hc/rfpse83pz1HfaPl/yRg3RjCSCltloXUTctJmc7iBaglhVWv44UQPNWgq867xhMgln9R3Tczv/3zP6vW71oNXCk6Zogh/QsaMAEpFnFKu5h+VUN8nbKyVgrjyUYvPllEe6u5V/qOyMsJc83LO5GGMxhWUeiMrQKP94UgowiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710129459; c=relaxed/simple;
	bh=E5DR2QAGZKW3fWpqoXgtS2AIabafQ43OF6KIow5fYZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2uepMlXon0EpmElwDNj7TVQSvD6FjtPxxBy4LqThP32T6aGWZ2j7Qht2uOPNCre8t/XtBIGxy6tYtJ+951ZHvMrPk6dnLRnywy462//KDWHI6PXKlRBLuHcfXa78nzoJqeW3pwrXk53IIz3Skk2qkUex0KyfBiygYuwkFcpxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdgcnmM0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29baaf3c018so1758630a91.0;
        Sun, 10 Mar 2024 20:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710129457; x=1710734257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5MR5N+6tV8+kHbX9z2W52LwKBRqNhKx905qdwAYtFt4=;
        b=IdgcnmM01wOt9uc03FsAhYl94nwpmJ0+XfiXOqiTCCHW+Ce5elxhs5zdpOEP4N+JZY
         U7p2c64yLc2mDEMH5V6rGjzzuovyr9KoQkoifTEy/y3Ba2IzHZ0FR4E55fkx7CIAk/+D
         XS/JXX2T6DqQJxYb8iTinF3bxqiPciiFKBJLrZp4WoMsB7hjmBmZ4TqeFVNJToiaN+/n
         ALn+YIQ9tMRgZ5BUWUJWhR6Hf8nyi34SRhyVY3/NWA/AzydH1r/UhGwgHlSX+gkjRWUN
         laGj0XSabH5b3aZb8S9VVkJ4vdTpTegI/BIcGIv+fxQbkzGC3GYTpcrehlo4W6CXS8gY
         Iihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710129457; x=1710734257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MR5N+6tV8+kHbX9z2W52LwKBRqNhKx905qdwAYtFt4=;
        b=o5OOMuxsJLW4HhXpCPmo/+/+r5V3CdnyNdi6db8Mx4o7yfJAxtEDsGIxqSxTewAAD0
         es/EOgKHUmuLEmNxFlceLIMf1mBdxDZt+wIY4cJsDVmSISJJannfuD8cRrYt0D6PD6+j
         WQYUNJ2DknBbj8b0lNxabOUg6jqRAPPkcLnOHtqVg8RrLv/62zKtQxC2rAo5AtVyDNmP
         Y43Nr/7BOC46NJZvAAiqZSgaLcldzo2ZFMT/yVY9/+9fwgMQtAjRpAemf0WhTSXExw1q
         yEAK0AoQMBmglJVCoeC/ELn+K46gC+oupDk8AZGBjT0JuzHCCVlBY26Ca9epSMSqdjdK
         ThXg==
X-Forwarded-Encrypted: i=1; AJvYcCUdlH0jFMRtfeMXpOib6JMeX3bAL105hOefGLzaH2BqhW8eBwX5wJeMgMsrd1jxyhGjNIbcLIyo528q0/segahbUb99gmbyvZQpIDDw
X-Gm-Message-State: AOJu0YzMgxskBYqPzG5OHedoVAW+Jnm2h23irR2a7uJDL+95OPTo+muG
	P1meQGDihJvUzvdjD5AvXEn59+NelNOVPN0DVJotDqk12j2wT7PpYxwX2COMiqijaFcFiqmHz+k
	/i86lX/5ukw93p40ijC65zmO9kE0=
X-Google-Smtp-Source: AGHT+IE8BJ8QeV2pCmW5/kH081A5KoEUPB1+YyDMzuNPyxTI3P2Npgayk4BVAKb2+dZfiXLHgSTFi6fJS+DT4FroFPo=
X-Received: by 2002:a17:90a:4586:b0:29b:4dfc:7c34 with SMTP id
 v6-20020a17090a458600b0029b4dfc7c34mr2900133pjg.33.1710129457333; Sun, 10 Mar
 2024 20:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311035502.7112-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20240311035502.7112-1-qiang.zhang1211@gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 11 Mar 2024 11:57:26 +0800
Message-ID: <CALm+0cXCO3L2BYHDzDkNjSrvSXdE+DB=9oeykavcqRr6=BkGTg@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Avoid rtp_irq_work triggering when the
 rcu-tasks GP is ongoing
To: paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org, 
	neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This commit generate rcu_task_gp_in_progress() to check whether
> the rcu-tasks GP is ongoing, if is ongoing, avoid trigger
> rtp_irq_work to wakeup rcu tasks kthreads in call_rcu_tasks_generic().
>
> The test results are as follows:
>
> echo call_rcu_tasks_iw_wakeup > /sys/kernel/debug/tracing/set_ftrace_filter
> echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
> insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> sleep 600
> rmmod rcutorture.ko
> echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
> echo > /sys/kernel/debug/tracing/set_ftrace_filter
>
> head /sys/kernel/debug/tracing/trace_stat/function*
>
> original: 56376  apply patch: 33521
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>

This test is based on the following environment:
runqemu nographic kvm slirp qemuparams="-smp 4 -m 2048M -drive
file=$PWD/share.img,if=virtio"  -d

Thanks
Zqiang

> original:
> ==> /sys/kernel/debug/tracing/trace_stat/function0 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   call_rcu_tasks_iw_wakeup             13217    19292.52 us     1.459 us        8.834 us
>
> ==> /sys/kernel/debug/tracing/trace_stat/function1 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   call_rcu_tasks_iw_wakeup             15146    22377.01 us     1.477 us        22.873 us
>
> ==> /sys/kernel/debug/tracing/trace_stat/function2 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   call_rcu_tasks_iw_wakeup             12561    18125.76 us     1.443 us        6.372 us
>
> ==> /sys/kernel/debug/tracing/trace_stat/function3 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   call_rcu_tasks_iw_wakeup             15452    21770.57 us     1.408 us        6.710 us
>
> apply patch:
> ==> /sys/kernel/debug/tracing/trace_stat/function0 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   call_rcu_tasks_iw_wakeup              8334    15121.13 us     1.814 us        4.457 us
>
> ==> /sys/kernel/debug/tracing/trace_stat/function1 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   call_rcu_tasks_iw_wakeup              8355    15760.51 us     1.886 us        14.775 us
>
> ==> /sys/kernel/debug/tracing/trace_stat/function2 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   call_rcu_tasks_iw_wakeup              7219    14194.27 us     1.966 us        42.440 us
>
> ==> /sys/kernel/debug/tracing/trace_stat/function3 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   call_rcu_tasks_iw_wakeup              9613    19850.04 us     2.064 us        91.023 us
>
>  kernel/rcu/tasks.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 147b5945d67a..36c7e1d441d0 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -317,6 +317,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
>         rcuwait_wake_up(&rtp->cbs_wait);
>  }
>
> +static int rcu_task_gp_in_progress(struct rcu_tasks *rtp)
> +{
> +       return rcu_seq_state(rcu_seq_current(&rtp->tasks_gp_seq));
> +}
> +
>  // Enqueue a callback for the specified flavor of Tasks RCU.
>  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>                                    struct rcu_tasks *rtp)
> @@ -375,7 +380,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>         }
>         rcu_read_unlock();
>         /* We can't create the thread unless interrupts are enabled. */
> -       if (needwake && READ_ONCE(rtp->kthread_ptr))
> +       if (needwake && READ_ONCE(rtp->kthread_ptr) &&
> +                       !rcu_task_gp_in_progress(rtp))
>                 irq_work_queue(&rtpcp->rtp_irq_work);
>  }
>
> --
> 2.17.1
>

