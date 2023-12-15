Return-Path: <linux-kernel+bounces-1787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D288153EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDAB20DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18318EC3;
	Fri, 15 Dec 2023 22:46:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B3A9218EAC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 288613 invoked by uid 1000); 15 Dec 2023 17:46:24 -0500
Date: Fri, 15 Dec 2023 17:46:24 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Yinghua Yang <yinghua.yang@motorolasolutions.com>
Cc: gregkh@linuxfoundation.org, zachary.zuzzio@motorolasolutions.com,
  Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
  Oliver Neukum <oneukum@suse.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
  Wentong Wu <wentong.wu@intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: misc: Add driver for Motorola Solutions security
 accessories
Message-ID: <26c70a69-f18f-4c82-a520-7943be0e1961@rowland.harvard.edu>
References: <20231215211218.2313996-1-Yinghua.Yang@motorolasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215211218.2313996-1-Yinghua.Yang@motorolasolutions.com>

On Fri, Dec 15, 2023 at 03:12:10PM -0600, Yinghua Yang wrote:
> New USB driver that sets power/control to autosuspend for Motorola
> Solutions security accessories. The new driver only changes the power
> control for specific USB devices, normal read/write/ioctl of the usb
> device uses the unmodified usbfs.
> 
> The rationale for a vendor specific driver was to allow for autosuspend
> behavior on Linux installations that are battery powered and do not
> allow user modifications to udev settings (e.g. embedded Linux, Android,
> etc.). The idealistic generic approach that would allow any USB device
> that supports autosuspend to change the power control could not be found
> without a change to the USB standard or substantial change to the usbfs
> architecture.
> 
> Signed-off-by: Yinghua Yang <Yinghua.Yang@motorolasolutions.com>
> ---

It seems silly to write a kernel driver for this.  Isn't there any way
to handle it in userspace?  All you would need is a simple shell
script.

Alan Stern

