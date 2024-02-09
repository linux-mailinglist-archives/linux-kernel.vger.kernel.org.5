Return-Path: <linux-kernel+bounces-60100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B984FFCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77156281ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3861F2E3E4;
	Fri,  9 Feb 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QgT3M5JW"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8D2134B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517367; cv=none; b=a9MmhK18RosbUNssulvOD2m8keIK6hTcQQNHs6vcQtfww7y3kGEcLdfvLVkW2WlfJWeeo/68HX8gviXGSY8ms9c/bF83cU++a8Z0saG1pk6Wtsk+b1sEW5FuIflF3R81RH5J2RI1dcM583BM/hCa1OuYcD0+7x0aYnaAEt7onU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517367; c=relaxed/simple;
	bh=crwM0s9o3DNmvvuHMXu38/kApI7jPbItz8f0lNqbz3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co+HwdtPI3lj23LpiFjeoq10ToiyTxVmYgcxKAOw3xm8E6ANItN1IB5GEv8ZIl0xhIZQ3wS3bzsImexucHbxHIuTbDeTlHKnvdSD6e/UftbxoanOvcAfMDv2TkMgO5uBkdvjnXF6gbilehBqrinM6vjahW8pGbnOEYhZRokY46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QgT3M5JW; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 9 Feb 2024 17:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707517362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jZJ2iUn1mvpFMmWP7gQAk92aZkJdfxn2oi12/Gdgdc=;
	b=QgT3M5JWKnHPEr9bL4rquUtW7R65YggiRMx8SHnyr2+18DG/9t+pGKqVsucp8rddaK2CaK
	S+nG/C4RDcDFrxVcHJQZh8MvYNDTT2u0+n+hHqk9ydDxl6+v+KU0rFLBq+CpOMZg0GgrEO
	IfRYh00tI+l4pX6IbfZIcS/GqJ6jA8Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, fuyuanli <fuyuanli@didiglobal.com>
Subject: Re: [PATCH] kernel/hung_task.c: export sysctl_hung_task_timeout_secs
Message-ID: <yzhtlroowrpgzcarjodgnev2p2ov7h2g3qeblakgbzp72uknqi@vgt4bdwhz4o7>
References: <20240209070935.1529844-1-kent.overstreet@linux.dev>
 <20240209141324.28cae36fe14c909058c1fed7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209141324.28cae36fe14c909058c1fed7@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 09, 2024 at 02:13:24PM -0800, Andrew Morton wrote:
> On Fri,  9 Feb 2024 02:09:35 -0500 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > needed for thread_with_file; also rare but not unheard of to need this
> > in module code, when blocking on user input.
> 
> I see no bcachefs code in linux-next which uses this.  All I have to go
> with is the above explanation-free assertion.  IOW this patch is
> unreviewable.
> 
> > one workaround used by some code is wait_event_interruptible()
> 
> examples?

fs/bcachefs/util.h kthread_wait_event(); we use that - among other
things - when the kthread is parked waiting for userspace to flip it on.

TASK_INTERRUPTIBLE was the suggestion I got years ago, but I want to get
away from it because -

> 
> > - but that can be buggy if the outer context isn't expecting unwinding.
> 
> More explanation of this?

We're starting to think about this a bit more because of David Howell's
proposal; the idea is that perhaps TASK_UNINTERRUPTIBLE vs.
TASK_INTERURPTIBLE vs. TASK_KILLABLE should probably not be set at the
waiting context, it should be set at the outer context where we would
handle (or not handle) -ERESTARTSYS.

think mutex_lock() vs. mutex_lock_killable(); that is bubbling up the
context specification in an ad hoc way. This would regularize that.

I've also seen bugs where code was doing a fixed TASK_INTERRUPTIBLE and
the outer context wasn't expecting that - kthread creation does this.

> 
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -43,6 +43,7 @@ static int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
> >   * Zero means infinite timeout - no checking done:
> >   */
> >  unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
> > +EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
> 
> It seems strange that a module wouild want this.  Makes one wonder what
> the heck is going on in there.
 
specifically, this is for thread_with_file, where we've got a kthread
hooked up to a file descriptor, effectively using it as both stdin and
stdout.

When the kthread reads from the fd, that can block for an unbounded
amount of time - we're waiting on userspace input and it's totally fine.

