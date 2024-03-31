Return-Path: <linux-kernel+bounces-126084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51988931F7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DC21C21539
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDC145330;
	Sun, 31 Mar 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYKHmwAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD932144D2A;
	Sun, 31 Mar 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711894856; cv=none; b=h/r98nbj1q+G8lH8n7zYae2C+2YmUAmZAjV83iPxwzWLULchc1zUGKg35Kia/qJykidalxxzSOJu9VWsB2+7Kez2QazY8vRQFUePJt09VgN7plgTcWmqglO2Jhvbch9I8Lpg9QXoU2ZexDK7rl5hODQRPwVkPdYufwndCRYWeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711894856; c=relaxed/simple;
	bh=MhZ+GNwAIgsUTcIkXuF7X0kiB2apEfQgvIGqYvrAc/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1hTiyoaVHJbCIUgxf4qlw80U2pBmzILrs7ANe0U6jNHr1BX/CNOykv2cMGW5NQIOmWMrktwqEWrSSOX+ak8XSo/gIdlJcZo9uoVCUnWk8FvIr2973LkEJX5UXK9aMnOmmBvgFg5Q5jrdykWd51IAOIGPZAYdjZGgC2H9/VJ+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYKHmwAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19DBC433F1;
	Sun, 31 Mar 2024 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711894856;
	bh=MhZ+GNwAIgsUTcIkXuF7X0kiB2apEfQgvIGqYvrAc/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NYKHmwAPHxH908yfjReJj3s5LqlkFu+hqeyf6R3JKvUdwJ2CxXP7G65iuUi98d5YE
	 jGuAeo74BElsHwjXvbUi0r4VNa0h1JXBXSnauW2Xmb1dxLXVVqz997lKns1jG+/WvB
	 kOiHNL/OHMjOcDr6uYlFYx/ym10GPbiPlbdiNtznO72r5jMj1+klBA3Fn2SREW1odh
	 qL8k9KboyXDlnUDBXpl2OXQifFiV3OeKnAZ5qj1GVR6nQa0Xmd9GCQiWrKqjQwcRVk
	 Dk3ZgLZBqjSR1vri/hGvOnhoJChXxCjExYp8hn7C48tVwElLLYH8gYzDJDjUQgRwp8
	 Mr8t4UnXpcCgQ==
Date: Sun, 31 Mar 2024 15:20:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>, David Lechner
 <dlechner@baylibre.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Syunya Ohshio
 <syunya.ohshio@atmark-techno.com>, Guido =?UTF-8?B?R8O8bnRoZXI=?=
 <agx@sigxcpu.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <20240331152042.394b4289@jic23-huawei>
In-Reply-To: <20240318122953.000013f3@Huawei.com>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
	<7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
	<Zd7hSOw3_zosyrn3@atmark-techno.com>
	<daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
	<Zd7qz1Qte8HWieF_@atmark-techno.com>
	<20240228142441.00002a79@Huawei.com>
	<Zd_zB_ymxkx0HB3q@atmark-techno.com>
	<ZfPg-nMANUtBlr6S@atmark-techno.com>
	<CAMknhBG_kJx8JPvTBQo7zpy3mFAkUjZpRY3DLBfXt+39nRJWiA@mail.gmail.com>
	<ZfejyEvPIncygKJ9@atmark-techno.com>
	<20240318122953.000013f3@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 12:29:53 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 18 Mar 2024 11:15:36 +0900
> Dominique Martinet <dominique.martinet@atmark-techno.com> wrote:
> 
> > David Lechner wrote on Fri, Mar 15, 2024 at 10:53:36AM -0500:  
> > > How about using udev rules to create symlinks for each device based on
> > > the label attribute? No changes to the kernel are needed.    
> > 
> > Right, it's definitely possible to make symlinks for each "device" -- my
> > patch comment links to such an udev script "solution":
> > https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-core/udev/files/verdin-imx8mm/toradex-adc.sh?h=kirkstone-6.x.y
> > (the script is launched by udev here:
> > https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-core/udev/files/verdin-imx8mm/99-toradex.rules
> > )
> > 
> > My conceptual problem with this is that this makes symlinks in /dev to
> > files in /sys and it feels like we're crossing boundaries.
> > As far as I can tell there is no way for userspace to create arbitrary
> > symlinks in /sys, so I think we could have an interface more
> > user-friendly by allowing paths to be static for users with multiple
> > devices.
> > (I guess that's a weak argument given e.g. disks etc will also have an
> > unreliable name in /sys in the general case, but simple programs don't
> > interact with them in /sys and can use stable links in /dev so my
> > expectations here aren't quite the same)
> > 
> > 
> > Ultimately, the problem might run deeper in that we're having userspace
> > interact with the device through /sys and not the /dev char dev... As
> > far as I could see /dev/iio:deviceX only allows reading buffered values
> > and doesn't have any ioctl or other way of reading immediate values as
> > is possible in /sys though, so that'd require quite a bit of work to
> > duplicate the interface there...  
> 
> Don't.  The sysfs interface as only control is entirely intentional and
> we do not want IOCTL based duplication.
> 
> Just addressing this bit as I'm still a bit snowed under to think about this
> more generally.
> 

Hi, got back to this finally...

So the problems compared to other 'alias' users is that IIO is a bit more
complex than for example LEDs.  A single DT node/compatible (or equivalent) can
result in a 1+ IIO devices and 1+ triggers. Triggers can also be instantiated
via configfs (technically devices can as well but we can ignore that).
Any alias scheme needs to work for all these options. To my mind that makes
it a userspace problem, not something the kernel can deal with in generic
enough way. I think that all IIO devices have ways to stability identify them
(label, or parent devices)

There is an approximate equivalent of DT alias entries in SMBIOS but
I suspect not all ACPI platforms will provide that (it's typically used for
stable disk / network device naming on complex servers).

So I've messed around a bit and can think of various possible options to make
this simpler.
1) Use a tmpfs mount and link from that.
   Now we 'could' put an alias directory somewhere under /sys/bus/iio/ that
   is a mount point created via sysfs_create_mount_point() - I abused the
   /sys/kernel/debug directory to test this (unmounted debugfs and mounted
   a tmpfs).  That would provide somewhere in sysfs that allows suitable
   links. However, this is unusual so likely to be controversial.
2) Alternatively the relevant platform could create one of these somewhere
   outside of sysfs and use udev rules to create the links.
3) Stick to the oddity of doing it under /dev/
4) Access the things in the first place via more stable paths?
  /sys/bus/i2c/devices/i2c-0/0-0008/iio\:device?/ etc 
   Relying on the alias support for i2c bus numbering to make that stable should work
   and if you are sure there will only be one entry (most devices) that matches
   the wild card, should be easy enough to use in scripts.

My personal preference is this last option.  Basically if you want stable paths
don't use /sys/bus/iio/devices/ to get them.

Jonathan





