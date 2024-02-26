Return-Path: <linux-kernel+bounces-82226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4548680FF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAECB2EB33
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DAC12FB0A;
	Mon, 26 Feb 2024 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TId+25zI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993622069;
	Mon, 26 Feb 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975124; cv=none; b=u4HGWM2k5AOeXwJRp1a6VTk/7wpQCquJklQUM6YJiTCBWdhtlzehuRRI/3QNJzlN/r/XrdciL7egDObqu+eHNGOgKfXGdthqUYIRhxb7II89GquVuJ6TYzCD4zOcvYtnvfb4UOwvDKJk1ZCpKFm3dWHchbtBovDBPTWsghGHEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975124; c=relaxed/simple;
	bh=8tlirjHXa76qqBCdlqXK3IUcUlZOwDUD8SDKrd+Mn2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRTTbsucjVlEZOvBBGMgTM5/Snpzbge67h4+PwruuwjHN/IllCun37V6B04Ntm5egQ+cfYiW3loPonpaRe/jHoKI/sUJ8i+gVPg2hGF7jyo7FLLPGiCOXqARA8PpE8PkYNawbYcGSnYVeHGLDdDaH1pl10ERDL+l9Fz558MDETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TId+25zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B7CC433F1;
	Mon, 26 Feb 2024 19:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975123;
	bh=8tlirjHXa76qqBCdlqXK3IUcUlZOwDUD8SDKrd+Mn2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TId+25zIxWobGCRio9wF0oBCLSJ9PDRK5YPnEgVl0m2rlk0BHefyUMJ9z7T5cAFhR
	 G28C/VJyYI/B7uAQx80BLm2iK6PTxFqfrtGJW50P0U8Htm2kgmLkHMmIAuGvTY/oZ4
	 gkjqL1nX6EN510QjgTCrVItij0c8gRzMpfNhZbpwbpA5negqRFZb4i1ejWEa4LnuuZ
	 b3Qu5EIMSYYq2atajTaJ2XRFkR3kSeIFyym+SFXyHYpixkA044EbsRmE/mnpY7JkDj
	 8rCyWwEye+RuBH1Ph47OIuLpG9GC6OJX9igfALydBZl5fZnDsyQO4wx4+ig6mIxSty
	 ES8/jcAlYqKvQ==
Date: Mon, 26 Feb 2024 19:18:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: drop redundant type from label
Message-ID: <20240226191826.1568a25b@jic23-huawei>
In-Reply-To: <20240226123004.91061-1-krzysztof.kozlowski@linaro.org>
References: <20240226123004.91061-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 13:30:04 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> dtschema defines label as string, so $ref in other bindings is
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied.
Thanks,
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml            | 1 -
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 261601729745..36775f8f71df 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -22,7 +22,6 @@ properties:
>      maxItems: 1
>  
>    label:
> -    $ref: /schemas/types.yaml#/definitions/string
>      description: Unique name to identify which channel this is.
>  
>    bipolar:
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index 40fa0710f1f0..c28db0d635a0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -75,7 +75,6 @@ patternProperties:
>            in the PMIC-specific files in include/dt-bindings/iio/.
>  
>        label:
> -        $ref: /schemas/types.yaml#/definitions/string
>          description: |
>              ADC input of the platform as seen in the schematics.
>              For thermistor inputs connected to generic AMUX or GPIO inputs


