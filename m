Return-Path: <linux-kernel+bounces-78289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FED86116D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833D81C21A66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB57BAE6;
	Fri, 23 Feb 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZzh6hfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963237B3DA;
	Fri, 23 Feb 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691109; cv=none; b=N/9dLTmH4l+GwKH7i8yV9lnjufjLKVjpzYYOqRMWnCrrtNSPrdnBzq+OvWebKluM9VRXPrzQFvlJW1dnuTTxe+dKgDk0EFWURW4mZOp0b6m5n8Z6bXu8kO5IhXERbLQ56OE5JFcPrP2+iJhbWFWUkggZBZSTJEdywMcbX0pBuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691109; c=relaxed/simple;
	bh=MaYmzslx1mf+A0NsaTa/pwiRoRWhmyCe7uHLHoWcvWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkwjT30xUU0zTpmw6Gq9anGn+5XcOCxN/stqJldOtLY4ok6mn3yNTKU6ZcSN+ZTA2Xf+0GZxqhMnVJloTGjjyW+4T5v/Rwazt+rU5DRDAU+zFDebka7vt6rQQ1lOsBwacceDZja8jyzW8Apc3DGN8jp2FBUIkcM5p/8wr0JdSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZzh6hfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8AC433C7;
	Fri, 23 Feb 2024 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708691109;
	bh=MaYmzslx1mf+A0NsaTa/pwiRoRWhmyCe7uHLHoWcvWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZzh6hfeQeMNWZYdbqEaxioTBGZ+mJt/NHcqk+dArheg7i59OcGjeBTfZPmvFQE4d
	 JdsZtv6LFy/0QAGQEFyiGAquMPB2JTsp4NVilxCKsoLE78YzNu9RT3/sgaYv6ROwu9
	 hJO1OBBiuX1TVmdMwaCjr12HAHnq+9lOR392OElPmJPTx9TvoHhOGSOvY4BofL4+NL
	 Lt72yrgSF6zPkSYE5jZO4WY3mVGHSSyPLV5b5zb44b3EukMiqd0EZgIKr8yFcKgSoL
	 pVskg+jGQpmFMq+grGHvxhGKogtpNjgQrNVqHd8K/p9gY0Mrl/iKfQPobzpQDZWghu
	 I0PCQlsfhY17Q==
Date: Fri, 23 Feb 2024 13:25:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v2 0/6] RCU tasks fixes for v6.9
Message-ID: <ZdiOot2RJm1VuzSJ@lothringen>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <Zdd7x4Rmy_-WDqfl@localhost.localdomain>
 <cf84fb44-9620-40bc-a68d-051edf6823b8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf84fb44-9620-40bc-a68d-051edf6823b8@paulmck-laptop>

On Thu, Feb 22, 2024 at 02:09:17PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 22, 2024 at 05:52:23PM +0100, Frederic Weisbecker wrote:
> > Le Fri, Feb 16, 2024 at 05:27:35PM -0800, Boqun Feng a écrit :
> > > Hi,
> > > 
> > > This series contains the fixes of RCU tasks for v6.9. You can also find
> > > the series at:
> > > 
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rcu-tasks.2024.02.14a
> > > 
> > > Changes since v1:
> > > 
> > > *	Update with Paul's rework on "Eliminate deadlocks involving
> > > 	do_exit() and RCU task"
> > > 
> > > The detailed list of changes:
> > > 
> > > Paul E. McKenney (6):
> > >   rcu-tasks: Repair RCU Tasks Trace quiescence check
> > >   rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
> > >   rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
> > >   rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
> > >   rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
> > 
> > Food for later thoughts and further improvements: would it make sense to
> > call exit_rcu_tasks_start() on fork() instead and rely solely on
> > each CPUs' rtp_exit_list instead of the tasklist?
> 
> It might well.
> 
> One big advantage of doing that is the ability to incrementally traverse
> the tasks.  But is there some good way of doing that to the full task
> lists?  If so, everyone could benefit.

What do you mean by incrementally? You mean being able to cond_resched()
in the middle of the tasks iteration? Yeah not sure that's possible...

Thanks.

> 
> 							Thanx, Paul
> 
> > Thanks.
> > 
> > >   rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
> > > 
> > >  include/linux/rcupdate.h |   4 +-
> > >  include/linux/sched.h    |   2 +
> > >  init/init_task.c         |   1 +
> > >  kernel/fork.c            |   1 +
> > >  kernel/rcu/tasks.h       | 110 ++++++++++++++++++++++++++++++---------
> > >  5 files changed, 90 insertions(+), 28 deletions(-)
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 

