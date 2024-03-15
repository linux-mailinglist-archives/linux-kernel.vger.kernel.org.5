Return-Path: <linux-kernel+bounces-103979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E65387C75E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0094128322E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E16FA9;
	Fri, 15 Mar 2024 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdMOyAnF"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A94C8D;
	Fri, 15 Mar 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710468493; cv=none; b=IKkdvD6vltzg3ugS85Kk6YJQGZYQjZytOobRYGi0Y6jcS6ZJUQSzotY3moslpw52biH5m2G5RGcd1deEnrHAjEiYzrkeoYTRJXeGivLoEloXzcA7RiwJHDtCGBXlSf99kj3IZV/I6UbgTe3xjVrkp0IVrL0xghBSQkEQyJhwNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710468493; c=relaxed/simple;
	bh=ZZBqB3DtDkbBNdg7q+F0PFywPz5TG70Od6EhcRlRJzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obSTwvK2M6BwPfW15nh4RO3VbLevRQAwr34h7gL95nL5INhUXqBkgVAUxKMD+NeYs/lp57GYQcNUgVQxsnNXd/8oDxdrU/vCVJIvHd5x9tReTU1aKXMUOUGDgjfP2p4UUxzLijBvkR8bbRRJkyQBfRVN00SnZ11nLvvlqoUdVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdMOyAnF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d204e102a9so19658551fa.0;
        Thu, 14 Mar 2024 19:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710468489; x=1711073289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ROdH2C+nyN8nSm7KvbYrrk66P+3+G60TJGcpP9QA9Q=;
        b=OdMOyAnFYguigLVJfTGyRptlfpPCiJLAzhJj6+e9LVYXu7ALhMMkP4cBrk5UHcwobh
         sb6yBN06uHnUIhhq3qmwUJfxA1cTwJvVrLkxgdt4dV8rC+0Ie8HwIJtpLHv6xmh4NBBa
         vIxibZf+rHUc0RybxPMAo7HqvfWbKXWnZAa123QxicyEqHO/f5mUqOy+Ni5TQFY6qK8D
         r3T6u9RzD5SaEb+bKbEeBGtVOrO0nZhMIRrchVWnFouxKSH7RFc1R0/xoRaWEoaKePit
         iJMQh80pU1duPB+mReJP/CzU7jplYyqcziTrw19jF4hPHHgB7T1Mf2T6DGfZp/1xL8E6
         0TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710468489; x=1711073289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ROdH2C+nyN8nSm7KvbYrrk66P+3+G60TJGcpP9QA9Q=;
        b=Bi2SbY5xC+mfDVSD/rj31Ptsb47xFWezpQOgFt0eA0ALojZv8rhvSb2KEJyClPc6BV
         aCjnUyKvNE8ujVgTQWxgVj9PeG5byZP1nJky2DSEL1Xm3lSMQ+Z2OhK9HrOcMIgUBmSQ
         Mf5RcopVBFBr8SBZUh892q9RX7+lzr39zxWt65y56+6CGQfltFwrd9SNTk1wZIJiW/rU
         rlhjk002O1Z9pPzKVkSVY/WM+2bYWr/rCNqEVVSa6YODj4ObDsquS3p9cOCSLX9WL2pc
         kW8b67XnJJD2ACxKt9RBi9mi25HenWV5yD8hfzgI8YwCaTj+cNd+wHRMyMxQw84j09kL
         giXw==
X-Forwarded-Encrypted: i=1; AJvYcCVXwJZsaacXjMSl+gbo/dyPzKiuo6fZPsO0OBVjNv4Jr+hUlh+63bHXu+newmBErCMbv4i4ErrJClocL9kQWmCKaMnEraa4qtzBckPotk0apqx70jLAgEKmdn6dKsPz1HmbGr1noz+Gc7nbdFxR
X-Gm-Message-State: AOJu0Yw5z/ZLUMUHmNbWN+LLZ+1ZwkacJk9BFLrBZMQ4Hmw0530NWQqv
	cqendSawfEoXo35Ux9MIBAXn5uTfQ5ReuPqE6OwGUn85OG/5wsJb7I87an1fDu3jw/Ib9slKjNk
	0CAr9qXNsTXvxbIvWhsdd1qH/kmkpUHY0TGio8g==
