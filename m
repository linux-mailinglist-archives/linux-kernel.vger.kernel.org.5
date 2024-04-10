Return-Path: <linux-kernel+bounces-139223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A7D8A0010
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAA82841DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9DA17F376;
	Wed, 10 Apr 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6OuxsVT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41A16F0DF;
	Wed, 10 Apr 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775142; cv=none; b=sLhWb8bu+Xr78gnHNTKCsJJnX3WxaL4QfEt0UVeySYPu+9qGdAQDLNKYMNYliAjFgcFxp8N9G6q7/eIc1NCeq+TCj3atLfBS6MGpGU3uJWzN3R3p+nKeE7uj0Aylmcn2YqKF1ExqTD/CVg0hi1tThbqN15InqYCss3geYaG4f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775142; c=relaxed/simple;
	bh=z5JVLaH+fp0+7NF0boo5IQT2gY7gn3yvbn52zrvcvJ0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=o90WXOtYo2qlap/p+3CUY6xbgD8+uB+483Sgrdn8VEy+UOV/Yco3t4pnczQK3acsz0wtOxPiPe9U2333UhQIGIJEaP6THoFpD3+LrWAc/SMpt1zNQWVIe9GUy/mAXBoKF1VtPMez0NVgtQo+77w1ZIR7om0cqsAh4jPNGnpV3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6OuxsVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F86AC433F1;
	Wed, 10 Apr 2024 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712775141;
	bh=z5JVLaH+fp0+7NF0boo5IQT2gY7gn3yvbn52zrvcvJ0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I6OuxsVT4AkYCNqtMs94w+YdgDTmc7sZi1OxRFxEEY7TdKkHVJLcff0Ns9HQaWzZJ
	 CJzELzUg6LhW/Zb2WUONLbjORl/K/NFFYoiLPrAM9BlAsKDbk2d0opNG3Oe/mBsz/f
	 LSIY661NBeHfccgnhAeH1yRgTFxTnGCfX5FWEGYNzFHgzKfk7qsgH8sc5xD/S3x/DU
	 svDLtE/k8eLctNrc8VUwJn+aoiuNdhTEFhChq/a7rgOmJGEr6sHa+OUHyvvjVUkKaR
	 mxiam+sNWKUBU7VM5dtuK6YPrlAybjIy+Uubf/kxua+j/QwydgWgS+mGV46n6F7ekT
	 1tGYgjy5Mebig==
Date: Wed, 10 Apr 2024 13:52:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-gpio@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 linux-clk@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20240410-mbly-olb-v1-1-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-1-335e496d7be3@bootlin.com>
Message-Id: <171277513936.883835.18187305941709008733.robh@kernel.org>
Subject: Re: [PATCH 01/11] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller


On Wed, 10 Apr 2024 19:12:30 +0200, Théo Lebrun wrote:
> Add documentation to describe the "Other Logic Block" syscon.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 125 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 126 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@d2003000: clock-controller@d2003040:compatible:0: 'mobileye,eyeq5-clk' was expected
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@d2003000: clock-controller@d2003040:reg: [[64, 56]] is too short
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@d2003000: clock-controller@d2003040: 'reg-names' is a required property
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@d2003000: reset-controller@d2003000:compatible:0: 'mobileye,eyeq5-reset' was expected
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@d2003000: reset-controller@d2003000:reg: [[0, 60]] is too short
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@d2003000: reset-controller@d2003000:#reset-cells:0:0: 2 was expected
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@d2003000: reset-controller@d2003000: 'reg-names' is a required property
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-1/soc/system-controller@d2003000/reset-controller@d2003000: failed to match any schema with compatible: ['mobileye,eyeq6h-acc-reset']
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-1/soc/system-controller@d2003000/clock-controller@d2003040: failed to match any schema with compatible: ['mobileye,eyeq6h-acc-clk']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240410-mbly-olb-v1-1-335e496d7be3@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


