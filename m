Return-Path: <linux-kernel+bounces-69842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC20858F5E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852362824DF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A927A72A;
	Sat, 17 Feb 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cZm6w3+q"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1041487B4;
	Sat, 17 Feb 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708173750; cv=none; b=YH/c6khnjc7oUMHWfnsZ9UCSMIgEwS+cq1GPoBN+IGTHp/WL6w2Afs3KeU2Evqz4flsP4yAwkAXm25ynkBi70UCZT2t7ZnVlGRP8+FsVxPEvTV+UNX/9bECuvHahB2UrdA+uZb8LQA1cVHfYpczpTMMs6Reh0amM3sVZKaRpPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708173750; c=relaxed/simple;
	bh=b3g8uEPS+3Ef3BYg2KSNVRp2AFWIwoooI5Kly5xpPZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPWnayKCFyzURg3oNbI7pXyHB8bP3Uwjk0lSqaK2yRL60UBM+2+KjwL4WaFL8hdji6o5WuydHBkqwRzkP+4tvNfrfIagm2WFH8W2N6Njh/QuQJ1k/pLudkRMMlQFiDlo7QYaIVWZCFYJbtm/U6BqDG2M0v4ngb6AdZQJjk9VaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cZm6w3+q; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64E86FF802;
	Sat, 17 Feb 2024 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708173745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQgQFC20iCOwYcRfjCRWjcJxj6kdRvb0sW/GpMA0iJA=;
	b=cZm6w3+q/UHjIT1yNRcAtWgateZy+3L53YEsxa8c0kbbAEj7aWy5AFrxj6rry5XSn9IF1M
	sT+b48pGm6Dbwqf7PWGXGB9DYyA8rgLo4Z6HcP3sO/cREYR0dfOL7IKM6jvRQHdZUQDLX8
	dGvaU1z+9dq+Tdm0/WBz2I9WWXpSW8yE2NA8JLFV4oY0StaAUa8ZKw8Bi7lf1VpSEA6Gat
	JJ3VGzSFbxSM5jVo5yPLcXMayJ++a4QX1PSgmntwv9QmTKJxOdD5lXyEufGFe0tT3Or9aH
	VLy8fnI6yzSpUVkK3fUTy08Ni3w0cq4IbSrs3qkZJ27zPKvMZn2wxvPryuteOA==
Date: Sat, 17 Feb 2024 13:42:23 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: i3c: drop "master" node name suffix
Message-ID: <2024021712422352187ad4@mail.local>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
 <00d6a0d5-6787-4777-8fb2-dcad4304a724@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d6a0d5-6787-4777-8fb2-dcad4304a724@linaro.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/02/2024 12:26:12+0100, Krzysztof Kozlowski wrote:
> On 17/01/2024 08:56, Krzysztof Kozlowski wrote:
> > Drop the requirement of "-master" suffix in node names because:
> > 1. "Master" word is discouraged and MIPI Alliance renamed it to
> >    "Controller".
> > 2. Some devices can operate in Controller (Master) or Target mode, thus
> >    the name is not accurate in such cases.
> > 3. Other buses, like I2C controllers, use simple "i2c".
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> 
> Rob, can you pick this one up? It seems Alexandre did not take it.
> 

I'll take it but I don't think it is super urgent.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

