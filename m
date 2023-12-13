Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9808C810E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377189AbjLMKfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjLMKff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:35:35 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D99D0;
        Wed, 13 Dec 2023 02:35:40 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2cc259392a6so38238301fa.2;
        Wed, 13 Dec 2023 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702463739; x=1703068539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V3CWtF2fNs4rwpfbH1gBvvm+8Rnb61bFFG6hs2W4ExA=;
        b=batvxJUvMPnHAKsWWExrG0Rx53MG3rISmoTDbs/OWl+0ton6lrhtsrWE/mPeViInv0
         168fMk+q1OW6YlwOUzGU7X5gXp3CkxXXUyuC68CgNdZjhjvmYylNqkh38jkaxXtPDiIa
         x3aK6phkgdL2Nl/1ks1H21NLmzwAq+zyPdKN54EcSB29GxQeqmCtpNPbhrVFfQveH13B
         kmCpiSXHLrUvErqRr0qmwXEYF7svVTIkX2aO3xQNjk3ai3lzFfgrKxIMZaEGsPy3imWh
         Y2pq72d2bK/H3lkm4u6VgXv/Vz2ZAwgPj0rJ5oa6AqcoWZCL+kJqtd4jEevonAozTfnG
         +yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463739; x=1703068539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3CWtF2fNs4rwpfbH1gBvvm+8Rnb61bFFG6hs2W4ExA=;
        b=Xmja3WDjJjKrVrDP4BrGDyWlxJgNLDBIe0YiBPpyRO4CvHj/2s8T77gYjdd8RnrmK8
         Koi6n1tCOfBMmBJxUeOES3MU+kzZq2YNXcVfG06Y0By/nXU0+voCOHxf18GoTfMgLrXL
         v4tUZ/VHBFYopSNqeI3eXbOwdzHTyf+k6zpBu9Ic6vK62IAaeU5zPKHoaNhXLWNBqrMY
         MvUXZCPbvj6AZq5ZFFPIhCqylgtm5wUMViJGMT7sHV3XuaDiZCNd1bidJUj7/II1j249
         6Y776DopAz6Xmd5m4pooy+1XgsmA+ZHo+dsHpSsOAoHx9HL3/S92q1IQzzZGA06M1Rtb
         jm9Q==
X-Gm-Message-State: AOJu0YxTrKQMH5UKSDoiHRL/zo0g1ACGnUrE2Ac8xR4BT6qeYxYbDcYH
        R+qRUZwHQO4IzGoj3KS1tUE=
X-Google-Smtp-Source: AGHT+IEQui0wHCLJmNUMvL14iDsJqoNnWAgoMis8U6G/2ToohSIRNjWhCuxMn+s0PRVlKH5GIu1JRg==
X-Received: by 2002:a05:651c:901:b0:2cc:264a:1c37 with SMTP id e1-20020a05651c090100b002cc264a1c37mr3394042ljq.104.1702463738671;
        Wed, 13 Dec 2023 02:35:38 -0800 (PST)
Received: from pc636 (host-90-235-2-229.mobileonline.telia.com. [90.235.2.229])
        by smtp.gmail.com with ESMTPSA id y5-20020a05651c020500b002ca35a126e5sm1792425ljn.119.2023.12.13.02.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:35:38 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 13 Dec 2023 11:35:35 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Qais Yousef <qyousef@layalina.io>,
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
Message-ID: <ZXmI9zDW8KlZqQj7@pc636>
References: <20231203011252.233748-1-qyousef@layalina.io>
 <ZXhTjrTqZvMTXKtK@pc636>
 <CAEXW_YSMwmG_joipkK5W1Bdwzdjm_a3f86BijkAkAJTHOWkE0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSMwmG_joipkK5W1Bdwzdjm_a3f86BijkAkAJTHOWkE0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:28:54PM -0500, Joel Fernandes wrote:
