Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC37F5363
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjKVW2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjKVW2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:28:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6121A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:28:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32fe1a29010so165336f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700692090; x=1701296890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Bmd3pdVrVWxilawrCu/zkEt8Cb8PfyWRAOKjsXYIYo=;
        b=EZGZuI3HLzDa4kZp4yyYRxeYWzBmeY8KqtFtqihYF7QXYWtL7O2X2tQdCaRXb5OgPV
         oY58+n5BSe2mf0IXxYQrXxTDmTsH1fVrm6Jwfq/iktzPw5wvAbyqxq6aMzaYj71p68dh
         5uTuh0Aycv4dtH5w3Mst8Fxph2Y8e2pdmilil1GQ9JAzzKgoPkCZ+pgO5ok73rnZvT2E
         TGqf9DYVRtZexsNnuqg0AoveKioYO3UHrcPEq1MyYkv74f6/WENuANoYyWt30S+q+Ur6
         ZtgIDroosDazlHk8EgvBDsaqVOp4d/RP5s4iBxeugNXbFoQQEGU0RoxI2EyiK24G284r
         sdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700692090; x=1701296890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bmd3pdVrVWxilawrCu/zkEt8Cb8PfyWRAOKjsXYIYo=;
        b=pJjd1u1KflGpHlrsWTtAZOy6vEi7zHevG0FxlzUSzvvfSmZPIb0z+aPMXXyXIEFdqI
         2JWu06mpFWYlnNMBJKTng9LAjwv70Wwts6Yb/LMDPTeQEeMCkfJ/KDXnsri5DrTg17I/
         DyDGSz4+sJAh6P40XnkniFSjqSxOnAY8FI6eDOhwMGrz/aTyyPW8eQVJ/Ck1p2Cr7pBg
         v7SaCkqtOg5dBL1O8RpiUOoPd2bnyBKrOTinuTV6PQjKFeVhZ5P65wRtihauaRQMXSUO
         5YS2CIPg8lFcpbvC+30mfnHpWQ7XQQdLiVsAFgDYk48lYnRCbeU2PUWoOF2Am8Cv3Ddv
         tfjA==
X-Gm-Message-State: AOJu0YwP77k3j40/Rj3cknTYpecl+VKShBpgJ4zcVYVP+feP/n77TaLg
        nznGYgu0h6LlLIYTKbS+HvAADQ==
X-Google-Smtp-Source: AGHT+IFG65CfgN+Vv5uDIw1RAb+kqcAw0igfFtjUwEnZOAqH73CaCQxU9uj32XjQnkhzfU3yzx3hGw==
X-Received: by 2002:a05:6000:184c:b0:332:c646:2e8 with SMTP id c12-20020a056000184c00b00332c64602e8mr2654791wri.44.1700692090224;
        Wed, 22 Nov 2023 14:28:10 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003316d1a3b05sm449100wrr.78.2023.11.22.14.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:28:09 -0800 (PST)
Date:   Tue, 21 Nov 2023 21:44:15 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <20231121214415.ovoskvbjarzpxi6e@airbuntu>
References: <20231121205304.315146-1-qyousef@layalina.io>
 <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 14:00, Paul E. McKenney wrote:
