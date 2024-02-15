Return-Path: <linux-kernel+bounces-67829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6132857192
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898FD282790
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FCD141995;
	Thu, 15 Feb 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJj/mCNx"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622991EA80
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039632; cv=none; b=b69NSgBFgk9YVZujuIExFSqDOn4fO5eo5wkgzKnofO/nEAf5FcYVhjRNJzppQnpgkEDJ+MQnftMTgHPq5UhlhUQEHbmzz1140Asg7y/fRZYaWMlnuYIzFSB/4xWddjm4uXnut6VcXk7oZrKVCyRzQsCsY1q6bz40M//iw9on1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039632; c=relaxed/simple;
	bh=hI3IaNmwmpoigHgr4TUjO4N23cGdnPbSDl/n7qwEBTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyqLioEAMyse1F09/G2dzI/GHZsmrFP2xO9UrKz6Kh8cvdKFDUJWziOcUIkqscEn4shyOVudERHml2nZvCJdJr4/7xJ80Fqrf/jQFIAdLiPZJq9wJLRyPFJq5aGCGygT6t1cMu8pxas1O4cqxLPqfFoXy7dBoPmAmWdXuCZfifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJj/mCNx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 18:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708039622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoqQs6b93PcUanm6LA7hi60ibIXjv2o5oOJV4LJzspg=;
	b=BJj/mCNxAyPczvn/s/2kbFkdB6c56NTDOkE/tE7Zr3JX61Dt5lmruksGqStkuKCzudRbzF
	hEbNfoS3fqkBeEj+iQz+wh5dBCcTpwakdCy+8STghQU/7WlUVe//1NK1UnCKKhqGlSpkrM
	9Si9VqvyYDqvwJyvsyonUX4WW3P7cWQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
	fuyuanli <fuyuanli@didiglobal.com>
Subject: Re: [PATCH] kernel/hung_task.c: export sysctl_hung_task_timeout_secs
Message-ID: <gbzf3rqo6edvan3lzdx7udc3hzfwfjh3c74lm6ruegu5cwg64q@lt4ghwp5y33f>
References: <20240209070935.1529844-1-kent.overstreet@linux.dev>
 <Zc2giqMeZhxuDSU9@infradead.org>
 <20240215105509.b7b3c87c24ed35cdfb111f34@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215105509.b7b3c87c24ed35cdfb111f34@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 10:55:09AM -0800, Andrew Morton wrote:
> On Wed, 14 Feb 2024 21:26:34 -0800 Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Fri, Feb 09, 2024 at 02:09:35AM -0500, Kent Overstreet wrote:
> > > needed for thread_with_file; also rare but not unheard of to need this
> > > in module code, when blocking on user input.
> > > 
> > > one workaround used by some code is wait_event_interruptible() - but
> > > that can be buggy if the outer context isn't expecting unwinding.
> > 
> > I don't think just exporting the variable ad thus allowing write
> > access is a good idea.  If we want to keep going down the route of
> > this hack we should add an accessor function that returns the value.
> > 
> > The cleaner solution would be a new task state that explicitly
> > marks code than can sleep forever without triggerring the hang
> > check.  Although this might be a bit invaѕive and take a while.

I had the same thought.

> A new PF_whatever flag would solve that simply?

TASK_* flags are separate from PF_* flags, fortunately, and it doesn't
look like anything but TASK_* flags go in task_struct->__state, so
this shouldn't be a difficult change.

> Which are the potential use sites for such a thing?

There's a few places in the block layer that are using the sysctl value;
those will be easy to fix. There's definitely more places abusing
TASK_INTERRUPTIBLE, but aside from the ones in my code I can't think of
a way to search for them.

But the block layer ones look a little suspect to me: the commit message
indicates they were added becasue discards on some devices can take >
100 seconds - which is true, but this is a more general problem, there's
other places we block on IO.

Might want to give this some more thought.

