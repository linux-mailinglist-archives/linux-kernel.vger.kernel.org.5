Return-Path: <linux-kernel+bounces-72580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FA685B584
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7ABAB218C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118065D74A;
	Tue, 20 Feb 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LmUX/xCs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487AD5CDF5;
	Tue, 20 Feb 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418344; cv=none; b=UQieitaD2KOT5dwW45uRJ3wdqzM1dpGgYP0B01griDdfWKmJVLaRdDkTsWjIe0ut4BeKvOP+zE994Ij+hfB2wd0IUmuw4PKo7p5RBJZlCbE/jrBrd0+xwo8D8ShVxvyeXQ1mL3gbxLt5YqBUsDkJryHL/215powLQ5t2/NgQDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418344; c=relaxed/simple;
	bh=kzLrKBPcUTW1ikS77w8ls5Y99614P/SjjSX03YkclJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6hS5TRkZwEkqmYENnfRRVnMyHhjcy5BV3fLbLYeAKhJDvOUG/6ZJRDM/ah5IO0EGOqplP6lJ5N/eyDMdMFKrCl8pgUkmDE9NLClZ4SJoli0S+mimNJ1MgctRUTYhkXgo/Iocz1LOWil5bA+QxJb1CdhE2fwfEEqo8Nh31Imdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LmUX/xCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707F4C433C7;
	Tue, 20 Feb 2024 08:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708418343;
	bh=kzLrKBPcUTW1ikS77w8ls5Y99614P/SjjSX03YkclJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmUX/xCs1dHkjU/ePjUbWXbV95xKvq+WLoXGrvHrdxFba7R1GjtWQSKanc5kH7Wxj
	 tfSOKzXUhxmDe3HSZpQVYUswbj0ktIOphniayMDtHYMJ8HW7wSUKRk/ea3IFC4x73X
	 BInYTp4mxZ97PImjFK8vn0J6mOTez8Wvka0MomXM=
Date: Tue, 20 Feb 2024 09:39:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ray Chi <raychi@google.com>
Cc: Thinh.Nguyen@synopsys.com, quic_uaggarwa@quicinc.com,
	albertccwang@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
Message-ID: <2024022024-clarinet-poise-332d@gregkh>
References: <20240220081205.135063-1-raychi@google.com>
 <CAPBYUsAnuyLwek39GJiwin_Pit0waH-2fhQv-G21OYkjoz051w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPBYUsAnuyLwek39GJiwin_Pit0waH-2fhQv-G21OYkjoz051w@mail.gmail.com>

On Tue, Feb 20, 2024 at 04:20:50PM +0800, Ray Chi wrote:
> On Tue, Feb 20, 2024 at 4:12 PM Ray Chi <raychi@google.com> wrote:
> >
> > The dwc3->gadget_driver is not initialized during the dwc3 probe
> > process. This leads to a warning when the runtime power management (PM)
> > attempts to suspend the gadget using dwc3_gadget_suspend().
> >
> > This patch adds a check to prevent the warning.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend")
> > Signed-off-by: Ray Chi <raychi@google.com>
> > ---
> >  drivers/usb/dwc3/gadget.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 28f49400f3e8..de987cffe1ec 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -4708,6 +4708,9 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
> >         unsigned long flags;
> >         int ret;
> >
> > +       if (!dwc->gadget_driver)
> > +               return 0;
> > +
> >         ret = dwc3_gadget_soft_disconnect(dwc);
> >         if (ret)
> >                 goto err;
> > --
> > 2.44.0.rc0.258.g7320e95886-goog
> >
> 
> Attached the warning message.
> 
> 02-20 06:01:24.227725  root    86    86 W Call trace:
> 02-20 06:01:24.227730  root    86    86 W         :
> dwc3_ep0_out_start+0xec/0x22c
> 02-20 06:01:24.227738  root    86    86 W         :
> dwc3_ep0_stall_and_restart+0xb8/0xd4
> 02-20 06:01:24.227747  root    86    86 W         :
> dwc3_gadget_soft_disconnect+0x1a8/0x284
> 02-20 06:01:24.227756  root    86    86 W         :
> dwc3_gadget_suspend+0x18/0xe4
> 02-20 06:01:24.227764  root    86    86 W         :
> dwc3_suspend_common+0x5c/0x320
> 02-20 06:01:24.227774  root    86    86 W         :
> dwc3_runtime_suspend+0x30/0x4c
> 02-20 06:01:24.227783  root    86    86 W         :
> pm_generic_runtime_suspend+0x3c/0x54
> 02-20 06:01:24.227793  root    86    86 W         : __rpm_callback+0xfc/0x76c
> 02-20 06:01:24.227802  root    86    86 W         : rpm_suspend+0x534/0xd78
> 02-20 06:01:24.227811  root    86    86 W         : dwc3_runtime_idle+0xcc/0x104
> 02-20 06:01:24.227819  root    86    86 W         : rpm_idle+0x228/0x4e0
> 02-20 06:01:24.227827  root    86    86 W         : update_autosuspend+0x50/0xb8
> 02-20 06:01:24.227836  root    86    86 W         :
> __pm_runtime_use_autosuspend+0x50/0x6c

That's a kernel warning?  Odd wrapping :(

Can you clean it up a bit and put it in the changelog?  There should be
more info before the "Call trace" portion, right?  What is causing the
warning exactly?

thanks,

greg k-h

