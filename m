Return-Path: <linux-kernel+bounces-64765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71276854299
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D97D28C22D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9119610A13;
	Wed, 14 Feb 2024 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="hcTaoN1n"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6AC126;
	Wed, 14 Feb 2024 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890564; cv=none; b=GDC1b3cf39LX7IPt07VNZzbFWMHFyRbqa5TvEy/t/R7DReynE7cJbkANksJ5JqT+JVCRx0H4GMcXq6msVPpL/+5qy4OcvBMtNq1fZfxV2tTfNQ8Af0wo08W2eSJPgMU2JbHBrXDLRitvTRvsArYCoaF9Ejkjf8OUbTKsBUskp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890564; c=relaxed/simple;
	bh=rNhahkQxaw8giaBJ+cD4PMrgcK6khgr+AoCBGGG5LNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkelwzZDcfRQCr71MswBBWFAfgf141wWBEgFxmQhO0Yje6QomJ/kQwHwHzQOSiT4Aw5nRvUSepuQvYBgwYX5l+LEfIVxHpCyRZ1F9R/85TDBsYDRTXad25DfP5qsuEjur29IwWbMXshJck9MkhX89ZkaBjRW4jqz+bIX0lnRIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=hcTaoN1n; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9468C60476;
	Wed, 14 Feb 2024 06:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707890562;
	bh=rNhahkQxaw8giaBJ+cD4PMrgcK6khgr+AoCBGGG5LNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcTaoN1nq7n8ne6/VqKBVelBcyf8/z3VCwBKoO27gDWv34bj6jVqnjXWIKOAIg5j1
	 C2tg3WJwREQmDJW+nVJJkrdsUCM5Yko5rlpUOxw1kIx+QI+LaE/HMHZcINvxgg4p+B
	 ndPIPcIaMlNVKfc3S+AznYmMHbT1953YlqxeTch8ivdEPf+uA2yaM1P7Em61+jlwUW
	 dIhOtsFAGubz/cgWSfcsKPn/bp3OkUlzQxXy1w/pWW0myykg4hk/HC3op3Y0xL62KQ
	 QKnB9w0himQfc0pTg3XaPMZLATXH5QMgE8KB7VMgHkRCMWP08At6v1UMSQ866jc0YY
	 9oCDJejw99vGA==
Date: Wed, 14 Feb 2024 08:02:09 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 4/6] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <20240214060209.GM52537@atomide.com>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-5-tony@atomide.com>
 <ZcuQc3frV99SKkXd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcuQc3frV99SKkXd@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240213 15:53]:
> On Tue, Feb 13, 2024 at 10:45:11AM +0200, Tony Lindgren wrote:
> > +int serial_base_add_preferred_console(struct uart_driver *drv,
> > +				      struct uart_port *port)
> > +{
> > +	const char *port_match __free(kfree);
> 
> = NULL
> 
> > +	int ret;
> > +
> > +	ret = serial_base_add_prefcon(drv->dev_name, port->line);
> > +	if (ret)
> 
> Otherwise here might be a problem.

Yes thanks for noticing it.

Regards,

Tony

