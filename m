Return-Path: <linux-kernel+bounces-39892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF5E83D732
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272CA29C1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F870629F4;
	Fri, 26 Jan 2024 09:09:30 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75495612D3;
	Fri, 26 Jan 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260170; cv=none; b=gKBPSULut4QoE1dnZd8vF5SRCE3KKOP90m+Nuyf32nHmysiFK09fH8YJkOv0tVf/ibuVwtybE8Qy5VdsklMsXv0fYxiW8Jg/LQzdyrHJIvUU8xBAhRcSQSafKudrKZZ32J/46MydwvxZvzdEQrYnb06oZrkQjC/M0daL6vRUIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260170; c=relaxed/simple;
	bh=F1hz7KCSVbFLfrCBmACnmf9Nqw8PEapG5/S7HX7OJtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVg29gsCmuRopBi5RCbQGQ/sbGZ5Tl8+4yz1eQFO0gLs/SkEJu43ymCMMTUM43VcCvEznOaVg4faHUpGnjE0vch5O9MDLHZvZIXU2BNWLKi9XZviHTkPiF//mvFJxX8zBfPwpBDRU2yvd+FBXJjH6xO6wEng4PpjYFUMpSpd8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTID0-006Ez2-Vh; Fri, 26 Jan 2024 17:09:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:09:23 +0800
Date: Fri, 26 Jan 2024 17:09:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Wronek <davidwronek@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: crypto: ice: Document SC7180 inline
 crypto engine
Message-ID: <ZbN2wwvM8D4yldjS@gondor.apana.org.au>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
 <20240121-sm7125-upstream-v4-1-f7d1212c8ebb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121-sm7125-upstream-v4-1-f7d1212c8ebb@gmail.com>

On Sun, Jan 21, 2024 at 05:57:41PM +0100, David Wronek wrote:
> Document the compatible used for the inline crypto engine found on
> SC7180.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>  Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

