Return-Path: <linux-kernel+bounces-103984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1687C770
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27D51C20F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0C6FD9;
	Fri, 15 Mar 2024 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzS9hYmU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A5323D;
	Fri, 15 Mar 2024 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469259; cv=none; b=QthW/83icp6118QcYkCPMS2KFNpzbTV9oj6ck5l3iSAgD/DoeusPZQ6J4CPyOKhwx4CQ9fkNye7FfoqepBm51SiY66HbSuXW20LEfU6tqS8xj5YJ9zll1Ho6q1bCeBrkqCvZ+ZAKRjFYlzX0N/IjNucnncubWeoJW9KwXbN/lOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469259; c=relaxed/simple;
	bh=fFwQIlb443EC36sVLwuFb4dzf0Dss+9EewZgyVbxvSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8U3K2u4+Ll57/kirI+OyoHepAd7GBvQfahIB3ff8C5muhk+/SI1HouOQ5MDyHaURi5Yt6xg37Wxwc+u7V/6Mip6FV/5cFPJ83iTg7GSJ4ccWyCVZ5yyHLwOCLtucCDJrMLP29+pDw0vln2sZgYF+V7gVhZq4eHm8/sqFH+avn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzS9hYmU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d3746950so1490803e87.1;
        Thu, 14 Mar 2024 19:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710469256; x=1711074056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKd+qVzPekK4mMOT4fBjyBHRZnbYGLNCRm2s7GZrCu4=;
        b=TzS9hYmUkGQFR25ZLGTHKG+0jEMtZi3o1NlKV1qqHElrw8KvCF5LO9ylXcsRsEuxkw
         Llh6CURnLt2xX+KcvUnYpTzLsI06mEp42xRQjGULKPNU57PO8zmCgF+z3Kkc7O4luDOi
         AaAOcbgo0bHPqaZSGAPp6BTdA7K3vEFauDXGaholbq/niAlUL2VsdxZk9fvFKn9V6/d+
         RP4b99r5PN8wGVKbUrjp6GPTlDI3xBxsSuoDfsRobf4ie+GE3ZSDqYZ+57TrgCrIJlvY
         /oTHD6anXeVkciSpE0ahIVfhu7wToQM5gtKtCiWcRtdKOzKVH23y52xwtn/oLrqwSr29
         Lo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710469256; x=1711074056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKd+qVzPekK4mMOT4fBjyBHRZnbYGLNCRm2s7GZrCu4=;
        b=mlauxnKeSz1JqntztqOOM2Q7GTju4BeuxFIAzqV8tR/eXg8pCjZvbNhEDKXMuhlOGu
         k2SRaN1yNFR/watSzSgJp1oxogd+Ijzp09wckQjfoEd3j22kyM4Rf2vxw4A0cD4z/1kJ
         26a3iobgAS+b1DrZ4HuVeVRJ3m8aAvpLbLc57QKzeglvsGd0NS4tb4IbPWTgcQggn2PR
         jEmH8xSU33tpiQm9SKgDgfBsxbbjauuwVCYrIqTzmhSlyqgRNq2frjdlmXWTKepf/5d8
         enzcY5DMZIHpDcdKNAB49l9cB0ZCVoLNxtUD7Hzowe2g9pCy6UJcxuq/eIHJwbp37OlS
         HKjg==
X-Forwarded-Encrypted: i=1; AJvYcCWDJPgf0BqznOUeSbGCa0GgaFO4+9j9GwtTOPN1kyePJaNAMtrLqV0z0LDmQQDRakpvnMj2mBj04nValc7h7iMsX47xpwG3nesV6Ek3YfhpeajtBU3mrZDIqqE+8KC4GinPzOCZsZppUpatBS0Q
X-Gm-Message-State: AOJu0YzUZQRXP0sMN+VUN2Ew7VCfeb6f3aFO65r1Rl4TnlKQWXDqWUiJ
	VyzeSWh3/g6jwR4EWe72Zd0sONpS2vYw0gIkRwRgWRtODKW0c/YhlNXwhfgqol89OWnygNdGU5U
	gLN+or4XJTXTtfL74aCzM+DFjFUQ=
