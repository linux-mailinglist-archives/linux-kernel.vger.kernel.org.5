Return-Path: <linux-kernel+bounces-1301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEDF814D16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540391F24AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08993FB1D;
	Fri, 15 Dec 2023 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P7CNJ3qe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6E3FB06
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso10344601fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702657940; x=1703262740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojDU/9VN5GeC3dLaid8BphJaGimgFMHJdaFdGJs6sOs=;
        b=P7CNJ3qeJMN3y/cujteH1AaQmFBJlmmtrMGDE196bIzJU0iw7r9ozi9cDbOJNw3bnr
         A0x0Y5N++UgNZmVZva/wlFCsVBqmxTcnpgm9rZ5DLKvBDwxZZBKI6YmTXgJTDQ+JHIpc
         MN6VzFWlLnt1inypJo5fprHpFPQU2wp+3Iol8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702657940; x=1703262740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojDU/9VN5GeC3dLaid8BphJaGimgFMHJdaFdGJs6sOs=;
        b=O2vl1fncHIF+PYd3sC/Odaexn4FCCSpPEls/cUrvWDm+cXhFT8ElImKbQ9hYdXnOAU
         oa4MbZpeFf4wTZn8knH2LjCm7Aml803YZFc7Jma2TS9zOvwR1o4v83QKenY50pQ2LCVH
         hK8aVLg6xAUbi6lNdbdV8+41bAGn049UMz9meAvsc2NwauxI3kyRRG3gAaPZRxTSU+5E
         C66qN/Y/tOQ+hBsB6Tt6zyyQLuNb34SrCfzI7rbEmJijg6CoRbtFlGyPwR5rZkXynl/D
         PL7Yyg2ptmC0HFqiQNbPzKc/3yYRgGPZtGUdew9ELOfhh6y7Z4Cvb5oPIX9T/UkwOolc
         c35w==
X-Gm-Message-State: AOJu0Yz+4CSb9eVxf9+vTK51yphPXwvTo953AnLlC3HuagKTdZWEshlS
	CXRWgdhskqgnVWuC3Wc4ejkby7BrTFjweFT3xLBNjA==
X-Google-Smtp-Source: AGHT+IGY6RKV7kOjHCo00Xasu9YBIUHdxyiAoiCv3LSuwch9yvWFnkm3keeK7vWU0VlytqR7XOrQRgv4YBQrVOx/m5o=
X-Received: by 2002:a2e:be0c:0:b0:2cc:200f:4392 with SMTP id
 z12-20020a2ebe0c000000b002cc200f4392mr5299553ljq.46.1702657939891; Fri, 15
 Dec 2023 08:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203011252.233748-1-qyousef@layalina.io> <ZXhTjrTqZvMTXKtK@pc636>
 <CAEXW_YSMwmG_joipkK5W1Bdwzdjm_a3f86BijkAkAJTHOWkE0Q@mail.gmail.com> <ZXmI9zDW8KlZqQj7@pc636>
In-Reply-To: <ZXmI9zDW8KlZqQj7@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 15 Dec 2023 11:32:08 -0500
Message-ID: <CAEXW_YRdgQywfJ+A9fa1itDojPDiZ_Xc3M8n6dS=M2LHX9hSFg@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Qais Yousef <qyousef@layalina.io>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Andrea Righi <andrea.righi@canonical.com>, John Stultz <jstultz@google.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 5:35=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
[....]
> > > > +       Use rcutree.enable_rcu_lazy=3D0 to turn it off at boot time=
.
> > > > +
> > > > +config RCU_LAZY_DEFAULT_OFF
> > > > +     bool "Turn RCU lazy invocation off by default"
> > > > +     depends on RCU_LAZY
> > > > +     default n
> > > > +     help
> > > > +       Allows building the kernel with CONFIG_RCU_LAZY=3Dy yet kee=
p it default
> > > > +       off. Boot time param rcutree.enable_rcu_lazy=3D1 can be use=
d to switch
> > > > +       it back on.
> > > > +
> > > >  config RCU_DOUBLE_CHECK_CB_TIME
> > > >       bool "RCU callback-batch backup time check"
> > > >       depends on RCU_EXPERT
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 3ac3c846105f..8b7675624815 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_=
callback_t func, bool lazy_in)
> > > >  }
> > > >
> > > >  #ifdef CONFIG_RCU_LAZY
> > > > +static bool enable_rcu_lazy __read_mostly =3D !IS_ENABLED(CONFIG_R=
CU_LAZY_DEFAULT_OFF);
> > > > +module_param(enable_rcu_lazy, bool, 0444);
> > > > +
> > > >  /**
> > > >   * call_rcu_hurry() - Queue RCU callback for invocation after grac=
e period, and
> > > >   * flush all lazy callbacks (including the new one) to the main ->=
cblist while
> > > > @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rc=
u_callback_t func)
> > > >       __call_rcu_common(head, func, false);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > > +#else
> > > > +#define enable_rcu_lazy              false
> > > >  #endif
> > > >
> > > >  /**
> > > > @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > >   */
> > > >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  {
> > > > -     __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> > > > +     __call_rcu_common(head, func, enable_rcu_lazy);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(call_rcu);
> > > >
> > > I think, it makes sense. Especially for devices/systems where it is h=
ard
> > > to recompile the kernel and deploy it. For example, Google and GKI ap=
proach.
> >
> > My concerns had nothing to do with recompiling the kernel. Passing a
> > boot parameter (without a kernel compile) can just as well
> > default-disable the feature.
> >
> > I think what Qais is saying is that passing a boot parameter is itself
> > a hassle in Android (something I did not know about) because of GKI
> > etc.
> >
> That is true. Doing:
>
> echo 1 > /sys/.../enable_lazy
>
> is a way how to make it easy and flexible.

Hey Vlad, are you suggesting that the boot parameter be made to
support runtime? We can keep that for later as it may get complicated.
Qais's boot parameter is designed only for boot time.

Qais, could you resend the patch with our tags and updated description? Tha=
nks,

 - Joel

