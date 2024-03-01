Return-Path: <linux-kernel+bounces-88833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E77AB86E750
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00A428D0B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257BB3C08F;
	Fri,  1 Mar 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIOF4Ss5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F33BB53;
	Fri,  1 Mar 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314193; cv=none; b=ClnFL2Ifsk4CWcPYZ1M/1HkZN2hgr2ga5Gz8DLoNFFzF1cZvcgA2rnHf5sPBen8Oom2b/T39IzNLVT0dOk5rd+gB7rQkT1nrjhaxZINO7zyA3+rfKrV/hKsUtL8CtGPKoOT6jzXd+b6W8OmmPYjECidetR7l0+bqqJIAJG5Z9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314193; c=relaxed/simple;
	bh=WVxywXC3sbGUricAi2EXdBOzFdQ8QwJnE94UfbYDxFs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=JcZIcS256HF80OZRxHoTkt3sHF1atPeH4IkOzEUhJnbSF6YX5fZkHXSU72V8CnZLj6/KEGNwwIkiXku70x8coEh49JbLUoyUpD+c1W8HA8/c7USv+ZU4t25YonVeG/AyYwAwv3WjoONtiX6lrgRBS4qnoS29groH/bG2vkACy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIOF4Ss5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C53C433C7;
	Fri,  1 Mar 2024 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709314192;
	bh=WVxywXC3sbGUricAi2EXdBOzFdQ8QwJnE94UfbYDxFs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uIOF4Ss549Pa5/GS1UuTqjZK59ux2hW/ydhhEXw+jc7kH1sUfbMIKf/2N9pRJlPme
	 l+Hgb5hmGwOT9Q+ZoWc3d2/2qTn4EZE5WvymLVbMUDX15E3U+WoJSoeV+vcb+emUAK
	 bhyceLdYgN2D1NCF4yRaCM9xpgI2kSiqraKHmQo1XdKgRi7pacPALnGAqJpUoQDwK2
	 hZwhj/YUrBsVSpfWuXCC1jtF8vy2KaI9emP0W7//OiVZ5fH0Dwm98VwrjpRHmpPPWP
	 PnVFAWFDlzlO4K0lfY8gyjaT0uAUN/iYae26XqCVeeSYiHA4F71o0L+AvevuXncLvP
	 IuzYwm/Wtr9CQ==
Date: Fri, 01 Mar 2024 11:29:51 -0600
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
Cc: Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, devicetree@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20240301-mbly-clk-v9-1-cbf06eb88708@bootlin.com>
References: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
 <20240301-mbly-clk-v9-1-cbf06eb88708@bootlin.com>
Message-Id: <170931419071.2439554.3352250315486620896.robh@kernel.org>
Subject: Re: [PATCH v9 1/9] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller


On Fri, 01 Mar 2024 17:22:14 +0100, Théo Lebrun wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: pinctrl@b0: False schema does not allow {'compatible': ['mobileye,eyeq5-pinctrl'], 'reg': [[176, 48]], 'uart2-pins': {'function': ['uart2'], 'pins': ['PB8', 'PB9']}}
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/soc/system-controller@e00000/reset-controller@0: failed to match any schema with compatible: ['mobileye,eyeq5-reset']
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/soc/system-controller@e00000/clock-controller@2c: failed to match any schema with compatible: ['mobileye,eyeq5-clk']
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/soc/system-controller@e00000/pinctrl@b0: failed to match any schema with compatible: ['mobileye,eyeq5-pinctrl']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240301-mbly-clk-v9-1-cbf06eb88708@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


