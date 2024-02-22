Return-Path: <linux-kernel+bounces-76907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD785FE78
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3865B1F2662C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F230D153BEF;
	Thu, 22 Feb 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0QK9tFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49A153BC9;
	Thu, 22 Feb 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620746; cv=none; b=FyFepszDKTYOh2UUQt3NZQdu0eX8DuWinRrgo7opH8V9qOM3GX0mmTuStLwmsPyLI/J7S1W/nnwmcGhyZUWMeSmptpfIOZQdeRUWkMWDKf3zB3XMkagL6nS7LYKbfKM/+ZEvxKwn8LFMTeEXP/s0AA9IjA/zPxhQmay86UoObfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620746; c=relaxed/simple;
	bh=98Sm4DZ8Y1ZioHme9G4K5gXY1XZZ3VUczoPsHQr9Qhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWPVoWiyRuUBQ5usLAibH9HDom1X7KHe1drzSfbJGw3aRFeAq7x/d8y22muFFe6Se8IkAKE6o0lptC61duXVLgtmn+8dE7mikizgpNa5lm3ru9/VvgJ9rfQlznf+Wz3Gd/sJtXQSr/7JgJO6BwSc2SvGjTNn7FmGM6YmmDq0r88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0QK9tFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA55BC433C7;
	Thu, 22 Feb 2024 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708620746;
	bh=98Sm4DZ8Y1ZioHme9G4K5gXY1XZZ3VUczoPsHQr9Qhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0QK9tFxHTWHbW973ceBcqVxgJ9lKHZLL4ZHXiqXJwL8ThTWYF7hcbAKuoGcUsZ6B
	 uKRTjIOqSnJaXRYzaAssp/caPIRBVJZeJpxi2AjuGJPOIypwZmb4SDbbLc5eNMdPyE
	 CV6KBevicSl2yQ5b8vbRVueXipUZq7DUkk7lxbiU5w1ReBxTezoIMDEpQ0ZKvGGy1d
	 3OJK0JNTqsi79RYZAp9v+fNh/VQumk8yzGZJqhuLxD3LtOBOmN3IQzybP14A8FfMUS
	 OmJJWKFSIqH7Mouq1Xzq95nWEu5EhQtxmsExjxRcmthOE6gRHgWPW+zsgebIii3c5q
	 2o5MgefxDfI6g==
Date: Thu, 22 Feb 2024 17:52:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v2 0/6] RCU tasks fixes for v6.9
Message-ID: <Zdd7x4Rmy_-WDqfl@localhost.localdomain>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217012745.3446231-1-boqun.feng@gmail.com>

Le Fri, Feb 16, 2024 at 05:27:35PM -0800, Boqun Feng a écrit :
> Hi,
> 
> This series contains the fixes of RCU tasks for v6.9. You can also find
> the series at:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rcu-tasks.2024.02.14a
> 
> Changes since v1:
> 
> *	Update with Paul's rework on "Eliminate deadlocks involving
> 	do_exit() and RCU task"
> 
> The detailed list of changes:
> 
> Paul E. McKenney (6):
>   rcu-tasks: Repair RCU Tasks Trace quiescence check
>   rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
>   rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
>   rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
>   rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks

Food for later thoughts and further improvements: would it make sense to
call exit_rcu_tasks_start() on fork() instead and rely solely on
each CPUs' rtp_exit_list instead of the tasklist?

Thanks.

>   rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
> 
>  include/linux/rcupdate.h |   4 +-
>  include/linux/sched.h    |   2 +
>  init/init_task.c         |   1 +
>  kernel/fork.c            |   1 +
>  kernel/rcu/tasks.h       | 110 ++++++++++++++++++++++++++++++---------
>  5 files changed, 90 insertions(+), 28 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

