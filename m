Return-Path: <linux-kernel+bounces-78406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B9861310
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFC71C2120C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13337C0B7;
	Fri, 23 Feb 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNa4UFnF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311927EF0F;
	Fri, 23 Feb 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695809; cv=none; b=AcraqjkbARxbcue9bwCIKtPep/P8tSgneIvStSM2pkHKKqWDczBh1kNQiPdIHAP/hcYX75YwUaD9tkY5cGLqLA+nJcJboEv/Zbl5mSnNMqGRgydshT3w0EEOkk+oxgu+7sPpohkk4AhyJbFULSgBnv891K9HstFB3tO+Q/ZLezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695809; c=relaxed/simple;
	bh=pSgrbhzYE2cxqddJbCuPtMoPkUisQmEruojDvLw93ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAeZpCwO1WcXz3SWZrpfML42qiuMPVgHW2nqaO6bNLlObEjscz8m4hOdu/sc2h2QqpI1qkL0CqHDaGQWETGwajM2LaHKM2BLq2J+bR+rcV01txVB56lpgmeK7b1f9rVtMGcaFBC1fZ5TWpnRxCFz/OA7sQHuWfUcf0Nj9WDcE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNa4UFnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F49C433F1;
	Fri, 23 Feb 2024 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695808;
	bh=pSgrbhzYE2cxqddJbCuPtMoPkUisQmEruojDvLw93ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNa4UFnF40pNA4TqsoRYAYRpCUaS7oHjiPuJ30ZXDzAo5T3alPLZolU/sAppysKGE
	 b2SMvrWj1GGMlIjqaQwiocQ647afQCJBK9win8Y/KD9B0lZ9raWdfX9rpUH5qLxnnY
	 J8nwSdFwmaRPfOqTlwnKyVSzcdKr6XnLVLnhxttQc2q6ORXiitz/GnoeHM52aOi0N+
	 g6pKC/yZjm/dGql3Z6UAmblAjaVUg4yr8qvnsFvcyu32AsKvkLsQfpZRiQNMFxf0yI
	 TCho5zO+IR4Gfl5gSNoUHue1vnBs9iF01YCEdrllo3DQpRpnOIgt4oZ+3VpBK2eKPb
	 zOYCb+2iXB0RA==
Date: Fri, 23 Feb 2024 06:43:26 -0700
From: Rob Herring <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
	sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, david@mainlining.org, adrian@travitia.xyz,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: clock: qcom,sm7150-gcc: Add missing CX
 power domain
Message-ID: <20240223134326.GA1754133-robh@kernel.org>
References: <20240220165240.154716-1-danila@jiaxyga.com>
 <20240220165240.154716-2-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220165240.154716-2-danila@jiaxyga.com>

On Tue, Feb 20, 2024 at 07:52:33PM +0300, Danila Tikhonov wrote:
> SM7150 GCC expected two power domains - CX and CX_AO. Currently only
> one is supported, so add the missing CX.

This makes no sense. You had 0 and now you have 1 power domain, not 2. 
Where is CX_AO.

> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../devicetree/bindings/clock/qcom,sm7150-gcc.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
> index 0eb76d9d51c4..1360e9d1d6ee 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
> @@ -27,9 +27,15 @@ properties:
>        - description: Board XO Active-Only source
>        - description: Sleep clock source
>  
> +  power-domains:
> +    maxItems: 1
> +    description:
> +      CX power domain.
> +
>  required:
>    - compatible
>    - clocks
> +  - power-domains

Adding new required properties is an ABI break. If that is fine, you 
must say why in the commit message.

>  
>  allOf:
>    - $ref: qcom,gcc.yaml#
> @@ -39,12 +45,14 @@ unevaluatedProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
>      clock-controller@100000 {
>        compatible = "qcom,sm7150-gcc";
>        reg = <0x00100000 0x001f0000>;
>        clocks = <&rpmhcc RPMH_CXO_CLK>,
>                 <&rpmhcc RPMH_CXO_CLK_A>,
>                 <&sleep_clk>;
> +      power-domains = <&rpmhpd RPMHPD_CX>;
>        #clock-cells = <1>;
>        #reset-cells = <1>;
>        #power-domain-cells = <1>;
> -- 
> 2.43.2
> 

