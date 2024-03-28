Return-Path: <linux-kernel+bounces-122838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081788FE32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6534295612
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66587E76F;
	Thu, 28 Mar 2024 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U4vw3dEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2668564CF3;
	Thu, 28 Mar 2024 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625786; cv=none; b=DXRZLleKUX5v/nzOxmIWMW9+1RaWBHVbd+SjiulTPig69kngQAaib4PmFe+sfVdal5xX3ZirWybUuUi2eFtQy0wOAKMiXtLCiRM+fmXhbxSCdwDmu29XFGMSTHdpSxwqNgA3TlGmXnhpl/YN6aMomFX/fmXHoGOeOMpnc8XVb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625786; c=relaxed/simple;
	bh=eHbd13xfCdlMc5rUeo8qU6KBZ2DNNiy+Au7LzhcCV2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6HCJy3gz40i99UTqUB+d7xdJhk+cJvuVtOexaMUmgm+yJTRRzU0dgAf3oXMaKxyNmGyZnfT6inm+RB8C/rL28YJbT4Y+vdn+Rwx0C+qdKip8+N/a22ig4Xty9bhJu3WMaBGBGRv4QZcmLB2Q8eVTchX8fsVeY8XkQeNdkIibS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U4vw3dEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34689C433C7;
	Thu, 28 Mar 2024 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711625785;
	bh=eHbd13xfCdlMc5rUeo8qU6KBZ2DNNiy+Au7LzhcCV2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4vw3dEijzi9OIFx/NC6mTsIqCD0yFjG0xREu5GDukFooFG8XFzYjV/sSx48kZEm2
	 Yf6oFeCucRBSixCd/HlCcRrXld/keobhxACx5x6jWM+lVaLTxDUL5fb7zONl3DDA3O
	 xi7ZLtyuwxFSW0pVMfTSaRsGDAlP88pLMFoX2H/s=
Date: Thu, 28 Mar 2024 12:36:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, nm@ti.com, vigneshr@ti.com
Subject: Re: [PATCH 2/5] bus: ti-sysc: Add a description and copyrights
Message-ID: <2024032824-suburb-decline-2165@gregkh>
References: <20240327081508.36747-1-tony@atomide.com>
 <20240327081508.36747-3-tony@atomide.com>
 <20240328111907.cknfqe3qpiyeipsp@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328111907.cknfqe3qpiyeipsp@dhruva>

On Thu, Mar 28, 2024 at 04:49:07PM +0530, Dhruva Gole wrote:
> On Mar 27, 2024 at 10:15:05 +0200, Tony Lindgren wrote:
> > The ti-sysc driver is missing coprights and description, let's add
> > those.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/bus/ti-sysc.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> > --- a/drivers/bus/ti-sysc.c
> > +++ b/drivers/bus/ti-sysc.c
> > @@ -1,6 +1,17 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * ti-sysc.c - Texas Instruments sysc interconnect target driver
> > + *
> > + * TI SoCs have an interconnect target wrapper IP for many devices. The wrapper
> > + * IP manages clock gating, resets, and PM capabilities for the connected devices.
> > + *
> > + * Copyright (C) 2017-2024 Texas Instruments Incorporated - https://www.ti.com/
> > + *
> > + * Many features are based on the earlier omap_hwmod arch code with thanks to all
> > + * the people who developed and debugged the code over the years:
> > + *
> > + * Copyright (C) 2009-2011 Nokia Corporation
> > + * Copyright (C) 2011-2012 Texas Instruments, Inc.
> 
> +Nishant
> 
> I am no expert on the copyrights part of it, but who gets copyright from
> 2012 - 2017?

If there are no changes in those years, what exactly are you attempting
to copyright for those years?

Please talk to your corporate copyright lawyers about this.  I'm sure
there is a class you can take from them to explain all of this.  If not,
there's a free one online from the Linux Foundation that you might want
to take instead.

thanks,

greg k-h

