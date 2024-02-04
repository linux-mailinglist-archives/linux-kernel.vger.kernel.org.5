Return-Path: <linux-kernel+bounces-51655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624D848DF8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88071C228EB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFDC224D6;
	Sun,  4 Feb 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzwBeV4L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C53224CC;
	Sun,  4 Feb 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051976; cv=none; b=mrTVfABiGMTS1QmCsErWRFhXtYENCscGRXdUh3z+ygLp6Rxmj4em1OJhoqcUVJFb5pCgMMlRgJtEsFldeGKRbJOC+pNZItFy2B0gqp1YCL5jmvwIrmLNnAPXU/ejw5ECc6eBbK9Uo3Gfd4Cc2pFj94bWjQppktGx46Yn49Z/9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051976; c=relaxed/simple;
	bh=8F9gI+12tY7oFI2qZxOeJGqM/wEKqf6RNcHmEbMRFuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh3tpy7xGV77bdpgDBPVw0eOZCPW4Ng31nwWlhTsMJhF9scpxxXkLd4stbpGL4QCQgCa5tp82mCcyR9r62PuhgrPEcjuTPBW3DFt1cn8rc5HpZ91EfcbQjmALxU2cwbayWVmwrMVjH5FyAIRi2lusZ6LpF4nesYd5UgpIfNu2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzwBeV4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123F1C43390;
	Sun,  4 Feb 2024 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707051976;
	bh=8F9gI+12tY7oFI2qZxOeJGqM/wEKqf6RNcHmEbMRFuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gzwBeV4LI6rpss0OpFsc4P00jJEDtTqGmXyexsgmffYKA+vP0gStrZUc6+2hYb1gI
	 /WQn7FNcD33eroxSvvx0eSQwE5G9GDuk65zG2wj353zGPk8okMN+mDLXC5kcmaZDWT
	 2Q9sY3UAtDGHD0LxsmfIc23DuwyfOvR0shoT5D48eWjpnOa1C4mbVnbvYh6sZIPFq0
	 a7wRlIo/sryVSBeTOovBOXuMI1OV79q5t2jrPPgChEsMkf4WfD2nYAD6cgvLTJFfFH
	 09MXjQ3s6MuwUskcnwUe0Rx6ciebohYF5YGvk85rI03cWX32DGkx8KxpWhC5jBZe5a
	 47XKhdkTCUYRQ==
Date: Sun, 4 Feb 2024 13:06:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Haibo Chen
 <haibo.chen@nxp.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Liam Beguin
 <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev
 <bigunclemax@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>, Mark Brown
 <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>, Okan Sahin
 <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240204130600.37083440@jic23-huawei>
In-Reply-To: <ZbuCqEWqpDadeF_v@smile.fi.intel.com>
References: <20231213094722.31547-1-mike.looijmans@topic.nl>
	<1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.27993507-256d-4b05-88df-c8643e7f1a68@emailsignatures365.codetwo.com>
	<20231213094722.31547-2-mike.looijmans@topic.nl>
	<ZXnF72wJCAeYWA8X@smile.fi.intel.com>
	<406d445a-3ce3-4253-8966-de2dac6f7c23@topic.nl>
	<ZbuCqEWqpDadeF_v@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 13:38:16 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jan 31, 2024 at 05:10:08PM +0100, Mike Looijmans wrote:
> > On 13-12-2023 15:55, Andy Shevchenko wrote:  
> > > On Wed, Dec 13, 2023 at 10:47:22AM +0100, Mike Looijmans wrote:  
> 
> First of all, please remove unneeded context, don't make me waste time on doing
> that for you!
> 
> ...
> 
> > > 		*val = sign_extend32(get_unaligned_be24(priv->rx_buffer + chan->address),
> > > 				     23);  
> > 
> > Doesn't fit, first line is 83 characters by my count...  
> 
> Is it a problem?

To add a bit more info here. For IIO at least (and most of the rest of the kernel)
it's fine to go over 80 chars if there is a significant cost in readability to break
the line.  Here that is the case + you are only going 3 chars over so it's fine
to do so.

Jonathan

> 
> 


