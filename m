Return-Path: <linux-kernel+bounces-45379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58B842F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4545B236AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E0A7D402;
	Tue, 30 Jan 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdEo/pFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF67D406;
	Tue, 30 Jan 2024 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653070; cv=none; b=NkFCH6MiMjz9CLN/wE6JnuGefItjJLEcHdutO7kP4ne7inwVfKdxrX1DA5hqMeSY21lPPEqTGYnSvQz5hbPdYXfERsqQuH1rEw2hgyFIETxtZLHv0nHEmi0UaXCyoQKDfPAJR/Hk1qy7nB+Dr96jY4ON/31m5/SmZvVEgIjiPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653070; c=relaxed/simple;
	bh=O4fXDnLnUAaa/RdBv6EbHu0KGbuvVOeIH7UneTfQU7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaQxxaH0qPyoi6pE6g6nUHYcptPA+lbxQl02JlB6ClRdWPv6tC+5itTmQmSAuxUQav4xXC+ztfxYp/9fs3sPH84mwS/RCq/Z9Qd/2nRuOGkudmme7fge3JSU621rx0vemqXkWijAFFyz5V9kXLpMfSYeTls365cyNLPl47HXdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdEo/pFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82389C43390;
	Tue, 30 Jan 2024 22:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706653070;
	bh=O4fXDnLnUAaa/RdBv6EbHu0KGbuvVOeIH7UneTfQU7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdEo/pFDUusB9x+ZODME3BoYG1R4MGowmocf34l7WvMQnTqW8ZncTtfi9FUr+LrQL
	 PYv7nzIQzRCrogdkqS8mWgKLXQbLUMNoeMAbdX6md2LhSByzuB9F6sJ8vKGJp4Bq8B
	 uxPSYlphk0UISAaVyxylgmtzFQTO585OCTS+QyM5HJNwbjlAUnfCBWbaTVDx3kvF0f
	 3rFFGFJWN6BghKfmxSQ+k+bpuZgEZ0JtIh8Ka2Rnjwrm1JTCDZzeWTXhar9B/TYm7x
	 pBh5VSQGO/XD5gEZ/qzI+Mcc6XEM2s3Ud20IwfL1T4eqVo8aURVwFoDY3OQiN3+7UB
	 h5e7hgo1FZYew==
Date: Tue, 30 Jan 2024 16:17:46 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Tao Zhang <quic_taozha@quicinc.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: coresight: Remove pattern match
 of ETE node name
Message-ID: <px3fj5e4mk3siruehhmazxnxbrleetdpb2slt64agtvbcqhts2@gmrtdonybmzd>
References: <20240119092500.7154-1-quic_jinlmao@quicinc.com>
 <20240119092500.7154-2-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119092500.7154-2-quic_jinlmao@quicinc.com>

On Fri, Jan 19, 2024 at 01:24:57AM -0800, Mao Jinlong wrote:
> Remove pattern match of ETE node name. Use ete as the name for ete nodes.
> 

Not saying that you're wrong, but...why?

Regards,
Bjorn

> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/arm,embedded-trace-extension.yaml          | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> index f725e6940993..a10a570bd9bc 100644
> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> @@ -22,8 +22,6 @@ description: |
>    with any optional connection graph as per the coresight bindings.
>  
>  properties:
> -  $nodename:
> -    pattern: "^ete([0-9a-f]+)$"
>    compatible:
>      items:
>        - const: arm,embedded-trace-extension
> @@ -55,13 +53,13 @@ examples:
>  
>  # An ETE node without legacy CoreSight connections
>    - |
> -    ete0 {
> +    ete {
>        compatible = "arm,embedded-trace-extension";
>        cpu = <&cpu_0>;
>      };
>  # An ETE node with legacy CoreSight connections
>    - |
> -   ete1 {
> +   ete {
>        compatible = "arm,embedded-trace-extension";
>        cpu = <&cpu_1>;
>  
> -- 
> 2.41.0
> 

