Return-Path: <linux-kernel+bounces-9318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74A81C401
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DAE2882EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AFE9449;
	Fri, 22 Dec 2023 04:35:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DA8F49;
	Fri, 22 Dec 2023 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rGXFu-00DhOu-71; Fri, 22 Dec 2023 12:35:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Dec 2023 12:35:37 +0800
Date: Fri, 22 Dec 2023 12:35:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: Olivia Mackall <olivia@selenic.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] hwrng: starfive: Add support for JH8100
Message-ID: <ZYUSGMJK2ollSFpI@gondor.apana.org.au>
References: <20231212032527.1250617-1-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212032527.1250617-1-jiajie.ho@starfivetech.com>

On Tue, Dec 12, 2023 at 11:25:25AM +0800, Jia Jie Ho wrote:
> This series adds driver support for StarFive JH8100 trng. It also
> updates pm ops of the original driver.
> 
> v1->v2:
> Dropped driver .compatible change, express new compatible string in
> devicetree bindings instead. (Krzysztof)
> 
> Thanks,
> Jia Jie
> 
> Jia Jie Ho (2):
>   dt-bindings: rng: starfive: Add jh8100 compatible string
>   hwrng: starfive - Add runtime pm ops
> 
>  .../devicetree/bindings/rng/starfive,jh7110-trng.yaml     | 6 +++++-
>  drivers/char/hw_random/jh7110-trng.c                      | 8 ++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

