Return-Path: <linux-kernel+bounces-53348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D884A383
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A32A281F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49FC6351E;
	Mon,  5 Feb 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bnl94npj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96377319C;
	Mon,  5 Feb 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159799; cv=none; b=NgZRktgE9LAahFX6JD5x+hhxOuSNpLd9UqyVv882Pxvw0sSlC/wIoVDJmJgu5rfQ4v33jBm+lgJiqqOlZywQw+D1S+tTxbtLmTVdfc6HKC43N2IwNML9TS0kgzmUDuGOizCwHdh/E79XuUGErkpzzCTjnZP/PZ1UT6JhXUpxivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159799; c=relaxed/simple;
	bh=FEzg+G2fknYhQYjKuxgdWtNV8zO/Hs0+/47sEWBzFaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihdehIGLxCmgWp/RIpmjwa108Id6aW3rkaUcxTh9PdxHgeK9BwuNtQFXNwiNbM7rbYaSzgQmy/FNka9I2aDgdTfWCm5Fy/24lrxqSF0LXGfhmMkRR5BfgIj1IifhHem+fP5Ve5l27Uc1sg8aSFAAEYSawo6cjxLxCcdWI9E4dg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bnl94npj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30784C43394;
	Mon,  5 Feb 2024 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159799;
	bh=FEzg+G2fknYhQYjKuxgdWtNV8zO/Hs0+/47sEWBzFaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bnl94npjQX8JOlCXmOJxKUTRF+xyvGc38XBtCRYx4eBEEA6p622XY8VyO9aqpXexl
	 zxZyGOOT/ImEX1cIECAZ+pVY/33gd9I50FRrWcR+VnmIkt/bvCHLm3aFxERXvhOZjE
	 wHOQSP6Ics+2QJ+NwQXsHc9Yugpl2wx7goHSxZ2Q=
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

