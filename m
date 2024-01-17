Return-Path: <linux-kernel+bounces-28518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87BC82FF99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353E0284EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD5663A5;
	Wed, 17 Jan 2024 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUsYAted"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C7522D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 04:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705466140; cv=none; b=mUM+YGJD/L0TM3vBUaxT3HfPb+grCuX7xu5Y16BWZVW0P3U0nRM/hyiaKAvKbkYCEPsErmtlApFrofEQ0jIQfeF0640ombUNkJF4n8mZgbPZkbVO/I6njbiKQ2Dqv2vAqMUsjGxdmQWYIVQPNFLcC1MgYLk7oLLvdCeuNhzICCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705466140; c=relaxed/simple;
	bh=Pu8u01IXY6pJPHQ3XhbDclswORXCg7XEQZaICGvCcbs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=agR/1CQYTwPqWrSwBWR5Kf/SDIDVxhn6ymnJUsjAqLFc8zMiNqsezfy2r7LEPF3PcJZtP39Ch1UDVWW01TDL6deIBvmK0VPqWTrk5MGqg1ucXuNq7n4VswSMci1+3sFoxls0lf2dAZIiMO0IT6B/wEGcraVZdQyLhHAVFydKw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUsYAted; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dd8cba736aso7222834a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705466137; x=1706070937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dFuHFZVYuk7Mdu07FG08RIHpzXQ0sDf8nhEBRImWd4=;
        b=JUsYAtedKdrXI5Joo9I4zlRb2oWbSJXOs2Vj0zXU/UpGq194zU25AMZl/yyjIPW0Wk
         YnZfIKTaUA8TW9vnaEO0ztytSpLD05WKFoWt/WWlLUDhGnJb1ibsBC6GQ9SdMNmUo+qq
         CvjCEjhIG+WXvSWGWEjGQca9zfaekQKTdQGp7IyIPc9E7nEUSM6V6BSfwQIBPDwP5wI6
         RSaV2JjCRcUIzcqJzy3ivbThl0gCL1jnRklOUg7vBUggh0IRimc4kRKpYjh5ri0AbeKS
         pzLOAyGL2hFwVVCf/g4HXb+jViAbwDTExjjl2r1LjCdZWXSZALc8wKWa7s69f7ZZatYM
         aeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705466137; x=1706070937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dFuHFZVYuk7Mdu07FG08RIHpzXQ0sDf8nhEBRImWd4=;
        b=EZ5g6hudrQgC5uOjChvNvXt1ZfBHTJ8TrVGz6Ii2za6orZYsIGV8i0vETtGn9Qp8gT
         bqnuWtPqRoGQT6R5xn1Is1D9MOHI6TXrDw+J1VfdVDBR+01IKJWnGhrEEw9YdhPrJy/Q
         ssahpkg0kmm51V+etFC8DdFJy6bVI+z0w35E696nRMB984LwTTzD+YlSqLEL+EH7eEad
         7t31HosgWFVdd5mM6XTtCHFeh1m2TkdeR21/M32WCFhkF90/UJJH5TG7WA+1lg9LKc+l
         e2d7tSshCQxu7FLB7TtlLYnchl+wD5WtTcYIuwxUmf0RV/HOhzgfGt6EZSnwWWLjxrbm
         nXLA==
X-Gm-Message-State: AOJu0YzMAzewZQ2BNXJ7rs/fW5+Q1pZi/VduVGvS/iruztYOgaKM6LC8
	GvVIS1gNnsZUxvuE9BHTpILaHyepzOxM+k/hvBs=
X-Google-Smtp-Source: AGHT+IEOMFA97jD2L08n9c8Os4/NXjrzXz5sp7pD0UtH0ncT+6ulSPn+WirZ9VUyPZEx5LOO4iRExvtU94Tmzdd/qPA=
X-Received: by 2002:a05:6871:79a5:b0:204:1590:2044 with SMTP id
 pb37-20020a05687179a500b0020415902044mr11483423oac.5.1705466137324; Tue, 16
 Jan 2024 20:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705308796-13547-1-git-send-email-zhiguo.niu@unisoc.com> <ZabBHHwZd70IDDxP@boqun-archlinux>
