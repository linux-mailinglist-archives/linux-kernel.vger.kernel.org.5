Return-Path: <linux-kernel+bounces-76582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFD85F982
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D76287711
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2161339A4;
	Thu, 22 Feb 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PGAUTrbI"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D961332B3;
	Thu, 22 Feb 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608079; cv=none; b=DIoLC8J6NqUesgI1juVqhy/qy6jk+5EeqJ44avNQB8kEd0SYoh5uRhoh/UCNeFQ48eptqDMiF+qoVMdfcsDz9BMeGFYvUNgFI2aR9Kk8TpGhhqCuHQ1Ha8cilqLuvYOAk7fOfl1qi4gXgEbXiqYjdxmp/mQHlDJXivGHmUE+dNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608079; c=relaxed/simple;
	bh=+EMIKnrUGp8vSSsqfLUeU1CTP0eQxnSJ538uMv+9x5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiswajQronvi5YqQttD2Xijus9as07Ip9i52Is9ogLGQpcRKX/2R0qqqO/injHNGAEmTzYWUgQeMn3Xc/HVooHKkLbZW4wT7ngQDkeEtnL880fU+4WHdUm3+JjkK3kf2sEzPjJxWy/QGyl4RL90OXTfM1c9rSXCHY1VYnhC4N4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PGAUTrbI; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F83EE000F;
	Thu, 22 Feb 2024 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708608069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIJQOiwsnPIHMQCuDyLqsDgu6VLT3hR2HUacNiT4rNQ=;
	b=PGAUTrbI2eCYfRgeudmxg+COgy/tQuE6n14TZt2RLEpK77Qn6/l4pRGeVzsKhRCvSu0Hjo
	zL3KLbt/+cwhZEit8wBneRi3vehint6IiHprNwGQARsvgWsYM4rqENtPGohGy89BC84pGJ
	azWoL4sUK6aTyxhnnQUk6SaQYCaQscLAd65eBMko37g0lRn0QvuXr7fFzlM3X68ocaVFaj
	ut6tv/vkqOhlVqKv132PEs1EGJibbSa+9AesvPwsSv0WJ4uFIzouV/jyLx67IRW9BasKWV
	424JPQWzD8YHW7CwJT6alnw4PISPHnPm8oZ45x3LIvCSejBVOT7yw3QDBukCCg==
Date: Thu, 22 Feb 2024 14:21:06 +0100
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
Subject: Re: [PATCH v3 RESEND 1/6] net: wan: Add support for QMC HDLC
Message-ID: <20240222142106.35dfa03d@bootlin.com>
In-Reply-To: <ZddJz9msz1ACmw_k@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
	<20240212075646.19114-2-herve.codina@bootlin.com>
	<ZcoNoDRF6h2C7TQd@smile.fi.intel.com>
	<20240222130516.5e139612@bootlin.com>
	<ZddJz9msz1ACmw_k@smile.fi.intel.com>
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

On Thu, 22 Feb 2024 15:19:11 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Feb 22, 2024 at 01:05:16PM +0100, Herve Codina wrote:
> > On Mon, 12 Feb 2024 14:22:56 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> 
> ...
> 
> > > > +#include <linux/dma-mapping.h>
> > > > +#include <linux/hdlc.h>
> > > > +#include <linux/module.h>    
> > >   
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_platform.h>    
> > > 
> > > I do not see how these are being used, am I right?
> > > What's is missing OTOH is the mod_devicetable.h.  
> > 
> > Agree for removing of.h and of_platform.h.
> > 
> > Why do I need mod_devicetable.h ?
> > Isn't including module.h enough ?  
> 
> In that header the definitions of many of ID table data structures are located.
> You are using that in the code.
> 

Ok, thanks.

Hervé

