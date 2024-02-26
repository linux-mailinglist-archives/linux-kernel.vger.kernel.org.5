Return-Path: <linux-kernel+bounces-82167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57528868027
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFFDB27C69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB312F395;
	Mon, 26 Feb 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD+ZlOMi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5F12E1D5;
	Mon, 26 Feb 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973697; cv=none; b=mZTSW7+VEGjdZvLvXdBoMSJjyS9ZRofBIkc60ZDDfVFFoWRWi2H9C+Ul5mB9trcbfMHYulgPeYX3kLH8RuYB0rQDmR7A5nZwBYJ9zg/NsoGdYrIsvFPoH9wCLH9mo5M6HntAyVW4pDulXSAW8qvBCkfAmP12BuH12MxM5fDuVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973697; c=relaxed/simple;
	bh=5LGD1bbsX0ViNwsdm1xCwt95M1/zjN9a/re3ou5QDek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do8tdMcIoO6ArH4kQR9dIMDUKNtCUcVAv/eJIuKSGuowC/cOQLy8eS9gc6qox070mdrs6XAVzNYOafoDySyw4zk/fdO5qk+UZ7YJ4aZa1IwLxDGwJmYzAZD0F2T1u8i8SsX2L/Y7tVST6UXAgoc96fme2bkbOOD87cR3BmPFUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD+ZlOMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4142BC433C7;
	Mon, 26 Feb 2024 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708973697;
	bh=5LGD1bbsX0ViNwsdm1xCwt95M1/zjN9a/re3ou5QDek=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VD+ZlOMigOx0gFuFn0DyZNVhZgAbDnaBsEkjTBvsWHViraUaHzWuJoQFuZ5WtoS8O
	 kTkNFq2NuqSd7fcBQy8GRIIwCUPKdmAiydzO3qaKcgd87Y+gpK6nZPsuLBu7g6C77p
	 Ag6ay0Qkq+x6OfB4nosPVtBjcEirDcVsjMz5xVpvRVmfK42Xf1oMPktSgp/cGnVuOE
	 Rf/NDjKqo9wOzgguPdibyhTLDlaAmDxhulXdRo5wCTdzAM9vZ1g5JvQtFaGOAl485L
	 SwYV+sKnX1AJZvjGmgCzbwKXtLIA+mESPCdMJ2xYwFhWG8psUvItEH5q2lEQh019Rb
	 7i7Y0Vu9AjHrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D162CCE0E27; Mon, 26 Feb 2024 10:54:56 -0800 (PST)
Date: Mon, 26 Feb 2024 10:54:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Fix the comments for
 tasks_rcu_exit_srcu_stall_timer
Message-ID: <4a8e281c-de4c-48e6-87dd-a26ec16b5f00@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240226032439.26359-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226032439.26359-1-qiang.zhang1211@gmail.com>

On Mon, Feb 26, 2024 at 11:24:39AM +0800, Zqiang wrote:
> The synchronize_srcu() has been removed by commit("rcu-tasks: Eliminate
> deadlocks involving do_exit() and RCU tasks") in rcu_tasks_postscan.
> This commit therefore fix the comments of tasks_rcu_exit_srcu_stall_timer.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Queued, most likely for the v6.10 merge window, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 78d74c81cc24..d5319bbe8c98 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -150,7 +150,7 @@ static struct rcu_tasks rt_name =							\
>  
>  #ifdef CONFIG_TASKS_RCU
>  
> -/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
> +/* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
>  static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
>  static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
>  #endif
> -- 
> 2.17.1
> 

