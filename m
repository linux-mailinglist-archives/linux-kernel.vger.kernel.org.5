Return-Path: <linux-kernel+bounces-157328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EBA8B0FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36521C22F65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F39916C685;
	Wed, 24 Apr 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iMVDtcco"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136053372;
	Wed, 24 Apr 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976386; cv=none; b=YciiiTGC5VbH3DQACoiHGkqunTkyU/1ZRs1AIU0Sm9wtwMuX0ChulWm8eVMwd7QkE6Is1kzvB/L5la7VDUUcMGQwo0/9uXbeXTOrmdMsBc+DzLbqdL8u4x5ah1CFTtmQCA2wT8NWxTlvy+hFGz7F+jIJleTdaGVtx9mdg5jL6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976386; c=relaxed/simple;
	bh=z3eF70FQlQ72XvDhpe9rqk8ScoUbO1zXys/ZqDSFff8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EsJFQDEcLhk0fHrYPYoe9EZiu11tL3ubDWunuN5Qa6QFR1xiKcBtHySOjFoGkuJut66dO+8vITb5V1GVICyLDDkV8LBVck39x+gNMHctX5N2kRXPQywMHJ0ItymxUDczOO14h+SbClZ4jzogUPc6iDMNhNGJUpjykDx4lfdOJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iMVDtcco; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21B53C000F;
	Wed, 24 Apr 2024 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713976375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nVfX6CunHv0QJSiX7CwyfL7fs8TD4zil05zPYCaSh6k=;
	b=iMVDtccoEjyJoeXjQJLTyW/F8IkBaa/rp9MWSak72TbmK3OD5QfxAjn1in6WE98ZtBUyR5
	3P30Xa4NYEDOJWfQc45QcD3YdXvSv1WDXSusY+dtDC2jdM6pibXjIRocRI5egVRjFP2OOy
	ee13xRwe4nIhFtLSEg+D4hnIG/x9FNg9Y/zCSi8RjeyuNd8Oq5T4u1mYLqcrrN3fg2y5tg
	Mt8UhDahzyzg/3U7hicTJd9RbTxtnMHLCFR+RR6ZXQS+6gwZsApMHLOAIPN2expFnKgqOX
	Zi3tqaEjw8QcWzUf0o8XEAtexPfEvmQSk/JdjNpfLv+x9+AZ58jWDqhqAICBGQ==
Date: Wed, 24 Apr 2024 18:33:30 +0200 (CEST)
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
    linux-arm-kernel@lists.infradead.org, 
    "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 2/5] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
In-Reply-To: <qf637dtkakxbumefbei3qrhbpyxgerjwn72ixp5xh6mc6yjbda@6z6tm6hk7fki>
Message-ID: <27279f1a-e718-a8cf-ecfc-40f45bf6c500@bootlin.com>
References: <20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com> <20240424-rzn1-gmac1-v4-2-852a5f2ce0c0@bootlin.com> <qf637dtkakxbumefbei3qrhbpyxgerjwn72ixp5xh6mc6yjbda@6z6tm6hk7fki>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Serge,

On Wed, 24 Apr 2024, Serge Semin wrote:

> Once again. There is a ready-to-use stmmac_xpcs_setup() method. Which
> is currently intended for the XPCS setups. Let's collect all the
> PCS-related stuff in a single place there. That will make code cleaner
> and easier to read. This was discussed on v3:
> 
> https://lore.kernel.org/netdev/42chuecdt7dpgm6fcrtt2crifvv5hflmtnmdrw5fvk3r7pwjgu@hlcv56dbeosf/
> 
> You agreed to do that, but just ignored in result. I'll repeat what I
> said in v3:

Yeah sorry I took a quick look at your merged patches and thought that 
stmmac_xpcs_setup() had been repurposed in the meantime, but it seems like I was 
just confused about that.

> It doesn't look as that much hard thing to do, but will cause having a
> better readable code by providing a single coherent function for all
> PCS'es.

Sure, I'll get to it in v5.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

