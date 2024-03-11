Return-Path: <linux-kernel+bounces-98969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7A28781B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39F3B22F42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04440843;
	Mon, 11 Mar 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="E2TLIv+Z"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CE3FB8F;
	Mon, 11 Mar 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167752; cv=none; b=k2Q0B7feIkD/G0vCMzY0mklSa0CAShhrUy83vK0XNTR2dMYUpi4iVxANfMYnUw0jWTC4JI4rnBznEypYpXc4fpiKeinBUpXhWaph7ii4dwtSogDj3XWR6PNI422ucbxhhOq1emLBmUnxpCED4orNUTHwLXn7hsORo2ToR5IgdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167752; c=relaxed/simple;
	bh=eS2AA1HymDS+4IYH13YDjFki4s+8SSS5wQAF97x5SX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2o7nVq7Zs9E1LLCkheUSClf4mtOZ+AxIN2R8mkc26n111CxjF/Ry7SFim2INTliyWIlCTO3WrNRfaKcOku93ezQ82blIR9Zwq4vJdTL7ll8r1qXbQKScc5mgqhYzx+n/ktuHcV4kz7Tz1EQhwhFOhAEyr+Ced/Vj94E+oFYXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=E2TLIv+Z; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1710167741; bh=eS2AA1HymDS+4IYH13YDjFki4s+8SSS5wQAF97x5SX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2TLIv+ZCPBCP8m5kQKgo81WNy2fJBkPhN2lNYWlMgX9xPpBxtBtC8BQIPPXtm2Js
	 abxOk9RmxD+74hUaUXTeAOjtNmVVxJMgnXq8QY0qfmcPSYEPdaJL96WlLu+fmiwIQ2
	 Sw6d0qiXvbMmsmM3KmQkx8e0m4VnltjsYzh8AS1uZi18chDeWMqolqjBxU+h/ksHcr
	 OFp0LNGYrFcAKDtKBN8HZyWnb3p46HNN9AZdYkALLUgqDVp90CXwshDpLw/sNQTtPI
	 NBZ9HJn0ghc1XDTaPjaMuccUzbTWA1Az6VOt3+PFCoCcAmnPOoizQlQFseQ1Zzpw25
	 PSqZaBKEAyj7g==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 2FF35100100; Mon, 11 Mar 2024 14:35:41 +0000 (GMT)
Date: Mon, 11 Mar 2024 14:35:41 +0000
From: Sean Young <sean@mess.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: rc: gpio-ir-recv: Remove unused of_gpio.h
Message-ID: <Ze8WvTnlay4mDhgi@gofer.mess.org>
References: <20240304180510.1201042-1-andriy.shevchenko@linux.intel.com>
 <Ze8Ubb5YQ4DzNHTt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze8Ubb5YQ4DzNHTt@smile.fi.intel.com>

On Mon, Mar 11, 2024 at 04:25:49PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 04, 2024 at 08:05:10PM +0200, Andy Shevchenko wrote:
> > of_gpio.h is deprecated and subject to remove.
> > The driver doesn't use it, simply remove the unused header.
> 
> Sean, are you okay with this change?

Looks great, I've applied it my branch.

Thanks,
Sean

