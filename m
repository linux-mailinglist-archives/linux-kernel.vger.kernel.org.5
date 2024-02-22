Return-Path: <linux-kernel+bounces-77008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914485FFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A19B2696E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C0158D76;
	Thu, 22 Feb 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gn9siWgG"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955D156964;
	Thu, 22 Feb 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623912; cv=none; b=KPu5PpD9z5YoRWZ8raxl7nNJQJjE6GqxYLMXwK036UIJgdg2NH/swrE98IYN+m3IB7t2rBCq9zqFNQ07laOyf46P8kBHe/NIvl/NV7hLuwL2jrC0PFxDQHhhBc686lzuTcUvvJAdyEl3wlDUo0M6UtB5b9p09Kjt/1JtyMDEcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623912; c=relaxed/simple;
	bh=t5zt+TWCiEVitoTsZfoCUCenxBToFiWAiBgB3/Iqy6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN5quN1Vl3u6T5d38uizvZl6rEzuJP2KqOpPllmiEmOqZ71iVPGY0oCloRvxqaLW3f8ZSVmxF7fIziHYV4iZt3TBDlvYWg+YQ6VU73WGPOMtD+V4O10pbOJaAcNVW1etZzp8lYW+sSIu/fHd/NLV2xZzUTV9I4jGBuUu+sIRmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gn9siWgG; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 245471C0006;
	Thu, 22 Feb 2024 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708623908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3I/R/8qE9M+CRJjU12CIPkeWv2RmJWu64GPRTejT9A=;
	b=Gn9siWgGy58upwjuxgZs1XPEf1GDRTbpcvMhGVQfa6tZlTi2lsfyZpcQxf8FkXeGe9tIJ3
	yXjKmoW/ka+D12sjQlBQsSvGJWwZt/OmrV8PwIcpGmozoCEoRTcEIHnQfIB5NS9nuYUe3w
	6NNZ5+JB8LXFqUdqSjDStf+Re/To2Y1SMcEuNpRdnRJBWyF99+PvOGoGMwWH9B+MemlYfA
	j5ppLi6XsOPUBeewQUOqqILuWdqhnUNixduxT7ASbeeFv+tIAFO7M9bCFbOz9b1yKy0Ly+
	7Zf7N5aeK2sdiydUrmEj0FgyhvYGlOpTdaf2raQ0ULfAcGMmE05QtMlI+GR49A==
Date: Thu, 22 Feb 2024 18:45:05 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/5] net: wan: Add support for QMC HDLC
Message-ID: <20240222184505.7350df2e@bootlin.com>
In-Reply-To: <Zdd8ukxdhH16vRDJ@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
	<20240222142219.441767-2-herve.codina@bootlin.com>
	<ZddoQTg32unJJ_qP@smile.fi.intel.com>
	<20240222174501.4cbe03ab@bootlin.com>
	<Zdd8ukxdhH16vRDJ@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Andy, Jakub,

On Thu, 22 Feb 2024 18:56:26 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Feb 22, 2024 at 05:45:01PM +0100, Herve Codina wrote:
> > On Thu, 22 Feb 2024 17:29:05 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Thu, Feb 22, 2024 at 03:22:14PM +0100, Herve Codina wrote:  
> 
> ...
> 
> > > > +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);    
> > > 
> > > Why not using cleanup.h from day 1?  
> > 
> > I don't know about cleanup.h.
> > Can you tell me more ?
> > How should I use it ?
> >   
> > > > +end:    
> > > 
> > > This label, in particular, will not be needed with above in place.
> > >   
> > > > +	spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);
> > > > +	return ret;
> > > > +}    
> 
> Here are the examples:
> 6191e49de389 ("pinctrl: baytrail: Simplify code with cleanup helpers")
> 1d1b4770d4b6 ("platform/x86/intel/vsec: Use cleanup.h")
> e2eeddefb046 ("pstore: inode: Convert mutex usage to guard(mutex)")
> 
> Some advanced stuff:
> ced085ef369a ("PCI: Introduce cleanup helpers for device reference counts and locks")
> 
> Hope this helps.

Sure, thanks for the pointer.

Jakub,
nothing in drivers/net seems to use the guard() (from cleanup.h) family
macro.
Are you ok with having this HDLC driver that uses guard() macros ?

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

