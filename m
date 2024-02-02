Return-Path: <linux-kernel+bounces-50487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59C8479C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D899F1F24D72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF8315E5C8;
	Fri,  2 Feb 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovi+0ekJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046E15E5D8;
	Fri,  2 Feb 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902691; cv=none; b=PIr1JrFHq6opl77RcLlrskmFl7z0zHB94S8+NTN7oh9e4akS9bjd0m7yTfxHL/ZtxM7OfOYMSczNHxWSWt00QIaNW7BUcq/ka1kYDH9fa8ffWBYMd1l4Iw/vUYkh4TPLNgyMQNWeyrI8miBkFK4+xrJJlwOCAyT0BqQQr2E9HCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902691; c=relaxed/simple;
	bh=cXSewaIhyGydS5Gw01kUhO+TK9P0kL9oR3wsJgkpSXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2+cUy4K12Ry734F4Kqv6SgyGf6pjLe86z8/VXXi9TBps6mBqYYp3HX9Dxz0hk4UMCdLzX1pqDWFd9XnvE2SV/eFZNBRvQuFXffJ7G/bJ8ISo847rG0PgoeDHYCBhX5lBYa+lbZa+98QQWQPKg8Qpx3erxH5bLhX21P7qaUaESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovi+0ekJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B896C433C7;
	Fri,  2 Feb 2024 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706902690;
	bh=cXSewaIhyGydS5Gw01kUhO+TK9P0kL9oR3wsJgkpSXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovi+0ekJPZurgLg8k360G3rdBWysmMIochoK+bC4Dcn43HvlSf4ueyyed1iL/BIKp
	 pxEKuGpZMJgyE5VB2iyakVKzVkI2z27TLziSvsZ4MBVpP8XEWYFAY5S0rSaNa7I0UG
	 SKlElFrz4Z9VulT1xnl556sxrDbnc+j8TwwhaKH4uSReLWdLMGT2fi1fd8C7dP5jrO
	 rM+V/ev1Bil/ScnFXez9obyL29t300jIRIfkQUgX4ZB9faRUULT7KshaFJKNwYCoHV
	 JObzf2YabL/I7Jf8mWG8M//XHvb2ipLKSxgKCp88Y6Q7G7+p85bTJwyv93zIvOThvZ
	 bwDBvEtB+tMRg==
Date: Fri, 2 Feb 2024 13:38:08 -0600
From: Rob Herring <robh@kernel.org>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-msm@vger.kernel.org,
	Tingwei Zhang <quic_tingweiz@quicinc.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: Add device-name in the
 coresight components
Message-ID: <20240202193808.GA581322-robh@kernel.org>
References: <20240131082628.6288-1-quic_jinlmao@quicinc.com>
 <20240131082628.6288-3-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131082628.6288-3-quic_jinlmao@quicinc.com>

On Wed, Jan 31, 2024 at 12:26:26AM -0800, Mao Jinlong wrote:
> Current name of coresight component's folder consists of prefix of
> the device and the id in the device list. When run 'ls' command,
> we can get the register address of the device. Take CTI for example,
> if we want to set the config for modem CTI, but we can't know which
> CTI is modem CTI from all current information.
> 
> cti_sys0 -> ../../../devices/platform/soc@0/138f0000.cti/cti_sys0
> cti_sys1 -> ../../../devices/platform/soc@0/13900000.cti/cti_sys1
> 
> Add device-name in device tree which can provide a better description
> of the coresight device. It can provide the info like the system or
> HW it belongs to.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../devicetree/bindings/arm/arm,coresight-catu.yaml         | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-cpu-debug.yaml    | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-cti.yaml          | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-dummy-sink.yaml   | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml | 6 ++++++
>  .../bindings/arm/arm,coresight-dynamic-funnel.yaml          | 6 ++++++
>  .../bindings/arm/arm,coresight-dynamic-replicator.yaml      | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-etb10.yaml        | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-etm.yaml          | 6 ++++++
>  .../bindings/arm/arm,coresight-static-funnel.yaml           | 6 ++++++
>  .../bindings/arm/arm,coresight-static-replicator.yaml       | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-stm.yaml          | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-tmc.yaml          | 6 ++++++
>  .../devicetree/bindings/arm/arm,coresight-tpiu.yaml         | 6 ++++++
>  .../devicetree/bindings/arm/qcom,coresight-tpda.yaml        | 6 ++++++
>  .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml        | 6 ++++++

Why do you need a name on everything? Funnels and replicators, for 
example, aren't a source of data, but just connected to things that are. 
ETM is tightly coupled to a CPU and you have a link to it. You have 
graph links to show connections. Limit this to where you actually need 
it. 

>  16 files changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> index 2bae06eed693..a4d20aad0c70 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> @@ -44,6 +44,12 @@ properties:
>        - const: arm,coresight-catu
>        - const: arm,primecell
>  
> +  device-name:

This is too generic of a name. Make is something closer to how it is 
used or what it is for. Naming sysfs devices is not how it is used. 
That's just an intermediate step.

> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Define the name which can describe what kind of HW or system the
> +      device is for.
> +
>    reg:
>      maxItems: 1
>  
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
> index 0a6bc03ebe00..6094cc9cb834 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
> @@ -39,6 +39,12 @@ properties:
>        - const: arm,coresight-cpu-debug
>        - const: arm,primecell
>  
> +  device-name:
> +    $ref: /schemas/types.yaml#/definitions/string

If you are redefining the type multiple times, there's a problem in the 
structure of the schemas. Really, that's true for anything duplicated in 
the kernel.

Rob

