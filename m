Return-Path: <linux-kernel+bounces-89814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033A86F604
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20641F21A7C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFF6BB3E;
	Sun,  3 Mar 2024 16:11:20 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8069E08;
	Sun,  3 Mar 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709482279; cv=none; b=QHSemGjagMfJ7lejCPmI4p7IMo1yAYHx7FmJP0T3HTN96gFzbNRQVNmq9zL/JdpFtCYhFwzUwpugHw064BmJBsCA+Wx3VL0gJMX0bCbhzCS5W9oggOeJksY+qLOcmWtlvnaUj/06/ApnTrGqprR9V+iMgAPOJ3mJIeX1VfTgz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709482279; c=relaxed/simple;
	bh=QvEtrdlYIYZjdD7RzpqyWpmTMSYBhgTq9HB8V56Vbvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3dF0YsxntrzVpc/X6ICNxTYPkYIWhhSy19p/nXSQ6IdvIYmo6d+0QYn1XDx8SCxU3PbpH18Zlp6tS8Xa2WihEHLOcat+2RffoObgzhHA+BgYVTMhx1v15Euq6JALa86RWK54yctsrmwF0tjk7oHUs49IAI4GLZvDvZbFjOUBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22034c323a3so1871372fac.0;
        Sun, 03 Mar 2024 08:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709482276; x=1710087076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpYeZIYDjOTNBHhnHMM1ZX731nmJnhY6r1aOvNDc+9s=;
        b=eTVN2hD/7C+z5dwzEFRZWphPh+NKVyBbSNQxj1n5xKNuR+/O2Eiqu20u0cHaLH5Vc/
         KEJmFO60IsepYCRB+r33MGPe8KoV+Ccm6a3jS0RbDJZo4zqo6eS326nYwZAwDoxKxI9T
         FaEUemlLIPTZSAWBtD6q2QqLY5WkOj7U3jzECajqwSGNeMJIzdiWSLw9/Lm1YSJGf4RA
         OpaSbN5gm6BsmFt2UWkYIo2jGQaKQ7HZenuzm15eVizDXKrk71sTa9Y5kDW5HYM/lZqo
         Tg+mnb6CTwATgjxDdPtsVX+V2DH6DQci9o9i8k0gjJAf62nyqRctaHKgkzIOWUTaICGl
         E/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV1Iq68UHq94Gt1VJ+DRJkPZEXnW5uFQyiVu/ZeLydkgJTQ59Oe6yYzJCyDsVIxR2HxiPTWhCXb8my52d2lZ2fys8sLCiKofy+CLI7/P6p3v7wrCm9LB99VndfSDL5S8VJhxQltt6M3phkPSKUxeunLNHd/ANnzN2YwPT7Rg6SLMNL
X-Gm-Message-State: AOJu0YzQonC8hDZzHMNqsSgYP9bvtbSLUjm2yYZvJVOSu1kz+zlZ8P9b
	swncnAYzEOWcjpwpU7cbqeLbGLcrQbNoGoqZ0KprA7VVbBT3yeBIMK6ETBAGGsM=
X-Google-Smtp-Source: AGHT+IGdc2fsFA7Ak0HYPEgmHCep7mGiBEu0yfDED0QMQag2vENbD//HJf5G0h3vs6i6wPXmR0oAvg==
X-Received: by 2002:a05:6871:7412:b0:21f:d862:2ad7 with SMTP id nw18-20020a056871741200b0021fd8622ad7mr8071533oac.5.1709482275613;
        Sun, 03 Mar 2024 08:11:15 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id lt10-20020a05687142ca00b0021a70aa7cedsm2055405oab.34.2024.03.03.08.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 08:11:15 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e432514155so2064257a34.1;
        Sun, 03 Mar 2024 08:11:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGeaM/qul2ckNDHs7SdNedOAkjAZ521FT3HZE2FckQ3PyQTuL1ia4DYa14JxDu2goX9rug5ccNCbxRaGwoYtR0a+GQmHVcF+LkyJQqXh1/4vS5YWdxMW+DSoPT0nV9ufohT6cMNpnCl42brv9mX7KUKk++xxozUW7/mTDOM8qZsIJu
X-Received: by 2002:a05:6808:1690:b0:3c1:8498:239b with SMTP id
 bb16-20020a056808169000b003c18498239bmr8548891oib.59.1709482275070; Sun, 03
 Mar 2024 08:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c395b02613572131568bc1fd1bc456d20d1a5426.1709325647.git.geert+renesas@glider.be>
 <87fe0004-0e53-4b7a-b19d-c6b37c8db8dc@redhat.com>
