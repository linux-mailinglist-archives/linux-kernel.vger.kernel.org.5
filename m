Return-Path: <linux-kernel+bounces-39517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D456583D23F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708FA1F28C88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAE34430;
	Fri, 26 Jan 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbmozgLh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B8387;
	Fri, 26 Jan 2024 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233855; cv=none; b=kZm/rCYcVjVLRektUOrA+kVmMGrbHj9/BVWuQqP/CLT5tOVHWfewUaxakPkT2kLb9Z73TTiJgWxfl2+kgV/tgvByK7RbBobitVRP+7Pc/aq7HUk/ceSBTm2q3p/a1F+txnrXh6AxXgc7wspxMTEhCqzri7j0mjen+2Aax3QCoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233855; c=relaxed/simple;
	bh=fU7HLSpDKExkjYJxmfhBXhXuObujx6v9bxNW536NIWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG6riIj4boox4dTkSo0z6z/zr1boj3vT5N/i5oFqaR6wfEGUfZKdjhiYwkzAbmT1ow9fEdb7l8FDG8bceRtiiCaYEyHj3Pr5vkIQPSisoRuMXrNmxaFtqcb+wWo73rbkZUBOY+2smTKlbcclV0DGzLktULbX8iv1rgj8K5jPoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbmozgLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B68C43390;
	Fri, 26 Jan 2024 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706233854;
	bh=fU7HLSpDKExkjYJxmfhBXhXuObujx6v9bxNW536NIWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbmozgLhGApnSGAj66aY66xMQStJSH4jPvW4si1NniJbcEuJFgRzfCRgAK6fCYElD
	 hk+ieGRibamjFUsk67nUYlGgUUxvfZ1t/G5cmh6o9inMHc3Ep2DOSJvhAEJ3Eom0g8
	 fbZTX7Ma7gBxzlhOk/1OER6Az8UQAuFIiVeptpz4=
Date: Thu, 25 Jan 2024 17:50:54 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, jthies@google.com, pmalani@chromium.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Update connector cap and status
Message-ID: <2024012555-nuclear-chummy-6079@gregkh>
References: <20240125004456.575891-1-abhishekpandit@google.com>
 <20240124164443.v2.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
 <2024012512-haphazard-mobster-f566@gregkh>
 <CANFp7mWzA5df9iFpCWFRpXuOP06yDmBehYDYNACjrW2fPvp_Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mWzA5df9iFpCWFRpXuOP06yDmBehYDYNACjrW2fPvp_Ow@mail.gmail.com>

On Thu, Jan 25, 2024 at 04:21:47PM -0800, Abhishek Pandit-Subedi wrote:
> On Thu, Jan 25, 2024 at 3:03 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 24, 2024 at 04:44:53PM -0800, Abhishek Pandit-Subedi wrote:
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> > > index bec920fa6b8a..94b373378f63 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.h
> > > +++ b/drivers/usb/typec/ucsi/ucsi.h
> > > @@ -3,6 +3,7 @@
> > >  #ifndef __DRIVER_USB_TYPEC_UCSI_H
> > >  #define __DRIVER_USB_TYPEC_UCSI_H
> > >
> > > +#include <asm-generic/unaligned.h>
> >
> > Do you really need to include a asm/ include file?  This feels very
> > wrong.
> 
> I didn't see any header in include/linux that already had these
> unaligned access functions so I opted to include
> asm-generic/unaligned.h. Is there a reason not to use an asm/ include
> file?

Yes, you should never need to include a asm/ file, unless you are
arch-specific code.

But the big issue is that you don't really need this, right?

> > It's also in the wrong place, AND why "asm-generic"?  That also feels
> > wrong.
> 
> asm-generic is definitely wrong; I misunderstood how these headers are
> supposed to be used (should be just asm/unaligned.h).

Why?  What are you requiring this .h file for?

> For ordering, I took a look at some other files and it looks like
> <asm/...> goes below the <linux/...> includes. This also probably
> deserves documenting in the style guide.

It is somewhere, checkpatch should complain about it.

thanks,

greg k-h

