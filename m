Return-Path: <linux-kernel+bounces-54699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E738F84B293
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E1C1C2378F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420E51EA71;
	Tue,  6 Feb 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+5iSl75"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC71DA24;
	Tue,  6 Feb 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215840; cv=none; b=cUsVuBdyxRaLQYkdWD8sPp64JjzSyirKoxYQeUIUBwWn/H9Y4Q4Rmf/R5yEXheLQmTpr1GlJR/tC5iBMkc3GB6J1C6o+BFxIUx/KFGxC7NOaqq4GibMS9T01u60ZBKcITM871jK89qiq/2nBPzBFf6FYPAzf/0GUVBzEmRMt+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215840; c=relaxed/simple;
	bh=3lE5E6pH72/f+iuFDA9aTxJyfp7UsDAJWw5h9DOpU3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fz1gwL/NWyl4zIy96TyglmUwaqhQLndn+5DrkH6tPWIlA5ciNZpBwvny0SQZxO1iwuHQ8w1fCkQXg0Mnx6qeyfRgQ1Srtxn5IVJIyFF4pQVP8AkQZoC3mcW6UgdIS7PKtwVqHL1XhqvSIMWx/4ehi6QClUVNpLwhRc6NnNTE0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+5iSl75; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-560037b6975so3465293a12.2;
        Tue, 06 Feb 2024 02:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707215837; x=1707820637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQwMOmCmmaMJ/1GcvQUcnA3UobAxgtc6VygznxvmbGQ=;
        b=h+5iSl75Ixokh/aW/wm+wIqpgNOFwF5lGBxIN4CUGjkgQQpE9ywcByLsVRQ5oNE7s8
         rdsWnIW7xWApTg99WCdcC3lzAEOGAWHatDrIe2PFVAYebC+L2Awl7xs+x1xXRyy7asxl
         lYvALnZ6ghiR9oMgkVWeJPMXLmW3pRvl9qq2EkMFqiW8N/1LiD80mp0Zqj5wBKC9kzij
         gqoHgRYVC59BEneGaARiI67xl/yOc4mPh+MVq8V4xeOZklruBR7MwraSYhY0Mcg5lheC
         Qf7tK92HMMiVCq4mWEln0Y07jvYNzO1vSI3+ApXLlCz6EsVrP77Oi3qOh5qbkovN+lau
         A4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215837; x=1707820637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQwMOmCmmaMJ/1GcvQUcnA3UobAxgtc6VygznxvmbGQ=;
        b=GF8LqMem6eSpsPuUr9hl89mseH4w5CpGH+TgskZvPXmCPPj61iUURAUhhhoeuDo849
         Ycri3+vuTut4JKDbbdy3IWjaV0p3jVXLPQv/6yWi6ycueZghVTzgjZxJB81xTGsvdye6
         51Ao52M2IAvV5jY/Y/Hk/dm+6V9yhiDDOI94pJJaDDhTLmD1wtxfZFH58RXvDq5MBolE
         vbMieVUvowyoWXUhWHvhHK/PZ35UJkn/zm4S7kqvabkbXIzND8+/hXT4OalG04ZWN5vC
         nVgHB559V637iF4ev5gbsQMTNJWAp+WBou743D3K77GNNkQATFLWf1AnhVxoHR/U8VcM
         Op9Q==
X-Gm-Message-State: AOJu0YxyvS9OExBbrdjJ9eYFesNPPqoYbF2weDQebBSx5FG0hmCPOoma
	6+m9y4+9W4XDi1IHDlvKxZmnTll/zxM9rnfuhwP9mEtPSkfz88huDWxQUpRIl3BQRYJ+1Xb4MAb
	+0R8siKR4p6uPClPUEoWSlibWdM8=
X-Google-Smtp-Source: AGHT+IH+udyLvwnshTKcv+3OxXDL0kC8QjwhjfTyWmxeWgGOrIkiOw5Hv07J8Qaru4//yWMprTUYC6wNF3I6NmtXOYo=
X-Received: by 2002:a05:6402:750:b0:560:5748:40bb with SMTP id
 p16-20020a056402075000b00560574840bbmr1276883edy.33.1707215836784; Tue, 06
 Feb 2024 02:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706861676-26574-1-git-send-email-zhiguo.niu@unisoc.com>
 <Zb1IxNd54z2Ib1N3@google.com> <2024020233-wildland-blouse-2f2e@gregkh>
