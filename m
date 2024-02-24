Return-Path: <linux-kernel+bounces-79777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB0862689
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112F2282C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B1482DD;
	Sat, 24 Feb 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhuG9zt4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E5ECE;
	Sat, 24 Feb 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797585; cv=none; b=JTjuvV71/CDk5NTXKCrmDGA2eNZUw3dEKhYYoD3Dz+9HN2lDDqA9bh6f6NahwgL0GV5Lbn13FFJFVCKZfxORPi9oUIrIEyAxi9FXjhLYvjgcB7AvdUaCSDAQvPmR0GRvKLg3KqxO9GJCk0f6KE7i0nEPhZYGHewUGHsRBdptn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797585; c=relaxed/simple;
	bh=8G4raxEorwHg1cIbMoXqVqp32zreKMBGcCu9RJbSZKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmQu5BH8bRY7f0M5RRtWUUhygPn+x841rYSNbzmUu0g0C3O7LLxQbKw7XUO8//VtM3BMEPHvdhcTkdmwq5iVrS4jMU3gPfUrHt2DcpgnYDDkHVpG9djrvUvlmXYaCvw/8OOSh16YqUIP19a9pTRH5vEmtwVnSSpqstd46tyzemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhuG9zt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CBCC433C7;
	Sat, 24 Feb 2024 17:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708797585;
	bh=8G4raxEorwHg1cIbMoXqVqp32zreKMBGcCu9RJbSZKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BhuG9zt4vDDzXoDlbdnJWdljq3A4RYauEz3oZ34gQx3IwLdia6R+yozUxFFUIBGGW
	 Ei74tTFSSBeJJIC5zDaLYsx12MaLXXZ0u+4RO3Gtl2H5Xp+TQMp7ZeTFp0hBo+x15g
	 c5PF2f4isrZj5JMHGbgLahrG7D4JPRX+IM5iocWw5EXZPJjpHf7ihWNVHEQwkao4PW
	 VMoHQEHxSYkl6RDdkyFkcdtYDg3ThV7MNiNVJ9XAFUZfM1EfU0HJEgDojmjjOtApX1
	 elR7Zy5G8M3deuvY7Yos4IPhMauVBKaZLgHRccFcQjvGJCriB3yH4FNKGj8OldkrRC
	 ll/IkKFaZfuFQ==
Date: Sat, 24 Feb 2024 17:59:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: iio: pressure: Sort headers of BMPxxx SPI
 driver
Message-ID: <20240224175930.5c283586@jic23-huawei>
In-Reply-To: <ZdUD3yI7I7uj3Nhp@smile.fi.intel.com>
References: <20240220184125.32602-1-vassilisamir@gmail.com>
	<20240220184125.32602-2-vassilisamir@gmail.com>
	<ZdUD3yI7I7uj3Nhp@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 21:56:15 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Feb 20, 2024 at 07:41:25PM +0100, Vasileios Amoiridis wrote:
> > Alphabetical sorting and separation of headers for the BMPxxx
> > SPI driver.  
> 
> ...
> 
> > -#include <linux/module.h>
> > -#include <linux/spi/spi.h>
> > +#include <linux/bits.h>
> >  #include <linux/err.h>
> > +#include <linux/module.h>
> >  #include <linux/regmap.h>  
> 
> > -#include <linux/bits.h>  
> 
> That's what I meant. Please do not add it into the wrong place to begin with.
> 
> > +#include <linux/spi/spi.h>  
> 

This isn't going be something I rush in with the fix, so
plenty of time to revisit this next cycle.

Thanks,

Jonathan


