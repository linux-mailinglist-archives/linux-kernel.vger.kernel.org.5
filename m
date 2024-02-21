Return-Path: <linux-kernel+bounces-74817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2C85DBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8401F2479A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25DD7993D;
	Wed, 21 Feb 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kdesK/7Y"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF378B53;
	Wed, 21 Feb 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523079; cv=none; b=QG5khIVkdxLYc6TmDS/0cRB8Z0NhML3Lt49uV/CFQRXU3r5Xaf7SN+6btbuyLthPp3+g6hORr+loGhfChCjmQddRKvubKCjIMq9z8qeoARLZuXFS48Bh+gywD5ewhPHBPtRk5hdGUfdI9lt/V/KkYSDsl0+WTKdr60ezLdRrGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523079; c=relaxed/simple;
	bh=jZFVlaoxSO28+3NT998Mf72mtvHwv/LubVSsk9HbnJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKut4VhT30QQuoDMHN4meIItMUZZnXDo5CWzuBWPP65WZPkKCBu7Bf4fo8WYrt54Q6nZ6YPs791hzzJCTblYL5UaIZTjGno22+B/i3AqPvEjSGhaZuGyfvHMB7sW1YJAJxiejh9fMFEasLfEEoiEYH1SDWnIxH6okzJktYNlFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kdesK/7Y; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5980660002;
	Wed, 21 Feb 2024 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708523074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrp+YmUU+v0EhVwMHcIQvcwO/VqJPYfeVs/EWjoSXJA=;
	b=kdesK/7Y8qVDLsCghR0aipV1MYMOWBJevJpEdYlrmc+vqk331xncXZaKQoDfbTKsCCgSY4
	pFkpEI4J2SsnRORd0MParLYiqNXZEC0a3TnwNaqQy/0YWUbt+Tq47dTm+couH/C06schmB
	ydviN/SiZmK85C5VpjWmT8eZImWf0aZqcjg3/r0+a9W/sFC/IbYkakP5vMepKmLSsKfJFx
	s42dEoJyKi2pBT/xce43VCQsZDEyc8Qc6JToSDqcToxLTiFiLAJbQ7NiJpSbD6ZzQ64ov1
	QG0Jsv2yr0Ect/roDJsitO0mbz/6jScd4Mnbg7Y/Zm4Fn/90vLBKjJ/ueMtQqw==
Date: Wed, 21 Feb 2024 14:44:31 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 3/6] bitmap: Make bitmap_onto() available to
 users
Message-ID: <20240221144431.149c3a16@bootlin.com>
In-Reply-To: <Zc5jQ3zR51MDIovB@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
	<20240212075646.19114-4-herve.codina@bootlin.com>
	<ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
	<20240212143753.620ddd6e@bootlin.com>
	<ZcokwpMb6SFWhLBB@smile.fi.intel.com>
	<20240212152022.75b10268@bootlin.com>
	<Zcos9F3ZCX5c936p@smile.fi.intel.com>
	<Zcptyd/AWrDD3EAL@yury-ThinkPad>
	<20240215184612.438bd4f2@bootlin.com>
	<Zc5jQ3zR51MDIovB@smile.fi.intel.com>
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

On Thu, 15 Feb 2024 21:17:23 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

[...]

> > Now what's the plan ?
> > Andy, do you want to send a v2 of this patch or may I get the patch, modify it
> > according to reviews already present in v1 and integrate it in my current
> > series ?  
> 
> I would like to do that, but under pile of different things.
> I would try my best but if you have enough time and motivation feel free
> to take over, address the comments and integrate in your series.
> 
> I dunno what to do with bitmap_onto(), perhaps in a separate patch we can
> replace it with bitmap_scatter() (IIUC) with explanation that the former
> 1) uses atomic ops while being non-atomic as a whole, and b) having quite
> hard to get documentation. At least that's how I see it, I mean that I would
> like to leave bitmap_onto() alone and address it separately.
> 

I will take the Andy's bitmap_{scatter,gather}() patch in my next iteration.
And use bitmap_{scatter,gather}() in my code.

For bitmap_onto() replacement, nothing will be done in my next iteration as
it is out of this series scope.

Hervé