In-Reply-To: <ZabBHHwZd70IDDxP@boqun-archlinux>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 17 Jan 2024 12:35:26 +0800
Message-ID: <CAB8ipk--3-+K2bhQS_YMTgpxCkZRbX21Lv_x-nT298yx5YTJeg@mail.gmail.com>
Subject: Re: [PATCH] lockdep: fix deadlock issue between lockdep and rcu
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, ke.wang@unisoc.com, xuewen.yan@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:47=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Jan 15, 2024 at 04:53:16PM +0800, Zhiguo Niu wrote:
> > There is a deadlock scenario between lockdep and rcu when
> > rcu nocb feature is enabled, just as following call stack:
> >
> >      rcuop/x
> > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFF817F2A8A80, val =3D ?)
> > -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> > -001|do_raw_spin_lock(lock =3D 0xFFFFFF817F2A8A80)
> > -002|__raw_spin_lock_irqsave(inline)
> > -002|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F2A8A80)
> > -003|wake_nocb_gp_defer(inline)
> > -003|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F30B680)
> > -004|__call_rcu_common(inline)
> > -004|call_rcu(head =3D 0xFFFFFFC082EECC28, func =3D ?)
> > -005|call_rcu_zapped(inline)
> > -005|free_zapped_rcu(ch =3D ?)// hold graph lock
> > -006|rcu_do_batch(rdp =3D 0xFFFFFF817F245680)
> > -007|nocb_cb_wait(inline)
> > -007|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F245680)
> > -008|kthread(_create =3D 0xFFFFFF80803122C0)
> > -009|ret_from_fork(asm)
> >
> >      rcuop/y
> > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFFC08291BBC8, val =3D 0)
> > -001|queued_spin_lock()
> > -001|lockdep_lock()
> > -001|graph_lock() // try to hold graph lock
> > -002|lookup_chain_cache_add()
> > -002|validate_chain()
> > -003|lock_acquire
> > -004|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F211D80)
> > -005|lock_timer_base(inline)
> > -006|mod_timer(inline)
> > -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> > -006|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F2A8680)
> > -007|__call_rcu_common(inline)
> > -007|call_rcu(head =3D 0xFFFFFFC0822E0B58, func =3D ?)
> > -008|call_rcu_hurry(inline)
> > -008|rcu_sync_call(inline)
> > -008|rcu_sync_func(rhp =3D 0xFFFFFFC0822E0B58)
> > -009|rcu_do_batch(rdp =3D 0xFFFFFF817F266680)
> > -010|nocb_cb_wait(inline)
> > -010|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F266680)
> > -011|kthread(_create =3D 0xFFFFFF8080363740)
> > -012|ret_from_fork(asm)
> >
> > rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> >
>
> Nice! Looks like you find the root cause ;-) nocb_gp_lock and graph_lock
> have an ABBA deadlock due to lockdep's dependency on RCU. I assume this
> actually fixes the problem you saw?
>
> However, I want to suggest a different fix, please see below:
>
> > This patch release the graph lock before lockdep call_rcu.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/locking/lockdep.c | 38 +++++++++++++++++++++++++-------------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 151bd3d..c1d432a 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -6186,23 +6186,29 @@ static struct pending_free *get_pending_free(vo=
id)
> >  /*
> >   * Schedule an RCU callback if no RCU callback is pending. Must be cal=
led with
> >   * the graph lock held.
> > + *
> > + * Return true if graph lock need be released by the caller, otherwise=
 false
> > + * means graph lock is released by itself.
> >   */
> > -static void call_rcu_zapped(struct pending_free *pf)
> > +static bool call_rcu_zapped(struct pending_free *pf)
> >  {
> >       WARN_ON_ONCE(inside_selftest());
> >
> >       if (list_empty(&pf->zapped))
> > -             return;
> > +             return true;
> >
> >       if (delayed_free.scheduled)
> > -             return;
> > +             return true;
> >
> >       delayed_free.scheduled =3D true;
> >
> >       WARN_ON_ONCE(delayed_free.pf + delayed_free.index !=3D pf);
> >       delayed_free.index ^=3D 1;
> >
> > +     lockdep_unlock();
> >       call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > +
> > +     return false;
> >  }
> >
> >  /* The caller must hold the graph lock. May be called from RCU context=
 */
> > @@ -6228,6 +6234,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
> >  {
> >       struct pending_free *pf;
> >       unsigned long flags;
> > +     bool need_unlock;
> >
> >       if (WARN_ON_ONCE(ch !=3D &delayed_free.rcu_head))
> >               return;
> > @@ -6243,9 +6250,9 @@ static void free_zapped_rcu(struct rcu_head *ch)
> >       /*
> >        * If there's anything on the open list, close and start a new ca=
llback.
> >        */
> > -     call_rcu_zapped(delayed_free.pf + delayed_free.index);
> > -
> > -     lockdep_unlock();
> > +     need_unlock =3D call_rcu_zapped(delayed_free.pf + delayed_free.in=
dex);
> > +     if (need_unlock)
> > +             lockdep_unlock();
>
> Instead of returning a bool to control the unlock, I think it's better
> that we refactor the call_rcu_zapped() a bit, so it becomes a
> prepare_call_rcu_zapped():
>
>         // See if we need to queue an RCU callback, must called with
>         // the lockdep lock held, returns false if either we don't have
>         // any pending free or the callback is already scheduled.
>         // Otherwise, a call_rcu() must follow this function call.
>         static bool prepare_call_rcu_zapped(struct pending_free *pf)
>         {
>                 WARN_ON_ONCE(inside_selftest());
>
>                 if (list_empty(&pf->zapped))
>                         return false;
>
>                 if (delayed_free.scheduled)
>                         return false;
>
>                 delayed_free.scheduled =3D true;
>
>                 WARN_ON_ONCE(delayed_free.pf + delayed_free.index !=3D pf=
);
>                 delayed_free.index ^=3D 1;
>
>                 return true;
>         }
>
> , and here we can:
>
>         <lockdep_lock() is called previous>
>         need_callback =3D prepare_call_rcu_zapped(...);
>         lockdep_unlock();
>         raw_local_irq_restore(flags);
>
>         if (need_callback)
>                 call_rcu(&delayed_free.rcu_head, free_zapped_rcu);

Would there be any problems if call_rcu is placed outside the shutdown
interrupt?

>
> compared to your fix, we don't have a special logic where
> call_rcu_zapped() can be an unlock in some conditions, which prevents
> local correctness reasoning.
>
> Thoughts?
>
> Regards,
> Boqun
>
> >       raw_local_irq_restore(flags);
> >  }
> >
> [...]
>

