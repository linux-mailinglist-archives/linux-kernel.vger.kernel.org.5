Return-Path: <linux-kernel+bounces-36047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7826839AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA84A287BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D42C681;
	Tue, 23 Jan 2024 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8itH9+3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03D22062;
	Tue, 23 Jan 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043482; cv=none; b=jC4dTKqAXCvlJHjNSmQxEV0rChCshmHU8laQyvAcsVsTesuum1i37g+Il47//1ASbniqJdxGrRpztU7rjshFkgdZkJMFElUHVEYx5rEVcYvthTT9Ujt7MFfm3GOUARWTQD+HQ3bw1ygOXpFZLYdpe3xdxxGxY3KXhnvtusR8xYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043482; c=relaxed/simple;
	bh=Dy5zxA6c7jFWwSh8GJ8YoVzBXmqlTVG67n4m3y2+WZE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=CLjyqFgjoT2/RkmirjWCgUYQkjziyZmTejBHq+pmS70NXzyM/k4M5KMPbjKHKp04rXLwSXhBJK/OFeKNc7dJsf8+jeWVbOQCWBKDsfXveElV6EHrc+urhgxiB/2g/QE00t41G1xcj6I9P1HDWQkQ0S8sMyEjwu4nEa64YKhRO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8itH9+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9D3C433F1;
	Tue, 23 Jan 2024 20:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706043482;
	bh=Dy5zxA6c7jFWwSh8GJ8YoVzBXmqlTVG67n4m3y2+WZE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Y8itH9+33g8+Bro4cfhlc60bsNVJqZfNXDqJmnChcxydSoY5g9EJt/6wS5O9GmVp6
	 NANOqaRYekyGd54ktMiLDmLHcxCUzy8hcG2kmYYtGllcqx32v/YmxD7tzU5Ig7pvuN
	 WJKvoO/okkfp6Z8clHXV82jmbo4x8MObJmP7r61FUsUc3zIN2JRT71Nzei5Oe9f4Qv
	 DIUG+2kkDJ0BdY7K/OrTmC5xRH2dH/vtXQJGoVSurHq03HK46t/VSDh56GPdIBctKp
	 wXmtc4lROICktAuWDujUMxYkBaA6ohyrXtLoNsQHL8e8MF+M88d7+eE2ua/XctxqrV
	 QWQelbEm+TgUQ==
Date: Tue, 23 Jan 2024 14:58:00 -0600
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
Cc: Rob Herring <robh+dt@kernel.org>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 linux-mips@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-clk@vger.kernel.org
In-Reply-To: <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
Message-Id: <170604347738.1901942.18176924808448385013.robh@kernel.org>
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller


On Tue, 23 Jan 2024 19:46:49 +0100, Théo Lebrun wrote:
> Add documentation to describe the "Other Logic Block" syscon.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 77 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 78 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/clock/mobileye,eyeq5-clk.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: clock-controller: False schema does not allow {'compatible': ['mobileye,eyeq5-clk'], '#clock-cells': [[1]], 'clocks': [[4294967295]], 'clock-names': ['ref']}
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: reset-controller: False schema does not allow {'compatible': ['mobileye,eyeq5-reset'], '#reset-cells': [[2]]}
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: pinctrl-a: False schema does not allow {'compatible': ['mobileye,eyeq5-a-pinctrl'], '#pinctrl-cells': [[1]]}
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: pinctrl-b: False schema does not allow {'compatible': ['mobileye,eyeq5-b-pinctrl'], '#pinctrl-cells': [[1]]}
	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/system-controller@e00000/clock-controller: failed to match any schema with compatible: ['mobileye,eyeq5-clk']
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/system-controller@e00000/reset-controller: failed to match any schema with compatible: ['mobileye,eyeq5-reset']
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/system-controller@e00000/pinctrl-a: failed to match any schema with compatible: ['mobileye,eyeq5-a-pinctrl']
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example.dtb: /example-0/system-controller@e00000/pinctrl-b: failed to match any schema with compatible: ['mobileye,eyeq5-b-pinctrl']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240123-mbly-clk-v3-4-392b010b8281@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


