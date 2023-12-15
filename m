Return-Path: <linux-kernel+bounces-1791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 657828153F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5836B20EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C52B5F844;
	Fri, 15 Dec 2023 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OAbuHoNq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9725F843
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c9f559b82cso11704411fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702680489; x=1703285289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIWED5BaLhRY/GkvDBwpljGf7EHBV+YYams2Uza/KBE=;
        b=OAbuHoNqA5zSlwKqAHuhhVkJ7izLcQgTNc0Cnt8hGgjACBp0FZfNoRQxU3F9KWRTZB
         CyD4tChU3sKJuRMJyQCruY6cl3s8zIoTjAII9EvftYvzLg8Gvwj7rzJKeWI+X6+VEZt5
         46jBvvVRbP2rKXHabI8olFl2sSrnV1h0RnFeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702680489; x=1703285289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIWED5BaLhRY/GkvDBwpljGf7EHBV+YYams2Uza/KBE=;
        b=rTtiVbBcMx832tiTobTB7God5NvjLtzgZvOiRMTsntlaAcqS+e46Yt54Pto2QDD+SL
         7+I/Si059JEk3A1LLpN31jdOFfBUbzpIq2v3Kb999rtGDmiwLIZf57xcM9q4crqk+Swg
         SrAQFF+d5Ei93BC20uFrD5qZuESfaJkb/OtFu0Hu4yFid+euzfDSHvnHr5sNkd5JHGS7
         QH81apwhWTwEg9RaKpnw6kafN6bskLXXygVtDpot2y2okFJYTEp0ByvwmXMvPF1ovSwf
         /XQPDOi5HfRkd0JPegwVfW5di6EmeiHetL/dLfBDdlOGX1LdMC6CiqzN6GaX8+TxF0Or
         iECg==
X-Gm-Message-State: AOJu0YwQ6Y3PV3LUEm9L/s1QlxTDnukHSBU+gT50ZoPU7lSInbzZMRlY
	O8urWTsuJfnHygkXvxRf9hcKCew0TDqjqSrIHeDX7Q==
X-Google-Smtp-Source: AGHT+IHJMNOxbb+3vlrV0p0QacQeSsk+1FtOZ4roLmHJ01KF4ncPe0O23RCUgig7taxPkZtzOKUIZ14L3QdbWytPKhM=
X-Received: by 2002:a05:651c:151:b0:2cc:430a:a3c6 with SMTP id
 c17-20020a05651c015100b002cc430aa3c6mr1541241ljd.77.1702680488844; Fri, 15
 Dec 2023 14:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203011252.233748-1-qyousef@layalina.io> <ZXhTjrTqZvMTXKtK@pc636>
 <CAEXW_YSMwmG_joipkK5W1Bdwzdjm_a3f86BijkAkAJTHOWkE0Q@mail.gmail.com>
 <ZXmI9zDW8KlZqQj7@pc636> <CAEXW_YRdgQywfJ+A9fa1itDojPDiZ_Xc3M8n6dS=M2LHX9hSFg@mail.gmail.com>
 <ZXyFz1BD6Nh1zsnc@pc636> <f1a6e96e-43d7-4872-9db5-c43bc767bf9e@paulmck-laptop>
In-Reply-To: <f1a6e96e-43d7-4872-9db5-c43bc767bf9e@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 15 Dec 2023 17:47:57 -0500
Message-ID: <CAEXW_YRcYvhpXXWYCb+_W9rB-0tFqXDgNUtR8+Ug=P4iOt7JBQ@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
To: paulmck@kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>, Qais Yousef <qyousef@layalina.io>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Andrea Righi <andrea.righi@canonical.com>, John Stultz <jstultz@google.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:46=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Dec 15, 2023 at 05:58:55PM +0100, Uladzislau Rezki wrote:
> > Hello, Joel!
> >
> > > [....]
> > > > > > > +       Use rcutree.enable_rcu_lazy=3D0 to turn it off at boo=
t time.
> > > > > > > +
> > > > > > > +config RCU_LAZY_DEFAULT_OFF
> > > > > > > +     bool "Turn RCU lazy invocation off by default"
> > > > > > > +     depends on RCU_LAZY
> > > > > > > +     default n
> > > > > > > +     help
> > > > > > > +       Allows building the kernel with CONFIG_RCU_LAZY=3Dy y=
et keep it default
> > > > > > > +       off. Boot time param rcutree.enable_rcu_lazy=3D1 can =
be used to switch
> > > > > > > +       it back on.
> > > > > > > +
> > > > > > >  config RCU_DOUBLE_CHECK_CB_TIME
> > > > > > >       bool "RCU callback-batch backup time check"
> > > > > > >       depends on RCU_EXPERT
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index 3ac3c846105f..8b7675624815 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head=
, rcu_callback_t func, bool lazy_in)
> > > > > > >  }
> > > > > > >
> > > > > > >  #ifdef CONFIG_RCU_LAZY
> > > > > > > +static bool enable_rcu_lazy __read_mostly =3D !IS_ENABLED(CO=
NFIG_RCU_LAZY_DEFAULT_OFF);
> > > > > > > +module_param(enable_rcu_lazy, bool, 0444);
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * call_rcu_hurry() - Queue RCU callback for invocation afte=
r grace period, and
> > > > > > >   * flush all lazy callbacks (including the new one) to the m=
ain ->cblist while
> > > > > > > @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *he=
ad, rcu_callback_t func)
> > > > > > >       __call_rcu_common(head, func, false);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > > > > > +#else
> > > > > > > +#define enable_rcu_lazy              false
> > > > > > >  #endif
> > > > > > >
> > > > > > >  /**
> > > > > > > @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > > > > >   */
> > > > > > >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > > > >  {
> > > > > > > -     __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZ=
Y));
> > > > > > > +     __call_rcu_common(head, func, enable_rcu_lazy);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(call_rcu);
> > > > > > >
> > > > > > I think, it makes sense. Especially for devices/systems where i=
t is hard
> > > > > > to recompile the kernel and deploy it. For example, Google and =
GKI approach.
> > > > >
> > > > > My concerns had nothing to do with recompiling the kernel. Passin=
g a
> > > > > boot parameter (without a kernel compile) can just as well
> > > > > default-disable the feature.
> > > > >
> > > > > I think what Qais is saying is that passing a boot parameter is i=
tself
> > > > > a hassle in Android (something I did not know about) because of G=
KI
> > > > > etc.
> > > > >
> > > > That is true. Doing:
> > > >
> > > > echo 1 > /sys/.../enable_lazy
> > > >
> > > > is a way how to make it easy and flexible.
> > >
> > > Hey Vlad, are you suggesting that the boot parameter be made to
> > > support runtime? We can keep that for later as it may get complicated=
.
> > > Qais's boot parameter is designed only for boot time.
> > >
> > No problem. Yes, i meant a runtime one. But as you stated there might
> > be hidden issues witch we are not aware of yet.
>
> My current thought is that Qais's version currently in -rcu for
> the merge window after next (v6.9) suits our current situation.
> But if we are eventually able to support runtime changes to this new
> rcutree.enable_rcu_lazy module parameter via simplification to the
> rcu_nocb_try_bypass() function (or maybe a better analysis of it),
> then at that point it would be good to allow this module parameter to
> be changed via sysfs at runtime.

Yes, that's right.

> Does that make sense, or am I missing some aspect or use case?

No you are not missing anything.

Thanks.

