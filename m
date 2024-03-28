Return-Path: <linux-kernel+bounces-122841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB96A88FE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9390D295238
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694907D08A;
	Thu, 28 Mar 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="mKPdRH/9"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A22D792;
	Thu, 28 Mar 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625942; cv=none; b=r9iNNfRzuuv2rJVyV2AQ4Sj/JM1PzlKpavyvmqR76vuSAGSMKzV4erJ6nt0jTMhTxjT0wjvnbpdHbxIjk4QHh25hGdWMtNlT2KSE5szEaC6qmDAtCe+WlQpv/R/YJhCjxgzBeAdAfDgaGNDnrH+eb0Ey6QkeaAUBcCHAiAOsu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625942; c=relaxed/simple;
	bh=8RmK43ggvfQ1+WvpcWl0NYjVeNhqoikpnYsbFbW3j/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lucML9/6L6nI1A3rgbvChuSAg6iKJX0yQfCx0z6rRM69WsGg0g/DcrwXu1H3A7rMPo9Qcso04F908aUY1qCAoWuJdW2ocq4MI8/7KwEmn6QNt84qTp631txdEX0pxkh1dSl3QNbIbVAJSeBYxOWAeYa6aM6ZhLgf0YZcAFkeP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=mKPdRH/9; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 36AC5609EB;
	Thu, 28 Mar 2024 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711625939;
	bh=8RmK43ggvfQ1+WvpcWl0NYjVeNhqoikpnYsbFbW3j/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKPdRH/9zOwwU9H2YcgUUwdq5iUKUx6g9oxw2e/eKPuxkN8OweTp1WWZsbGA0WAcI
	 L4tlmXt215Gs+8h7J7hKjm/b8nsTTn+svvULk9LRsUXidnEF2PJlFk78d3jFAe7sr5
	 +33ADM15JgMKew990UW2mqb3gAS++HmeGuxmwq1f6bCVKh3AD36zYwLlTT6ahOwRmf
	 OjNw2L2CnOs5eqGYN7ysNVan8GVsyz128jzLlcJTzFkdvO4tVZk028dk+gyhVBBM/n
	 4VvQDRnlskomUPXlLNDrA4wXLr8+HjCfg1fU5U0iq4pI6tvMB5KlDtmQJMriU8Hoal
	 NmLJ28gS9hDxg==
Date: Thu, 28 Mar 2024 13:38:45 +0200
From: Tony Lindgren <tony@atomide.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: linux-omap@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, nm@ti.com, vigneshr@ti.com
Subject: Re: [PATCH 2/5] bus: ti-sysc: Add a description and copyrights
Message-ID: <20240328113845.GI5132@atomide.com>
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

* Dhruva Gole <d-gole@ti.com> [240328 11:19]:
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

Well this particular driver did not exist until 2017 :) But for the
earlier hwmod arch code reference above, we could make it 2011-2024.

> Also, for TI should we stick to this format as you did above?
> Copyright (C) 2011-2024 Texas Instruments Incorporated
> perhaps?

Sure that works for me.

> But otherwise,
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Thanks,

Tony

