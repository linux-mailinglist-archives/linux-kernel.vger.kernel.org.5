Return-Path: <linux-kernel+bounces-78202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACEC86102F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38DCB21DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74B67C4D;
	Fri, 23 Feb 2024 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N+4llCPZ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDD14B835;
	Fri, 23 Feb 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686989; cv=none; b=rD9cudBRjttmh3cCEdUoGUDDOIaXFGmcKo3aTNzGiChSvH2x+8+/OaNsuLRIkNZKk0e1JdOOdTQh2ePRh2S0bckx4poYLcVjZnmbM4vB7GL9wuW8Ok22MkRgBG3+FKo5A0ejByXmyfxtwS+cq8tkCfmXSLXgWx9XEvwPdGWSob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686989; c=relaxed/simple;
	bh=bCP9xIHaRBY6slhXkEczq0iwAfBBoyIZlUPlQCFQ93o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7KboKzNl1tCyVZuIDsJCc6raNO+21YkZZUogkwMRi21dEPMPgLiKSEwfeRBZHV9IlHgrgi1peGIX2o3C9ATlZlIO6kv++ie7IyIw/3TJ6BYLreObba3+cpi4P07Qdyokdt4YjS4bc6oCyTbHyDw0ZwH2NIslEt8zVDfLYku4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N+4llCPZ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1B1520005;
	Fri, 23 Feb 2024 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708686984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCP9xIHaRBY6slhXkEczq0iwAfBBoyIZlUPlQCFQ93o=;
	b=N+4llCPZevgTvBggZq8lo7lMJfaFDrjsN6nOnM/ydnQgxhWC8rE+xxvEJjjJcQCo+FpJzt
	TWR0vQvsOJU6KVR8Vh1QvcrzAYfpzBVOJis1Cm2JHDmd61mXcjEh0D/jQHxam+d0xoQhuh
	M6k04k+EmUf4dQhiumN5C4hjn0ILWLr12S5bzUampCnMdtdPYocFdtFoFkM4bfkLFWxRkZ
	iVxApVsJUQ+/jP8HtPbKsspxH1GxLRJAMJq+p7J5t5p7s1kywwoe5ykknRVxNhpL1M5Ff6
	yd6zlqC0ugVd0NmAlwmDX78yIm9X2YGWQ+UBQKYliBor9uLdY+ftZKwCI35TJQ==
Date: Fri, 23 Feb 2024 12:16:22 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: =?UTF-8?B?SsOpcsOpbWll?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH net-next 2/3] net: phy: dp83826: Add support for
 phy-mode configuration
Message-ID: <20240223121622.6bd9e3b1@device-28.home>
In-Reply-To: <20240222103117.526955-3-jeremie.dautheribes@bootlin.com>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
	<20240222103117.526955-3-jeremie.dautheribes@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello J=C3=A9r=C3=A9mie,

On Thu, 22 Feb 2024 11:31:16 +0100
J=C3=A9r=C3=A9mie Dautheribes <jeremie.dautheribes@bootlin.com> wrote:

> The TI DP83826 PHY can operate in either MII mode or RMII mode.
> By default, it is configured by straps.
> It can also be configured by writing to the bit 5 of register 0x17 - RMII
> and Status Register (RCSR).
>=20
> When phydev->interface is rmii, rmii mode must be enabled, otherwise
> mii mode must be set.
> This prevents misconfiguration of hw straps.
>=20
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes <jeremie.dautheribes@bootlin=
com>

This looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


