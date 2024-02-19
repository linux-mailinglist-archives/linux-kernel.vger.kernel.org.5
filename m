Return-Path: <linux-kernel+bounces-72061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123B785AE77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737DA284780
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB055E7F;
	Mon, 19 Feb 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4wHDeYu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3183D966;
	Mon, 19 Feb 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382025; cv=none; b=pAOncMYi6VL3vy4ldujHKlanyXXzEzM612zomLpCFKdqq+gdCOeZaWn+DMaWJQo8wXCSUcBaxmHxTaAtjf4BnpgDlYZRUWUqgdBsemp7g2eReNBIxJ5jGXc8SctHY8uw8u5XfdsXaxO5x7/zWHNu0o1Vdy6Mw/eHSMWhMapv7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382025; c=relaxed/simple;
	bh=O4fKZaiQPaIJXWA8cxp2UweHXAV6/z+SV96Qvk5/ds8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=uheXAhZCbnMA1D1B7Qvuwvf6coCqZtWh9yDWdub+kwvSmkS1KWgCieM6QKCjuWDlL92ZgcS2MJ9E+L4pZ0w/UEvV0MvNlxuksvjV4NIgjBDXB9N4ywRiePR9nBlgBD6NX8OcO3VCw+4GvFDrV6hoUqvVqByOAFrdCzd8kPoHpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4wHDeYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35BAC43390;
	Mon, 19 Feb 2024 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708382025;
	bh=O4fKZaiQPaIJXWA8cxp2UweHXAV6/z+SV96Qvk5/ds8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=h4wHDeYu4/HtbxYz0U4kYTobwm12vZ281WY71OJH+Mt7BsDyAom+6BGcHUrjbjse9
	 wj9CmiEgtz+iWnNh0CeW1z8PiINACwmCB5ngPRbYCyrr74Z9dOscXQp+0sXGL0fReF
	 RlP4ds36GBMHB9xBgTKE79rHggAHUdtqhq9F2s2PPWY1/UhasgBmWp7JnPUx3Yfnoa
	 x9AkGxUgwN/fQv+bsaM6dogAv/bAKL9bLTeH1zojQuG2aMEUNKI10xmVsXx1r11Rqf
	 iD94ptKNQV5jmUKd9htAefvoz4mJ4YhGf5QTR61yFpEyJI4pw+wW9MzswlNfl+MZD7
	 ZIvP1IekoOXnQ==
Date: Mon, 19 Feb 2024 16:33:43 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 David Yang <mmyangfl@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
Message-Id: <170838202273.730000.13574216479638773090.robh@kernel.org>
Subject: Re: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert
 to YAML


On Tue, 20 Feb 2024 05:27:58 +0800, Yang Xiwen wrote:
> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
> list due to prior driver change.
> 
> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
> compatible lists.
> 
> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>  2 files changed, 95 insertions(+), 71 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml: patternProperties:phy@[0-9a-f]+:properties:reg: 'anyOf' conditional failed, one must be fixed:
	'descrption' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml: patternProperties:phy@[0-9a-f]+:properties:reg: 'anyOf' conditional failed, one must be fixed:
	'descrption' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('descrption' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'descrption' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240220-inno-phy-v3-1-893cdf8633b4@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


