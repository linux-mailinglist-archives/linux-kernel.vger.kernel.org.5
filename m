Return-Path: <linux-kernel+bounces-36404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB4183A023
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE21294126
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C0C2D2;
	Wed, 24 Jan 2024 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="k03q1MTw"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71BDC131;
	Wed, 24 Jan 2024 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067312; cv=none; b=pwgWn+MAgL8c7gS881fpGx/XUTEM9tTJqIVOgGazQCN+VpY9KjMR/ajCkT9Z0DCPLUD+0XGyN6eiIEjbkHjzNY0dvqFb6w6sQdXLqiOdl4P+aEKtBZ4pr0Tcn/+I/QaTYqggpAdXiF8O1JSDYfkb0RtD5xy7Oxaxw7LiD/UYjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067312; c=relaxed/simple;
	bh=VXBPWnkkL+AQhwvJV7ZF0sajxS0QjAMs9aF6VeovhLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pU+3QQFn8fkn41zO5N7+9PGN3GNTfDx0DZGtOUrfXisn7aDglvDEK+dZ0MZDSpOYH14/KZOtP/Faox/SsoBJt5sDzIGRLjWXw1st3Jk6g+w9qwIkEN1zMjlkMADacQu2AziYBbQ2PbodpT1+nRBt/JL0BYX/lo62tqqROzucMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=k03q1MTw; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=684JbBC38tKWKnzRDJ3Jbbmhn9UVaUIy+vs9EjmX8P4=; b=k03q1MTwsnTovFX5Ne+WnwRx5M
	78y/9iLDybuNFQPth6y5dFuthSZVsXxdOlikUWKrYYslQ3Er7y+QYBsujtBfPSZp/y237UsI+rPih
	Bmrw7UxNB02olEts4/DiTNrPU/qBL477NVEK2JJl/FEAzp8SYQaoRX/nYrwYFu2k2XzEzFEdIbmf5
	DrqdVZkjyUF/xrwNfcLL6CTJ+WhNHrQjjyom428OrXVxRi/wC6EjAoLCPCn8bnXzPULRuMfRHyTS/
	ARtZSzoWwxb2E3a3DADn6QZCQXEzmTvg1mAn1dX4VVX189gJ/yeZFcBUQh7CBJvBcQbM3W+PC/f82
	Wks7Hp+A==;
Received: from [10.69.139.2] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSU2a-00DdED-20;
	Tue, 23 Jan 2024 21:35:04 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject:
 Re: [RFC PATCH 3/9] ntsync: Introduce NTSYNC_IOC_CREATE_SEM and
 NTSYNC_IOC_DELETE.
Date: Tue, 23 Jan 2024 21:35:04 -0600
Message-ID: <5746919.DvuYhMxLoT@terabithia>
In-Reply-To: <2024012301-dork-awry-c9ad@gregkh>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-4-zfigura@codeweavers.com>
 <2024012301-dork-awry-c9ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 23 January 2024 19:14:17 CST Greg Kroah-Hartman wrote:
> On Tue, Jan 23, 2024 at 06:40:22PM -0600, Elizabeth Figura wrote:
> > +static int ntsync_create_sem(struct ntsync_device *dev, void __user
> > *argp)
> > +{
> > +	struct ntsync_sem_args __user *user_args = argp;
> > +	struct ntsync_sem_args args;
> > +	struct ntsync_obj *sem;
> > +	__u32 id;
> > +	int ret;
> > +
> > +	if (copy_from_user(&args, argp, sizeof(args)))
> > +		return -EFAULT;
> > +
> > +	if (args.count > args.max)
> > +		return -EINVAL;
> 
> No bounds checking on count or max?
> 
> What's the relationship between count and max?  

Indeed, no bounds checking. The counter is just the semaphore's internal value 
and has no meaning other than that.

It's basically like an EFD_SEMAPHORE, except that the maximum is configurable 
rather than always being 2**64-2.

> Some sort of real
> documentation is needed here, the changelog needs to explain this.  Or
> somewhere, but as-is, this patch series is pretty unreviewable as I
> can't figure out how to review it because I don't know what it wants to
> do.

There is some comprehensive documentation in the series, but for ease of 
review I will try to write a basic description of the API in each relevant 
patch in v2.



