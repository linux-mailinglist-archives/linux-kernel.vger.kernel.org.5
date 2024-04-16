Return-Path: <linux-kernel+bounces-146865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763AA8A6C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335272819A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824C12C485;
	Tue, 16 Apr 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jprFcJrV"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE912C466;
	Tue, 16 Apr 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273672; cv=none; b=fJpjmMBbtfMLnJfwQPq9SesjKsP7cITAzTavnkCHRZ7kFrCNptjHXBfkrL36eRUSo74fDr1Ytn5Yw3PfxcqxWfhhwGR2povoFRodoWz0UcwhbKL34lWwrnn3gOMqjUPmRwWbm8qrAKbAt0KUZlS5k80x3AmYEGE1TIpN/7VCOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273672; c=relaxed/simple;
	bh=H9XJnECG+rehggPZBwMJ2UcoWV6pit0iZcc8APFEx6U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gs2NZyAShD60MZjb3M9o5UIaKuyT6bwpaDegDMYHXpeGlGijaNWyX5oVLTvH/xSkR+i+uGAmgxv+V6i9LiThD/BBEJVBnyXV2rhNDTW/atbWbZAIjx881OojUl0rN/qYxq00xhXTAF/tBISIlJrJ6X9g01PtdYRdXIOTO1K82VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jprFcJrV; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 979BEC699F;
	Tue, 16 Apr 2024 13:21:03 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F9ABE0003;
	Tue, 16 Apr 2024 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713273656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCnKnoSsQoEAYv75BNn3l7B7yy2mGKGbl/sOd184mU0=;
	b=jprFcJrVd9rSnrTiyxix2blgTrCU/Qlp+tzngtuXlZLiieDwzkoOldUgEDp5yVLsbulKIZ
	CzSEXc5zzaQHSVsTI5W6AOCIkga+IsG1oFTjYI+JU7a3nor22PG5eIgHIbgpmXTpUzBalM
	mCn64ex2Hn2WUlBRAFWl2qzVao7CKHpEBs+ucgOXjh4GH4LmArUBjbOWczTwHYK7ShMHNl
	KmqTxXL6PM1QSO34cOPfhY+Nfw1c63wJjVcxyoZ6Vh/+Qj5UH4M+GBNyfiDllwmnsAfBBo
	Il45EZNbkMeX3HOTXI5P3oxAe/GyR4f2LJuUEWuXGSighZKeZw4vOiEL7rntOA==
Date: Tue, 16 Apr 2024 15:21:30 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
    Yanteng Si <siyanteng@loongson.cn>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Simon Horman <horms@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
    Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: stmmac: Move MAC caps init to phylink
 MAC caps getter
In-Reply-To: <btgxb3ugs4apjvxj5hmpec3rtoxwdal7ms2z4s7pecdfefphiw@gd7ctqsh7wg2>
Message-ID: <8ffb6634-6d57-8df8-90c3-aecc585395e5@bootlin.com>
References: <20240412180340.7965-1-fancer.lancer@gmail.com> <20240412180340.7965-5-fancer.lancer@gmail.com> <714199e5-edf2-dcbb-216b-563431d70488@bootlin.com> <btgxb3ugs4apjvxj5hmpec3rtoxwdal7ms2z4s7pecdfefphiw@gd7ctqsh7wg2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Tue, 16 Apr 2024, Serge Semin wrote:

> So I don't think that changing it to something different would be a
> good alternative. What could be a better option is to rename the
> stmmac_ops::phylink_get_caps() callback and
> stmmac_mac_phylink_get_caps() macro-function to something like:
> 
> stmmac_ops::link_update_caps()
> stmmac_mac_link_update_caps()
> 
> especially seeing the callback no longer sets the phylink MAC
> capabilities directly. What do you think?

This seems like a good solution to me.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

