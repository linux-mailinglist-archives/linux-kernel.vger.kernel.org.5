Return-Path: <linux-kernel+bounces-123053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BAA890180
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54CC294CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8738129E93;
	Thu, 28 Mar 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hs3RqxMJ"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D887126F19;
	Thu, 28 Mar 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635552; cv=none; b=OhDqPdPmsZmAW2fQnDuSBDrOXF249A0uKgv30+Bi0zZxBoPUSG8zs9sNu7nlZ3NB7r4+4TtJp/SKftGZ5nNhCg+FnBmy/gX+Wml29wiXAINg8hho4xsAegHDmFIoXKp3sJJY+eVu4refBpLLl9n/OwLUOmqrX+TH1115t49bR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635552; c=relaxed/simple;
	bh=nZyYoG1hcN9sZV1x6eeJSQ7WJTnGbfV5shTYRE57f+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P23BBOM+fRKnMOQ/qNdcX4cNPPYbvWO3hettLa8juE+6nMtZcUZdWPLJUbLFuwAuUWxg7f/+c1Id0KIwn5zO3E81+c6dy52kHUQQGHRZPRm2TCdu9sCsP9Gktqgf1bdR+494TsoCWaUZQV3Hq2/L4ajo97zdaVuFoTJgDJrGfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hs3RqxMJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2FBB68818C;
	Thu, 28 Mar 2024 15:19:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711635545;
	bh=SonutgD18/IvJSdqtAfr8jPeMT+pqsEe9jBU5XMTvVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hs3RqxMJQCoEI9woF3jNnqv5D63sMTWJjGzivOtDRxDy2hrbQeSd7eSwq7O6GgRC0
	 xaOgPFJVGNvbkgDPdfPH7WEBN83mQhn2m+ViwPZEZAF5/FwwM7JgCL7wCxACaGR03J
	 l/8aEwaAXPvaaOKTnHuKLpUhAj3b39PsM67Q09qLJW6wsm2NFscYMT6ccD2NVxU/df
	 GJc4OAWnxF5RmGXXjR/VpLiR70+M/hugonzdB3zGJyr3j5r6kB8eACLloha5PyXXEN
	 Up6lSzcfFAMheNlq0c+0vsVsnlL3o/GNGtIiF6xKhO8UrpHIA1DAQmi+00rM8RjCOA
	 evKusuNNo5nNg==
Message-ID: <480d4064-b553-4005-ad98-499a862703ff@denx.de>
Date: Thu, 28 Mar 2024 15:19:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] dt-bindings: net: dwmac: Document STM32 property
 st,ext-phyclk
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240328140803.324141-1-christophe.roullier@foss.st.com>
 <20240328140803.324141-2-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240328140803.324141-2-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/28/24 3:08 PM, Christophe Roullier wrote:

[...]

> | RMII    |    -   |     eth-ck    |      eth-ck        |       n/a        |
> |         |        | st,ext-phyclk | st,eth-ref-clk-sel |                  |
> |         |        |               | or st,ext-phyclk   |                  |
> 
> ---------------------------------------------------------------------------
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index fc8c96b08d7dc..b35eae80ed6ac 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -82,6 +82,13 @@ properties:
>         Should be phandle/offset pair. The phandle to the syscon node which
>         encompases the glue register, and the offset of the control register
>   
> +st,ext-phyclk:

Don't you need two spaces in front of the 'st,' here ?

> +    description:
> +      set this property in RMII mode when you have PHY without crystal 50MHz and want to
> +      select RCC clock instead of ETH_REF_CLK. OR in RGMII mode when you want to select
> +      RCC clock instead of ETH_CLK125.
> +    type: boolean
> +

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

