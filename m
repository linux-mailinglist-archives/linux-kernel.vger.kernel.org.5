Return-Path: <linux-kernel+bounces-105508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BEF87DF7C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392FF1F214C4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E21DDEC;
	Sun, 17 Mar 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi1NLRde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE001CD2D;
	Sun, 17 Mar 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702199; cv=none; b=NKISjVmwptydzPA5b9clSByQ97z0BOXRLTfenC8bxBmOZqGw9DMaCREL+PoWcui/k9xoEGyrcHR5RjYNGEA3oUiMLJnXYGsZepV7XkfW5OdxWSx41St8Var82ZORKk8mXXjlJoe5L1Su7ZYUhYtwQh8nTZ+r+PluC5xefszQErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702199; c=relaxed/simple;
	bh=jxULVwpCUVr9kQOyAisgtABRYa85JCUAZu0zVjCuxi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5Q8eLuJSG5o9zJfoRGPfIlDo4zPY+cFElXkaY2xEUp5xbhZey/spQtQe7WTINaT9vB7WkttJaLU8bYbwIFd8O6mWG7SlN46U49NVL1EdFCtgOVDKUsJB6gzKd47UeVV1XRGq/ecps3x5hBJAh4295PR2jwd0kqLmj6WjIIp0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi1NLRde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF428C433C7;
	Sun, 17 Mar 2024 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710702199;
	bh=jxULVwpCUVr9kQOyAisgtABRYa85JCUAZu0zVjCuxi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xi1NLRdeQz3riPNdP1ZHBPXe07dfHk/rdBMlDxr2BAuWQwtUOT7wvm3iubrbXXRN0
	 3vowVuTwWxL1s7iACpQuBk/vkRcZCT/JJ5Z8c0tC3QPuziteHXLw3/Z8COb++V4GZ6
	 2eyOGxxt+APWQCchtJO/NvGK5HaFgYvHfO0lBLoy0k/h0fGna/hRg7DfRtlUG4KMxh
	 1rZDa2CW6huDD/xp9X1X85VVCwEm1JLvFApN8U15+hRS7536bgd+HACCcW/V9KWZgw
	 u+cyv0lcIr6NEMbrcKFNSdZn6Qi22PoIuJVZ9TF7SQyVWhwOpcVhuQs3cnSvP1x8Fd
	 JSiL782nMVAlg==
Date: Sun, 17 Mar 2024 13:03:16 -0600
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH 11/25] ASoC: dt-bindings: meson: t9015: add support for
 A1 SoC family
Message-ID: <20240317190316.GA2071139-robh@kernel.org>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-12-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314232201.2102178-12-jan.dakinevich@salutedevices.com>

On Fri, Mar 15, 2024 at 02:21:47AM +0300, Jan Dakinevich wrote:
> Add "amlogic,t9015-a1" compatible string.

That's obvious from the diff. Perhaps what does 'a1' mean? What the 
difference from the existing compatible?

> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  Documentation/devicetree/bindings/sound/amlogic,t9015.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
> index 5f5cccdbeb34..ee8bd57dbcf9 100644
> --- a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
> +++ b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
> @@ -21,7 +21,9 @@ properties:
>  
>    compatible:
>      items:
> -      - const: amlogic,t9015
> +      - enum:
> +          - amlogic,t9015
> +          - amlogic,t9015-a1
>  
>    clocks:
>      items:
> -- 
> 2.34.1
> 

