Return-Path: <linux-kernel+bounces-110103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B602B885A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5526C1F21A05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73184A55;
	Thu, 21 Mar 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kcx9Gsdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2A83CD3;
	Thu, 21 Mar 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028348; cv=none; b=i+cvy5ErVdg2tRzbxArYXDBQMDsq8g24IRPRepdasGx/qSGtAlwkXynPqqiUmUyc93A2moeAatsAM3rizXZTXt0rPBLwyLTObYYRCKbw4nvQgsuNdotFwMZsmahukYz9LuhuY2itlf/r2dzve1oxhv/bD+GFZ4b0HnN1td9nziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028348; c=relaxed/simple;
	bh=CyqSIKd95/3uoReHNnW1elb9HosCTRAVT1Iw5QyGoYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9QrvUdemrnjXgLa5JvVz5eZ4No1AU6NjIfr3JnshlMceywgP1LpXmSoXIod7+yHfjAbcxz8+Lt8vLCNqkG0s8oDXf/7iKwl5pUKm3UE5Zg8tZnPqbo7m7pN17mU3MOZS771QNKBWxgclg4FjzXqfg411l7R25tsdr4Uy6uDx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kcx9Gsdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45B4C433F1;
	Thu, 21 Mar 2024 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711028347;
	bh=CyqSIKd95/3uoReHNnW1elb9HosCTRAVT1Iw5QyGoYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kcx9GsdhjQvQQpYLWFnvdZLS+2ZKFWR6qmN9cHugEVPhYHa3TH1bw9xOWhbQMmnFG
	 RqF+a08SQ/ecPsw08+s4HtSPqF9f7aS5wpynb3GlpMvUM9qhMwRVLZwLSS7y/Lt+eN
	 vZRkHyZ3OjfHODobgA2AfG5SYrv/a2upSZH6I3Hg+Ig8p5FCfol9HVQgiGnOuDnkkE
	 Gk6DJcTIokLICiR2NJfixRatOMZQ1+x7emzlgjVwprfE/HPP9peRzYdJdt1F/T8agr
	 +3W/AL1REGEO2KflIeMTQoJKD/RO7A/TTnDg9I/KcMIuNTIVWblkh4Fvg+6e5AbXmH
	 nCwr/jeQgH/5Q==
Date: Thu, 21 Mar 2024 08:39:05 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: mtd: fixed-partitions: Add alignment
 properties
Message-ID: <20240321133905.GA1622174-robh@kernel.org>
References: <20240320052449.175786-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320052449.175786-1-sjg@chromium.org>

On Wed, Mar 20, 2024 at 06:24:48PM +1300, Simon Glass wrote:
> Add three properties for controlling alignment of partitions, aka
> 'entries' in fixed-partition.
> 
> For now there is no explicit mention of hierarchy, so a 'section' is
> just the 'fixed-partitions' node.
> 
> These new properties are inputs to the Binman packaging process, but are
> also needed if the firmware is repacked, to ensure that alignment
> constraints are not violated. Therefore they are provided as part of
> the schema.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v9:
> - Move binding example to next batch to avoid build error
> 
> Changes in v7:
> - Drop patch 'Add binman compatible'
> - Put the alignment properties into the fixed-partition binding
> 
> Changes in v6:
> - Correct schema-validation errors missed due to older dt-schema
>   (enum fix and reg addition)
> 
> Changes in v5:
> - Add value ranges
> - Consistently mention alignment must be power-of-2
> - Mention that alignment refers to bytes
> 
> Changes in v2:
> - Fix 'a' typo in commit message
> 
>  .../bindings/mtd/partitions/partition.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> index 1ebe9e2347ea..39c7d7672783 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> @@ -57,6 +57,57 @@ properties:
>        user space from
>      type: boolean
>  
> +  align:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1

Shouldn't this and the others be 2?

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

