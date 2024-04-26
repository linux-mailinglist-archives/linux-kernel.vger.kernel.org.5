Return-Path: <linux-kernel+bounces-160747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513508B4247
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830691C215E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B93BBCA;
	Fri, 26 Apr 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GXA1OfOh"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A953BBC5;
	Fri, 26 Apr 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171288; cv=none; b=VB49P8naaYzLQ6c+k1U0DTmsKroFjRepoF1dtuTkFVWqlPwvf6UZMfEs2GRlSRN5ebpbFt5wfl5EDCGqdYLQQzIuqgELhXoYWqFQyM9inOcuPFmziUM50cgBgljcPcdTFjX3nAwK0FtdmwJ3lucHSZB8ws1DYb8yXRAkbIejVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171288; c=relaxed/simple;
	bh=vZKtcZYVRAMqBRpL0CJRuYdyohcVXJMTXBSs6eu/1IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/rxLYbSN4xoYbvwEFtQEazL1dq/xMeVmSFUQeIUMjmQJMieLxldwMoN9gWJ7FH9I8bDGGKi9lgOUJ7DaZB4WiAVqO/ihb93oKCsOBpjgVA+dfyaJfBX7phfqRVMMmD7vbZnEBoq4JUsSF28EZgF/3Rlxq68MeND4Li9Arwko9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GXA1OfOh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PvZ/i9r3FVZj4alsX5Jepp4+7BJpXMZbt0ExU5aF+ZA=; b=GXA1OfOhyUuYOMS8rX51yQ4NhB
	z0hxpeeaMdcTn9AximebwffapVKvVhe0+re2LV01QBKHyKpnfNnyAqGLCeIWK81gaKXHGRebrhVlQ
	KxfQUGehYjbphUEPtYqV20wCd9+ki+82VuPOmUFwau9etZMnCIdc0+1g/lsrT7huCqg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0UFr-00E75d-Un; Sat, 27 Apr 2024 00:41:19 +0200
Date: Sat, 27 Apr 2024 00:41:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426124253.56fd0933@kmaincent-XPS-13-7390>

> Let's begin simple, in PSE world we are more talking about power.
> Would it be ok to add a regulator_get/set_power_limit() and
> regulator_get_power() callback to regulator API. Would regulator API have
> interest to such callbacks?

Could you define this API in more details.

I'm assuming this is mostly about book keeping? When a regulator is
created, we want to say is can deliver up to X Kilowatts. We then want
to allocate power to ports. So there needs to be a call asking it to
allocate part of X to a consumer, which could fail if there is not
sufficient power budget left. And there needs to be a call to release
such an allocation.

We are probably not so much interested in what the actual current
power draw is, assuming there is no wish to over provision?

There is in theory a potential second user of this. Intel have been
looking at power control for SFPs. Typically they are guaranteed a
minimum of 1.5W. However, they can operate at higher power
classes. You can have boards with multiple SFPs, with a theoretical
maximum power draw more than what the supply can supply. So you need
similar sort of power budget book keeping to allocate power to an SFP
cage before telling the SFP module it can swap to a higher power
class. I say this is theoretical, because the device Intel is working
on has this hidden away in firmware. But maybe sometime in the future
somebody will want Linux doing this.

      Andrew

