Return-Path: <linux-kernel+bounces-4222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69879817947
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A260B2144A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1C15D72D;
	Mon, 18 Dec 2023 17:57:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id F2C524FF6C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 385326 invoked by uid 1000); 18 Dec 2023 12:57:01 -0500
Date: Mon, 18 Dec 2023 12:57:00 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Yinghua Yang Yang <yinghua.yang@motorolasolutions.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
  zachary.zuzzio@motorolasolutions.com,
  Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
  Oliver Neukum <oneukum@suse.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
  Wentong Wu <wentong.wu@intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: misc: Add driver for Motorola Solutions security
 accessories
Message-ID: <fa0492da-7b18-47f8-8c79-a640835a3174@rowland.harvard.edu>
References: <20231215211218.2313996-1-Yinghua.Yang@motorolasolutions.com>
 <26c70a69-f18f-4c82-a520-7943be0e1961@rowland.harvard.edu>
 <CAHhS5zZzHzZBADHkKyzCzr5FJ0zdTvsaQUE0ygjU1FG3vocrCA@mail.gmail.com>
 <2023121712-gigabyte-oppressed-b8f4@gregkh>
 <CAHhS5zY+X5DFX5cYir-raswc0Pmck-nuMSWAsK7epBU3ARO_BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhS5zY+X5DFX5cYir-raswc0Pmck-nuMSWAsK7epBU3ARO_BA@mail.gmail.com>

On Sun, Dec 17, 2023 at 09:56:34PM -0600, Yinghua Yang Yang wrote:
> Is there a way to set the auto suspend mode for a usb device without root
> permission? I think this is a general question for many usb devices.
> According to the Linux Kernel document
> https://www.kernel.org/doc/Documentation/usb/power-management.txt, by
> default the kernel disables autosuspend for all devices. So there are many
> usb devices that support autosuspend but by default autosuspend is
> disabled. In order to support autosuspend on those devices, are the only
> solutions 1) obtain root permission and write ../power/control file using a
> script

It doesn't have to be a script; any sort of program can do it.  A 
power-management daemon such as PowerTOP, for example.

>  2) work with the hardware vendor on a driver/kernel to write the
> autosuspend flag?

That would be kind of silly.  After all, if the vendor is willing to 
work with you on a kernel driver, they certainly ought to be willing to 
work with you on installing a power-management userspace program.  And 
installing a program should be much easier than getting a new driver 
into the kernel.

But to answer your question -- Yes, the only ways to modify the 
autosuspend settings are from userspace or from within the kernel.

Alan Stern

