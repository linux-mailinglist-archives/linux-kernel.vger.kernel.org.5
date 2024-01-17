Return-Path: <linux-kernel+bounces-28643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD2830140
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B6D282267
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45866111BD;
	Wed, 17 Jan 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XpGHtRkR"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3AC2E3;
	Wed, 17 Jan 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480014; cv=none; b=EDEhb0t82WL2AoHwKLQQHwtjNMmAS78AzYjnOm4cJzfFbxPwVlp9wWzuhj6Xll0bXtWq7XiNv0xMeZCFAby7WbJsOKQj8SJkJtQotS6jfxml6lzwTeMbKVTgRdVKajMJXO54UXw1hw9U1ctcK4GJG2isHaTUo3IJRA/WyTkD/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480014; c=relaxed/simple;
	bh=Fu1R7P8eMCin1OY/qCPZtclkmrVqJa5Kvi/9RjdPeMY=;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version; b=gEdKoFYz8Ir7HP+MsAlEf81lBENLlDawPsdknDcMWZe1hFA+5QX2o1IT2vPmMgDopHmbnQ9kFj2ABjhUtVpLrlnogrXsW+iixyg5az15YGp0/nXPpoQD2qh8z/xDS8jZGN5JYg8e+isS/0VcYUQsSXISmLPskPyvxBMqYioLtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XpGHtRkR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 910CC200EF;
	Wed, 17 Jan 2024 16:20:28 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1705479632;
	bh=hZ9j8UuXRkmu15JoqsIHh0GDdaekortIGwbW9yvv6ts=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=XpGHtRkRfLDwrUodELF03yxjD4NPXkDcZ1NSbJNn14dWioGavFVlSgGMoTZRpbIKX
	 kn8W8nkaVlGw3rx6xgEhoJKZfg91VDffqlP6tkIHFz+VjjrITvYT2rF04aPia0WKHO
	 +bhEzP2JnZlUfQ5lYteM7FLCfzxSxI2df8kTCAuT5EDg5s9kPdEiFdORu5hfg1IjR6
	 FYwhYUris9LHOzxXE3wvbtf3BSZVesoK6QJ9v+mHKCWf8mm8/wWmDAdFrdMPyTsOpi
	 WHPSdC26WXLCKAUqIU/od3F9KOky/x7y9RSbw4mRXs1SWY5Ls1z8T+n+BLslEF7xYO
	 JQFX2jy7i8cFg==
Message-ID: <491efee1860ef1fbe94f990faea9c40cd99294c4.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/3] dt-bindings: i3c: drop "master" node name suffix
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>,  =?UTF-8?Q?Przemys=C5=82aw?= Gaj
 <pgaj@cadence.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Conor
 Culhane <conor.culhane@silvaco.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>, NXP Linux
 Team <linux-imx@nxp.com>, Dinh Nguyen <dinguyen@kernel.org>,  Boris
 Brezillon <bbrezillon@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
 linux-i3c@lists.infradead.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Wed, 17 Jan 2024 16:20:28 +0800
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

> Drop the requirement of "-master" suffix in node names because:
> 1. "Master" word is discouraged and MIPI Alliance renamed it to
> =C2=A0=C2=A0 "Controller".
> 2. Some devices can operate in Controller (Master) or Target mode,
>    thus the name is not accurate in such cases.
> 3. Other buses, like I2C controllers, use simple "i2c".

Sounds good, thanks!

For the ast2600-i3c changes:

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

