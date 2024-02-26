Return-Path: <linux-kernel+bounces-82168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0986802B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E6BB243E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245112F366;
	Mon, 26 Feb 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odhHk28u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF791E866;
	Mon, 26 Feb 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973788; cv=none; b=X+ufXOZUgc86U55sMo0zr27t6STB6cy7hVa2iJ1ViDkUJJ141f1i4fSGVE0hAYuHqBuzqirAgNmIPr/wx3DFLetwJfnTf4GDbyOaMy6btfz1XQClp2K8M0GpDsDlwW6zAbZAB6q3Ae1OTNupf4uSPevk8tYeakCGo1xjwh7XOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973788; c=relaxed/simple;
	bh=4/ht9cg/8jPdSwNdZpj18Zq8GSZsf6eqVmgNBZwyisU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrB1A0iM71UkcxVYpDtRT+/rJIARaoLCPJde7JTKZZquk87NMMiNu7qcLFJPsQ77ho7BXqskOw6nnnKirUinlist9dK2dCf91/gtrk4lkQfhpaffgGMy9n4NoAOIQeAJ7SD1XmTZXF19eQGHm56Aqku+hptZP7xwdZyxQXfkwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odhHk28u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976FEC433F1;
	Mon, 26 Feb 2024 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708973787;
	bh=4/ht9cg/8jPdSwNdZpj18Zq8GSZsf6eqVmgNBZwyisU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=odhHk28uPnYzLH5s4vt8muhzUtrBhljzUsbhTVOkGAZzNceCATjyVG/aMJ2muuzEd
	 rmYCrjQEZM9ThaOcn3DbicwC7RuZ94tSyiyuFfaGLFTuALZ7Db2mEqcfDYXHbdb3zx
	 EIaXyH+zfQYhjeG3c468kjOHjCFCsge/6nsA7BsAa7rih+lgi7ONbu+1pS+goqlejV
	 Qx4iVyzjVbnvQwGfK0Z2E+7X3WKfeYPRNJSyAuG2jXoJEF3638nwV2RRZLN/eqyCoQ
	 Uh5Swtn0qanspekiUtu5mudPDVqWgn9LqMVhKUVvdpxrFTwaOX7FsF7120cqZGFceB
	 bAKmOT0QyZ12g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F98FCE0E27; Mon, 26 Feb 2024 10:56:27 -0800 (PST)
Date: Mon, 26 Feb 2024 10:56:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Fix the comments for
 tasks_rcu_exit_srcu_stall_timer
Message-ID: <ec57f86d-936c-4709-aeda-d9f57a8fd7aa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240226032439.26359-1-qiang.zhang1211@gmail.com>
 <CALm+0cXvWG2cP2sECzF9JGyUvvp0bBgSXA8NbGf896iMQEcCuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cXvWG2cP2sECzF9JGyUvvp0bBgSXA8NbGf896iMQEcCuA@mail.gmail.com>

On Mon, Feb 26, 2024 at 11:28:57AM +0800, Z qiang wrote:
> >
> > The synchronize_srcu() has been removed by commit("rcu-tasks: Eliminate
> > deadlocks involving do_exit() and RCU tasks") in rcu_tasks_postscan.
> > This commit therefore fix the comments of tasks_rcu_exit_srcu_stall_timer.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tasks.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 78d74c81cc24..d5319bbe8c98 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -150,7 +150,7 @@ static struct rcu_tasks rt_name =                                                   \
> >
> >  #ifdef CONFIG_TASKS_RCU
> >
> > -/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
> > +/* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
> >  static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
> >  static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
> 
> Is this timer not necessary? any thoughts?

We have preemption points in the list traversals, and things like mutex
contention on the do_exit() path could result in extremely long lists,
so I believe we do need the timer.

But what did you have in mind?

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >  #endif
> > --
> > 2.17.1
> >

