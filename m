Return-Path: <linux-kernel+bounces-84597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4986A8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035F21F25C49
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B125567;
	Wed, 28 Feb 2024 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ertHSvP1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5925108;
	Wed, 28 Feb 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104851; cv=none; b=u1sH80umHpv15FWiN6/q2VNZo+5b9fdWZLyPvkEm6uJMH5Z0rPrc2U1d+iyFHjhVyK6V6phwRMVuNKAJ+D+lNXS7J7Ol4SoEZPEPJHF5IMdLDccjejutD9zyr7nE6r3dgXFUMICThXBEpINXTG7pDMG7ilY6iziqSwFv1XktKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104851; c=relaxed/simple;
	bh=GJEAgcGajQHOekPPW3hskfy84Wf8MxRKNiEJITZZ/SE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QX5osNZoz+EP05uV4jZAutXY4yLmDZfPfQF7bTaKbbPV1pTG5MAGpjcCjMYuNf8A6nmVOnpSVgigsP4aj4vqHr9paL40ZtLUhAPUu2fx5o5iUtWpXveBQ/r9K0V1tdRftAOcpKRIOeTayBTMZqkhRxhbD6QSs/MgeIcPBFO7YLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ertHSvP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723CEC433C7;
	Wed, 28 Feb 2024 07:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709104850;
	bh=GJEAgcGajQHOekPPW3hskfy84Wf8MxRKNiEJITZZ/SE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ertHSvP1EvWCBUKaP9J13CcvXiXh6JelVegD9JFQpU9Juh3qNLgZYynRcDfRhJaJ9
	 JT1ZUUFVPj7tbV+tYVtCoritu9PBTGkQy7Z/aB5dWn/hIEwHBBTX99eUaPj3OEYrv9
	 xjCgpbY8GyECA1Z+iPeoWDwv7nVwuGCQYmMuQoTW6g2VfIt1sYU6/0t5FLTvE7muSn
	 Qf91BIFVEL8b3w05D7S/23MKylnALBpzudkOihu9AdhbIV1C/Zb6NSXn8/kewvU7HQ
	 W+XU2pMkOpvdYkTbNA+x1n1yeF4VPa37nOpQbewk54CFUbM7US30DrcofUtu7hH7KY
	 YIaRFhXf70s3Q==
Date: Wed, 28 Feb 2024 01:20:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Abel Vesa <abelvesa@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20240228-imx95-blk-ctl-v2-1-ffb7eefb6dcd@nxp.com>
References: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
 <20240228-imx95-blk-ctl-v2-1-ffb7eefb6dcd@nxp.com>
Message-Id: <170910484819.1798591.16113826147285530887.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module


On Wed, 28 Feb 2024 13:43:05 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
> VPUMIX, BLK_CTRL_NETCMIX in NETCMIX, CAMERA_CSR in CAMERAMIX and etc.
> 
> The BLK CTL module is used for various settings of a specific MIX, such
> as clock, QoS and etc.
> 
> This patch is to add some BLK CTL modules that has clock features.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx95-blk-ctl.yaml   | 61 ++++++++++++++++++++++
>  include/dt-bindings/clock/nxp,imx95-clock.h        | 32 ++++++++++++
>  2 files changed, 93 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/imx95-blk-ctl.example.dtb: /example-0/syscon@4c410000: failed to match any schema with compatible: ['fsl,imx95-vpumix-csr', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240228-imx95-blk-ctl-v2-1-ffb7eefb6dcd@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


