Return-Path: <linux-kernel+bounces-111634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D006886ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4220E1F23E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCB5487BC;
	Fri, 22 Mar 2024 14:40:50 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 84A204644C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118449; cv=none; b=b1/JT7G7UB1ZLNUWqTdeCzmV+qa7pfdvbmVtYJSz3KtPDg4WR+HBUVBBO1GssfvTLVQFfjVVZFeV03UoCRkmMjB5wMuRx1LTJssYeBj+ZUK1BSm7C8K2OsmraR4/ghGrbsvjdmCeHHYXaZ/oRtfA7954RiTkOhwsrVnFKSkvC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118449; c=relaxed/simple;
	bh=VmvTwIK00BUsWSa6IRrE06C6cD4KWMsHDZSl8m19mcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVOY8Aib6vBxdAE4GgT8x6k6ZH+wlj4VgdArpFpQE0nINPUQcIK/wD0WpKOUbNefW7StXwJnkwkUqL7bB41Je9MkN0qk4it6zPpWKkcHFpbCVanroNvgslectPX7BoCJRmwMB4m5DWGzUnjhe7hLJYoyQPH191zOsVkCHI1LmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 761098 invoked by uid 1000); 22 Mar 2024 10:40:46 -0400
Date: Fri, 22 Mar 2024 10:40:46 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Oliver Neukum <oneukum@suse.com>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Mauro Carvalho Chehab <mchehab@kernel.org>, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
Message-ID: <588d2e1f-1cb5-4868-9160-11a36e8640d6@rowland.harvard.edu>
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
 <20240204105227.GB25334@pendragon.ideasonboard.com>
 <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>
 <6aade777-d97c-4c65-b542-14ce5b39abb6@rowland.harvard.edu>
 <20240213104725.GC5012@pendragon.ideasonboard.com>
 <CANiDSCvqEkzD_-pUExT2Aci9t_tfFPWusnjST5iF-5N9yiob4g@mail.gmail.com>
 <CANiDSCsqER=3OqzxRKYR_vs4as5aO1bfSXmFJtNmzw1kznd_wQ@mail.gmail.com>
 <20240322115734.GB31979@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322115734.GB31979@pendragon.ideasonboard.com>

On Fri, Mar 22, 2024 at 01:57:34PM +0200, Laurent Pinchart wrote:
> On Thu, Feb 29, 2024 at 05:57:38PM +0100, Ricardo Ribalda wrote:
> > Oliver, friendly ping
> 
> Seconded :-) We can help with the implementation, but we would like your
> guidance on the direction you think this should take.

Thirded  :-)  I want to hear what Oliver thinks about the original 
patch.

Alan Stern

> > On Mon, 19 Feb 2024 at 16:13, Ricardo Ribalda wrote:
> > >
> > > Hi Oliver
> > >
> > > Would you prefer a version like this?
> > >
> > > https://lore.kernel.org/all/20231222-rallybar-v2-1-5849d62a9514@chromium.org/
> > >
> > > If so I can re-submit a version with the 3 vid/pids.  Alan, would you
> > > be happy with that?
> > >
> > > Regards!
> > >
> > > On Tue, 13 Feb 2024 at 11:47, Laurent Pinchart wrote:
> > > > On Mon, Feb 12, 2024 at 02:04:31PM -0500, Alan Stern wrote:
> > > > > On Mon, Feb 12, 2024 at 01:22:42PM +0100, Oliver Neukum wrote:
> > > > > > On 04.02.24 11:52, Laurent Pinchart wrote:
> > > > > > > Hi Ricardo,
> > > > > > >
> > > > > > > Thank you for the patch.
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > sorry for commenting on this late, but this patch has
> > > > > > a fundamental issue. In fact this issue is the reason the
> > > > > > handling for quirks is in usbcore at all.
> > > > > >
> > > > > > If you leave the setting/clearing of this flag to a driver you
> > > > > > are introducing a race condition. The driver may or may not be
> > > > > > present at the time a device is enumerated. And you have
> > > > > > no idea how long the autosuspend delay is on a system
> > > > > > and what its default policy is regarding suspending
> > > > > > devices.
> > > > > > That means that a device can have been suspended and
> > > > > > resumed before it is probed. On a device that needs
> > > > > > RESET_RESUME, we are in trouble.
> > > > >
> > > > > Not necessarily.  If the driver knows that one of these devices may
> > > > > already have been suspend and resumed, it can issue its own preemptive
> > > > > reset at probe time.
> > > > >
> > > > > > The inverse issue will arise if a device does not react
> > > > > > well to RESET_RESUME. You cannot rule out that a device
> > > > > > that must not be reset will be reset.
> > > > >
> > > > > That's a separate issue, with its own list of potential problems.
> > > > >
> > > > > > I am sorry, but it seems to me that the exceptions need
> > > > > > to go into usbcore.
> > > > >
> > > > > If we do then we may want to come up with a better scheme for seeing
> > > > > which devices need to have a quirk flag set.  A static listing probably
> > > > > won't be good enough; the decision may have to be made dynamically.
> > > >
> > > > I don't mind either way personally. Oliver, could you try to find a good
> > > > solution with Ricardo ? I'll merge the outcome.
> 
> -- 
> Regards,
> 
> Laurent Pinchart

