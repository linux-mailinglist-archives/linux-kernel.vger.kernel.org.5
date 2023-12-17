Return-Path: <linux-kernel+bounces-2507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16C815E21
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865691F22176
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC511FB4;
	Sun, 17 Dec 2023 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UHcv0zw7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39721863;
	Sun, 17 Dec 2023 08:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6375C433C7;
	Sun, 17 Dec 2023 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702801762;
	bh=kQM/bmkve4FFOjpxeer7XYIDa+l+sAEjNV1l4XEdtH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHcv0zw71GsvKYeqFqqoat+RMD/uEuoS/YYpy/gOEdbVIKZ+NXANM86TvFDhNtqbA
	 cmeS5e625lMzEsBR9LUwUwFjD1cjJMtT4nhYFu9HjzNxxBZF2XgFTQaIpTwYIBkuo4
	 L/Hw7lX5k+cgRtzZe8u3ZdMaPMJw4p35tQ6ON8wQ=
Date: Sun, 17 Dec 2023 09:29:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yinghua Yang Yang <yinghua.yang@motorolasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	zachary.zuzzio@motorolasolutions.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Oliver Neukum <oneukum@suse.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: misc: Add driver for Motorola Solutions security
 accessories
Message-ID: <2023121712-gigabyte-oppressed-b8f4@gregkh>
References: <20231215211218.2313996-1-Yinghua.Yang@motorolasolutions.com>
 <26c70a69-f18f-4c82-a520-7943be0e1961@rowland.harvard.edu>
 <CAHhS5zZzHzZBADHkKyzCzr5FJ0zdTvsaQUE0ygjU1FG3vocrCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhS5zZzHzZBADHkKyzCzr5FJ0zdTvsaQUE0ygjU1FG3vocrCA@mail.gmail.com>

On Sat, Dec 16, 2023 at 12:15:35PM -0600, Yinghua Yang Yang wrote:
> I would prefer an easier way too. On a linux platform where udev
> is supported, a udev rule can be used to set the power/control flag. But on
> the platform I am using, the udev is not available and I don't have
> root access.
> If this driver is accepted by the Linux kernel, we hope the driver will
> subsequently be picked up by the platform's hardware vendor. With that, any
> USB device that is specified by this driver when plugged into the platform,
> auto suspend will be enabled on it.
> 
> Any suggestions will be appreciated.

As Alan says, please just fix your userspace to properly enable the
correct setting, no need for a kernel change at all.

You have the contacts and interactions to work with the hardware vendor,
don't use the kernel community as a "back door" to circumvent that.

thanks,

greg k-h

