Return-Path: <linux-kernel+bounces-39864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C783D6EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B82CB2E7AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2A153507;
	Fri, 26 Jan 2024 08:59:18 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362C1534F3;
	Fri, 26 Jan 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259557; cv=none; b=nUpsdBc5Sd9D06245Hv7Cv/pclsYQKG/B1PsqctuG74U9jQS60DVOMwo2ZztKy6NToHFXdRUOy1jwlTMgED/KEVLG1a5XtfE7gHO9uMdis0cGwsaDo2HH3lPWi5oPv+bpCGtrLwvUxulxQALrpFZvpqMfT/PyXL27YRvQMyfdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259557; c=relaxed/simple;
	bh=D8VbU5mjeZe3vkqTBVXQtA/B1a+u/vrIoT2ylxQ8Vn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFzkhtsODpLPDqbtJBeKwFDcFqZkUc/Zttt+OUAJk26xGDlGxeDm+oZZRvOiSLVMHwJoueJa2vDufu9M/w6aVpUsDcRwEN+gNplBsW/MXNR45F2sKqKMsXXRgp3vwof3t83ES8qWlG0zKeZfI68c8tviwBi0tP0GGWpcsKH7oSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI3D-006Eay-LZ; Fri, 26 Jan 2024 16:59:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 16:59:16 +0800
Date: Fri, 26 Jan 2024 16:59:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: qcom-qce: Add compatible for SM6350
Message-ID: <ZbN0ZBggHzdM12BD@gondor.apana.org.au>
References: <20240105-sm6350-qce-v1-0-416e5c7319ac@fairphone.com>
 <20240105-sm6350-qce-v1-1-416e5c7319ac@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105-sm6350-qce-v1-1-416e5c7319ac@fairphone.com>

On Fri, Jan 05, 2024 at 05:15:43PM +0100, Luca Weiss wrote:
> Add a compatible for the crypto block found on the SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

