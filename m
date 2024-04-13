Return-Path: <linux-kernel+bounces-143685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3468A3C46
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B97EB217E7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44E2134A;
	Sat, 13 Apr 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dhs9733Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAC1D688
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004931; cv=none; b=nsPWBZRAkhNBV+Jw5CVl/4wy7KGqEiKsynurgBgUtbHGhwTZNEpVHc5rt43uJybKFvJWCDFjE4UdiMoqr27Pw06ketlf3BEwy3Qtg2Vs7umzy0ISLEmroyKVc860JF3uaxwEQnymcfdGlByNt7H7CxT5hiOV18n3eVDliDnhTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004931; c=relaxed/simple;
	bh=rzoC/rjGvsejklgiGORB3oApd2mMQ8Jn1iazSLrhmzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuOiXPChjsNT4keTcIZS03q2BmNg5mVLNf9PIEM7L6G2E00LGF6OYc/QLp8L+J73S/InPgVyFDmHMvB0rmMaUg/6V0C3QFRHA19nU1xC8CZDh/7E4hLKvPoY/iSCI3R/7a2VMmpZ4TWNtMxKiyQQQNwHcW0cUe7Lq8x5DxMjOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dhs9733Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7808DC113CD;
	Sat, 13 Apr 2024 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713004930;
	bh=rzoC/rjGvsejklgiGORB3oApd2mMQ8Jn1iazSLrhmzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dhs9733QPGI1lDZ4H1kFb5RJPB18vu/66BHJB2MGncwgX4tgPwv1TfpqZcEeES8yo
	 WNjvbAIOszReLpjVCJLNY8a2uDGWIRLREj9F41+AqYJMjG/Xdf0AWhBXMXFiRv267Z
	 SXC2Mxn1ACGXtNuu1VWSTSmB3Sa7q6ZNU7WwIpBE=
Date: Sat, 13 Apr 2024 12:41:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Puneet Gupta <puneet.gupta@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>, linux-kernel@vger.kernel.org,
	Abhijit Gangurde <abhijit.gangurde@amd.com>, kernel@pengutronix.de,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH] cdx: Convert to platform remove callback returning void
Message-ID: <2024041316-unwrapped-parchment-88d8@gregkh>
References: <5d40f57e978bcce003133306712ec96439e93595.1709886922.git.u.kleine-koenig@pengutronix.de>
 <wyt4jvdvbq4wrgxslwkdeg3e6mhjtfue4xwdec7sil3whhromv@57xjgduvont7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wyt4jvdvbq4wrgxslwkdeg3e6mhjtfue4xwdec7sil3whhromv@57xjgduvont7>

On Sat, Apr 13, 2024 at 12:12:56PM +0200, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Fri, Mar 08, 2024 at 09:51:05AM +0100, Uwe Kleine-König wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> > 
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> > 
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> we just talked in irc about this thread that might have fell through the
> cracks on your side.
> 
> Thanks for reconsidering to apply it for v6.10-rc1,

Now applied, thanks.

greg k-h

