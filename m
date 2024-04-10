Return-Path: <linux-kernel+bounces-138485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42989F1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913DA1F229AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330DA15E81C;
	Wed, 10 Apr 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kz/0yk2P"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521415E219;
	Wed, 10 Apr 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751888; cv=none; b=Pww3n9DOQRZbViFUswNQsGFmjSPMZsYRgrLuNo2vA0gVw68e3Ar+NkpFWnYr4QJgWJ3PoxDTefJI+M3HS2F9h599uHSYEGqiOGqZup8YhQ5ybH31tj8Tj3RbPsiHwWd0EhN8vYF7ZeF4BvnWcNDzoorNz3FSxRjjpFOxTKPVeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751888; c=relaxed/simple;
	bh=C6TTaj8C3gGDyMgcwpzgLzOx1oB8jniHUKHvI6XaAHM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VRTUhhmYEOxbuvblwYYCvpmSJj8oXj5ljwEV8zPw4eESQaBv9/A42KJwgQwQI9/4YqsxwWimkDmuhUwcy/ONyX193zJLIMIu5ohR3oRQA5fS3nM3iWBFB1GITPwcPer0j94MwsQY77McfBS7rMhIWqVagXJJXoL5ChhmX0Cj2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kz/0yk2P; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68EDD1C0002;
	Wed, 10 Apr 2024 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712751883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3ws31mOJD6WJ5PiqoLqg0x1rdfJP9Z5AmhmFZmsojA=;
	b=kz/0yk2P0u15uvLO3V2bIiiBeyKMosuhBgHxZkWris1gH74OkoU5jCPXSknQz1fwnbqCjo
	WU93j8pFtyf1I68J1uRLHRNfAg5gHZOVcMlMzHVsVuI0NHrTx8HflyI9e+u4/KSZym1ID/
	dLY1ynmBrfb0tNGPH9M0ukL+GBN7W+zJIfMTRlKVe+QSU7q152nT7Stn4Lg2mBWWFD4IAz
	is0Ld37Wwxu3wR4M4tX6oiZtMUnmBiv5xa+BA5V0S6lyrm4TKrsHU9+Xh30ivTw3v9rkKM
	KjmEQ3u/Z+jx+Z9jJ5DewvT9iMBn+e0lu7mg7yh+wHeLPrLuMrtg83iOywZIEQ==
Date: Wed, 10 Apr 2024 14:25:18 +0200 (CEST)
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
Subject: Re: [PATCH net-next v2 4/5] net: stmmac: add support for RZ/N1
 GMAC
In-Reply-To: <CAMuHMdX-F8LXWx=Ras4f+Dt_r485HKjRDLydDXZsnZBW8HJzxw@mail.gmail.com>
Message-ID: <9bd8eee4-952d-d5b2-c462-45c1466c54d6@bootlin.com>
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com> <20240409-rzn1-gmac1-v2-4-79ca45f2fc79@bootlin.com> <CAMuHMdX-F8LXWx=Ras4f+Dt_r485HKjRDLydDXZsnZBW8HJzxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1582177605-1727822458-1712751921=:538696"
X-GND-Sasl: romain.gantois@bootlin.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1582177605-1727822458-1712751921=:538696
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Geert,

On Tue, 9 Apr 2024, Geert Uytterhoeven wrote:

> > +config DWMAC_RZN1
> > +       tristate "Renesas RZ/N1 dwmac support"
> > +       default ARCH_RZN1
> 
> Why default to enabled?
> 
> > +       depends on OF && (ARCH_RZN1 || COMPILE_TEST)

The kernel doc states this as one of the possible cases where setting default 
y/m makes sense:

```
Sub-driver behavior or similar options for a driver that is “default n”. This 
allows you to provide sane defaults.
```

In the case of DWMAC_RZN1, it is a suboption of stmmac which is "default n", and 
I think it makes sense to enable the RZN1 ethernet controller driver if both the 
stmmac driver and the RZN1 architecture were explicitely selected.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--1582177605-1727822458-1712751921=:538696--

