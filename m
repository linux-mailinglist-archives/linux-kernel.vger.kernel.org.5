Return-Path: <linux-kernel+bounces-27590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3B182F296
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F491F25309
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF9A1C6AB;
	Tue, 16 Jan 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sECyj7ns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978C1BF3D;
	Tue, 16 Jan 2024 16:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20690C433F1;
	Tue, 16 Jan 2024 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705423838;
	bh=2NPjzps+hJ+aAwUViw/dVtWsbpS2ZynMXSxeOnl8abA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sECyj7ns3TuopVn59k97q26ied+kCapNq22izPEJWbJP1Mhof5souh6+5pWT9qIHL
	 BJOriWroXYFjbgNCUGoNSjOvpieAZ613hJoTkaRTPbdxiZDc1ageTrG/CsPvCgksQx
	 Tt1XmN9mIfVAlqjkTmTGyTTY+qotN1HM3XaZNGkYM7yXTWVFqDwlmO1Aw92XPK0pBd
	 Fhlm1d2URKXwlDGao0khj/36je+iaZf4D8YR+IP597Qs4TT7bJcfqAp05OO2pDDiEp
	 /diRbsuVL+c2We5mbtVNTIhHWqsDYtZ3qFgukdkrLsYJqFG5WIkSRSo8QQIz5o766l
	 DVrUlF4ti2oDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DC23ECE04A3; Tue, 16 Jan 2024 08:50:35 -0800 (PST)
Date: Tue, 16 Jan 2024 08:50:35 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onkarnarth <onkarnath.1@samsung.com>
Cc: frederic@kernel.org, quic_neeraju@quicinc.com, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, r.thapliyal@samsung.com,
	maninder1.s@samsung.com, tj@kernel.org, oleg@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 1/1] rcu/sync: remove un-used rcu_sync_enter_start
 function
Message-ID: <de792eee-1f44-48e2-a122-c3ded1645155@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CGME20240111092805epcas5p2ebb993010ae31d039e8f9de1e7818f7c@epcas5p2.samsung.com>
 <20240111092722.322454-1-onkarnath.1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111092722.322454-1-onkarnath.1@samsung.com>

On Thu, Jan 11, 2024 at 02:57:22PM +0530, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
> 
> With commit '6a010a49b63a ("cgroup: Make !percpu threadgroup_rwsem
> operations optional")' usage of rcu_sync_enter_start is removed.
> 
> So this function can also be removed.
> 
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Adding Oleg, Peter, and Tejun for their thoughts.  Any objections?

							Thanx, Paul

> ---
>  include/linux/rcu_sync.h |  1 -
>  kernel/rcu/sync.c        | 16 ----------------
>  2 files changed, 17 deletions(-)
> 
> diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
> index 0027d4c8087c..3860dbb9107a 100644
> --- a/include/linux/rcu_sync.h
> +++ b/include/linux/rcu_sync.h
> @@ -37,7 +37,6 @@ static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
>  }
>  
>  extern void rcu_sync_init(struct rcu_sync *);
> -extern void rcu_sync_enter_start(struct rcu_sync *);
>  extern void rcu_sync_enter(struct rcu_sync *);
>  extern void rcu_sync_exit(struct rcu_sync *);
>  extern void rcu_sync_dtor(struct rcu_sync *);
> diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> index e550f97779b8..86df878a2fee 100644
> --- a/kernel/rcu/sync.c
> +++ b/kernel/rcu/sync.c
> @@ -24,22 +24,6 @@ void rcu_sync_init(struct rcu_sync *rsp)
>  	init_waitqueue_head(&rsp->gp_wait);
>  }
>  
> -/**
> - * rcu_sync_enter_start - Force readers onto slow path for multiple updates
> - * @rsp: Pointer to rcu_sync structure to use for synchronization
> - *
> - * Must be called after rcu_sync_init() and before first use.
> - *
> - * Ensures rcu_sync_is_idle() returns false and rcu_sync_{enter,exit}()
> - * pairs turn into NO-OPs.
> - */
> -void rcu_sync_enter_start(struct rcu_sync *rsp)
> -{
> -	rsp->gp_count++;
> -	rsp->gp_state = GP_PASSED;
> -}
> -
> -
>  static void rcu_sync_func(struct rcu_head *rhp);
>  
>  static void rcu_sync_call(struct rcu_sync *rsp)
> -- 
> 2.25.1
> 

