Return-Path: <linux-kernel+bounces-48593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342DB845E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC881F2A25C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8444B84020;
	Thu,  1 Feb 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f68EvTjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8B63CAF;
	Thu,  1 Feb 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808702; cv=none; b=RbZVOjtgviVRyOSH6SA2HcjnTuzFxPH9uehYhYFLlf32uvstww7EtgO188JtzLRurlzSl6NHiOmGKSvwKowql7c8g1bb4lEpps0fshtDk/EPqjrU90bGwEtJ7DXo0LzFFr/EtB8l4RhVOhMLsvW1Sk4cBdaKhmEkdmhgTUmfiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808702; c=relaxed/simple;
	bh=WTfAV8E5tolH0Cpe7AFR3fPsSu2YVvD36XVmkg+Huyw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VniJFCfBIm3dW+SfdVo9H/eksbMesRL7DgaUOJ5Y5+BIL3bK7P/HCqatOjWCbQAYtxYh37VDCW9k5pbYO4RJTAv04fw1f4IZbCbYnp1qluXMlIeXxEEl78M3I2XQw0zzUvcUuLR5C3O8EcxTZOjSbKItDkDMtMFdxOF38yrNCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f68EvTjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E6C433F1;
	Thu,  1 Feb 2024 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808702;
	bh=WTfAV8E5tolH0Cpe7AFR3fPsSu2YVvD36XVmkg+Huyw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=f68EvTjvzkRDBiGk/cyjJViHIOhudiBr8virxWTmT3rlcbchaOfPKFGKjSS0z7SNj
	 Txvcf/9xarLbFTwgWrI0DnP5DuasXVh9q4tjsz2MrBC0/Co9ZKeJE7rRnCCxOBCcr+
	 us5bNql9Y/LV1wrMdZxGziiQqzFmu+MMXGhjAqqRVsV2Y0p1ZmQM0xPkAkPGqmeiwR
	 KpU7pYRY8AXXpHIR0CeaV6NghmQy8aFlCASVM78xpuoESWdkNEHQvmZQFTSEgewooC
	 NhFMI0Z4JLJO1cw2y4rzXCtrPuhQfQ6Iy/YznI+KqrCKSRpR0bWI6+NFWAd1coZI8E
	 tXvexldZe2Svg==
Date: Thu, 01 Feb 2024 11:31:41 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be>
References: <cover.1706802756.git.geert+renesas@glider.be>
 <b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be>
Message-Id: <170680870030.996964.6959185693674664805.robh@kernel.org>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: gpio-regulator: Fix
 {gpios-,}states limits


On Thu, 01 Feb 2024 16:58:41 +0100, Geert Uytterhoeven wrote:
> make dtbs_check:
> 
>     arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: regulator-vccq-sdhi0: Unevaluated properties are not allowed ('gpios-states', 'states' were unexpected)
> 	    from schema $id: http://devicetree.org/schemas/regulator/gpio-regulator.yaml#
> 
> The number of items in "gpios-states" must match the number of items in
> "gpios", so their limits should be identical.
> 
> The number of items in "states" must lie within the range from zero up
> to 2^{number of gpios}.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The second issue did not cause any dtbs_check errors?
> ---
>  .../devicetree/bindings/regulator/gpio-regulator.yaml         | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml: properties:states:minItems: 0 is less than the minimum of 1
	hint: An array property has at least 1 item or is not present
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


