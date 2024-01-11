Return-Path: <linux-kernel+bounces-23222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878082A91E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF241F246A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C33E56B;
	Thu, 11 Jan 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GPTtM7BQ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E68814
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so8925870a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704961697; x=1705566497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiFVxTIDUu/aeYHleXLoWQUAfhWIhHlpgNu1dIu/jjU=;
        b=GPTtM7BQempNBJLdw6f/pjj7FbDut9OtxXBovgB+5RYzfJkFhqI/x3vWqXfXmcKNqA
         yvx5zD0seZ0E/4I88HW0cizmrQJBy4mGhU/Vz8ueCh6r3W55PQh2ezaUKEveWN2QfsXS
         ETmU0xezJf+oPsaWXsu3SPJOWs1VlKTLZgeM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704961697; x=1705566497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiFVxTIDUu/aeYHleXLoWQUAfhWIhHlpgNu1dIu/jjU=;
        b=gCou6Le+yF3tmiOW5mx7h6mxqQA6O9NyqQJTqFH817twUV2V7HfsQvT5p6VB/MJMsS
         FdOI78b2nTCtLK/OZqTduRvnbndbP6Q4KGAlFMeNDOtUaLOEQo2deejHf/g/xQ5Pbq5Z
         wvkljPNVpcPs3w/VebQQhHSP7EKwGugeD8rTxGxY8kxNHLwCXIHl06vbzQQABzC8Oke+
         /z2qVqztYlKAiuVlSSiqv8GvTwEAjgZNRYRurEbOCAUfhpv7sar+xbR6WwwRFSPlCtYD
         4VnJfe9w069XlwZWBdZBDLWnxoQh3+7AdMcEaATASLjgz1CHdlK/eqakrDTtdqsuVISx
         76Bw==
X-Gm-Message-State: AOJu0YyTDfLqiQLhKIZUfwUSJ/YDMt96UTrgp8R4vgEw9TGzqGMj3vni
	yM2GaTJaY934RyTi8rZ9tRD0W6zS8RdvSVsevfyBJ1i+t1tcq+nWvzpyagvL7Bk=
X-Google-Smtp-Source: AGHT+IHeBBG7o97OqeFdMJv9solBSr0kIFL7XUUiAqn+WiPFq5i0vrTRZaGB+b5lR4kWFVt+tfVWUEYSyXTzJtovrlk=
X-Received: by 2002:a05:6402:308b:b0:558:ab9e:b77e with SMTP id
 de11-20020a056402308b00b00558ab9eb77emr50055edb.15.1704961697039; Thu, 11 Jan
 2024 00:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
In-Reply-To: <20230211064527.3481754-2-jstultz@google.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 11 Jan 2024 09:28:06 +0100
Message-ID: <CAOf5uwkyKXyfu-D6=4tZ1QYiZniutozLvryo8s3Ppws18Zr-gA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael <michael@mipisi.de>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all

On Sat, Feb 11, 2023 at 7:45=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
>
> Instead of trying to handle the freezer waking up tasks from
> schedule() in nanosleep on alarmtimers explicitly, use
> TASK_FREEZABLE which marks the task freezable when it goes
> to schedule, which prevents the signal wakeup.
>
> This allows for the freezer handling to be removed, simplifying
> the code.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael <michael@mipisi.de>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: kernel-team@android.com
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1909021247250.3955@nan=
os.tec.linutronix.de/
> [jstultz: Forward ported to 6.2-rc and split out from a separate
>           fix.]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---

Is this land?

Michael

>  kernel/time/alarmtimer.c | 53 ++--------------------------------------
>  1 file changed, 2 insertions(+), 51 deletions(-)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index f7b2128f64e2..15ecde8fcc1b 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -49,14 +49,6 @@ static struct alarm_base {
>         clockid_t               base_clockid;
>  } alarm_bases[ALARM_NUMTYPE];
>
> -#if defined(CONFIG_POSIX_TIMERS) || defined(CONFIG_RTC_CLASS)
> -/* freezer information to handle clock_nanosleep triggered wakeups */
> -static enum alarmtimer_type freezer_alarmtype;
> -static ktime_t freezer_expires;
> -static ktime_t freezer_delta;
> -static DEFINE_SPINLOCK(freezer_delta_lock);
> -#endif
> -
>  #ifdef CONFIG_RTC_CLASS
>  /* rtc timer and device for setting alarm wakeups at suspend */
>  static struct rtc_timer                rtctimer;
> @@ -241,19 +233,12 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
>   */
>  static int alarmtimer_suspend(struct device *dev)
>  {
> -       ktime_t min, now, expires;
> +       ktime_t now, expires, min =3D KTIME_MAX;
>         int i, ret, type;
>         struct rtc_device *rtc;
>         unsigned long flags;
>         struct rtc_time tm;
>
> -       spin_lock_irqsave(&freezer_delta_lock, flags);
> -       min =3D freezer_delta;
> -       expires =3D freezer_expires;
> -       type =3D freezer_alarmtype;
> -       freezer_delta =3D KTIME_MAX;
> -       spin_unlock_irqrestore(&freezer_delta_lock, flags);
> -
>         rtc =3D alarmtimer_get_rtcdev();
>         /* If we have no rtcdev, just return */
>         if (!rtc)
> @@ -480,38 +465,6 @@ u64 alarm_forward_now(struct alarm *alarm, ktime_t i=
nterval)
>  EXPORT_SYMBOL_GPL(alarm_forward_now);
>
>  #ifdef CONFIG_POSIX_TIMERS
> -
> -static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type t=
ype)
> -{
> -       struct alarm_base *base;
> -       unsigned long flags;
> -       ktime_t delta;
> -
> -       switch(type) {
> -       case ALARM_REALTIME:
> -               base =3D &alarm_bases[ALARM_REALTIME];
> -               type =3D ALARM_REALTIME_FREEZER;
> -               break;
> -       case ALARM_BOOTTIME:
> -               base =3D &alarm_bases[ALARM_BOOTTIME];
> -               type =3D ALARM_BOOTTIME_FREEZER;
> -               break;
> -       default:
> -               WARN_ONCE(1, "Invalid alarm type: %d\n", type);
> -               return;
> -       }
> -
> -       delta =3D ktime_sub(absexp, base->get_ktime());
> -
> -       spin_lock_irqsave(&freezer_delta_lock, flags);
> -       if (delta < freezer_delta) {
> -               freezer_delta =3D delta;
> -               freezer_expires =3D absexp;
> -               freezer_alarmtype =3D type;
> -       }
> -       spin_unlock_irqrestore(&freezer_delta_lock, flags);
> -}
> -
>  /**
>   * clock2alarm - helper that converts from clockid to alarmtypes
>   * @clockid: clockid.
> @@ -750,7 +703,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, =
ktime_t absexp,
>         struct restart_block *restart;
>         alarm->data =3D (void *)current;
>         do {
> -               set_current_state(TASK_INTERRUPTIBLE);
> +               set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
>                 alarm_start(alarm, absexp);
>                 if (likely(alarm->data))
>                         schedule();
> @@ -765,8 +718,6 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, =
ktime_t absexp,
>         if (!alarm->data)
>                 return 0;
>
> -       if (freezing(current))
> -               alarmtimer_freezerset(absexp, type);
>         restart =3D &current->restart_block;
>         if (restart->nanosleep.type !=3D TT_NONE) {
>                 struct timespec64 rmt;
> --
> 2.39.1.581.gbfd45094c4-goog
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

