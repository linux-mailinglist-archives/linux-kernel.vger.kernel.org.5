Return-Path: <linux-kernel+bounces-81757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F5F8679C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EB829DDB5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD21136999;
	Mon, 26 Feb 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LxhAMZUV"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30812FB20;
	Mon, 26 Feb 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959766; cv=none; b=g3KnzRb4to0lQFWraECqxg2hKaF/PIZ4JFfXvOulbgjn/dckPLvTiM+EReNNI9a8FyOXXCgV7SYO2MFJEG8l9rSl4RabMhewB9xDAw6pQfj8TkCci/hJqgIAhyh+FqdsgoE+Ujvn6zPI3mkHXqCDSCDvBT9RNU68LMBGemOanc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959766; c=relaxed/simple;
	bh=++bKhOmmTbnqJeVvKFotCD89SF/i/2dmPSn/v2BMW1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEiuVJscyZMbhK4kfNKW1mMM9GqMmH1i91ug+0K6f3bRW0OCrzaGFOk9yKMIqGe0YmSiLPUPmbFupSzh2PNz5h0wh8ijj1m+5VUYEzzBJJtEPgjHqx3ORlhQTB1gfgoiq5OufwSy3yBmMeU03CrZXtATT+tRx7wlf5qR7Q6425Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LxhAMZUV; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D644FF817;
	Mon, 26 Feb 2024 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708959761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhQdSa5w2SLt0irLQ3VTTOjn+66Wh8GOtpyJlh79610=;
	b=LxhAMZUVIZAJ7R8oDB6yi2m/uYuZSSUEi3VUz3ghcr/b4xtDJfNTmlccGLTbN1goXn+DQr
	gUEpwzcTBzoA9wR/pPjvT1looKFNWcAv0lcm8CcFhYWwc7/ymBCdwBOnvYMg75eyTU/YNG
	w9SnbP9MhK9XxGLaatr6MY62Ce9CiIdsfnNAzbUwS1EkmyN21QglRMoRIQUjcATi7ovtlN
	2v+HG6p0BX4agaovoF6hEWWiVDhrWg6w4GkIpzjoVOpbIR3UX96CCSNvxPk2Q/tvoWD1fq
	tf+viiUBKpgMNqTwUuAuCyXuY4C7dz5fGt+3q3g0xcBciLyoSSCfOC04NpKD9w==
Date: Mon, 26 Feb 2024 16:02:36 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next 1/2] doc: sfp-phylink: drop the mention to
 phylink_config->pcs_poll
Message-ID: <20240226160236.20c0be97@device-28.home>
In-Reply-To: <Zdx40zi1Qz61sCX7@shell.armlinux.org.uk>
References: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
	<20240220160406.3363002-2-maxime.chevallier@bootlin.com>
	<Zdx40zi1Qz61sCX7@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Mon, 26 Feb 2024 11:41:07 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Feb 20, 2024 at 05:04:03PM +0100, Maxime Chevallier wrote:
> > commit 64b4a0f8b51b ("net: phylink: remove phylink_config's pcs_poll")
> > dropped the phylink_config->pcs_poll field, which is no longer required
> > to be set by MAC drivers. Remove that mention in the phylink porting
> > guide.  
> 
> The porting guide needs to be updated with the PCS, and the details for
> that moved over rather than being deleted. While it's true that this
> member is gone from phylink_config, it was only removed after the
> introduction of the similarly named member in phylink_pcs.
> 
> In other words, point 10 should probably read:
> 
> 10. Arrange for PCS link state interrupts to be forwarded into
>     phylink, via:
> 
>     .. code-block:: c
> 
>         phylink_pcs_change(pcs, link_is_up);
> 
>     where ``link_is_up`` is true if the link is currently up or false
>     otherwise. If a PCS is unable to provide these interrupts, then
>     it should set ``pcs->pcs_poll = true;`` when creating the PCS.
> 
> However, for that to make sense, we then need the guide to provide
> details about creating the PCS, and also the mac_select_pcs() method.
> Thus my comment about a much bigger update being required.
> 

Makes sense. If that's OK I'll send a V2 with a PCS handling addition
to it, and see how that looks.

Thanks for the review,

Maxime

