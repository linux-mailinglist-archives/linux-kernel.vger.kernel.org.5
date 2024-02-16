Return-Path: <linux-kernel+bounces-68622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238BB857D57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B6CB2498E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFAF129A88;
	Fri, 16 Feb 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2lqtOjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68451292F2;
	Fri, 16 Feb 2024 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089077; cv=none; b=roFGJ1mYgTMfFD1GdGxVr5WhtZx+ZdTWs0EO63wpZXh8ssw3JX2LWjLAYFV1nBBhiRa1FqquRbhGatCLVcs1/Aq1JrIdJn5qwKphHql2BFnuR9y73LRDrzQuklCudRsAijWirY5Wvwmfe37WUxgk+CGO0s6kSEmPZOM/61CHukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089077; c=relaxed/simple;
	bh=LAAp7Osd1gjjfHEdbUnOHNw1THfhBG7mbln6+EHSQYY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KJ71wT0r/ifIhU0xikXgI6WeS1FN3ySwJMEx1KuR0h9/Zx0/CaXdE6boODCdSNg+np+JvG+NevMuGgebm78Sx1zV4iV3jlMDnXFQwveytYqIL0R/WpJhMIGtSMdZaq5YiMQNbxeAlH9t4m2U2oSPL6MDtWZkiCzmyfm4CMKRDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2lqtOjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28851C433C7;
	Fri, 16 Feb 2024 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708089077;
	bh=LAAp7Osd1gjjfHEdbUnOHNw1THfhBG7mbln6+EHSQYY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=W2lqtOjviTGvuy/SZQ8Hmi2zmEN+9d9HUPTHVi/gpwu6V5xCnhidnMyPLetzivGNr
	 v0TGRrS0sDEaO63FPIDu8Q465eTQUO7rs0LQtrMyI2IhgAsS1kO0AFfGVZd6kEpRHx
	 epSnv4yTzkX19f67WTal7EBX0VoH9qcz5Kw3e38YLnl8p6+FxbWVQFGV5g9GAJJ+sj
	 PUo6oV9RYlBvqcDTpXlAS6TcxxXDe7YUThpcDxJ7tU0nf7EldwnAW8eQU3XVgBFdOd
	 oyLvaVQD8fXFzHBYfqK0PZ8JeDerRCjk+rN2hCb7nCkmJXFfc9rfHHvaI8fSaXGqpI
	 q32WJPuBnwlxQ==
Date: Fri, 16 Feb 2024 07:11:16 -0600
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
Cc: Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Yang <mmyangfl@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240216-clk-mv200-v1-4-a29ace29e636@outlook.com>
References: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
 <20240216-clk-mv200-v1-4-a29ace29e636@outlook.com>
Message-Id: <170808907492.2771271.5272601820598116325.robh@kernel.org>
Subject: Re: [PATCH RFC 4/4] dt-binding: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC support


On Fri, 16 Feb 2024 19:37:54 +0800, Yang Xiwen wrote:
> This SoC is similar to Hi3798CV200.
> 
> Also document the specific DLL regs and add an example for it.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../clock/hisilicon,clock-reset-generator.yaml     | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.example.dtb: /example-2/clock-reset-controller@8a22000/sap-dll@39c: failed to match any schema with compatible: ['hisilicon,sdmmc-sap-dll', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.example.dtb: /example-2/clock-reset-controller@8a22000/sap-dll@3a4: failed to match any schema with compatible: ['hisilicon,sdmmc-sap-dll', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.example.dtb: /example-2/clock-reset-controller@8a22000/sap-dll@3ac: failed to match any schema with compatible: ['hisilicon,sdmmc-sap-dll', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-clk-mv200-v1-4-a29ace29e636@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


