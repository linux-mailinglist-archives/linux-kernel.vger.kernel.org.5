Return-Path: <linux-kernel+bounces-1343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D744F814DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FB8284306
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92FD3EA7C;
	Fri, 15 Dec 2023 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IurPGBVZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D43EA6B;
	Fri, 15 Dec 2023 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc3facf0c0so8301801fa.0;
        Fri, 15 Dec 2023 08:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702659538; x=1703264338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng6OxL3bfprBeqixlAY27bfZCnLXVb/25bFamyart8Q=;
        b=IurPGBVZyPxLwUG7oD0kRT33HeAnQ4XleFTQ/Mal2YDn4A70oD2vR7EUhLgB0EhWlL
         /3s8zaFjjFRxc27Gq8oToxxlgg+aUng2PwSsKWzbcjXQvcff//7+2AMN3ZBbMLva9r6N
         WkoXfY0g2lau3J+nbNACGc0+8zwcveXOHMIV+eKYg+YvaKciHoevz+66vLY3LQ/Oo6wC
         v73ZeW1JQrqYhs/N4Ww9s5da7RHCf9a7NFAP5N0Bs78x+pYO5xwEVrtKdlbbwiTgNW4r
         qsF74/oP1Q3kubhEroU74fXwLprQlWAqUcxgWtIQcCBkvOHfRQBhU7cKmJ9IgqJcGdCh
         cDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702659538; x=1703264338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng6OxL3bfprBeqixlAY27bfZCnLXVb/25bFamyart8Q=;
        b=tfyS9yAWsO6lMmhUP7QDlhuEj7Mtnx0LiYUCSr66LsIJbuzSYUgku6opZL37tjEp7N
         AdBDv5tPLSN2QyndyNWQDkoOiyE43ey5deb5T90zGQj9ZGq3262tBqF1Ni76U7vo3eH/
         L06t/mmCdmLINEPJHF/5Lh5rVOp48csaua4lroxythd2y3e+j2IlxXY2PFb/csI+Iz11
         fTASX25Hnk45qZp8i+/CeQkNlNN6uqzzUPn6LnQdde7baEV1MbVlPynkdV/Z0VlN5RHP
         y1+vzaXjxJhEVV/v+uyJ+rEN31xmthxw0VZmw20XS6DqXGNKyGJwmmiL+Ie4zY4iiyYP
         XsgA==
X-Gm-Message-State: AOJu0YxETCJ4pRLOeDQjwGSMxzsfhX/j/Ktll2gOzLPJxgUEIHp9tzvC
	Y9K0mXjCqmrN6wKJdC1KrPQ=
X-Google-Smtp-Source: AGHT+IHP23uE00H/RQwr42qR+drtU4psvRD8J4Zc/giYF4D+Pn6m6nF7FIYwwhvM1WTYs6Vdj/TX/Q==
X-Received: by 2002:a2e:a367:0:b0:2ca:27a:1829 with SMTP id i7-20020a2ea367000000b002ca027a1829mr6530295ljn.2.1702659538200;
        Fri, 15 Dec 2023 08:58:58 -0800 (PST)
Received: from pc636 (host-90-235-2-229.mobileonline.telia.com. [90.235.2.229])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b002c9f8626256sm2530609ljo.53.2023.12.15.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:58:57 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 15 Dec 2023 17:58:55 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Qais Yousef <qyousef@layalina.io>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <ZXyFz1BD6Nh1zsnc@pc636>
References: <20231203011252.233748-1-qyousef@layalina.io>
 <ZXhTjrTqZvMTXKtK@pc636>
 <CAEXW_YSMwmG_joipkK5W1Bdwzdjm_a3f86BijkAkAJTHOWkE0Q@mail.gmail.com>
 <ZXmI9zDW8KlZqQj7@pc636>
 <CAEXW_YRdgQywfJ+A9fa1itDojPDiZ_Xc3M8n6dS=M2LHX9hSFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRdgQywfJ+A9fa1itDojPDiZ_Xc3M8n6dS=M2LHX9hSFg@mail.gmail.com>

Hello, Joel!

> [....]
> > > > > +       Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
> > > > > +
> > > > > +config RCU_LAZY_DEFAULT_OFF
> > > > > +     bool "Turn RCU lazy invocation off by default"
> > > > > +     depends on RCU_LAZY
> > > > > +     default n
> > > > > +     help
> > > > > +       Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
> > > > > +       off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
> > > > > +       it back on.
> > > > > +
> > > > >  config RCU_DOUBLE_CHECK_CB_TIME
> > > > >       bool "RCU callback-batch backup time check"
> > > > >       depends on RCU_EXPERT
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 3ac3c846105f..8b7675624815 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > > > >  }
> > > > >
> > > > >  #ifdef CONFIG_RCU_LAZY
> > > > > +static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
> > > > > +module_param(enable_rcu_lazy, bool, 0444);
> > > > > +
> > > > >  /**
> > > > >   * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
> > > > >   * flush all lazy callbacks (including the new one) to the main ->cblist while
> > > > > @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
> > > > >       __call_rcu_common(head, func, false);
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > > > +#else
> > > > > +#define enable_rcu_lazy              false
> > > > >  #endif
> > > > >
> > > > >  /**
> > > > > @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > > >   */
> > > > >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > >  {
> > > > > -     __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> > > > > +     __call_rcu_common(head, func, enable_rcu_lazy);
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(call_rcu);
> > > > >
> > > > I think, it makes sense. Especially for devices/systems where it is hard
> > > > to recompile the kernel and deploy it. For example, Google and GKI approach.
> > >
> > > My concerns had nothing to do with recompiling the kernel. Passing a
> > > boot parameter (without a kernel compile) can just as well
> > > default-disable the feature.
> > >
> > > I think what Qais is saying is that passing a boot parameter is itself
> > > a hassle in Android (something I did not know about) because of GKI
> > > etc.
> > >
> > That is true. Doing:
> >
> > echo 1 > /sys/.../enable_lazy
> >
> > is a way how to make it easy and flexible.
> 
> Hey Vlad, are you suggesting that the boot parameter be made to
> support runtime? We can keep that for later as it may get complicated.
> Qais's boot parameter is designed only for boot time.
> 
No problem. Yes, i meant a runtime one. But as you stated there might
be hidden issues witch we are not aware of yet.

Thanks!

--
Uladzislau Rezki

