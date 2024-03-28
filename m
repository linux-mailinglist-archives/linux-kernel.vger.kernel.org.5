Return-Path: <linux-kernel+bounces-123306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E130B890653
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4651C21909
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A326C12D753;
	Thu, 28 Mar 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xxpi53HM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85153F9D4;
	Thu, 28 Mar 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644601; cv=none; b=dZS0dEgZJn4/9LHW0hSSmE7vL0rpe25u9FFTgl0VpEmVIU053NOhHnbcOwhhuMJPhjPaQ4wxRpaZXM7Ux+G+eL3F4IvJqe/kD0Ao2WHv59ULj6QxtXDYbhXe8m+lnxNrr3+h1qJAXTjh/h83C4nFEE3NS7EG8RN6bpSxPQGRhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644601; c=relaxed/simple;
	bh=xGGADh4akfeiszNVR/Er4vkIxCrGC1E74wXmXfZjO5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ84K0TDylEXugC7tfwtMhN3y5jAX0dWoNYssVyoBNfx5e5Jb0RNfA1i0CSzJHYozj4poRVnE13QzEv1coZJRj99N1Nc5YSx+M1B1ZNK149vsGxQGfmkHFPPacEkWgQmG31oe5+JlIjH1jKmjxZ4EF1Fmi9GHnyiTogsmdOF+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxpi53HM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59F2C433C7;
	Thu, 28 Mar 2024 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711644600;
	bh=xGGADh4akfeiszNVR/Er4vkIxCrGC1E74wXmXfZjO5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xxpi53HMGuyVF0fPqf1WvDJbGVVLBENGCi1DoAi2DTeqykC1yQDu17lHtasFancPD
	 JB2l8EknpAWB08LTRH+jFET6wPq/AmDEe9NjTpUpD1q9KrkEekoRwtjbvzJVBgICKZ
	 xWLRyYP50dP7SxuuvGUS2BTBhO2yAGpmXIflloFs=
Date: Thu, 28 Mar 2024 17:49:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] video: backlight: constify struct class usage
Message-ID: <2024032817-avatar-agony-c17d@gregkh>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
 <20240328114131.GB13211@google.com>
 <2024032816-tightrope-lushness-00f1@gregkh>
 <anuaxqt2zlravjpepkuhqmii3adjdeh3lzal3wwb7rg7krv6uu@7sbwczq3flot>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anuaxqt2zlravjpepkuhqmii3adjdeh3lzal3wwb7rg7krv6uu@7sbwczq3flot>

On Thu, Mar 28, 2024 at 09:46:01AM -0300, Ricardo B. Marliere wrote:
> On 28 Mar 13:01, Greg Kroah-Hartman wrote:
> > On Thu, Mar 28, 2024 at 11:41:31AM +0000, Lee Jones wrote:
> > > On Tue, 05 Mar 2024, Ricardo B. Marliere wrote:
> > > 
> > > > This is a simple and straight forward cleanup series that aims to make the
> > > > class structures in backlight constant. This has been possible since 2023
> > > > [1].
> > > > 
> > > > [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> > > > 
> > > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > > ---
> > > > Ricardo B. Marliere (2):
> > > >       video: backlight: make backlight_class constant
> > > >       video: backlight: lcd: make lcd_class constant
> > > > 
> > > >  drivers/video/backlight/backlight.c | 29 ++++++++++++++++-------------
> > > >  drivers/video/backlight/lcd.c       | 23 +++++++++++++----------
> > > >  2 files changed, 29 insertions(+), 23 deletions(-)
> > > 
> > > No longer apply.
> > > 
> > > Please rebase on top of v6.9-rc1 or for-backlight-next.
> > 
> > As I already had this in my local tree, I've sent out a v2 at:
> > 	https://lore.kernel.org/lkml/2024032805-putdown-mushy-a0f9@gregkh/
> 
> Thank you Greg. I will see what is left to be made const for -next.

Many of your patches were not picked up for -rc1, I'll be taking a bunch
of them into my tree "soon" as that usually means the subsystem isn't as
active.

thanks,

greg k-h

