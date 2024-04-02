Return-Path: <linux-kernel+bounces-127954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E7989534D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279FF1F234D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D947F7EB;
	Tue,  2 Apr 2024 12:38:24 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3F60BB7;
	Tue,  2 Apr 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061504; cv=none; b=BqMMwSTwXWMVKeBYl9/+Lm8Gpqu/FSnCiEbm4K69gG5jur+54iiPt2fnvPtfx1SneaoTd2V4ZXnJib1mTqKQ68ESHaMSKHm/ouG8NrI6wMLaOPAaKZIBjyzwDEWzjkCysR2zfbSnI2FdY4jEKlbtaGiUQywcgspdRxAKy51y5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061504; c=relaxed/simple;
	bh=boRRZlpZak68PYABIUG6OvIfNGXFu1bXko+mpxmmDnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYXEaxUy6p3RKX7b523xmVCEpKbxi3zNH9SJa3pnT13XR05lsCdmjg48PEL3fM7efvbzJj7pdQg5tm9DbhQDwylxmf4yQ83QT9s7+c0Llej5pRM/LOtzoWwyKRutOUmQJgRfCjeoE84SW4wL4J/mZkE7XCgunCkRE6RtiOuV4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rrdOi-00E5xQ-MJ; Tue, 02 Apr 2024 20:37:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Apr 2024 20:38:09 +0800
Date: Tue, 2 Apr 2024 20:38:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <Zgv8MYZuMpVjeRFg@gondor.apana.org.au>
References: <20240319082306.34716-1-akhilrajeev@nvidia.com>
 <20240319082306.34716-4-akhilrajeev@nvidia.com>
 <ZgVCxnI0sZcE04io@gondor.apana.org.au>
 <SJ1PR12MB63394D2C8C5329DE4B9B937FC03E2@SJ1PR12MB6339.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR12MB63394D2C8C5329DE4B9B937FC03E2@SJ1PR12MB6339.namprd12.prod.outlook.com>

On Tue, Apr 02, 2024 at 12:36:41PM +0000, Akhil R wrote:
>
> Should I set the reqsize as below in sha_cra_init()? Seeing this in other crypto drivers.
> 
>         crypto_ahash_set_reqsize(ahash_tfm,
>                         sizeof(struct tegra_sha_reqctx) +
>                         crypto_ahash_reqsize(ctx->fallback_tfm));

Yes if you places the fallback request at the end of reqctx then
this is the correct reqsize.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

