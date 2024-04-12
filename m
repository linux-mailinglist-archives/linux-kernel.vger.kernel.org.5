Return-Path: <linux-kernel+bounces-142228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C98A2935
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBC71F2218F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8334F1F2;
	Fri, 12 Apr 2024 08:22:21 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9F4F1F5;
	Fri, 12 Apr 2024 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910141; cv=none; b=JSV5wJRtOZo46s2FClXCgh4GOzVSI+ysSzScg25WBfjzAqw68rlLrDVQJ5U37iVqqu6QPDQmdbPKl299HvneMMDplF/Jpsg5SKYDfQA7brbfOAnZoS3FKsoQA90nL6oPopTxvDRGyISGUPq7jtBV8rLrUSl0oXc45QzJEHf4zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910141; c=relaxed/simple;
	bh=9KS+FHwnRssF1d7d2Iwik6/+NpzaoXCE4mQMQeIDero=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVicmLwHSc+igMqnsjncRib7y46FA/rRjEKhzYjj029fDIWWLYVd9TFtjMEKUA/SLBAd2ihn6arW3zXb/UU4N3R35r9EXd+YMGnDPSda/NQEaXOh1KSliVO0rkwmDIbRvijwon7CiIGZFGv/KGszTa4rn8CgxPeTQ23Gf15fm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvCAN-000n5W-DN; Fri, 12 Apr 2024 16:21:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 16:22:04 +0800
Date: Fri, 12 Apr 2024 16:22:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"khilman@baylibre.com" <khilman@baylibre.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v7 00/23] Support more Amlogic SoC families in crypto
 driver
Message-ID: <ZhjvLMcMXKNmlCZ7@gondor.apana.org.au>
References: <20240411133832.2896463-1-avromanov@salutedevices.com>
 <ZhiiPVckOYH9dFQ/@gondor.apana.org.au>
 <20240412081931.3s2fw6hds3hh5cwg@cab-wsm-0029881.sigma.sbrf.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412081931.3s2fw6hds3hh5cwg@cab-wsm-0029881.sigma.sbrf.ru>

On Fri, Apr 12, 2024 at 08:19:36AM +0000, Alexey Romanov wrote:
>
> Old Amlogic Soc's for crypto HW used a BLKMV engine, which required
> a clk input and a second interrupt line. New SoC's uses DMA engine
> and don't need this.
> 
> I spoke with vendor, and they confirmed that AXG, G12A, G12B, SM1,
> A1, S4 and GXL is using DMA engine and crypto HW is not connected
> to clk / second interrupt line.

Sorry I'm just asking you to ensure that you've tested the whole
patch-series with CRYPTO_MANAGER_EXTRA_TESTS enabled and there are
no errors reported.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

