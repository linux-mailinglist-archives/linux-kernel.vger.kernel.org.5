Return-Path: <linux-kernel+bounces-67145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B38A8566FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEDD1C221AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD9132C1C;
	Thu, 15 Feb 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY+8zwEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8B132487;
	Thu, 15 Feb 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010067; cv=none; b=n5Mc9IBV1BhDxhFaiZAoME8xtxzvQq8Q97M6c8CKNDOE3HzWpT1a4dHbdB/gnoTXMycLBVkhaDtO2O9Lz+f8M2fArdaYrspj3jWCmcYycIlbFfiA/VE0R+zwgsxZytK1wpNz4Wqsy/LdRg8o04XxSxFBCNQD8fRIPawd2UwU4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010067; c=relaxed/simple;
	bh=I1sWwOkQgziEC2+uZ8Soe1wI9+LGEmMcSQQ/8gmPUjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjUJ6b1p1nXmWo8i2iwTJhoD4FUCsg2W5NICXo/FPWq+SiR9tuLleXvMirCQVysCn++aMDGF8X5dBT9IItgFqkq5ZKKqhuYeuyZZtQqjaefCstuaKwS1Ibt2VUJCToKMRDN3bvPpgAIffiwdu7Nhx3euD+nDc51tQwLnE9QG8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY+8zwEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E353C433F1;
	Thu, 15 Feb 2024 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708010066;
	bh=I1sWwOkQgziEC2+uZ8Soe1wI9+LGEmMcSQQ/8gmPUjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY+8zwEiAeB5gYbYqxlq1q5tZFRECxOJsnIN3ejg/Lfvz7eF78CXwhp49Vuj8J/P0
	 HrLhYF8Ku4vt0PrRRgAFdXNR7h2gox51Jcje11HUhGE34N31qa2yGSi22hTl1mKJ5q
	 1s5YagR0tH75BmgG2ibM1DiU3d+YOkQGYnfmereWHzTxLdn4C1tQCH+JTjTWtdBPvf
	 vYjZfvNsU8Q75EF0HmNAaNcwAoU4xKoSxWjB9vMmJsSSJUNaCBbKLMcrHk/CtnCSfA
	 et2HFdvcUgJSPPI0X7vAWBCf12PVRgaiK2Eole2rGr1suKmEemQjyTC5p4MD+SJVNs
	 cvngEB7o6lT2Q==
Date: Thu, 15 Feb 2024 09:14:19 -0600
From: Rob Herring <robh@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	devicetree@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: humidity: hdc3020: add
 interrupt bindings in example
Message-ID: <170801005495.117936.14865503171344450311.robh@kernel.org>
References: <20240214085350.19382-1-dima.fedrau@gmail.com>
 <20240214085350.19382-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214085350.19382-3-dima.fedrau@gmail.com>


On Wed, 14 Feb 2024 09:53:44 +0100, Dimitri Fedrau wrote:
> Add interrupt bindings in example.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


