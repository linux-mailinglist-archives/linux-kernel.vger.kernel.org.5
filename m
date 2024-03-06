Return-Path: <linux-kernel+bounces-94180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3D6873AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD21C21314
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89941135417;
	Wed,  6 Mar 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OOcZi+Pv"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611B1353F5;
	Wed,  6 Mar 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739799; cv=none; b=TlqvQXj9eI8iVtN2/VI6gVGAxJEIdGZwwQWxPa/YmWIqurUg/S0hfkaOYF8J0MmJ3kTNoAJsNkPa3GimODxv9opLlfcfZtPvuQMOpsSpgGD0LaSSYa2+IY1coZkYQV+yeFgBP3GuN0QT1dOiAC5Kw+DtPEeacw9KkCMoJyOtaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739799; c=relaxed/simple;
	bh=CdLAI+mWnl48rftVyLTtGfQFJM4I5eon+K0K+2xZeXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFnPTHaxsAeCI8+bcbNohF5W8ETQCRLdwdX9ew0tbUTgbVMm9dm4UDKLL7GWH0AwDi7CJV2yYysMI6xVXYxPdn0E0WqqGHhA6RkWoxbfNizERrjOBFn/F5BJO9zFougK87dHJWPCtqwu2exzgZ1WdGCCrwCYv+EbAUxtp0DUFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OOcZi+Pv; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B42E140004;
	Wed,  6 Mar 2024 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709739795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYq2Ln/cYGg9mHiPcZf1m5ozgzbPmfufP7t0HGayXEU=;
	b=OOcZi+PvRqJOXRQte4KHieNLJdGYo88Y4btcN/OcBc+Ytvgx188h6khSW53VMo+IVL1Tay
	u+2U/0RkJwAtqKIPvBzY4bFONCgfSoJY4s+YpVRKnQGyrrVzRn2HbHNQZFI4T/3OkMddib
	tJ6TqyXn1Jub3h2Cpb6If3dUDcnSMk7sQB2B73LfCNfpOWoeDJEK+MbWdzE5nLKuMfAiQI
	qullN1y/jyU7TAOMbqMYUb8lb9hl70HdFalssK2GSF0o2yUC24gcAQEhvZwK40Mr8BpjZ4
	kROknzsitHe6IaaPQt0kJNGoXx+itPF2FEtXJrgtUWpQJBF5q1TDhHIPxcTTIA==
Date: Wed, 6 Mar 2024 16:43:11 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yury Norov
 <yury.norov@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Lunn
 <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 4/5] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <20240306164311.735ded83@bootlin.com>
In-Reply-To: <Zehy6K0Sj-cqcxZE@smile.fi.intel.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
	<20240306080726.167338-5-herve.codina@bootlin.com>
	<ZehqRMZwtazTf6P6@yury-ThinkPad>
	<Zehy6K0Sj-cqcxZE@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andy, Yury,

On Wed, 6 Mar 2024 15:43:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 06, 2024 at 05:06:12AM -0800, Yury Norov wrote:
> > On Wed, Mar 06, 2024 at 09:07:20AM +0100, Herve Codina wrote:  
> 
> ...
> 
> > > +	DECLARE_BITMAP(ts_mask_avail, 64);
> > > +	DECLARE_BITMAP(ts_mask, 64);
> > > +	DECLARE_BITMAP(map, 64);  
> 
> 
> > > +	bitmap_from_u64(ts_mask_avail, ts_info->rx_ts_mask_avail);
> > > +	bitmap_from_u64(map, slot_map);  
> 
> > We've got a BITMAP_FROM_U64() for this:
> > 
> > 	DECLARE_BITMAP(ts_mask_avail, 64) = { BITMAP_FROM_U64(ts_info->rx_ts_mask_avail) };
> > 	DECLARE_BITMAP(map, 64) = { BITMAP_FROM_U64(slot_map) };  
> 
> This looks ugly. Can we rather provide a macro that does this under the hood?
> 
> Roughly:
> 
> #define DEFINE_BITMAP_64(name, src)				\
> 	DECLARE_BITMAP(name, 64) = { BITMAP_FROM_U64(src) }
> 

Well, the construction I used:
	DECLARE_BITMAP(foo, 64);
	...
	bitmap_from_u64(foo, init_value);
	...
can be found in several places in the kernel.

Having the DEFINE_BITMAP_64() macro can be a way to remove this
construction but I am not sure that this should be done in this
series.

IMHO, a specific series introducing the macro and updating pieces of
code in the kernel everywhere it is needed to replace this construction
would make much more sense.


Best regards,
Hervé

