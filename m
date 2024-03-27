Return-Path: <linux-kernel+bounces-121382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C85B88E73B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1511C2ED17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B2213B2B2;
	Wed, 27 Mar 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IxMEOz0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73212DDAF;
	Wed, 27 Mar 2024 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547024; cv=none; b=ACNWhOptIFHL9QPPWUwTmxranYn17K0w2s3/7w6Gz0iQ9IJHiKzpw3XoiEXG369i3kCtB4ImUbYo3u1ZXvR+XT7JQCtxY0rvv8lUNexuQJW269FfAi3gxs9LKX9bn/C/9kSaN4XZ6N6Z+g8KLwwqPigXtnfp6AcxW7s0Njslqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547024; c=relaxed/simple;
	bh=jDFSsc2I8O7lsiinPAqe5K2U9ZhqiVvG7UDP4Qyx7bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLSNory83q06/POaex2LgFb8j+05nnScU6gxvS1RzfiSha/YgMCMYoU+FB7YOHhXbh7okBx+qGGy4Rj6RPYtQQ8gPYK8TkiFlUkk8DT75CnJAHMJz001MKsDxlFxeiT25HwhhqGtVlii9TSQp2WXBhgWn4yeun4c5UY6KqfI4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IxMEOz0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EBDC433F1;
	Wed, 27 Mar 2024 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711547023;
	bh=jDFSsc2I8O7lsiinPAqe5K2U9ZhqiVvG7UDP4Qyx7bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxMEOz0souoepUUY4FjZnzzZPm/Qz+ztLIF3UheOgq/xHV9PJ9vdx1xUXwAurB8wG
	 MyrGCWjKP/blb6quJBwXmjPi7KbiJNvn4c/5qosGkGKJ6cdLeo6v0GDkn9qvdGlqq/
	 1iw+HuEHc/hUwNxBXtO6NJd0umi+d0NrlnDf1Pi4=
Date: Wed, 27 Mar 2024 14:43:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Audra Mitchell <audra@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6.8 002/715] workqueue.c: Increase workqueue name length
Message-ID: <2024032733-freebase-dipped-0b4b@gregkh>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-3-sashal@kernel.org>
 <10844429-b80f-ca9d-bf1d-c42efcc635f6@w6rz.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10844429-b80f-ca9d-bf1d-c42efcc635f6@w6rz.net>

On Tue, Mar 26, 2024 at 02:36:22AM -0700, Ron Economos wrote:
> On 3/24/24 3:23 PM, Sasha Levin wrote:
> > From: Audra Mitchell <audra@redhat.com>
> > 
> > [ Upstream commit 31c89007285d365aa36f71d8fb0701581c770a27 ]
> > 
> > Currently we limit the size of the workqueue name to 24 characters due to
> > commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
> > Increase the size to 32 characters and print a warning in the event
> > the requested name is larger than the limit of 32 characters.
> > 
> > Signed-off-by: Audra Mitchell <audra@redhat.com>
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   kernel/workqueue.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 7b482a26d7419..8a06fddb23e66 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -108,7 +108,7 @@ enum {
> >   	RESCUER_NICE_LEVEL	= MIN_NICE,
> >   	HIGHPRI_NICE_LEVEL	= MIN_NICE,
> > -	WQ_NAME_LEN		= 24,
> > +	WQ_NAME_LEN		= 32,
> >   };
> >   /*
> > @@ -4666,6 +4666,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> >   	va_list args;
> >   	struct workqueue_struct *wq;
> >   	struct pool_workqueue *pwq;
> > +	int len;
> >   	/*
> >   	 * Unbound && max_active == 1 used to imply ordered, which is no longer
> > @@ -4692,9 +4693,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> >   	}
> >   	va_start(args, max_active);
> > -	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> > +	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> >   	va_end(args);
> > +	if (len >= WQ_NAME_LEN)
> > +		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
> > +
> >   	max_active = max_active ?: WQ_DFL_ACTIVE;
> >   	max_active = wq_clamp_max_active(max_active, flags, wq->name);
> 
> Minor issue. The upstream commit 8318d6a6362f5903edb4c904a8dd447e59be4ad1
> "workqueue: Shorten events_freezable_power_efficient name" goes with this
> patch. Otherwise the warning "kernel: workqueue: name exceeds WQ_NAME_LEN.
> Truncating to: events_freezable_power_efficien" occurs.
> 
> Same for 6.7.11-rc2 and 6.6.23-rc2.

Now queued up, thanks.

greg k-h