> On Tue, Dec 12, 2023 at 7:35 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Sun, Dec 03, 2023 at 01:12:52AM +0000, Qais Yousef wrote:
> > > To allow more flexible arrangements while still provide a single kernel
> > > for distros, provide a boot time parameter to enable/disable lazy RCU.
> > >
> > > Specify:
> > >
> > >       rcutree.enable_rcu_lazy=[y|1|n|0]
> > >
> > > Which also requires
> > >
> > >       rcu_nocbs=all
> > >
> > > at boot time to enable/disable lazy RCU.
> > >
> > > To disable it by default at build time when CONFIG_RCU_LAZY=y, the new
> > > CONFIG_RCU_LAZY_DEFAULT_OFF can be used.
> > >
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > ---
> > >
> > > Changes since v1:
> > >
> > >       * Use module_param() instead of module_param_cb()
> > >       * Add new CONFIG_RCU_LAZY_DEFAULT_OFF to force default off.
> > >       * Remove unnecessary READ_ONCE()
> > >
> > > Tested on qemu only this time with various config/boot configuration to ensure
> > > expected values are in sysfs.
> > >
> > > Did a bunch of build tests against various configs/archs.
> > >
> > >  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
> > >  kernel/rcu/Kconfig                              | 13 +++++++++++++
> > >  kernel/rcu/tree.c                               |  7 ++++++-
> > >  3 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 65731b060e3f..2f0386a12aa7 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5021,6 +5021,11 @@
> > >                       this kernel boot parameter, forcibly setting it
> > >                       to zero.
> > >
> > > +     rcutree.enable_rcu_lazy= [KNL]
> > > +                     To save power, batch RCU callbacks and flush after
> > > +                     delay, memory pressure or callback list growing too
> > > +                     big.
> > > +
> > >       rcuscale.gp_async= [KNL]
> > >                       Measure performance of asynchronous
> > >                       grace-period primitives such as call_rcu().
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index bdd7eadb33d8..e7d2dd267593 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -314,6 +314,19 @@ config RCU_LAZY
> > >         To save power, batch RCU callbacks and flush after delay, memory
> > >         pressure, or callback list growing too big.
> > >
> > > +       Requires rcu_nocbs=all to be set.
> > > +
> > > +       Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
> > > +
> > > +config RCU_LAZY_DEFAULT_OFF
> > > +     bool "Turn RCU lazy invocation off by default"
> > > +     depends on RCU_LAZY
> > > +     default n
> > > +     help
> > > +       Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
> > > +       off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
> > > +       it back on.
> > > +
> > >  config RCU_DOUBLE_CHECK_CB_TIME
> > >       bool "RCU callback-batch backup time check"
> > >       depends on RCU_EXPERT
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 3ac3c846105f..8b7675624815 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > >  }
> > >
> > >  #ifdef CONFIG_RCU_LAZY
> > > +static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
> > > +module_param(enable_rcu_lazy, bool, 0444);
> > > +
> > >  /**
> > >   * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
> > >   * flush all lazy callbacks (including the new one) to the main ->cblist while
> > > @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
> > >       __call_rcu_common(head, func, false);
> > >  }
> > >  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > +#else
> > > +#define enable_rcu_lazy              false
> > >  #endif
> > >
> > >  /**
> > > @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > >   */
> > >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  {
> > > -     __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> > > +     __call_rcu_common(head, func, enable_rcu_lazy);
> > >  }
> > >  EXPORT_SYMBOL_GPL(call_rcu);
> > >
> > I think, it makes sense. Especially for devices/systems where it is hard
> > to recompile the kernel and deploy it. For example, Google and GKI approach.
> 
> My concerns had nothing to do with recompiling the kernel. Passing a
> boot parameter (without a kernel compile) can just as well
> default-disable the feature.
> 
> I think what Qais is saying is that passing a boot parameter is itself
> a hassle in Android (something I did not know about) because of GKI
> etc.
>
That is true. Doing:

echo 1 > /sys/.../enable_lazy

is a way how to make it easy and flexible.

--
Uladzislau Rezki
