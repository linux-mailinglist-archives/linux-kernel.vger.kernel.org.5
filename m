Return-Path: <linux-kernel+bounces-123129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EB389028A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C381C2A505
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF112DDB8;
	Thu, 28 Mar 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="LGKHhnyS"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57912F398
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638047; cv=none; b=YJZG55Tz/HTxEZ2S6k3i9tLZMl3SefnhmMN5uUyFOkXpEszApV59V1cHr3YDvNkvHB7xBXwjAJBRXo/QQGfFq3ZplicPEW08iipQdGYAugiDNxyDbAliZKVnCb4bI/RYDj3diTZaRtyfX25Fn/wwh4pV/fNazqJBGMvWhgXOrjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638047; c=relaxed/simple;
	bh=EoHim42owK348cZhl/I9M1pymb0CHHmvTuAnkh/utqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXc7UNNj0QNbcY8op2f8VbVOv/K/vX0s1rE+vL9CmuIaL4Ov7BUFy1A9dsQx46ll6xzw9igKTA+x+UBrB/UY5YSygufZx9VRgMxXJCmn9g7ood8PbCQgcdndaxohj/ybCAOf6laWb+MD5bEc0jsfmeVTIGIAGm5Ja4Hy5ceJLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=LGKHhnyS; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Fri, 29 Mar 2024 01:56:24 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1711638043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwp1Qw0/EtEt4456dlzV/Bdcj7tMPkZXlkry1Wr4Z8Y=;
	b=LGKHhnySkPwGebCdv/mVHphyxvQc8crAcv2Oui6bANMhmRHEJY6K/I2Ih6ly5HFvYpnUHr
	RaUk1/+0ZaAAyPuNk32vxYEQYx4aouN64DPVOXSzVM0WlRfOVF3VvetqnNrc7RB6mHZfUR
	inf9ihorMeBYe1/lMJsjrHpxhqHn/RM3fcBpIbCgRU5OFMhfta4Roy8pnpjHXNQhBSuCtA
	0ZUlE2egI+t8HpZUXQuAiqiYiO023tOnBUL8Gs0BxbWGG2YGwH2bL9q89kJuOAViz0zvBS
	AEIE4C395ksCyP/I+kqd4xxYCwZBNHvU5GWaOirrFG3WcF3d3oxrDVehHlndWw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sunxi: sun4i-i2s: Enable 32-bit audio formats
Message-ID: <ZgWFGHvjjGkRVubV@titan>
References: <20240326-sunxi_s32-v1-1-899f71dcb1e6@jookia.org>
 <23447395.6Emhk5qWAg@jernej-laptop>
 <ZgTUIWh8qXH_7oxQ@titan>
 <9055efa5-8da6-47b2-b2db-d1f8e02d2267@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9055efa5-8da6-47b2-b2db-d1f8e02d2267@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 28, 2024 at 01:56:42PM +0000, Mark Brown wrote:
> On Thu, Mar 28, 2024 at 01:21:21PM +1100, John Watts wrote:
> > On Wed, Mar 27, 2024 at 08:53:32PM +0100, Jernej Škrabec wrote:
> 
> > > I wish it would be that simple. SUN4I_FORMATS is cross section of all I2S
> > > variants that are supported by this driver. If you check A10, you'll see that
> > > it doesn't support S32.
> 
> > > If you want to add support for S32, you'll have to add new quirk for each
> > > variant.
> 
> > Yes, A10 doesn't support it. But it should error out in hw_params due to
> > get_sr not supporting 32-bit, no?
> 
> The constraints shouldn't be advertising things that hw_params() will
> error out on, sometimes there are contingent constraints that prevent
> this but something that just doesn't work isn't one of those times.

Oh right! I'm not sure how I forgot about this, given I went through this
exact discussion for my wm8782 patch.

I'll try and get v2 patch for this soon. :)

John.

