Return-Path: <linux-kernel+bounces-106535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448E87F00C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6797B211B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA056442;
	Mon, 18 Mar 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqsubnx3"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E825774;
	Mon, 18 Mar 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788297; cv=none; b=rWweqagPXr9QPA1eUGnxjcSTJLrmFKWQZvvMhHiHCJ2bFY9xmiZmXIRtJIlqJU43El5zwHTsdYR27x9Oto4Qx2se/HYCek2QdlpZtWgtWSAszwid4wCRCkEfJ9HOUT0uxUOyU6H+/SfaohonpRc9qlFn71IWG/9C8RiBPDm8nV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788297; c=relaxed/simple;
	bh=avsXDYPINe5LmCPSFAn0dGYnmy2Rz3niYsfJVzEkgOI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAPDy0zfmb35GupAn36t715aeFJk1e4dUSRiSQetY10ql68dfBy4BhvO2NsZ2QgHzug/VYx7vVu3C1AzzLZZ3JSBaeoBKgf21XiLsx6vmLaDzSP+X/mEZi8vw3Ih3XlRdwAupUs23BsoWpxVx1szRQPJ4TO3URzl+WszeX9LxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqsubnx3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513d717269fso4824716e87.0;
        Mon, 18 Mar 2024 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710788293; x=1711393093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMtWXS3dtM0NMQkLB2HmFBiUuOO+4b3zQnUwksDT1wI=;
        b=Hqsubnx3y0aJ/kh2W3Rrla+mn+4ylPUncb7QpZVbJqGl+H9umnwvEmpgapLXXy14yl
         N7bAXDodC2LNKquCYVJkey0BB4apQ3kPBcuRCuUXgpKUHNls/qlxUduRpskA9DQpZsUG
         3+WeW7cBwXb/HFybZbON0ekIFDAqH+6/fMCPP3nOINMc9XrTAfnVr1auBkBGFZE8hK/F
         F0RSUkAf8/Vd0+ZeXa3EeXwlG/yJd1l9hhz6830buluSmT+aYHYq+KDEeimVxKTLQiqy
         eDHVn7GTMfFmiZGULSku/hOHW9lo/805IsYFWN+lGpyW6Xei0jP2PoiNZfxNvHXaPSz5
         RQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710788293; x=1711393093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMtWXS3dtM0NMQkLB2HmFBiUuOO+4b3zQnUwksDT1wI=;
        b=LRsyC7aLBOqwd0o2LgG6KfcCfk+qg2LeTQ9VR0SrLmOFKYoKMyY1Jfy8E0kLe/5JAo
         dtoiKDyMY33KB3Yyb7tYkUfyBPvrDtms8iSMPKu6ozisjL1998pypvSFrN2Y9auF5Z6D
         oRPrDcC4Vnq3Txh03xoR4lUzgFIUFpvN7U/iknglyRd72YIRvdbbRjVp9RT+8qmjnV9u
         BFDGwlt35Rma60Bl/BzFGB8SKpzkHhfsUFsCEwTs4q2dX4XI9t9LqFnBhYKbOR/PVc6W
         96bw9579NCR6BW2ErhY09bxR/ahdHF6K4kMOLP6PmosrUk6byUoaO4HJr7gCICZfzwxi
         5ZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY5xluoVKHy+Sk6TKTqN/AzNe+FrAnPQ7TH82QAM2rBWqNqbUmaRG1dYdkCkthuXcU99Cyz4+Lal+lXCRf9eneqM2B
X-Gm-Message-State: AOJu0YyPUTlCJXI4GILIu/VfD9v+6oKGMdSyWZM1raQHRzKEuwtHNVeA
	Xyqi00+3lV2iVrPKfzGQhc3NZgJnG5rj2wdNVT0RKQJb9skKaNF5
X-Google-Smtp-Source: AGHT+IEjNoc3HDKsdhTnr5X7f4jx0Vo4SiPOJSkZrkKGfyW04NVHQgv+JFKtn1lpywWTX6ZnN7fYsQ==
X-Received: by 2002:ac2:4649:0:b0:513:ba35:cacd with SMTP id s9-20020ac24649000000b00513ba35cacdmr7968211lfo.39.1710788293008;
        Mon, 18 Mar 2024 11:58:13 -0700 (PDT)
Received: from pc636 (host-90-235-3-101.mobileonline.telia.com. [90.235.3.101])
        by smtp.gmail.com with ESMTPSA id m21-20020a194355000000b00513da68c536sm1264372lfj.152.2024.03.18.11.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:58:12 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 18 Mar 2024 19:58:10 +0100
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
	rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for
 synchronize_rcu() common case
Message-ID: <ZfiOwtPfnxXW4JX3@pc636>
References: <20240308224439.281349-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308224439.281349-1-joel@joelfernandes.org>

Hello, Joel!

Sorry for late checking, see below few comments:

> In the synchronize_rcu() common case, we will have less than
> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> is pointless just to free the last injected wait head since at that point,
> all the users have already been awakened.
> 
> Introduce a new counter to track this and prevent the wakeup in the
> common case.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Rebased on paul/dev of today.
> 
>  kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
>  kernel/rcu/tree.h |  1 +
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9fbb5ab57c84..bd29fe3c76bf 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
>  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
>  	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
>  		rcu_sr_normal_gp_cleanup_work),
> +	.srs_cleanups_pending = ATOMIC_INIT(0),
>  };
>  
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>  	 * the done tail list manipulations are protected here.
>  	 */
>  	done = smp_load_acquire(&rcu_state.srs_done_tail);
> -	if (!done)
> +	if (!done) {
> +		/* See comments below. */
> +		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
>  		return;
> +	}
>  
>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
>  	head = done->next;
> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>  
>  		rcu_sr_put_wait_head(rcu);
>  	}
> +
> +	/* Order list manipulations with atomic access. */
> +	atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
>  }
>  
>  /*
> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>   */
>  static void rcu_sr_normal_gp_cleanup(void)
>  {
> -	struct llist_node *wait_tail, *next, *rcu;
> +	struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
>  	int done = 0;
>  
>  	wait_tail = rcu_state.srs_wait_tail;
> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
>  			break;
>  	}
>  
> -	// concurrent sr_normal_gp_cleanup work might observe this update.
> -	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> +	/*
> +	 * Fast path, no more users to process. Remove the last wait head
> +	 * if no inflight-workers. If there are in-flight workers, let them
> +	 * remove the last wait head.
> +	 */
> +	WARN_ON_ONCE(!rcu);
>
This assumption is not correct. An "rcu" can be NULL in fact. 

>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>  
> +	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
> +		/* Order atomic access with list manipulation. */
> +		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
> +		wait_tail->next = NULL;
> +		rcu_sr_put_wait_head(rcu);
> +		smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> +		return;
> +	}
> +
> +	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
> +	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> +
>  	/*
>  	 * We schedule a work in order to perform a final processing
>  	 * of outstanding users(if still left) and releasing wait-heads
>  	 * added by rcu_sr_normal_gp_init() call.
>  	 */
> -	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
> +	atomic_inc(&rcu_state.srs_cleanups_pending);
> +	if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work)) {
> +		atomic_dec(&rcu_state.srs_cleanups_pending);
> +	}
>  }
No need an extra "{}" pair.

>  
>  /*
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index bae7925c497f..affcb92a358c 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -420,6 +420,7 @@ struct rcu_state {
>  	struct llist_node *srs_done_tail; /* ready for GP users. */
>  	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
>  	struct work_struct srs_cleanup_work;
> +	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
>  };
>  
>  /* Values for rcu_state structure's gp_flags field. */
> -- 
> 2.34.1
> 

