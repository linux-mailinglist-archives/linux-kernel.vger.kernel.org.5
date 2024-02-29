Return-Path: <linux-kernel+bounces-87091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0EF86CF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046AA1F2357D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2D3433C0;
	Thu, 29 Feb 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EW77o+6R"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDA160638;
	Thu, 29 Feb 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224251; cv=none; b=mO1fDgQzjnTA8VKzt/mOQMhSW5ANVkli/aaL2Vw+L9lcSC8bAsVN3xlihsTw3kisE6yTg0mOv+i+9msoZp7Jes8w1+kRLG89qaWEkB/90LRSPobNbJVj3g6RA+tkWPp0WzPp/D4qjd4xemHZkJrFDiD2i+zVnlulQXmhpExHu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224251; c=relaxed/simple;
	bh=ZFgn9dvYdWUi6qzXbxQCIoPqKZKJiWzRsNJ+igw7Mxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kezLWPdKY5pVyRrWniAQ1raCvEgkJPSH27y+MvxwdT7VfPq6vp9ZpGAg0XaimjGqOfqgOFyoZVyeMNlZM5T6pM+Nd8O0EA923QecCULJSbEj/LkzMjJdDL2fhmw/zaSCBN3jlVVC48/Z1JTAkVog7/BX0VIwgVcetd/Wy/3P0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EW77o+6R; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B303C000D;
	Thu, 29 Feb 2024 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709224246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDGt+EA7hkCFccMGYrVs2zoZyoxmiDzvNkKrfbOvX+E=;
	b=EW77o+6R6+tU3vtpYuza6yzR1k55eFiv3f2qtwo20rqmjPP5AeMUOmCIAsbt+6GAu+z3j/
	/4nGFkCoCmPeA2hsE+ACxc4Me+Uusd/z3j9bn2Wg5XAg6YxQsOdnmOL0a3NZizgiw5HG2E
	/5SS1B/WgSSSsG7E7Z+fMVxnyoT6KT8yy2B7/SERUqvhrR27hivzhBpxef2hj1K9xShYxJ
	dpIDb8GpNhq4GocYrkZDTKki1UQRhGK8dCJMZEMmAwmqULU0U3By/kdvGAcskpVrAhOEmd
	dMhQTouPzTeFBDXgqk5Liy8k1884JUfhtV+dOfuBWE15SrmId5NdYR9hQjdYhA==
Date: Thu, 29 Feb 2024 17:30:43 +0100
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
Subject: Re: [PATCH v5 4/5] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <20240229173043.3dc5decf@bootlin.com>
In-Reply-To: <ZeCg24Iv8qDmxNV9@smile.fi.intel.com>
References: <20240229141554.836867-1-herve.codina@bootlin.com>
	<20240229141554.836867-5-herve.codina@bootlin.com>
	<ZeCg24Iv8qDmxNV9@smile.fi.intel.com>
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

Hi Andy,

On Thu, 29 Feb 2024 17:20:59 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Feb 29, 2024 at 03:15:52PM +0100, Herve Codina wrote:
> > QMC channels support runtime timeslots changes but nothing is done at
> > the QMC HDLC driver to handle these changes.
> > 
> > Use existing IFACE ioctl in order to configure the timeslots to use.  
> 
> ...
> 
> > +	bitmap_scatter(ts_mask, map, ts_mask_avail, 64);  
> 
> Wondering if we may have returned value more useful and hence having something like
> 
> 	n = bitmap_scatter(...);

I thought about it.

In bitmap_{scatter,gather}(dst, src, mask, nbits), only returning the
weight of the third parameter (i.e. mask) can be efficient regarding to the
for_each_set_bit() loop done in the functions.
For dst parameter, we need to add a counter in the loop to count the number
of bit set depending on the test_bit() result. Will this be more efficient
than a call to bitmap_weight() ?

Also, in my case, the third parameter is ts_mask_avail and I don't need
its weight.

I thing users that need to have the dst or src weight should call
bitmap_weight() themselves as this is users context dependent.

bitmap_{scatter,gather}(dst, src, mask, nbits) can be improved later with
no impact to current users (except performance).

That's why I concluded to return nothing from bitmap_{scatter,gather} when
I took the old existing patches.

> 
> > +	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {  
> 
> 	if (n != ...) {
> 
> ?
> 
> > +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots %64pb -> (%64pb, %64pb)\n",
> > +			map, ts_mask_avail, ts_mask);
> > +		return -EINVAL;
> > +	}  
> 
> ...
> 
> > +	bitmap_gather(map, ts_mask, ts_mask_avail, 64);
> > +
> > +	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {
> > +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (%64pb, %64pb) -> %64pb\n",
> > +			ts_mask_avail, ts_mask, map);
> > +		return -EINVAL;
> > +	}  
> 
> Ditto.
> 

Best regards,
Hervé

