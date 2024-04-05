Return-Path: <linux-kernel+bounces-132593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414DF8996FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727241C21B14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E06140391;
	Fri,  5 Apr 2024 07:51:20 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABF140370;
	Fri,  5 Apr 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303480; cv=none; b=CZwH0AQxH4pCFTt5+T+6R5Q53YW74JMFnxT5R2Gq3kXgMeAG4yX4FnI7+UwAr/jJCGn7VJ6YRYJ7kFe9sjprtB9JsEmLxCZ8Qzq0U3Bk4mGunbykCoxo1Wk5kGchgCYITUA8rYzs1TlLj6fHncc0YVoX3QfI3wuNlcBafnCvnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303480; c=relaxed/simple;
	bh=xn9mKjCSeAVsNJvtOqh/uYd66Nck7ShW38HVNkEoWQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qznJYTcQ/Q0Du1lz9yDd83UuCgvyc7H9y4SPKZAjeV1mlU1QbUBmh0DFwhM1WeplbEEaMq2BVWU1b+euWnGXblQ/92mvuB1YJntyq+oRlnXpEzS4h3v+MsvW5TQfvAnSfEmcTVF8LlXnpru0fic736aSDuP6lRCIUljngA2FJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rseLu-00FU2s-Uq; Fri, 05 Apr 2024 15:51:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 15:51:28 +0800
Date: Fri, 5 Apr 2024 15:51:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: crypto: ti,omap-sham: Convert to dtschema
Message-ID: <Zg+tgFFDkwLvWgLv@gondor.apana.org.au>
References: <20240327054911.43093-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327054911.43093-1-animeshagarwal28@gmail.com>

On Wed, Mar 27, 2024 at 11:19:06AM +0530, Animesh Agarwal wrote:
> Convert the OMAP SoC SHA crypto Module bindings to DT Schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> 
> ---
> Changes in v2:
> - Moved vendor specific property below more common properties.
> ---
>  .../devicetree/bindings/crypto/omap-sham.txt  | 28 ----------
>  .../bindings/crypto/ti,omap-sham.yaml         | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

