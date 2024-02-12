Return-Path: <linux-kernel+bounces-61818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B718516EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61601F225D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F350C3BB26;
	Mon, 12 Feb 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HCqZorbz"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FF3B191;
	Mon, 12 Feb 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747636; cv=none; b=LHYX9sWedxnNuSYRjqCbYz5R32337bMs7wxjZlndC6btn9JfTrmSf9a1c5KsZEcQflV5pUI6XXDO2XqAq8cdDem/yhjiUejaCXZwxt6oP5cWoN4CPWTfPe236UsJ82L60RYZPQgPRB3GCPX80exV/6K9fZ26hYr9JMXBhVk/f2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747636; c=relaxed/simple;
	bh=HOOFzuqzT3fIYr/DIX8rmV3hi9Jkc6ezbSFq2yKsCNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VG/CRTE13qnovFd4WS8gcTLAkNk+wisACYnOjX+Tp3GU7I+lFd5haHZyw9R9nl4jBephavrdxxF7lr+VUEB2r0veYSBKCbJyXsKb0Ip/hBPvPB+bsel497+bLDflX26rpB29jvQYKyjQah8QH8VuXk//jBnndPeCikhTGVbMQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HCqZorbz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A14A240004;
	Mon, 12 Feb 2024 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707747626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rZfjdEu2RYZ/9BtHHNLkIKbP50Gk/4PTrBnkkv9ErI=;
	b=HCqZorbzy0esT9Eqv/sS9A2HZ4FrwPc/w9nx9jaj7DuOm8mxgj0PaRgWzh3jdZ9NbCOENL
	63gi1eZ8V05xzYU+5d4HG8vIdGBid9lAJaH/XrJq6obsJSREHR+qvy/iqMsZAZvHZ1pQB6
	yBcCy1YzjUqElDP4fDnwpM8RIknbl5fJ7KxsqeXwhl2iUHLx3OIXOS+lF46ITJQHzcaIAN
	q7/oWSa5EItG6QLW4IUMlLgNQywuaw/+4aPDawbHlvep8ZtTaO14bs+nLGsIQszn0JBk/7
	+Hljz66sK0u46tlT3ZmnMEOnVaB6/aBbX7tQ8MJ0KONxqtfUdGAiNbu3O6v9XA==
Date: Mon, 12 Feb 2024 15:20:22 +0100
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
Subject: Re: [PATCH v3 RESEND 3/6] bitmap: Make bitmap_onto() available to
 users
Message-ID: <20240212152022.75b10268@bootlin.com>
In-Reply-To: <ZcokwpMb6SFWhLBB@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
	<20240212075646.19114-4-herve.codina@bootlin.com>
	<ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
	<20240212143753.620ddd6e@bootlin.com>
	<ZcokwpMb6SFWhLBB@smile.fi.intel.com>
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

On Mon, 12 Feb 2024 16:01:38 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Feb 12, 2024 at 02:37:53PM +0100, Herve Codina wrote:
> > On Mon, 12 Feb 2024 14:27:16 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Mon, Feb 12, 2024 at 08:56:31AM +0100, Herve Codina wrote:  
> > > > Currently the bitmap_onto() is available only for CONFIG_NUMA=y case,
> > > > while some users may benefit out of it and being independent to NUMA
> > > > code.
> > > > 
> > > > Make it available to users by moving out of ifdeffery and exporting for
> > > > modules.    
> > > 
> > > Wondering if you are trying to have something like
> > > https://lore.kernel.org/lkml/20230926052007.3917389-1-andriy.shevchenko@linux.intel.com/  
> > 
> > Yes, it looks like.
> > Can you confirm that your bitmap_scatter() do the same operations as the
> > existing bitmap_onto() ?  
> 
> I have test cases to be 100% sure, but on the first glance, yes it does with
> the adjustment to the atomicity of the operations (which I do not understand
> why be atomic in the original bitmap_onto() implementation).
> 
> This actually gives a question if we should use your approach or mine.
> At least the help of bitmap_onto() is kinda hard to understand.

Agree, the bitmap_onto() code is simpler to understand than its help.

I introduced bitmap_off() to be the "reverse" bitmap_onto() operations
and I preferred to avoid duplicating function that do the same things.

On my side, I initially didn't use the bitmap_*() functions and did the the
bits manipulation by hand.
During the review, it was suggested to use the bitmap_*() family and I followed
this suggestion. I did tests to be sure that bitmap_onto() and bitmap_off() did
exactly the same things as my previous code did.

> 
> > If so, your bitmap_gather() will match my bitmap_off() (patch 4 in this
> > series).  
> 
> Yes.
> 

Regards,
Hervé


