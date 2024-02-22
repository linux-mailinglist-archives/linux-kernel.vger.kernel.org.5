Return-Path: <linux-kernel+bounces-76509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64A85F81B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ECD1F217FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631660BB9;
	Thu, 22 Feb 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dScpg8Iw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E842078;
	Thu, 22 Feb 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604715; cv=none; b=mdwTFEjvMBLs8BFG1MCGdteq2Xrrl74mL7zeteBI/vVyFU8oRNnruuCizHXsCqC7z6xZtrpA66nLMAZ9ge+lwDS6RoxEt4r1LjPr2Q74UYJz46oqj/SzA/Zw79TAD2n/nYQka9bMrUqsBYbN8cLtr+dzsYZBv7wXiHw0hvpyfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604715; c=relaxed/simple;
	bh=69qHeUTOH4zPzO8rZQNYTRNkVJ/vxf11CHJWT0bGgow=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=B5UZ2aU6Blifzkl56NEZMqvbNXZfMWym8J0N3BbIErsPY7AE6NB74KlH/XYVUOpCukn/0uW5JxJ7HeQCl+lmW3FjYHSEfaaWyFkVDrnbbAhXiIRS7vocEC2FEaSZl0ux2RyriJ8myaB/ZmKlUAGzNjAP/iwDZys2IFJ7Jj1erqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dScpg8Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8D5C433C7;
	Thu, 22 Feb 2024 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604714;
	bh=69qHeUTOH4zPzO8rZQNYTRNkVJ/vxf11CHJWT0bGgow=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dScpg8IwFvkPsh9NDss/Hw/60geFbodRVS21pH+glD717mGn7AvrPXO2kBi4EOlGR
	 73Dbn2oU9hroH7sT8bfUTem8R7rdQ6tTEeZkxj6q2f/Pciw85c9lnwp2lVU4Fy9sbO
	 92EtwpkU2L6cOqOm9RHA0T3YjHYTjydco7+XSjAQcvEMpWF3CUWRunr6hG61omhdjN
	 yhjxr0nNMKoW8O7VpRZEffPFHxUde5NUm6B5l2gEUlLH6Fa8uJHE+ZetM7GWFODBcV
	 zXv6lM5yIh1ESZenM7NJgRthuKLhzC089xGf0wV4KPhuGQ82HGrCYfrHvSEv7rpbJi
	 4coy5XdE29lsg==
Date: Thu, 22 Feb 2024 05:25:13 -0700
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Jai Luthra <j-luthra@ti.com>
Cc: Vaishnav Achath <vaishnav.a@ti.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jayshri Pawar <jpawar@cadence.com>, Jack Zhu <jack.zhu@starfivetech.com>, 
 Julien Massot <julien.massot@collabora.com>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Changhuang Liang <changhuang.liang@starfivetech.com>, 
 Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 Vignesh Raghavendra <vigneshr@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20240222-multistream-v1-4-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
 <20240222-multistream-v1-4-1837ed916eeb@ti.com>
Message-Id: <170860471258.2476270.8232202066004725650.robh@kernel.org>
Subject: Re: [PATCH RFC 04/21] dt-bindings: media: ti,j721e-csi2rx-shim:
 Support 32 dma chans


On Thu, 22 Feb 2024 17:01:20 +0530, Jai Luthra wrote:
> The CSI2RX SHIM IP can support a maximum of 32x DMA channels.
> 
> These can be used to split incoming "streams" of data on the CSI-RX
> port, distinguished by MIPI Virtual Channel (or Data Type), into
> different locations in memory (/dev/videoX nodes).
> 
> Actual number of DMA channels reserved is different for each SoC
> integrating this IP, but a maximum of 32x channels are always available
> in this IP's register space, so set minimum as 1 and maximum as 32.
> 
> Link: https://www.ti.com/lit/pdf/spruiv7
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  .../bindings/media/ti,j721e-csi2rx-shim.yaml       | 40 ++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml: properties:dma-names: {'minItems': 1, 'maxItems': 32, 'items': [{'const': 'rx0'}, {'const': 'rx1'}, {'const': 'rx2'}, {'const': 'rx3'}, {'const': 'rx4'}, {'const': 'rx5'}, {'const': 'rx6'}, {'const': 'rx7'}, {'const': 'rx8'}, {'const': 'rx9'}, {'const': 'rx10'}, {'const': 'rx11'}, {'const': 'rx12'}, {'const': 'rx13'}, {'const': 'rx14'}, {'const': 'rx15'}, {'const': 'rx16'}, {'const': 'rx17'}, {'const': 'rx18'}, {'const': 'rx19'}, {'const': 'rx20'}, {'const': 'rx21'}, {'const': 'rx22'}, {'const': 'rx23'}, {'const': 'rx24'}, {'const': 'rx25'}, {'const': 'rx26'}, {'const': 'rx27'}, {'const': 'rx28'}, {'const': 'rx29'}, {'const': 'rx30'}, {'const': 'rx31'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240222-multistream-v1-4-1837ed916eeb@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


