Return-Path: <linux-kernel+bounces-111668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2B886F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DC51F2440E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567FA4DA04;
	Fri, 22 Mar 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikj271nX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A164CB47;
	Fri, 22 Mar 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119582; cv=none; b=dP8ALNUM6xllJpDGwHBMM1AP7Xvv5hD10mfGyEnNMfqPg1KoL/60tWFL4ptKoa4OLTx2ZmqGHWzj5hYjYw35+8YbMgMuMuW2XN6spm4Eqs59gyl1sx8bVnDpWSH9ZTvOeU9STmGhXpfDCqk4sEfRXP2Vnq1S76EJPHMPaoomdsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119582; c=relaxed/simple;
	bh=UqzGdXK0o4iy7ce72+Jguni+WtdtHJAkBg4t/Gsjw+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwOSDUVjl01LQe1a3jqTzdye14YVeDIHunLEv87ihV+Cv7ZYeiZ5O2izy6Z2VSDoBRMqRyutWEszqLI4XSB1X0HAtopZdFBkz3LLYctBqnsTPcJvp76lA79oHRQOrNamkZosXdldOQB9dLVc1m62AHAJa7EEjW4r5mB3V4205LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikj271nX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CC6C433C7;
	Fri, 22 Mar 2024 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119582;
	bh=UqzGdXK0o4iy7ce72+Jguni+WtdtHJAkBg4t/Gsjw+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikj271nXVaTbVZB+YZgseBnuocZ2xADr7wxwa2mAc2SfIE1vYP8ng2j0nskSCaXxo
	 ZV/mvoCooFdwl5yrSr924bA+Q4YfTQEAzX+JOywKdQf8PPx9dkRctcFXKviYhnrSbi
	 M1qB2zRUya6nHXx12UWryZbdqpYmWtEC+nUtmYLKZI/kNKu1LV0We4l2OVmgd4LvMC
	 PWHkDHeqmNhWv5v4jzQrWtAKuE7lxwS4l9sEEbL89mLG1Sq6+FdLs1ud4Mr/+kwxoY
	 inMC/PrRPDsYYDUZvJMSNDADKeGgGL8HbR6c0ONqDu5tONxJ6qfeOjcPSZ01kJtjI3
	 oPHHMOcUgoDMQ==
Date: Fri, 22 Mar 2024 09:59:39 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-sound@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: fsl-audmix: Convert
 fsl,audmix.txt to yaml
Message-ID: <171111957775.891508.5189958179022068449.robh@kernel.org>
References: <20240321150401.2464783-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321150401.2464783-1-Frank.Li@nxp.com>


On Thu, 21 Mar 2024 11:04:00 -0400, Frank Li wrote:
> Convert fsl,audmix.txt to yaml to let dtb check tools check audmix part.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v2
>     - Add | at descript
>     - Add phandle-array according to rob's feedback
> 
>     $ref: /schemas/types.yaml#/definitions/phandle-array
>     minItems: 2
>     items:
>      - description: the AUDMIX output
>        maxItems: 1
>      - description: serial audio input 1
>        maxItems: 1
>      - description: serial audio input 2
>        maxItems: 1
> 
>     dt_binding_check and DTB_CHECK passed.
> 
>     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,audmix.yaml
>       LINT    Documentation/devicetree/bindings
>       DTEX    Documentation/devicetree/bindings/sound/fsl,audmix.example.dts
>       CHKDT   Documentation/devicetree/bindings/processed-schema.json
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       DTC_CHK Documentation/devicetree/bindings/sound/fsl,audmix.example.dtb
> 
>  .../devicetree/bindings/sound/fsl,audmix.txt  | 50 -----------
>  .../devicetree/bindings/sound/fsl,audmix.yaml | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


