Return-Path: <linux-kernel+bounces-50598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B190B847B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C98128DFCD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7681745;
	Fri,  2 Feb 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvjzg8v2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2518049;
	Fri,  2 Feb 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908672; cv=none; b=oUvP8UO8r5qhJmdkuNG0kCd+SMHOzUEIsoAAhwKY90owW0ljocQxrAIYRBsCd+QHYaNriqneTashk+JZdY9ne1VeiSro9/8fuWRq7Gf6geBtl88SizbIwMyRwiNOTT8Oa2niDsui4DmO6f8jxPvhkzHFl/b4uy3g/fEFviFNJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908672; c=relaxed/simple;
	bh=/VCh0+HPTFG2lAHl8Ir63vVbaWY0czUg4EndhAmsGSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMJF2dFq6SfyqIbmqDFnncc9ZWvuG/RnyzaJmeuLBXwx2XTX0jXv8aj/qP4bTUEZO2Afj9uYByN3ed/ppxuLEVPZoHNdj45IAdX8oh+oJPWtnBXXXyM/AltjEiBp9Dojuh7BOLL8RCSprx4RCviilOnQJXprme+qYu77GDWHq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvjzg8v2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB59C433F1;
	Fri,  2 Feb 2024 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706908671;
	bh=/VCh0+HPTFG2lAHl8Ir63vVbaWY0czUg4EndhAmsGSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yvjzg8v2QAYg2UYrB+Vbpmh7MiYTumX0/jy0ou8L09dgeEe2AjOeKOVCL38zLtq2B
	 3EnMHuQG6hAXgLSwJmtknf63d9V5i8YDh1rpVTeUYLV61yKuBCTvLG3v29pLYY4rV8
	 1P322vsYsiW3VWtNnWfWTGjTrJMC5ANbMAwJuWvxAlIok42ADCt793YIY9Rkc9FWM1
	 Coy70l89C4Rk6R5vGd1Uae0XVtfzACT+rF9BkzunQi0BL38hPlS2lFsw1sVmTQNW3I
	 lcnCjL5AZ6qLnoamq/rh7NtQ+GQ91Erg9DYlSvDHqRKq0zW9fJoHt5VUEd+3kcWvYl
	 CKI3HeTmiZgZg==
Date: Fri, 2 Feb 2024 15:17:49 -0600
From: Rob Herring <robh@kernel.org>
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, robdclark@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
	quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
	quic_sudaraja@quicinc.com, djakov@kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
Message-ID: <20240202211749.GA1467077-robh@kernel.org>
References: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
 <20240201210529.7728-2-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201210529.7728-2-quic_c_gdjako@quicinc.com>

On Thu, Feb 01, 2024 at 01:05:20PM -0800, Georgi Djakov wrote:
> Add common bindings for the TBUs to describe their properties. The
> TBUs are modelled as child devices of the IOMMU and each of them is
> described with their compatible, reg and stream-id-range properties.
> There could be other implementation specific properties to describe
> any resources like clocks, regulators, power-domains, interconnects
> that would be needed for TBU operation. Such properties will be
> documented in a separate vendor-specific TBU schema.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 14 ++++++++++
>  .../devicetree/bindings/iommu/tbu-common.yaml | 28 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/tbu-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index a4042ae24770..ba3237023b39 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -235,6 +235,20 @@ properties:
>        enabled for any given device.
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
> +  '#address-cells':
> +    enum: [ 1, 2 ]
> +
> +  '#size-cells':
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^tbu@[0-9a-f]+$":
> +    description: TBU child nodes
> +    type: object
> +    $ref: tbu-common.yaml#

       additionalProperties: false


However, that's going to break with the extra QCom properties. In 
json-schema, you can't have 2 schemas and extend the properties of 
their child nodes. The validator doesn't "see" the child node schemas at 
the same time. You are going to have to move QCom SMMU to its own schema 
and remove it from arm,smmu.yaml.

Rob

