Return-Path: <linux-kernel+bounces-86087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F6E86BF68
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980F3B22CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C63374EB;
	Thu, 29 Feb 2024 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fRNXX3Iz"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5A2030B;
	Thu, 29 Feb 2024 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176923; cv=none; b=IcwBjjAu3J7VGCnuEfTXlxf02//Pg6Jm2CSDx1UjXPPmL3xVkh7sgMY/m0sL5a6zzNO99ZTILYsV19ro1pWEZ0iE+cMprVhNDnAPNOoTWGPB4VcPYMmWmx/IMZY2Uv0coBaymhmd+26piRqnYH1asaVw9S1W+tcUZKp9qgM8owE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176923; c=relaxed/simple;
	bh=LPgGynQ+A1/bnYxF+wO/SXRI5kLXQ3Qw06TO0sy0C24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfeW0KKdnz3pJtUVF4iwuQIi1XySDVNYXjRBIIE+yGkZevDJ7VE143ybexBA0w0k0HyndizdApRENNYfe+Y7s9EXO5+g2ZmzJHbBEfcoyY2dZVpw5RLy8QOm3hqAIlu8pt3cZxr4g/Lq59VYJeo2/06dMLDLUs+c9dHiTbZXJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fRNXX3Iz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-70-176.adl-apt-pir-bras31.tpg.internode.on.net [14.2.70.176])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 854162003C;
	Thu, 29 Feb 2024 11:21:48 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1709176912;
	bh=RLcNqeFFO91l5U2c2IKNxo911MnrtAjB3bSLnMByv8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fRNXX3IzTcEDeyZE4x/DP7vMGGIc5cp7BOkn7QL+57i48ck+9kkXj2c+UWUD9JxVX
	 2EqFfWfksv4DLEqx48mVIcMgcys42fwv2FaWdBCdNGi9nyArnwCtBtvzDf7jUk5DR3
	 /anASWfpRpAMG2muKIHLK/ZBzNlMpeM+0B9HZOepx0wgXeMYRdEj3m909jz4J63VTS
	 aWztF4wAso9Qg9NuRqiVWWMiVr4GAYD35xnEa9cWmTkWE+vP5zCHwCiMvvsDAnUEjx
	 hNZziqdSqQmtRsAZSeWSJSyWL5OIjPElh1aFlTOotSSxurW0x8g8Ryg1PYBbwVKuzz
	 QNybC8fjN4CcA==
Message-ID: <16ddd99007176da3f84462de217cb76c8fa4e1bd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linus.walleij@linaro.org, brgl@bgdev.pl, krzysztof.kozlowski+dt@linaro.org
Cc: robh+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 29 Feb 2024 13:51:45 +1030
In-Reply-To: <c2060450-4b76-4740-afe4-d14717245f01@linaro.org>
References: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
	 <c2060450-4b76-4740-afe4-d14717245f01@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 08:47 +0100, Krzysztof Kozlowski wrote:
> On 28/02/2024 01:30, Andrew Jeffery wrote:
> > Squash warnings such as:
> >=20
> > ```
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e=
600000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,=
ast2400-gpio']
> > ```
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > v6: Address more constraint feedback from Krzysztof:
> >     https://lore.kernel.org/all/f69ef2ad-8ace-40c8-b923-4dde20eda2ec@li=
naro.org/
>=20
> You still have way too many examples. One is enough, two is still okay.
> We really do not want more of examples with minor differences.

Noted, I'll keep them to a minimum in the future.

>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for the feedback.

Andrew