X-Google-Smtp-Source: AGHT+IFRxSMNBLfIBXMWkSggNRNgR7JDL62JuMhQo5aTLKc3CaAOrZspTtFnC+nmgqFnH2ssQTui5JclG0syKt2P47Q=
X-Received: by 2002:a05:651c:ba5:b0:2d4:62b7:4c71 with SMTP id
 bg37-20020a05651c0ba500b002d462b74c71mr2090389ljb.31.1710468489209; Thu, 14
 Mar 2024 19:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
 <87cyrxm7ua.ffs@tglx> <CAAfh-jOu0hG1hfWX9kL_gOXkSLXEVGNkddP-azO=pjNAKsRGhA@mail.gmail.com>
 <877ci5m3c4.ffs@tglx>
In-Reply-To: <877ci5m3c4.ffs@tglx>
From: Enlin Mu <enlinmu@gmail.com>
Date: Fri, 15 Mar 2024 10:07:42 +0800
Message-ID: <CAAfh-jPvPhu6G6cp_NouhLAeHvLPeVj6JzPmzrL1VK+0BM78+g@mail.gmail.com>
Subject: Re: [PATCH] hrtimer:Add get_hrtimer_cpu_base()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Enlin Mu <enlin.mu@outlook.com>, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E5=9B=9B 19:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Mar 14 2024 at 18:45, Enlin Mu wrote:
> > Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B 18:22=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Wed, Mar 13 2024 at 05:30, Enlin Mu wrote:
> >> > From: Enlin Mu <enlin.mu@unisoc.com>
> >> >
> >> > On the Arm platform,arch_timer may occur irq strom,
> >> > By using the next_timer of hrtimer_cpu_base, it is
> >> > possible to quickly locate abnormal timers.
> >> > As it is an out of tree modules,the function needs
> >> > to be exproted.
> >>
> >> No. We are not exporting for out of tree code.
> > Can you explain it?
>
> Exporting functions or variables requires an in tree usecase.
>
Thands, I got it.

If patch is following:
---
 include/linux/hrtimer.h     | 1 +
 kernel/time/hrtimer.c       | 1 +
 kernel/time/tick-internal.h | 1 -
 kernel/time/timer_list.c    | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2a37d2a8e808..a0eaed4a3edc 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -278,6 +278,7 @@ static inline void hrtimer_start(struct hrtimer
*timer, ktime_t tim,
 extern int hrtimer_cancel(struct hrtimer *timer);
 extern int hrtimer_try_to_cancel(struct hrtimer *timer);
 extern struct hrtimer_cpu_base *get_hrtimer_cpu_base(int cpu);
+DECLARE_PER_CPU(struct tick_device, tick_cpu_device);

 static inline void hrtimer_start_expires(struct hrtimer *timer,
                                         enum hrtimer_mode mode)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f7cf7d48b91d..49024d07c61b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -113,6 +113,7 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
=3D
                },
        }
 };
+EXPORT_PER_CPU_SYMBOL(hrtimer_bases);

 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] =3D {
        /* Make sure we catch unsupported clockids */
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5f2105e637bd..96df7d21506c 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -18,7 +18,6 @@ struct timer_events {
 # define TICK_DO_TIMER_NONE    -1
 # define TICK_DO_TIMER_BOOT    -2

-DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 extern ktime_t tick_next_period;
 extern int tick_do_timer_cpu __read_mostly;

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 1c311c46da50..b6fee42e3861 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -16,6 +16,7 @@
 #include <linux/uaccess.h>

 #include "tick-internal.h"
+#include <linux/hrtimer.h>

 struct timer_list_iter {
        int cpu;
--

please review and comment.

Thanks

