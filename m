Return-Path: <linux-kernel+bounces-76475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0787E85F7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FE71C24639
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422AB46558;
	Thu, 22 Feb 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="URZPm961"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695A4642A;
	Thu, 22 Feb 2024 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603530; cv=none; b=P+lMslb8pAJO8tapcdR6rb4kPRXdUgI4bsArRzHiE7hkX0RqNSHOGX1dByHVyeBEL7eo0MLoqP/ikJ9eEMQXYY7u2pQgKzZzxrw20x+o7BSaIV/axXCN/ceP5jsFQ4H8t8AF0jQs6+gnifSLc1y1Zzdjh/TKVwzmEyPPSYpa5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603530; c=relaxed/simple;
	bh=QE8PnDDTJgkY/Sxm/yDuHrkH3udkDHWChsHX8XlggnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fth57JBqnJ5sQpbGDC+X+U0SJ21f+AdxVF5KmWlYuVVQ9PpVgzkT0uYC7kizMcTpUvWGGKAb2bHRIOaa2cA6yxUC7keT4pskJ6gm7jqqGGg0gFdafYLD0w20Wc1qXesAuAZovclJSw5Nr2UUAZ8jHQpHQmEBj+Y5UAPkeV4K+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=URZPm961; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C99661BF210;
	Thu, 22 Feb 2024 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708603519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IK1GlbJIzPjcabZtha8401cpHaWcLHGP+gKkN9qNPew=;
	b=URZPm961mF8mYOcJAgDR00zqwM0Dn3N4QZl0N2oWWtaXfGjWDDlYQvlUbL3CDAN6kgyCUg
	Sa/kYcuhdo4WuPAVb76+mFosL/QhUvPmgobIz9hovbYR/U/imSuZownAKFMQakW2OOT9ye
	sS8qWP4WwzYbDADh1DTPcZbWGA5FStJ53GEY65XPGusASjN1apCsKge2DnQRUr8HgAQvXW
	LfPjJzPTbyHeZ5fu40Avdt46xTHwzIvj4wJxlta8lKhKAfTAD3pYtYcVHRCQhGJNwma9U2
	MmTBeFin+N5TU23BsleoGMz2paD4+gEbv5dxPQEvfXve45QNaR3jvOncIyFO2w==
Date: Thu, 22 Feb 2024 13:05:16 +0100
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
Message-ID: <20240222130516.5e139612@bootlin.com>
In-Reply-To: <ZcoNoDRF6h2C7TQd@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
	<20240212075646.19114-2-herve.codina@bootlin.com>
	<ZcoNoDRF6h2C7TQd@smile.fi.intel.com>
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

Hi Andy,

On Mon, 12 Feb 2024 14:22:56 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..

> 
> > +#include <linux/dma-mapping.h>
> > +#include <linux/hdlc.h>
> > +#include <linux/module.h>  
> 
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>  
> 
> I do not see how these are being used, am I right?
> What's is missing OTOH is the mod_devicetable.h.

Agree for removing of.h and of_platform.h.

Why do I need mod_devicetable.h ?
Isn't including module.h enough ?

Best regards,
Hervé

