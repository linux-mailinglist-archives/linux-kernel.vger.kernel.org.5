Return-Path: <linux-kernel+bounces-83626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 146AF869C74
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79751F2441A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE91487DC;
	Tue, 27 Feb 2024 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl8yB78/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD46145FF9;
	Tue, 27 Feb 2024 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051915; cv=none; b=FDSnBuJGZ8pZoHE2kuQPac+L4GjPXOywdqGaRIUFLYNC+rFegRSW8Oc5dFDHhdKNRa4f+7L6WUfKoJhRPZ8MBcwwGMSXJP8b68Ri4pX1ptV5goXDSoIOoalq60ZWnWqysU506oU3SDnrGaTOPg9tm3/coSS4PQgdl/tPkq9TI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051915; c=relaxed/simple;
	bh=ikEKQlLSECX2b8BEADhWEQfhujAMjXxhYPJhlsmt8PI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=T48zqJwToRF2TI1GRN+FmdLju6mEslBKHFD7ELmzG0XWJjKZuFxQgd+LLuFxwIZlS2v/VV/CCGAOxnu6sXd6KaKG44YsoOmPACNfhUYUYdbbk41xeaU4MLLueIl+K3sWO6fIwUsrhQQ8N9xjHEBHVR1Qys51P25nmDeuuBrikdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl8yB78/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F929C433F1;
	Tue, 27 Feb 2024 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709051914;
	bh=ikEKQlLSECX2b8BEADhWEQfhujAMjXxhYPJhlsmt8PI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Zl8yB78/QGgEfBXbOE2rd4BWgjAnheF0pBdhJ1LOk6mW7YPw/rXx6fJyuhgnmBDta
	 yi2LyvAU3PGI9FJN4gxPo10VelwIwhjiGA1hrOLr/wf8Npe/6ud9/3QqJbaEi/vJVk
	 9vXrkmrHAAwJV63xA4UiGlzOQsUM7fy2y+83AnqrM8TjZZIfpCdC1TGW2ayacFRdc7
	 1J8JhemTBkpHNOpnvFiozMvAF5rgRbWx3jlaNFVoO+k9a7TpmztIQGLum027h5l6qN
	 0DBCB+4dKUmsOAOEKFPTlgYgoht6tqErsyD5VPfXo3NDLmYnf3dLDh2pEYcdz6br4Z
	 BWly5kOEoP8Pw==
Date: Tue, 27 Feb 2024 10:38:33 -0600
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
Cc: linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-clk@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20240227-mbly-clk-v8-2-c57fbda7664a@bootlin.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-2-c57fbda7664a@bootlin.com>
Message-Id: <170905191234.4042659.13935993184407860612.robh@kernel.org>
Subject: Re: [PATCH v8 02/10] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller


On Tue, 27 Feb 2024 15:55:23 +0100, Théo Lebrun wrote:
> Add documentation to describe the "Other Logic Block" syscon.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/clock/mobileye,eyeq5-clk.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: clock-controller@2c: False schema does not allow {'compatible': ['mobileye,eyeq5-clk'], 'reg': [[44, 80], [284, 4]], 'reg-names': ['plls', 'ospi'], '#clock-cells': [[1]], 'clocks': [[4294967295]], 'clock-names': ['ref']}
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: reset-controller@0: False schema does not allow {'compatible': ['mobileye,eyeq5-reset'], 'reg': [[0, 12], [512, 52], [288, 4]], 'reg-names': ['d0', 'd1', 'd2'], '#reset-cells': [[2]]}
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/soc/system-controller@e00000/reset-controller@0: failed to match any schema with compatible: ['mobileye,eyeq5-reset']
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/soc/system-controller@e00000/clock-controller@2c: failed to match any schema with compatible: ['mobileye,eyeq5-clk']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240227-mbly-clk-v8-2-c57fbda7664a@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


