Return-Path: <linux-kernel+bounces-86814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A8886CB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF7D1F2516C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443A1361A5;
	Thu, 29 Feb 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b6r/o/Mu"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16E1350E4;
	Thu, 29 Feb 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216115; cv=none; b=E/dCkG263cMII9LXK3tOptOKArQFzQrZ2pDF7PrplbfqN9Ap9kfEPqEyaZ7yEZzP+8ypqqYz9Y4ouG2CNrmRSQPAbUNwfZdTNl6O49nS2OjaTybHkT6seHz8Rlba5gYHTgHJxZ1+ouWDa+x5yRnlopSUP8iEuoPGiThx1SppKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216115; c=relaxed/simple;
	bh=17Re2ZlxCpPi8VT+NvWtc5Nizs8oPUXsA0ViMmWSD4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUriKcdBfbaI74v4i0WKBSucUTgoJLpfoE9TdVjjxd4SsOP6mZRDuaNaFAixUIaiNRzmYjd9Q+ZdE4wdDxHk3+PvbLZ8ipYGeQhSTCgA4xMbPOzjuWlDHUrRLi3c+/QwQusKr5Iv1+wSQTnhhpkHlAvJJUkQ94HibTs+FK7Vc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b6r/o/Mu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C95CAC000B;
	Thu, 29 Feb 2024 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709216111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VODy3+pzl+mL+SxkoGGkZEMj3lgjxIWIJ0o/1JFBQvs=;
	b=b6r/o/Mu9TPn/uf6l5ivBke/Yz/QfZOFnWspbOdUT0tyBMQOKs4qIYOoR80iSfCPE7+p5h
	AAUAGna7VQJxSZM+VDSWJKDe2oJzV66x1gGVd/6LduwPFq0qTVHd1B/+h8NorBAnZSIcP/
	llrWdkcy9+423XM5HVk1urmeMUm7XZW6hYce7vGmM7BUQ+kNQTgMxjgSgxMqtIug+/DiKp
	D4Dz7ohiNB374q5JIOCvZutQHbGkMpRQEcgxkr8hjjHhGBRZfm5Y4EpjMSTHWmrSssd8iR
	iI2qdB7wlO0GKPxWr0KDNkWmXVV5rtFba1PfxpQlSc+drhfweBMAfYo5N+vhEg==
Date: Thu, 29 Feb 2024 15:15:08 +0100
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
Subject: Re: [PATCH v4 5/5] net: wan: fsl_qmc_hdlc: Add framer support
Message-ID: <20240229151508.42432f9c@bootlin.com>
In-Reply-To: <ZeCNboCslYgT8tjb@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
	<20240222142219.441767-6-herve.codina@bootlin.com>
	<ZddtFG4bvCX-lsn3@smile.fi.intel.com>
	<20240229135605.6454052f@bootlin.com>
	<ZeCNboCslYgT8tjb@smile.fi.intel.com>
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

On Thu, 29 Feb 2024 15:58:06 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Feb 29, 2024 at 01:56:05PM +0100, Herve Codina wrote:
> > On Thu, 22 Feb 2024 17:49:40 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Thu, Feb 22, 2024 at 03:22:18PM +0100, Herve Codina wrote:  
> 
> ...
> 
> > I've got an issue with guard(spinlock_irqsave).  
> 
> No, you got an issue with sparse.
> 
> > I have the following warning (make C=1):
> > drivers/net/wan/fsl_qmc_hdlc.c:49:12: warning: context imbalance in 'qmc_hdlc_framer_set_carrier' - wrong count at exit
> > 
> > I also tried to call guard(spinlock_irqsave) before 'if (!qmc_hdlc->framer)'
> > but it does not change anything.
> > 
> > Did I miss something in the guard(spinlock_irqsave) usage ?  
> 
> You may ignore that for now. Not your problem, no problem in the code.
> 
> https://lore.kernel.org/linux-sparse/8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain/
> 

Perfect, thanks.

Hervé

