Return-Path: <linux-kernel+bounces-95052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09E8748A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC33028516B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853291D551;
	Thu,  7 Mar 2024 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P8vhRTSJ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B851CF90;
	Thu,  7 Mar 2024 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796414; cv=none; b=cgooI+CL1yEJZU7t7ILrtz7EgcyKmo64jR4x4LoVgjV49tK9J74/FGYkFQzASzg1zsFvcGOAo4MlQlDzhjrDYLoYwQwRv0etwRuxGs8O/tc9+emFY/pYpD4uuPpd0ra8bqXii6K0csp+7S/noGZaZUxE5raFzz8BzHd4N0O62e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796414; c=relaxed/simple;
	bh=s5tJ0QIApsTMztJmvLDBL7x76du4iHpJXQLs952EM4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXs9N0G1QGAuLX9Ex2Q8st/UAkxFVL+2vT6qZO56M3oUOFS32HppADBEuF/HDFfY1EuUUMa/FF9N5XBR/7Ktu9r47z3Yg7cYYgin+KWzwfoQoj6KShmerQw5AIdbfI6q7IzQjtCsvWkQqMdffZS+aS1+gHpJJ6uJB/zhngBgs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P8vhRTSJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4D5C1C0008;
	Thu,  7 Mar 2024 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709796409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xj17IIU3mZI+eCLparz/ED3UapItdhG48ep26M0JvY0=;
	b=P8vhRTSJ518ktE6j0m/qxCBcIS1lVkemkyN85nYa4BoMpelyHYZzXuFRpZ1cWIGgeTKCBM
	ookJUy2RR8mU8frm6nQKWx70so7K3yARVwe6MrxU/w6HIftKGVPEbuZVFDLA4EnpwamyEJ
	Z0vxtCZdfs41BY05p4RLwWCA/sucJT8L5DAr5i3ZcDux/N3Nk/yzqInuObynnyOGFn3xJd
	rTC8IAzW+6rLPUp3V0/5+gSD6ythsBBsPWUOkccVjpTydkWwcoxfzUKjR3lJG71q7Jahwy
	EApL63PwkFSXpTgVVZTv4IV+mWrLvuuYWeo5CAELvB/7tMF6rCCOQMkR/aCTFw==
Date: Thu, 7 Mar 2024 08:26:46 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Lunn
 <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 4/5] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <20240307082646.6e9198df@bootlin.com>
In-Reply-To: <ZehqRMZwtazTf6P6@yury-ThinkPad>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
	<20240306080726.167338-5-herve.codina@bootlin.com>
	<ZehqRMZwtazTf6P6@yury-ThinkPad>
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

Hi Yury,

On Wed, 6 Mar 2024 05:06:12 -0800
Yury Norov <yury.norov@gmail.com> wrote:

..
> > +static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
> > +				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)
> > +{
> > +	DECLARE_BITMAP(ts_mask_avail, 64);
> > +	DECLARE_BITMAP(ts_mask, 64);
> > +	DECLARE_BITMAP(map, 64);
> > +	u32 array32[2];  
> 
> NIT. Bad name. I'd suggest slot_array, or something.
> 

A new iteration of this series is planned.
I will change to slot_array as suggested.

Best regards,
Hervé

