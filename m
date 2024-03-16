Return-Path: <linux-kernel+bounces-105073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1D87D8C5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26BD282726
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7535C96;
	Sat, 16 Mar 2024 04:40:30 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392D3FC2;
	Sat, 16 Mar 2024 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710564029; cv=none; b=UcQHxYN5WY/LVWuhGdQ8QTdlkmSra+iFQ9B1bm2IvHFqIlcvO3lAP7KYd9sRK68tt6WWGx5j1wjJ1fuHE8UCgvohb1IuoqLL5ZT3chnTiHr68kRhRnd+XhqsbCoA2ZMv47zyaUZ21nb8ZDAR7eQhWgZD9lIgpHDKl2SEcUDtxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710564029; c=relaxed/simple;
	bh=sQ158lf3+49OyNQlPNO5nC+CUHuz+Q6MIKXittyRchg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5kOV0a2KmhAovlFe4YaZW4yIFkaHg0nw0NnUJI5cT3hzM4t4uoivPTRshc5cZFuTDESjqfE4TTJFZf9GQp6JZJNaLMzzs1wgEYoAumjblzOBuAKoBuY1BKus6ZoZGIP9NVgga3pY5N9OY2FapoeWxQbEszSoH/NUHn+C5h+ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rlLqD-007X3J-S5; Sat, 16 Mar 2024 12:40:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 16 Mar 2024 12:40:33 +0800
Date: Sat, 16 Mar 2024 12:40:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Driver supporting HW decompression and SW decompression
Message-ID: <ZfUiwajCAO5tvW14@gondor.apana.org.au>
References: <20240316002443.GA31904@hu-cgoldswo-sd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316002443.GA31904@hu-cgoldswo-sd.qualcomm.com>

On Fri, Mar 15, 2024 at 05:26:21PM -0700, Chris Goldsworthy wrote:
> Hi There,
> 
> If a compression driver were submitted upstream that used HW LZO decompression
> and SW LZO compression, could it be accepted? It would be geared towards
> decompressing boot images on IOT-type targets with exteremely limited secondary
> storage.

Who is the intended user in the kernel? In general, Crypto API
drivers will be accepted if there is at least one in-kernel user.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

