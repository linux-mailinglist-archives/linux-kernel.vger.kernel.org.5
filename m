Return-Path: <linux-kernel+bounces-63370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E44852E44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D83282FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09942BB03;
	Tue, 13 Feb 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TmEu4/T4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895D1775C;
	Tue, 13 Feb 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821245; cv=none; b=ZssUiCFkslxCBRdCeqac/qGtNBF3AJi9I3DshU+cUQr1mJSE/Ve6n5AjXbpTj/EgiGDHQpsve2FExC7qRcT0aTktFqTL8yEGwWFWP+V2HatjVUa/jN3OUBnB4qoY0CikR/m4qWxKOPxT9nDOWZ6hWA97Ib/mL7VQ9eQyyPk7SVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821245; c=relaxed/simple;
	bh=LuZVB9/U46GxT3gi1nHL2CZ0+ZTFaMf0rDsOE7bl3hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYOwy8fdnzpRniTJOkdVxnE5L5lU6RhNqGtst0Yk0bWEXJMpkSECmDrNrwSoMUdcT0WTcQBhnFvfUTkTUXKkJFEG/mgxP3myTLY3gcnm5zkugkVYFL4kMsb3We+RIZJ5SjmpmaV5Jg4kzeUypfPNJar4N090MfGVQEMVbe1qCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TmEu4/T4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [109.130.69.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1569C675;
	Tue, 13 Feb 2024 11:47:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707821240;
	bh=LuZVB9/U46GxT3gi1nHL2CZ0+ZTFaMf0rDsOE7bl3hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmEu4/T4muelKKgbtFKqcPolTwHWbmCtPpMzX1aE0RScaQOkVU/BGQgyw6wrWKzCD
	 ruxiLIkknUu5+KyeEq5ajNihe/TYwdmADq3l6qko5002lmZCjS4dv4J2QvBQXbf9+2
	 cX5Q1mqXJZFRmShzYgg4q5TfIhlfbBNL2BMKFsRs=
Date: Tue, 13 Feb 2024 12:47:25 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
Message-ID: <20240213104725.GC5012@pendragon.ideasonboard.com>
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
 <20240204105227.GB25334@pendragon.ideasonboard.com>
 <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>
 <6aade777-d97c-4c65-b542-14ce5b39abb6@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6aade777-d97c-4c65-b542-14ce5b39abb6@rowland.harvard.edu>

On Mon, Feb 12, 2024 at 02:04:31PM -0500, Alan Stern wrote:
> On Mon, Feb 12, 2024 at 01:22:42PM +0100, Oliver Neukum wrote:
> > On 04.02.24 11:52, Laurent Pinchart wrote:
> > > Hi Ricardo,
> > > 
> > > Thank you for the patch.
> > 
> > Hi,
> > 
> > sorry for commenting on this late, but this patch has
> > a fundamental issue. In fact this issue is the reason the
> > handling for quirks is in usbcore at all.
> > 
> > If you leave the setting/clearing of this flag to a driver you
> > are introducing a race condition. The driver may or may not be
> > present at the time a device is enumerated. And you have
> > no idea how long the autosuspend delay is on a system
> > and what its default policy is regarding suspending
> > devices.
> > That means that a device can have been suspended and
> > resumed before it is probed. On a device that needs
> > RESET_RESUME, we are in trouble.
> 
> Not necessarily.  If the driver knows that one of these devices may 
> already have been suspend and resumed, it can issue its own preemptive 
> reset at probe time.
> 
> > The inverse issue will arise if a device does not react
> > well to RESET_RESUME. You cannot rule out that a device
> > that must not be reset will be reset.
> 
> That's a separate issue, with its own list of potential problems.
> 
> > I am sorry, but it seems to me that the exceptions need
> > to go into usbcore.
> 
> If we do then we may want to come up with a better scheme for seeing 
> which devices need to have a quirk flag set.  A static listing probably 
> won't be good enough; the decision may have to be made dynamically.

I don't mind either way personally. Oliver, could you try to find a good
solution with Ricardo ? I'll merge the outcome.

-- 
Regards,

Laurent Pinchart