> On Tue, Nov 21, 2023 at 08:53:04PM +0000, Qais Yousef wrote:
> > To allow more flexible opt-in arrangements while still provide a single
> > kernel for distros, provide a boot time parameter to enable lazy RCU.
> > 
> > Specify:
> > 
> > 	rcutree.enable_rcu_lazy
> > 
> > Which also requires
> > 
> > 	rcu_nocbs=all
> > 
> > at boot time to enable lazy RCU assuming CONFIG_RCU_LAZY=y. The
> > parameter will be ignored if CONFIG_RCU_LAZY is not set.
> > 
> > With this change now lazy RCU is disabled by default if the boot
> > parameter is not set even when CONFIG_RCU_LAZY is enabled.
> > 
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> > 
> > Makes sense to remove the CONFIG_RCU_LAZY now we have a boot time param?
> > 
> > We can make it a static key too if it *really* matters.
> > 
> > Thanks to Joel for helping initially in reviewing this patch which was intended
> > originally for Android.
> > 
> > I got some requests to make this a runtime modifiable for init scripts; but
> > Paul suggested there shall be dragons. So RO it is.
> 
> I must defer to the people using this, but my experience is that kernel
> boot parameters work for some people but not others.  For example,
> I tried making rcu_nocbs be the only way to say that all CPUs were
> going to be offloaded, but popular demand resulted in my adding a
> CONFIG_RCU_NOCB_CPU_DEFAULT_ALL.

Speak of pleasing a crowd.. There's always someone who wants something else :-)

I imagine the difficulty is in some environments it is easier to switch a sysfs
knob than add a new boot time parameter. And in the absence of a writable sysfs
node, I can imagine some folks think having a Kconfig to force a default at
compile time is the 2nd best compared to modifying their boot time parameters..

Either way; I'll follow what the crowd wants too :-)

> 
> If we cannot be sure that we know everyone using CONFIG_RCU_LAZY=y
> and expecting full laziness, the safe approach is to make another
> Kconfig option that defaults to off, but with either setting allowing
> rcutree.enable_rcu_lazy to override at boot time.
> 
> If you can be sure that you know everyone using CONFIG_RCU_LAZY=y
> is OK with this change, I must confess that I am curious as to how
> you found them all.

If you let it break and no one shouts..

/me hides

Jokes aside, all options work for me. I'll wait to hear from the other rcu
gurus what they'd like.

> 
> Thoughts?
> 
> 							Thanx, Paul
> 
> >  .../admin-guide/kernel-parameters.txt         |  5 ++++
> >  kernel/rcu/tree.c                             | 26 ++++++++++++++++++-
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 65731b060e3f..2f0386a12aa7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5021,6 +5021,11 @@
> >  			this kernel boot parameter, forcibly setting it
> >  			to zero.
> >  
> > +	rcutree.enable_rcu_lazy= [KNL]
> > +			To save power, batch RCU callbacks and flush after
> > +			delay, memory pressure or callback list growing too
> > +			big.
> > +
> >  	rcuscale.gp_async= [KNL]
> >  			Measure performance of asynchronous
> >  			grace-period primitives such as call_rcu().
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 3ac3c846105f..e0885905b3f6 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2718,7 +2718,30 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >  	}
> >  }
> >  
> > +static bool enable_rcu_lazy;
> >  #ifdef CONFIG_RCU_LAZY
> > +/* Enable lazy rcu at boot time */
> > +static int param_set_rcu_lazy(const char *val, const struct kernel_param *kp)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * Make sure a grace period has passed before and after flipping the
> > +	 * switch.
> > +	 */
> > +	rcu_barrier();
> > +	ret = param_set_bool(val, kp);
> > +	rcu_barrier();
> > +
> > +	return ret;
> > +}
> > +static const struct kernel_param_ops rcu_lazy_ops = {
> > +	.flags = KERNEL_PARAM_OPS_FL_NOARG,
> > +	.set = param_set_rcu_lazy,
> > +	.get = param_get_bool,
> > +};
> > +module_param_cb(enable_rcu_lazy, &rcu_lazy_ops, &enable_rcu_lazy, 0444);
> 
> OK, I will bite...
> 
> Given that this is to be set only at boot time, why not replace everything
> from "#ifdef CONFIG_RCU_LAZY" to here with this?
> 
> module_param(enable_rcu_lazy, bool, 0444);

No need for the rcu_barrier() then? Only reason why we use the _cb flavour

> And then maybe also a __read_mostly on the definition of enable_rcu_lazy?

+1

I think the READ_ONCE() was unnecessary too.


Thanks!

--
Qais Yousef
