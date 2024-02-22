Return-Path: <linux-kernel+bounces-76905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71CE85FE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B56BB2387C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA48F153BFA;
	Thu, 22 Feb 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nuYshMwG"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15B153511;
	Thu, 22 Feb 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620606; cv=none; b=mxXqYwGuGI5Nb3hE0SY9qPvGNQpYw3k4nviHHvQzbEonN1p8FxvEDqY0vLlsE+lcgrez6VYsekrWSw2w62d4+ROzgGI5TpoEpaX+4DmLvCEhKD6w7opNTnwg+aXjMg6k0bWzdA8TgX0qcUPpQfUODKyXajcFMSJunoCXq+h6+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620606; c=relaxed/simple;
	bh=WQ8J/MZsH2vzEpVzHEOKc9Ad3stIDyGyoURkyC1Y3Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMgh0M052CdW5t47Q2ZcncqkHHfO25KFQ/prs0CylRrG5905ACIpuxymv/TiHY9a3KiAwoByWwR4rXbWFND5QJEpDqmgfuDn1hWskvt3WjcFCiUwyWwMzWMSlIUPUYELILjESE2aZbChsPxvoLiaAm5IhFHERJm7Y0w39qoBdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nuYshMwG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C41811BF205;
	Thu, 22 Feb 2024 16:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708620602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19qhGNmQmWm9BCOh8qUm/W3o9hKN/eZYOSKauiIFfoY=;
	b=nuYshMwGlMUB6NdNCDKR2k/WM9Ms7Q/xXxQMJvOyn6XcCUUOSkmbB7v4BphjOXQdRDq6ft
	5Kk34TTJiC//w2a7g7aPDHRsI1rtsjvEap40y4W41OI+nFwV0cWOoMZpTupFan6qEpoN4d
	YDNERvNW5AVAsApFCmaWj6ph5QjpC1Kw6HH8GibCvreOmv66EswhaYlfXGCBqlQDVydlS4
	Zou9Ox0rlcFLYDRZDNc8KA4dchaTfAQq9bvoBzRPyC2o/bCnG5fN+wg7wN293MsMvmlS4M
	Y4b6k6JA9ATcrLJo42BpLaQPA+KtE3Peq7SHjCvF9vf0K7rJhFvfZzLT/azi3g==
Date: Thu, 22 Feb 2024 17:49:59 +0100
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
Subject: Re: [PATCH v4 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <20240222174959.7097c29b@bootlin.com>
In-Reply-To: <Zddqr3aN4rU-upai@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
	<20240222142219.441767-4-herve.codina@bootlin.com>
	<Zddqr3aN4rU-upai@smile.fi.intel.com>
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

Hi Andy, Yury,

On Thu, 22 Feb 2024 17:39:27 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..
> > + * bitmap_scatter() for the bitmap scatter detailed operations).  
> 
> > + * Suppose scattered computed using bitmap_scatter(scattered, src, mask, n).
> > + * The operation bitmap_gather(result, scattered, mask, n) leads to a result
> > + * equal or equivalent to src.  
> 
> This paragraph...
> 
> > + * The result can be 'equivalent' because bitmap_scatter() and bitmap_gather()
> > + * are not bijective.  
> 
> 
> > + * The result and src values are equivalent in that sense that a call to
> > + * bitmap_scatter(res, src, mask, n) and a call to bitmap_scatter(res, result,
> > + * mask, n) will lead to the same res value.  
> 
> ...seems duplicating this one.
> 
> I would drop the latter one.

I would like to give details about the 'equivalent' in this scatter/gather case.

If Yury is ok, I can drop this last paragraph.


Thanks for the review,

Regards,
Hervé

