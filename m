Return-Path: <linux-kernel+bounces-150206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458ED8A9BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85EB1F2377B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9EE1649DE;
	Thu, 18 Apr 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RmxsbDgx"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C26A8CA;
	Thu, 18 Apr 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448356; cv=none; b=ZKjOrqTuJE/EF5vU2s7jauO22adZTTuNkzOviX7mgjlL7eXpUSWhAmth2wdN77XYEhWcOr+rBJr8j6Pckr0lc/qaqWrkxxW+mhTFeyCc1pIambwZoWf+U4jdIfDwHirru5c5D+gaTsQl0QIJ7xXHBqLIkwFdlGaz3zma6i0ST/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448356; c=relaxed/simple;
	bh=DFMBpvLg9bEM08JQ9ob6upTO1i+WiZqw2n6cDonSo4w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hkLPK5vSU7Qq1oCMXrswgANtXkRoEOkivWE8HPXRsi8HmUIENYbZi/bAkLl+XpSaD9NKBGffq3D9MXtSnB707scAflPYNu8JMHnNsAncAttM2XpQ5VrCdaN97XoLuq2DqfnQihtwFjdVbGTR+Yqit+dLkiTuxM8LXs7nX/l8D+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RmxsbDgx; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2C281BF209;
	Thu, 18 Apr 2024 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713448351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wUOi164P3lAmjE1ClSdezuP19LGck9A7BJ4c8R2rWo=;
	b=RmxsbDgxhNpNQOPoFlayXDpwdP+tytqkGF2OJI6z52D3jvdH0BINaMaSOJABYa6/o6WxeC
	ghog+bvm/6xdvqTf7B+xQM1u8PJB3QGicA2yN5ueeF17yS8iO+LMOt3yX/95A/69vx0wFU
	cWHL5OJ6Vcw7APt18HuFE96l5gziHKoup8zj+aF3KookZJxRSzPjCOjoJAU1e0WxFzVysT
	v/WQR3MUr8UJwvigXjjQu2WXU9bhHEg4YS9NtOcNTo94oqfGuwGimoaaP5yb6TJK1bx/Ff
	aiZo6SsBfRs+qKWkz/kuZH1VCi7XUvW5NuGt7bGVzPZKfEQBmV9RD8UVbJaq/w==
Date: Thu, 18 Apr 2024 15:53:07 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Magnus Damm <magnus.damm@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, 
    =?ISO-8859-15?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-renesas-soc@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 4/5] net: stmmac: add support for RZ/N1
 GMAC
In-Reply-To: <eqfta73ost45nbzz3aoa2tw5tasg3geehf4fgphu4teq5yfvar@ngif2e6j5j2k>
Message-ID: <c99b452b-be35-3a67-1c87-042dbc5fce49@bootlin.com>
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com> <20240415-rzn1-gmac1-v3-4-ab12f2c4401d@bootlin.com> <xp34tp5cjmdshefxjczltz2prqtiikagfspf4lobznzypvsyah@ihpmwfynwzhh> <232e3b0c-ca55-2da0-1c9f-47520a1bcfbd@bootlin.com>
 <eqfta73ost45nbzz3aoa2tw5tasg3geehf4fgphu4teq5yfvar@ngif2e6j5j2k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Thu, 18 Apr 2024, Serge Semin wrote:

> On Thu, Apr 18, 2024 at 01:57:47PM +0200, Romain Gantois wrote:
> > Hi Serge,
> > 
> > On Tue, 16 Apr 2024, Serge Semin wrote:
> > 
> > > > +static int rzn1_dwmac_pcs_init(struct stmmac_priv *priv,
> > > 
> > > > +			       struct mac_device_info *hw)
> > > 
> > > AFAICS hw is unused, and the mac_device_info instance is reached via
> > > the priv pointer. What about dropping the unused argument then?
> > 
> 
> > Unfortunately, this is an implementation of the pcs_init() callback, which is 
> > also used by socfpga (see patch 4/6 in this series). The socfpga implementations 
> > use the hw parameter for both pcs_init() and pcs_exit() so I can't remove it.
> 
> I had that patch content in mind when was writing my comment. There is
> no point in passing the hw-pointer there either because you already
> have the stmmac_priv pointer. There is stmmac_priv::hw field which you
> can use instead in the same way as you do in this patch. Here is the
> respective change for your SoCFPGA patch:
> 

You're right, I'll remove the parameter.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

