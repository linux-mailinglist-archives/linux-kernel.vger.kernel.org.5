Return-Path: <linux-kernel+bounces-84530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91F86A7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE0DB2240D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E0210E6;
	Wed, 28 Feb 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbxOV6/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BB20B35;
	Wed, 28 Feb 2024 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097631; cv=none; b=RCo3rtVxMrxBcWmah5a7Vo1YxgLw8aYlOGQFMxC4aflH/03E8pR12A9tV6tW5yVuaUXYmp48tfI4nOMVw3/r+s0b++B2pUIYl1NHg9BbbnEo8QtKA4NbaqQOL/8BnO0AuWg5lBW9UO+MVIKHXzJFr8+J4O+/fOS0zlqhfGFfhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097631; c=relaxed/simple;
	bh=bQQCh+4x5G6GPwcir7PDSPu3I8AoEcyhe4AaapPYS+s=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=kvN919OQvWrGS2xerF2vu877SRoJ4sioEH4iKHF7IP+OMaG+RKxzowI3WXnUaDLotgFx29vWUJNARzD8BPOQ+xvgoEA1G2Q1cH/zCkqAu92Yk8nviCHqVoF34rxTQ1/Czj1Np87idXNc1Ol6Vis5rJ+BFU0otmM0LZMHrspftAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbxOV6/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B02C433F1;
	Wed, 28 Feb 2024 05:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709097630;
	bh=bQQCh+4x5G6GPwcir7PDSPu3I8AoEcyhe4AaapPYS+s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HbxOV6/gbJDgoEG7nofHmPYlMdX0nXrvWI+sY3S3SB/2MfBGIztYSim5nueJy1Pdy
	 cZh/exZvSTupu8gWCqEHOc7t8lIkYAR54AxdtUDk6ZBpLOB7APJU/fbMRlRXD7be3f
	 WepNCD4bEzPFgp/O5dTKPMcYhSFT32cSaScdjC8f3REdG6W7Px1NgnuCvqH4Pc9OzY
	 aXPKAFDRp5bqdCJfPQn3X7rhzUWqWYAd2jmHM4rUqThlv4kH4GEusLlap0Z0y+T/1O
	 f4XIsg5MFN8v1RejSnUiHsFbhr+GdhkLOQx8q6W2DInTmvzV5p1yv0ThvbudFPJGB0
	 /HkLpK243UKQQ==
Date: Tue, 27 Feb 2024 23:20:29 -0600
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
 Abel Vesa <abelvesa@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240228-imx95-blk-ctl-v1-1-9b5ae3c14d83@nxp.com>
References: <20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com>
 <20240228-imx95-blk-ctl-v1-1-9b5ae3c14d83@nxp.com>
Message-Id: <170909762820.1565936.4437868637843535603.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module


On Wed, 28 Feb 2024 12:31:04 +0800, Peng Fan (OSS) wrote:
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
Documentation/devicetree/bindings/clock/imx95-blk-ctl.example.dtb: /example-0/syscon@4c410000: failed to match any schema with compatible: ['fsl,imx95-vpumix-blk-ctrl', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240228-imx95-blk-ctl-v1-1-9b5ae3c14d83@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


