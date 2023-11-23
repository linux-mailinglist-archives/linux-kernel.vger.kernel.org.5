Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58D7F5833
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjKWG2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKWG2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:28:49 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C76189
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:28:54 -0800 (PST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 979ED40C4F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700720932;
        bh=KDCZsrpFj7eJm5TsscoUxhvwf8t1zu/BgHh2L9uW6fQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=qTD1LomgZ2KXILT42+wTdLmfHkqjUEb5tic1+a2bAIyyr48LbNTCwmZOaPWnPhBF0
         eI7pep0Ju9SIt1D1drWLotg8KkXKFgfd3/e3r1Fk1gimdCIJbkQa71Ork5GJHnfXml
         M/5v6CNgrb/Y3nWZ59PQvlI0IJb1bskt6XWq1+CyQKM6IRTNdeqjICZGfGlTufSXC9
         AO255R2fX1sMTBTbOvnBf77DzQawz/+7ZDyVE6CtP4avONmXq0s9mLII+QlwPQLIbR
         jqEMbcUnUOeT5BxDNexWoDQSpoeED4MtISfI/YnCcKVmOQ5XDKDmKyON8CycMS+7nn
         +8mdVrOClzFNA==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c89230b1fdso4842671fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700720931; x=1701325731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDCZsrpFj7eJm5TsscoUxhvwf8t1zu/BgHh2L9uW6fQ=;
        b=U3Av88GKz9QDL8voik75IQE/oq9F0avr4wNMLz5hAHuvLzOXedsVjyxyPQ/AQC8Bdy
         2BP4VnWgqosGJmycC8V3wiJ5VNfqMRXDC1v1E5lxMFr5dO7JwtpzKH1tjmjQFk2n4cgJ
         kWU2xzvyaKPTHjBLSpUthz6bPk2Yh4sgwJfNE7xn9ub19Nes4KXIimb1hyGPyxQHEUL6
         AZaW5MEPP1SoEnJ+gWpgZxSnIMiHXEgmUi5Vu8rt45iavyOofKKHtIkhAjPBYLVPdN9q
         PL4z8dwdMmhG/Htmp7Eru+GBQmAdc03mk5haGm9c8DrKkbiWbWgd4ep2N5Ulvt/slSxK
         joQw==
X-Gm-Message-State: AOJu0YyEQ+Pnf9292wEOn0i40SeQin5Dj9kP+HBgfb0ClpazcpNUOjSw
        RYmwHD9oaTicyWxbaPz0BI+1LZ93VAAt0GM1RpTrjc6k71ATEScyrkR3oAZuwdU1Z6ijkrF9D6e
        bNdz6DirLKl2/rOHrfzXTAudT8xLZChaxHHLv8gg13Rl/SQMZgKyH
X-Received: by 2002:a2e:8095:0:b0:2c2:c450:c2d0 with SMTP id i21-20020a2e8095000000b002c2c450c2d0mr3086711ljg.24.1700720931781;
        Wed, 22 Nov 2023 22:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeapI2zr/lkHVWEAuf15/aw5+xLb5nbTdIJh1ap18WkP3QVTzHdOPCwXTHdl2XzfqhlnLIQg==
X-Received: by 2002:a2e:8095:0:b0:2c2:c450:c2d0 with SMTP id i21-20020a2e8095000000b002c2c450c2d0mr3086697ljg.24.1700720931407;
        Wed, 22 Nov 2023 22:28:51 -0800 (PST)
Received: from localhost (host-79-54-179-199.retail.telecomitalia.it. [79.54.179.199])
        by smtp.gmail.com with ESMTPSA id my47-20020a1709065a6f00b009920a690cd9sm366280ejc.59.2023.11.22.22.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:28:51 -0800 (PST)
Date:   Thu, 23 Nov 2023 07:28:50 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <ZV7xIjSq1l1q7gRI@gpd>
References: <20231121205304.315146-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121205304.315146-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:53:04PM +0000, Qais Yousef wrote:
> To allow more flexible opt-in arrangements while still provide a single
> kernel for distros, provide a boot time parameter to enable lazy RCU.
> 
> Specify:
> 
> 	rcutree.enable_rcu_lazy
> 
> Which also requires
> 
> 	rcu_nocbs=all
> 
> at boot time to enable lazy RCU assuming CONFIG_RCU_LAZY=y. The
> parameter will be ignored if CONFIG_RCU_LAZY is not set.
> 
> With this change now lazy RCU is disabled by default if the boot
> parameter is not set even when CONFIG_RCU_LAZY is enabled.

I'm wondering if we should make this enabled by default if
CONFIG_RCU_LAZY=y, so we don't break the previous behavior, and those
who want it disabled (despite having CONFIG_RCU_LAZY=y in their .config)
can add rcutree.enable_rcu_lazy=0 to the boot options.

Thanks for working on this!
-Andrea

> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
> 
> Makes sense to remove the CONFIG_RCU_LAZY now we have a boot time param?
> 
> We can make it a static key too if it *really* matters.
> 
> Thanks to Joel for helping initially in reviewing this patch which was intended
> originally for Android.
> 
> I got some requests to make this a runtime modifiable for init scripts; but
> Paul suggested there shall be dragons. So RO it is.
> 
> 
>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>  kernel/rcu/tree.c                             | 26 ++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..2f0386a12aa7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5021,6 +5021,11 @@
>  			this kernel boot parameter, forcibly setting it
>  			to zero.
>  
> +	rcutree.enable_rcu_lazy= [KNL]
> +			To save power, batch RCU callbacks and flush after
> +			delay, memory pressure or callback list growing too
> +			big.
> +
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
>  			grace-period primitives such as call_rcu().
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ac3c846105f..e0885905b3f6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2718,7 +2718,30 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>  	}
>  }
>  
> +static bool enable_rcu_lazy;
>  #ifdef CONFIG_RCU_LAZY
> +/* Enable lazy rcu at boot time */
> +static int param_set_rcu_lazy(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	/*
> +	 * Make sure a grace period has passed before and after flipping the
> +	 * switch.
> +	 */
> +	rcu_barrier();
> +	ret = param_set_bool(val, kp);
> +	rcu_barrier();
> +
> +	return ret;
> +}
> +static const struct kernel_param_ops rcu_lazy_ops = {
> +	.flags = KERNEL_PARAM_OPS_FL_NOARG,
> +	.set = param_set_rcu_lazy,
> +	.get = param_get_bool,
> +};
> +module_param_cb(enable_rcu_lazy, &rcu_lazy_ops, &enable_rcu_lazy, 0444);
> +
>  /**
>   * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
>   * flush all lazy callbacks (including the new one) to the main ->cblist while
> @@ -2792,7 +2815,8 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> +	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY) &&
> +			  READ_ONCE(enable_rcu_lazy));
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> -- 
> 2.34.1
