Return-Path: <linux-kernel+bounces-94674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7368742F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646341F228CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7629E1BDD8;
	Wed,  6 Mar 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c631OACJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0841B7E4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765206; cv=none; b=KTDwmTHkK4jXoG9V9aDH2LpkfQwc47FQnlG/NyHjLokKsKFmp/JgBt9kCQNbf+hjbcmTlhZ422bFNhOJdevt9dsR0cw8Pi/OkexNoLY6tCgA4YP3eLZgqCzQ+4v+ygWMmqfQQgKXnlRyTxdvNlocmrN8mkrQ/L6T0/p0WsbEHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765206; c=relaxed/simple;
	bh=IIyzKQaugyVEay7v/TS1NkBvw201LO7QQeSmsI0yQ8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr0Mm/B1QH03RPH6znBIUbU0+64YepiIRdO8h1nRnX4O4Y894WrgKYyJYa2QWaedRTS/OXfh6bk/6Bt3UKDOZHIbJzRMd2+V7wFOd6n892iGH7z0yjVc0ZJ5r2KG4WgAgJ5dqTIhKpKFM36Ps/TilHIhSGi209EnZGayBeRFwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c631OACJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA505C433C7;
	Wed,  6 Mar 2024 22:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709765206;
	bh=IIyzKQaugyVEay7v/TS1NkBvw201LO7QQeSmsI0yQ8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c631OACJtyyGVZVywHRNQs9fxY3OBMDO1ibEtIKfvcD7tKf6EmKMQykSzqla8AI+9
	 Rzrx5eSiRTEuUwiT2X5ccxWy+h0JZVWpBxSzrQwYNdDxr222btu7i5gak/g3zlkx91
	 Ru2wtdDe7EHSHAOZkU1BndCxbnHyP+gQJrfUZlS8=
Date: Wed, 6 Mar 2024 22:46:43 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Thorsten Scherer <T.Scherer@eckelmann.de>,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: siox patches for next development cycle [Re: [PATCH 0/4] siox:
 Move some complexity into the core]
Message-ID: <2024030655-sketch-conical-b506@gregkh>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <lkgvr2t4wzw4jkfg523zcek6y2v5l7kj6onw77yffvvs7i2gfy@6ectsjpcg64t>
 <vg5yex3wpnfeibgkwmi33yazdxdz2pbhn4w72mnffqm3qtvjf6@gv3syxj6gsk7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vg5yex3wpnfeibgkwmi33yazdxdz2pbhn4w72mnffqm3qtvjf6@gv3syxj6gsk7>

On Wed, Mar 06, 2024 at 07:24:38PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Feb 27, 2024 at 11:21:24AM +0100, Thorsten Scherer wrote:
> > On Mon, Feb 19, 2024 at 08:46:28AM +0100, Uwe Kleine-König wrote:
> > The series looks sensible.
> > 
> > Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>
> > 
> > @gregkh: Would you please pick up Uwe's series as well?
> 
> There are currently six patches for drivers/siox waiting to be applied.
> (Two by Ricardo and four by me.) Thorsten asked Greg to do so. Greg
> didn't pick these up yet though. So I collected them and put them to a
> branch at:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git siox/for-next
> 
> I'd like to get them in during the next development cycle.
> 
> Greg, what is easiest for you? Are they still on your list of open
> patches and we (I) need just a bit more patience? Or should I send a PR
> to Linus when the merge window opens?

Yes, they are on my list, but I am way behind, sorry.  But hey, a pull
request is faster, I'll go take this now, thanks!

Oops, nope, I get the following build error with this tree:
	ERROR: modpost: "devm_siox_master_alloc" [drivers/siox/siox-bus-gpio.ko] undefined!

So are you sure you tested this?

thanks,

greg k-h

