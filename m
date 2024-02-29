Return-Path: <linux-kernel+bounces-86469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB686C5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CCE1C225BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B09626C6;
	Thu, 29 Feb 2024 09:45:00 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570562167;
	Thu, 29 Feb 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199900; cv=none; b=tMEYNOMPKRaHaENYX2tmXcX2OJcvEzMryMI9z39TqI3X7sOfqHH6bMCFDsJQsliBDuMNFm0tLIFM742BrHuY+O8yC9d5sm4SolfZUcRUcOitaLLdJWvO1eRTS2ZvZwUYEgbQiU0hF+AL7X73U5bYAxKx1zLTnqS2HM4fskXulyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199900; c=relaxed/simple;
	bh=LRJVFzBwH7MuVtq2csaTPRAM3cjLsMOfo43jLit+25Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfqUW0oJAvGh5vomtFDJo+i9PTMXLGAIW5HflM4LMD9JQxIXBKC9gbzhQGhqg8b3UXikl/rRsoqKiit+RGBfkRD0g6ZWxQHTAlZC9d/srR9coKPFcfg7zwVHVEJpjHJjcqFlbTVJhoevmARrxsfV4mXxQ0E7xCWjDgsVZR8XMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rfcxv-001mAd-8M; Thu, 29 Feb 2024 17:44:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Feb 2024 17:44:50 +0800
Date: Thu, 29 Feb 2024 17:44:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>
Subject: Re: [PATCH v5 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <ZeBSEviAw/JVpICl@gondor.apana.org.au>
References: <20240219172530.20517-1-akhilrajeev@nvidia.com>
 <20240219172530.20517-4-akhilrajeev@nvidia.com>
 <SJ1PR12MB63392983F30CA57CBCB69B93C05F2@SJ1PR12MB6339.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR12MB63392983F30CA57CBCB69B93C05F2@SJ1PR12MB6339.namprd12.prod.outlook.com>

On Thu, Feb 29, 2024 at 09:20:48AM +0000, Akhil R wrote:
>
> Do we have any other concerns with the driver currently, which I can address
> in the next revision?

The sha export/import code looks good now.  Does it pass all the
self-tests, including extra fuzzing?

The same export/import issue still exists with cmac so please fix
that.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