X-Google-Smtp-Source: AGHT+IFtyxEzPv4XBFuqTidRTiFrLDoGQgKUC0WvFlPYV7nBfRQoPiPOY4zHRJX+f1AdECUdrpVCSeXw7pciQ+z8C6s=
X-Received: by 2002:ac2:5bcd:0:b0:513:b90f:f4dd with SMTP id
 u13-20020ac25bcd000000b00513b90ff4ddmr1307617lfn.49.1710469255711; Thu, 14
 Mar 2024 19:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
 <87cyrxm7ua.ffs@tglx> <CAAfh-jOu0hG1hfWX9kL_gOXkSLXEVGNkddP-azO=pjNAKsRGhA@mail.gmail.com>
 <877ci5m3c4.ffs@tglx> <CAAfh-jPvPhu6G6cp_NouhLAeHvLPeVj6JzPmzrL1VK+0BM78+g@mail.gmail.com>
In-Reply-To: <CAAfh-jPvPhu6G6cp_NouhLAeHvLPeVj6JzPmzrL1VK+0BM78+g@mail.gmail.com>
From: Enlin Mu <enlinmu@gmail.com>
Date: Fri, 15 Mar 2024 10:20:29 +0800
Message-ID: <CAAfh-jP7c1ythFCnLUZ4EO=prD+XHeASQWRv22XT1AS4rAxfgg@mail.gmail.com>
Subject: Re: [PATCH] hrtimer:Add get_hrtimer_cpu_base()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Enlin Mu <enlin.mu@outlook.com>, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Enlin Mu <enlinmu@gmail.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8815=E6=97=A5=E5=
=91=A8=E4=BA=94 10:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B 19:59=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Mar 14 2024 at 18:45, Enlin Mu wrote:
> > > Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=88=
14=E6=97=A5=E5=91=A8=E5=9B=9B 18:22=E5=86=99=E9=81=93=EF=BC=9A
> > >>
> > >> On Wed, Mar 13 2024 at 05:30, Enlin Mu wrote:
> > >> > From: Enlin Mu <enlin.mu@unisoc.com>
> > >> >
> > >> > On the Arm platform,arch_timer may occur irq strom,
> > >> > By using the next_timer of hrtimer_cpu_base, it is
> > >> > possible to quickly locate abnormal timers.
> > >> > As it is an out of tree modules,the function needs
> > >> > to be exproted.
> > >>
> > >> No. We are not exporting for out of tree code.
> > > Can you explain it?
> >
> > Exporting functions or variables requires an in tree usecase.
> >
> Thands, I got it.
>
> If patch is following:
> ---
>  include/linux/hrtimer.h     | 1 +
>  kernel/time/hrtimer.c       | 1 +
>  kernel/time/tick-internal.h | 1 -
>  kernel/time/timer_list.c    | 1 +
>  4 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
> index 2a37d2a8e808..a0eaed4a3edc 100644
> --- a/include/linux/hrtimer.h
> +++ b/include/linux/hrtimer.h
> @@ -278,6 +278,7 @@ static inline void hrtimer_start(struct hrtimer
> *timer, ktime_t tim,
>  extern int hrtimer_cancel(struct hrtimer *timer);
>  extern int hrtimer_try_to_cancel(struct hrtimer *timer);
>  extern struct hrtimer_cpu_base *get_hrtimer_cpu_base(int cpu);
> +DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
>
>  static inline void hrtimer_start_expires(struct hrtimer *timer,
>                                          enum hrtimer_mode mode)
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index f7cf7d48b91d..49024d07c61b 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -113,6 +113,7 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases=
) =3D
>                 },
>         }
>  };
> +EXPORT_PER_CPU_SYMBOL(hrtimer_bases);
>
>  static const int hrtimer_clock_to_base_table[MAX_CLOCKS] =3D {
>         /* Make sure we catch unsupported clockids */
> diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> index 5f2105e637bd..96df7d21506c 100644
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -18,7 +18,6 @@ struct timer_events {
>  # define TICK_DO_TIMER_NONE    -1
>  # define TICK_DO_TIMER_BOOT    -2
>
> -DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
>  extern ktime_t tick_next_period;
>  extern int tick_do_timer_cpu __read_mostly;
>
> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
> index 1c311c46da50..b6fee42e3861 100644
> --- a/kernel/time/timer_list.c
> +++ b/kernel/time/timer_list.c
> @@ -16,6 +16,7 @@
>  #include <linux/uaccess.h>
>
>  #include "tick-internal.h"
> +#include <linux/hrtimer.h>
>
>  struct timer_list_iter {
>         int cpu;
> --
>
> please review and comment.
>
> Thanks

Hi  Thomas

Sorry, I made a mistake
Please ignore this comment

