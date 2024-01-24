Return-Path: <linux-kernel+bounces-36257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB5839DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE411C25A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33D137B;
	Wed, 24 Jan 2024 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e+HrVT+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AA1FAA;
	Wed, 24 Jan 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058858; cv=none; b=i5NabR/bHDIMHhtIULXe6bBMuPFVHZghu3/QRkhDbsM0CTQgkoMUyT4a5Q8by9MhYc9dXyAlh5M4YrWWbGG0Ycz6IWI1lP6kVu0vHOHRF5Oz/U63qurpT5p3X2BLh220MgVvUDuXgFQNhAeN7o9PLhP/kWbfQVnLcmBv5a0hIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058858; c=relaxed/simple;
	bh=qWcnJt0pf9bdDGsYcKVLk1NGTUvvib50FPZ8UjiLKug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgAf7xmMxZEVTAmUUTh4XbUzlZ9bQ0rgVsChKofO0azItK1BsWjAehRvtzYXr53RxBbHDueXsZu2SGCqcUabpM9GAe2RSxx8+eTT8c8v0EbrEow72geq4bbOHQXWe3e7fAg/n4sGA2msU5yDKDlpwqq3h64Sz04Js0PSjI3Zrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e+HrVT+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5D3C433F1;
	Wed, 24 Jan 2024 01:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706058858;
	bh=qWcnJt0pf9bdDGsYcKVLk1NGTUvvib50FPZ8UjiLKug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+HrVT+5RZvgPrFmWTd5dXq9JwoZ2LyffRT5//NQHo8gKxQtSATCZqdkRqVpPGe1Y
	 jsZA/B+5B38PgXqB0sJaJBEaPKPKUG9n7Y23iJ2DJKq6Dvz7GPHEKQY/jkQgJH3dU9
	 zIsyfoJleOh/3IA6c/JSimg4qBvDW5BUZ0S25COg=
Date: Tue, 23 Jan 2024 17:14:17 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/9] ntsync: Introduce NTSYNC_IOC_CREATE_SEM and
 NTSYNC_IOC_DELETE.
Message-ID: <2024012301-dork-awry-c9ad@gregkh>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-4-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124004028.16826-4-zfigura@codeweavers.com>

On Tue, Jan 23, 2024 at 06:40:22PM -0600, Elizabeth Figura wrote:
> +static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
> +{
> +	struct ntsync_sem_args __user *user_args = argp;
> +	struct ntsync_sem_args args;
> +	struct ntsync_obj *sem;
> +	__u32 id;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.count > args.max)
> +		return -EINVAL;

No bounds checking on count or max?

What's the relationship between count and max?  Some sort of real
documentation is needed here, the changelog needs to explain this.  Or
somewhere, but as-is, this patch series is pretty unreviewable as I
can't figure out how to review it because I don't know what it wants to
do.

thanks,

greg k-h

