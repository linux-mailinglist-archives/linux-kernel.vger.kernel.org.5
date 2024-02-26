Return-Path: <linux-kernel+bounces-81282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354FE867352
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671D21C22747
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B021F606;
	Mon, 26 Feb 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="JEn2yVgf"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826351CF8B;
	Mon, 26 Feb 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947417; cv=none; b=aQYAAHYzQDQ9jxxnS2MuWIl33wP+Txc17XG+npJ+yTG0MeEOEjyCXMzE7cFBVX4qPLQ3RTDKedhD8L5H9uOWupBb31TyEAOOgxgSmR50eHkhn9QUzQJeK6ySu9VXsBbPrIBGkX+3alo6Js1lQY5SOMAZlERyOeA1MSrdjUtu9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947417; c=relaxed/simple;
	bh=2gjWfX3Fc1Tup8W+A/vxOWi6G6eBFO8CGRc8GajV1so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXRzIZZxkZ5S/Ctlpd/8vDG/8h5dN6ho32GhZW4A/kOE55Urre+9UFVC343hbTIyRi/E6NBKQKqrlvI+9mbwK5RQjipX8SD7lgTTyDDdOuzGH2PjOgiR04610v3F4VckI3LUKbU8w9tHCZFwTjq2k7vQ2D0UPRwCS0b9nmayscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=JEn2yVgf; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 7683C604E8;
	Mon, 26 Feb 2024 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708947414;
	bh=2gjWfX3Fc1Tup8W+A/vxOWi6G6eBFO8CGRc8GajV1so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEn2yVgfsfj5NPH4gKFcoGsAZ2zFvLFE1gGqsFUXi4F5eiv1d7EPy/OthWqVOi35D
	 owQH9f11huETnaCfd73zeTEl9Cq75mp0uboQUUiSDF78xRAEekDpCyzUhNY+1wwI89
	 yZySQYo+su5nxSt4bJ//xgP4lmARqE3CPhoFwqXQgS0dDKw9E2YkDbPhQr5Vv0sxbN
	 XVj4b/9Qjc0mnlYJ3JOZ4q9zOaKkc/dY7nEYGZF6Sft3Rj5zjeX2LlIHUqASFC6647
	 tS7XpetHF8fLEfloR/qhGtfD5kBTmaMTKElvKhD0MEOwWzTYl5qpQ6PKJsdq2fpVUo
	 +IQ86qpl4KJSQ==
Date: Mon, 26 Feb 2024 13:36:35 +0200
From: Tony Lindgren <tony@atomide.com>
To: Lee Jones <lee@kernel.org>
Cc: Andreas Schwab <schwab@suse.de>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, robh@kernel.org,
	wens@csie.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6030-irq: Revert to use of_match_device()
Message-ID: <20240226113635.GX52537@atomide.com>
References: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
 <mvmttm4ye5q.fsf@suse.de>
 <20240219143312.GA10170@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219143312.GA10170@google.com>

* Lee Jones <lee@kernel.org> [240219 14:33]:
> On Mon, 19 Feb 2024, Andreas Schwab wrote:
> 
> > On Okt 29 2023, Peter Ujfalusi wrote:
> > 
> > > The core twl chip is probed via i2c and the dev->driver->of_match_table is
> > > NULL, causing the driver to fail to probe.
> > >
> > > This partially reverts commit 1e0c866887f4.
> > >
> > > Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")
> > 
> > That commit id does not exist, which is why it hasn't been picked up by
> > stable.  The correct commit id is 830fafce06e6f.
> 
> It hasn't been picked by Stable because no one sent it to Stable. :)

Andreas, can you please send an email asking stable to pick it up?

See Documentation/process/stable-kernel-rules.rst for details.

Regards,

Tony

