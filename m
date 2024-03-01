Return-Path: <linux-kernel+bounces-89023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C486E99A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B07B1C21259
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76383BB33;
	Fri,  1 Mar 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWRa70tJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF783BB53;
	Fri,  1 Mar 2024 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321421; cv=none; b=iDZnAAjygakDZDb5Xl5aKwfuJqJ9YiGlHWRKuuOqpmNaa376C1ysId18ugt4amZI+Xsk2xJCt6ZJVIla0c0xGPH04HbWBeLY0j2hGMJyJHYQkkJQkDI5oNA+XGYTcouDEWgWAwgfoPADRbpU3T173k4Rv5C4XGbcPmiTQz0Gem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321421; c=relaxed/simple;
	bh=6Rqv0faURWJI/3NOQPOHWDUzQFrx11H6s6M6zXFApI0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=G5Lw2J8dOyRY2gUQBc8eHZNUfIgZdJI6NDoXpyKIdoKvAFTvEX9ErmLIsakEa1TCibLKhyp3/yLNVPltdGP4iwdP5sUWgjV0U5fjmA9Q8hI321YIr1ORejHfP3l8nxGZV0EyoKBwj4Ox3hlaXdxfGpyOznzl6e6DyywA3tol/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWRa70tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A439C43394;
	Fri,  1 Mar 2024 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321420;
	bh=6Rqv0faURWJI/3NOQPOHWDUzQFrx11H6s6M6zXFApI0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CWRa70tJvq6el/aXrZip5PuNX+xc1LoCJ8+h4D0rMgSyyRAYtMqaxRDU1C1Puj533
	 OU6xN/bQB4JFfpubX+I6ek2ZJo80GCl/t07zGL6ETgaA+czQZ8mPwxIxNjHaPUSeiX
	 TAaJ57tGVCnxzyVK78ltt5t3O514AWSToqAD3xoxvytmg1xhQmOUNuwnS695p3C//S
	 UFp6f/ooWTbAjmNgb4WPZOzJWH0KcKzsEtSofv+Nw2fbRP9dfYc8LImDnLhaVI3LXR
	 p+LJN5CeGWBj7Tf7zx/BLf/r3UhdhSHRn4CpjI5R4VmXo+/Cd1Pe0zVEUjpmzPfxTM
	 3469dySTSf2eA==
Date: Fri, 01 Mar 2024 13:30:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, dlemoal@kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, 
 devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
In-Reply-To: <20240301174729.238869-1-animeshagarwal28@gmail.com>
References: <20240301174729.238869-1-animeshagarwal28@gmail.com>
Message-Id: <170932141816.2900771.3586455400222811829.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: imx-pata: Convert to dtschema


On Fri, 01 Mar 2024 23:17:21 +0530, Animesh Agarwal wrote:
> Convert the imx-pata bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../devicetree/bindings/ata/imx-pata.txt      | 16 ---------
>  .../devicetree/bindings/ata/imx-pata.yaml     | 34 +++++++++++++++++++
>  2 files changed, 34 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/imx-pata.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/ata/imx-pata.example.dtb: /example-0/pata@83fe0000: failed to match any schema with compatible: ['fsl,imx51-pata', 'fsl,imx27-pata']
Documentation/devicetree/bindings/ata/imx-pata.example.dtb: /example-0/pata@83fe0000: failed to match any schema with compatible: ['fsl,imx51-pata', 'fsl,imx27-pata']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240301174729.238869-1-animeshagarwal28@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


