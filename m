Return-Path: <linux-kernel+bounces-27762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945D82F57A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9E61C23AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DB31D520;
	Tue, 16 Jan 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0di1nzs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF531D52D;
	Tue, 16 Jan 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433824; cv=none; b=ZKodEfBQSPIXhognmBVhHdnGYMOKj8uwEi63N76uBEFP0jEhIjIX8pI+m29ah/8UbFkY3JJ1pI+w18jmCFyt7TTxvBLiFPmiHoYbyC3k0VGEpuYwlafr8DQ8wTFeRp0N3nrCEIXt4At37Mh2v2h4hkbnfeAyy57zfIsujFGkEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433824; c=relaxed/simple;
	bh=Yqhm26i3ttwzsTuBQPuzExYobWq+0zPxlrgFkTwLhD8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ANeqLJKY2MXcNE9FOGw5g2yDTSJC2t+ahjR8i5RyxZB//lqKxyquakbYOKrg7R8h38+0xsAQsJ5oXLoOf1MgGv6yxQMkB9U13PLTPFt+YYajyrNXaKCx+VPLDRKP+5BiK5UPeGsWgwyI9jXdo5TFoRDxrwzkzKPm/4Eo4JFT5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0di1nzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961F9C433F1;
	Tue, 16 Jan 2024 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433823;
	bh=Yqhm26i3ttwzsTuBQPuzExYobWq+0zPxlrgFkTwLhD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0di1nzspkf5zkxcuyMcBuF1jlJO/YeSBoFm106PmraSymsKFeJ8cWwBQiEjc94cr
	 xVEm4k/F6gAPJD01Z7C979z+P3vEZ6z1QW0buB95KdQNZ76wSROUmSKiPUJk6YMQu4
	 ejN0xOaPEcoqmXUWw9fJikrutJySDIn1volektWZMWtpd9CgZtAIv32pdWJHqDYpcI
	 juhk6xgGl59/TVSMNNOmAoCPldQYQgO0EbUpVp3B04Y2K4hcTLkeEBcN0bRBBkANwP
	 1NsY7jSDqI0Z1t102lHnLLCwKY/0a7SzLM7umi6CxYn6Zh23O4no0lABUCE9q3yNXb
	 HBq1o76rlX3SA==
Date: Tue, 16 Jan 2024 13:37:01 -0600
From: Rob Herring <robh@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: rockchip: Add rk809 support for rk817
 audio codec
Message-ID: <20240116193701.GA286794-robh@kernel.org>
References: <20240116084618.3112410-1-tim@feathertop.org>
 <20240116084618.3112410-2-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116084618.3112410-2-tim@feathertop.org>

On Tue, Jan 16, 2024 at 07:46:16PM +1100, Tim Lunn wrote:
> Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
> using the same rk817_codec driver. However it is missing from the
> bindings.
> 
> Update dt-binding documentation for rk809 to include the audio codec
> properties. This fixes the following warning from dtb check:
> 
> pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
>    'clock-names', 'clocks', 'codec' do not match any of the regexes:
>    'pinctrl-[0-9]+'
> 
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> ---
> 
>  .../bindings/mfd/rockchip,rk809.yaml          | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> index 839c0521f1e5..bac2e751e2f2 100644
> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> @@ -12,7 +12,7 @@ maintainers:
>  
>  description: |
>    Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
> -  that includes regulators, an RTC, and power button.
> +  that includes regulators, an RTC, a power button, and an audio codec.
>  
>  properties:
>    compatible:
> @@ -93,6 +93,34 @@ properties:
>          unevaluatedProperties: false
>      unevaluatedProperties: false
>  
> +  clocks:
> +    description:
> +      The input clock for the audio codec.

How many clocks? (maxItems: 1)

You can drop the description.

> +
> +  clock-names:
> +    description:
> +      The clock name for the codec clock.

Drop.

> +    items:
> +      - const: mclk
> +
> +  '#sound-dai-cells':
> +    description:
> +      Needed for the interpretation of sound dais.

Common property, don't need the description.


> +    const: 0
> +
> +  codec:
> +    description: |
> +      The child node for the codec to hold additional properties. If no
> +      additional properties are required for the codec, this node can be
> +      omitted.

Why do you need a child node here? Just put the 1 property in the parent 
node.

> +    type: object
> +    additionalProperties: false
> +    properties:
> +      rockchip,mic-in-differential:
> +        type: boolean
> +        description:
> +          Describes if the microphone uses differential mode.
> +
>  allOf:
>    - if:
>        properties:
> -- 
> 2.40.1
> 

