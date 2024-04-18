Return-Path: <linux-kernel+bounces-150019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E28A9929
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B461F21507
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857E515F326;
	Thu, 18 Apr 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hy2SsbNn"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BC15D5D6;
	Thu, 18 Apr 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441435; cv=none; b=I27qv2qQY785kiym2kiUH34xyBhGZ1Q89aVm4YW8vlHwJ1U53c55dlgUz7hyyGPzlQyqNU4aF8+umzErHGSHhZtqvVxoAFncBixVnv2Vt8yrvUYdrXoauHP/bXk0owjdfR1WQCEeyv7TvnDijdPtPrQ/ihK7C/EG0TVUo2SbI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441435; c=relaxed/simple;
	bh=M7F9AOhLfsq2Uh4staUpb8IChltcrroxoNWvR3Qvuxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IxjEJ3BrwCjMPPf3Hgt/uFw12F4MktI64W4bIeNZogmnEdNbZ05LvG+XuhrEYIthHdlGad+efeT5ubaBXzQatyPn2fdCheG2eXC/gm+EbaH4M5ArQTQJ5K+Rw32jDWRpYBOhtF85DWuSRCVrkMV7r3s9YF9IN8ogbYlyDx1R4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hy2SsbNn; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD03D1BF20C;
	Thu, 18 Apr 2024 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713441431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1G2JcwttleuEX4OArtvrIC9rhjBFn4pb36VCCBIh/k=;
	b=Hy2SsbNnYmDiJbouDoQakG4O9hhGXW4f+OjvJAR3aQz8kL2s8/mbpBjipIEcykp1brgcjr
	kJ+d9gSauDycypI+PmrGrD9mrzFGc23eeqRwQYLbkzGRyeXVKEcMiWZg5hWbUgpJznFlRn
	5V7abewlK8QD2a6f8PjfAXELplvwBZP2YIPnkUR+48xmyi0cvNa/YPqRE2B2fk1ozWk2Y6
	MU2FCi0NcSbFEC7E0hWlLKOWpRrQBUDsU6a9RVthAORmx26StgefFaaICrvbzSgrLdQppE
	1ZmdlRAGxtTWxKIcm+wOGUO8UuWr6897yKZsU3eT7r8zUI5i35pKX4KaHo9c2A==
Date: Thu, 18 Apr 2024 13:57:47 +0200 (CEST)
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
In-Reply-To: <xp34tp5cjmdshefxjczltz2prqtiikagfspf4lobznzypvsyah@ihpmwfynwzhh>
Message-ID: <232e3b0c-ca55-2da0-1c9f-47520a1bcfbd@bootlin.com>
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com> <20240415-rzn1-gmac1-v3-4-ab12f2c4401d@bootlin.com> <xp34tp5cjmdshefxjczltz2prqtiikagfspf4lobznzypvsyah@ihpmwfynwzhh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Serge,

On Tue, 16 Apr 2024, Serge Semin wrote:

> > +static int rzn1_dwmac_pcs_init(struct stmmac_priv *priv,
> 
> > +			       struct mac_device_info *hw)
> 
> AFAICS hw is unused, and the mac_device_info instance is reached via
> the priv pointer. What about dropping the unused argument then?

Unfortunately, this is an implementation of the pcs_init() callback, which is 
also used by socfpga (see patch 4/6 in this series). The socfpga implementations 
use the hw parameter for both pcs_init() and pcs_exit() so I can't remove it.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

