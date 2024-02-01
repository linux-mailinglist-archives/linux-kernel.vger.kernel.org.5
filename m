Return-Path: <linux-kernel+bounces-47686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF30845140
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46ADC1F2B274
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B94585C69;
	Thu,  1 Feb 2024 06:10:20 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD584A20;
	Thu,  1 Feb 2024 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767819; cv=none; b=J8EZijAD9lnO6Zob6c8LgPXaWHNLMto6YBXy+tWhGY/T6qV5R3htQ/H85XNsONQ5ywwYJ0TztfdFQFk9a1dh9R2ZmqDsPgdxyAlG6M8bydV2UPeFKhk8ES4pxSng3Ozbs3VcyegrBHub1HyMa0Tpv6Is9eQ2eQRzt7jcb+5GSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767819; c=relaxed/simple;
	bh=JCwgUM7Lkx9hM5PB0H/+JSoypP5rQNgl3EZ1IP1uZdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGA638wDyU1SkZTJ8fYxFnli9U6Bowq79ORbitkZFsJHgCyceBLSsq2FptHUcrA15yCxAvhV/CjwHoZLFQZLsgQ+Cp46Yb9QADDK9VneXU+G68qNQ8vhraOrQgViqrtdpN2+ABXBbRrva5YBYxVak15pKOzz8V1lFElKy7WT9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVQGw-008Uwg-Os; Thu, 01 Feb 2024 14:10:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 Feb 2024 14:10:15 +0800
Date: Thu, 1 Feb 2024 14:10:15 +0800
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
Message-ID: <Zbs1xy4DesZDkFC4@gondor.apana.org.au>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
 <20240116090135.75737-5-jiajie.ho@starfivetech.com>
 <ZbNCKrTLXmPcsrSH@gondor.apana.org.au>
 <BJSPR01MB0659C3FE1262DF8CC7F7DA468A43A@BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn>
 <Zbsu39gZn2cGrnew@gondor.apana.org.au>
 <SHXPR01MB0670720DD9EAB09EE8A1B13E8A43A@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SHXPR01MB0670720DD9EAB09EE8A1B13E8A43A@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>

On Thu, Feb 01, 2024 at 05:59:01AM +0000, JiaJie Ho wrote:
.
> Currently, the object files defining new algo register/unregister functions weren't included in Makefile for unsupported device.
> Compiler will still check for these definitions if IS_ENABLED is used instead of ifdef causing build errors.

Please point me to specific examples of something that's included
in the output and shouldn't be.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

