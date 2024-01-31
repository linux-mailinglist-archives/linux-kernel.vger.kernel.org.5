Return-Path: <linux-kernel+bounces-46777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0668443FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D66B230A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E747412BE8D;
	Wed, 31 Jan 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztUlj6r1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8D12A146;
	Wed, 31 Jan 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718170; cv=none; b=pMI/yMUqVBsaRo0X6HqioXAIz8p3+kV9Z4Gl35zE0s9s6ChqVHNM4KK+nf6i6NhER6+wRaVMscUfnOU2jEqQbqszGmWmV/I845tVFTldM5d4IYHst5uy19SQIvruVclmXGYOpfbMo83uH/Ftc17RIemd9Y9Y+fCds6+ErMhTK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718170; c=relaxed/simple;
	bh=cgqvIXY2Y6ujV/j24/sdO9SiSv1S/a3wo9WZsazN5KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWG1yYmyqO5lq8dsYihtvSRFzP5eW2lVWr5dqHJgyMmq53TPVr/PpBu+QkewAuAEJ6ZTIaRLl2sNOT2T4TWo5bSELWWEZgu0joubuxZB5EwDMn5Wh8ZflCjpe6d6ENwnc1N7ThaeY+lYG4uYFZWT2B/QEZww3vm+18/cOaXJfdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ztUlj6r1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52923C433F1;
	Wed, 31 Jan 2024 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706718169;
	bh=cgqvIXY2Y6ujV/j24/sdO9SiSv1S/a3wo9WZsazN5KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ztUlj6r1C3QWmhHr8PeOKtvt3MbKGvpQMs2jmB6RTKF7ovM+Nr2MGanVh8TIKcUc4
	 4txSI7YtPg0yD4Q0rh2TB3JxzcyrflSpviYGG3jQUroC3aZdOd9OqRqHTecGDm6a8Z
	 BMEHMK0A7DKOVAbk+sStoc162pmZM43u0s1zG35M=
Date: Wed, 31 Jan 2024 08:22:48 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: John Garry <john.g.garry@oracle.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, rafael@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	keescook@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
	nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
Message-ID: <2024013158-dipper-mural-424b@gregkh>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131104851.2311358-1-john.g.garry@oracle.com>

On Wed, Jan 31, 2024 at 10:48:47AM +0000, John Garry wrote:
> When hacking it is a waste of time and compute energy that we need to
> rebuild much kernel code just for changing the head git commit, like this:
> 
> > touch include/generated/utsrelease.h 
> > time make  -j3
> mkdir -p /home/john/mnt_sda4/john/kernel-dev2/tools/objtool && make O=/home/john/mnt_sda4/john/kernel-dev2 subdir=tools/objtool --no-print-directory -C objtool 
>   INSTALL libsubcmd_headers
>   CALL    scripts/checksyscalls.sh
>   CC      init/version.o
>   AR      init/built-in.a
>   CC      kernel/sys.o
>   CC      kernel/module/main.o
>   AR      kernel/module/built-in.a
>   CC      drivers/base/firmware_loader/main.o
>   CC      kernel/trace/trace.o
>   AR      drivers/base/firmware_loader/built-in.a
>   AR      drivers/base/built-in.a
>   CC      net/ethtool/ioctl.o
>   AR      kernel/trace/built-in.a
>   AR      kernel/built-in.a
>   AR      net/ethtool/built-in.a
>   AR      net/built-in.a
>   AR      drivers/built-in.a
>   AR      built-in.a
>   ...
> 
> Files like drivers/base/firmware_loader/main.c needs to be recompiled as
> it includes generated/utsrelease.h for UTS_RELEASE macro, and utsrelease.h
> is regenerated when the head commit changes.
> 
> Introduce global char uts_release[] in init/version.c, which this
> mentioned code can use instead of UTS_RELEASE, meaning that we don't need
> to rebuild for changing the head commit - only init/version.c needs to be
> rebuilt. Whether all the references to UTS_RELEASE in the codebase are
> proper is a different matter.
> 
> For an x86_64 defconfig build for this series on my old laptop, here is
> before and after rebuild time:
> 
> before:
> real    0m53.591s
> user    1m1.842s
> sys     0m9.161s
> 
> after:
> real    0m37.481s
> user    0m46.461s
> sys     0m7.199s
> 
> Sending as an RFC as I need to test more of the conversions and I would
> like to also convert more UTS_RELEASE users to prove this is proper
> approach.

I like it, I also think that v4l2 includes this as well as all of those
drivers seem to rebuild when this changes, does that not happen for you
too?

Anyway, if the firmware changes work, I'm all for this, thanks for
taking it on!

thanks,

greg k-h