In-Reply-To: <87fe0004-0e53-4b7a-b19d-c6b37c8db8dc@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 3 Mar 2024 17:11:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX+mpc5++8h4oM98FTPAdV-c8TzscTQA095Wzssae6amg@mail.gmail.com>
Message-ID: <CAMuHMdX+mpc5++8h4oM98FTPAdV-c8TzscTQA095Wzssae6amg@mail.gmail.com>
Subject: Re: [PATCH/RFC] locking/spinlocks: Make __raw_* lock ops static
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Waiman,

CC s390

On Sun, Mar 3, 2024 at 5:25=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
> On 3/1/24 15:43, Geert Uytterhoeven wrote:
> > sh/sdk7786_defconfig (CONFIG_GENERIC_LOCKBREAK=3Dy and
> > CONFIG_DEBUG_LOCK_ALLOC=3Dn):
> >
> > kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__=
raw_spin_lock' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__=
raw_spin_lock_irqsave' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__=
raw_spin_lock_irq' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:103:17: warning: no previous prototype for '_=
_raw_spin_lock_bh' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__=
raw_read_lock' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__=
raw_read_lock_irqsave' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__=
raw_read_lock_irq' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:103:17: warning: no previous prototype for '_=
_raw_read_lock_bh' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__=
raw_write_lock' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__=
raw_write_lock_irqsave' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__=
raw_write_lock_irq' [-Wmissing-prototypes]
> > kernel/locking/spinlock.c:103:17: warning: no previous prototype for '_=
_raw_write_lock_bh' [-Wmissing-prototypes]
> >
> > Fix this by making the __raw_* lock ops static.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Compile-tested only.
> >
> > Is SH really the only SMP platform where CONFIG_GENERIC_LOCKBREAK=3Dy?
> > ---
> >   kernel/locking/spinlock.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
> > index 8475a0794f8c5ad2..7009b568e6255d64 100644
> > --- a/kernel/locking/spinlock.c
> > +++ b/kernel/locking/spinlock.c
> > @@ -65,7 +65,7 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
> >    * towards that other CPU that it should break the lock ASAP.
> >    */
> >   #define BUILD_LOCK_OPS(op, locktype)                                 =
       \
> > -void __lockfunc __raw_##op##_lock(locktype##_t *lock)                 =
       \
> > +static void __lockfunc __raw_##op##_lock(locktype##_t *lock)         \
> >   {                                                                   \
> >       for (;;) {                                                      \
> >               preempt_disable();                                      \
> > @@ -77,7 +77,7 @@ void __lockfunc __raw_##op##_lock(locktype##_t *lock)=
                       \
> >       }                                                               \
> >   }                                                                   \
> >                                                                       \
> > -unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)=
       \
> > +static unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t=
 *lock) \
> >   {                                                                   \
> >       unsigned long flags;                                            \
> >                                                                       \
> > @@ -95,12 +95,12 @@ unsigned long __lockfunc __raw_##op##_lock_irqsave(=
locktype##_t *lock)    \
> >       return flags;                                                   \
> >   }                                                                   \
> >                                                                       \
> > -void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)            \
> > +static void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)     \
> >   {                                                                   \
> >       _raw_##op##_lock_irqsave(lock);                                 \
> >   }                                                                   \
> >                                                                       \
> > -void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)             \
> > +static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)       =
       \
> >   {                                                                   \
> >       unsigned long flags;                                            \
> >                                                                       \
>
> This may not work if CONFIG_GENERIC_LOCKBREAK is defined. We had been

sdk7786_defconfig sets CONFIG_GENERIC_LOCKBREAK=3Dy?

FTR, I checked all defconfigs, and it's set in three of them:
  - s390/debug_defconfig
  - sh/sdk7786_defconfig
  - sh/shx3_defconfig

However, the first one has CONFIG_DEBUG_LOCK_ALLOC=3Dy, so the issue
does not trigger there (but see below).

> talking about taking out CONFIG_GENERIC_LOCKBREAK before. See the thread
> in [1]. However, we didn't proceed further at that time as we weren't
> totally sure if there were still some configurations that required
> CONFIG_GENERIC_LOCKBREAK.
>
> [1] https://lore.kernel.org/lkml/20211022120058.1031690-1-arnd@kernel.org=
/
>
> Anyway, without taking out CONFIG_GENERIC_LOCKBREAK, the proper way to
> fix this issue is probably to declare the proper function prototypes in
> include/linux/rwlock_api_smp.h and include/linux/spinlock_api_smp.h when
> CONFIG_GENERIC_LOCKBREAK is defined.

What is the point of adding function prototypes to header files if the
functions don't seem to be called outside kernel/locking/spinlock.c?
Or is that part of the breakage?

I do not have an sdk7786 or shx3, so I do not know if the kernel
actually boots/works.

The warnings are also seen with s390/debug_defconfig after changing
CONFIG_DEBUG_LOCK_ALLOC=3Dn
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dn
CONFIG_LOCK_STAT=3Dn
CONFIG_PROVE_LOCKING=3Dn
Probably that is the easiest config to test on actual hardware?

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

