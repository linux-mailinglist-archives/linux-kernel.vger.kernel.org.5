Return-Path: <linux-kernel+bounces-111404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1D886BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6D61F24479
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DA83FE3D;
	Fri, 22 Mar 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="joVDam/L"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAC3FBA4;
	Fri, 22 Mar 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109298; cv=none; b=EaLvec9okJ9v2w3cRGq0/d2JNaPFd0w4LokzbyKHdQhCX7LNhsEOIEJ12WRCSvqWsU/GgT+zz9VG08v+jXNoCSxMX4p8/GbeI2IPwFHiw6gr71qL1mZZ0qHpQoo3UYLFHts0rsL73WD+t68pdTyFIJjrOUPe9ajgaMrH8oB1olE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109298; c=relaxed/simple;
	bh=jnhXAoZYwd5Rl7o3GSC0RmRjOoMAxqv7Y96qFrb1dHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRVjQbRfpeUbNlbW4KoBLVmGB531SKBAGitW8jiftfVC7NEfE9Cijx9fXtiw5P44b+q648lkE9llcl38ENrIkhCCsTGVotkOkAXTYsio9MNG4EjSZbAwffBmXObtcwdU6kQ95AVr6dRAdbmUst+0UDZXhhwhwlgxl8KyxuKX2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=joVDam/L; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5856D82A;
	Fri, 22 Mar 2024 13:07:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711109266;
	bh=jnhXAoZYwd5Rl7o3GSC0RmRjOoMAxqv7Y96qFrb1dHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joVDam/L4AA7f3FSLcI+o9ANdjH++tCVWENzHRx+a1PDAeb8btve0sfJrVrq71ioc
	 nWh64GcScJOUNsp1s/BIGhiM/F+b/FdYskd6FjVtW0jVOFWlrcPHK+BtzCIEv187Pg
	 1PRZ4+Fo0tQk394/ot3m8unU1pGFMXaUulMM/pYQ=
Date: Fri, 22 Mar 2024 14:08:10 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Yunke Cao <yunkec@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND] media: uvcvideo: Disable autosuspend for Insta360
 Link
Message-ID: <20240322120810.GA648@pendragon.ideasonboard.com>
References: <20221101-instal-v1-0-d13d1331c4b5@chromium.org>
 <Y6z55cXTt5yXjIZj@pendragon.ideasonboard.com>
 <CANiDSCvbQ7uMgoxDsXDOphjANNZ2EuoV-Dra+wtT9LLL6USstQ@mail.gmail.com>
 <CANiDSCveK6QRbYM==XN9jggy8DHfS3QJawDWpFLy0jcmmHeduA@mail.gmail.com>
 <1298c83f-695a-4356-aa2e-22b0e6629610@rowland.harvard.edu>
 <CANiDSCtfPO+O=uLTAAiLDrmvcRigi1weAih_+et5iwFy5Joamw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCtfPO+O=uLTAAiLDrmvcRigi1weAih_+et5iwFy5Joamw@mail.gmail.com>

Hi Ricardo,

On Thu, Mar 09, 2023 at 12:12:27AM +0100, Ricardo Ribalda wrote:
> On Thu, 9 Mar 2023 at 00:02, Alan Stern wrote:
> > On Wed, Mar 08, 2023 at 11:43:09PM +0100, Ricardo Ribalda wrote:
> > > On Wed, 1 Mar 2023 at 10:04, Ricardo Ribalda wrote:
> > > > On Thu, 29 Dec 2022 at 03:22, Laurent Pinchart wrote:
> > > > > On Fri, Dec 02, 2022 at 05:48:52PM +0100, Ricardo Ribalda wrote:
> > > > > > When the device suspends, it keeps power-cycling.
> > > > > >
> > > > > > The user notices it because the LED constanct oscillate between
> > > > > > blue (ready) and no LED (off).
> >
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > > media: uvcvideo: Disable autosuspend for Insta360
> > > > > >
> > > > > > The device does not handle properly the USB suspend and makes it barely usable.
> > > > >
> > > > > Isn't this best handled with a quirk in the USB core ? Autosuspend is a
> > > > > device feature, not an interface feature, so if the USB sound driver is
> > > > > loaded but uvcvideo isn't, the kernel may still attempt to autosuspend
> > > > > the device.
> > > > >
> > > >
> > > > Seems like USB_QUIRK_NO_AUTOSUSPEND was gone for a long time
> > > >
> > > > https://lore.kernel.org/lkml/20071115064457.GU19218@kroah.com/
> > > >
> > > > under the assumption that autosuspend was off by default and user
> > > > space should only enable autosuspend on the devices that support it
> > > > (if I understand it correctly).
> > > >
> > > > There are two other quirks still available: USB_QUIRK_RESET_RESUME and
> > > > USB_QUIRK_DISCONNECT_SUSPEND, but they do not seem to work for this
> > > > device (Yunke, thanks for looking into this)
> > > >
> > > > If we are explicitly enabling autosuspend on the driver, shouldn't we
> > > > make sure that the device supports it?
> > > >
> > >
> > > Alan, Greg, any idea about what is the best way to proceed here from a
> > > USB perspective?
> >
> > How is autosuspend getting enabled for this device?  It is disabled by
> > default for non-hub USB devices.
> 
> It is enabled on the driver via usb_enable_autosuspend()
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_driver.c#n2211
> 
> > If the uvcvideo or USB sound driver is enabling autosuspend, the driver
> > should be fixed.  Perhaps by adding a quirk bit for this purpose.
> 
> This is what I tried with this patch :). Laurent, could you please
> take a second look to it?
> Thanks!

Done, and

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > If userspace is enabling autosuspend, then any misbehavior isn't the
> > kernel's fault.  :-)

-- 
Regards,

Laurent Pinchart

