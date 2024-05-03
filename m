Return-Path: <linux-kernel+bounces-167831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BDF8BAFFC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF80E1F235D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C60150988;
	Fri,  3 May 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7BvhLUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726C154BF3;
	Fri,  3 May 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750518; cv=none; b=E7VCWQkw1IbyTFgWEJIClydswKF+W11xEmfQTyH+1z+t8urn0esANoFSamYDa3Da0UqmtURPUSebpJVyaYTqu4m8Hu8xLm46GR1w2P8/8fot/LQWvToIyK9QiqlyoyWTrVu3jmYGDmRL3xsYBIRoG/L0KFbQEYCyD2KykXEdm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750518; c=relaxed/simple;
	bh=W7CM22NmLViaaQ1ZuNAixQADGaivdjs2l0TCTx40bMc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KIIzREB6kmAfCjGV0QbCKk3epOF4Uiv75OFLjls/w0PNRoCj7VUY8eYlgD4v0PN1I9TWglkvYgF2iJmolD10BXmsKx+o12FuFFGdD+G8g/pnQLuQsNPCvZhX+GZv/ZioILd1ZYlhhLY8ZUHJk/ZMIcricPXQaIw7MxudK54dcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7BvhLUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CAFC4AF1B;
	Fri,  3 May 2024 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714750518;
	bh=W7CM22NmLViaaQ1ZuNAixQADGaivdjs2l0TCTx40bMc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=s7BvhLUZSfr3XzknFD3wulbSHm6QGC/tEMM6sjgOJNrZpbU6yXn2vtj0UEnHgMLSd
	 2vfgIrSwV/Ak2y9XhkEROe9REmMjZSlwo1TVT/jrPrvod3ULXb0bko+6uMfHtE4xH/
	 GwAN/05ETdSK0K+aZF7ZzAmOGlkSbYEHVcBav6HtAadqxPUn62jGOvF/4tEATn8kvB
	 R1UeUEjSTg85+cvVe1Dl7EiKuVs5zGc1hPZsG4SCDtaTCHeJ2dpwPJ2OqquXuyLNH+
	 VL+Ob08t4YqsA7x0DeSdk+EA3GTDTQwsf0Sf+825Vbb/Pb5fiq3l3tB7JcFrlj6ezD
	 SQkNvlYmEzJ2w==
Date: Fri, 03 May 2024 10:35:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: linux-gpio@vger.kernel.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-mips@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-clk@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 devicetree@vger.kernel.org, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20240503-mbly-olb-v2-3-95ce5a1e18fe@bootlin.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
 <20240503-mbly-olb-v2-3-95ce5a1e18fe@bootlin.com>
Message-Id: <171475051550.955578.14266002492616876772.robh@kernel.org>
Subject: Re: [PATCH v2 03/11] dt-bindings: soc: mobileye: add EyeQ OLB
 system controller


On Fri, 03 May 2024 16:20:48 +0200, Théo Lebrun wrote:
> Add documentation to describe the "Other Logic Block" system-controller.
> It deals with three platforms: EyeQ5, EyeQ6L and EyeQ6H. First two have
> a single instance, whereas EyeQ6H has seven named instances.
> 
> Features provided are:
>  - Clocks, children to main crystal. Some PLLs and divider clocks.
>  - Resets. EyeQ6H central, south, DDR0 and DDR1 do not have resets.
>  - Pinctrl. Only EyeQ5 has such feature.
> 
> Those are NOT the only registers exposed in OLB system-controllers! Many
> individual registers, related to IP block integration, can be found.
> 
> We simplify devicetree references to OLB in two ways:
>  - Compatibles exposing a single clock do not ask for a index argument.
>  - Compatibles exposing a single reset domain do not ask for a domain
>    index, only a reset index.
> 
> About pinctrl subnodes: all pins have two functionality, either GPIO or
> something-else. The latter is pin dependent, we express constraints
> using many if-then.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 375 +++++++++++++++++++++
>  MAINTAINERS                                        |   2 +
>  include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 ++
>  3 files changed, 398 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240503-mbly-olb-v2-3-95ce5a1e18fe@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


