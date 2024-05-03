Return-Path: <linux-kernel+bounces-167830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B828BAFF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310DC1F231C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE14B15444D;
	Fri,  3 May 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJRJV0rW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273494BAA6;
	Fri,  3 May 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750517; cv=none; b=CxJofVmoYa8lZ7NsimUUIAE5TmEwfLyBKDfXwuT3AvFMOTxtTHUXWY62tlxPa8x4JFxncP3+sdRqeJqlAuBXUwyWMDlaTu37FZ/c6bvcNBefHDznFEbvPDjcgfdUENi7jttBlayZHx8NkIpPs2YAHi7DBltCDQSfs+66H5wYhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750517; c=relaxed/simple;
	bh=5122ytSykAD8/7pq8djxBfhijWrS3hHsYPao9LwhmNQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ME7w/0p5Buls5G+5lKCGSDkf/qPbbJpJdABO6xqzOt8UiPbuYb5VO834zFAt6LlDp/T8cqcj38dJ13Q5giqFiIjjlspKoB1jGRjGW5AYBrNGSBj3vqo7pWsJnrzsePPPql0JdP1vrZDdJ75ODi0qkto/a2KjTcAeybRG1M5QBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJRJV0rW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80050C116B1;
	Fri,  3 May 2024 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714750516;
	bh=5122ytSykAD8/7pq8djxBfhijWrS3hHsYPao9LwhmNQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hJRJV0rWm2CPF11P6sOxYgxNcsV1cLMpZxMsKn4aX4oxHZkiTFvX5DQSQiqRTsBRl
	 ojNq9yNvT3ihP89dxUneZkEaEx/1pA0FSJAuo6A1OsjI5gCcdto2mgs69J/MOZ5sZ7
	 4xBq/Xa6o73jjshWUgyViAlso0cH4p9fyuvvT79U8/VwV2TqbqRZaBtPC/qe4YTn74
	 mcU1qrgan3O0PMspAJJIWHuTXi5ebuq3Q7vWkGgKmvbDWm7rVHgtgRXyjB+FhHp83O
	 Pr5r+GnPaLEJcjXLzuPC7GuhLGTUMDIKzS1zMMQFafYSTP7iklHKUeSdSl8VDMw+RV
	 JvR6LYpHb6mpQ==
Date: Fri, 03 May 2024 10:35:15 -0500
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
Cc: linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
In-Reply-To: <20240503-mbly-olb-v2-2-95ce5a1e18fe@bootlin.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
 <20240503-mbly-olb-v2-2-95ce5a1e18fe@bootlin.com>
Message-Id: <171475051471.955521.7998302785295485922.robh@kernel.org>
Subject: Re: [PATCH v2 02/11] dt-bindings: clock: mobileye,eyeq5-reset:
 drop bindings


On Fri, 03 May 2024 16:20:47 +0200, Théo Lebrun wrote:
> Switch from sub-nodes in system-controller for each functionality to a
> single node representing the entire OLB instance. dt-bindings is
> unnecessary and soc/mobileye/mobileye,eyeq5-olb.yaml will inherit all
> properties.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/reset/mobileye,eyeq5-reset.yaml       | 43 ----------------------
>  1 file changed, 43 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dtb: /example-0/remoteproc@cd00000: failed to match any schema with compatible: ['qcom,ipq8074-wcss-pil']
Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dtb: /example-1/syscon@20e00000: failed to match any schema with compatible: ['sprd,sc9863a-glbregs', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/clock/milbeaut-clock.example.dtb: /example-2/serial@1e700010: failed to match any schema with compatible: ['socionext,milbeaut-usio-uart']
Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.example.dtb: /example-0/peripheral-controller@8a20000/phy@850: failed to match any schema with compatible: ['hisilicon,hi3798cv200-combphy']
Documentation/devicetree/bindings/sound/st,stm32-sai.example.dtb: /example-0/sai@4400b000/audio-controller@4400b004: failed to match any schema with compatible: ['st,stm32-sai-sub-a']
Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240503-mbly-olb-v2-2-95ce5a1e18fe@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


