Return-Path: <linux-kernel+bounces-146453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589128A6585
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DCB1C223D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932F8665B;
	Tue, 16 Apr 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LtugVChy"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24184DFC;
	Tue, 16 Apr 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254160; cv=none; b=bApw1S4hDRpQefYqV/yPKrrcnMYO/eUEVZ4onME97n+2CbjuNQ7f7Z/v5e2nIy08244Z8wIGkXclAvVqynwW/PJtMXd2h6HMPNljesusjIFXpdtB9TCd4cjX50d5gQtxaDk66ivEP0ayGeboAaY9+Xs1v45F8VPf7d1NNarSiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254160; c=relaxed/simple;
	bh=FNHbQiBBP8Y9Z4UhDHB1kGtf1vaeV2YhdLHMFkJwVuo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SpZxrvs72TJ8ElumHN3AvMjJbEQfvAaSdomwcPY24DF2P2r079ipZRiZ9ZA3BivYqAswkfaPm/YWbM4UvU6NA7/nCLST8IWsTBlK511lx2HvKlm+r1SgCeBiUWilV37KiI9wENR2EOGcySMizCO/JT8rp4ze6IoOjJhooSeduI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LtugVChy; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B3FEFF802;
	Tue, 16 Apr 2024 07:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713254157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNHJECVaeH5Bqcxn+tWmMLACctSfkhVXpwFzee2HMAk=;
	b=LtugVChyoDxebpXTrApSPFU1i07DT8qK9YJEwMwn/0JmI6ndkLuG22gdGgU0V+VI9K923L
	CK6F7wKZ7kaniEyTR5uvoEug6BjcnL1a/xdRTo1RsS1ZyHpnWZ8z14QKM7oMhRF+mWiy92
	vWxP33Z9hLCY2jjTfrGbZRZ5gTmEdY8bEl7vj1HjfNZ8dF685mQdeRCVSdB/IHcemRbh/s
	3xvMTWwNHqrUJxfAw7f5LSxNhnI4n+aw+YjU/IwJxsHyFLkYUsvcULOiA2MmqKyVkTCXZj
	QblLIhQt69FkaNO52lwcj+uADa+0o9vJMWZ7Sx51X+/M7rkz+wjyn/uqUU4ozQ==
Date: Tue, 16 Apr 2024 09:56:32 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>
cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
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
In-Reply-To: <20240412180340.7965-5-fancer.lancer@gmail.com>
Message-ID: <714199e5-edf2-dcbb-216b-563431d70488@bootlin.com>
References: <20240412180340.7965-1-fancer.lancer@gmail.com> <20240412180340.7965-5-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Serge,

On Fri, 12 Apr 2024, Serge Semin wrote:

> +static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
> +					 phy_interface_t interface)
> +{
> +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> +
> +	/* Get the MAC-specific capabilities */
> +	stmmac_mac_phylink_get_caps(priv);

This is a bit of a nitpick, but the terminology is quite confusing between 
stmmac_mac_phylink_get_caps() and stmmac_mac_get_caps(). Ideally, we could just 
get rid of the whole stmmac_do_void_callback() complexity and just call 
phylink_get_caps() directly. In the meantime, maybe renaming this to 
stmmac_mac_core_get_caps() would be acceptable?

Please let me know what you think.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

