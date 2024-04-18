Return-Path: <linux-kernel+bounces-149963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9A78A9878
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147EE28418F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC68C15E7EC;
	Thu, 18 Apr 2024 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RjKcP8eC"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7B15AD99;
	Thu, 18 Apr 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439466; cv=none; b=jQ2COdTfludtGTXmb+WKDw15GVVN6C6qAq+C9qB9+KpC2kgHOjbGTVsFujQ2L7twxmcizLmwkugvgDjh1JSeMIrwVKoOdx8NN0b6I8FIM9nD5M7Qg1bGGoVAPBCy2FtczAncmHH76PfWOtyxr0G2OMk0Ol2r0KS4s6XQng03qHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439466; c=relaxed/simple;
	bh=oc066vT+D/F5ovmoh/FG9gPN0vrcXHwurKJtRWRajb8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ukdsEfvl81jJCoHEHSnMzeXEDIRl71Axd9Ft/DUutNdmtVyZbow2n0UCK5C2pfysWzJqCbty+P9R4AUYQtWlNrwVv1dnI3sAlUq3JPqPks9zxOks4KqeyJWr8QEet4vYe20AQGrFUrVcp1FjZlLAqZE9peBSKH3ey7+LBt6XGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RjKcP8eC; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7D8AE0003;
	Thu, 18 Apr 2024 11:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713439460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMOGVNbuITYt7dy+1dT/3leK/5M9H8PcreUPt+p35qI=;
	b=RjKcP8eCCvgTt8VGT8VoIlKf0Qq6wN1vbHBN65pxwLkuoNSCCRK9HMIckOEc7Pmk3kxTN0
	Y14XTy+U0naNbBritHYr/5MoYDZj9oZm7AB5GSvTo4z9DTD0SiPxe0GwgxNzIW9eV9RVM/
	LVS7FDjuhPyJyN2nvTk0SeXijjt7oVx4KDFMlSHrErHJ+5+n9mLvPfgmI05Jphqx8MXe/n
	3HOKNshqS/DM6R0bDDbngk/eKBeSl9EvMysy9TeEGAVbxEVcf3IGTUaBJ8VQeJY27rfz8K
	1oy9fzsN+qb+Glkaf/Na1dKUANBKFagdcw8XuoHhc0ZnI08f25vTEMLXOwy2+w==
Date: Thu, 18 Apr 2024 13:24:56 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH net-next v3 5/5] ARM: dts: r9a06g032: describe GMAC1
In-Reply-To: <CAMuHMdVWEMSR6vKSPdXRbf5_dqBWsM+Z2PV46DBmwHAoBNv_5w@mail.gmail.com>
Message-ID: <57f94b4a-75e2-32ad-506f-954c13498cd8@bootlin.com>
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com> <20240415-rzn1-gmac1-v3-5-ab12f2c4401d@bootlin.com> <CAMuHMdVWEMSR6vKSPdXRbf5_dqBWsM+Z2PV46DBmwHAoBNv_5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Geert,

On Thu, 18 Apr 2024, Geert Uytterhoeven wrote:

> > +               gmac1: ethernet@44000000 {
> > +                       compatible = "renesas,r9a06g032-gmac", "renesas,rzn1-gmac", "snps,dwmac";
> > +                       reg = <0x44000000 0x2000>;
> > +                       interrupt-parent = <&gic>;
> 
> The surrounding "soc" node already specifies the interrupt parent,
> so there is no need to repeat that. I could fix that while applying
> to renesas-devel for v6.10, but it looks like there will be a v4 for
> the rest of the series anyway?

Indeed there will be a v4 so I'll fix it.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

