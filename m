Return-Path: <linux-kernel+bounces-54361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0734284AE36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED261F21A59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287027F7C8;
	Tue,  6 Feb 2024 05:54:46 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26577F15;
	Tue,  6 Feb 2024 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198885; cv=none; b=JFu+sVI19HDcuQl6Le/HuGdD1OHDpvPyXq6qJ0yv3duiYCtFgLDM1aWvz3B3rjtCt1c/xNLSjtjjRUvwjhvcDcm/hwUHDfQ1i+PQzRmDTyvEy/0r7q7jjQdGuZFuTyKEmeodNkLuKkyPSjcOLC2FYT+5CnfyP7W+LlH8NRM2oZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198885; c=relaxed/simple;
	bh=AUWGDDqIJo66bx4O8tOlxc7GdJKJ1cazxnGTGYtiGr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uookoIDEuySShmdSOiodqLFgiQXfwxZlUhn1egdPu4i1g4PiJ2ZqSJq55IoC3Pp1NjCoSjNsgVTrhWgtPUkLfmmgwi7cNcm8ymdYdDIaiNUvtT7GmSj/pCF3GIRJoF21mcCMYjUk0Kq8OPy+zqIoO9aGQKPjFbxfMIML0DKgRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rXEPb-00ASzF-Fz; Tue, 06 Feb 2024 13:54:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Feb 2024 13:54:40 +0800
Date: Tue, 6 Feb 2024 13:54:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>
Subject: Re: [PATCH v4 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <ZcHJoJxe+2gsfIaT@gondor.apana.org.au>
References: <20240124083846.46487-1-akhilrajeev@nvidia.com>
 <20240124083846.46487-4-akhilrajeev@nvidia.com>
 <Zby5bLEgz/UktarE@gondor.apana.org.au>
 <SJ1PR12MB6339E195387767AC3BE74F0EC0462@SJ1PR12MB6339.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR12MB6339E195387767AC3BE74F0EC0462@SJ1PR12MB6339.namprd12.prod.outlook.com>

On Tue, Feb 06, 2024 at 05:50:33AM +0000, Akhil R wrote:
>
> Understood the issue. But I feel it will be a bit overburden for the update()
> to copy/paste these for every call. Let me explore more on the hardware and
> come back with a better approach.

Of course it's a burden to copy it in and out on every update,
that is why we generally use digest and finup instead of update.

As a driver you don't need to worry about this cost.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

