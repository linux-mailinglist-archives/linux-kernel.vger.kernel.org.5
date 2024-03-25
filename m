Return-Path: <linux-kernel+bounces-117414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CBF88AB14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B671C367BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7114EC44;
	Mon, 25 Mar 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTHLCfZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85D13B290;
	Mon, 25 Mar 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381938; cv=none; b=isUKJ6kj3+6FNbCSzVxVmYiscgl3FEMxtJUNCGysRKIyzDO06gN8KG5wEY/8EZJ7ZKTrqAfKB8uCUWKKUKhuYNTUKfrRMATPQ9atV1JG3bpNEhQU6x6aqxsJt1KL9wHqZP4R+JIg35nPiK/OubY5Lb6clMCKQyN5DU9SHn+8sFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381938; c=relaxed/simple;
	bh=sOLBnPszEseCrqEhABXNORHufRD3rz4P4P6IKCH46XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUB+RQqAMuCUVq4Fa11PiVs/FsTDYmk2EXIodx8uHA0ZZb6AvZ+/x7SsV0FoYw+ZxEwHs8PZdepDxVbXGVPLZpk2JsKgb/myKJP6Ph8EP9GhOmY7SwK+N5H5aTozu/0q33a+ywjs7gDZdL0nNWitLAGrmDroma1eHyWyNhNmSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTHLCfZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A032FC32796;
	Mon, 25 Mar 2024 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711381937;
	bh=sOLBnPszEseCrqEhABXNORHufRD3rz4P4P6IKCH46XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTHLCfZgVrIJw6zmFtALYr1Hi0YzXyAkj8DhdVOKD+eokDB9g9SOxbejyPJKh188z
	 TC0ylXaFB8a/lNLwlIfVuskCYvPEF3FxtL4YJJ2EgY51q1acJnEAr6Bt7GmzvtPCP1
	 fvVkvHITXpBMtf9aMJXkqTzqWuJGlf35bccDAsdqNSTPNJOQntvmh3g0oVvIX75NQ4
	 5geV1tizFBnic+iRRhpTpi8QtR3goe7T3jnla9afcNe56buNgq647nvhLcA797rghe
	 iwcH8PnzgpykApYyFVChp6KKQghsGTBsj+yOYe+eLR9eQBoiWF9+O624vWwo2GIqJy
	 2jdbtSLrrtYgA==
Date: Mon, 25 Mar 2024 10:52:15 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, devicetree@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>, imx@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt
 to yaml
Message-ID: <171138193441.3998562.4443623988882776576.robh@kernel.org>
References: <20240322145406.2613256-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322145406.2613256-1-Frank.Li@nxp.com>


On Fri, 22 Mar 2024 10:54:05 -0400, Frank Li wrote:
> Convert fsl,esai.txt to yaml. So DTB_CHECK tools can verify dts file about
> esai part.
> 
> clock-names 'spba' is optional according to description. So minItems of
> clocks and clock-names is 3.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v2
>     - alphabetical order compatible string according to rob's suggestion
>     - clock description move under 'clock' according to kryszof's suggestion
>     - fix descritpion indent according to rob's suggestion
> 
>     Pass dt_binding check
>      make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
>       DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
>       LINT    Documentation/devicetree/bindings
>       CHKDT   Documentation/devicetree/bindings/processed-schema.json
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
> 
>  .../devicetree/bindings/sound/fsl,esai.txt    |  68 ----------
>  .../devicetree/bindings/sound/fsl,esai.yaml   | 116 ++++++++++++++++++
>  2 files changed, 116 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


