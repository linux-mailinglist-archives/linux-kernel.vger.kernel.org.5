Return-Path: <linux-kernel+bounces-53281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6E784A307
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B579B21D75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3AD4BA88;
	Mon,  5 Feb 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v60Qk0Qm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF294A990;
	Mon,  5 Feb 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159772; cv=none; b=mFdgw0/5hResavnaTVc0Xfk9KQNZB+YuS8nmhG/+a7j7gyzEdGC2fVQt0xp6wxdEgX9T8xfbSHb6Pn7wmthkmexlvp5+tHHnw89f6ZRWIZSeEkxvbIL/Ntcm/yo/a8/PAsjY7ebTfcgcoGRLodSEzxKsGwl9aUZQRUK/K4k9EM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159772; c=relaxed/simple;
	bh=FEzg+G2fknYhQYjKuxgdWtNV8zO/Hs0+/47sEWBzFaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO9Ar4vTpBIrDSW0D2YIuoHPKC9rjXcrn4K3eFHuZZPOrCNvZktxUHcJJFWMTt02BhIFRipThABrWHiBEvXC0jqWFXN4qJmGATnHxvSE4hu45LoovL10mI5b8ff33pI+HA2gxad1d9xGavR/RJFCFXP1Iqpc/wvFnCmeKWMuqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v60Qk0Qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5266C43394;
	Mon,  5 Feb 2024 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159772;
	bh=FEzg+G2fknYhQYjKuxgdWtNV8zO/Hs0+/47sEWBzFaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v60Qk0QmfgfmzhVMccAEE252jBpx7iyrqzCuD4aqHMq1HPqNTgR9EpykuL/7ksITA
	 78Ukc+e2IPSG4iZJz2t3xAczP4dXxKUetKJKaEAfZYw+22id+XbjqD+NsINJgqjHnV
	 EJMgJ54jyMBKRfds5gO8X21IYsL1de43bu+UgspQ=
Date: Mon, 5 Feb 2024 04:43:49 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: gpiolib: make gpio_bus_type const
Message-ID: <2024020545-sloppy-book-9b17@gregkh>
References: <20240204-bus_cleanup-gpio-v1-1-82d91b4ee1de@marliere.net>
 <CAMRc=MdSApjK2b66LxLE9XZufvT-+SThuqjdr+yG-hsKEb4sVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdSApjK2b66LxLE9XZufvT-+SThuqjdr+yG-hsKEb4sVw@mail.gmail.com>

On Sun, Feb 04, 2024 at 07:34:43PM +0100, Bartosz Golaszewski wrote:
> On Sun, Feb 4, 2024 at 5:29 PM Ricardo B. Marliere <ricardo@marliere.net> wrote:
> >
> > Now that the driver core can properly handle constant struct bus_type,
> > move the gpio_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/gpio/gpiolib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index d50a786f8176..24d046268a01 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -63,7 +63,7 @@ static int gpio_bus_match(struct device *dev, struct device_driver *drv)
> >         return 1;
> >  }
> >
> > -static struct bus_type gpio_bus_type = {
> > +static const struct bus_type gpio_bus_type = {
> >         .name = "gpio",
> >         .match = gpio_bus_match,
> >  };
> >
> > ---
> > base-commit: 3eac8bbed22e940ac1645a884f221bef408f675c
> > change-id: 20240204-bus_cleanup-gpio-57eea8d32a5a
> >
> > Best regards,
> > --
> > Ricardo B. Marliere <ricardo@marliere.net>
> >
> 
> Ha! Does the same work now for struct device_type?

Very much so, please feel free to do so, that's next on my list of
things to do for the tree.

greg k-h

