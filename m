Return-Path: <linux-kernel+bounces-122796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA388FD7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A763B21F50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207D7E572;
	Thu, 28 Mar 2024 10:54:12 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155707E112;
	Thu, 28 Mar 2024 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623252; cv=none; b=j8HME11YBQA4cGDYSkYDywh6uUBvR/mr8oE7rRpkKt+Vz3p+f8gGMxJhLZC1OZAT6J+goTcGS9UdfNf6ZDp7eVsc8JnhzZ8sVfaKgppzmB/W1t+6JloDZWCXIC+rOhUHsEASSF8M5PSMXpc59Cn8bEknnQMKCpJtJqSOq67EbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623252; c=relaxed/simple;
	bh=waBJhRTALbA9npM49eqspenD5qwK6bVmYXSu2TkIC24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2PvnP5jKplIjPffGTePFyq5BNQIe0eKGBgIok1J4U2Wt05ebK9z9jYRkBYk9KYV9SvlHtP31HuGFjgvjv3WseNHe77pYjUh542dJRrWt1lgAt8mUJ/5uKTaLjRt2DOIj2j3MPCvR+lSu7NQz+Oq89RnT5mxOanMYXcD9Bo9OuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnOO-00C8PI-Bt; Thu, 28 Mar 2024 18:53:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:54:12 +0800
Date: Thu, 28 Mar 2024 18:54:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: crypto: ice: Document sc7280 inline
 crypto engine
Message-ID: <ZgVMVFCXe3Itw6TL@gondor.apana.org.au>
References: <20240313-sc7280-ice-v1-0-3fa089fb7a27@fairphone.com>
 <20240313-sc7280-ice-v1-1-3fa089fb7a27@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313-sc7280-ice-v1-1-3fa089fb7a27@fairphone.com>

On Wed, Mar 13, 2024 at 01:53:14PM +0100, Luca Weiss wrote:
> Document the compatible used for the inline crypto engine found on
> SC7280.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

