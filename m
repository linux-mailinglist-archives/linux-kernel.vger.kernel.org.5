Return-Path: <linux-kernel+bounces-49476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C390A846ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784121F2797D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E85182DD;
	Fri,  2 Feb 2024 08:36:44 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED5182BE;
	Fri,  2 Feb 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863004; cv=none; b=la+LJPXnI/QPGQfXzqT0wNx4F/OJoHjUEnkJ7SmfwnMa5BjBjAJ+lgew8Z+F7sF73ev7MoMK6JNiPAdWhpgw+uWcyhyTy3kgvtrGsgADrKgIdPhTYfxwViHkirehIyDaB8HAlkGvYeG0lgGElLNup1x8aI79Msq1q10ZbdF3v9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863004; c=relaxed/simple;
	bh=eolS9kucw4GS7qQgXMbsHb/gx9RBQSE7IndU+OJ5npg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmUaUKJbChG4TZueqfN0Di1IheY6nqWqHr1PBbcTLMFt2J4MQVrsVakSJwn15/fcIj96vEesmmwfo/V6gIZUPQUFyA6dsEJUe0EpJkoBkOBeeRZ4SZe2OjF+pOa29LFrvueaSVIsTNdns9AFv94si5b0pCmHZgzcUoArfwo+kTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVp22-0090Dp-VU; Fri, 02 Feb 2024 16:36:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Feb 2024 16:36:32 +0800
Date: Fri, 2 Feb 2024 16:36:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: JiaJie Ho <jiajie.ho@starfivetech.com>
Cc: "'David S . Miller'" <davem@davemloft.net>,
	'Rob Herring' <robh+dt@kernel.org>,
	'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
	'Conor Dooley' <conor+dt@kernel.org>,
	"'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
	"'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Message-ID: <ZbypkC/y1einkKmw@gondor.apana.org.au>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
 <20240116090135.75737-5-jiajie.ho@starfivetech.com>
 <ZbNCKrTLXmPcsrSH@gondor.apana.org.au>
 <BJSPR01MB0659C3FE1262DF8CC7F7DA468A43A@BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn>
 <Zbsu39gZn2cGrnew@gondor.apana.org.au>
 <SHXPR01MB0670720DD9EAB09EE8A1B13E8A43A@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>
 <Zbs1xy4DesZDkFC4@gondor.apana.org.au>
 <SHXPR01MB067059F064CD56ED58DE6F9A8A43A@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SHXPR01MB067059F064CD56ED58DE6F9A8A43A@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>

On Thu, Feb 01, 2024 at 06:40:09AM +0000, JiaJie Ho wrote:
>
> The object files defining these functions aren't included for CRYPTO_DEV_JH7110 in the Makefile.
> obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
> jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o
> 
> obj-$(CONFIG_CRYPTO_DEV_JH8100) += jh8100-crypto.o
> jh8100-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o jh8100-sm4.o

What happens if someone enables/loads both drivers? If you want
to share code then that needs to be split out into a third module.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

