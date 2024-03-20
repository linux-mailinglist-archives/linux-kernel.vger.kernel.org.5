Return-Path: <linux-kernel+bounces-109017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2F881367
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16661F23C84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2787347F4A;
	Wed, 20 Mar 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTqA/ENs"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96C405C1;
	Wed, 20 Mar 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945380; cv=none; b=Nee606jXlRfoD2c413sveuKOFvqzr2NJbKKpH/S6DtuWmtdWSOg5XIqkqkdWJRsBNxwf7YvTwSDAi69oKpCjf+0oSVliDiKg7CbBsI+gny62V5+uuHDmNBfCqCnsEwwGNDjVXU7yrV0jDppMoXnhIHHwcOEaaRFKgxNP2GtfGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945380; c=relaxed/simple;
	bh=bkVh2hE6ECF8PpR1ujud01w+O393SFAoRTTeTz1knS8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M91Ky+kcMRlESoazwxyJX9lZ0O5OIWr2213Q/M1PHhNOdJtmdP01rYpxJWMlD+7HCQirFu2f2tNK1boml7SYlzP6oV04X/nRR/CTKHFTU1hlbGiHl+Ry8mEmj8SxVIU5A9wCCNFhcOWWhwUUk+TP5Ijs7O2Qqbkfi4RP2H8XUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTqA/ENs; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515830dc79cso1877258e87.1;
        Wed, 20 Mar 2024 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710945377; x=1711550177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jaEPTtQ4G833kyiwIGAF2QMWnjG7uctqKqKj19z3o3Y=;
        b=DTqA/ENskc5+E85AO19L5ps6m8odiIhyUO6HRviSqOnQ6THzZPEY2ag/xXah/9L4tj
         UY+/2tsi6sEfXCLNN60gbn6XpWW6Y231owh4EMjOVkD0SAMjFCpTjONbXKWSvlD3Cp9v
         j3OxRoCJEL5uXY+XSsZnApIvEC7QWA2RBUSmt3gP0KS6MDdNQp9Kbb/xct5R/5WJdi2M
         vOZNLJ6xyp62uLEB/Y5DZj4LS5IkaTllQ9XBjJVU9VYDHSICeiYbzUVHms9S7CNoWNn7
         pzqvAPFhY3wevUR7m0riuJBxClvz7s4595GrRkFDm7+XmIrskTf82d+etEbyJDiXcnbA
         dkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945377; x=1711550177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaEPTtQ4G833kyiwIGAF2QMWnjG7uctqKqKj19z3o3Y=;
        b=E7OvjDcTeYP+qAFcHs4Nzu4hX7IREatlNO2FjTnJ4fzRGFy/WNb/pM0OizbByYtGjY
         rX3KjL45g5WyBmfisPihMPHtUzdbBzT2cNuRv24UC2AT9zUPZwdN7c/JZp3W/Bda9/Li
         QEbZgVPbeVpc80Pv96azMzZy03mOHRqV1KrKcIhzfqmNLRd/2DYHP8Ztr/6qaHKtWRC5
         A406/CT1E99EYEv/U4i8iAX30c20N+1yRMbYgPBEjqftrAC60I26mG++44hWIngl9r5i
         rgKHQQEoL2GBxWgOOW0+ilVTx/WVRwkSTE6ZIlKq6xzth3XjZYtM91FO9BGTOrjuFJUF
         aRuw==
X-Forwarded-Encrypted: i=1; AJvYcCX73fcuqts4PJGOueW9xMCH82gvigaxBhiWdMAq8eptuKXvp+Tx2cg2efJs9PJVs9RKvBr80ggChbglV5Ds9zQwmyDA
X-Gm-Message-State: AOJu0YzxgdjhBwDoGH2Itk1f6bcMfg0ZPE39btDqjtx89l6aX/VyfP3N
	/d62hPmtOBSyC/+ymj6YMyntBme0IC15Vhl9QYPKREosxZk6ex5+
X-Google-Smtp-Source: AGHT+IG+9PIIaXQWJslKKJSlWtlLnPVxXHXMneebRguNfriDZvpod3E6/4CXz3xIiYaKcxNLWbP4ZA==
X-Received: by 2002:a05:6512:470:b0:513:cf52:3c15 with SMTP id x16-20020a056512047000b00513cf523c15mr12275984lfd.49.1710945376406;
        Wed, 20 Mar 2024 07:36:16 -0700 (PDT)
Received: from pc636 (host-90-235-3-101.mobileonline.telia.com. [90.235.3.101])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25b46000000b00513a8da4592sm2288777lfp.74.2024.03.20.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:36:16 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 20 Mar 2024 15:36:13 +0100
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, urezki@gmail.com,
	neeraj.iitr10@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH v4] rcu/tree: Reduce wake up for synchronize_rcu() common
 case
Message-ID: <Zfr0XVpgugTK8MMi@pc636>
References: <20240319185458.3968308-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319185458.3968308-1-joel@joelfernandes.org>

On Tue, Mar 19, 2024 at 02:54:57PM -0400, Joel Fernandes (Google) wrote:
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
> v1->v2: Rebase on paul/dev
> v2->v3: Additional optimization for wait_tail->next == NULL case.
> v3->v4: Apply clean ups from Vlad. Tested rcutorture all scenarios.
> ---
>  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
>  kernel/rcu/tree.h |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9fbb5ab57c84..f3193670fe42 100644
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
> @@ -1699,16 +1706,34 @@ static void rcu_sr_normal_gp_cleanup(void)
>  			break;
>  	}
>  
> -	// concurrent sr_normal_gp_cleanup work might observe this update.
> -	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> +	/*
> +	 * Fast path, no more users to process except putting the second last
> +	 * wait head if no inflight-workers. If there are in-flight workers,
> +	 * they will remove the last wait head.
> +	 *
> +	 * Note that the ACQUIRE orders atomic access with list manipulation.
> +	 */
> +	if (wait_tail->next && wait_tail->next->next == NULL &&
> +	    rcu_sr_is_wait_head(wait_tail->next) &&
> +	    !atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
> +		rcu_sr_put_wait_head(wait_tail->next);
> +		wait_tail->next = NULL;
> +	}
> +
> +	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> +	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>  
>  	/*
>  	 * We schedule a work in order to perform a final processing
>  	 * of outstanding users(if still left) and releasing wait-heads
>  	 * added by rcu_sr_normal_gp_init() call.
>  	 */
> -	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
> +	if (wait_tail->next) {
> +		atomic_inc(&rcu_state.srs_cleanups_pending);
> +		if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
> +			atomic_dec(&rcu_state.srs_cleanups_pending);
> +	}
>  }
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
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

