Return-Path: <linux-kernel+bounces-162503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D768B5C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE19B2858A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323FE811E9;
	Mon, 29 Apr 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5kNs7mmv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB37EEF2;
	Mon, 29 Apr 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402663; cv=none; b=Tw9vvKVenAaR/KMT3G7X8tM20IX0cghrfCmDBYCS6urb//xg2WXw0xxqF3Fn1n6qPxrpw5kNK/il+7IMVTt7GLgPPF/JvT65jOUuSlwxhpLY/1R8WIMpjd/6iZkEW+/mU91qvDitWNohnqlrB0phk0UBQPwiKRQYYepTwXffXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402663; c=relaxed/simple;
	bh=IcugJ0QwbKQ6I/BOBlgoBQscijLsbDvk0jtQCL+HSjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0p5NsCvlVFBVMuf/3IXrTRYEqTtu3GYnNpft9kynleG9KlwdoWPZmfjLYJhW0zQ1mzNiNIkrHqfTbU4ko8NZFHqSJrISrZd+KsamdVia+MVCU9ers7uDVbotE62O+H5jNl8osvGbLlfdEp2N2njd33fntnF5Nzmb2gVzWUo2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5kNs7mmv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cWBfapoZi8jsbt7Iy+JKtlaopk7WUGuiHafZVePp7/w=; b=5kNs7mmveYPQjgP4V1Uy81UUsm
	G1WP+1HAONV/YqfaHS9jlLRXy04i7tL67Yz7VRyu/TQ2w9Mcg1V3sgOaXpJcD1MHl9ir+tsKOT+Jv
	TJcryVSOW+nIY1+6gM18qqyTpEkT/gdOCxn4FVhIQNv09WefiIxr0Ylx/YW6qMtPayZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1SRj-00EGI7-6N; Mon, 29 Apr 2024 16:57:35 +0200
Date: Mon, 29 Apr 2024 16:57:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <5063429d-5dca-4538-b240-50c35cbf5e93@lunn.ch>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
 <57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
 <20240429145203.219bee06@kmaincent-XPS-13-7390>
 <Zi-vhKx-WlYPQe3c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi-vhKx-WlYPQe3c@pengutronix.de>

> Since there is already support to work with current (I) values, there
> are is also overcurrent protection. If a device is beyond the power
> budget limit, it is practically an over current event. Regulator
> framework already capable on handling some of this events, what we need
> for PoE is prioritization. If we detect overcurrent on supply root/node
> we need to shutdown enough low prio consumers to provide enough power
> for the high prio consumers.

So the assumption is we allow over provisioning?

> > So there is a potential second user, that's great to hear it! Could the
> > priority stuff be also interesting? Like to allow only high priority SFP to use
> > higher power class in case of a limiting power budget.

I was not expecting over-provisioning to happen. So prioritisation
does not make much sense. You either have the power budget, or you
don't. The SFP gets to use a higher power class if there is budget, or
it is kept at a lower power class if there is no budget. I _guess_ you
could give it a high power class, let it establish link, monitor its
actual power consumption, and then decide to drop it to a lower class
if the actual consumption indicates it could work at a lower
class. But the danger is, you are going to loose link.

I've no real experience with this, and all systems today hide this
away in firmware, rather than have Linux control it.

     Andrew