In-Reply-To: <2024020233-wildland-blouse-2f2e@gregkh>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 6 Feb 2024 18:37:05 +0800
Message-ID: <CAHJ8P3L8A4uUwDuD5WQkDGdsOB6jWBdPFzR98mCiAh-0LtM91A@mail.gmail.com>
Subject: Re: [PATCH V3] lockdep: fix deadlock issue between lockdep and rcu
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Carlos Llamas <cmllamas@google.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>, bvanassche@acm.org, 
	peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, 
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	hongyu.jin@unisoc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Greg,

On Sat, Feb 3, 2024 at 5:36=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Feb 02, 2024 at 07:55:48PM +0000, Carlos Llamas wrote:
> > On Fri, Feb 02, 2024 at 04:14:36PM +0800, Zhiguo Niu wrote:
> > > There is a deadlock scenario between lockdep and rcu when
> > > rcu nocb feature is enabled, just as following call stack:
> > >
> > >      rcuop/x
> > > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFF817F2A8A80, val =3D ?=
)
> > > -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> > > -001|do_raw_spin_lock(lock =3D 0xFFFFFF817F2A8A80)
> > > -002|__raw_spin_lock_irqsave(inline)
> > > -002|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F2A8A80)
> > > -003|wake_nocb_gp_defer(inline)
> > > -003|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F30B680)
> > > -004|__call_rcu_common(inline)
> > > -004|call_rcu(head =3D 0xFFFFFFC082EECC28, func =3D ?)
> > > -005|call_rcu_zapped(inline)
> > > -005|free_zapped_rcu(ch =3D ?)// hold graph lock
> > > -006|rcu_do_batch(rdp =3D 0xFFFFFF817F245680)
> > > -007|nocb_cb_wait(inline)
> > > -007|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F245680)
> > > -008|kthread(_create =3D 0xFFFFFF80803122C0)
> > > -009|ret_from_fork(asm)
> > >
> > >      rcuop/y
> > > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFFC08291BBC8, val =3D 0=
)
> > > -001|queued_spin_lock()
> > > -001|lockdep_lock()
> > > -001|graph_lock() // try to hold graph lock
> > > -002|lookup_chain_cache_add()
> > > -002|validate_chain()
> > > -003|lock_acquire
> > > -004|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F211D80)
> > > -005|lock_timer_base(inline)
> > > -006|mod_timer(inline)
> > > -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> > > -006|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F2A8680)
> > > -007|__call_rcu_common(inline)
> > > -007|call_rcu(head =3D 0xFFFFFFC0822E0B58, func =3D ?)
> > > -008|call_rcu_hurry(inline)
> > > -008|rcu_sync_call(inline)
> > > -008|rcu_sync_func(rhp =3D 0xFFFFFFC0822E0B58)
> > > -009|rcu_do_batch(rdp =3D 0xFFFFFF817F266680)
> > > -010|nocb_cb_wait(inline)
> > > -010|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F266680)
> > > -011|kthread(_create =3D 0xFFFFFF8080363740)
> > > -012|ret_from_fork(asm)
> > >
> > > rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread=
.
> > > This patch release the graph lock before lockdep call_rcu.
> > >
> > > Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no =
longer in use")
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: Carlos Llamas <cmllamas@google.com>
> > > Cc: Bart Van Assche <bvanassche@acm.org>
> > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > ---
> > > changes of v3: correct code comments and add Cc tag.
> > > changes of v2: update patch according to Boqun's suggestions.
> > > ---
> >
> > It seems v3 should have collected the review tags from Boqun and Waiman=
.
> > Also, I'm actually Cc'ing stable here. I hope that is enough.
> > FWIW, this looks fine to me.
> >
> > Reviewed-by: Carlos Llamas <cmllamas@google.com>
>
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

I see that many commits in mainline use Cc: <stable@vger.kernel.org>
directly without other information,
and I also find this information from above link: "Note, such tagging
is unnecessary if the stable team can
derive the appropriate versions from Fixes: tags."

In addition, this fixed commit "a0b0fd53e1e6 ("locking/lockdep: Free
lock classes that are no longer in use")"
was committed in 2019, so I am not very sure which start version
should be added to stabe tag.
Do you have any good suggestions?
thanks!

